module top (

input button_0,  //switch 0 (SW6)
input button_1,

output led_0,
output led_1,

input  [7:0] pmod_A_IN,
output [7:0] pmod_A_OUT,
output [7:0] pmod_A_OE,

output [7:0] ddr_inst1_AID_1,
output [31:0] ddr_inst1_AADDR_1,
output [7:0] ddr_inst1_ALEN_1,
output [2:0] ddr_inst1_ASIZE_1,
output [1:0] ddr_inst1_ABURST_1,
output [1:0] ddr_inst1_ALOCK_1,
output ddr_inst1_AVALID_1,
input ddr_inst1_AREADY_1,
output ddr_inst1_ATYPE_1,

output [7:0] ddr_inst1_WID_1,
output [127:0] ddr_inst1_WDATA_1,
output [15:0] ddr_inst1_WSTRB_1,
output ddr_inst1_WLAST_1,
output ddr_inst1_WVALID_1,
input ddr_inst1_WREADY_1,


input [7:0] ddr_inst1_RID_1,
input [127:0] ddr_inst1_RDATA_1,
input ddr_inst1_RLAST_1,
input ddr_inst1_RVALID_1,
output ddr_inst1_RREADY_1,
input [1:0] ddr_inst1_RRESP_1,

input [7:0] ddr_inst1_BID_1,
input ddr_inst1_BVALID_1,
output ddr_inst1_BREADY_1,

input axi_clk,
input br0_pll_locked,
input br1_pll_locked,
output br0_pll_rstn,
output br1_pll_rstn,

// VIO interface
input           bscan_DRCK,
input           bscan_RESET,    
input           bscan_TMS,   
input           bscan_RUNTEST,    
input           bscan_SEL,    
input           bscan_SHIFT,    
input           bscan_TDI,    
input           bscan_CAPTURE,    
input           bscan_TCK,    
input           bscan_UPDATE,    
output          bscan_TDO

);


assign br0_pll_rstn = 1'b1;
assign br1_pll_rstn = 1'b1;
assign bscan_TDO = 1'b0;

wire rst = !button_0;
wire memoryReset;
wire systemReset;

//LSB to MSB => tck, tdi, tdo, tms, rx, tx
assign pmod_A_OE = 8'b00100100;
assign pmod_A_OUT[0] = 1'b0;
assign pmod_A_OUT[1] = 1'b0;
//assign pmod_A_OUT[2] = 1'b0;
assign pmod_A_OUT[3] = 1'b0;
assign pmod_A_OUT[4] = 1'b0;
//assign pmod_A_OUT[5] = 1'b0;
assign pmod_A_OUT[6] = 1'b0;
assign pmod_A_OUT[7] = 1'b0;

wire [15:0] system_gpio_0_io_read;
wire [15:0] system_gpio_0_io_write;
wire [15:0] system_gpio_0_io_writeEnable;

assign system_gpio_0_io_read = 16'h1234;

t120f324_SoC RubySoc_inst
(
    .io_systemClk(axi_clk),
    .io_asyncReset(rst),
    .io_memoryClk(axi_clk),
    .io_memoryReset(memoryReset),
    .io_systemReset(systemReset),
    .jtag_tms(pmod_A_IN[3]),
    .jtag_tdi(pmod_A_IN[1]),
    .jtag_tdo(pmod_A_OUT[2]),
    .jtag_tck(pmod_A_IN[0]),
    .io_ddrA_arw_valid(ddr_inst1_AVALID_1),
    .io_ddrA_arw_ready(ddr_inst1_AREADY_1),
    .io_ddrA_arw_payload_addr(ddr_inst1_AADDR_1),
    .io_ddrA_arw_payload_id(ddr_inst1_AID_1),
    .io_ddrA_arw_payload_len(ddr_inst1_ALEN_1),
    .io_ddrA_arw_payload_size(ddr_inst1_ASIZE_1),
    .io_ddrA_arw_payload_burst(ddr_inst1_ABURST_1),
    .io_ddrA_arw_payload_lock(ddr_inst1_ALOCK_1),
    .io_ddrA_arw_payload_write(ddr_inst1_ATYPE_1),
    .io_ddrA_w_valid(ddr_inst1_WVALID_1),
    .io_ddrA_w_ready(ddr_inst1_WREADY_1),
    .io_ddrA_w_payload_data(ddr_inst1_WDATA_1),
    .io_ddrA_w_payload_strb(ddr_inst1_WSTRB_1),
    .io_ddrA_w_payload_last(ddr_inst1_WLAST_1),
    .io_ddrA_b_valid(ddr_inst1_BVALID_1),
    .io_ddrA_b_ready(ddr_inst1_BREADY_1),
    .io_ddrA_b_payload_id(ddr_inst1_BID_1),
    .io_ddrA_b_payload_resp(2'b00),
    .io_ddrA_r_valid(ddr_inst1_RVALID_1),
    .io_ddrA_r_ready(ddr_inst1_RREADY_1),
    .io_ddrA_r_payload_data(ddr_inst1_RDATA_1),
    .io_ddrA_r_payload_id(ddr_inst1_RID_1),
    .io_ddrA_r_payload_resp(ddr_inst1_RRESP_1),
    .io_ddrA_r_payload_last(ddr_inst1_RLAST_1),
    .io_ddrA_w_payload_id(ddr_inst1_WID_1),
    .system_uart_0_io_txd(pmod_A_OUT[5]),
    .system_uart_0_io_rxd(pmod_A_IN[4]),
    .system_gpio_0_io_read(system_gpio_0_io_read),
    .system_gpio_0_io_write(system_gpio_0_io_write),
    .system_gpio_0_io_writeEnable(system_gpio_0_io_writeEnable)
);


endmodule
