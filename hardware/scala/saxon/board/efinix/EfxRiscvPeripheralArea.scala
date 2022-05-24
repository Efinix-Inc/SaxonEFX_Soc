package saxon.board.efinix


import saxon._
import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.core.sim._
import spinal.lib.bus.amba3.apb.Apb3Config
import spinal.lib.bus.amba3.apb.sim.{Apb3Listener, Apb3Monitor}
import spinal.lib.bus.amba4.axi.sim.{Axi4ReadOnlySlaveAgent, Axi4WriteOnlyMonitor, Axi4WriteOnlySlaveAgent}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config, Axi4SpecRenamer}
import spinal.lib.bus.bmb._
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.com.eth.{MacEthParameter, PhyParameter}
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
import vexriscv.VexRiscvBmbGenerator
import vexriscv.demo.smp.VexRiscvSmpClusterGen
import vexriscv.plugin._

import scala.collection.mutable.ArrayBuffer


class EfxRiscvPeripheralArea (val p : EfxRiscvBmbDdrSocParameter,
                              val peripheralClock : Handle[ClockDomain],
                              val bridge : BmbBridgeGenerator,
                              val plic : BmbPlicGenerator,
                              val clint : BmbClintGenerator)
                             (implicit interconnect : BmbInterconnectGenerator,
                                       decoder : BmbImplicitPeripheralDecoder) extends Area {

  plic.apbOffset.load( BigInt(0xC00000))
  clint.apbOffset.load(BigInt(0xB00000))

  val ddr = p.withDdrA generate TrionDdrGenerator(
    addressWidth = p.ddrA.addressWidth,
    dataWidth = p.ddrA.dataWidth,
    mapping = p.ddrAMapping,
    withAxi4 = p.ddrAAxi4
  )

  if(p.withDdrA) {
    ddr.ddrMasters.load(p.ddrMasters)
    ddr.ddrAConfig.load(p.ddrA)
    interconnect.addConnection(bridge.bmb, ddr.bmb)
  }


  val peripheralCdPush = ClockDomain.push(peripheralClock)

  val uart = for((spec, i) <- p.uart.zipWithIndex) yield {
    val g = BmbUartGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    g.uart.setName(spec.name)
    interconnect.setPipelining(g.ctrl)(cmdHalfRate = true, rspHalfRate = true)
    g
  }

  val spi = for((spec, i) <- p.spi.zipWithIndex) yield {
    val g = new BmbSpiGenerator(spec.address){
      val io = phyAsIo().setName(spec.name)
    }
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    interconnect.setPipelining(g.ctrl)(cmdHalfRate = true)
    g
  }

  val i2c = for((spec, i) <- p.i2c.zipWithIndex) yield {
    val g = BmbI2cGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    g.i2c.setName(spec.name)
    interconnect.setPipelining(g.ctrl)(cmdHalfRate = true)
    g
  }

  val rmii = for((spec, i) <- p.rmii.zipWithIndex) yield {
    val mac = BmbMacEthGenerator(spec.address)
    mac.connectInterrupt(plic, spec.interruptId)
    val eth = mac.withPhyRmii(
      withEr = false
    )
    eth.setName(spec.name)

    mac.parameter load MacEthParameter(
      phy = PhyParameter(
        txDataWidth = 2,
        rxDataWidth = 2
      ),
      rxDataWidth = 32,
      rxBufferByteSize = 4096,
      txDataWidth = 32,
      txBufferByteSize = 4096
    )

    val rmii_clk = in.Bool().setName(spec.name + "_clk")
    mac.txCd.load(ClockDomain(rmii_clk))
    mac.rxCd.load(ClockDomain(rmii_clk))
  }

  val timers = for((spec, i) <- p.timer.zipWithIndex) yield {
    val g = new EfxTimerGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupts(plic, spec.interruptBase)
    interconnect.setPipelining(g.ctrl)(cmdHalfRate = true)
    g
  }

  val gpio = for((spec, i) <- p.gpio.zipWithIndex) yield {
    val g = BmbGpioGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    for((pin, interruptId) <- spec.interruptMapping)  {
      g.connectInterrupt(plic, pin, interruptId)
    }
    g.gpio.setName(spec.name)
    g
  }


  val apbSlaves = for((spec, i) <- p.apbSlaves.zipWithIndex) yield new Area{
    val g = BmbToApb3Generator(mapping = spec.mapping)
    g.setName(spec.name)
    val bus = Handle(g.logic.io.output.toIo.setName(spec.name))
    g.apb3Config load Apb3Config(
      addressWidth = log2Up(spec.mapping.size),
      dataWidth = 32
    )
    g
  }

  val userInterrupts = for(spec <- p.interrupt) yield UserInterrupt(spec, plic)


  val axiA = p.withAxiA generate new Generator{

    val bmb = produce(logic.bmbToAxiBridge.io.input)
    val interrupt = produce(logic.interrupt)

    plic.addInterrupt(interrupt, 30)

    val accessSource = Handle[BmbAccessCapabilities]
    val accessRequirements = createDependency[BmbAccessParameter]
    interconnect.addSlave(
      accessSource = accessSource,
      accessCapabilities = BmbAccessCapabilities(
        addressWidth  = p.axiA.addressWidth,
        dataWidth     = 32,
        lengthWidthMax   = log2Up(256*4),
        alignment = BmbParameter.BurstAlignement.BYTE
      ),
      accessRequirements = accessRequirements,
      bus = bmb,
      mapping = p.axiAMapping
    )
    
    interconnect.addConnection(bridge.bmb, bmb)

    val logic = add task new Area{
      val bmbToAxiBridge = BmbToAxi4SharedBridge(
        bmbConfig = accessRequirements.toBmbParameter(),
        pendingMax = 7
      )

      val axiA = master(Axi4(p.axiA))
      val axiAAdapted = Axi4(p.axiA)
      axiAAdapted << bmbToAxiBridge.io.output.toAxi4()
      axiA.ar << axiAAdapted.ar
      axiA.aw << axiAAdapted.aw
      axiA.w << axiAAdapted.w
      axiA.r >-> axiAAdapted.r
      axiA.b >> axiAAdapted.b

      Axi4SpecRenamer(axiA.setName("axiA"))

      val interrupt = in Bool()
    }
  }

  peripheralCdPush.restore()


  def pipelinedCd() = Handle(ClockDomain.current.copy(reset = ClockDomain.current(KeepAttribute(RegNext(ClockDomain.current.readResetWire)))))


  p.withDdrA generate interconnect.setPipelining(ddr.bmb)(cmdValid = true, cmdReady = true, rspValid = true)
  p.withAxiA generate interconnect.setPipelining(axiA.bmb)(cmdValid = true, cmdReady = true, rspValid = true, rspReady = true)
}









