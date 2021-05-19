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

// ------------------------------------------------------------------------------
// 1. User requires to manually uncomment SOFT_TAP definition and reassign pin for
// soft jtag pins
// 2. User requires to manually edit SDC constraint for clk
// ------------------------------------------------------------------------------
`include "hbram_define.v"


`define CPU_COUNT 1

`define customInstructionConnect(id) \
  .cpu``id``_customInstruction_cmd_valid   (cpu_customInstruction_cmd_valid[``id``]), \
  .cpu``id``_customInstruction_cmd_ready   (cpu_customInstruction_cmd_ready[``id``]), \
  .cpu``id``_customInstruction_function_id (cpu_customInstruction_function_id[``id``]), \
  .cpu``id``_customInstruction_inputs_0    (cpu_customInstruction_inputs_0[``id``]), \
  .cpu``id``_customInstruction_inputs_1    (cpu_customInstruction_inputs_1[``id``]), \
  .cpu``id``_customInstruction_rsp_valid   (cpu_customInstruction_rsp_valid[``id``]), \
  .cpu``id``_customInstruction_rsp_ready   (cpu_customInstruction_rsp_ready[``id``]), \
  .cpu``id``_customInstruction_outputs_0   (cpu_customInstruction_outputs_0[``id``])


module top (
    //user custom ports
    output       [3:0]  leds,

    input               uart_rxd,
    output              uart_txd,

    output              flash_sck,
    output              flash_ss,
    output              flash_mosi,
    input               flash_miso,

    output              sdcard_sck,
    output              sdcard_ss,
    output              sdcard_mosi,
    input               sdcard_miso,

    output      [7:0]   pmod,

    input               jtag_inst1_TCK,
    input               jtag_inst1_TDI,
    output              jtag_inst1_TDO,
    input               jtag_inst1_SEL,
    input               jtag_inst1_CAPTURE,
    input               jtag_inst1_SHIFT,
    input               jtag_inst1_UPDATE,
    input               jtag_inst1_RESET,

    //HBRAM PLL
    input                hbramClk,
    input                hbramClk_cal,
    input                 hbramClk_pll_locked,
    output                hbramClk_pll_rstn,
    output                sysClk_pll_rstn,
    //clk
    input                clk,
    input                io_asyncReset,
    //SOC
    output    [2:0]             hbc_cal_SHIFT,
    output    [4:0]             hbc_cal_SHIFT_SEL,
    output                      hbc_cal_SHIFT_ENA,
    output                      hbc_rst_n,
    output                      hbc_cs_n,
    output                      hbc_ck_p_HI,
    output                      hbc_ck_p_LO,
    output                      hbc_ck_n_HI,
    output                      hbc_ck_n_LO,
    output  [`RAM_DBW/8-1:0]    hbc_rwds_OUT_HI,
    output  [`RAM_DBW/8-1:0]    hbc_rwds_OUT_LO,
    input   [`RAM_DBW/8-1:0]    hbc_rwds_IN_HI,
    input   [`RAM_DBW/8-1:0]    hbc_rwds_IN_LO,
    output  [`RAM_DBW/8-1:0]    hbc_rwds_OE,
    output  [`RAM_DBW-1:0]      hbc_dq_OUT_HI,
    output  [`RAM_DBW-1:0]      hbc_dq_OUT_LO,
    input   [`RAM_DBW-1:0]      hbc_dq_IN_LO,
    input   [`RAM_DBW-1:0]      hbc_dq_IN_HI,
    output  [`RAM_DBW-1:0]      hbc_dq_OE
);

wire                        memoryCheckerDone;
wire                        memoryCheckerPass;
wire                        hbc_cal_pass;

/////////////////////////////////////////////////////////////////////////////
//DDR Control Workaround
wire                        reset;
wire                        start;
wire                        memoryFail;
wire                        io_arw_valid;
wire                        io_arw_ready;
wire    [31:0]              io_arw_payload_addr;
wire    [7:0]               io_arw_payload_id;
wire    [7:0]               io_arw_payload_len;
wire    [2:0]               io_arw_payload_size;
wire    [1:0]               io_arw_payload_burst;
wire    [1:0]               io_arw_payload_lock;
wire                        io_arw_payload_write;
wire    [7:0]               io_w_payload_id;
wire                        io_w_valid;
wire                        io_w_ready;
wire    [`AXI_DBW-1:0]          io_w_payload_data;
wire    [`AXI_DBW/8-1:0]           io_w_payload_strb;
wire                        io_w_payload_last;
wire                        io_b_valid;
wire                        io_b_ready;
wire    [7:0]               io_b_payload_id;
wire                        io_r_valid;
wire                        io_r_ready;
wire    [`AXI_DBW-1:0]          io_r_payload_data;
wire    [7:0]               io_r_payload_id;
wire    [1:0]               io_r_payload_resp;
wire                        io_r_payload_last;
wire    [1:0]                io_b_payload_resp;

