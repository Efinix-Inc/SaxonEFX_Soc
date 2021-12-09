# PLL Constraints
#################
create_clock -period 2.50 my_ddr_pll_CLKOUT0
create_clock -period 15.0 io_systemClk
create_clock -period 25.0 jtag_inst1_TCK

# False Path
#################
set_clock_groups -exclusive -group {io_systemClk} -group {jtag_inst1_TCK}
set_clock_groups -exclusive -group {io_systemClk io_memoryClk} -group {video_clk_148}




# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_uart_0_io_rxd}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_uart_0_io_rxd}]
set_output_delay -clock io_systemClk -max -4.700 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_systemClk -min -2.571 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_systemClk -max -4.700 [get_ports {system_spi_0_io_ss}]
set_output_delay -clock io_systemClk -min -2.571 [get_ports {system_spi_0_io_ss}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_uart_0_io_txd}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_uart_0_io_txd}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_0_io_scl_read}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_0_io_scl_read}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_0_io_scl_write}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_0_io_scl_write}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_0_io_scl_writeEnable}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_0_io_scl_writeEnable}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_0_io_sda_read}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_0_io_sda_read}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_0_io_sda_write}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_0_io_sda_write}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_0_io_sda_writeEnable}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_0_io_sda_writeEnable}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_1_io_scl_read}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_1_io_scl_read}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_1_io_scl_write}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_1_io_scl_write}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_1_io_scl_writeEnable}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_1_io_scl_writeEnable}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_1_io_sda_read}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_1_io_sda_read}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_1_io_sda_write}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_1_io_sda_write}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_i2c_1_io_sda_writeEnable}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_i2c_1_io_sda_writeEnable}]
set_input_delay -clock io_systemClk -max 6.168 [get_ports {system_spi_0_io_data_0_read}]
set_input_delay -clock io_systemClk -min 3.084 [get_ports {system_spi_0_io_data_0_read}]
set_output_delay -clock io_systemClk -max -4.700 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_systemClk -min -2.571 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_systemClk -max -4.707 [get_ports {system_spi_0_io_data_0_writeEnable}]
set_output_delay -clock io_systemClk -min -2.567 [get_ports {system_spi_0_io_data_0_writeEnable}]
set_input_delay -clock io_systemClk -max 6.168 [get_ports {system_spi_0_io_data_1_read}]
set_input_delay -clock io_systemClk -min 3.084 [get_ports {system_spi_0_io_data_1_read}]
set_output_delay -clock io_systemClk -max -4.700 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_systemClk -min -2.571 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_systemClk -max -4.707 [get_ports {system_spi_0_io_data_1_writeEnable}]
set_output_delay -clock io_systemClk -min -2.567 [get_ports {system_spi_0_io_data_1_writeEnable}]

# LVDS TX GPIO Constraints
############################
set_input_delay -clock io_systemClk -max 6.100 [get_ports {system_spi_1_io_data_1}]
set_input_delay -clock io_systemClk -min 3.050 [get_ports {system_spi_1_io_data_1}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[4]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[4]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[5]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[5]}]
set_output_delay -clock io_systemClk -max -5.210 [get_ports {system_spi_1_io_data_0}]
set_output_delay -clock io_systemClk -min -2.480 [get_ports {system_spi_1_io_data_0}]
set_output_delay -clock io_systemClk -max -5.210 [get_ports {system_spi_1_io_sclk}]
set_output_delay -clock io_systemClk -min -2.480 [get_ports {system_spi_1_io_sclk}]
set_output_delay -clock io_systemClk -max -5.210 [get_ports {system_spi_1_io_ss}]
set_output_delay -clock io_systemClk -min -2.480 [get_ports {system_spi_1_io_ss}]

# LVDS Rx Constraints
####################

# LVDS TX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {io_asyncReset}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {io_asyncReset}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_de}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_de}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_hsync}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_hsync}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[0]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[0]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[1]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[1]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[2]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[2]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[3]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[3]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[4]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[4]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[5]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[5]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[6]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[6]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[7]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[7]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[8]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[8]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[9]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[9]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[10]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[10]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[11]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[11]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[12]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[12]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[13]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[13]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[14]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[14]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_txd[15]}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_txd[15]}]
set_output_delay -clock video_clk_148 -max -5.210 [get_ports {hdmi_vsync}]
set_output_delay -clock video_clk_148 -min -2.480 [get_ports {hdmi_vsync}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[6]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[6]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {probes[7]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {probes[7]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_read[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_read[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_write[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_write[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_writeEnable[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_writeEnable[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_read[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_read[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_write[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_write[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_writeEnable[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_writeEnable[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_read[2]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_read[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_write[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_write[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_writeEnable[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_writeEnable[2]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_read[3]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_read[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_write[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_write[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_gpio_0_io_writeEnable[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_gpio_0_io_writeEnable[3]}]

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
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.111 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min 0.053 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.231 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.116 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.321 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.161 [get_ports {jtag_inst1_SHIFT}]