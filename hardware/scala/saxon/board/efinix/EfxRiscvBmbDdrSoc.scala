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




class EfxRiscvBmbSocSystem() extends Generator{
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

class EfxRiscvAxiDdrSocSystemWithArgs(p : EfxRiscvBmbDdrSocParameter) extends EfxRiscvBmbSocSystem{
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

class EfxRiscvBmbDdrSoc(p : EfxRiscvBmbDdrSocParameter) extends Generator{
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

  val system = new EfxRiscvAxiDdrSocSystemWithArgs(p)
  system.onClockDomain(systemCd.outputClockDomain)
  system.ddr.memoryClockDomain.merge(ddrCd.outputClockDomain)
  system.ddr.systemClockDomain.merge(systemCd.outputClockDomain)



  val io_systemReset = systemCd.outputClockDomain.produce(out(CombInit(systemCd.outputClockDomain.reset)))
  val io_memoryReset = ddrCd.outputClockDomain.produce(ddrCd.outputClockDomain.get.withAsyncReset()(out(RegNext(ddrCd.outputClockDomain.reset) init(True))))
}



object EfxRiscvBmbDdrSoc {
  //Generate the SoC
  def main(args: Array[String]): Unit = {
    val report = SpinalRtlConfig.copy(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
        inlineRom = false
      ).generateVerilog{
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      val toplevel = new EfxRiscvBmbDdrSoc(p){
        system.cpu.enableJtagInstructionCtrl(debugCd, ddrCd)
        val jtagCtrl = system.cpu.jtagInstructionCtrl.produce{
          val i = slave(JtagTapInstructionCtrl())
          i <> system.cpu.jtagInstructionCtrl
          i
        }
        val jtagCtrl_tck = produce(in Bool())
        jtagCtrl_tck.produce(system.cpu.jtagClockDomain.load(ClockDomain(jtagCtrl_tck)))

      }.toComponent("EfxRiscvBmbDdrSoc")

//     toplevel.system.cpu.config.plugins.map{
//       case p : CsrPlugin => p.printCsr()
//       case _ =>
//     }
      //Match previous version names
      toplevel.debugCd.inputClockDomain.clock.setName("io_systemClk")
      toplevel.debugCd.inputClockDomain.reset.setName("io_asyncReset")
      toplevel.ddrCd.inputClockDomain.clock.setName("io_memoryClk")
//      toplevel.system.cpu.jtag.get.setName("io_jtag")
      toplevel.system.ddr.ddrLogic.io.setName("io")

      toplevel.io_systemReset.get.setName("io_systemReset")
      toplevel.io_memoryReset.get.setName("io_memoryReset")
      toplevel.system.axiA.interrupt.get.setName("io_axiAInterrupt")

      toplevel
    }
    BspGenerator("efinix/EfxRiscvBmbDdrSoc", report.toplevel.generator, report.toplevel.generator.system.cpu.dBus)
  }
}




object EfxRiscvAxiDdrSocSystemSim {
  import spinal.core.sim._

