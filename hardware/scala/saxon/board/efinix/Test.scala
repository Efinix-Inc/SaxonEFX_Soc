package saxon.board.efinix

import org.apache.commons.io.FileUtils
import spinal.core._
import spinal.core.sim._
import spinal.lib.com.uart.sim.UartDecoder
import spinal.lib.sim.SparseMemory

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer



class BlackBoxedIp[T <: Data](ioType : => T, name : String) extends BlackBox{
  val io = ioType
  noIoPrefix()
  setDefinitionName(name)
}

class BlackBoxWrapper[T <: Data](ioType : => T, name : String) extends Component{
  val io = ioType
  val bb = new BlackBoxedIp(ioType, name)
  bb.io <> io
}




case class top_rubySoc_io() extends Bundle{
  val bscan_CAPTURE = in Bool()
  val bscan_DRCK = in Bool()
  val bscan_RESET = in Bool()
  val bscan_RUNTEST = in Bool()
  val bscan_SEL = in Bool()
  val bscan_SHIFT = in Bool()
  val bscan_TCK = in Bool()
  val bscan_TDI = in Bool()
  val bscan_TMS = in Bool()
  val bscan_UPDATE = in Bool()
  val bscan_TDO = out Bool()
  val video_clk_148_90 = in Bool()
  val video_clk_148 = in Bool()
  val video_clkx2 = in Bool()
  val apb3LED = out Bool()
  val memoryCheckerDone = out Bool()
  val memoryCheckerPass = out Bool()
//  val hdmi_clk_out = out Bool()
  val hdmi_de = out Bool()
  val hdmi_vsync = out Bool()
  val hdmi_hsync = out Bool()
  val hdmi_txd = out Bits(1+15 bits)
  val my_pll_rstn = out Bool()
  val my_pll_locked = in Bool()
  val my_ddr_pll_rstn = out Bool()
  val my_ddr_pll_locked = in Bool()
  val ddr_inst1_RSTN = out Bool()
  val ddr_inst1_CFG_SCL_IN = out Bool()
  val ddr_inst1_CFG_SDA_IN = out Bool()
  val ddr_inst1_CFG_SDA_OEN = in Bool()
  val io_systemClk = in Bool()
  val io_asyncReset = in Bool()
  val io_memoryClk = in Bool()
  val system_uart_0_io_txd = out Bool()
  val system_uart_0_io_rxd = in Bool()
  val system_i2c_0_io_sda_writeEnable = out Bool()
  val system_i2c_0_io_sda_write = out Bool()
  val system_i2c_0_io_sda_read = in Bool()
  val system_i2c_0_io_scl_writeEnable = out Bool()
  val system_i2c_0_io_scl_write = out Bool()
  val system_i2c_0_io_scl_read = in Bool()
  val system_i2c_1_io_sda_writeEnable = out Bool()
  val system_i2c_1_io_sda_write = out Bool()
  val system_i2c_1_io_sda_read = in Bool()
  val system_i2c_1_io_scl_writeEnable = out Bool()
  val system_i2c_1_io_scl_write = out Bool()
  val system_i2c_1_io_scl_read = in Bool()
  val system_gpio_0_io_read = in Bits(1+4 bits)
  val system_gpio_0_io_write = out Bits(1+4 bits)
  val system_gpio_0_io_writeEnable = out Bits(1+4 bits)
  val io_ddrA_arw_valid = out Bool()
  val io_ddrA_arw_ready = in Bool()
  val io_ddrA_arw_payload_addr = out Bits(1+31 bits)
  val io_ddrA_arw_payload_id = out Bits(1+7 bits)
  val io_ddrA_arw_payload_len = out Bits(1+7 bits)
  val io_ddrA_arw_payload_size = out Bits(1+2 bits)
  val io_ddrA_arw_payload_burst = out Bits(1+1 bits)
  val io_ddrA_arw_payload_lock = out Bits(1+1 bits)
  val io_ddrA_arw_payload_write = out Bool()
  val io_ddrA_w_payload_id = out Bits(1+7 bits)
  val io_ddrA_w_valid = out Bool()
  val io_ddrA_w_ready = in Bool()
  val io_ddrA_w_payload_data = out Bits(1+127 bits)
  val io_ddrA_w_payload_strb = out Bits(1+15 bits)
  val io_ddrA_w_payload_last = out Bool()
  val io_ddrA_b_valid = in Bool()
  val io_ddrA_b_ready = out Bool()
  val io_ddrA_b_payload_id = in Bits(1+7 bits)
  val io_ddrA_r_valid = in Bool()
  val io_ddrA_r_ready = out Bool()
  val io_ddrA_r_payload_data = in Bits(1+127 bits)
  val io_ddrA_r_payload_id = in Bits(1+7 bits)
  val io_ddrA_r_payload_resp = in Bits(1+1 bits)
  val io_ddrA_r_payload_last = in Bool()
  val dma_arwvalid = out Bool()
  val dma_arwready = in Bool()
  val dma_arwaddr = out Bits(1+31 bits)
  val dma_arwid = out Bits(1+7 bits)
  val dma_arwlen = out Bits(1+7 bits)
  val dma_arwsize = out Bits(1+2 bits)
  val dma_arwburst = out Bits(1+1 bits)
  val dma_arwlock = out Bits(1+1 bits)
  val dma_arwwrite = out Bool()
  val dma_wid = out Bits(1+7 bits)
  val dma_wvalid = out Bool()
  val dma_wready = in Bool()
  val dma_wdata = out Bits(1+255 bits)
  val dma_wstrb = out Bits(1+32 bits)
  val dma_wlast = out Bool()
  val dma_bvalid = in Bool()
  val dma_bready = out Bool()
  val dma_bid = in Bits(1+7 bits)
  val dma_rvalid = in Bool()
  val dma_rready = out Bool()
  val dma_rdata = in Bits(1+255 bits)
  val dma_rid = in Bits(1+7 bits)
  val dma_rresp = in Bits(1+1 bits)
  val dma_rlast = in Bool()
  val system_spi_0_io_sclk_write = out Bool()
  val system_spi_0_io_data_0_writeEnable = out Bool()
  val system_spi_0_io_data_0_read = in Bool()
  val system_spi_0_io_data_0_write = out Bool()
  val system_spi_0_io_data_1_writeEnable = out Bool()
  val system_spi_0_io_data_1_read = in Bool()
  val system_spi_0_io_data_1_write = out Bool()
  val system_spi_0_io_ss = out Bool()
  val system_spi_1_io_sclk = out Bool()
  val system_spi_1_io_data_0 = out Bool()
  val system_spi_1_io_data_1 = in Bool()
  val system_spi_1_io_ss = out Bool()
  val probes = out Bits(1+7 bits)
  val jtag_inst1_TCK = in Bool()
  val jtag_inst1_TDI = in Bool()
  val jtag_inst1_TDO = out Bool()
  val jtag_inst1_SEL = in Bool()
  val jtag_inst1_CAPTURE = in Bool()
  val jtag_inst1_SHIFT = in Bool()
  val jtag_inst1_UPDATE = in Bool()
  val jtag_inst1_RESET = in Bool()
}



