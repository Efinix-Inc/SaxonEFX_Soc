
# Efinity Interface Designer SDC
# Version: 2021.2.323.4.6
# Date: 2022-10-25 14:09

# Copyright (C) 2017 - 2021 Efinix Inc. All rights reserved.

# Device: T120F324
# Project: t120f324_lpddr3_x16
# Timing Model: C4 (final)

# PLL Constraints
#################
create_clock -period 2.50 br0_pll_CLKOUT0
create_clock -period 15.00 axi_clk

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {br0_pll_clkin}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {br0_pll_clkin}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {br1_pll_clkin}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {br1_pll_clkin}]

# LVDS RX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {button_0}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {button_0}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {button_1}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {button_1}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led_0}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led_0}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led_1}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led_1}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[2]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[2]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[3]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[3]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[4]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[4]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[4]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[4]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[4]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[4]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[5]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[5]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[5]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[5]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[5]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[5]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[6]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[6]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[6]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[6]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[6]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[6]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_IN[7]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_IN[7]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OUT[7]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OUT[7]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pmod_A_OE[7]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pmod_A_OE[7]}]

# LVDS Rx Constraints
####################

# LVDS TX GPIO Constraints
############################
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pll_locked}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pll_locked}]

# LVDS Tx Constraints
####################

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {bscan_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {bscan_DRCK}]
set_output_delay -clock bscan_TCK -max 0.111 [get_ports {bscan_TDO}]
set_output_delay -clock bscan_TCK -min 0.053 [get_ports {bscan_TDO}]
set_input_delay -clock_fall -clock bscan_TCK -max 0.267 [get_ports {bscan_CAPTURE}]
set_input_delay -clock_fall -clock bscan_TCK -min 0.134 [get_ports {bscan_CAPTURE}]
set_input_delay -clock_fall -clock bscan_TCK -max 0.267 [get_ports {bscan_RESET}]
set_input_delay -clock_fall -clock bscan_TCK -min 0.134 [get_ports {bscan_RESET}]
set_input_delay -clock_fall -clock bscan_TCK -max 0.267 [get_ports {bscan_RUNTEST}]
set_input_delay -clock_fall -clock bscan_TCK -min 0.134 [get_ports {bscan_RUNTEST}]
set_input_delay -clock_fall -clock bscan_TCK -max 0.231 [get_ports {bscan_SEL}]
set_input_delay -clock_fall -clock bscan_TCK -min 0.116 [get_ports {bscan_SEL}]
set_input_delay -clock_fall -clock bscan_TCK -max 0.267 [get_ports {bscan_UPDATE}]
set_input_delay -clock_fall -clock bscan_TCK -min 0.134 [get_ports {bscan_UPDATE}]
set_input_delay -clock_fall -clock bscan_TCK -max 0.321 [get_ports {bscan_SHIFT}]
set_input_delay -clock_fall -clock bscan_TCK -min 0.161 [get_ports {bscan_SHIFT}]

# DDR Constraints
#####################
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_AADDR_1[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_AADDR_1[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_ABURST_1[1] ddr_inst1_ABURST_1[0]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_ABURST_1[1] ddr_inst1_ABURST_1[0]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_AID_1[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_AID_1[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_ALEN_1[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_ALEN_1[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_ALOCK_1[1] ddr_inst1_ALOCK_1[0]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_ALOCK_1[1] ddr_inst1_ALOCK_1[0]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_ASIZE_1[2] ddr_inst1_ASIZE_1[1] ddr_inst1_ASIZE_1[0]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_ASIZE_1[2] ddr_inst1_ASIZE_1[1] ddr_inst1_ASIZE_1[0]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_ATYPE_1}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_ATYPE_1}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_AVALID_1}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_AVALID_1}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_BREADY_1}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_BREADY_1}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_RREADY_1}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_RREADY_1}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_WDATA_1[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_WDATA_1[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_WID_1[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_WID_1[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_WLAST_1}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_WLAST_1}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_WSTRB_1[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_WSTRB_1[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {ddr_inst1_WVALID_1}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {ddr_inst1_WVALID_1}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_AREADY_1}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_AREADY_1}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_BID_1[*]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_BID_1[*]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_BVALID_1}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_BVALID_1}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_RDATA_1[*]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_RDATA_1[*]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_RID_1[*]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_RID_1[*]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_RLAST_1}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_RLAST_1}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_RRESP_1[1] ddr_inst1_RRESP_1[0]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_RRESP_1[1] ddr_inst1_RRESP_1[0]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_RVALID_1}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_RVALID_1}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {ddr_inst1_WREADY_1}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {ddr_inst1_WREADY_1}]