  def main(args: Array[String]): Unit = {

    val simConfig = SimConfig
    simConfig.allOptimisation
//    simConfig.withWave

    simConfig.addSimulatorFlag("-Wno-UNSIGNED")
    simConfig.compile {
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      new EfxRiscvBmbDdrSoc(p){
        val ddrSim = system.ddr.ddrLogic.produce (new Area {
          val axi4 = system.ddr.ddrLogic.io.ddrA.setAsDirectionLess.toAxi4()
          val readOnly = master(axi4.toReadOnly()).setName("ddrA_sim_readOnly")
          val writeOnly = master(axi4.toWriteOnly()).setName("ddrA_sim_writeOnly")
          for(u <-system.ddr.ddrLogic.userAdapters){
            u.userClk.setAsDirectionLess() := ddrCd.inputClockDomain.clock.pull()
          }
        })

//        system.cpu.enableJtag(debugCd, ddrCd)
        system.cpu.enableJtagInstructionCtrl(debugCd, ddrCd)

        val jtag = new Generator{
          val io = produce(slave(Jtag()))
          val clockDomain = produce(ClockDomain(io.tck))
          produce(system.cpu.jtagClockDomain.load(clockDomain.get)) //TODO better syntax
        }
        val jtagTap = new Generator {
          dependencies += system.cpu.jtagInstructionCtrl
          val logic = add task new Area{
            val tap = jtag.clockDomain on new Area{
              val tap = new JtagTap(jtag.io, 4)
              val idcodeArea = tap.idcode(B"x00220a79")(5)
              val wrapper = tap.map(system.cpu.jtagInstructionCtrl, instructionId = 9)
            }
          }
        }
      }.toComponent()
    }.doSimUntilVoid("test", 42){dut =>
      val systemClkPeriod = (1e12/dut.debugCd.inputClockDomain.frequency.getValue.toDouble).toLong
      val ddrClkPeriod = (1e12/100e6).toLong
      val jtagClkPeriod = systemClkPeriod*4
      val uartBaudRate = 115200
      val uartBaudPeriod = (1e12/uartBaudRate).toLong

      val clockDomain = dut.debugCd.inputClockDomain.get
      clockDomain.forkStimulus(systemClkPeriod)
      val ddrCd = dut.ddrCd.inputClockDomain.get
      ddrCd.forkStimulus(ddrClkPeriod)

      val tcpJtag = JtagTcp(
        jtag = dut.jtag.io,
//        jtag = dut.system.cpu.jtag,
        jtagClkPeriod = jtagClkPeriod
      )

      val uartTx = UartDecoder(
        uartPin =  dut.system.uart(0).uart.txd,
        baudPeriod = uartBaudPeriod
      )

      val uartRx = UartEncoder(
        uartPin = dut.system.uart(0).uart.rxd,
        baudPeriod = uartBaudPeriod
      )

      val flash = FlashModel(dut.system.spi(0).io, clockDomain)

      fork {
        ddrCd.waitSampling(100)
        val ddrMemory = SparseMemory()
        new Axi4WriteOnlySlaveAgent(dut.ddrSim.writeOnly, ddrCd)
        new Axi4WriteOnlyMonitor(dut.ddrSim.writeOnly, ddrCd) {
          override def onWriteByte(address: BigInt, data: Byte): Unit = ddrMemory.write(address.toLong, data)
        }
        new Axi4ReadOnlySlaveAgent(dut.ddrSim.readOnly, ddrCd) {
          override def readByte(address: BigInt): Byte = ddrMemory.read(address.toLong)
        }

        for (u <- dut.system.ddr.ddrLogic.userAdapters) {
          u.userAxi.ar.valid #= false
          u.userAxi.aw.valid #= false
        }

//        dut.system.axiA.logic.axiA.b.valid #= false
//        dut.system.axiA.logic.axiA.r.valid #= false


        val axiAMemory = SparseMemory()
        new Axi4WriteOnlySlaveAgent(dut.system.axiA.logic.axiA, clockDomain)
        new Axi4WriteOnlyMonitor(dut.system.axiA.logic.axiA, clockDomain) {
          override def onWriteByte(address: BigInt, data: Byte): Unit = axiAMemory.write(address.toLong, data)
        }
        new Axi4ReadOnlySlaveAgent(dut.system.axiA.logic.axiA, clockDomain) {
          override def readByte(address: BigInt): Byte = axiAMemory.read(address.toLong)
        }


        val linuxPath = "../buildroot/output/images/"
        val uboot = "../u-boot/"
//        ddrMemory.loadBin(0x00001000, "software/standalone/machineModeSbi/build/machineModeSbi.bin")
//        ddrMemory.loadBin(0x00200000, uboot + "u-boot.bin")
//
//        ddrMemory.loadBin(0x00FF0000, linuxPath + "dtb")
//        ddrMemory.loadBin(0x00400000, linuxPath + "uImage")
//        ddrMemory.loadBin(0x01000000, linuxPath + "rootfs.cpio.uboot")

//        ddrMemory.loadBin(0x00400000, linuxPath + "Image")
//        ddrMemory.loadBin(0x01000000, linuxPath + "rootfs.cpio")


//        ddrMemory.loadBin(0x00001000, "software/standalone/timerAndGpioInterruptDemo/build/timerAndGpioInterruptDemo_spinal_sim.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/dhrystone/build/dhrystone.bin")
        ddrMemory.loadBin(0x00001000, "software/standalone/freertosDemo/build/freertosDemo_spinal_sim.bin")
      }

      fork{
//        disableSimWave()
//        sleep(systemClkPeriod*598332)
//        println("enableSimWave")
//        enableSimWave()

//        while(true){
//          disableSimWave()
//          sleep(systemClkPeriod*500000)
//          enableSimWave()
//          sleep(systemClkPeriod*1000)
//        }
      }

      fork{
        while(true){
          dut.system.gpio(0).gpio.read #= 0
          sleep(0.001e12.toLong)
          dut.system.gpio(0).gpio.read #= 1
          sleep(0.001e12.toLong)
        }
      }
    }
  }
}

