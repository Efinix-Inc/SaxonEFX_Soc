package saxon.board.efinix

import saxon.board.blackice.peripheral.Apb3I2cGenerator
import saxon.{ResetSensitivity, _}
import spinal.core._
import spinal.lib._
import spinal.core.sim._
import spinal.lib.bus.amba3.apb.Apb3Config
import spinal.lib.bus.amba3.apb.sim.{Apb3Listener, Apb3Monitor}
import spinal.lib.bus.amba4.axi.sim.{Axi4ReadOnlySlaveAgent, Axi4WriteOnlyMonitor, Axi4WriteOnlySlaveAgent}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config, Axi4SpecRenamer}
import spinal.lib.bus.bmb.{BmbParameter, BmbToAxi4SharedBridge}
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.com.jtag.{Jtag, JtagTap, JtagTapInstructionCtrl}
import spinal.lib.com.jtag.sim.JtagTcp
import spinal.lib.com.spi.SpiHalfDuplexMaster
import spinal.lib.com.spi.ddr.{SpiXdrMasterCtrl, SpiXdrParameter}
import spinal.lib.com.uart.UartCtrlMemoryMappedConfig
import spinal.lib.com.uart.sim.{UartDecoder, UartEncoder}
import spinal.lib.eda.bench.{Bench, Rtl, XilinxStdTargets}
import spinal.lib.generator._
import spinal.lib.io.{Gpio, InOutWrapper}
import spinal.lib.master
import spinal.lib.memory.sdram.sdr._
import spinal.lib.memory.sdram.sdr.sim.SdramModel
import spinal.lib.memory.sdram.xdr.CoreParameter
import spinal.lib.memory.sdram.xdr.phy.XilinxS7Phy
import spinal.lib.misc.plic.PlicMapping
import spinal.lib.sim.SparseMemory
import spinal.lib.system.debugger.JtagBridge
import vexriscv.plugin.{CsrPlugin, CsrPluginConfig}




class EfxRubySocSystem() extends Generator{
  implicit val interconnect = BmbInterconnectGenerator()
  implicit val apbDecoder = Apb3DecoderGenerator()

  val peripheralBridge = BmbToApb3Decoder()
  val cpu = VexRiscvBmbGenerator()

  interconnect.setDefaultArbitration(BmbInterconnectGenerator.STATIC_PRIORITY)
  interconnect.setPriority(cpu.iBus, 1)
  interconnect.setPriority(cpu.dBus, 2)

  val plic = Apb3PlicGenerator()
  plic.priorityWidth.load(2)
  plic.mapping.load(PlicMapping.sifive)
  plic.addTarget(cpu.externalInterrupt)

  val machineTimer = Apb3MachineTimerGenerator()
  cpu.setTimerInterrupt(machineTimer.interrupt)
  plic.addInterrupt(machineTimer.interrupt, 31)

  val ramA = BmbOnChipRamGenerator()
  ramA.dataWidth.load(32)

  val bridge = BmbBridgeGenerator()
  interconnect.addConnection(
    cpu.iBus -> List(bridge.bmb),
    cpu.dBus -> List(bridge.bmb),
    bridge.bmb -> List(ramA.bmb, peripheralBridge.input)
  )

  interconnect.setConnector(peripheralBridge.input){(m,s) =>
    s.cmd << m.cmd.halfPipe()
    s.rsp >> m.rsp
  }
  interconnect.setConnector(bridge.bmb){(m,s) =>
    s.cmd << m.cmd.stage()
    s.rsp >> m.rsp
  }
}

class EfxRubySocSystemWithArgs(p : EfxRiscvBmbDdrSocParameter) extends EfxRubySocSystem{
  val ddr = TrionDdrGenerator(
    addressWidth = p.ddrA.addressWidth,
    dataWidth = p.ddrA.dataWidth,
    mapping = p.ddrAMapping
  )

  ddr.ddrMasters.load(p.ddrMasters)
  ddr.ddrAConfig.load(p.ddrA)

  interconnect.addConnection(bridge.bmb, ddr.bmb)

  ramA.address.load(p.onChipRamMapping.base)
  ramA.size.load(p.onChipRamSize)
  ramA.hexInit.load(p.onChipRamHexFile)

  peripheralBridge.address.load(p.apbBridgeMapping.base)

  plic.apbOffset.loadi(0xC00000)
  machineTimer.apbOffset.loadi(0x08000)

  cpu.config.load(p.cpu)
  if(p.cpu.plugins.exists{
    case csr : CsrPlugin if csr.config.supervisorGen => true
    case _ => false
  }){
    plic.addTarget(cpu.externalSupervisorInterrupt)
  }

  val uart = for((spec, i) <- p.uart.zipWithIndex) yield {
    val g = Apb3UartGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    g.uart.setName(spec.name)
    g
  }

  val spi = for((spec, i) <- p.spi.zipWithIndex) yield {
    val g = new Apb3SpiGenerator(spec.address){
      val io = phyAsIo().setName(spec.name)
    }
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    g
  }

  val i2c = for((spec, i) <- p.i2c.zipWithIndex) yield {
    val g = Apb3I2cGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    g.i2c.setName(spec.name)
    g
  }

  val gpio = for((spec, i) <- p.gpio.zipWithIndex) yield {
    val g = Apb3GpioGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    for((pin, interruptId) <- spec.interruptMapping)  {
      g.connectInterrupt(plic, pin, interruptId)
    }
    g.gpio.setName(spec.name)
    g
  }


