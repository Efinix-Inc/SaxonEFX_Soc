#/bin/sh
export socdir=./hardware/netlist

opal_parameterised()
{
	sed -e 's/module OpalSoc (/module OpalSoc #(parameter CLOCK_FREQ=100000000,parameter [31:0] RAM_SIZE=4096) (/g' \
	-e 's/module OpalSoc_softTap (/module OpalSoc_softTap #(parameter CLOCK_FREQ=100000000,parameter [31:0] RAM_SIZE=4096) (/g' \
	-e '/wire\s\{7,\}\[3\:0\]\s\{4,\}_zz_43;/i localparam [19:0] UART_CLKDIV = (CLOCK_FREQ/115200) >> 3;localparam MW = $clog2(RAM_SIZE);' \
	-e '/BmbDecoder_1\ssystem_cpu_dBus_decoder\s(/c BmbDecoder_1 #(.RAM_SIZE(RAM_SIZE)) system_cpu_dBus_decoder (' \
	-e '/module\sBmbDecoder_1\s(/c module BmbDecoder_1 #(parameter [31:0] RAM_SIZE=4096) (' \
	-e '/BmbDecoder\ssystem_cpu_iBus_decoder\s(/c BmbDecoder #(.RAM_SIZE(RAM_SIZE)) system_cpu_iBus_decoder (' \
	-e '/module\sBmbDecoder\s(/c module BmbDecoder #(parameter [31:0] RAM_SIZE=4096) (' \
	-e '/BmbOnChipRam\ssystem_ramA_logic\s(/c BmbOnChipRam #(.RAM_SIZE(RAM_SIZE),.MW(MW)) system_ramA_logic (' \
	-e '/module\sBmbOnChipRam\s(/c module BmbOnChipRam #(parameter [31:0] RAM_SIZE=4096, parameter MW=12) (' \
	-e '/BmbArbiter\ssystem_ramA_bmb_arbiter\s(/c BmbArbiter #(.MW(MW)) system_ramA_bmb_arbiter (' \
	-e '/module\sBmbArbiter\s(/c module BmbArbiter #(parameter MW=12) (' \
	-e '/module\sStreamArbiter\s(/c module StreamArbiter #(parameter MW=12) (' \
	-e '/StreamArbiter\smemory_arbiter\s(/c StreamArbiter #(.MW(MW)) memory_arbiter (' \
	-e '/Apb3UartCtrl\ssystem_uart_0_io_logic\s(/c Apb3UartCtrl #(.UART_CLKDIV(UART_CLKDIV)) system_uart_0_io_logic (' \
	-e '/Apb3UartCtrl\ssystem_uart_1_io_logic\s(/c Apb3UartCtrl #(.UART_CLKDIV(UART_CLKDIV)) system_uart_1_io_logic (' \
	-e "/module\sApb3UartCtrl\s(/c module Apb3UartCtrl #(parameter [19:0] UART_CLKDIV = 20'h35) (" \
	-e "/bridge_uartConfigReg_clockDivider\s<=\s20'h0;/d" \
	-e "/bridge_uartConfigReg_clockDivider\s<=\s20'h00035/c bridge_uartConfigReg_clockDivider <= UART_CLKDIV;" \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}_zz_56;/wire       [MW-1:0] _zz_56;/g' \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}_zz_57;/wire       [MW-1:0] _zz_57;/g' \
	-e 's/_zz_56\[11\:0\]/_zz_56[MW-1:0]/g' \
	-e 's/_zz_57\[11\:0\]/_zz_57[MW-1:0]/g' \
	-e 's/system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_address\[11\:0\]/system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_address[MW-1:0]/g' \
	-e 's/system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_address\[11\:0\]/system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_address[MW-1:0]/g' \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;/wire       [MW-1:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;/g' \
	-e 's/system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address\[11\:0\]/system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e 's/system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address\[11\:0\]/system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e "/assign\slogic_hits_0\s=/c assign logic_hits_0 = ((io_input_cmd_payload_fragment_address & (~ (RAM_SIZE-1))) == 32'hf9000000);" \
	-e 's/input\s\{6,\}\[11\:0\]\s\{3,\}io_input_cmd_payload_fragment_address,/input      [MW-1:0]   io_input_cmd_payload_fragment_address,/g' \
	-e 's/output\sreg\s\[11\:0\]\s\{3,\}io_output_cmd_payload_fragment_address,/output reg [MW-1:0]   io_output_cmd_payload_fragment_address,/g' \
	-e "/buffer_addressIncr\s=\s(_zz_2/c generate if (MW > 12) \n  assign buffer_addressIncr = {buffer_address[MW-1 : 12],(_zz_2 & (~ 12'h003))}; \nelse \n  assign buffer_addressIncr = (_zz_2 & (~ 12'h003)); \nendgenerate " \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_0_cmd_payload_fragment_address,/[MW-1:0]   io_inputs_0_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_1_cmd_payload_fragment_address,/[MW-1:0]   io_inputs_1_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_output_cmd_payload_fragment_address,/[MW-1:0]   io_output_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_bus_cmd_payload_fragment_address,/[MW-1:0]   io_bus_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}memory_arbiter_io_output_payload_fragment_address;/[MW-1:0]   memory_arbiter_io_output_payload_fragment_address;/g' \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_0_payload_fragment_address,/[MW-1:0]  io_inputs_0_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_1_payload_fragment_address,/[MW-1:0]  io_inputs_1_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_output_payload_fragment_address,/[MW-1:0]  io_output_payload_fragment_address,/g' \
	-e 's/io_inputs_0_cmd_payload_fragment_address\[11\:0\]/io_inputs_0_cmd_payload_fragment_address[MW-1:0]/g' \
	-e 's/io_inputs_1_cmd_payload_fragment_address\[11\:0\]/io_inputs_1_cmd_payload_fragment_address[MW-1:0]/g' \
	-e 's/memory_arbiter_io_output_payload_fragment_address\[11\:0\]/memory_arbiter_io_output_payload_fragment_address[MW-1:0]/g' \
	-e 's/wire\s\{7,\}\[9\:0\]\s\{3,\}_zz_1;/wire       [MW-3:0] _zz_1;/g' \
	-e 's/ram_symbol0\s\[0\:1023\]/ram_symbol0 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol1\s\[0\:1023\]/ram_symbol1 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol2\s\[0\:1023\]/ram_symbol2 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol3\s\[0\:1023\]/ram_symbol3 [0:(RAM_SIZE\/4)-1]/g' \
	$2/$1 >> $3/$1
}

jade_parameterised()
{
	sed -e 's/module JadeSoc (/module JadeSoc #(parameter CLOCK_FREQ=100000000,parameter [31:0] RAM_SIZE=4096) (/g' \
	-e 's/module JadeSoc_softTap (/module JadeSoc_softTap #(parameter CLOCK_FREQ=100000000,parameter [31:0] RAM_SIZE=4096) (/g' \
	-e '/wire\s\{7,\}\[3\:0\]\s\{4,\}_zz_46;/i localparam [19:0] UART_CLKDIV = (CLOCK_FREQ/115200) >> 3;localparam MW = $clog2(RAM_SIZE);' \
	-e '/BmbDecoder_2\ssystem_bridge_bmb_decoder\s(/c BmbDecoder_2 #(.RAM_SIZE(RAM_SIZE)) system_bridge_bmb_decoder (' \
	-e '/module\sBmbDecoder_2\s(/c module BmbDecoder_2 #(parameter [31:0] RAM_SIZE=4096) (' \
	-e '/BmbOnChipRam\ssystem_ramA_logic\s(/c BmbOnChipRam #(.RAM_SIZE(RAM_SIZE),.MW(MW)) system_ramA_logic (' \
	-e '/module\sBmbOnChipRam\s(/c module BmbOnChipRam #(parameter [31:0] RAM_SIZE=4096, parameter MW=12) (' \
	-e '/BmbArbiter_1\ssystem_ramA_bmb_arbiter\s(/c BmbArbiter_1 #(.MW(MW)) system_ramA_bmb_arbiter (' \
	-e '/module\sBmbArbiter_1\s(/c module BmbArbiter_1 #(parameter MW=12) (' \
	-e '/BmbUnburstify\ssystem_ramA_bmb_burstUnburstifier\s(/c BmbUnburstify #(.MW(MW)) system_ramA_bmb_burstUnburstifier (' \
	-e '/module\sBmbUnburstify\s(/c module BmbUnburstify #(parameter MW=12) (' \
	-e '/Apb3UartCtrl\ssystem_uart_0_io_logic\s(/c Apb3UartCtrl #(.UART_CLKDIV(UART_CLKDIV)) system_uart_0_io_logic (' \
	-e '/Apb3UartCtrl\ssystem_uart_1_io_logic\s(/c Apb3UartCtrl #(.UART_CLKDIV(UART_CLKDIV)) system_uart_1_io_logic (' \
	-e "/module\sApb3UartCtrl\s(/c module Apb3UartCtrl #(parameter [19:0] UART_CLKDIV = 20'h35) (" \
	-e "/bridge_uartConfigReg_clockDivider\s<=\s20'h0;/d" \
	-e "/bridge_uartConfigReg_clockDivider\s<=\s20'h00035/c bridge_uartConfigReg_clockDivider <= UART_CLKDIV;" \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}_zz_67;/wire       [MW-1:0] _zz_67;/g' \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;/wire       [MW-1:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;/g' \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address;/wire       [MW-1:0] system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address;/g' \
	-e 's/system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address\[11\:0\]/system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e 's/system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address\[11\:0\]/system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e 's/system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address\[11\:0\]/system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e "/assign\slogic_hits_0\s=/c assign logic_hits_0 = ((io_input_cmd_payload_fragment_address & (~ (RAM_SIZE-1))) == 32'hf9000000);" \
	-e 's/input\s\{6,\}\[11\:0\]\s\{3,\}io_input_cmd_payload_fragment_address,/input      [MW-1:0]   io_input_cmd_payload_fragment_address,/g' \
	-e 's/output\sreg\s\[11\:0\]\s\{3,\}io_output_cmd_payload_fragment_address,/output reg [MW-1:0]   io_output_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}buffer_address;/[MW-1:0]   buffer_address;/g' \
	-e 's/\[11\:0\]\s\{3,\}buffer_addressIncr;/[MW-1:0]   buffer_addressIncr;/g' \
	-e 's/_zz_67\[11\:0\]/_zz_67[MW-1:0]/g' \
	-e "/buffer_addressIncr\s=\s(_zz_2/c generate if (MW > 12) \n  assign buffer_addressIncr = {buffer_address[MW-1 : 12],(_zz_2 & (~ 12'h003))}; \nelse \n  assign buffer_addressIncr = (_zz_2 & (~ 12'h003)); \nendgenerate " \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_0_cmd_payload_fragment_address,/[MW-1:0]   io_inputs_0_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_output_cmd_payload_fragment_address,/[MW-1:0]   io_output_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_bus_cmd_payload_fragment_address,/[MW-1:0]   io_bus_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_0_payload_fragment_address,/[MW-1:0]  io_inputs_0_payload_fragment_address,/g' \
	-e 's/memory_arbiter_io_output_payload_fragment_address\[11\:0\]/memory_arbiter_io_output_payload_fragment_address[MW-1:0]/g' \
	-e 's/wire\s\{7,\}\[9\:0\]\s\{3,\}_zz_1;/wire       [MW-3:0] _zz_1;/g' \
	-e 's/ram_symbol0\s\[0\:1023\]/ram_symbol0 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol1\s\[0\:1023\]/ram_symbol1 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol2\s\[0\:1023\]/ram_symbol2 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol3\s\[0\:1023\]/ram_symbol3 [0:(RAM_SIZE\/4)-1]/g' \
	$2/$1 >> $3/$1
}

