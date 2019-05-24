package saxon

import java.awt
import java.awt.event.{ActionEvent, ActionListener, MouseEvent, MouseListener}
import java.nio.file.{Files, Paths}

import spinal.sim._
import spinal.core._
import spinal.core.sim._
import spinal.lib.generator._
import javax.swing._
import spinal.lib.com.jtag.sim.JtagTcp
import spinal.lib.com.uart.sim.{UartDecoder, UartEncoder}
import spinal.lib.memory.sdram.sim.SdramModel
import spinal.lib.memory.sdram.{SdramCtrl, SdramInterface, SdramLayout}
import vexriscv.test.{JLedArray, JSwitchArray}

import scala.collection.mutable




object SaxonSim {
  def main(args: Array[String]): Unit = {
    val simSlowDown = false

    val simConfig = SimConfig
    simConfig.allOptimisation
    simConfig.withWave
    simConfig.compile(new GeneratorComponent(new SaxonSoc().defaultSetting())).doSimUntilVoid("test", 42){dut =>
      val systemClkPeriod = (1e12/dut.generator.clockCtrl.clkFrequency.get.toDouble).toLong
      val jtagClkPeriod = systemClkPeriod*4
      val uartBaudRate = 1000000
      val uartBaudPeriod = (1e12/uartBaudRate).toLong

      val clockDomain = ClockDomain(dut.generator.clockCtrl.io.clk, dut.generator.clockCtrl.io.reset)
      clockDomain.forkStimulus(systemClkPeriod)
//      clockDomain.forkSimSpeedPrinter(4)

      fork{
        while(true){
          sleep(systemClkPeriod*1000000*10)
          println("\nsimTime : " + simTime())
        }
      }
      fork{
        disableSimWave()
//        sleep(180000000000l)
//        enableSimWave()
//        sleep(systemClkPeriod*1000000)
//        simFailure()
      }




      val tcpJtag = JtagTcp(
        jtag = dut.generator.core.cpu.jtag,
        jtagClkPeriod = jtagClkPeriod
      )

      val uartTx = UartDecoder(
        uartPin =  dut.generator.core.uartA.uart.get.txd,
        baudPeriod = uartBaudPeriod
      )

      val uartRx = UartEncoder(
        uartPin = dut.generator.core.uartA.uart.get.rxd,
        baudPeriod = uartBaudPeriod
      )

      val sdram = SdramModel(
        io = dut.generator.core.sdramA.sdram.get,
        layout = dut.generator.core.sdramA.logic.layout,
        clockDomain = clockDomain
      )
//      sdram.loadBin(0, "software/standalone/dhrystone/build/dhrystone.bin")

      val binPath = "ext/VexRiscv/src/test/resources/VexRiscvRegressionData/sim/linux/rv32ima/"
      sdram.loadBin(0x00000000, binPath + "Image")
      sdram.loadBin(0x02000000, binPath + "rootfs.cpio")
      sdram.loadBin(0x03000000, binPath + "rv32.dtb")
    }
  }

}
