package saxon.board.efinix


import naxriscv.compatibility.{MemReadAsyncForceWriteFirst, MemReadAsyncTagging, MemReadAsyncToPhasedReadSyncPhase, MemReadAsyncToPhasedReadSyncPhaseTag, MemReportReadAsyncWithoutRegAddress, MultiPortWritesSymplifier, MultiPortWritesSymplifierTag}
import naxriscv.misc.RegFilePlugin
import saxon._
import spinal.core._
import spinal.core.fiber._
import spinal.lib.{master, system, _}
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
import spinal.lib.memory.sdram.sdr._
import spinal.lib.memory.sdram.sdr.sim.SdramModel
import spinal.lib.memory.sdram.xdr.CoreParameter
import spinal.lib.memory.sdram.xdr.phy.XilinxS7Phy
import spinal.lib.misc.plic.PlicMapping
import spinal.lib.sim.SparseMemory
import spinal.lib.system.debugger.JtagBridge
import vexriscv.VexRiscvBmbGenerator
import vexriscv.demo.smp.VexRiscvSmpClusterGen
import vexriscv.plugin.{AesPlugin, CfuBus, CfuBusParameter, CfuPlugin, CfuPluginEncoding, CsrPlugin, CsrPluginConfig, MulPlugin}

import scala.collection.mutable.ArrayBuffer