/////////////////////////////////////////////////////////////////////////////
`ifdef SIM
localparam STOP_ADDRESS = 'h00002000;
`else
localparam STOP_ADDRESS = 'h01FFE000;
`endif
localparam ASIZE_DEC     = (`AXI_DBW == 64)  ? 3 : 
              (`AXI_DBW == 128) ? 4 : 
              (`AXI_DBW == 256) ? 5 : 2;
//Reset and PLL
assign reset          = ~( io_asyncReset & hbramClk_pll_locked);
assign hbramClk_pll_rstn = 1'b1;
assign sysClk_pll_rstn   = 1'b1;
//MemoryChecker
//assign start_mem_checker = start & hbc_cal_pass; 
assign start_mem_checker = start ; 
assign memoryCheckerPass = memoryCheckerDone & ~memoryFail;
//DDR controller
assign io_b_payload_resp = 2'b00;
/////////////////////////////////////////////////////////////////////////////

hbram_top #(
    .RAM_DBW        (`RAM_DBW        ),
    .RAM_ABW        (`RAM_ABW        ),
    .CFG_CR0        (`CR0            ),
    .CFG_CR1        (`CR1            ),
    .AXI_DBW        (`AXI_DBW        ),
    .AXI_AWR_DEPTH         (`AXI_AWR_DEPTH        ),
    .AXI_W_DEPTH           (`AXI_W_DEPTH        ),
    .AXI_R_DEPTH        (`AXI_R_DEPTH        ),
    .DQIN_MODE        (`DQIN_MODE        ),
        .CAL_CLK_CH         (`CAL_CLK_CH        ),
    .TCYC            (`tCYC            ),
    .TCSM            (`tCSM            ),
    .TVCS            (`tVCS            ),
    .TRH            (`tRH            ),
    .TRTR            (`tRTR            )
) hbram_top_inst (
    .rst            (soc_io_memoryReset            ),
    .ram_clk                  (hbramClk               ), 
    .ram_clk_cal        (hbramClk_cal        ),
    .io_axi_clk        (clk            ),
    .io_arw_valid        (io_arw_valid        ),
        .io_arw_ready        (io_arw_ready        ),
        .io_arw_payload_addr    (io_arw_payload_addr    ),
        .io_arw_payload_id    (io_arw_payload_id    ),
        .io_arw_payload_len    (io_arw_payload_len    ),
        .io_arw_payload_size    (io_arw_payload_size    ),
        .io_arw_payload_burst    (io_arw_payload_burst    ),
        .io_arw_payload_lock    (io_arw_payload_lock    ),
        .io_arw_payload_write    (io_arw_payload_write    ),
        .io_w_payload_id    (io_w_payload_id    ),
        .io_w_valid        (io_w_valid        ),
        .io_w_ready        (io_w_ready        ),
        .io_w_payload_data    (io_w_payload_data    ),
        .io_w_payload_strb    (io_w_payload_strb    ),
        .io_w_payload_last    (io_w_payload_last    ),
        .io_b_valid        (io_b_valid        ),
        .io_b_ready        (io_b_ready        ),
        .io_b_payload_id    (io_b_payload_id    ),
        .io_r_valid        (io_r_valid        ),
        .io_r_ready        (io_r_ready        ),
        .io_r_payload_data    (io_r_payload_data    ),
        .io_r_payload_id    (io_r_payload_id    ),
        .io_r_payload_resp    (io_r_payload_resp    ),
        .io_r_payload_last    (io_r_payload_last    ),
    .hbc_cal_SHIFT_ENA    (hbc_cal_SHIFT_ENA    ),
    .hbc_cal_SHIFT        (hbc_cal_SHIFT        ),
    .hbc_cal_SHIFT_SEL    (hbc_cal_SHIFT_SEL    ),
    .hbc_cal_pass        (hbc_cal_pass        ),
    .hbc_cal_debug_info    (            ),
    .hbc_rst_n            (hbc_rst_n              ), 
    .hbc_cs_n             (hbc_cs_n               ),
    .hbc_pcs_p_HI         (            ),
    .hbc_pcs_p_LO         (            ),
    .hbc_pcs_n_HI         (            ),
    .hbc_pcs_n_LO         (            ),
    .hbc_ck_p_HI          (hbc_ck_p_HI            ),
    .hbc_ck_p_LO          (hbc_ck_p_LO            ),
    .hbc_ck_n_HI          (hbc_ck_n_HI            ),
    .hbc_ck_n_LO          (hbc_ck_n_LO            ),
    .hbc_rwds_OUT_HI      (hbc_rwds_OUT_HI        ),
    .hbc_rwds_OUT_LO      (hbc_rwds_OUT_LO        ),
    .hbc_rwds_IN_HI          (hbc_rwds_IN_HI         ),
    .hbc_rwds_IN_LO          (hbc_rwds_IN_LO         ),
    .hbc_rwds_OE          (hbc_rwds_OE            ),
    .hbc_dq_OUT_HI        (hbc_dq_OUT_HI          ),
    .hbc_dq_OUT_LO        (hbc_dq_OUT_LO          ),
    .hbc_dq_IN_HI         (hbc_dq_IN_HI            ),
    .hbc_dq_IN_LO         (hbc_dq_IN_LO        ),
    .hbc_dq_OE            (hbc_dq_OE              )
);



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
       .clk(clk),
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



wire          soc_jtagCtrl_tck;
wire          soc_io_asyncReset;
wire          soc_io_memoryReset;
wire          soc_jtagCtrl_tdi;
wire          soc_jtagCtrl_enable;
wire          soc_jtagCtrl_capture;
wire          soc_jtagCtrl_shift;
wire          soc_jtagCtrl_update;
wire          soc_jtagCtrl_reset;
wire          soc_jtagCtrl_tdo;
wire          soc_io_systemReset;
wire          soc_io_ddrA_arw_valid;
wire          soc_io_ddrA_arw_ready;
wire [31:0]   soc_io_ddrA_arw_payload_addr;
wire [7:0]    soc_io_ddrA_arw_payload_id;
wire [3:0]    soc_io_ddrA_arw_payload_region;
wire [7:0]    soc_io_ddrA_arw_payload_len;
wire [2:0]    soc_io_ddrA_arw_payload_size;
wire [1:0]    soc_io_ddrA_arw_payload_burst;
wire [0:0]    soc_io_ddrA_arw_payload_lock;
wire [3:0]    soc_io_ddrA_arw_payload_cache;
wire [3:0]    soc_io_ddrA_arw_payload_qos;
wire [2:0]    soc_io_ddrA_arw_payload_prot;
wire          soc_io_ddrA_arw_payload_write;
wire          soc_io_ddrA_w_valid;
wire           soc_io_ddrA_w_ready;
wire [127:0]  soc_io_ddrA_w_payload_data;
wire [15:0]   soc_io_ddrA_w_payload_strb;
wire          soc_io_ddrA_w_payload_last;
wire           soc_io_ddrA_b_valid;
wire          soc_io_ddrA_b_ready;
wire  [7:0]    soc_io_ddrA_b_payload_id;
wire  [1:0]    soc_io_ddrA_b_payload_resp;
wire           soc_io_ddrA_r_valid;
wire          soc_io_ddrA_r_ready;
wire  [127:0]  soc_io_ddrA_r_payload_data;
wire  [7:0]    soc_io_ddrA_r_payload_id;
wire  [1:0]    soc_io_ddrA_r_payload_resp;
wire           soc_io_ddrA_r_payload_last;
wire [7:0]    soc_io_ddrA_w_payload_id;
wire          soc_system_uart_0_io_txd;
wire           soc_system_uart_0_io_rxd;
wire  [15:0]   soc_system_gpio_0_io_read;
wire [15:0]   soc_system_gpio_0_io_write;
wire [15:0]   soc_system_gpio_0_io_writeEnable;
wire [0:0]    soc_system_spi_0_io_sclk_write;
wire          soc_system_spi_0_io_data_0_writeEnable;
wire  [0:0]    soc_system_spi_0_io_data_0_read;
wire [0:0]    soc_system_spi_0_io_data_0_write;
wire          soc_system_spi_0_io_data_1_writeEnable;
wire  [0:0]    soc_system_spi_0_io_data_1_read;
wire [0:0]    soc_system_spi_0_io_data_1_write;
wire          soc_system_spi_0_io_data_2_writeEnable;
wire  [0:0]    soc_system_spi_0_io_data_2_read;
wire [0:0]    soc_system_spi_0_io_data_2_write;
wire          soc_system_spi_0_io_data_3_writeEnable;
wire  [0:0]    soc_system_spi_0_io_data_3_read;
wire [0:0]    soc_system_spi_0_io_data_3_write;
wire [0:0]    soc_system_spi_0_io_ss;
wire [0:0]    soc_system_spi_1_io_sclk_write;
wire          soc_system_spi_1_io_data_0_writeEnable;
wire  [0:0]    soc_system_spi_1_io_data_0_read;
wire [0:0]    soc_system_spi_1_io_data_0_write;
wire          soc_system_spi_1_io_data_1_writeEnable;
wire  [0:0]    soc_system_spi_1_io_data_1_read;
wire [0:0]    soc_system_spi_1_io_data_1_write;
wire          soc_system_spi_1_io_data_2_writeEnable;
wire  [0:0]    soc_system_spi_1_io_data_2_read;
wire [0:0]    soc_system_spi_1_io_data_2_write;
wire          soc_system_spi_1_io_data_3_writeEnable;
wire  [0:0]    soc_system_spi_1_io_data_3_read;
wire [0:0]    soc_system_spi_1_io_data_3_write;
wire [0:0]    soc_system_spi_1_io_ss;



EfxRiscvBmbDdrSoc soc (

  `customInstructionConnect(0),
  //`customInstructionConnect(1),
  //`customInstructionConnect(2),
  //`customInstructionConnect(3),
  //`customInstructionConnect(4),
  //`customInstructionConnect(5),
  //`customInstructionConnect(6),
  //`customInstructionConnect(7),

  .jtagCtrl_tck(soc_jtagCtrl_tck),
  .io_systemClk(clk),
  .io_asyncReset(soc_io_asyncReset),
  .io_memoryClk(clk),
  .io_memoryReset(soc_io_memoryReset),
  .jtagCtrl_tdi(soc_jtagCtrl_tdi),
  .jtagCtrl_enable(soc_jtagCtrl_enable),
  .jtagCtrl_capture(soc_jtagCtrl_capture),
  .jtagCtrl_shift(soc_jtagCtrl_shift),
  .jtagCtrl_update(soc_jtagCtrl_update),
  .jtagCtrl_reset(soc_jtagCtrl_reset),
  .jtagCtrl_tdo(soc_jtagCtrl_tdo),
  .io_systemReset(soc_io_systemReset),
  .io_ddrA_arw_valid(soc_io_ddrA_arw_valid),
  .io_ddrA_arw_ready(soc_io_ddrA_arw_ready),
  .io_ddrA_arw_payload_addr(soc_io_ddrA_arw_payload_addr),
  .io_ddrA_arw_payload_id(soc_io_ddrA_arw_payload_id),
  .io_ddrA_arw_payload_region(soc_io_ddrA_arw_payload_region),
  .io_ddrA_arw_payload_len(soc_io_ddrA_arw_payload_len),
  .io_ddrA_arw_payload_size(soc_io_ddrA_arw_payload_size),
  .io_ddrA_arw_payload_burst(soc_io_ddrA_arw_payload_burst),
  .io_ddrA_arw_payload_lock(soc_io_ddrA_arw_payload_lock),
  .io_ddrA_arw_payload_cache(soc_io_ddrA_arw_payload_cache),
  .io_ddrA_arw_payload_qos(soc_io_ddrA_arw_payload_qos),
  .io_ddrA_arw_payload_prot(soc_io_ddrA_arw_payload_prot),
  .io_ddrA_arw_payload_write(soc_io_ddrA_arw_payload_write),
  .io_ddrA_w_valid(soc_io_ddrA_w_valid),
  .io_ddrA_w_ready(soc_io_ddrA_w_ready),
  .io_ddrA_w_payload_data(soc_io_ddrA_w_payload_data),
  .io_ddrA_w_payload_strb(soc_io_ddrA_w_payload_strb),
  .io_ddrA_w_payload_last(soc_io_ddrA_w_payload_last),
  .io_ddrA_b_valid(soc_io_ddrA_b_valid),
  .io_ddrA_b_ready(soc_io_ddrA_b_ready),
  .io_ddrA_b_payload_id(soc_io_ddrA_b_payload_id),
  .io_ddrA_b_payload_resp(soc_io_ddrA_b_payload_resp),
  .io_ddrA_r_valid(soc_io_ddrA_r_valid),
  .io_ddrA_r_ready(soc_io_ddrA_r_ready),
  .io_ddrA_r_payload_data(soc_io_ddrA_r_payload_data),
  .io_ddrA_r_payload_id(soc_io_ddrA_r_payload_id),
  .io_ddrA_r_payload_resp(soc_io_ddrA_r_payload_resp),
  .io_ddrA_r_payload_last(soc_io_ddrA_r_payload_last),
  .io_ddrA_w_payload_id(soc_io_ddrA_w_payload_id),
  .system_uart_0_io_txd(soc_system_uart_0_io_txd),
  .system_uart_0_io_rxd(soc_system_uart_0_io_rxd),
  .system_gpio_0_io_read(soc_system_gpio_0_io_read),
  .system_gpio_0_io_write(soc_system_gpio_0_io_write),
  .system_gpio_0_io_writeEnable(soc_system_gpio_0_io_writeEnable),
  .system_spi_0_io_sclk_write(soc_system_spi_0_io_sclk_write),
  .system_spi_0_io_data_0_writeEnable(soc_system_spi_0_io_data_0_writeEnable),
  .system_spi_0_io_data_0_read(soc_system_spi_0_io_data_0_read),
  .system_spi_0_io_data_0_write(soc_system_spi_0_io_data_0_write),
  .system_spi_0_io_data_1_writeEnable(soc_system_spi_0_io_data_1_writeEnable),
  .system_spi_0_io_data_1_read(soc_system_spi_0_io_data_1_read),
  .system_spi_0_io_data_1_write(soc_system_spi_0_io_data_1_write),
  .system_spi_0_io_data_2_writeEnable(soc_system_spi_0_io_data_2_writeEnable),
  .system_spi_0_io_data_2_read(soc_system_spi_0_io_data_2_read),
  .system_spi_0_io_data_2_write(soc_system_spi_0_io_data_2_write),
  .system_spi_0_io_data_3_writeEnable(soc_system_spi_0_io_data_3_writeEnable),
  .system_spi_0_io_data_3_read(soc_system_spi_0_io_data_3_read),
  .system_spi_0_io_data_3_write(soc_system_spi_0_io_data_3_write),
  .system_spi_0_io_ss(soc_system_spi_0_io_ss),
  .system_spi_1_io_sclk_write(soc_system_spi_1_io_sclk_write),
  .system_spi_1_io_data_0_writeEnable(soc_system_spi_1_io_data_0_writeEnable),
  .system_spi_1_io_data_0_read(soc_system_spi_1_io_data_0_read),
  .system_spi_1_io_data_0_write(soc_system_spi_1_io_data_0_write),
  .system_spi_1_io_data_1_writeEnable(soc_system_spi_1_io_data_1_writeEnable),
  .system_spi_1_io_data_1_read(soc_system_spi_1_io_data_1_read),
  .system_spi_1_io_data_1_write(soc_system_spi_1_io_data_1_write),
  .system_spi_1_io_data_2_writeEnable(soc_system_spi_1_io_data_2_writeEnable),
  .system_spi_1_io_data_2_read(soc_system_spi_1_io_data_2_read),
  .system_spi_1_io_data_2_write(soc_system_spi_1_io_data_2_write),
  .system_spi_1_io_data_3_writeEnable(soc_system_spi_1_io_data_3_writeEnable),
  .system_spi_1_io_data_3_read(soc_system_spi_1_io_data_3_read),
  .system_spi_1_io_data_3_write(soc_system_spi_1_io_data_3_write),
  .system_spi_1_io_ss(soc_system_spi_1_io_ss)
);