ruby_parameterised()
{
	sed -e 's/module RubySoc (/module RubySoc #(parameter CLOCK_FREQ=100000000,parameter [31:0] RAM_SIZE=4096) (/g' \
	-e 's/module RubySoc_softTap (/module RubySoc_softTap #(parameter CLOCK_FREQ=100000000,parameter [31:0] RAM_SIZE=4096) (/g' \
	-e '/wire\s\{7,\}\[3\:0\]\s\{4,\}_zz_94;/i localparam [19:0] UART_CLKDIV = (CLOCK_FREQ/115200) >> 3;localparam MW = $clog2(RAM_SIZE);' \
	-e '/BmbDecoder_2\ssystem_bridge_bmb_decoder\s(/c BmbDecoder_2 #(.RAM_SIZE(RAM_SIZE)) system_bridge_bmb_decoder (' \
	-e '/module\sBmbDecoder_2\s(/c module BmbDecoder_2 #(parameter [31:0] RAM_SIZE=4096) (' \
	-e '/BmbOnChipRam\ssystem_ramA_logic\s(/c BmbOnChipRam #(.RAM_SIZE(RAM_SIZE),.MW(MW)) system_ramA_logic (' \
	-e '/module\sBmbOnChipRam\s(/c module BmbOnChipRam #(parameter [31:0] RAM_SIZE=4096, parameter MW=12) (' \
	-e '/BmbArbiter_3\ssystem_ramA_bmb_arbiter\s(/c BmbArbiter_3 #(.MW(MW)) system_ramA_bmb_arbiter (' \
	-e '/module\sBmbArbiter_3\s(/c module BmbArbiter_3 #(parameter MW=12) (' \
	-e '/BmbUnburstify\ssystem_ramA_bmb_burstUnburstifier\s(/c BmbUnburstify #(.MW(MW)) system_ramA_bmb_burstUnburstifier (' \
	-e '/module\sBmbUnburstify\s(/c module BmbUnburstify #(parameter MW=12) (' \
	-e '/Apb3UartCtrl\ssystem_uart_0_io_logic\s(/c Apb3UartCtrl #(.UART_CLKDIV(UART_CLKDIV)) system_uart_0_io_logic (' \
	-e '/Apb3UartCtrl\ssystem_uart_1_io_logic\s(/c Apb3UartCtrl #(.UART_CLKDIV(UART_CLKDIV)) system_uart_1_io_logic (' \
	-e "/module\sApb3UartCtrl\s(/c module Apb3UartCtrl #(parameter [19:0] UART_CLKDIV = 20'h35) (" \
	-e "/bridge_uartConfigReg_clockDivider\s<=\s20'h0;/d" \
	-e "/bridge_uartConfigReg_clockDivider\s<=\s20'h00035/c bridge_uartConfigReg_clockDivider <= UART_CLKDIV;" \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}_zz_134;/wire       [MW-1:0] _zz_134;/g' \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;/wire       [MW-1:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;/g' \
	-e 's/wire\s\{7,\}\[11\:0\]\s\{3,\}system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address;/wire       [MW-1:0] system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address;/g' \
	-e 's/system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address\[11\:0\]/system_ramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e 's/system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address\[11\:0\]/system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e 's/system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address\[11\:0\]/system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address\[MW-1:0]/g' \
	-e "/assign\slogic_hits_0\s=/c assign logic_hits_0 = ((io_input_cmd_payload_fragment_address & (~ (RAM_SIZE-1))) == 32'hf9000000);" \
	-e 's/input\s\{6,\}\[11\:0\]\s\{3,\}io_input_cmd_payload_fragment_address,/input      [MW-1:0]   io_input_cmd_payload_fragment_address,/g' \
	-e 's/output\sreg\s\[11\:0\]\s\{3,\}io_output_cmd_payload_fragment_address,/output reg [MW-1:0]   io_output_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}buffer_address;/[MW-1:0]   buffer_address;/g' \
	-e 's/\[11\:0\]\s\{3,\}buffer_addressIncr;/[MW-1:0]   buffer_addressIncr;/g' \
	-e 's/_zz_134\[11\:0\]/_zz_134[MW-1:0]/g' \
	-e "/buffer_addressIncr\s=\s(_zz_2/c generate if (MW > 12) \n  assign buffer_addressIncr = {buffer_address[MW-1 : 12],(_zz_2 & (~ 12'h003))}; \nelse \n  assign buffer_addressIncr = (_zz_2 & (~ 12'h003)); \nendgenerate " \
	-e 's/\[11\:0\]\s\{3,\}io_inputs_0_cmd_payload_fragment_address,/[MW-1:0]   io_inputs_0_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_output_cmd_payload_fragment_address,/[MW-1:0]   io_output_cmd_payload_fragment_address,/g' \
	-e 's/\[11\:0\]\s\{3,\}io_bus_cmd_payload_fragment_address,/[MW-1:0]   io_bus_cmd_payload_fragment_address,/g' \
	-e 's/wire\s\{7,\}\[9\:0\]\s\{3,\}_zz_1;/wire       [MW-3:0] _zz_1;/g' \
	-e 's/ram_symbol0\s\[0\:1023\]/ram_symbol0 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol1\s\[0\:1023\]/ram_symbol1 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol2\s\[0\:1023\]/ram_symbol2 [0:(RAM_SIZE\/4)-1]/g' \
	-e 's/ram_symbol3\s\[0\:1023\]/ram_symbol3 [0:(RAM_SIZE\/4)-1]/g' \
	$2/$1 >> $3/$1
}

