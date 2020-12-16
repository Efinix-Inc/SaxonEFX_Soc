package saxon.board.efinix

import saxon._
import spinal.core._
import spinal.lib._
import spinal.lib.com.jtag.sim.JtagTcp
import spinal.lib.com.spi.ddr.{SpiXdrMasterCtrl, SpiXdrParameter}
import spinal.lib.com.uart.UartCtrlMemoryMappedConfig
import spinal.lib.com.uart.sim.{UartDecoder, UartEncoder}
import spinal.lib.generator._
import spinal.lib.io.Gpio
import spinal.lib.misc.plic.PlicMapping
import vexriscv.demo.SimdAddPlugin

class TrainingSystem extends Generator {
  implicit val interconnect = BmbInterconnectGenerator()
  implicit val apbDecoder = Apb3DecoderGenerator()

  val peripheralBridge = BmbToApb3Decoder(0x10000000)
  val cpu = VexRiscvBmbGenerator()

  val plic = Apb3PlicGenerator(0xC00000)
  plic.priorityWidth.load(2)
  plic.mapping.load(PlicMapping.sifive)
  plic.addTarget(cpu.externalInterrupt)

  val machineTimer = Apb3MachineTimerGenerator(0x08000)
  cpu.setTimerInterrupt(machineTimer.interrupt)
  plic.addInterrupt(machineTimer.interrupt, 31)


  val gpioA = Apb3GpioGenerator(0x00000)
  val uartA = Apb3UartGenerator(0x10000)
  val spiA = new Apb3SpiGenerator(0x20000){
    val io = phyAsIo()
  }

  val ramA = BmbOnChipRamGenerator(0x80000000l)
  ramA.dataWidth.load(32)

  interconnect.addConnection(
    cpu.iBus -> List(ramA.bmb),
    cpu.dBus -> List(ramA.bmb, peripheralBridge.input)
  )

//  val bridge = BmbBridgeGenerator()
//  interconnect.addConnection(
//    cpu.iBus -> List(bridge.bmb),
//    cpu.dBus -> List(bridge.bmb),
//    bridge.bmb -> List(ramA.bmb, peripheralBridge.input)
//  )

  interconnect.setConnector(cpu.dBus){case (m,s) =>
    m.cmd >/> s.cmd
    m.rsp <<  s.rsp
  }
}

class TrainingExtendedSystem extends TrainingSystem {
  val uartB = Apb3UartGenerator(0x11000)
  val uartC = Apb3UartGenerator(0x12000)

  uartB.parameter load UartCtrlMemoryMappedConfig(
    baudrate = 115200,
    txFifoDepth = 128,
    rxFifoDepth = 128
  )

  uartC.parameter load UartCtrlMemoryMappedConfig(
    baudrate = 115200,
    txFifoDepth = 128,
    rxFifoDepth = 128
  )

  val pwmA = new Apb3PwmGenerator(0x30000)
  pwmA.width.load(8)
}


object TrainingSystem{
  def defaultSetting(g : TrainingSystem, debugCd : ClockDomainResetGenerator, cpuCd : ClockDomainResetGenerator): Unit =g {
    import g._

    cpu.config.load(VexRiscvConfigs.muraxLike.add(new SimdAddPlugin))
    cpu.enableJtag(debugCd, cpuCd)

    ramA.size.loadi(8096)
    ramA.hexInit.load(null)

    uartA.parameter load UartCtrlMemoryMappedConfig(
      baudrate = 115200,
      txFifoDepth = 128,
      rxFifoDepth = 128
    )
    gpioA.parameter load Gpio.Parameter(
      width = 24,
      interrupt = List(0, 1, 2, 3)
    )
    gpioA.connectInterrupts(plic, 4)

    spiA.parameter load SpiXdrMasterCtrl.MemoryMappingParameters(
      SpiXdrMasterCtrl.Parameters(
        dataWidth = 8,
        timerWidth = 12,
        spi = SpiXdrParameter(
          dataWidth = 2,
          ioRate = 1,
          ssWidth = 1
        )
      ) .addFullDuplex(id = 0),
      cmdFifoDepth = 256,
      rspFifoDepth = 256
    )
  }
}


class TrainingToplevel extends Generator{
  val globalCd = ClockDomainResetGenerator()
  globalCd.holdDuration.load(255)
  globalCd.enablePowerOnReset()
  globalCd.makeExternal(
    frequency = FixedFrequency(50 MHz)
  )

  val systemCd = ClockDomainResetGenerator()
  systemCd.setInput(globalCd)
  systemCd.holdDuration.load(63)

  val system = new TrainingExtendedSystem()

  system.onClockDomain(systemCd.outputClockDomain)
}

object TrainingSystemGen{
  def gen() = {
    val toplevel = new TrainingToplevel
    TrainingSystem.defaultSetting(
      g = toplevel.system,
      debugCd = toplevel.globalCd,
      cpuCd = toplevel.systemCd
    )
    toplevel.system.ramA.hexInit.load("software/standalone/asmSimd/build/asmSimd.hex")

    val dut = toplevel.toComponent()
    BspGenerator("efinix/Training", toplevel, toplevel.system.cpu.dBus)
    dut
  }

  def main(args: Array[String]): Unit = {
    SpinalRtlConfig.generateVerilog(gen)
  }
}

object TrainingSystemSim {
  import spinal.core.sim._

  def main(args: Array[String]): Unit = {
    val simConfig = SimConfig
//    simConfig.allOptimisation
    simConfig.withWave

    simConfig.compile {
      TrainingSystemGen.gen
    }.doSimUntilVoid { dut =>
      val systemClkPeriod = (1e12/dut.globalCd.outputClockDomain.frequency.getValue.toDouble).toLong
      val jtagClkPeriod = systemClkPeriod*4
      val uartBaudRate = 115200
      val uartBaudPeriod = (1e12/uartBaudRate).toLong

      dut.globalCd.inputClockDomain.get.forkStimulus(systemClkPeriod)

      val tcpJtag = JtagTcp(
        jtag = dut.system.cpu.jtag,
        jtagClkPeriod = jtagClkPeriod
      )

      dut.globalCd.inputClockDomain.get.waitSampling(10)

      val uartTx = UartDecoder(
        uartPin =  dut.system.uartA.uart.txd,
        baudPeriod = uartBaudPeriod
      )

      val uartRx = UartEncoder(
        uartPin = dut.system.uartA.uart.rxd,
        baudPeriod = uartBaudPeriod
      )
    }
  }
}