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


case class RmiiSpec (     name : String,
                          address : BigInt,
                          interruptId : Int)
case class TimerSpec (    name : String,
                          address : BigInt,
                          interruptBase : Int,
                          config : EfxTimerCtrlParameter)


//Definition of the SoC parameters
case class EfxRiscvBmbDdrSocParameter(systemFrequency : HertzNumber,
                                      onChipRamSize : BigInt,
                                      onChipRamHexFile : String,
                                      iCacheSize : Int,
                                      dCacheSize : Int,
                                      iCacheWays : Int,
                                      dCacheWays : Int,
                                      withSoftJtag : Boolean,
                                      withRiscvDebugPriv : Boolean,
                                      gpio : Seq[GpioSpec],
                                      uart : Seq[UartSpec],
                                      spi : Seq[SpiSpec],
                                      timer : Seq[TimerSpec],
                                      i2c : Seq[I2cSpec],
                                      rmii : Seq[RmiiSpec],
                                      interrupt : Seq[InterruptSpec] = Nil,
                                      ddrA  : Axi4Config,
                                      axiA  : Axi4Config,
                                      ddrANoBurst : Boolean,
                                      ddrAAxi4 : Boolean,
                                      ddrAMapping      : SizeMapping,
                                      apbBridgeMapping : SizeMapping,
                                      axiAMapping      : SizeMapping,
                                      onChipRamMapping : SizeMapping,
                                      ddrMasters : Seq[DdrMasterSpec],
                                      apbSlaves : Seq[ApbSlaveSpec],
                                      simulation : Boolean,
                                      customInstruction : Boolean,
                                      cpuCount : Int,
                                      withFpu : Boolean,
                                      withAxiA : Boolean = true,
                                      withDdrA : Boolean = true,
                                      linuxReady : Boolean = true,
                                      withAtomic : Boolean = true,
                                      bsp : String = null,
                                      resetVector : Long = 0xF9000000L,
                                      rvc : Boolean = false,
                                      additionalJtagTapMax : Int = 1,
                                      withL1D : Boolean = true,
                                      withL1I : Boolean = true,
                                      withPeripheralClock : Boolean = false,
                                      peripheralFrequancy : HertzNumber = null,
                                      tapId : BigInt = 0x00220a79,
                                      toplevelName : String = "EfxRiscvBmbDdrSoc",
                                      withNaxRiscv : Boolean = false){
  def withCoherency = cpuCount > 1 || linuxReady
  def withVexRiscv = !withNaxRiscv
}