assign soc_io_asyncReset = reset;


assign io_arw_valid            = soc_io_ddrA_arw_valid;
assign io_arw_payload_addr    = soc_io_ddrA_arw_payload_addr;
assign io_arw_payload_id    = soc_io_ddrA_arw_payload_id;
assign io_arw_payload_len    = soc_io_ddrA_arw_payload_len;
assign io_arw_payload_size    = soc_io_ddrA_arw_payload_size;
assign io_arw_payload_burst    = soc_io_ddrA_arw_payload_burst;
assign io_arw_payload_lock    = soc_io_ddrA_arw_payload_lock;
assign io_arw_payload_write    = soc_io_ddrA_arw_payload_write;
assign io_w_valid            = soc_io_ddrA_w_valid;
assign io_w_payload_id        = soc_io_ddrA_w_payload_id;
assign io_w_payload_data    = soc_io_ddrA_w_payload_data;
assign io_w_payload_strb    = soc_io_ddrA_w_payload_strb;
assign io_w_payload_last    = soc_io_ddrA_w_payload_last;
assign io_b_ready            = soc_io_ddrA_b_ready;
assign io_r_ready            = soc_io_ddrA_r_ready;

assign soc_io_ddrA_arw_ready       = io_arw_ready;
assign soc_io_ddrA_w_ready         = io_w_ready;
assign soc_io_ddrA_b_valid         = io_b_valid;
assign soc_io_ddrA_b_payload_id    = io_b_payload_id;
assign soc_io_ddrA_r_valid         = io_r_valid;
assign soc_io_ddrA_r_payload_data  = io_r_payload_data;
assign soc_io_ddrA_r_payload_id    = io_r_payload_id;
assign soc_io_ddrA_r_payload_resp  = io_r_payload_resp;
assign soc_io_ddrA_r_payload_last  = io_r_payload_last;

