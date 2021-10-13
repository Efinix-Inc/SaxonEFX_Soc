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


`define CPU_COUNT 1

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
  	output	      	my_pll_rstn,
  	input			my_pll_locked,
  	output	      	my_ddr_pll_rstn,
  	input			my_ddr_pll_locked,

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
  	input      [6:0]   	system_gpio_0_io_read,
  	output     [6:0]   	system_gpio_0_io_write,
  	output     [6:0]   	system_gpio_0_io_writeEnable,



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

    //input               system_rmii_0_io_clk,
    //output reg [1:0]    system_rmii_0_io_mii_TX_D,
    //output              system_rmii_0_io_mii_TX_EN,
    //input      [1:0]    system_rmii_0_io_mii_RX_D,
    //input               system_rmii_0_io_mii_RX_CRS_DV,

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
(* keep , syn_keep *) wire 	  io_memoryReset /* synthesis syn_keep = 1 */;				

/////////////////////////////////////////////////////////////////////////////
//Reset and PLL
assign mcuReset 	= ~( io_asyncReset & my_pll_locked & my_ddr_pll_locked );
assign my_pll_rstn 	= 1'b1;
assign my_ddr_pll_rstn 	= 1'b1;

/////////////////////////////////////////////////////////////////////////////

  wire             cpu_customInstruction_cmd_valid [0:`CPU_COUNT-1];
  wire             cpu_customInstruction_cmd_ready[0:`CPU_COUNT-1];
  wire    [9:0]    cpu_customInstruction_function_id[0:`CPU_COUNT-1];
  wire    [31:0]   cpu_customInstruction_inputs_0[0:`CPU_COUNT-1];
  wire    [31:0]   cpu_customInstruction_inputs_1[0:`CPU_COUNT-1];
  wire             cpu_customInstruction_rsp_valid[0:`CPU_COUNT-1];
  wire             cpu_customInstruction_rsp_ready[0:`CPU_COUNT-1];
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
       .rsp_outputs_0(cpu_customInstruction_outputs_0[i])
      );
end
endgenerate



assign probes[0] = system_uart_0_io_txd;
assign probes[1] = system_uart_0_io_rxd;
assign probes[2] = system_spi_1_io_ss;
assign probes[3] = hdmi_de;
assign probes[4] = cpu_customInstruction_rsp_ready[0];
assign probes[5] = cpu_customInstruction_rsp_valid[0];
assign probes[6] = cpu_customInstruction_cmd_ready[0];
assign probes[7] = cpu_customInstruction_cmd_valid[0];

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
  .cpu``id``_customInstruction_outputs_0   (cpu_customInstruction_outputs_0[``id``])


trion_cacheless RubySoc_inst
(
  .io_systemClk				(io_systemClk),
  .io_asyncReset			(mcuReset),
  .system_uart_0_io_txd			(system_uart_0_io_txd),
  .system_uart_0_io_rxd			(system_uart_0_io_rxd),
  .system_gpio_0_io_read		(system_gpio_0_io_read[6:0]),
  .system_gpio_0_io_write		(system_gpio_0_io_write[6:0]),
  .system_gpio_0_io_writeEnable		(system_gpio_0_io_writeEnable[6:0]),
  .io_systemReset			(io_systemReset),		
  .jtagCtrl_tck				(jtag_inst1_TCK),
  .jtagCtrl_tdi				(jtag_inst1_TDI),
  .jtagCtrl_tdo				(jtag_inst1_TDO),
  .jtagCtrl_enable			(jtag_inst1_SEL),
  .jtagCtrl_capture			(jtag_inst1_CAPTURE),
  .jtagCtrl_shift			(jtag_inst1_SHIFT),
  .jtagCtrl_update			(jtag_inst1_UPDATE),
  .jtagCtrl_reset			(jtag_inst1_RESET),
  `customInstructionConnect(0)/*
  `customInstructionConnect(1),
  `customInstructionConnect(2),
  `customInstructionConnect(3),
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
