package saxon.board.efinix


import spinal.core._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4CC, Axi4Config, Axi4Shared, Axi4SharedArbiter, Axi4SharedCC, Axi4Upsizer}
import spinal.lib.bus.misc.{AddressMapping, SizeMapping}
import spinal.lib.com.i2c.{I2cMasterMemoryMappedGenerics, I2cSlaveGenerics, I2cSlaveMemoryMappedGenerics}
import spinal.lib.com.spi.ddr.{SpiXdrMasterCtrl, SpiXdrParameter}
import spinal.lib.com.uart.{UartCtrlGenerics, UartCtrlInitConfig, UartCtrlMemoryMappedConfig, UartParityType, UartStopType}
import spinal.lib.generator._
import spinal.lib.io.Gpio
import spinal.lib._
import spinal.lib.bus.bmb
import spinal.lib.bus.bmb.{BmbParameter, BmbToAxi4SharedBridge}
import vexriscv.{Riscv, VexRiscvConfig, plugin}
import vexriscv.ip.{DataCacheConfig, InstructionCacheConfig}
import vexriscv.plugin.{BranchPlugin, CfuBusParameter, CfuPlugin, CfuPluginEncoding, CsrAccess, CsrPlugin, CsrPluginConfig, DBusCachedPlugin, DecoderSimplePlugin, DivPlugin, FullBarrelShifterPlugin, HazardSimplePlugin, IBusCachedPlugin, IntAluPlugin, MmuPlugin, MmuPortConfig, MulPlugin, RegFilePlugin, STATIC, SrcPlugin, StaticMemoryTranslatorPlugin, YamlPlugin}

import scala.collection.mutable.ArrayBuffer


case class ApbSlaveSpec(mapping : SizeMapping,
                        name : String)

case class GpioSpec( name : String,
                     address : BigInt,
                     interruptMapping : Seq[(Int, Int)], //Which pin to which interruptId
                     config : Gpio.Parameter)

case class UartSpec( name : String,
                     address : BigInt,
                     interruptId : Int,
                     config : UartCtrlMemoryMappedConfig)

case class I2cSpec( name : String,
                    address : BigInt,
                    interruptId : Int,
                    config : I2cSlaveMemoryMappedGenerics)

case class SpiSpec( name : String,
                    address : BigInt,
                    interruptId : Int,
                    config : SpiXdrMasterCtrl.MemoryMappingParameters)

case class DdrMasterSpec( name : String,
                          axiConfig : Axi4Config)

case class InterruptSpec( name : String,
                          id : Int)


//Definition of the SoC parameters
case class EfxRiscvBmbDdrSocParameter(systemFrequency : HertzNumber,
                                      onChipRamSize : BigInt,
                                      onChipRamHexFile : String,
                                      gpio : Seq[GpioSpec],
                                      uart : Seq[UartSpec],
                                      spi : Seq[SpiSpec],
                                      i2c : Seq[I2cSpec],
                                      interrupt : Seq[InterruptSpec] = Nil,
                                      ddrA  : Axi4Config,
                                      axiA  : Axi4Config,
                                      ddrAMapping      : SizeMapping,
                                      apbBridgeMapping : SizeMapping,
                                      axiAMapping      : SizeMapping,
                                      onChipRamMapping : SizeMapping,
                                      cpu : VexRiscvConfig,
                                      ddrMasters : Seq[DdrMasterSpec],
                                      apbSlaves : Seq[ApbSlaveSpec],
                                      simulation : Boolean,
                                      customInstruction : Boolean,
                                      cpuCount : Int)

