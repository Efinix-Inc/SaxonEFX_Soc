package saxon.board.efinix


import saxon._
import spinal.core._
import spinal.lib._
import spinal.core.sim._
import spinal.lib.bus.amba3.apb.Apb3Config
import spinal.lib.bus.amba3.apb.sim.{Apb3Listener, Apb3Monitor}
import spinal.lib.bus.amba4.axi.sim.{Axi4ReadOnlySlaveAgent, Axi4WriteOnlyMonitor, Axi4WriteOnlySlaveAgent}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config, Axi4SpecRenamer}
import spinal.lib.bus.bmb._
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
import vexriscv.VexRiscvBmbGenerator
import vexriscv.demo.smp.VexRiscvSmpClusterGen
import vexriscv.plugin.{AesPlugin, CfuBus, CfuBusParameter, CfuPlugin, CfuPluginEncoding, CsrPlugin, CsrPluginConfig}

import scala.collection.mutable.ArrayBuffer




class EfxRiscvBmbSocSystem(p : EfxRiscvBmbDdrSocParameter) extends VexRiscvClusterGenerator(p.cpuCount){
  val fabric = this.withDefaultFabric(withOutOfOrderDecoder = false)
  bmbPeripheral.mapping.load(p.apbBridgeMapping)

  val ramA = BmbOnChipRamGenerator()
  ramA.dataWidth.load(32)

  val bridge = BmbBridgeGenerator()
  interconnect.addConnection(
    fabric.iBus.bmb -> List(bridge.bmb),
    fabric.dBus.bmb -> List(bridge.bmb),
    bridge.bmb -> List(ramA.ctrl, peripheralDecoder.bus)
  )
}

class EfxRiscvAxiDdrSocSystemWithArgs(p : EfxRiscvBmbDdrSocParameter) extends EfxRiscvBmbSocSystem(p){
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


  plic.apbOffset.loadi(0xC00000)
  clint.apbOffset.loadi(0xB00000)

  // Configure the CPUs
  for((cpu, coreId) <- cores.zipWithIndex) {
    cpu.config.load(VexRiscvSmpClusterGen.vexRiscvConfig( //TODO
      hartId = coreId,
      ioRange = _ (31 downto 28) === 0xF,
      resetVector = 0xF9000000L,
      iBusWidth = 64,
      dBusWidth = 64,
      dBusCmdMasterPipe = true
    ))
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
//    cpu.config.plugins += new AesPlugin()
//    cpu.config.plugins +=  new CfuPlugin(
//      stageCount = 1,
//      allowZeroLatency = true,
//      encodings = List(
//        CfuPluginEncoding (
//          instruction = M"-------------------------0001011",
//          functionId = List(31 downto 25, 14 downto 12),
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
    g.produceIo(g.logic.io.output).derivate(_.setName(spec.name))
    g.apb3Config load Apb3Config(
        addressWidth = log2Up(spec.mapping.size),
        dataWidth = 32
    )
    g
  }

