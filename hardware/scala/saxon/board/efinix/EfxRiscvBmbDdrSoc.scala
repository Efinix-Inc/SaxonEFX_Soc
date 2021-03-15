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
import vexriscv.plugin.{AesPlugin, CfuBus, CfuBusParameter, CfuPlugin, CfuPluginEncoding, CsrPlugin, CsrPluginConfig, MulPlugin}

import scala.collection.mutable.ArrayBuffer




class EfxRiscvBmbSocSystem(p : EfxRiscvBmbDdrSocParameter) extends VexRiscvClusterGenerator(p.cpuCount){
  val fabric = this.withDefaultFabric(withOutOfOrderDecoder = false)
  bmbPeripheral.mapping.load(p.apbBridgeMapping)

  val generalDataWidth = if(p.withDdrA || p.cpuCount > 1) 64 else 32
  val ramA = BmbOnChipRamGenerator()
  ramA.dataWidth.load(generalDataWidth)

  val bridge = BmbBridgeGenerator()
  interconnect.addConnection(
    fabric.iBus.bmb -> List(bridge.bmb),
    fabric.dBus.bmb -> List(bridge.bmb),
    bridge.bmb -> List(ramA.ctrl, peripheralDecoder.bus)
  )
}

class EfxRiscvAxiDdrSocSystemWithArgs(p : EfxRiscvBmbDdrSocParameter) extends EfxRiscvBmbSocSystem(p){
  val ddr = p.withDdrA generate TrionDdrGenerator(
    addressWidth = p.ddrA.addressWidth,
    dataWidth = p.ddrA.dataWidth,
    mapping = p.ddrAMapping
  )

  if(p.withDdrA) {
    ddr.ddrMasters.load(p.ddrMasters)
    ddr.ddrAConfig.load(p.ddrA)
    interconnect.addConnection(bridge.bmb, ddr.bmb)
  }

  ramA.address.load(p.onChipRamMapping.base)
  ramA.size.load(p.onChipRamSize)
  ramA.hexInit.load(p.onChipRamHexFile)


  plic.apbOffset.load( BigInt(0xC00000))
  clint.apbOffset.load(BigInt(0xB00000))