object EfxRiscvBmbDdrSocParameter{
  def defaultArgs(args : Seq[String]): EfxRiscvBmbDdrSocParameter ={
    var iCacheSize = 4096
    var dCacheSize = 4096
    var onChipRamHexFile = "software/standalone/bootloader/build/bootloader.hex"
    var systemFrequancy = 50000000
    var ddrADataWidth = 128
    var uartBaudrate = 115200
    var ddrMasters = ArrayBuffer[DdrMasterSpec]()
    var apbSlaves = ArrayBuffer[ApbSlaveSpec]()
    var ddrAAddress : BigInt = 0x00001000L
    var ddrASize : BigInt = 4.GiB - 128.MB - 4.KiB
    var apbBridgeAddress : BigInt = 0xF8000000L
    var apbBridgeSize : BigInt = 16 MiB
    var onChipRamAddress : BigInt = 0xF9000000L
    var onChipRamSize : BigInt = 2048
    var axiAAddress : BigInt = 0xFA000000L
    var axiASize : BigInt = 16 MiB
    var linuxReady = false
    var cpuCount = 1
    var customInstruction = false
    val gpio = ArrayBuffer[GpioSpec]()
    val uart = ArrayBuffer[UartSpec]()
    val spi = ArrayBuffer[SpiSpec]()
    val i2c = ArrayBuffer[I2cSpec]()
    val interrupt = ArrayBuffer[InterruptSpec]()

    def decode(str : String) = if(str.contains("0x"))
      BigInt(str.replace("0x",""), 16)
    else
      BigInt(str, 10)

    assert(new scopt.OptionParser[Unit]("EfxRiscvAxiDdrSocGen") {
      help("help").text("prints this usage text")
      opt[String]("ramHex")  action { (v, c) => onChipRamHexFile = v } text(s"Set the main memory boot content with an hex file. Default $onChipRamHexFile")
      opt[Unit]("customInstruction")action { (v, c) => customInstruction = true } text(s"Add custom instruction interface. Default $customInstruction")
      opt[Unit]("linux")action { (v, c) => linuxReady = true } text(s"Default $linuxReady")
      opt[Int]("cpuCount")action { (v, c) => cpuCount = v } text(s"Default $cpuCount")
      opt[String]("iCacheSize")action { (v, c) => iCacheSize = decode(v).toInt } text(s"At least 32 and multiple of 32. Default $iCacheSize")
      opt[String]("dCacheSize")action { (v, c) => dCacheSize = decode(v).toInt } text(s"At least 32 and multiple of 32. Default $dCacheSize")
      opt[Int]("systemFrequancy")action { (v, c) => systemFrequancy = v } text(s"CPU + peripherals frequancy (set the UART baudrate at reset). Default $systemFrequancy")
      opt[String]("ddrADataWidth")action { (v, c) => ddrADataWidth = decode(v).toInt } text(s"Default $ddrADataWidth")
      opt[String]("uartBaudrate")action { (v, c) => uartBaudrate = decode(v).toInt } text(s"Default $uartBaudrate")
      opt[String]("ddrAAddress")action { (v, c) => ddrAAddress = decode(v) } text(s"Default 0x${ddrAAddress.toString(16)}")
      opt[String]("ddrASize")action { (v, c) => ddrASize = decode(v) } text(s"Default 0x${ddrASize.toString(16)}")
      opt[String]("apbBridgeAddress")action { (v, c) => apbBridgeAddress = decode(v) } text(s"Default 0x${apbBridgeAddress.toString(16)}")
      opt[String]("apbBridgeSize")action { (v, c) => apbBridgeSize = decode(v) } text(s"Default 0x${apbBridgeSize.toString(16)}")
      opt[String]("onChipRamAddress")action { (v, c) => onChipRamAddress = decode(v) } text(s"Default 0x${onChipRamAddress.toString(16)}")
      opt[String]("onChipRamSize")action { (v, c) => onChipRamSize = decode(v) } text(s"At least 1 KB to host the flash bootloader. Default 0x${onChipRamSize.toString(16)}")
      opt[String]("axiAAddress")action { (v, c) => axiAAddress = decode(v) } text(s"Default 0x${axiAAddress.toString(16)}")
      opt[String]("axiASize")action { (v, c) => axiASize = decode(v) } text(s"Default 0x${axiASize.toString(16)}")
      opt[Map[String, String]]("interrupt") unbounded() action { (v, c) =>
        interrupt += InterruptSpec(
          id = Integer.decode(v("id")).toInt,
          name = v("name")
        )
      }
      opt[Map[String, String]]("apbSlave") unbounded() action { (v, c) =>
        apbSlaves += ApbSlaveSpec(
          mapping = SizeMapping(Integer.decode(v("address")).toInt, Integer.decode(v("size")).toInt),
          name = v("name")
        )
      } text(s"Add a new APB3 slave with the given name and memory mapping (relative to the apbBridge) Ex : --apbSlave name=portName,address=0x800000,size=4096")

      opt[Map[String, String]]("uart") unbounded() action { (v, c) =>
        uart += UartSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptId = Integer.decode(v("interruptId")).toInt,
          config = UartCtrlMemoryMappedConfig(
            uartCtrlConfig = UartCtrlGenerics(
              dataWidthMax = 8,
              clockDividerWidth = 20,
              preSamplingSize = 1,
              samplingSize = 5,
              postSamplingSize = 2
            ),
            initConfig = UartCtrlInitConfig(
              baudrate = uartBaudrate,
              dataLength = 7, //7 => 8 bits
              parity = UartParityType.NONE,
              stop = UartStopType.ONE
            ),
            txFifoDepth = 16,
            rxFifoDepth = 16
          )
        )
      } text(s"Add a new UART with the given name, address (relative to the apbBridge) and interrupt id,  Ex : --uart name=portName,address=0x123000,interruptId=2")

      opt[Map[String, String]]("spi") unbounded() action { (v, c) =>
        spi += SpiSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptId = Integer.decode(v("interruptId")).toInt,
          config = SpiXdrMasterCtrl.MemoryMappingParameters(
            SpiXdrMasterCtrl.Parameters(
              dataWidth = 8,
              timerWidth = 12,
              spi = SpiXdrParameter(
                dataWidth = 4,
                ioRate = 1,
                ssWidth = Integer.decode(v.getOrElse("ssCount","1")).toInt
              )
            ).addFullDuplex(id = 0)
              .addHalfDuplex(id = 1, rate = 1, ddr = false, spiWidth = 2)
              .addHalfDuplex(id = 2, rate = 1, ddr = false, spiWidth = 4),
            pipelined = true,
            cmdFifoDepth = 256,
            rspFifoDepth = 256
          )
        )
      } text (s"Add a new SPI with the given name, address (relative to the apbBridge) and interrupt id,  Ex : --spi name=portName,address=0x123000,interruptId=2")


      opt[Map[String, String]]("i2c") unbounded() action { (v, c) =>
        i2c += I2cSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptId = Integer.decode(v("interruptId")).toInt,
          config = I2cSlaveMemoryMappedGenerics(
            ctrlGenerics = I2cSlaveGenerics(
              samplingWindowSize = 3,
              samplingClockDividerWidth = 10 bits,
              timeoutWidth = 20 bits
            ),
            addressFilterCount = 2,
            masterGenerics = I2cMasterMemoryMappedGenerics(
              timerWidth = 12
            )
          )
        )
      } text (s"Add a new I2C with the given name, address (relative to the apbBridge) and interrupt id,  Ex : --i2c name=portName,address=0x123000,interruptId=2")


