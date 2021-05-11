# PLL Constraints
#################
create_clock -period 10 clk

#100M
#create_clock -period 10.00 hbramClk
#create_clock -period 10.00 hbramClk_cal
#create_clock -waveform {2.50 7.50} -period 10.00 hbramClk90

#200M
create_clock -period 5.00 hbramClk
create_clock -period 5.00 hbramClk_cal
create_clock -waveform {1.25 3.75} -period 5.00 hbramClk90
 
set_clock_groups -exclusive  -group {hbramClk hbramClk_cal hbramClk90} -group {clk}

#rwds
set_input_delay -clock hbramClk_cal -max 2.688 [get_ports {hbc_dq_IN_HI[*]}]
set_input_delay -clock hbramClk_cal -min 1.881 [get_ports {hbc_dq_IN_HI[*]}]
set_input_delay -clock hbramClk_cal -max 2.688 [get_ports {hbc_dq_IN_LO[*]}]
set_input_delay -clock hbramClk_cal -min 1.881 [get_ports {hbc_dq_IN_LO[*]}]
set_output_delay -clock_fall -clock hbramClk -max -1.950 [get_ports {hbc_dq_OUT_HI[*]}]
set_output_delay -clock_fall -clock hbramClk -min -1.443 [get_ports {hbc_dq_OUT_HI[*]}]
set_output_delay -clock_fall -clock hbramClk -max -1.950 [get_ports {hbc_dq_OUT_LO[*]}]
set_output_delay -clock_fall -clock hbramClk -min -1.443 [get_ports {hbc_dq_OUT_LO[*]}]
set_output_delay -clock_fall -clock hbramClk -max -1.895 [get_ports {hbc_dq_OE[*]}]
set_output_delay -clock_fall -clock hbramClk -min -1.434 [get_ports {hbc_dq_OE[*]}]
#rwds
set_input_delay -clock hbramClk_cal -max 2.688 [get_ports {hbc_rwds_IN_HI[*]}]
set_input_delay -clock hbramClk_cal -min 1.881 [get_ports {hbc_rwds_IN_HI[*]}]
set_input_delay -clock hbramClk_cal -max 2.688 [get_ports {hbc_rwds_IN_LO[*]}]
set_input_delay -clock hbramClk_cal -min 1.881 [get_ports {hbc_rwds_IN_LO[*]}]
set_output_delay -clock hbramClk -max -1.950 [get_ports {hbc_rwds_OUT_HI[*]}]
set_output_delay -clock hbramClk -min -1.443 [get_ports {hbc_rwds_OUT_HI[*]}]
set_output_delay -clock hbramClk -max -1.950 [get_ports {hbc_rwds_OUT_LO[*]}]
set_output_delay -clock hbramClk -min -1.443 [get_ports {hbc_rwds_OUT_LO[*]}]
set_output_delay -clock hbramClk -max -1.895 [get_ports {hbc_rwds_OE[*]}]
set_output_delay -clock hbramClk -min -1.434 [get_ports {hbc_rwds_OE[*]}]
#ck
set_output_delay -clock_fall -clock hbramClk90 -max -1.950 [get_ports {hbc_ck_p_HI}]
set_output_delay -clock_fall -clock hbramClk90 -min -1.443 [get_ports {hbc_ck_p_HI}]
set_output_delay -clock_fall -clock hbramClk90 -max -1.950 [get_ports {hbc_ck_p_LO}]
set_output_delay -clock_fall -clock hbramClk90 -min -1.443 [get_ports {hbc_ck_p_LO}]
set_output_delay -clock_fall -clock hbramClk90 -max -1.950 [get_ports {hbc_ck_n_HI}]
set_output_delay -clock_fall -clock hbramClk90 -min -1.443 [get_ports {hbc_ck_n_HI}]
set_output_delay -clock_fall -clock hbramClk90 -max -1.950 [get_ports {hbc_ck_n_LO}]
set_output_delay -clock_fall -clock hbramClk90 -min -1.443 [get_ports {hbc_ck_n_LO}]
#csn
set_output_delay -clock hbramClk -max -1.950 [get_ports {hbc_cs_n}]
set_output_delay -clock hbramClk -min -1.443 [get_ports {hbc_cs_n}]


# False Path
#################
set_false_path -setup -hold -from io_asyncReset