  // Configure the CPUs
  for((cpu, coreId) <- cores.zipWithIndex) {
    cpu.config.load(VexRiscvSmpClusterGen.vexRiscvConfig( //TODO
      hartId = coreId,
      ioRange =address => p.apbBridgeMapping.hit(address) || p.axiAMapping.hit(address), //_ (31 downto 28) === 0xF,
      resetVector = 0xF9000000L,
      iBusWidth = generalDataWidth,
      dBusWidth = generalDataWidth,
      iCacheSize = p.iCacheSize,
      dCacheSize = p.dCacheSize,
      iCacheWays = p.iCacheWays,
      dCacheWays = p.dCacheWays,
      dBusCmdMasterPipe = true,
      injectorStage = true,
      withMmu = p.linuxReady,
      withSupervisor = p.linuxReady,
      regfileRead = vexriscv.plugin.SYNC
    ))

    val mul = cpu.config.get.get(classOf[MulPlugin])
    mul.outputBuffer = true

    if(p.customInstruction) cpu.config.plugins +=  new CfuPlugin(
      stageCount = 2,
      allowZeroLatency = true,
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

  val uart = for((spec, i) <- p.uart.zipWithIndex) yield {
    val g = BmbUartGenerator(spec.address)
    g.setName(spec.name)
    g.parameter.load(spec.config)
    g.connectInterrupt(plic, spec.interruptId)
    g.uart.setName(spec.name)
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


  val apbSlaves = for((spec, i) <- p.apbSlaves.zipWithIndex) yield {
    val g = BmbToApb3Generator(mapping = spec.mapping)
    g.setName(spec.name)
    Handle(g.logic.io.output.toIo.setName(spec.name))
    g.apb3Config load Apb3Config(
        addressWidth = log2Up(spec.mapping.size),
        dataWidth = 32
    )
    g
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

  if(cores.size != 1) {
    interconnect.masters(bridge.bmb).withPerSourceDecoder()
  }
  interconnect.setPipelining(ramA.ctrl)(rspValid = true)
  // Add some interconnect pipelining to improve FMax
  interconnect.setPipelining(bridge.bmb)(cmdValid = true, cmdReady = true)
  for(cpu <- cores) interconnect.setPipelining(cpu.dBus)(cmdValid = true, invValid = true, ackValid = true, syncValid = true)
  interconnect.setPipelining(fabric.exclusiveMonitor.input)(cmdValid = true, cmdReady = true, rspValid = true)
  interconnect.setPipelining(fabric.invalidationMonitor.input)(invReady = true, ackValid =  true)
  interconnect.setPipelining(fabric.invalidationMonitor.output)(cmdValid = true, cmdReady = true, rspValid = true)
  interconnect.setPipelining(bmbPeripheral.bmb)(cmdHalfRate = true, rspHalfRate = true)
  p.withDdrA generate interconnect.setPipelining(ddr.bmb)(cmdValid = true, cmdReady = true, rspValid = true)
  p.withAxiA generate interconnect.setPipelining(axiA.bmb)(cmdValid = true, cmdReady = true, rspValid = true, rspReady = true)
  interconnect.setPipelining(fabric.iBus.bmb)(cmdValid = true)
  for(cpu <- cores) interconnect.setPipelining(cpu.iBus)(rspValid = true)

  def pipelinedCd() = Handle(ClockDomain.current.copy(reset = ClockDomain.current(KeepAttribute(RegNext(ClockDomain.current.readResetWire)))))
//  for(cpu <- cores) cpu.onClockDomain(pipelinedCd()) //TODO bring me back
//  if(p.withDdrA) ddr.onClockDomain(pipelinedCd())
//  i2c.foreach(_.onClockDomain(pipelinedCd()))
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

  val systemCd = ClockDomainResetGenerator()
  systemCd.holdDuration.load(63)
  systemCd.asyncReset(if(p.withDdrA) ddrCd else debugCd)
  systemCd.setInput(
    debugCd.outputClockDomain,
    omitReset = true
  )

  val system = systemCd.outputClockDomain on new EfxRiscvAxiDdrSocSystemWithArgs(p)

  if(p.withDdrA) {
    system.ddr.memoryClockDomain.load(ddrCd.outputClockDomain)
    system.ddr.systemClockDomain.load(systemCd.outputClockDomain)
  }

  val io_systemReset = systemCd.outputClockDomain.produce(out(systemCd.outputClockDomain.on(RegNext(systemCd.outputClockDomain.reset))))
  val io_memoryReset = p.withDdrA generate ddrCd.outputClockDomain.produce(out(ddrCd.outputClockDomain.on(RegNext(ddrCd.outputClockDomain.reset))))

  val hardJtag = !p.withSoftJtag generate new Area {
    val debug = system.withDebugBus(debugCd, if(p.withDdrA) ddrCd else systemCd, 0x10B80000).withJtagInstruction()
    val jtagCtrl = Handle(debug.logic.jtagBridge.io.ctrl.toIo).setName("jtagCtrl")
    val jtagCtrl_tck = in(Bool()) setName("jtagCtrl_tck")
    debug.jtagClockDomain.load(ClockDomain(jtagCtrl_tck))
  }

  val softJtag = p.withSoftJtag generate new Area {
    val debug = system.withDebugBus(debugCd, if(p.withDdrA) ddrCd else systemCd, 0x10B80000).withJtagInstruction()
    //        system.withoutDebug()
    //        system.cpu.enableJtag(debugCd, ddrCd)
    //        system.cpu.enableJtagInstructionCtrl(debugCd, ddrCd)
    //
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
          val idcodeArea = tap.idcode(B"x00220a79")(5)
          val wrapper = tap.map(debug.jtagInstruction, instructionId = 8)
        }
      }
    }
  }
}


// Default :
// --systemFrequancy 66666666--dCacheSize 4096 --iCacheSize 4096 --ddrADataWidth 128 --ddrASize 0xf7fff000 --onChipRamSize 0x1000 --axiAAddress 0xfa000000 --axiASize 0x1000 --apbSlave name=io_apbSlave_0,address=0x800000,size=4096 --apbSlave name=io_dma_ctrl,address=0x804000,size=16384 --ddrMaster name=io_ddrMasters_0,dataWidth=32 --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12;1->13 --uart name=system_uart_0_io,address=0x10000,interruptId=1 --uart name=system_uart_1_io,address=0x11000,interruptId=2 --spi name=system_spi_0_io,address=0x14000,interruptId=4 --spi name=system_spi_1_io,address=0x15000,interruptId=5 --spi name=system_spi_2_io,address=0x16000,interruptId=6 --i2c name=system_i2c_0_io,address=0x18000,interruptId=8 --i2c name=system_i2c_1_io,address=0x19000,interruptId=9 --i2c name=system_i2c_2_io,address=0x1A000,interruptId=10 --interrupt name=userInterruptA,id=25 --ramHex software/standalone/bootloader/build/bootloader.hex --cpuCount=2 --customInstruction
object EfxRiscvBmbDdrSoc {
  //Generate the SoC
  def main(args: Array[String]): Unit = {
    val report = SpinalRtlConfig.copy(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
        inlineRom = false
      ).generateVerilog{
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      val toplevel = new EfxRiscvBmbDdrSoc(p){
        setDefinitionName("EfxRiscvBmbDdrSoc")
      }

      //Match previous version names
      Handle {
        toplevel.debugCd.inputClockDomain.clock.setName("io_systemClk")
        toplevel.debugCd.inputClockDomain.reset.setName("io_asyncReset")
        if (p.withDdrA) {
          toplevel.ddrCd.inputClockDomain.clock.setName("io_memoryClk")
          toplevel.system.ddr.ddrLogic.io.setName("io")
        }

        toplevel.io_systemReset.get.setName("io_systemReset")
        if (p.withAxiA) {
          toplevel.io_memoryReset.get.setName("io_memoryReset")
          toplevel.system.axiA.interrupt.get.setName("io_axiAInterrupt")
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
    BspGenerator("efinix/EfxRiscvBmbDdrSoc", report.toplevel, report.toplevel.system.cores(0).dBus)
  }
}




object EfxRiscvAxiDdrSocSystemSim {
  import spinal.core.sim._

  def main(args: Array[String]): Unit = {

    val simConfig = SimConfig
    simConfig.allOptimisation
//    simConfig.withFstWave
//    simConfig.withIVerilog

    simConfig.addIncludeDir("../aesVerilog")
    simConfig.addRtl("../aesVerilog/aes_instruction.v")
    simConfig.addSimulatorFlag("-Wno-UNSIGNED")
    simConfig.compile {
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      new EfxRiscvBmbDdrSoc(p){
        val ddrSim = p.withDdrA generate system.ddr.ddrLogic.produce (new Area {
          val axi4 = system.ddr.ddrLogic.io.ddrA.setAsDirectionLess.toAxi4()
          val readOnly = master(axi4.toReadOnly()).setName("ddrA_sim_readOnly")
          val writeOnly = master(axi4.toWriteOnly()).setName("ddrA_sim_writeOnly")
          for(u <-system.ddr.ddrLogic.userAdapters){
            u.userClk.setAsDirectionLess() := ddrCd.inputClockDomain.clock.pull()
          }
        })

        val customInstructionAes = if(p.customInstruction) systemCd.outputClockDomain on Handle {
          system.customInstruction.loaded.get
          for (bus <- system.customInstruction.io) {
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

      val clockDomain = dut.debugCd.inputClockDomain.get
      clockDomain.forkStimulus(systemClkPeriod)
      val ddrCd = dut.p.withDdrA generate dut.ddrCd.inputClockDomain.get
      if(dut.p.withDdrA) ddrCd.forkStimulus(ddrClkPeriod)
//      ddrCd.forkSimSpeedPrinter()

      val tcpJtag = JtagTcp(
        jtag = dut.softJtag.jtag.io,
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

      val flash = if(dut.system.spi.size != 0) FlashModel(dut.system.spi(0).io, clockDomain)

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

        for (u <- dut.system.ddr.ddrLogic.userAdapters) {
          u.userAxi.ar.valid #= false
          u.userAxi.aw.valid #= false
        }

//        dut.system.axiA.logic.axiA.b.valid #= false
//        dut.system.axiA.logic.axiA.r.valid #= false


        if(dut.p.withAxiA){
          val axiAMemory = SparseMemory()
          new Axi4WriteOnlySlaveAgent(dut.system.axiA.logic.axiA, clockDomain)
          new Axi4WriteOnlyMonitor(dut.system.axiA.logic.axiA, clockDomain) {
            override def onWriteByte(address: BigInt, data: Byte): Unit = axiAMemory.write(address.toLong, data)
          }
          new Axi4ReadOnlySlaveAgent(dut.system.axiA.logic.axiA, clockDomain) {
            override def readByte(address: BigInt): Byte = axiAMemory.read(address.toLong)
          }
        }


        val images = "../buildroot-build/images/"
        ddrMemory.loadBin(0x00001000, images + "fw_jump.bin")
        ddrMemory.loadBin(0x00100000, images + "u-boot.bin")
//        ddrMemory.loadBin(0x00400000, images + "uImage")
//        ddrMemory.loadBin(0x00FF0000, images + "linux.dtb")
//        ddrMemory.loadBin(0x00FFFFC0, images + "rootfs.cpio.uboot")
//
//        //Bypass uboot
//        ddrMemory.loadBin(0x00400000, images + "Image")
//        List(0x00000897, 0x01088893, 0x0008a883 , 0x000880e7, 0x00400000).zipWithIndex.foreach{case (v,i) => ddrMemory.write(0x00100000+i*4, v)}

//        ddrMemory.loadBin(0x00001000, "software/standalone/test/aes/build/aes.bin")

//        ddrMemory.loadBin(0x00001000, "software/standalone/timerAndGpioInterruptDemo/build/timerAndGpioInterruptDemo_spinal_sim.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/dhrystone/build/dhrystone.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/freertosDemo/build/freertosDemo_spinal_sim.bin")
      }

      fork{
        val at = 0
        val duration = 5
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
          dut.system.gpio(0).gpio.read #= 0
          sleep(0.001e12.toLong)
          dut.system.gpio(0).gpio.read #= 1
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