  val customInstruction = p.customInstruction generate new Generator {
    dependencies ++= cores

    val io = ArrayBuffer[CfuBus]()
    add task {
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

  val axiA = new Generator{

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
      axiA << bmbToAxiBridge.io.output.toAxi4()
      Axi4SpecRenamer(axiA.setName("axiA"))

      val interrupt = in Bool()
    }
  }
  // Add some interconnect pipelining to improve FMax
  for(cpu <- cores) interconnect.setPipelining(cpu.dBus)(cmdValid = true, invValid = true, ackValid = true, syncValid = true)
  interconnect.setPipelining(fabric.exclusiveMonitor.input)(cmdValid = true, cmdReady = true, rspValid = true)
  interconnect.setPipelining(fabric.invalidationMonitor.output)(cmdValid = true, cmdReady = true, rspValid = true)
  interconnect.setPipelining(bmbPeripheral.bmb)(cmdHalfRate = true, rspHalfRate = true)
  interconnect.setPipelining(ddr.bmb)(cmdValid = true, cmdReady = true, rspValid = true)
  interconnect.setPipelining(fabric.iBus.bmb)(cmdValid = true)
  for(cpu <- cores) interconnect.setPipelining(cpu.iBus)(rspValid = true)
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
  val io_memoryReset = ddrCd.outputClockDomain.produce(out(CombInit(ddrCd.outputClockDomain.reset)))
}



object EfxRiscvBmbDdrSoc {
  //Generate the SoC
  def main(args: Array[String]): Unit = {
    val report = SpinalRtlConfig.copy(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
        inlineRom = false
      ).generateVerilog{
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      val toplevel = GeneratorComponent(new EfxRiscvBmbDdrSoc(p){
        val debug = system.withDebugBus(debugCd, ddrCd, 0x10B80000).withJtagInstruction()
        val jtagCtrl = debug.produceIo(debug.logic.jtagBridge.io.ctrl)
        val jtagCtrl_tck = in Bool()
        debug.jtagClockDomain.load(ClockDomain(jtagCtrl_tck))
      }).setDefinitionName("EfxRiscvBmbDdrSoc")

//     toplevel.system.cpu.config.plugins.map{
//       case p : CsrPlugin => p.printCsr()
//       case _ =>
//     }

      //Match previous version names
      toplevel.debugCd.inputClockDomain.clock.setName("io_systemClk")
      toplevel.debugCd.inputClockDomain.reset.setName("io_asyncReset")
      toplevel.ddrCd.inputClockDomain.clock.setName("io_memoryClk")
      toplevel.system.ddr.ddrLogic.io.setName("io")

      toplevel.io_systemReset.get.setName("io_systemReset")
      toplevel.io_memoryReset.get.setName("io_memoryReset")
      toplevel.system.axiA.interrupt.get.setName("io_axiAInterrupt")

      toplevel
    }
    BspGenerator("efinix/EfxRiscvBmbDdrSoc", report.toplevel.generator, report.toplevel.generator.system.cores(0).dBus)
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
    simConfig.compile {
      val p = EfxRiscvBmbDdrSocParameter.defaultArgs(args)
      GeneratorComponent(new EfxRiscvBmbDdrSoc(p){
        val ddrSim = system.ddr.ddrLogic.produce (new Area {
          val axi4 = system.ddr.ddrLogic.io.ddrA.setAsDirectionLess.toAxi4()
          val readOnly = master(axi4.toReadOnly()).setName("ddrA_sim_readOnly")
          val writeOnly = master(axi4.toWriteOnly()).setName("ddrA_sim_writeOnly")
          for(u <-system.ddr.ddrLogic.userAdapters){
            u.userClk.setAsDirectionLess() := ddrCd.inputClockDomain.clock.pull()
          }
        })

        val debug = system.withDebugBus(debugCd, ddrCd, 0x10B80000).withJtagInstruction()
//        system.withoutDebug()
//        system.cpu.enableJtag(debugCd, ddrCd)
//        system.cpu.enableJtagInstructionCtrl(debugCd, ddrCd)
//
        val jtag = new Generator{
          val io = produce(slave(Jtag()))
          val clockDomain = produce(ClockDomain(io.tck))
          produce(debug.jtagClockDomain.load(clockDomain.get))
        }

        val jtagTap = new Generator {
          dependencies += debug.jtagInstruction
          val logic = add task new Area{
            val tap = jtag.clockDomain on new Area{
              val tap = new JtagTap(jtag.io, 4)
              val idcodeArea = tap.idcode(B"x00220a79")(5)
              val wrapper = tap.map(debug.jtagInstruction, instructionId = 8)
            }
          }
        }


        val customInstructionAes = if(p.customInstruction) new Generator {
          dependencies += system.customInstruction
          onClockDomain(systemCd.outputClockDomain)

          add task {
            for (bus <- system.customInstruction.io) {
              bus.setAsDirectionLess
              val bb = aes_instruction()
              bb.cmd_valid <> bus.cmd.valid
              bb.cmd_ready <> bus.cmd.ready
              bb.cmd_function_id <> bus.cmd.function_id
              bb.cmd_inputs_0 <> bus.cmd.inputs(0)
              bb.cmd_inputs_1 <> bus.cmd.inputs(1)


              bb.rsp_valid <> bus.rsp.valid
              bb.rsp_ready <> bus.rsp.ready
              bb.rsp_response_ok <> bus.rsp.response_ok
              bb.rsp_outputs_0 <> bus.rsp.outputs(0)
              bb
            }
          }
        }
      })
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
//      ddrCd.forkSimSpeedPrinter()

      val tcpJtag = JtagTcp(
        jtag = dut.jtag.io,
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


        val images = "../buildroot-build/images/"

//        ddrMemory.loadBin(0x00001000, images + "fw_jump.bin")
//        ddrMemory.loadBin(0x00100000, images + "u-boot.bin")
//        ddrMemory.loadBin(0x00400000, images + "uImage")
//        ddrMemory.loadBin(0x00FF0000, images + "linux.dtb")
//        ddrMemory.loadBin(0x00FFFFC0, images + "rootfs.cpio.uboot")

        ddrMemory.loadBin(0x00001000, "software/standalone/test/aes/build/aes.bin")

//        ddrMemory.loadBin(0x00001000, "software/standalone/timerAndGpioInterruptDemo/build/timerAndGpioInterruptDemo_spinal_sim.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/dhrystone/build/dhrystone.bin")
//        ddrMemory.loadBin(0x00001000, "software/standalone/freertosDemo/build/freertosDemo_spinal_sim.bin")
      }

      fork{
        val at = 3
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