object EfxDebugSoc extends App{
  val c = SimConfig
  c.withFstWave

  val rtlRoot = "/media/data/open/SaxonSoc/efinix/soc_Ruby/soc_Ruby_hw/"

  EfxRiscvBmbDdrSoc.main("--dCacheSize 4096 --iCacheSize 4096 --ddrADataWidth 128 --ddrASize 0xf7fff000 --onChipRamSize 0x1000 --axiAAddress 0xfa000000 --axiASize 0x1000 --apbSlave name=io_apbSlave_0,address=0x800000,size=4096 --apbSlave name=io_dma_ctrl,address=0x804000,size=16384 --ddrMaster name=io_ddrMasters_0,dataWidth=32 --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12;1->13 --uart name=system_uart_0_io,address=0x10000,interruptId=1 --uart name=system_uart_1_io,address=0x11000,interruptId=2 --spi name=system_spi_0_io,address=0x14000,interruptId=4 --spi name=system_spi_1_io,address=0x15000,interruptId=5 --spi name=system_spi_2_io,address=0x16000,interruptId=6 --i2c name=system_i2c_0_io,address=0x18000,interruptId=8 --i2c name=system_i2c_1_io,address=0x19000,interruptId=9 --i2c name=system_i2c_2_io,address=0x1A000,interruptId=10 --interrupt name=userInterruptA,id=25 --ramHex software/standalone/bootloader/build/bootloader.hex --cpuCount=2 --customInstruction".split(" "))

  FileUtils.copyFile(new java.io.File("hardware/netlist/EfxRiscvBmbDdrSoc.v"), new java.io.File(rtlRoot + "source/EfxRiscvBmbDdrSoc.v"))
  val binCp = List(
    "EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol0.bin",
    "EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol1.bin",
    "EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol2.bin",
    "EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol3.bin",
    "EfxRiscvBmbDdrSoc.v_toplevel_system_cpu_logic_cpu_RegFilePlugin_regFile.bin"
  )
  for(bin <- binCp){
    FileUtils.copyFile(new java.io.File(s"hardware/netlist/$bin"), new java.io.File(rtlRoot + s"source/$bin"))
    FileUtils.copyFile(new java.io.File(s"hardware/netlist/$bin"), new java.io.File(rtlRoot + s"T120F576_BB/$bin"))
  }


  c.addIncludeDir(rtlRoot + "source")