if [ $1 == 1 ]
then 
	export destdir=../efx_SOC/ip_manager/soc_Ruby/source
	export socname="RubySoc.v"
	rm $destdir/$socname
	ruby_parameterised $socname $socdir $destdir
	export socname="RubySoc_softTap.v"
	rm $destdir/$socname
	ruby_parameterised $socname $socdir $destdir
	cp $socdir/RubySoc.v*.bin $destdir
	cp $socdir/RubySoc_softTap.v*.bin $destdir
elif [ $1 == 2 ]
then
	export destdir=../efx_SOC/ip_manager/soc_Jade/source
	export socname="JadeSoc.v"
	rm $destdir/$socname
	jade_parameterised $socname $socdir $destdir
	export socname="JadeSoc_softTap.v"
	rm $destdir/$socname
	jade_parameterised $socname $socdir $destdir
	cp $socdir/JadeSoc.v*.bin $destdir
	cp $socdir/JadeSoc_softTap.v*.bin $destdir
elif [ $1 == 3 ]
then
	export destdir=../efx_SOC/ip_manager/soc_Opal/source
	export socname="OpalSoc.v"
	rm $destdir/$socname
	opal_parameterised $socname $socdir $destdir
	export socname="OpalSoc_softTap.v"
	rm $destdir/$socname
	opal_parameterised $socname $socdir $destdir
	cp $socdir/OpalSoc.v*.bin $destdir
	cp $socdir/OpalSoc_softTap.v*.bin $destdir
else
	echo "invalid selection"
fi
