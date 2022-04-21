package saxon

import naxriscv.misc.PrivilegedPlugin
import naxriscv.platform.NaxRiscvBmbGenerator
import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.bus.bmb._
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.com.jtag.altera.VJtag2BmbMasterGenerator
import spinal.lib.com.jtag.xilinx.Bscane2BmbMasterGenerator
import spinal.lib.com.jtag.{JtagInstructionDebuggerGenerator, JtagTapDebuggerGenerator}
import spinal.lib.generator._
import spinal.lib.misc.plic.PlicMapping

class NaxRiscvSocBase(cpuCount : Int, withSupervisor : Boolean = true, peripheralCd : Handle[ClockDomain] = ClockDomain.currentHandle) extends Area {
  // Define the BMB interconnect utilities
  implicit val interconnect = BmbInterconnectGenerator()
  val bmbPeripheral = peripheralCd on BmbBridgeGenerator(mapping = SizeMapping(0x10000000, 16 MiB)).peripheral(dataWidth = 32)
  implicit val peripheralDecoder = peripheralCd on bmbPeripheral.asPeripheralDecoder()

  // Define the main interrupt controllers
  val plic = peripheralCd on BmbPlicGenerator(0xC00000)
  plic.priorityWidth.load(2)
  plic.mapping.load(PlicMapping.sifive)

  val clint = peripheralCd on BmbClintGenerator(0xB00000)
  clint.cpuCount.load(cpuCount)

  // Defines the VexRiscv cores with their connections to the PLIC and CLINT
  val cores = for(cpuId <- 0 until cpuCount) yield {
    def bufferize[T <: Data](that : T) : T = if(peripheralCd != ClockDomain.currentHandle) BufferCC[T](that, init = null.asInstanceOf[T]) else RegNext[T](that)
    val nax = new NaxRiscvBmbGenerator()
    nax.setTimerInterrupt(clint.timerInterrupt(cpuId).derivate(bufferize))
    nax.setSoftwareInterrupt(clint.softwareInterrupt(cpuId).derivate(bufferize))

    plic.addTarget(nax.externalInterrupt)
    if(withSupervisor) plic.addTarget(nax.externalSupervisorInterrupt)
    List(clint.logic, nax.logic).produce{
      for (plugin <- nax.plugins) plugin match {
        case plugin : PrivilegedPlugin if plugin.io.rdtime != null => plugin.io.rdtime := bufferize(clint.logic.io.time)
        case _ =>
      }
    }
    nax
  }

  // Can be use to define a SMP memory fabric with mainly 3 attatchement points (iBus, dBusCoherent, dBusIncoherent)
  def withDefaultFabric() = new Area{
    val mem = BmbBridgeGenerator()
    val periph = BmbBridgeGenerator()


    val chunk = for(cpu <- cores)  yield new Area{
      val memNode = BmbBridgeGenerator()
      val periphNode = BmbBridgeGenerator()
      interconnect.addConnection(
        cpu.iMem -> List(memNode.bmb),
        cpu.dMemRead -> List(memNode.bmb),
        cpu.dMemWrite -> List(memNode.bmb),
        memNode.bmb -> List(mem.bmb),

        cpu.iPeriph -> List(periphNode.bmb),
        cpu.dPeriph -> List(periphNode.bmb),
        periphNode.bmb -> List(periph.bmb)
      )
    }
  }

//  // Utility to create the debug fabric usable by JTAG
//  def withDebugBus(debugCd : Handle[ClockDomain], systemCd : ClockDomainResetGenerator, address : Long) = new Area{
//    val ctrl = debugCd on BmbBridgeGenerator()
//
//    for ((cpu,i) <- cores.zipWithIndex) {
//      cores(i).enableDebugBmb(debugCd, systemCd, SizeMapping(address + i * 0x1000, 0x1000))
//      interconnect.addConnection(ctrl.bmb, cpu.debugBmb)
//    }
//
//    def withJtag() = {
//      val tap = debugCd on JtagTapDebuggerGenerator()
//      interconnect.addConnection(tap.bmb, ctrl.bmb)
//      tap
//    }
//
//    def withJtagInstruction(headerIgnoreWidth : Int) = {
//      val tap = debugCd on JtagInstructionDebuggerGenerator(headerIgnoreWidth)
//      interconnect.addConnection(tap.bmb, ctrl.bmb)
//      tap
//    }
//
//    // For Xilinx series 7 FPGA
//    def withBscane2(userId : Int, headerIgnoreWidth : Int) = {
//      val tap = debugCd on Bscane2BmbMasterGenerator(userId, headerIgnoreWidth)
//      interconnect.addConnection(tap.bmb, ctrl.bmb)
//      tap
//    }
//
//    // For Altera FPGAs
//    def withVJtag(headerIgnoreWidth : Int) = {
//      val tap = debugCd on VJtag2BmbMasterGenerator(headerIgnoreWidth)
//      interconnect.addConnection(tap.bmb, ctrl.bmb)
//      tap
//    }
//  }
//
//  def withoutDebug(): Unit ={
//    for ((cpu,i) <- cores.zipWithIndex) {
//      cores(i).disableDebug()
//    }
//  }
}