  val rtl = List(
    rtlRoot + "T120F576_BB/top_rubySoc.v",
    rtlRoot + "source/memory_checker.v",
    rtlRoot + "source/axi4_slave.v",
    rtlRoot + "source/apb3_slave.v",
    rtlRoot + "source/user_dual_port_ram.v",
    rtlRoot + "T120F576_BB/tgp_marco.v",
    rtlRoot + "T120F576_BB/sync_extract.v",
    rtlRoot + "source/EfxRiscvBmbDdrSoc.v",
    rtlRoot + "source/aes_instruction.v",
    rtlRoot + "source/video_ctrl_top.v",
    rtlRoot + "source/dma_soc.v",
    rtlRoot + "source/color_coding_converter.v",
    rtlRoot + "source/true_dual_port_ram.v"
  )
  for(f <- rtl) c.addRtl(f)

  val bin = List(
    rtlRoot + "T120F576_BB/EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol0.bin",
    rtlRoot + "T120F576_BB/EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol1.bin",
    rtlRoot + "T120F576_BB/EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol2.bin",
    rtlRoot + "T120F576_BB/EfxRiscvBmbDdrSoc.v_toplevel_system_ramA_logic_ram_symbol3.bin",
    rtlRoot + "T120F576_BB/rom_a00.mem",
    rtlRoot + "T120F576_BB/rom_a01.mem",
    rtlRoot + "T120F576_BB/rom_a02.mem",
    rtlRoot + "T120F576_BB/rom_a10.mem",
    rtlRoot + "T120F576_BB/rom_a11.mem",
    rtlRoot + "T120F576_BB/rom_a12.mem",
    rtlRoot + "T120F576_BB/rom_a20.mem",
    rtlRoot + "T120F576_BB/rom_a21.mem",
    rtlRoot + "T120F576_BB/rom_a22.mem"
  )
  for(f <- bin) c.addRtl(f)

  c.addSimulatorFlag("-Wno-TIMESCALEMOD")
  c.addSimulatorFlag("-Wno-PINMISSING")
  c.addSimulatorFlag("-Wno-IMPLICIT")
  c.addSimulatorFlag("-Wno-REALCVT")
  c.addSimulatorFlag("-Wno-COMBDLY")
  c.addSimulatorFlag("-Wno-WIDTHCONCAT")


  c.compile(new BlackBoxWrapper(new top_rubySoc_io, "top_rubySoc")).doSim(seed = 42){dut =>
    val io_systemClk = ClockDomain(dut.io.io_systemClk)
    val io_memoryClk = ClockDomain(dut.io.io_memoryClk)
    val video_clk_148 = ClockDomain(dut.io.video_clk_148)
    val video_clk_148_90 = ClockDomain(dut.io.video_clk_148_90)


    io_memoryClk.forkStimulus(10000)
    io_systemClk.forkStimulus(20000)
    video_clk_148.forkStimulus(6734)
    fork{
      sleep(6734*3/4)
      video_clk_148_90.forkStimulus(6734)
    }


    val memory = SparseMemory()
    val dmaReadQueue = mutable.Queue[(Array[Byte], Boolean)]()

    for(i <- 0x100000 to 0x1000000 by 4){
      memory.write(i, i.toInt)
    }

    dut.io.dma_arwready #= true


    sleep(10)
    dut.io.io_asyncReset #= false
    dut.io.my_pll_locked #= false
    dut.io.my_ddr_pll_locked #= false
    sleep(501)
    dut.io.io_asyncReset #= true
    dut.io.my_pll_locked #= true
    dut.io.my_ddr_pll_locked #= true

    val uartTx = UartDecoder(
      uartPin =  dut.io.system_uart_0_io_txd,
      baudPeriod = 1e12/115200 toInt
    )

    dut.io.system_uart_0_io_rxd #= true


    io_memoryClk.waitSampling(1000)
    io_memoryClk.onSamplings{
      dut.io.system_i2c_0_io_sda_read #= dut.io.system_i2c_0_io_sda_write.toBoolean
      dut.io.system_i2c_0_io_scl_read #= dut.io.system_i2c_0_io_scl_write.toBoolean

      if(dut.io.dma_rready.toBoolean){
        dut.io.dma_rvalid #= false
      }
      if(!dut.io.dma_rvalid.toBoolean || dut.io.dma_rready.toBoolean) {
        if (dmaReadQueue.nonEmpty) {
          val (data, last) = dmaReadQueue.dequeue()
          dut.io.dma_rvalid #= true
          dut.io.dma_rresp #= 0
          dut.io.dma_rdata #= data
          dut.io.dma_rlast #= last
        }
      }
      if(dut.io.dma_arwvalid.toBoolean){
        var addr = dut.io.dma_arwaddr.toLong & ~31
        val len = dut.io.dma_arwlen.toInt
        val work = ArrayBuffer[(Array[Byte], Boolean)]()
        for(i <- 0 to len){
          val data = new Array[Byte](32)
          for(byteId <- 0 to 31) {
            data(byteId) = memory.read(addr)
            addr += 1
          }
          work += ((data, i == len))
        }

        delayed(200*1000){
          dmaReadQueue ++= work
        }
      }
    }

    sleep(1e12*0.1)
  }
}