class EfxVexRiscvCluster(p : EfxRiscvBmbDdrSocParameter,
                         peripheralCd : Handle[ClockDomain],
                         debugCd : ClockDomainResetGenerator,
                         debugResetCd : ClockDomainResetGenerator) extends VexRiscvClusterGenerator(p.cpuCount, withSupervisor = p.linuxReady, peripheralCd = peripheralCd){
  val fabric = p.withL1D generate withDefaultFabric(withOutOfOrderDecoder = false, withInvalidation = p.withCoherency)
  bmbPeripheral.mapping.load(p.apbBridgeMapping)

  val fpu = p.withFpu generate new FpuIntegration(){
    setParameters(extraStage = p.cpuCount > 1)
  }

  val generalDataWidth = if(p.cpuCount > 1 || p.withFpu) 64 else 32

  val bridge = BmbBridgeGenerator()

  val ramA = BmbOnChipRamGenerator()
  ramA.address.load(p.onChipRamMapping.base)
  ramA.size.load(p.onChipRamSize)
  ramA.hexInit.load(p.onChipRamHexFile)

  p.withL1D match {
    case true => {
      interconnect.addConnection(
        fabric.iBus.bmb -> List(bridge.bmb),
        fabric.dBus.bmb -> List(bridge.bmb),
        bridge.bmb -> List(ramA.ctrl, peripheralDecoder.bus)
      )
    }
    case false => {
      interconnect.setDefaultArbitration(BmbInterconnectGenerator.STATIC_PRIORITY)
      interconnect.setPriority(cores(0).iBus, 1)
      interconnect.setPriority(cores(0).dBus, 2)
      interconnect.addConnection(
        cores(0).iBus -> List(bridge.bmb),
        cores(0).dBus -> List(bridge.bmb),
        bridge.bmb -> List(ramA.ctrl, peripheralDecoder.bus)
      )
    }
  }

  assert(!(p.withL1D && !p.withL1I), "CPU with data cache but without instruction cache isn't supported.")
  assert(!(p.linuxReady && !p.withL1D), "CPU do not support linux without data cache")
  assert(!(p.withAtomic && !p.withL1D), "CPU do not support atomic without data cache")
  assert(!(p.withCoherency && !p.withL1D), "CPU do not support memory coherency without data cache")
  assert(!(p.cpuCount > 1 && !p.withL1D), "Multicore isn't supported without data cache")

  // Configure the CPUs
  for((cpu, coreId) <- cores.zipWithIndex) {
    cpu.config.load(VexRiscvSmpClusterGen.vexRiscvConfig( //TODO
      hartId = coreId,
      ioRange =address => p.apbBridgeMapping.hit(address) || p.axiAMapping.hit(address), //_ (31 downto 28) === 0xF,
      resetVector = p.resetVector,
      iBusWidth = generalDataWidth,
      dBusWidth = generalDataWidth,
      loadStoreWidth = if (p.withFpu) 64 else 32,
      iCacheSize = p.iCacheSize,
      dCacheSize = p.dCacheSize,
      iCacheWays = p.iCacheWays,
      dCacheWays = p.dCacheWays,
      dBusCmdMasterPipe = true,
      injectorStage = true,
      earlyShifterInjection = false,
      withFloat = p.withFpu,
      withDouble = p.withFpu,
      externalFpu = p.withFpu,
      withMmu = p.linuxReady,
      withSupervisor = p.linuxReady,
      atomic = p.withAtomic,
      coherency = p.withCoherency,
      regfileRead = vexriscv.plugin.SYNC,
      rvc = p.rvc,
      withDataCache = p.withL1D,
      withInstructionCache = p.withL1I,
      forceMisa = true,
      forceMscratch = true
    ))

    val mul = cpu.config.get.get(classOf[MulPlugin])
    mul.outputBuffer = true

    if(p.customInstruction) cpu.config.plugins +=  new CfuPlugin(
      stageCount = 2,
      allowZeroLatency = true,
      withEnable = false,
      encodings = List(
        CfuPluginEncoding (
          instruction = M"-------------------------0001011",
          functionId = List(14 downto 12, 31 downto 25),
          input2Kind = CfuPlugin.Input2Kind.RS
        )
      ),
      busParameter = CfuBusParameter(
        CFU_FUNCTION_ID_W = 10,
        CFU_INPUTS = 2,
        CFU_INPUT_DATA_W = 32,
        CFU_OUTPUTS = 1,
        CFU_OUTPUT_DATA_W = 32,
        CFU_FLOW_REQ_READY_ALWAYS = false,
        CFU_FLOW_RESP_READY_ALWAYS = false
      )
    )
  }



  val customInstruction = p.customInstruction generate new Area {
    val io = ArrayBuffer[CfuBus]()
    val loaded = Handle {
      for ((core, coreId) <- cores.zipWithIndex if core.logic.cpu.serviceExist(classOf[CfuPlugin])) {
        val cfu = core.logic.cpu.service(classOf[CfuPlugin]).bus
        val bus = (master(cloneOf(cfu)))
        bus <> cfu
        bus.setName(s"cpu${coreId}_customInstruction")
        bus.cmd.payload.setCompositeName(bus)
        bus.rsp.payload.setCompositeName(bus)
        io += bus
      }
    }
  }


  // Add some interconnect pipelining to improve FMax
  if(cores.size != 1) {
    interconnect.masters(bridge.bmb).withPerSourceDecoder()
  }
  if(p.withCoherency) {
    interconnect.setPipelining(fabric.invalidationMonitor.input)(invReady = true, ackValid = true)
    interconnect.setPipelining(fabric.invalidationMonitor.output)(cmdValid = true, cmdReady = true, rspValid = true)
  }
  interconnect.setPipelining(bmbPeripheral.bmb)(cmdHalfRate = !p.withL1D, rspHalfRate = true)
  p.withL1D match {
    case true => {
      for(cpu <- cores) interconnect.setPipelining(cpu.dBus)(cmdValid = true, invValid = p.withCoherency, ackValid = p.withCoherency, syncValid = p.withCoherency)
      for(cpu <- cores) interconnect.setPipelining(cpu.iBus)(rspValid = true)
      interconnect.setPipelining(bridge.bmb)(cmdValid = true, cmdReady = true)
      interconnect.setPipelining(fabric.iBus.bmb)(cmdValid = true)
      interconnect.setPipelining(fabric.exclusiveMonitor.input)(cmdValid = true, cmdReady = true, rspValid = true)
      interconnect.setPipelining(ramA.ctrl)(rspValid = true)
    }
    case false => {
      interconnect.setPipelining(cores(0).dBus)(cmdValid = true, cmdReady = true)
      interconnect.setPipelining(cores(0).iBus)(cmdValid = true, cmdReady = true)
    }
  }

  interconnect.getConnection(bridge.bmb, bmbPeripheral.bmb).ccByToggle

  val hardJtag = !p.withSoftJtag generate new Area {
    val debug = withDebugBus(debugCd.outputClockDomain, debugResetCd, 0x10B80000).withJtagInstruction(p.additionalJtagTapMax)
    val jtagCtrl = Handle(debug.logic.jtagBridge.io.ctrl.toIo).setName("jtagCtrl")
    val jtagCtrl_tck = Handle(in(Bool()) setName("jtagCtrl_tck"))
    debug.jtagClockDomain.loadAsync(ClockDomain(jtagCtrl_tck))
  }

  val softJtag = p.withSoftJtag generate new Area {
    val debug = withDebugBus(debugCd.outputClockDomain, debugResetCd, 0x10B80000).withJtagInstruction(p.additionalJtagTapMax)
    val jtag = new Generator {
      val io = produce(slave(Jtag())).setName("jtag")
      val clockDomain = produce(ClockDomain(io.tck))
      produce(debug.jtagClockDomain.load(clockDomain.get))
    }

    val jtagTap = new Generator {
      dependencies += debug.jtagInstruction
      val logic = add task new Area {
        val tap = jtag.clockDomain on new Area {
          val tap = new JtagTap(jtag.io, 4)
          val idcodeArea = tap.idcode(B(p.tapId, 32 bits))(5)
          val wrapper = tap.map(debug.jtagInstruction, instructionId = 8)
        }
      }
    }
  }
}