assign soc_jtagCtrl_tck = jtag_inst1_TCK;
assign soc_jtagCtrl_tdi = jtag_inst1_TDI;
assign soc_jtagCtrl_enable = jtag_inst1_SEL;
assign soc_jtagCtrl_capture = jtag_inst1_CAPTURE;
assign soc_jtagCtrl_shift = jtag_inst1_SHIFT;
assign soc_jtagCtrl_update = jtag_inst1_UPDATE;
assign soc_jtagCtrl_reset = jtag_inst1_RESET;
assign jtag_inst1_TDO = soc_jtagCtrl_tdo;

assign soc_system_uart_0_io_rxd = uart_rxd;
assign uart_txd = soc_system_uart_0_io_txd;


assign flash_sck  = soc_system_spi_0_io_sclk_write;
assign flash_ss   = soc_system_spi_0_io_ss;
assign flash_mosi = soc_system_spi_0_io_data_0_write;
assign soc_system_spi_0_io_data_1_read = flash_miso;

assign sdcard_sck  = soc_system_spi_1_io_sclk_write;
assign sdcard_ss   = soc_system_spi_1_io_ss;
assign sdcard_mosi = soc_system_spi_1_io_data_0_write;
assign soc_system_spi_1_io_data_1_read = sdcard_miso;

