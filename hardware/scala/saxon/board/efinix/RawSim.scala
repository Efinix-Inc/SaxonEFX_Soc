package saxon.board.efinix
import spinal.core._
import spinal.lib._
import spinal.core.sim._
import spinal.lib.com.uart.sim.{UartDecoder, UartEncoder}
object RawSim extends App{
  class Toplevel extends BlackBox {
    setDefinitionName("top_rubySoc")

    //PLL
    val my_pll_locked = in Bool()
    val my_ddr_pll_locked = in Bool()
    val io_systemClk = in Bool()
    val io_asyncReset = in Bool()
    val io_memoryClk = in Bool()

    val system_uart_0_io_txd = out Bool()
    val system_uart_0_io_rxd = in Bool()
  }

  val config = SimConfig

  config.addSimulatorFlag("-Wno-TIMESCALEMOD")
  config.addSimulatorFlag("-Wno-PINMISSING")
  config.addSimulatorFlag("-Wno-IMPLICIT")
  config.addSimulatorFlag("-Wno-REALCVT")
  config.addSimulatorFlag("-Wno-COMBDLY")
  config.addSimulatorFlag("-Wno-WIDTHCONCAT")
  config.withFstWave


//  config.withIVerilog
//  config.withLogging
//  config.withWave


  config.addRtl("hardware/synthesis/efx/T120F576_BB_cacheless/source/aes_instruction.v")
  config.addRtl("hardware/synthesis/efx/T120F576_BB_cacheless/source/top_rubySoc.v")
  config.addRtl("hardware/synthesis/efx/T120F576_BB_cacheless/source/user_dual_port_ram.v")
  config.addIncludeDir("hardware/synthesis/efx/T120F576_BB_cacheless/source")

  config.addRtl("hardware/netlist/trion_cacheless.v")
  config.addRtl("hardware/netlist/trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol0.bin")
  config.addRtl("hardware/netlist/trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol1.bin")
  config.addRtl("hardware/netlist/trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol2.bin")
  config.addRtl("hardware/netlist/trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol3.bin")
  config.addIncludeDir("hardware/netlist")

//  config.addRtl("hardware/synthesis/efx/T120F576_BB_cacheless/source/trion_cacheless.v")
//  config.addIncludeDir("hardware/synthesis/efx/T120F576_BB_cacheless")
  config.compile(new Toplevel).doSimUntilVoid(seed = 7654){dut =>
    val systemClkPeriod = (1e12/66666666).toLong
    val uartBaudRate = 115200
    val uartBaudPeriod = (1e12/uartBaudRate).toLong

    val cd = ClockDomain(dut.io_systemClk, dut.io_asyncReset, config = ClockDomainConfig(resetActiveLevel = LOW))
    cd.forkStimulus(systemClkPeriod)
    dut.my_pll_locked #= true
    dut.my_ddr_pll_locked #= true

    val uartTx = UartDecoder(
      uartPin =  dut.system_uart_0_io_txd,
      baudPeriod = uartBaudPeriod
    )

    val uartRx = UartEncoder(
      uartPin = dut.system_uart_0_io_rxd,
      baudPeriod = uartBaudPeriod
    )

    println("running")

  }

}