class EfxRiscvBmbDdrSoc(val p : EfxRiscvBmbDdrSocParameter) extends Component{
  val debugCd = ClockDomainResetGenerator()
  debugCd.holdDuration.load(4095)
  debugCd.enablePowerOnReset()
  debugCd.makeExternal(frequency = FixedFrequency(p.systemFrequency))

  val ddrCd = p.withDdrA generate ClockDomainResetGenerator()
  if(p.withDdrA) {
    ddrCd.holdDuration.load(63)
    ddrCd.asyncReset(debugCd)
    ddrCd.makeExternal(
      withResetPin = false
    )
  }

  val peripheralCd = p.withPeripheralClock generate ClockDomainResetGenerator()
  if(p.withPeripheralClock) {
    peripheralCd.holdDuration.load(63)
    peripheralCd.asyncReset(if (p.withDdrA) ddrCd else debugCd)
    peripheralCd.makeExternal(frequency = FixedFrequency(p.peripheralFrequancy), withResetPin = false)
  }

  val systemCd = ClockDomainResetGenerator()
  systemCd.holdDuration.load(63)
  systemCd.asyncReset(if(p.withPeripheralClock) peripheralCd else (if(p.withDdrA) ddrCd else debugCd))
  systemCd.setInput(
    debugCd.outputClockDomain,
    omitReset = true
  )

  val debugResetCd = if(p.withDdrA) ddrCd else if(p.withPeripheralClock) peripheralCd else systemCd

  val system = systemCd.outputClockDomain on new Area{
    sexport("cpuHz", p.systemFrequency.toLong)
    sexport("peripheralHz", if(p.withPeripheralClock) p.peripheralFrequancy.toLong else p.systemFrequency.toLong)

    val peripheralCdHandle =  (if(p.withPeripheralClock) peripheralCd else systemCd).outputClockDomain
    val vexCluster = p.withVexRiscv generate new EfxVexRiscvCluster(
      p,
      peripheralCdHandle,
      debugCd,
      debugResetCd
    )
    val naxCluster = p.withNaxRiscv generate new EfxNaxRiscvCluster(
      p,
      peripheralCdHandle,
      debugCd,
      debugResetCd
    )

    val peripherals = if(p.withVexRiscv) new EfxRiscvPeripheralArea(
      p,
      peripheralCdHandle,
      vexCluster.bridge,
      vexCluster.plic,
      vexCluster.clint
    )(vexCluster.interconnect,
      vexCluster.peripheralDecoder
    ) else if(p.withNaxRiscv) new EfxRiscvPeripheralArea(
      p,
      peripheralCdHandle,
      naxCluster.bridge,
      naxCluster.plic,
      naxCluster.clint
    )(naxCluster.interconnect,
      naxCluster.peripheralDecoder
    ) else ???

    if(p.withVexRiscv) vexCluster.setCompositeName(this)
    if(p.withNaxRiscv) naxCluster.setCompositeName(this)
    peripherals.setCompositeName(this)
  }

  if(p.withDdrA) {
    system.peripherals.ddr.memoryClockDomain.load(ddrCd.outputClockDomain)
    system.peripherals.ddr.systemClockDomain.load(systemCd.outputClockDomain)
  }

  val io_systemReset = systemCd.outputClockDomain.produce(out(systemCd.outputClockDomain.on(RegNext(systemCd.outputClockDomain.reset))))
  val io_memoryReset = p.withDdrA generate ddrCd.outputClockDomain.produce(out(ddrCd.outputClockDomain.on(RegNext(ddrCd.outputClockDomain.reset))))
  val io_peripheralReset = p.withPeripheralClock generate peripheralCd.outputClockDomain.produce(out(peripheralCd.outputClockDomain.on(RegNext(peripheralCd.outputClockDomain.reset))))
}