assign leds[3:0] = {soc_system_gpio_0_io_write[2:0], hbc_cal_pass};
assign pmod[0] = io_arw_valid;
assign pmod[1] = io_w_valid;
assign pmod[2] = io_b_valid;
assign pmod[3] = io_r_valid;
assign pmod[4] = io_arw_ready;
assign pmod[5] = io_w_ready;
assign pmod[6] = io_b_ready;
assign pmod[7] = io_r_ready;


/*
memory_checker #(
      .START_ADDR    (32'h00000000),
        .STOP_ADDR    (STOP_ADDRESS),
        .ASIZE        (ASIZE_DEC), 
    .ALEN        (255), 
    .COMPARE_WIDTH    (`AXI_DBW)
) ddrMaster_0 (                
    .axi_clk          (clk            ),
        .rstn             (~reset            ),
        .start            (start_mem_checker    ),
        .aid              (io_arw_payload_id    ),
        .aaddr            (io_arw_payload_addr    ),
        .alen             (io_arw_payload_len    ),
        .asize            (io_arw_payload_size    ),
        .aburst           (io_arw_payload_burst    ),
        .alock            (io_arw_payload_lock    ),
        .avalid           (io_arw_valid        ),
        .aready           (io_arw_ready        ),
        .atype            (io_arw_payload_write    ),
        .wid              (io_w_payload_id    ),
        .wdata            (io_w_payload_data    ),
        .wstrb            (io_w_payload_strb    ),
        .wlast            (io_w_payload_last    ),
        .wvalid           (io_w_valid        ),
        .wready           (io_w_ready        ), 
        .rid              (io_r_payload_id    ),
        .rdata            (io_r_payload_data    ),
        .rlast            (io_r_payload_last    ),
        .rvalid           (io_r_valid        ),
        .rready           (io_r_ready        ),
        .rresp            (io_r_payload_resp    ),
        .bid              (io_b_payload_id    ),
        .bvalid           (io_b_valid        ),
        .bready           (io_b_ready        ),
        .fail             (memoryFail        ),
        .done             (memoryCheckerDone    ),
    .states           ()
                            
);

memory_checker_start #(
    .MHZ(100),
    .SECOND(3)
) u_memory_checker_start (

    .clk        (clk    ),
    .rst_n        (~reset    ),
    .start        (start    )
);*/

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
