/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// Description:
// Example top file for RubySoc
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
// 1.1 Enhance APB3 slave range from 4K  to 64K
//     Enhance AXI4 slave range from 4K  to 16MB
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module top_rubySoc (
	//Debug
    input  bscan_CAPTURE,
    input  bscan_DRCK,
    input  bscan_RESET,
    input  bscan_RUNTEST,
    input  bscan_SEL,
    input  bscan_SHIFT,
    input  bscan_TCK,
    input  bscan_TDI,
    input  bscan_TMS,
    input  bscan_UPDATE,
    output bscan_TDO,
    
    
    //user custom ports
	input           video_clk_148_90,
    input           video_clk_148,
    input           video_clkx2,
    
    // output          hdmi_clk_out,
    output          hdmi_de,
    output          hdmi_vsync,
    output          hdmi_hsync, 
    output [15:0]   hdmi_txd, 
	//PLL
  	output	      		my_pll_rstn,
  	input			my_pll_locked,
  	output	      		my_ddr_pll_rstn,
  	input			my_ddr_pll_locked,
	//DDR Control
	output			ddr_inst1_RSTN,
	output 			ddr_inst1_CFG_SCL_IN,
	output 			ddr_inst1_CFG_SDA_IN,
	input 			ddr_inst1_CFG_SDA_OEN,
	//SOC
  	input               	io_systemClk,
  	input               	io_asyncReset,
  	input               	io_memoryClk,
  	output              	system_uart_0_io_txd,
  	input               	system_uart_0_io_rxd,
  	output              	system_i2c_0_io_sda_writeEnable,
  	output              	system_i2c_0_io_sda_write,
  	input               	system_i2c_0_io_sda_read,
  	output              	system_i2c_0_io_scl_writeEnable,
  	output              	system_i2c_0_io_scl_write,
  	input               	system_i2c_0_io_scl_read,
  	output              	system_i2c_1_io_sda_writeEnable,
  	output              	system_i2c_1_io_sda_write,
  	input               	system_i2c_1_io_sda_read,
  	output              	system_i2c_1_io_scl_writeEnable,
  	output              	system_i2c_1_io_scl_write,
  	input               	system_i2c_1_io_scl_read,
  	input      [3:0]   	system_gpio_0_io_read,
  	output     [3:0]   	system_gpio_0_io_write,
  	output     [3:0]   	system_gpio_0_io_writeEnable,
  	output              	io_ddrA_arw_valid,
  	input               	io_ddrA_arw_ready,
  	output     [31:0]   	io_ddrA_arw_payload_addr,
  	output     [7:0]    	io_ddrA_arw_payload_id,
  	output     [7:0]    	io_ddrA_arw_payload_len,
  	output     [2:0]    	io_ddrA_arw_payload_size,
  	output     [1:0]    	io_ddrA_arw_payload_burst,
  	output     [1:0]    	io_ddrA_arw_payload_lock,
  	output              	io_ddrA_arw_payload_write,
  	output     [7:0]    	io_ddrA_w_payload_id,
  	output              	io_ddrA_w_valid,
  	input               	io_ddrA_w_ready,
  	output     [127:0]  	io_ddrA_w_payload_data,
  	output     [15:0]   	io_ddrA_w_payload_strb,
  	output              	io_ddrA_w_payload_last,
  	input               	io_ddrA_b_valid,
  	output              	io_ddrA_b_ready,
  	input      [7:0]    	io_ddrA_b_payload_id,
  	input               	io_ddrA_r_valid,
  	output              	io_ddrA_r_ready,
  	input      [127:0]  	io_ddrA_r_payload_data,
  	input      [7:0]    	io_ddrA_r_payload_id,
  	input      [1:0]    	io_ddrA_r_payload_resp,
  	input               	io_ddrA_r_payload_last,

  	output              	dma_arwvalid,
  	input               	dma_arwready,
  	output     [31:0]   	dma_arwaddr,
  	output     [7:0]    	dma_arwid,
  	output     [7:0]    	dma_arwlen,
  	output     [2:0]    	dma_arwsize,
  	output     [1:0]    	dma_arwburst,
  	output     [1:0]    	dma_arwlock,
  	output              	dma_arwwrite,
  	output     [7:0]    	dma_wid,
  	output              	dma_wvalid,
  	input               	dma_wready,
  	output     [255:0]  	dma_wdata,
  	output     [31:0]   	dma_wstrb,
  	output              	dma_wlast,
  	input               	dma_bvalid,
  	output              	dma_bready,
  	input      [7:0]    	dma_bid,
  	input               	dma_rvalid,
  	output              	dma_rready,
  	input      [255:0]  	dma_rdata,
  	input      [7:0]    	dma_rid,
  	input      [1:0]    	dma_rresp,
  	input               	dma_rlast,

  	output         		system_spi_0_io_sclk_write,
  	output              	system_spi_0_io_data_0_writeEnable,
  	input          		system_spi_0_io_data_0_read,
  	output         		system_spi_0_io_data_0_write,
  	output              	system_spi_0_io_data_1_writeEnable,
  	input          		system_spi_0_io_data_1_read,
  	output         		system_spi_0_io_data_1_write,
  	output         		system_spi_0_io_ss,
  	output         		system_spi_1_io_sclk,
  	output         		system_spi_1_io_data_0,
  	input          		system_spi_1_io_data_1,
  	output         		system_spi_1_io_ss,
  	output      [7:0]   probes,
`ifndef SOFT_TAP
	input               	jtag_inst1_TCK,
  	input               	jtag_inst1_TDI,
  	output              	jtag_inst1_TDO,
  	input               	jtag_inst1_SEL,
  	input               	jtag_inst1_CAPTURE,
  	input               	jtag_inst1_SHIFT,
  	input               	jtag_inst1_UPDATE,
  	input               	jtag_inst1_RESET
`else
  	input               	io_jtag_tms,
  	input               	io_jtag_tdi,
  	output              	io_jtag_tdo,
  	input               	io_jtag_tck
`endif
);
/////////////////////////////////////////////////////////////////////////////
//Local Parameter 
localparam NI = 1;
//Reset and PLL
wire 		mcuReset;
wire		io_systemReset;
wire		io_ddrMasterReset;
wire   [1:0]    io_ddrA_b_payload_resp;
(* keep , syn_keep *) wire 	  io_memoryReset /* synthesis syn_keep = 1 */;				
(* keep , syn_keep *) wire [3:0]  io_ddrA_arw_payload_qos /* synthesis syn_keep = 1 */;
(* keep , syn_keep *) wire [2:0]  io_ddrA_arw_payload_prot /* synthesis syn_keep = 1 */;
(* keep , syn_keep *) wire [3:0]  io_ddrA_arw_payload_cache /* synthesis syn_keep = 1 */;
(* keep , syn_keep *) wire [3:0]  io_ddrA_arw_payload_region /* synthesis syn_keep = 1 */;

//DDR Control Workaround
wire 		ddr_inst1_CFG_SDA_OEN_workaround;
wire		system_i2c_2_io_sda_write;
wire		system_i2c_2_io_sda_read;
wire		system_i2c_2_io_scl_write;
wire		system_i2c_2_io_scl_read;
//APB Slave 0  
wire		apb3MemoryStart;
wire   [15:0]   io_apbSlave_0_PADDR;
wire          	io_apbSlave_0_PSEL;
wire            io_apbSlave_0_PENABLE;
wire            io_apbSlave_0_PREADY;
wire            io_apbSlave_0_PWRITE;
wire   [31:0]   io_apbSlave_0_PWDATA;
wire   [31:0]   io_apbSlave_0_PRDATA;
wire            io_apbSlave_0_PSLVERROR;
//User Interupt
wire		userInterrupt;
wire   [NI-1:0] apb3Interrupt;
wire		axi4Interrupt;
//AXI Slave 0
wire   [7:0]	axi_awid;
wire   [31:0]	axi_awaddr;
wire   [7:0]	axi_awlen;
wire   [2:0]	axi_awsize;
wire   [1:0]	axi_awburst;
wire		axi_awlock;
wire   [3:0]	axi_awcache;
wire   [2:0]	axi_awprot;
wire   [3:0]	axi_awqos;
wire   [3:0]	axi_awregion;
wire	 	axi_awvalid;
wire		axi_awready;
wire   [31:0]	axi_wdata;
wire   [3:0] 	axi_wstrb;
wire		axi_wvalid;
wire	 	axi_wlast;
wire		axi_wready;
wire   [7:0]	axi_bid;
wire   [1:0]	axi_bresp;
wire	 	axi_bvalid;
wire		axi_bready;
wire   [7:0]	axi_arid;
wire   [31:0]	axi_araddr;
wire   [7:0]	axi_arlen;
wire   [2:0]	axi_arsize;
wire   [1:0]	axi_arburst;
wire	 	axi_arlock;
wire   [3:0]	axi_arcache;
wire   [2:0]	axi_arprot;
wire   [3:0]	axi_arqos;
wire   [3:0]	axi_arregion;
wire	 	axi_arvalid;
wire		axi_arready;
wire   [7:0]	axi_rid;
wire   [31:0]	axi_rdata;
wire   [1:0]	axi_rresp;
wire         	axi_rlast;
wire		axi_rvalid;
wire		axi_rready;	
//MemoryChecker
wire   [7:0]   	mc_aid_0;
wire   [31:0]  	mc_aaddr_0;
wire   [7:0]   	mc_alen_0;
wire   [2:0]   	mc_asize_0;
wire   [1:0]   	mc_aburst_0;
wire   [1:0]   	mc_alock_0;
wire           	mc_avalid_0;
wire           	mc_aready_0;
wire           	mc_awready_0;
wire           	mc_arready_0;
wire           	mc_atype_0;
wire   [7:0]   	mc_wid_0;
wire   [255:0]	mc_wdata_0;
wire   [31:0]	mc_wstrb_0;
wire           	mc_wlast_0;
wire           	mc_wvalid_0;
wire           	mc_wready_0;
wire   [7:0]   	mc_rid_0;
wire   [255:0] 	mc_rdata_0;
wire           	mc_rlast_0;
wire           	mc_rvalid_0;
wire           	mc_rready_0;
wire   [1:0]   	mc_rresp_0;
wire   [7:0]   	mc_bid_0;
wire   [1:0]   	mc_bresp_0;
wire           	mc_bvalid_0;
wire           	mc_bready_0;
wire		ddr_awValid;
wire		ddr_arValid;
wire		memoryFail;

/////////////////////////////////////////////////////////////////////////////
//Reset and PLL
assign mcuReset 	= ~( io_asyncReset & my_pll_locked & my_ddr_pll_locked );
assign my_pll_rstn 	= 1'b1;
assign my_ddr_pll_rstn 	= 1'b1;
//DDR Control Workaround
assign ddr_inst1_RSTN			= 1'b1;
assign ddr_inst1_CFG_SDA_OEN_workaround = ddr_inst1_CFG_SDA_OEN;
assign ddr_inst1_CFG_SDA_IN 		= system_i2c_2_io_sda_write && ddr_inst1_CFG_SDA_OEN_workaround;
assign ddr_inst1_CFG_SCL_IN 		= system_i2c_2_io_scl_write;
assign system_i2c_2_io_sda_read 	= system_i2c_2_io_sda_write && ddr_inst1_CFG_SDA_OEN_workaround;
assign system_i2c_2_io_scl_read 	= system_i2c_2_io_scl_write;
//I2C
assign system_i2c_0_io_sda_writeEnable = !system_i2c_0_io_sda_write;
assign system_i2c_0_io_scl_writeEnable = !system_i2c_0_io_scl_write;
assign system_i2c_1_io_sda_writeEnable = !system_i2c_1_io_sda_write;
assign system_i2c_1_io_scl_writeEnable = !system_i2c_1_io_scl_write;
//User Interrupt
assign userInterrupt 		       = apb3Interrupt[0];
//MemoryChecker
assign mc_aready_0 	 = (mc_atype_0 & mc_awready_0) | (!mc_atype_0 & mc_arready_0);
assign ddr_awValid 	 = mc_avalid_0 & mc_atype_0;
assign ddr_arValid 	 = mc_avalid_0 & ~mc_atype_0;
assign memoryCheckerPass = memoryCheckerDone? (memoryFail? 1'b0:1'b1) : 1'b0;
//DDR controller
assign io_ddrA_b_payload_resp = 2'b00;

/////////////////////////////////////////////////////////////////////////////


//Custom APB PLUGIN

apb3_slave #(
	// user parameter starts here
	//
	.ADDR_WIDTH	(16),
	.DATA_WIDTH	(32),
	.NUM_REG	(2)
) apb_slave_0 (
	// user logic starts here
	.apb3LED	(apb3LED),
	.apb3MemoryStart(apb3MemoryStart),
	.apb3Interrupt	(apb3Interrupt[0]),
	.clk		(io_systemClk),
	.resetn		(~io_systemReset),
	.PADDR		(io_apbSlave_0_PADDR),
	.PSEL		(io_apbSlave_0_PSEL),
	.PENABLE	(io_apbSlave_0_PENABLE),
	.PREADY		(io_apbSlave_0_PREADY),
	.PWRITE		(io_apbSlave_0_PWRITE),
	.PWDATA		(io_apbSlave_0_PWDATA),
	.PRDATA		(io_apbSlave_0_PRDATA),
	.PSLVERROR 	(io_apbSlave_0_PSLVERROR)

);
//Custom AXI PLUGIN

axi4_slave #(
	.ADDR_WIDTH	(32),
	.DATA_WIDTH 	(32)
) axi_slave_0 (
	.axi_interrupt  (axi4Interrupt),
	.axi_aclk	(io_systemClk),
	.axi_resetn	(~io_systemReset),
	.axi_awid	(axi_awid),
	.axi_awaddr	(axi_awaddr),
	.axi_awlen	(axi_awlen),
	.axi_awsize	(axi_awsize),
	.axi_awburst	(axi_awburst),
	.axi_awlock	(axi_awlock),
	.axi_awcache	(axi_awcache),
	.axi_awprot	(axi_awprot),
	.axi_awqos	(axi_awqos),
	.axi_awregion	(axi_awregion),
	.axi_awvalid	(axi_awvalid),
	.axi_awready	(axi_awready),
	.axi_wdata	(axi_wdata),
	.axi_wstrb	(axi_wstrb),
	.axi_wlast	(axi_wlast),
	.axi_wvalid	(axi_wvalid),
	.axi_wready	(axi_wready),
	.axi_bid	(axi_bid),
	.axi_bresp	(axi_bresp),
	.axi_bvalid	(axi_bvalid),
	.axi_bready	(axi_bready),
	.axi_arid	(axi_arid),
	.axi_araddr	(axi_araddr),
	.axi_arlen	(axi_arlen),
	.axi_arsize	(axi_arsize),
	.axi_arburst	(axi_arburst),
	.axi_arlock	(axi_arlock),
	.axi_arcache	(axi_arcache),
	.axi_arprot	(axi_arprot),
	.axi_arqos	(axi_arqos),
	.axi_arregion	(axi_arregion),
	.axi_arvalid	(axi_arvalid),
	.axi_arready	(axi_arready),
	.axi_rid	(axi_rid),
	.axi_rdata	(axi_rdata),
	.axi_rresp	(axi_rresp),
        .axi_rlast	(axi_rlast),
	.axi_rvalid	(axi_rvalid),
	.axi_rready	(axi_rready)	
);
//Custom Logic - Memory Checker 

memory_checker #(
  	.START_ADDR	(32'h10000000),
        .STOP_ADDR	(32'h10000300),
        .ASIZE		(2), 
	.ALEN		(1), 
	.COMPARE_WIDTH	(32) 
) ddrMaster_0 (                
	.axi_clk      (io_memoryClk),
        .rstn         (~io_ddrMasterReset),
        .start        (apb3MemoryStart),
        .aid          (mc_aid_0),
        .aaddr        (mc_aaddr_0),
        .alen         (mc_alen_0),
        .asize        (mc_asize_0),
        .aburst       (mc_aburst_0),
        .alock        (mc_alock_0),
        .avalid       (mc_avalid_0),
        .aready       (mc_aready_0),
        .atype        (mc_atype_0),
        .wid          (mc_wid_0),
        .wdata        (mc_wdata_0),
        .wstrb        (mc_wstrb_0),
        .wlast        (mc_wlast_0),
        .wvalid       (mc_wvalid_0),
        .wready       (mc_wready_0), 
        .rid          (mc_rid_0),
        .rdata        (mc_rdata_0),
        .rlast        (mc_rlast_0),
        .rvalid       (mc_rvalid_0),
        .rready       (mc_rready_0),
        .rresp        (mc_rresp_0),
        .bid          (mc_bid_0),
        .bvalid       (mc_bvalid_0),
        .bready       (mc_bready_0),
        .fail         (memoryFail),
        .done         (memoryCheckerDone),
	.states       ()
							
);

  `define CPU_COUNT 4

  wire             cpu_customInstruction_cmd_valid [0:`CPU_COUNT-1];
  wire             cpu_customInstruction_cmd_ready[0:`CPU_COUNT-1];
  wire    [9:0]    cpu_customInstruction_function_id[0:`CPU_COUNT-1];
  wire    [31:0]   cpu_customInstruction_inputs_0[0:`CPU_COUNT-1];
  wire    [31:0]   cpu_customInstruction_inputs_1[0:`CPU_COUNT-1];
  wire             cpu_customInstruction_rsp_valid[0:`CPU_COUNT-1];
  wire             cpu_customInstruction_rsp_ready[0:`CPU_COUNT-1];
  wire             cpu_customInstruction_response_ok[0:`CPU_COUNT-1];
  wire    [31:0]   cpu_customInstruction_outputs_0[0:`CPU_COUNT-1];


genvar i;
generate
    for (i=0; i<`CPU_COUNT; i=i+1) begin : aes_block // <-- example block name
      aes_instruction aes_instruction_0 (
       .clk(io_systemClk),
       .reset(io_systemReset),

       .cmd_valid(cpu_customInstruction_cmd_valid[i]),
       .cmd_ready(cpu_customInstruction_cmd_ready[i]),
       .cmd_function_id(cpu_customInstruction_function_id[i]),
       .cmd_inputs_0(cpu_customInstruction_inputs_0[i]),
       .cmd_inputs_1(cpu_customInstruction_inputs_1[i]),
       .rsp_valid(cpu_customInstruction_rsp_valid[i]),
       .rsp_ready(cpu_customInstruction_rsp_ready[i]),
       .rsp_response_ok(cpu_customInstruction_response_ok[i]),
       .rsp_outputs_0(cpu_customInstruction_outputs_0[i])
      );
end
endgenerate


reg video_reset_148_buf;
reg video_reset_148;

always@(posedge video_clk_148) begin
    video_reset_148_buf <= io_systemReset;
    video_reset_148 <= video_reset_148_buf;
end


wire              dma_hdmi_0_tvalid;
wire               dma_hdmi_0_tready;
wire     [31:0]   dma_hdmi_0_tdata;
wire     [3:0]    dma_hdmi_0_tkeep;
wire              dma_hdmi_0_tlast;

wire  [13:0]   io_dma_ctrl_PADDR;
wire  [0:0]    io_dma_ctrl_PSEL;
wire           io_dma_ctrl_PENABLE;
wire           io_dma_ctrl_PREADY;
wire           io_dma_ctrl_PWRITE;
wire  [31:0]   io_dma_ctrl_PWDATA;
wire  [31:0]   io_dma_ctrl_PRDATA;
wire           io_dma_ctrl_PSLVERROR;

dma_soc dma_soc_inst (
  .ctrl_PADDR(io_dma_ctrl_PADDR),
  .ctrl_PSEL(io_dma_ctrl_PSEL),
  .ctrl_PENABLE(io_dma_ctrl_PENABLE),
  .ctrl_PREADY(io_dma_ctrl_PREADY),
  .ctrl_PWRITE(io_dma_ctrl_PWRITE),
  .ctrl_PWDATA(io_dma_ctrl_PWDATA),
  .ctrl_PRDATA(io_dma_ctrl_PRDATA),
  .ctrl_PSLVERROR(io_dma_ctrl_PSLVERROR),
  .ctrl_interrupts(),
  .axi_arwvalid(dma_arwvalid),
  .axi_arwready(dma_arwready),
  .axi_arwaddr(dma_arwaddr),
  .axi_arwregion(),
  .axi_arwlen(dma_arwlen),
  .axi_arwsize(dma_arwsize),
  .axi_arwburst(dma_arwburst),
  .axi_arwlock(dma_arwlock),
  .axi_arwcache(),
  .axi_arwqos(),
  .axi_arwprot(),
  .axi_arwwrite(dma_arwwrite),
  .axi_wvalid(dma_wvalid),
  .axi_wready(dma_wready),
  .axi_wdata(dma_wdata),
  .axi_wstrb(dma_wstrb),
  .axi_wlast(dma_wlast),
  .axi_bvalid(dma_bvalid),
  .axi_bready(dma_bready),
  .axi_bresp(2'b00),
  .axi_rvalid(dma_rvalid),
  .axi_rready(dma_rready),
  .axi_rdata(dma_rdata),
  .axi_rresp(dma_rresp),
  .axi_rlast(dma_rlast),
  .hdmi_0_tvalid(dma_hdmi_0_tvalid),
  .hdmi_0_tready(dma_hdmi_0_tready),
  .hdmi_0_tdata(dma_hdmi_0_tdata),
  .hdmi_0_tkeep(dma_hdmi_0_tkeep),
  .hdmi_0_tlast(dma_hdmi_0_tlast),
  .clk(io_memoryClk),
  .reset(io_memoryReset),
  .ctrl_clk(io_systemClk),
  .ctrl_reset(io_systemReset),
  .hdmi_0_clk(video_clk_148),
  .hdmi_0_reset(video_reset_148)
);


  assign dma_arwid = 8'd0;
  assign dma_wid = 8'd0;

  wire              video_ctrl_vSync;
  wire              video_ctrl_hSync;
  wire              video_ctrl_colorEn;
  wire     [7:0]    video_ctrl_color_r;
  wire     [7:0]    video_ctrl_color_g;
  wire     [7:0]    video_ctrl_color_b;

video_ctrl_top video_ctrl_top_inst (
  .io_input_valid(dma_hdmi_0_tvalid),
  .io_input_ready(dma_hdmi_0_tready),
  .io_input_payload_data(dma_hdmi_0_tdata),
  .io_input_payload_mask(dma_hdmi_0_tkeep),
  .io_input_payload_last(dma_hdmi_0_tlast),
  .io_vga_vSync(video_ctrl_vSync),
  .io_vga_hSync(video_ctrl_hSync),
  .io_vga_colorEn(video_ctrl_colorEn),
  .io_vga_color_r(video_ctrl_color_r),
  .io_vga_color_g(video_ctrl_color_g),
  .io_vga_color_b(video_ctrl_color_b),
  .clk(video_clk_148),
  .reset(video_reset_148)
);

    reg [15:0] lolCounter;
  always @ (posedge video_clk_148) begin
    lolCounter <= lolCounter + 1;
    if(hdmi_vsync) lolCounter <= 0;
  end

/* RGB to YCbCr */
wire		w_de_out;
wire [7:0]	w_y_out;
wire [7:0]	w_cb_out;
wire [7:0]	w_cr_out;

reg			r_yuv_cnt;
reg			r_yuv_vs_1P ;
reg			r_yuv_hs_1P ;
reg			r_yuv_de_1P ;
reg			r_yuv_vs_2P ;
reg			r_yuv_hs_2P ;
reg			r_yuv_de_2P ;
reg			r_yuv_vs_3P ;
reg			r_yuv_hs_3P ;
reg			r_yuv_de_3P ;
reg			r_yuv_vs_4P ;
reg			r_yuv_hs_4P ;
reg			r_yuv_de_4P ;
reg			r_yuv_vs_5P ;
reg			r_yuv_hs_5P ;
reg			r_yuv_de_5P ;
reg			r_yuv_vs_6P ;
reg			r_yuv_hs_6P ;
reg			r_yuv_de_6P ;
reg			r_yuv_vs_7P ;
reg			r_yuv_hs_7P ;
reg			r_yuv_de_7P ;
reg	[7:0]	r_r_in;
reg	[7:0]	r_g_in;
reg	[7:0]	r_b_in;
reg	[15:0]	r_yuv_data_6P;
reg [7:0] 	r_yuv_x_cnt;
reg [7:0] 	r_yuv_y_cnt;
wire [7:0] 	r_yuv_xy_cnt;
reg			r_yuv_hs_out;
reg			r_yuv_vs_out;

// YCbCr video output
reg			yuv_vs;
reg			yuv_hs;
reg			yuv_de;
reg	[15:0]	yuv_data;

/* RGB to YCbCr */
color_coding_converter
#(
	.R_DEPTH(8),
	.G_DEPTH(8),
	.B_DEPTH(8),
	.Y_DEPTH(8),
	.U_DEPTH(8),
	.V_DEPTH(8)
)
inst_RGB_to_YCbCr_in0
(
	.i_arst		(video_reset_148	),
	.i_pclk		(video_clk_148	),

	.i_rgb2yuv_de	(video_ctrl_colorEn	),
	.i_rgb2yuv_r	(video_ctrl_color_r	),
	.i_rgb2yuv_g	(video_ctrl_color_g	),
	.i_rgb2yuv_b	(video_ctrl_color_b	),
	.o_rgb2yuv_de	(w_de_out	),
	.o_rgb2yuv_y	(w_y_out	),
	.o_rgb2yuv_u	(w_cb_out	),
	.o_rgb2yuv_v	(w_cr_out	),

	.i_yuv2rgb_de	(1'b0),
	.i_yuv2rgb_y	(8'b0),
	.i_yuv2rgb_u	(8'b0),
	.i_yuv2rgb_v	(8'b0),
	.o_yuv2rgb_de	(),
	.o_yuv2rgb_r	(),
	.o_yuv2rgb_g	(),
	.o_yuv2rgb_b	()
);


assign r_yuv_xy_cnt = r_yuv_x_cnt + r_yuv_y_cnt;

/* Remap 2 pixels per clock to odd and even yuv pixels */
always @(posedge video_clk_148)
begin
    if(video_reset_148)
	begin
		r_yuv_cnt		<= 1'b0;
		r_yuv_vs_1P     <= 1'b0;
		r_yuv_hs_1P     <= 1'b0;
		r_yuv_de_1P     <= 1'b0;
		r_yuv_vs_2P     <= 1'b0;
		r_yuv_hs_2P     <= 1'b0;
		r_yuv_de_2P     <= 1'b0;
		r_yuv_vs_3P     <= 1'b0;
		r_yuv_hs_3P     <= 1'b0;
		r_yuv_de_3P     <= 1'b0;
		r_yuv_vs_4P     <= 1'b0;
		r_yuv_hs_4P     <= 1'b0;
		r_yuv_de_4P     <= 1'b0;
		r_yuv_vs_5P     <= 1'b0;
		r_yuv_hs_5P     <= 1'b0;
		r_yuv_de_5P     <= 1'b0;
		r_yuv_vs_6P     <= 1'b0;
		r_yuv_hs_6P     <= 1'b0;
		r_yuv_de_6P     <= 1'b0;
		r_yuv_vs_7P     <= 1'b0;
		r_yuv_hs_7P     <= 1'b0;
		r_yuv_de_7P     <= 1'b0;
		r_yuv_x_cnt		<= 8'b0;
		r_yuv_y_cnt		<= 8'b0;
		r_yuv_hs_out    <= 1'b0;
		r_yuv_vs_out    <= 1'b0;
		r_yuv_data_6P	<= 16'b0;
	end
	else
	begin
		r_yuv_vs_1P     <= video_ctrl_vSync ;
		r_yuv_hs_1P     <= video_ctrl_hSync ;
		r_yuv_vs_2P     <= r_yuv_vs_1P ;
		r_yuv_hs_2P     <= r_yuv_hs_1P ;
		r_yuv_vs_3P     <= r_yuv_vs_2P ;
		r_yuv_hs_3P     <= r_yuv_hs_2P ;
		r_yuv_vs_4P     <= r_yuv_vs_3P ;
		r_yuv_hs_4P     <= r_yuv_hs_3P ;
		r_yuv_vs_5P     <= r_yuv_vs_4P ;
		r_yuv_hs_5P     <= r_yuv_hs_4P ;
		r_yuv_vs_6P     <= r_yuv_vs_5P ;
		r_yuv_hs_6P     <= r_yuv_hs_5P ;
		r_yuv_de_6P     <= w_de_out ;
		r_yuv_vs_7P     <= r_yuv_vs_6P ;
		r_yuv_hs_7P     <= r_yuv_hs_6P ;

		if (w_de_out)
		begin
			r_yuv_cnt	<= ~r_yuv_cnt;
			r_yuv_x_cnt	<= r_yuv_x_cnt + 1'b1;
		end
		else
		begin
			r_yuv_cnt	<= 1'b0;
			r_yuv_x_cnt	<= 8'b0;
		end

        if (r_yuv_vs_4P && !r_yuv_vs_5P) r_yuv_y_cnt	<= 8'b0-8'd41;
        if (r_yuv_hs_4P && !r_yuv_hs_5P)  r_yuv_y_cnt	<= r_yuv_y_cnt + 1'b1;

        if (r_yuv_cnt)
            r_yuv_data_6P    <= {w_cr_out, w_y_out};
        else
            r_yuv_data_6P    <= {w_cb_out, w_y_out};

		yuv_vs  	<= r_yuv_vs_6P;
		yuv_hs  	<= r_yuv_hs_6P;
		yuv_de  	<= r_yuv_de_6P;
		yuv_data	<= r_yuv_data_6P;
	end
end



assign hdmi_vsync = yuv_vs;
assign hdmi_hsync = yuv_hs;
assign hdmi_de = yuv_de;
assign hdmi_txd = yuv_data;





assign probes[0] = system_uart_0_io_txd;
assign probes[1] = hdmi_vsync;
assign probes[2] = hdmi_hsync;
assign probes[3] = hdmi_de;
assign probes[4] = dma_hdmi_0_tvalid;
assign probes[5] = dma_hdmi_0_tready;
assign probes[6] = system_i2c_0_io_sda_write;
assign probes[7] = system_i2c_0_io_scl_write;

//Marco Wu Added for Debug
/////////////////////////////////////////////////////////////////////////////

`define customInstructionConnect(id) \
  .cpu``id``_customInstruction_cmd_valid   (cpu_customInstruction_cmd_valid[``id``]), \
  .cpu``id``_customInstruction_cmd_ready   (cpu_customInstruction_cmd_ready[``id``]), \
  .cpu``id``_customInstruction_function_id (cpu_customInstruction_function_id[``id``]), \
  .cpu``id``_customInstruction_inputs_0    (cpu_customInstruction_inputs_0[``id``]), \
  .cpu``id``_customInstruction_inputs_1    (cpu_customInstruction_inputs_1[``id``]), \
  .cpu``id``_customInstruction_rsp_valid   (cpu_customInstruction_rsp_valid[``id``]), \
  .cpu``id``_customInstruction_rsp_ready   (cpu_customInstruction_rsp_ready[``id``]), \
  .cpu``id``_customInstruction_response_ok (cpu_customInstruction_response_ok[``id``]), \
  .cpu``id``_customInstruction_outputs_0   (cpu_customInstruction_outputs_0[``id``])


EfxRiscvBmbDdrSoc RubySoc_inst
(
  .io_systemClk				(io_systemClk),
  .io_asyncReset			(mcuReset),
  .io_memoryClk				(io_memoryClk),
  .io_memoryReset			(io_memoryReset), 		
  .system_uart_0_io_txd			(system_uart_0_io_txd),
  .system_uart_0_io_rxd			(system_uart_0_io_rxd),
  .system_uart_1_io_txd			(),
  .system_uart_1_io_rxd			(),
  .system_i2c_0_io_sda_write		(system_i2c_0_io_sda_write),
  .system_i2c_0_io_sda_read		(system_i2c_0_io_sda_read),
  .system_i2c_0_io_scl_write		(system_i2c_0_io_scl_write),
  .system_i2c_0_io_scl_read		(system_i2c_0_io_scl_read),
  .system_i2c_1_io_sda_write		(system_i2c_1_io_sda_write),
  .system_i2c_1_io_sda_read		(system_i2c_1_io_sda_read),
  .system_i2c_1_io_scl_write		(system_i2c_1_io_scl_write),
  .system_i2c_1_io_scl_read		(system_i2c_1_io_scl_read),
  .system_i2c_2_io_sda_write		(system_i2c_2_io_sda_write),
  .system_i2c_2_io_sda_read		(system_i2c_2_io_sda_read),
  .system_i2c_2_io_scl_write		(system_i2c_2_io_scl_write),
  .system_i2c_2_io_scl_read		(system_i2c_2_io_scl_read),
  .system_gpio_0_io_read		(system_gpio_0_io_read[3:0]),
  .system_gpio_0_io_write		(system_gpio_0_io_write[3:0]),
  .system_gpio_0_io_writeEnable		(system_gpio_0_io_writeEnable[3:0]),
  .io_apbSlave_0_PADDR			(io_apbSlave_0_PADDR),
  .io_apbSlave_0_PSEL			(io_apbSlave_0_PSEL),
  .io_apbSlave_0_PENABLE		(io_apbSlave_0_PENABLE),
  .io_apbSlave_0_PREADY			(io_apbSlave_0_PREADY),
  .io_apbSlave_0_PWRITE			(io_apbSlave_0_PWRITE),
  .io_apbSlave_0_PWDATA			(io_apbSlave_0_PWDATA),
  .io_apbSlave_0_PRDATA			(io_apbSlave_0_PRDATA),
  .io_apbSlave_0_PSLVERROR		(io_apbSlave_0_PSLVERROR),
  .io_dma_ctrl_PADDR			(io_dma_ctrl_PADDR),
  .io_dma_ctrl_PSEL			(io_dma_ctrl_PSEL),
  .io_dma_ctrl_PENABLE		(io_dma_ctrl_PENABLE),
  .io_dma_ctrl_PREADY			(io_dma_ctrl_PREADY),
  .io_dma_ctrl_PWRITE			(io_dma_ctrl_PWRITE),
  .io_dma_ctrl_PWDATA			(io_dma_ctrl_PWDATA),
  .io_dma_ctrl_PRDATA			(io_dma_ctrl_PRDATA),
  .io_dma_ctrl_PSLVERROR		(io_dma_ctrl_PSLVERROR),
  .userInterruptA			(userInterrupt),				
  .io_systemReset			(io_systemReset),		
  .io_ddrA_arw_valid			(io_ddrA_arw_valid),
  .io_ddrA_arw_ready			(io_ddrA_arw_ready),
  .io_ddrA_arw_payload_addr		(io_ddrA_arw_payload_addr),
  .io_ddrA_arw_payload_id		(io_ddrA_arw_payload_id),
  .io_ddrA_arw_payload_region		(io_ddrA_arw_payload_region),
  .io_ddrA_arw_payload_len		(io_ddrA_arw_payload_len),
  .io_ddrA_arw_payload_size		(io_ddrA_arw_payload_size),
  .io_ddrA_arw_payload_burst		(io_ddrA_arw_payload_burst),
  .io_ddrA_arw_payload_lock		(io_ddrA_arw_payload_lock),
  .io_ddrA_arw_payload_cache		(io_ddrA_arw_payload_cache),
  .io_ddrA_arw_payload_qos		(io_ddrA_arw_payload_qos),
  .io_ddrA_arw_payload_prot		(io_ddrA_arw_payload_prot),
  .io_ddrA_arw_payload_write		(io_ddrA_arw_payload_write),
  .io_ddrA_w_valid			(io_ddrA_w_valid),
  .io_ddrA_w_ready			(io_ddrA_w_ready),
  .io_ddrA_w_payload_data		(io_ddrA_w_payload_data),
  .io_ddrA_w_payload_strb		(io_ddrA_w_payload_strb),
  .io_ddrA_w_payload_last		(io_ddrA_w_payload_last),
  .io_ddrA_b_valid			(io_ddrA_b_valid),
  .io_ddrA_b_ready			(io_ddrA_b_ready),
  .io_ddrA_b_payload_id			(io_ddrA_b_payload_id),
  .io_ddrA_b_payload_resp		(io_ddrA_b_payload_resp),
  .io_ddrA_r_valid			(io_ddrA_r_valid),
  .io_ddrA_r_ready			(io_ddrA_r_ready),
  .io_ddrA_r_payload_data		(io_ddrA_r_payload_data),
  .io_ddrA_r_payload_id			(io_ddrA_r_payload_id),
  .io_ddrA_r_payload_resp		(io_ddrA_r_payload_resp),
  .io_ddrA_r_payload_last		(io_ddrA_r_payload_last),
  .io_ddrA_w_payload_id			(io_ddrA_w_payload_id),
  .io_ddrMasters_0_aw_valid		(ddr_awValid),
  .io_ddrMasters_0_aw_ready		(mc_awready_0),
  .io_ddrMasters_0_aw_payload_addr	(mc_aaddr_0),
  .io_ddrMasters_0_aw_payload_id	(mc_aid_0[3:0]),
  .io_ddrMasters_0_aw_payload_region	({4{1'b0}}),
  .io_ddrMasters_0_aw_payload_len	(mc_alen_0),
  .io_ddrMasters_0_aw_payload_size	(mc_asize_0),
  .io_ddrMasters_0_aw_payload_burst	(mc_aburst_0),
  .io_ddrMasters_0_aw_payload_lock	(mc_alock_0[0]),
  .io_ddrMasters_0_aw_payload_cache	({4{1'b0}}),
  .io_ddrMasters_0_aw_payload_qos	({4{1'b0}}),
  .io_ddrMasters_0_aw_payload_prot	({3{1'b0}}),
  .io_ddrMasters_0_w_valid		(mc_wvalid_0),
  .io_ddrMasters_0_w_ready		(mc_wready_0),
  .io_ddrMasters_0_w_payload_data	(mc_wdata_0[31:0]),
  .io_ddrMasters_0_w_payload_strb	(mc_wstrb_0[3:0]),
  .io_ddrMasters_0_w_payload_last	(mc_wlast_0),
  .io_ddrMasters_0_b_valid		(mc_bvalid_0),
  .io_ddrMasters_0_b_ready		(mc_bready_0),
  .io_ddrMasters_0_b_payload_id		(mc_bid_0[3:0]),
  .io_ddrMasters_0_b_payload_resp	(mc_bresp_0),
  .io_ddrMasters_0_ar_valid		(ddr_arValid),
  .io_ddrMasters_0_ar_ready		(mc_arready_0),
  .io_ddrMasters_0_ar_payload_addr	(mc_aaddr_0),
  .io_ddrMasters_0_ar_payload_id	(mc_aid_0[3:0]),
  .io_ddrMasters_0_ar_payload_region	({4{1'b0}}),
  .io_ddrMasters_0_ar_payload_len	(mc_alen_0),
  .io_ddrMasters_0_ar_payload_size	(mc_asize_0),
  .io_ddrMasters_0_ar_payload_burst	(mc_aburst_0),
  .io_ddrMasters_0_ar_payload_lock	(mc_alock_0[0]),
  .io_ddrMasters_0_ar_payload_cache	({4{1'b0}}),
  .io_ddrMasters_0_ar_payload_qos	({4{1'b0}}),
  .io_ddrMasters_0_ar_payload_prot	({3{1'b0}}),
  .io_ddrMasters_0_r_valid		(mc_rvalid_0),
  .io_ddrMasters_0_r_ready		(mc_rready_0),
  .io_ddrMasters_0_r_payload_data	(mc_rdata_0[31:0]),
  .io_ddrMasters_0_r_payload_id		(mc_rid_0[3:0]),
  .io_ddrMasters_0_r_payload_resp	(mc_rresp_0),
  .io_ddrMasters_0_r_payload_last	(mc_rlast_0),
  .io_ddrMasters_0_clk			(io_memoryClk),
  .io_ddrMasters_0_reset		(io_ddrMasterReset),
  .system_spi_0_io_sclk_write		(system_spi_0_io_sclk_write),
  .system_spi_0_io_data_0_writeEnable	(system_spi_0_io_data_0_writeEnable),
  .system_spi_0_io_data_0_read		(system_spi_0_io_data_0_read),
  .system_spi_0_io_data_0_write		(system_spi_0_io_data_0_write),
  .system_spi_0_io_data_1_writeEnable	(system_spi_0_io_data_1_writeEnable),
  .system_spi_0_io_data_1_read		(system_spi_0_io_data_1_read),
  .system_spi_0_io_data_1_write		(system_spi_0_io_data_1_write),
  .system_spi_0_io_data_2_writeEnable	(),
  .system_spi_0_io_data_2_read		(),
  .system_spi_0_io_data_2_write		(),
  .system_spi_0_io_data_3_writeEnable	(),
  .system_spi_0_io_data_3_read		(),
  .system_spi_0_io_data_3_write		(),
  .system_spi_0_io_ss			(system_spi_0_io_ss),
  .system_spi_1_io_sclk_write		(system_spi_1_io_sclk),
  .system_spi_1_io_data_0_writeEnable	(),
  .system_spi_1_io_data_0_read		(),
  .system_spi_1_io_data_0_write		(system_spi_1_io_data_0),
  .system_spi_1_io_data_1_writeEnable	(),
  .system_spi_1_io_data_1_read		(system_spi_1_io_data_1),
  .system_spi_1_io_data_1_write		(),
  .system_spi_1_io_data_2_writeEnable	(),
  .system_spi_1_io_data_2_read		(),
  .system_spi_1_io_data_2_write		(),
  .system_spi_1_io_data_3_writeEnable	(),
  .system_spi_1_io_data_3_read		(),
  .system_spi_1_io_data_3_write		(),
  .system_spi_1_io_ss			(system_spi_1_io_ss),
  .system_spi_2_io_sclk_write		(),
  .system_spi_2_io_data_0_writeEnable	(),
  .system_spi_2_io_data_0_read		(),
  .system_spi_2_io_data_0_write		(),
  .system_spi_2_io_data_1_writeEnable	(),
  .system_spi_2_io_data_1_read		(),
  .system_spi_2_io_data_1_write		(),
  .system_spi_2_io_data_2_writeEnable	(),
  .system_spi_2_io_data_2_read		(),
  .system_spi_2_io_data_2_write		(),
  .system_spi_2_io_data_3_writeEnable	(),
  .system_spi_2_io_data_3_read		(),
  .system_spi_2_io_data_3_write		(),
  .system_spi_2_io_ss			(),
  .axiA_awvalid				(axi_awvalid),
  .axiA_awready				(axi_awready),
  .axiA_awaddr				(axi_awaddr),
  .axiA_awid				(axi_awid),
  .axiA_awregion			(axi_awregion),
  .axiA_awlen				(axi_awlen),
  .axiA_awsize				(axi_awsize),
  .axiA_awburst				(axi_awburst),
  .axiA_awlock				(axi_awlock),
  .axiA_awcache				(axi_awcache),
  .axiA_awqos				(axi_awqos),
  .axiA_awprot				(axi_awprot),
  .axiA_wvalid				(axi_wvalid),
  .axiA_wready				(axi_wready),
  .axiA_wdata				(axi_wdata),
  .axiA_wstrb				(axi_wstrb),
  .axiA_wlast				(axi_wlast),
  .axiA_bvalid				(axi_bvalid),
  .axiA_bready				(axi_bready),
  .axiA_bid				(axi_bid),
  .axiA_bresp				(axi_bresp),
  .axiA_arvalid				(axi_arvalid),
  .axiA_arready				(axi_arready),
  .axiA_araddr				(axi_araddr),
  .axiA_arid				(axi_arid),
  .axiA_arregion			(axi_arregion),
  .axiA_arlen				(axi_arlen),
  .axiA_arsize				(axi_arsize),
  .axiA_arburst				(axi_arburst),
  .axiA_arlock				(axi_arlock),
  .axiA_arcache				(axi_arcache),
  .axiA_arqos				(axi_arqos),
  .axiA_arprot				(axi_arprot),
  .axiA_rvalid				(axi_rvalid),
  .axiA_rready				(axi_rready),
  .axiA_rdata				(axi_rdata),
  .axiA_rid				(axi_rid),
  .axiA_rresp				(axi_rresp),
  .axiA_rlast				(axi_rlast),
  .io_axiAInterrupt			(axi4Interrupt),	
  .jtagCtrl_tck				(jtag_inst1_TCK),
  .jtagCtrl_tdi				(jtag_inst1_TDI),
  .jtagCtrl_tdo				(jtag_inst1_TDO),
  .jtagCtrl_enable			(jtag_inst1_SEL),
  .jtagCtrl_capture			(jtag_inst1_CAPTURE),
  .jtagCtrl_shift			(jtag_inst1_SHIFT),
  .jtagCtrl_update			(jtag_inst1_UPDATE),
  .jtagCtrl_reset			(jtag_inst1_RESET),

  `customInstructionConnect(0),
  `customInstructionConnect(1),
  `customInstructionConnect(2),
  `customInstructionConnect(3)/*,
  `customInstructionConnect(4),
  `customInstructionConnect(5),
  `customInstructionConnect(6),
  `customInstructionConnect(7)*/
);

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// This   document  contains  proprietary information  which   is
// protected by  copyright. All rights  are reserved.  This notice
// refers to original work by Efinix, Inc. which may be derivitive
// of other work distributed under license of the authors.  In the
// case of derivative work, nothing in this notice overrides the
// original author's license agreement.  Where applicable, the 
// original license agreement is included in it's original 
// unmodified form immediately below this header.
//
// WARRANTY DISCLAIMER.  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND 
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH 
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES, 
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED 
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.
//
// LIMITATION OF LIABILITY.  
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY 
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT 
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY 
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT, 
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY 
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR 
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN 
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER 
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR 
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT 
//     APPLY TO LICENSEE.
//
/////////////////////////////////////////////////////////////////////////////