// Default :
// --systemFrequancy 66666666--dCacheSize 4096 --iCacheSize 4096 --ddrADataWidth 128 --ddrASize 0xf7fff000 --onChipRamSize 0x1000 --axiAAddress 0xfa000000 --axiASize 0x1000 --apbSlave name=io_apbSlave_0,address=0x800000,size=4096 --apbSlave name=io_dma_ctrl,address=0x804000,size=16384 --ddrMaster name=io_ddrMasters_0,dataWidth=32 --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12;1->13 --uart name=system_uart_0_io,address=0x10000,interruptId=1 --uart name=system_uart_1_io,address=0x11000,interruptId=2 --spi name=system_spi_0_io,address=0x14000,interruptId=4 --spi name=system_spi_1_io,address=0x15000,interruptId=5 --spi name=system_spi_2_io,address=0x16000,interruptId=6 --i2c name=system_i2c_0_io,address=0x18000,interruptId=8 --i2c name=system_i2c_1_io,address=0x19000,interruptId=9 --i2c name=system_i2c_2_io,address=0x1A000,interruptId=10 --interrupt name=userInterruptA,id=25 --ramHex software/standalone/bootloader/build/bootloader.hex --cpuCount=2 --customInstruction
object EfxRiscvBmbDdrSoc {
  //Generate the SoC
  def main(args: Array[String]): Unit = {

    LutInputs.set(4)
    val spinalConfig = SpinalRtlConfig.copy(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
      inlineRom = false
    )
    if(args.contains("--withNaxRiscv")){
      spinalConfig.addTransformationPhase(new MultiPortWritesSymplifier(onlyTagged = true))
      spinalConfig.addTransformationPhase(new MemReadAsyncToPhasedReadSyncPhase)
//      spinalConfig.addTransformationPhase(new MemReadAsyncTagging(new AttributeString("syn_ramstyle", "registers")))
      spinalConfig.addTransformationPhase(new MemReadAsyncForceWriteFirst)
      spinalConfig.addTransformationPhase(new MemReportReadAsyncWithoutRegAddress)
    }

    val report = spinalConfig.generateVerilog{
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      val toplevel = new EfxRiscvBmbDdrSoc(p){
        setDefinitionName(p.toplevelName)
        val naxPatcher = p.withNaxRiscv generate hardFork{new Area{
          val cdRf = ClockDomain.external("nax_rf", withReset = false).setSyncWith(system.naxCluster.cores.head.logic.cpu.clockDomain)
          cdRf.clock.setName("io_naxRfClk")
          system.naxCluster.cores.foreach(core => EfxNaxRiscvPatcher(core.plugins.get, core.logic.cpu.clockDomain, cdRf))
        }}
      }

      //Match previous version names
      Handle {
        toplevel.debugCd.inputClockDomain.clock.setName("io_systemClk")
        toplevel.debugCd.inputClockDomain.reset.setName("io_asyncReset")
        if (p.withDdrA) {
          toplevel.ddrCd.inputClockDomain.clock.setName("io_memoryClk")
          toplevel.system.peripherals.ddr.ddrLogic.io.setName("io")
          toplevel.io_memoryReset.get.setName("io_memoryReset")
        }

        if(p.withPeripheralClock) {
          toplevel.peripheralCd.inputClockDomain.clock.setName("io_peripheralClk")
        }
        toplevel.io_systemReset.get.setName("io_systemReset")
        if (p.withAxiA) {
          toplevel.system.peripherals.axiA.interrupt.get.setName("io_axiAInterrupt")
        }
      }

      toplevel
    }
//    val cpu = report.toplevel.system.cores(0).logic.get.cpu
//    val cache = cpu.children.find(_.getName().contains("IBus")).get
//    val source = cache.reflectBaseType("_zz_14")
//    val destination = cpu.reflectBaseType("CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr")
//    val destination = cpu.reflectBaseType("IBusCachedPlugin_decodeExceptionPort_valid")
//    val destination = cache.reflectBaseType("fetchStage_read_waysValues_0_tag_address")
//    val destination = cpu.reflectBaseType("IBusCachedPlugin_iBusRsp_stages_0_input_payload")
//    val destination = cpu.reflectBaseType("IBusCachedPlugin_decodeExceptionPort_valid")
//    println("len : " + LatencyAnalysis(source, destination))

    BspGenerator(report.toplevel.p.bsp, report.toplevel, report.toplevel.system.peripherals.bridge.bmb)
  }
}