//  assert(!(p.withL1D && !p.withL1I), "CPU with data cache but without instruction cache isn't supported.")
//  assert(!(p.linuxReady && !p.withL1D), "CPU do not support linux without data cache")
//  assert(!(p.withAtomic && !p.withL1D), "CPU do not support atomic without data cache")
//  assert(!(p.withCoherency && !p.withL1D), "CPU do not support memory coherency without data cache")
//  assert(!(p.cpuCount > 1 && !p.withL1D), "Multicore isn't supported without data cache")
//
//  // Configure the CPUs
//  for((cpu, coreId) <- cores.zipWithIndex) {
//    cpu.config.load(VexRiscvSmpClusterGen.vexRiscvConfig( //TODO
//      hartId = coreId,
//      ioRange =address => p.apbBridgeMapping.hit(address) || p.axiAMapping.hit(address), //_ (31 downto 28) === 0xF,
//      resetVector = p.resetVector,
//      iBusWidth = generalDataWidth,
//      dBusWidth = generalDataWidth,
//      loadStoreWidth = if (p.withFpu) 64 else 32,
//      iCacheSize = p.iCacheSize,
//      dCacheSize = p.dCacheSize,
//      iCacheWays = p.iCacheWays,
//      dCacheWays = p.dCacheWays,
//      dBusCmdMasterPipe = true,
//      injectorStage = true,
//      earlyShifterInjection = false,
//      withFloat = p.withFpu,
//      withDouble = p.withFpu,
//      externalFpu = p.withFpu,
//      withMmu = p.linuxReady,
//      withSupervisor = p.linuxReady,
//      atomic = p.withAtomic,
//      coherency = p.withCoherency,
//      regfileRead = vexriscv.plugin.SYNC,
//      rvc = p.rvc,
//      withDataCache = p.withL1D,
//      withInstructionCache = p.withL1I
//    ))
//
//    val mul = cpu.config.get.get(classOf[MulPlugin])
//    mul.outputBuffer = true
//
//    if(p.customInstruction) cpu.config.plugins +=  new CfuPlugin(
//      stageCount = 2,
//      allowZeroLatency = true,
//      encodings = List(
//        CfuPluginEncoding (
//          instruction = M"-------------------------0001011",
//          functionId = List(14 downto 12, 31 downto 25),
//          input2Kind = CfuPlugin.Input2Kind.RS
//        )
//      ),
//      busParameter = CfuBusParameter(
//        CFU_FUNCTION_ID_W = 10,
//        CFU_INPUTS = 2,
//        CFU_INPUT_DATA_W = 32,
//        CFU_OUTPUTS = 1,
//        CFU_OUTPUT_DATA_W = 32,
//        CFU_FLOW_REQ_READY_ALWAYS = false,
//        CFU_FLOW_RESP_READY_ALWAYS = false
//      )
//    )
//  }
//
//
//
//  val customInstruction = p.customInstruction generate new Area {
//    val io = ArrayBuffer[CfuBus]()
//    val loaded = Handle {
//      for ((core, coreId) <- cores.zipWithIndex if core.logic.cpu.serviceExist(classOf[CfuPlugin])) {
//        val cfu = core.logic.cpu.service(classOf[CfuPlugin]).bus
//        val bus = (master(cloneOf(cfu)))
//        bus <> cfu
//        bus.setName(s"cpu${coreId}_customInstruction")
//        bus.cmd.payload.setCompositeName(bus)
//        bus.rsp.payload.setCompositeName(bus)
//        io += bus
//      }
//    }
//  }
//
//
//  // Add some interconnect pipelining to improve FMax
//  if(cores.size != 1) {
//    interconnect.masters(bridge.bmb).withPerSourceDecoder()
//  }
//  if(p.withCoherency) {
//    interconnect.setPipelining(fabric.invalidationMonitor.input)(invReady = true, ackValid = true)
//    interconnect.setPipelining(fabric.invalidationMonitor.output)(cmdValid = true, cmdReady = true, rspValid = true)
//  }
//  interconnect.setPipelining(bmbPeripheral.bmb)(cmdHalfRate = !p.withL1D, rspHalfRate = true)
//  p.withDdrA generate interconnect.setPipelining(ddr.bmb)(cmdValid = true, cmdReady = true, rspValid = true)
//  p.withAxiA generate interconnect.setPipelining(axiA.bmb)(cmdValid = true, cmdReady = true, rspValid = true, rspReady = true)
//  p.withL1D match {
//    case true => {
//      for(cpu <- cores) interconnect.setPipelining(cpu.dBus)(cmdValid = true, invValid = p.withCoherency, ackValid = p.withCoherency, syncValid = p.withCoherency)
//      for(cpu <- cores) interconnect.setPipelining(cpu.iBus)(rspValid = true)
//      interconnect.setPipelining(bridge.bmb)(cmdValid = true, cmdReady = true)
//      interconnect.setPipelining(fabric.iBus.bmb)(cmdValid = true)
//      interconnect.setPipelining(fabric.exclusiveMonitor.input)(cmdValid = true, cmdReady = true, rspValid = true)
//      interconnect.setPipelining(ramA.ctrl)(rspValid = true)
//    }
//    case false => {
//      interconnect.setPipelining(cores(0).dBus)(cmdValid = true, cmdReady = true)
//      interconnect.setPipelining(cores(0).iBus)(cmdValid = true, cmdReady = true)
//    }
//  }
//
//  interconnect.getConnection(bridge.bmb, bmbPeripheral.bmb).ccByToggle