      opt[Map[String, String]]("gpio") unbounded() action { (v, c) =>
        val interruptMapping = v("interrupts").split(";").map(s => (s.split("->")(0).toInt -> s.split("->")(1).toInt))
        gpio += GpioSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptMapping = interruptMapping.toSeq,
          config = Gpio.Parameter(
            width = Integer.decode(v("width")).toInt,
            interrupt = interruptMapping.map(_._1).toSeq
          )
        )
      } text (s"Add a new GPIO ctrl with the given name, address (relative to the apbBridge), width and interrupt mapping (pin->interruptId) Ex : --gpio name=io_gpioA,address=0x000000,width=8,interrupts=0->12;2->13")


      opt[Map[String, String]]("ddrMaster") unbounded() action { (v, c) =>
        ddrMasters += DdrMasterSpec(
          name = v("name"),
          axiConfig = Axi4Config(addressWidth = 32, dataWidth = v("dataWidth").toInt, idWidth = 4)
        )
      } text (s"Add a new DDR AXI master with the given name, and data width,  Ex : --ddrMaster name=portName,dataWidth=32")
    }.parse(args))

    val apbBridgeMapping : SizeMapping = (apbBridgeAddress,apbBridgeSize)
    val axiAMapping      : SizeMapping = (axiAAddress,axiASize)

    val config = EfxRiscvBmbDdrSocParameter.default(
      iCacheSize = iCacheSize,
      dCacheSize = dCacheSize,
      systemFrequancy = systemFrequancy,
      onChipRamSize = onChipRamSize.toInt,
      ddrADataWidth = ddrADataWidth,
      uartBaudrate = uartBaudrate,
      linuxReady = linuxReady,
      customInstruction = customInstruction,
      ioRange = address => apbBridgeMapping.hit(address) || axiAMapping.hit(address)
    ).copy(
      ddrMasters       = ddrMasters,
      ddrAMapping      = (ddrAAddress,ddrASize),
      apbBridgeMapping = apbBridgeMapping,
      onChipRamMapping = (onChipRamAddress,onChipRamSize),
      axiAMapping      = axiAMapping,
      apbSlaves = apbSlaves,
      gpio = gpio,
      uart = uart,
      spi = spi,
      i2c = i2c,
      interrupt = interrupt,
      onChipRamHexFile = onChipRamHexFile,
      cpuCount = cpuCount
    )

    config
  }

  //Default configuration of the SoC
  def default(linuxReady : Boolean,
              customInstruction : Boolean,
              iCacheSize : Int = 4096,
              dCacheSize : Int = 4096,
              systemFrequancy : Int = 50000000,
              onChipRamSize : Int = 2048,
              ddrADataWidth : Int = 128,
              uartBaudrate : Int = 115200,
              ioRange : UInt => Bool = _(31 downto 28) === 0xF) = {

    assert(iCacheSize >= 32 && iCacheSize % 32 == 0, "iCacheSize should be [1, ...] * 32")
    assert(dCacheSize >= 32 && dCacheSize % 32 == 0, "dCacheSize should be [1, ...] * 32")

    val config = EfxRiscvBmbDdrSocParameter(
      systemFrequency = systemFrequancy Hz,
      onChipRamSize  = onChipRamSize,
      onChipRamHexFile = "software/standalone/flashBootloader/build/flashBootloader.hex", //TODO
      customInstruction = customInstruction,
      cpuCount = 1,
      gpio = Nil,
      uart = Nil,
      spi = Nil,
      i2c = Nil,
      apbSlaves = Nil,
      ddrMasters = Nil,
      axiA = Axi4Config(
        addressWidth = 32,
        dataWidth    = 32,
        idWidth      =  8
      ),
      ddrA = Axi4Config(
        addressWidth =  32,
        dataWidth    = ddrADataWidth,
        idWidth      =   8
      ),
      ddrAMapping      = (0x00001000L,    4.GiB - 128.MB - 4.KiB),
      apbBridgeMapping = (0xF8000000L,   16 MiB),
      onChipRamMapping = (0xF9000000L,   64 KiB),
      axiAMapping      = (0xFA000000L,   16 MiB),
      simulation = false,
      cpu = VexRiscvConfig(
        withMemoryStage = true,
        withWriteBackStage = true,
        plugins = List(
          new IBusCachedPlugin(
            resetVector = 0xF9000000L,
            prediction = STATIC,
            relaxedPcCalculation = false,
            compressedGen = false,
            injectorStage = false,
            config = InstructionCacheConfig(
              cacheSize = iCacheSize,
              bytePerLine =32,
              wayCount = 1,
              addressWidth = 32,
              cpuDataWidth = 32,
              memDataWidth = 32,
              catchIllegalAccess = true,
              catchAccessFault = true,
              asyncTagMemory = false,
              twoCycleRam = true,
              twoCycleCache = true
            ),
            memoryTranslatorPortConfig = linuxReady generate MmuPortConfig(
              portTlbSize = 4
            )
          ),
          new DBusCachedPlugin(
            config = new DataCacheConfig(
              cacheSize         = dCacheSize,
              bytePerLine       = 32,
              wayCount          = 1,
              addressWidth      = 32,
              cpuDataWidth      = 32,
              memDataWidth      = 32,
              catchAccessError  = true,
              catchIllegal      = true,
              catchUnaligned    = true,
              withLrSc = linuxReady,
              withAmo = linuxReady
            ),
            dBusCmdMasterPipe = true,
            dBusCmdSlavePipe = true,
            dBusRspSlavePipe = true,
            memoryTranslatorPortConfig = linuxReady generate MmuPortConfig(
              portTlbSize = 4
            )
          ),
          if (!linuxReady) {
            new StaticMemoryTranslatorPlugin(
              ioRange = ioRange
            )
          } else {
            new MmuPlugin(
              ioRange = ioRange
            )
          },

          new DecoderSimplePlugin(
            catchIllegalInstruction = true
          ),
          new RegFilePlugin(
            regFileReadyKind = plugin.SYNC,
            zeroBoot = true,
            x0Init = false,
            readInExecute = false
          ),
          new IntAluPlugin,
          new SrcPlugin(
            separatedAddSub = false,
            executeInsertion = false
          ),
          new FullBarrelShifterPlugin,
          new MulPlugin,
          new DivPlugin,
          new HazardSimplePlugin(
            bypassExecute           = true,
            bypassMemory            = true,
            bypassWriteBack         = true,
            bypassWriteBackBuffer   = true
          ),
          new BranchPlugin(
            earlyBranch = false,
            catchAddressMisaligned = true,
            decodeBranchSrc2 = true //for timings
          ),
          if(!linuxReady){
            new CsrPlugin(
              config = CsrPluginConfig(
                catchIllegalAccess = true,
                mvendorid      = null,
                marchid        = null,
                mimpid         = null,
                mhartid        = 0,
                misaExtensionsInit = 0,
                misaAccess     = CsrAccess.NONE,
                mtvecAccess    = CsrAccess.READ_WRITE,
                mtvecInit      = null,
                mepcAccess     = CsrAccess.READ_WRITE,
                mscratchGen    = false,
                mcauseAccess   = CsrAccess.READ_ONLY,
                mbadaddrAccess = CsrAccess.READ_ONLY,
                mcycleAccess   = CsrAccess.NONE,
                minstretAccess = CsrAccess.NONE,
                ecallGen       = true,
                wfiGenAsWait   = false,
                wfiGenAsNop    = true,
                ucycleAccess   = CsrAccess.NONE
              )
            )
          } else {
            new CsrPlugin(CsrPluginConfig.openSbi(mhartid = 0, misa = Riscv.misaToInt("imas")).copy(
              ebreakGen = false,
              mtvecAccess = CsrAccess.READ_WRITE //Required by FREERTOS
            ))
          },
          new YamlPlugin("cpu0.yaml")
        )
      )
    )
    if(customInstruction) config.cpu.plugins +=  new CfuPlugin(
      stageCount = 1,
      allowZeroLatency = true,
      encodings = List(
        CfuPluginEncoding (
          instruction = M"-------------------------0001011",
          functionId = List(31 downto 25, 14 downto 12),
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
    config
  }
}