object EfxNaxRiscvPatcher{
  def apply(plugins : Seq[naxriscv.utilities.Plugin], cd : ClockDomain, cdRf : ClockDomain) = new Area{
    //Patch the netlist for better inferation
    val rfRa2RsTag = new MemReadAsyncToPhasedReadSyncPhaseTag(cdRf)
    plugins.foreach {
      case p: RegFilePlugin => p.logic.regfile.banks.foreach(_.ram.addTag(rfRa2RsTag).addTag(new MultiPortWritesSymplifierTag()))
      case _ =>
    }
  }
}


object EfxRiscvAxiDdrSocSystemSim {
  import spinal.core.sim._

  def main(args: Array[String]): Unit = {

    val simConfig = SimConfig
    simConfig.allOptimisation
    simConfig.withFstWave
//    simConfig.withIVerilog

    simConfig.addIncludeDir("../aesVerilog")
    simConfig.addRtl("../aesVerilog/aes_instruction.v")
    simConfig.addSimulatorFlag("-Wno-UNSIGNED")

    val spinalConfig = SpinalConfig()
    if(args.contains("--withNaxRiscv")){
      spinalConfig.addTransformationPhase(new MultiPortWritesSymplifier(onlyTagged = true))
      spinalConfig.addTransformationPhase(new MemReadAsyncToPhasedReadSyncPhase)
//      spinalConfig.addTransformationPhase(new MemReadAsyncForceWriteFirst)
    }

    simConfig.withConfig(spinalConfig)

    simConfig.compile {
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      new EfxRiscvBmbDdrSoc(p){
        val naxPatcher = p.withNaxRiscv generate hardFork{new Area{
          val cdRf = ClockDomain.external("nax_rf", withReset = false).setSyncWith(system.naxCluster.cores.head.logic.cpu.clockDomain)
          system.naxCluster.cores.foreach(core => EfxNaxRiscvPatcher(core.plugins.get, core.logic.cpu.clockDomain, cdRf))
        }}

        val ddrSim = p.withDdrA generate system.peripherals.ddr.ddrLogic.produce (new Area {
          val axi4 = if(p.ddrAAxi4) system.peripherals.ddr.ddrLogic.io.ddrA_axi4.setAsDirectionLess() else system.peripherals.ddr.ddrLogic.io.ddrA_axi3.setAsDirectionLess.toAxi4()
          val readOnly = master(axi4.toReadOnly()).setName("ddrA_sim_readOnly")
          val writeOnly = master(axi4.toWriteOnly()).setName("ddrA_sim_writeOnly")
          for(u <-system.peripherals.ddr.ddrLogic.userAdapters){
            u.userClk.setAsDirectionLess() := ddrCd.inputClockDomain.clock.pull()
          }
        })

        val customInstructionAes = if(p.customInstruction) systemCd.outputClockDomain on Handle {
          system.vexCluster.customInstruction.loaded.get
          for (bus <- system.vexCluster.customInstruction.io) {
            bus.setAsDirectionLess
            val bb = aes_instruction()
            bb.setName("aes",weak = true)
            bb.cmd_valid <> bus.cmd.valid
            bb.cmd_ready <> bus.cmd.ready
            bb.cmd_function_id <> bus.cmd.function_id
            bb.cmd_inputs_0 <> bus.cmd.inputs(0)
            bb.cmd_inputs_1 <> bus.cmd.inputs(1)


            bb.rsp_valid <> bus.rsp.valid
            bb.rsp_ready <> bus.rsp.ready
            bb.rsp_outputs_0 <> bus.rsp.outputs(0)
            bb
          }
        }
      }
    }.doSimUntilVoid("test", 41){dut =>
      val systemClkPeriod = (1e12/dut.debugCd.inputClockDomain.frequency.getValue.toDouble).toLong
      val ddrClkPeriod = (1e12/100e6).toLong
      val jtagClkPeriod = systemClkPeriod*4
      val uartBaudRate = 115200
      val uartBaudPeriod = (1e12/uartBaudRate).toLong
      if(dut.p.withPeripheralClock) dut.peripheralCd.inputClockDomain.forkStimulus((1e12/dut.peripheralCd.inputClockDomain.frequency.getValue.toDouble).toLong toLong)
      val clockDomain = dut.debugCd.inputClockDomain.get
      val peripheralCd = if(dut.p.withPeripheralClock) dut.peripheralCd.inputClockDomain.get else clockDomain
      clockDomain.forkStimulus(systemClkPeriod)
      val ddrCd = dut.p.withDdrA generate dut.ddrCd.inputClockDomain.get
      if(dut.p.withDdrA) ddrCd.forkStimulus(ddrClkPeriod)
//      ddrCd.forkSimSpeedPrinter()

      if(dut.p.withNaxRiscv){
        fork{
          clockDomain.waitSampling()
          sleep(systemClkPeriod*3/4)
          DoClock(dut.naxPatcher.cdRf.clockSim, systemClkPeriod)
        }
      }

      val tcpJtagVex = if(dut.p.withVexRiscv) JtagTcp(
        jtag = dut.system.vexCluster.softJtag.jtag.io,
        jtagClkPeriod = jtagClkPeriod
      )

      val tcpJtagNax = if(dut.p.withNaxRiscv) JtagTcp(
        jtag = dut.system.naxCluster.softJtag.io,
        jtagClkPeriod = jtagClkPeriod
      )

      val uartTx = UartDecoder(
        uartPin =  dut.system.peripherals.uart(0).uart.txd,
        baudPeriod = uartBaudPeriod
      )

      val uartRx = UartEncoder(
        uartPin = dut.system.peripherals.uart(0).uart.rxd,
        baudPeriod = uartBaudPeriod
      )

      val flash = (dut.system.peripherals.spi.size != 0) generate FlashModel(dut.system.peripherals.spi(0).io, peripheralCd)
      dut.system.peripherals.spi.tail.foreach(_.io.get.data.foreach(_.read #= 0))

      if(dut.p.withDdrA)fork {
        ddrCd.waitSampling(100)
        val ddrMemory = SparseMemory()
        val woa = new Axi4WriteOnlySlaveAgent(dut.ddrSim.writeOnly, ddrCd)
        new Axi4WriteOnlyMonitor(dut.ddrSim.writeOnly, ddrCd) {
          override def onWriteByte(address: BigInt, data: Byte): Unit = ddrMemory.write(address.toLong, data)
        }
        val roa = new Axi4ReadOnlySlaveAgent(dut.ddrSim.readOnly, ddrCd) {
          override def readByte(address: BigInt): Byte = ddrMemory.read(address.toLong)
        }

//        woa.bDriver.transactionDelay = () => 0
//        woa.awDriver.factor = 1.0f
//        woa.wDriver.factor = 1.0f
//
//        roa.arDriver.factor = 1.0f
//        roa.rDriver.transactionDelay = () => 0

        for (u <- dut.system.peripherals.ddr.ddrLogic.userAdapters) {
          u.userAxi.ar.valid #= false
          u.userAxi.aw.valid #= false
        }

//        dut.system.axiA.logic.axiA.b.valid #= false
//        dut.system.axiA.logic.axiA.r.valid #= false


        if(dut.p.withAxiA){
          val axiAMemory = SparseMemory()
          new Axi4WriteOnlySlaveAgent(dut.system.peripherals.axiA.logic.axiA, clockDomain)
          new Axi4WriteOnlyMonitor(dut.system.peripherals.axiA.logic.axiA, clockDomain) {
            override def onWriteByte(address: BigInt, data: Byte): Unit = axiAMemory.write(address.toLong, data)
          }
          new Axi4ReadOnlySlaveAgent(dut.system.peripherals.axiA.logic.axiA, clockDomain) {
            override def readByte(address: BigInt): Byte = axiAMemory.read(address.toLong)
          }
        }

        for(s <- dut.system.peripherals.apbSlaves){
          s.bus.PREADY #= true
          s.bus.PSLVERROR #= false
        }

        val images = "../buildroot-build/images/"
//        val images = "/home/rawrr/Downloads/sapphire_dual_core/"
        ddrMemory.loadBin(0x00001000, images + "fw_jump.bin")
        ddrMemory.loadBin(0x00100000, images + "u-boot.bin")
        ddrMemory.loadBin(0x00400000, images + "uImage")
        ddrMemory.loadBin(0x00FF0000, images + "linux.dtb")
        ddrMemory.loadBin(0x00FFFFC0, images + "rootfs.cpio.uboot")
//
//        //Bypass uboot
        ddrMemory.loadBin(0x00400000, images + "Image")
        List(0x00000897, 0x01088893, 0x0008a883 , 0x000880e7, 0x00400000).zipWithIndex.foreach{case (v,i) => ddrMemory.write(0x00100000+i*4, v)}



//        ddrMemory.loadBin(0x01000000, images + "fw_jump.bin")
//        ddrMemory.loadBin(0x01f00000, images + "linux.dtb") //0x00cf0000
//        ddrMemory.loadBin(0x00400000, images + "Image")

//        List(0x00000897, 0x01088893, 0x0008a883 , 0x000880e7, 0x01000000).zipWithIndex.foreach{case (v,i) => ddrMemory.write(0x00001000+i*4, v)}
//        List(0x00000897, 0x01088893, 0x0008a883 , 0x000880e7, 0x00400000).zipWithIndex.foreach{case (v,i) => ddrMemory.write(0x01040000+i*4, v)}


//        ddrMemory.loadBin(0x00001000, "software/standalone/staticLink/build/staticLink.bin")

//        ddrMemory.loadBin(0x00001000, "software/standalone/timerAndGpioInterruptDemo/build/timerAndGpioInterruptDemo_spinal_sim.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/dhrystone/build/dhrystone.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/spiDemo/build/spiDemo.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/freertosDemo/build/freertosDemo_spinal_sim.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/smpDemo/build/smpDemo.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/timerExtraDemoWithPriority/build/timerExtraDemoWithPriority_spinal_sim.bin")
//          ddrMemory.loadBin(0x00001000, "software/standalone/fpu/build/fpu.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/asm/build/asm.bin")
      }

//      if(flash != null) flash.loadBinary("software/standalone/blinkAndEcho/build/blinkAndEcho_spinal_sim.bin", 0xF00000)

      fork{
        val at = 0
        val duration = 0
        while(simTime() < at*1000000000l) {
          disableSimWave()
          sleep(100000 * 10000)
          enableSimWave()
          sleep(  100 * 10000)
        }
        println("\n\n********************")
        sleep(duration*1000000000l)
        println("********************\n\n")
        while(true) {
          disableSimWave()
          sleep(100000 * 10000)
          enableSimWave()
          sleep(  100 * 10000)
        }
      }


      fork{
        while(true){
          dut.system.peripherals.gpio(0).gpio.read #= 0
          sleep(0.001e12.toLong)
          dut.system.peripherals.gpio(0).gpio.read #= 1
          sleep(0.001e12.toLong)
        }
      }
    }
  }
}

case class aes_instruction() extends BlackBox{
  val clk = in Bool()
  val reset = in Bool()

  val cmd_valid = in Bool()
  val cmd_ready =  out Bool()
  val cmd_function_id = in UInt(10 bits)
  val cmd_inputs_0 = in Bits(32 bits)
  val cmd_inputs_1 = in Bits(32 bits)

  val rsp_valid = out Bool()
  val rsp_ready = in Bool()
  val rsp_response_ok = out Bool()
  val rsp_outputs_0 = out Bits(32 bits)

  mapCurrentClockDomain(clk, reset)
}


//object EfxRiscvAxiDdrSocSystemSimJtagChain {
//  import spinal.core.sim._
//
//  def main(args: Array[String]): Unit = {
//
//    val simConfig = SimConfig
//    simConfig.allOptimisation
//    simConfig.withFstWave
//    //    simConfig.withIVerilog
//
//    simConfig.addIncludeDir("../aesVerilog")
//    simConfig.addRtl("../aesVerilog/aes_instruction.v")
//    simConfig.addSimulatorFlag("-Wno-UNSIGNED")
//    simConfig.compile {
//      new Component {
//        def newSoc(tapId : BigInt) ={
//          new EfxRiscvBmbDdrSoc(EfxRiscvBmbDdrSocParameter.defaultArgs(args).copy(tapId = tapId)) {
//            val ddrSim = p.withDdrA generate system.peripherals.ddr.ddrLogic.produce(new Area {
//              val axi4 = system.peripherals.ddr.ddrLogic.io.ddrA.setAsDirectionLess.toAxi4()
//              val readOnly = master(axi4.toReadOnly()).setName("ddrA_sim_readOnly")
//              val writeOnly = master(axi4.toWriteOnly()).setName("ddrA_sim_writeOnly")
//              for (u <- system.peripherals.ddr.ddrLogic.userAdapters) {
//                u.userClk.setAsDirectionLess() := ddrCd.inputClockDomain.clock.pull()
//              }
//            })
//
//            val customInstructionAes = if (p.customInstruction) systemCd.outputClockDomain on Handle {
//              system.cluster.customInstruction.loaded.get
//              for (bus <- system.cluster.customInstruction.io) {
//                bus.setAsDirectionLess
//                val bb = aes_instruction()
//                bb.setName("aes", weak = true)
//                bb.cmd_valid <> bus.cmd.valid
//                bb.cmd_ready <> bus.cmd.ready
//                bb.cmd_function_id <> bus.cmd.function_id
//                bb.cmd_inputs_0 <> bus.cmd.inputs(0)
//                bb.cmd_inputs_1 <> bus.cmd.inputs(1)
//
//
//                bb.rsp_valid <> bus.rsp.valid
//                bb.rsp_ready <> bus.rsp.ready
//                bb.rsp_outputs_0 <> bus.rsp.outputs(0)
//                bb
//              }
//            }
//          }
//        }
//        val soc0 = newSoc(tapId = 0x00110a79)
//        val soc1 = newSoc(tapId = 0x00220a79)
//        val soc2 = newSoc(tapId = 0x00330a79)
//
//        val cd = ClockDomain.external("main")
//        val patches = Handle(new Area{
//          def patch(soc : EfxRiscvBmbDdrSoc): Unit ={
//            soc.system.peripherals.spi.foreach(_.io.toIo())
//            soc.system.peripherals.gpio.foreach(_.gpio.toIo())
//            soc.system.peripherals.uart.foreach(_.uart.toIo())
//            soc.system.peripherals.userInterrupts.foreach(_.pin.toIo())
//            soc.debugCd.inputClockDomain.clock := cd.readClockWire
//            soc.debugCd.inputClockDomain.reset := cd.readResetWire
//          }
//
//          patch(soc0)
//          patch(soc1)
//          patch(soc2)
//
//          val resets = out(List(soc0, soc1, soc2).map(_.io_systemReset.get).asBits())
//
//          val tap3 = new Area{
//            val jtag = Jtag()
//            val cd = ClockDomain(jtag.tck)
//            val ctx = cd.push()
//            val tap = new JtagTap(jtag, 4)
//            val idcodeArea = tap.idcode(B(0x00440a79, 32 bits))(5)
//            ctx.restore()
//          }
//
//          val jtag = slave(Jtag())
//          soc0.softJtag.jtag.io.tck := jtag.tck
//          soc0.softJtag.jtag.io.tms := jtag.tms
//          soc1.softJtag.jtag.io.tck := jtag.tck
//          soc1.softJtag.jtag.io.tms := jtag.tms
//          soc2.softJtag.jtag.io.tck := jtag.tck
//          soc2.softJtag.jtag.io.tms := jtag.tms
//          tap3.jtag.tck := jtag.tck
//          tap3.jtag.tms := jtag.tms
//
//          soc0.softJtag.jtag.io.tdi := jtag.tdi
//          soc1.softJtag.jtag.io.tdi := False //soc0.softJtag.jtag.io.tdo
//          soc2.softJtag.jtag.io.tdi := False //soc1.softJtag.jtag.io.tdo
//          tap3.jtag.tdi := soc0.softJtag.jtag.io.tdo
//          jtag.tdo := tap3.jtag.tdo
//        })
//      }
//    }.doSimUntilVoid("test", 41) { dut =>
//      dut.cd.forkStimulus(10)
//      val tcpJtag = JtagTcp(
//        jtag = dut.patches.jtag,
//        jtagClkPeriod = 200
//      )
//
//      var last = 0
//      dut.cd.onSamplings{
//        var value = dut.patches.resets.toInt
//        if(last != value){
//          println(s"${simTime()} ${value}")
//          last = value
//        }
//      }
//      disableSimWave()
//    }
//
//  }
//}


/*

fpga_spinal.cpu0 mww 0xF9000000 0xAAAAAAAA
fpga_spinal1.cpu0 mww 0xF9000000 0xBBBBBBBB
fpga_spinal2.cpu0 mww 0xF9000000 0xCCCCCCCC
fpga_spinal.cpu0 mdw 0xF9000000 16
fpga_spinal1.cpu0 mdw 0xF9000000 16
fpga_spinal2.cpu0 mdw 0xF9000000 16
 */