  val apbSlaves = for((spec, i) <- p.apbSlaves.zipWithIndex) yield {
    val g = Apb3MasterGenerator()
    g.setName(spec.name)
    Dependable(g.apb)(g.apb.get.setName(spec.name))
    g.apbOffset.load(spec.mapping.base)
    g.parameter.load(
      Apb3Config(
        addressWidth = log2Up(spec.mapping.size),
        dataWidth = 32
      )
    )
    g
  }


  val userInterrupts = for(spec <- p.interrupt) yield UserInterrupt(spec, plic)

  val axiA = new Generator{
    val requirements = createDependency[BmbParameter]
    val bmb = produce(logic.bmbToAxiBridge.io.input)
    val interrupt = produce(logic.interrupt)

    plic.addInterrupt(interrupt, 30)

    interconnect.addSlave(
      capabilities = BmbParameter(
        addressWidth  = p.axiA.addressWidth,
        dataWidth     = 32,
        lengthWidth   = 256*4,
        sourceWidth   = Int.MaxValue,
        contextWidth  = Int.MaxValue,
        canRead       = true,
        canWrite      = true,
        alignment = BmbParameter.BurstAlignement.BYTE,
        maximumPendingTransactionPerId = Int.MaxValue
      ),
      requirements = requirements,
      bus = bmb,
      mapping = p.axiAMapping
    )

    interconnect.addConnection(bridge.bmb, bmb)

    val logic = add task new Area{
      val bmbToAxiBridge = BmbToAxi4SharedBridge(
        bmbConfig = requirements,
        pendingMax = 7
      )

      val axiA = master(Axi4(p.axiA))
      axiA << bmbToAxiBridge.io.output.toAxi4()
      Axi4SpecRenamer(axiA.setName("axiA"))

      val interrupt = in Bool()
    }
  }
}

class EfxRubySoc(p : EfxRiscvBmbDdrSocParameter) extends Generator{
  val debugCd = ClockDomainResetGenerator()
  debugCd.holdDuration.load(4095)
  debugCd.enablePowerOnReset()
  debugCd.makeExternal(frequency = FixedFrequency(p.systemFrequency))

  val ddrCd = ClockDomainResetGenerator()
  ddrCd.holdDuration.load(63)
  ddrCd.asyncReset(debugCd)
  ddrCd.makeExternal(
    withResetPin = false
  )

  val systemCd = ClockDomainResetGenerator()
  systemCd.holdDuration.load(63)
  systemCd.asyncReset(ddrCd)
  systemCd.setInput(
    debugCd.outputClockDomain,
    omitReset = true
  )

  val system = new EfxRubySocSystemWithArgs(p)
  system.onClockDomain(systemCd.outputClockDomain)
  system.ddr.memoryClockDomain.merge(ddrCd.outputClockDomain)
  system.ddr.systemClockDomain.merge(systemCd.outputClockDomain)



  val io_systemReset = systemCd.outputClockDomain.produce(out(CombInit(systemCd.outputClockDomain.reset)))
  val io_memoryReset = ddrCd.outputClockDomain.produce(ddrCd.outputClockDomain.get.withAsyncReset()(out(RegNext(ddrCd.outputClockDomain.reset) init(True))))
}



object EfxRubySoc {
  //Generate the SoC
  def main(args: Array[String]): Unit = {
    val report = SpinalRtlConfig.copy(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
        inlineRom = false
      ).generateVerilog{
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
        //system.cpu.enableJtagInstructionCtrl(debugCd, ddrCd)
        if (p.softTap == true) {
          val toplevel = new EfxRubySoc(p) {
            system.cpu.enableJtag(debugCd, ddrCd)

          }.toComponent("RubySoc_softTap")
          toplevel.debugCd.inputClockDomain.clock.setName("io_systemClk")
          toplevel.debugCd.inputClockDomain.reset.setName("io_asyncReset")
          toplevel.system.cpu.jtag.get.setName("io_jtag")
          toplevel.io_systemReset.get.setName("io_systemReset")
          toplevel.ddrCd.inputClockDomain.clock.setName("io_memoryClk")
          toplevel.io_memoryReset.get.setName("io_memoryReset")
          toplevel.system.ddr.ddrLogic.io.setName("io")
          toplevel.system.axiA.interrupt.get.setName("io_axiAInterrupt")
          toplevel
        } else {
          val toplevel = new EfxRubySoc(p) {
            system.cpu.enableJtagInstructionCtrl(debugCd, ddrCd)
            val jtagCtrl = system.cpu.jtagInstructionCtrl.produce {
              val i = slave(JtagTapInstructionCtrl())
              i <> system.cpu.jtagInstructionCtrl
              i
            }
            val jtagCtrl_tck = produce(in Bool())
            jtagCtrl_tck.produce(system.cpu.jtagClockDomain.load(ClockDomain(jtagCtrl_tck)))

          }.toComponent("RubySoc")
          toplevel.debugCd.inputClockDomain.clock.setName("io_systemClk")
          toplevel.debugCd.inputClockDomain.reset.setName("io_asyncReset")
          toplevel.io_systemReset.get.setName("io_systemReset")
          toplevel.ddrCd.inputClockDomain.clock.setName("io_memoryClk")
          toplevel.io_memoryReset.get.setName("io_memoryReset")
          toplevel.system.ddr.ddrLogic.io.setName("io")
          toplevel.system.axiA.interrupt.get.setName("io_axiAInterrupt")
          toplevel
        }
      }
    BspGenerator("efinix/EfxRubySoc", report.toplevel.generator, report.toplevel.generator.system.cpu.dBus)
  }
}



