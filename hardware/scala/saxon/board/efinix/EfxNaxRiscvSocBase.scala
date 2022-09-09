package saxon.board.efinix

import naxriscv.compatibility.{MemReadAsyncToPhasedReadSyncPhaseTag, MultiPortWritesSymplifierTag}
import naxriscv.debug.EmbeddedJtagPlugin
import naxriscv.frontend.DispatchPlugin
import naxriscv.misc.{RegFilePlugin, RobPlugin}
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

import scala.collection.mutable.ArrayBuffer




class EfxNaxRiscvCluster(p : EfxRiscvBmbDdrSocParameter,
                         peripheralCd : Handle[ClockDomain],
                         debugCd : ClockDomainResetGenerator,
                         debugResetCd : ClockDomainResetGenerator
                        ) extends NaxRiscvSocBase(p.cpuCount, withSupervisor = p.linuxReady, peripheralCd = peripheralCd){
  val fabric = withDefaultFabric()
  bmbPeripheral.mapping.load(p.apbBridgeMapping)

  val generalDataWidth = 64

  val bridge = BmbBridgeGenerator()

  val ramA = BmbOnChipRamGenerator()
  ramA.address.load(p.onChipRamMapping.base)
  ramA.size.load(p.onChipRamSize)
  ramA.hexInit.load(p.onChipRamHexFile)

  interconnect.addConnection(
    fabric.mem.bmb -> List(bridge.bmb),
    fabric.periph.bmb -> List(bridge.bmb),
    bridge.bmb -> List(ramA.ctrl, peripheralDecoder.bus)
  )

  // Configure the CPUs
  for((cpu, coreId) <- cores.zipWithIndex) {
    assert(coreId == 0)

    val plugins = naxriscv.Config.plugins(
      ioRange = address => p.apbBridgeMapping.hit(address) || p.axiAMapping.hit(address),
      fetchRange = address => !(p.apbBridgeMapping.hit(address) || p.axiAMapping.hit(address)),
      resetVector = p.resetVector,
      withDebug = true,
      withEmbeddedJtagInstruction = !p.withSoftJtag,
      withEmbeddedJtagTap = p.withSoftJtag,
      aluCount    = 1,
      decodeCount = 1,
      withMmu = false,
      withDistributedRam = false,
      branchCount = 8,
      withPerfCounters = false
    )

    //Tweek a few parameters
    plugins.foreach{
      case p : RobPlugin => {
        p.completionWithReg = true
        p.robSize = 32
      }
      case p : DispatchPlugin => p.slotCount = 16
      case _ =>
    }

    cpu.plugins.load(plugins)
  }

  // Add some interconnect pipelining to improve FMax
  if(cores.size != 1) {
    interconnect.masters(bridge.bmb).withPerSourceDecoder()
  }

  assert(cores.size == 1)
  val hardJtag = !p.withSoftJtag generate hardFork(new Area {
    val p = cores.head.logic.cpu.framework.getService[EmbeddedJtagPlugin]
    val jtagCtrl_tck = in(Bool()) setName("jtagCtrl_tck")
    p.debugCd.loadAsync(debugCd.outputClockDomain)
    p.noTapCd.load(ClockDomain(jtagCtrl_tck))
    debugResetCd.asyncReset(Handle(p.logic.ndmreset), ResetSensitivity.HIGH)
    val jtagCtrl = Handle(p.logic.jtagInstruction.toIo).setName("jtagCtrl")
  })

  val softJtag = p.withSoftJtag generate hardFork(new Area {
    val p = cores.head.logic.cpu.framework.getService[EmbeddedJtagPlugin]
    p.debugCd.loadAsync(debugCd.outputClockDomain)
    debugResetCd.asyncReset(Handle(p.logic.ndmreset), ResetSensitivity.HIGH)
    val io = p.logic.jtag.toIo.setName("jtag")
  })

  interconnect.setPipelining(bmbPeripheral.bmb)(cmdHalfRate = true, rspHalfRate = true)
  for(cpu <- cores) {
    interconnect.setPipelining(cpu.iMem)(cmdHalfRate = true)
    interconnect.setPipelining(cpu.dMemRead)(cmdHalfRate = true)
  }
//  for(cpu <- cores) interconnect.setPipelining(cpu.iBus)(rspValid = true)
  interconnect.setPipelining(bridge.bmb)(cmdValid = true, cmdReady = true)
//  interconnect.setPipelining(fabric.iBus.bmb)(cmdValid = true)
//  interconnect.setPipelining(fabric.exclusiveMonitor.input)(cmdValid = true, cmdReady = true, rspValid = true)
  interconnect.setPipelining(ramA.ctrl)(rspValid = true)

  interconnect.setPipelining(fabric.periph.bmb)(cmdHalfRate = true, rspHalfRate = true)
  interconnect.setPipelining(fabric.mem.bmb)(cmdValid = true, cmdReady = true, rspValid = true)


  interconnect.getConnection(bridge.bmb, bmbPeripheral.bmb).ccByToggle
}


/*
XLRs: 51345 / 60800 (84.45%)
	XLRs needed for Logic: 26240 / 60800 (43.16%)
	XLRs needed for Logic + FF: 6041 / 60800 (9.94%)
	XLRs needed for Adder: 866 / 60800 (1.42%)
	XLRs needed for Adder + FF: 544 / 60800 (0.89%)
	XLRs needed for FF: 17653 / 60800 (29.03%)
	XLRs needed for SRL8: 1 / 14720 (0.01%)
	XLRs needed for SRL8+FF: 0 / 14720 (0.00%)
	XLRs needed for Routing: 0 / 60800 (0.00%)

22497 ff 29558 lut 150 ram

XLRs: 40487 / 60800 (66.59%)
	XLRs needed for Logic: 20872 / 60800 (34.33%)
	XLRs needed for Logic + FF: 6111 / 60800 (10.05%)
	XLRs needed for Adder: 866 / 60800 (1.42%)
	XLRs needed for Adder + FF: 544 / 60800 (0.89%)
	XLRs needed for FF: 12093 / 60800 (19.89%)
	XLRs needed for SRL8: 1 / 14720 (0.01%)
	XLRs needed for SRL8+FF: 0 / 14720 (0.00%)
	XLRs needed for Routing: 0 / 60800 (0.00%)

12482 ff 20806 lut 159 ram

XLRs: 34519 / 60800 (56.77%)
	XLRs needed for Logic: 17496 / 60800 (28.78%)
	XLRs needed for Logic + FF: 6107 / 60800 (10.04%)
	XLRs needed for Adder: 866 / 60800 (1.42%)
	XLRs needed for Adder + FF: 544 / 60800 (0.89%)
	XLRs needed for FF: 9505 / 60800 (15.63%)
	XLRs needed for SRL8: 1 / 14720 (0.01%)
	XLRs needed for SRL8+FF: 0 / 14720 (0.00%)
	XLRs needed for Routing: 0 / 60800 (0.00%)

9891 ff 17399 lut 173 ram
 */