object EfxRiscvBmbDdrSocParameter{
  def defaultArgs(args : Seq[String]): EfxRiscvBmbDdrSocParameter ={
    var iCacheSize = 8192
    var dCacheSize = 8192
    var iCacheWays = 2
    var dCacheWays = 2
    var withAxiA = true
    var withDdrA = true
    var withAtomic = true
    var onChipRamHexFile = "software/standalone/bootloader/build/bootloader.hex"
    var systemFrequancy = 50000000
    var peripheralFrequancy = -1
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
    var linuxReady = true
    var cpuCount = 1
    var customInstruction = false
    var withSoftJtag = false
    var withRiscvDebugPriv = false
    val gpio = ArrayBuffer[GpioSpec]()
    val uart = ArrayBuffer[UartSpec]()
    val spi = ArrayBuffer[SpiSpec]()
    val timer = ArrayBuffer[TimerSpec]()
    val i2c = ArrayBuffer[I2cSpec]()
    val rmii = ArrayBuffer[RmiiSpec]()
    val interrupt = ArrayBuffer[InterruptSpec]()
    var withFpu = false
    var bsp = "bsp/efinix/EfxRiscvBmbDdrSoc"
    var resetVector = 0xF9000000L
    var rvc = false
    var withL1D = true
    var withL1I = true
    var toplevelName = "EfxRiscvBmbDdrSoc"
    var withPeripheralClock = false
    var additionalJtagTapMax = 0
    var withNaxRiscv = false
    var ddrAAxi4 = false
    var ddrANoBurst = false

    def decode(str : String) = if(str.contains("0x"))
      BigInt(str.replace("0x",""), 16)
    else
      BigInt(str, 10)

    assert(new scopt.OptionParser[Unit]("EfxRiscvAxiDdrSocGen") {
      help("help").text("prints this usage text")
      opt[String]("toplevelName")  action { (v, c) => toplevelName = v } text(s"Set the name of the toplevel module. Default $toplevelName")
      opt[String]("ramHex")  action { (v, c) => onChipRamHexFile = v } text(s"Set the main memory boot content with an hex file. Default $onChipRamHexFile")
      opt[Unit]("customInstruction")action { (v, c) => customInstruction = true } text(s"Add custom instruction interface. Default $customInstruction")
      opt[Unit]("noLinux")action { (v, c) => linuxReady = false } text(s"Default ${!linuxReady}")
      opt[Unit]("noAtomic")action { (v, c) => withAtomic = false } text(s"Default ${!withAtomic}")
      opt[Unit]("noDdrA")action { (v, c) => withDdrA = false } text(s"Turn off ddrA")
      opt[Unit]("noAxiA")action { (v, c) => withAxiA = false } text(s"Turn off axiA")
      opt[Unit]("withFpu")action { (v, c) => withFpu = true } text(s"Turn on the FPU generation")
      opt[Int]("cpuCount")action { (v, c) => cpuCount = v } text(s"Default $cpuCount")
      opt[Unit]("softJtag")action { (v, c) => withSoftJtag = true } text(s"Add a jtag tap to the SoC. Default $withSoftJtag")
      opt[Unit]("withRiscvDebugPriv")action { (v, c) => withRiscvDebugPriv = true } text(s"Implement the debug following the official RISC-V spec. Default $withRiscvDebugPriv")
      opt[String]("iCacheSize")action { (v, c) => iCacheSize = decode(v).toInt } text(s"At least 32 and multiple of 32. Default $iCacheSize")
      opt[String]("dCacheSize")action { (v, c) => dCacheSize = decode(v).toInt } text(s"At least 32 and multiple of 32. Default $dCacheSize")
      opt[String]("iCacheWays")action { (v, c) => iCacheWays = decode(v).toInt } text(s"At least 1 and power of 2. Default $iCacheWays")
      opt[String]("dCacheWays")action { (v, c) => dCacheWays = decode(v).toInt } text(s"At least 1 and power of 32. Default $dCacheWays")
      opt[Int]("systemFrequency")action { (v, c) => systemFrequancy = v } text(s"CPU and peripheral frequency (if no peripheralClock specified) Default $systemFrequancy")
      opt[Int]("peripheralFrequency")action { (v, c) => peripheralFrequancy = v } text(s"Peripherals frequency (set the UART baudrate at reset). Same as systemFrequency by default")
      opt[Unit]("withPeripheralClock")action { (v, c) => withPeripheralClock = true} text(s"All the peripherals will use a dedicated clock. You will have to set peripheralFrequency too")
      opt[String]("ddrADataWidth")action { (v, c) => ddrADataWidth = decode(v).toInt } text(s"Default $ddrADataWidth")
      opt[String]("uartBaudrate")action { (v, c) => uartBaudrate = decode(v).toInt } text(s"Default $uartBaudrate")
      opt[Unit]("ddrAAxi4")action { (v, c) => ddrAAxi4 = true } text(s"Default $ddrAAxi4")
      opt[Unit]("ddrANoBurst")action { (v, c) => ddrANoBurst = true } text(s"Default $ddrANoBurst")
      opt[String]("ddrAAddress")action { (v, c) => ddrAAddress = decode(v) } text(s"Default 0x${ddrAAddress.toString(16)}")
      opt[String]("ddrASize")action { (v, c) => ddrASize = decode(v) } text(s"Default 0x${ddrASize.toString(16)}")
      opt[String]("apbBridgeAddress")action { (v, c) => apbBridgeAddress = decode(v) } text(s"Default 0x${apbBridgeAddress.toString(16)}")
      opt[String]("apbBridgeSize")action { (v, c) => apbBridgeSize = decode(v) } text(s"Default 0x${apbBridgeSize.toString(16)}")
      opt[String]("onChipRamAddress")action { (v, c) => onChipRamAddress = decode(v) } text(s"Default 0x${onChipRamAddress.toString(16)}")
      opt[String]("onChipRamSize")action { (v, c) => onChipRamSize = decode(v) } text(s"At least 1 KB to host the flash bootloader. Default 0x${onChipRamSize.toString(16)}")
      opt[String]("axiAAddress")action { (v, c) => axiAAddress = decode(v) } text(s"Default 0x${axiAAddress.toString(16)}")
      opt[String]("axiASize")action { (v, c) => axiASize = decode(v) } text(s"Default 0x${axiASize.toString(16)}")
      opt[String]("bsp")action { (v, c) => bsp = v } text(s"Path to the bsp folder, default ${bsp}")
      opt[Long]("resetVector")action { (v, c) => resetVector = v } text(s"Address at which the CPU program counter is set during reset. default ${resetVector}")
      opt[Unit]("rvc")action { (v, c) => rvc = true } text(s"Enable RISC-V compressed instructions")
      opt[Unit]("noL1I")action { (v, c) => withL1I = false } text(s"Disable CPU instruction caches")
      opt[Unit]("noL1D")action { (v, c) => withL1D = false } text(s"Disable CPU data caches")
      opt[Unit]("withNaxRiscv")action { (v, c) => withNaxRiscv = true } text(s"Default VexRiscv")
      opt[Int]("additionalJtagTapMax")action { (v, c) => additionalJtagTapMax = v } text(s"Allow having additional jtag tap on the jtag chain, up to the given number. Default 0")
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
            txFifoDepth = 128,
            rxFifoDepth = 128
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

      opt[Map[String, String]]("timer") unbounded() action { (v, c) =>
        timer += TimerSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptBase = Integer.decode(v("interruptBase")).toInt,
          config = EfxTimerCtrlParameter(
            prescalerWidth = Integer.decode(v("prescalerWidth")).toInt,
            timers = v("countersWidth").split("/").map(e => EfxTimerParameter(
              width = Integer.decode(e).toInt
            ))
          )
        )
      } text (s"Add a new timer controller with the given name, address (relative to the apbBridge), and a few parameters Ex : --timer name=timerA,address=0x99000,prescalerWidth=8,interruptBase=16,counters=12/16/32    for a triple timer of 12 bits, 16 bits, 32 bits")


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

      opt[Map[String, String]]("rmii") unbounded() action { (v, c) =>
        rmii += RmiiSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptId = Integer.decode(v("interruptId")).toInt
        )
      } text (s"Add a new RMII with the given name, address (relative to the apbBridge) and interrupt id,  Ex : --i2c name=portName,address=0x123000,interruptId=2")


      opt[Map[String, String]]("gpio") unbounded() action { (v, c) =>
        val interruptMapping = v("interrupts").split("[;/]").map(s => (s.split("->")(0).toInt -> s.split("->")(1).toInt))
        gpio += GpioSpec(
          address = Integer.decode(v("address")).toInt,
          name = v("name"),
          interruptMapping = interruptMapping.toSeq,
          config = Gpio.Parameter(
            width = Integer.decode(v("width")).toInt,
            interrupt = interruptMapping.map(_._1).toSeq
          )
        )
      } text (s"Add a new GPIO ctrl with the given name, address (relative to the apbBridge), width and interrupt mapping (pin->interruptId) Ex : --gpio name=io_gpioA,address=0x000000,width=8,interrupts=0->12/2->13")


      opt[Map[String, String]]("ddrMaster") unbounded() action { (v, c) =>
        ddrMasters += DdrMasterSpec(
          name = v("name"),
          axiConfig = Axi4Config(addressWidth = 32, dataWidth = v("dataWidth").toInt, idWidth = 4)
        )
      } text (s"Add a new DDR AXI master with the given name, and data width,  Ex : --ddrMaster name=portName,dataWidth=32")
    }.parse(args))

    val apbBridgeMapping : SizeMapping = (apbBridgeAddress,apbBridgeSize)
    val axiAMapping      : SizeMapping = (axiAAddress,axiASize)

    if(!withPeripheralClock){
      peripheralFrequancy = systemFrequancy
    } else {
      assert(peripheralFrequancy != -1, "You need the specify the peripheralFrequency")
    }
    
    val config = EfxRiscvBmbDdrSocParameter.default(
      iCacheSize = iCacheSize,
      dCacheSize = dCacheSize,
      iCacheWays = iCacheWays,
      dCacheWays = dCacheWays,
      systemFrequancy = systemFrequancy,
      onChipRamSize = onChipRamSize.toInt,
      ddrADataWidth = ddrADataWidth,
      uartBaudrate = uartBaudrate,
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
      timer = timer,
      withSoftJtag = withSoftJtag,
      withRiscvDebugPriv = withRiscvDebugPriv,
      i2c = i2c,
      rmii = rmii,
      interrupt = interrupt,
      onChipRamHexFile = onChipRamHexFile,
      cpuCount = cpuCount,
      withFpu = withFpu,
      withDdrA = withDdrA,
      ddrAAxi4 = ddrAAxi4,
      ddrANoBurst = ddrANoBurst,
      withAxiA = withAxiA,
      linuxReady = linuxReady,
      withAtomic = withAtomic,
      bsp = bsp,
      resetVector = resetVector,
      rvc = rvc,
      withL1D = withL1D,
      withL1I = withL1I,
      withNaxRiscv = withNaxRiscv,
      toplevelName = toplevelName,
      additionalJtagTapMax = additionalJtagTapMax,
      withPeripheralClock = withPeripheralClock,
      peripheralFrequancy = peripheralFrequancy Hz
    )

    assert(!(linuxReady && !withAtomic), "Linux support require atomic, you can turn off linux via --noLinux")
    config
  }

  //Default configuration of the SoC
  def default(customInstruction : Boolean,
              iCacheSize : Int = 4096,
              dCacheSize : Int = 4096,
              iCacheWays : Int = 4096,
              dCacheWays : Int = 4096,
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
      iCacheSize = iCacheSize,
      dCacheSize = dCacheSize,
      iCacheWays = iCacheWays,
      dCacheWays = dCacheWays,
      gpio = Nil,
      uart = Nil,
      spi = Nil,
      timer = Nil,
      i2c = Nil,
      rmii = Nil,
      apbSlaves = Nil,
      ddrMasters = Nil,
      ddrAAxi4 = false,
      ddrANoBurst = false,
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
      withFpu = false,
      simulation = false,
      withSoftJtag = false,
      withRiscvDebugPriv = false
    )
    config
  }
}





