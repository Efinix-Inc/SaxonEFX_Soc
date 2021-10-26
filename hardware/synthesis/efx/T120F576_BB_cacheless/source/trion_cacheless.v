// Generator : SpinalHDL v1.6.1    git head : b5bf215aad90982366fd949e8f8122eda568cad8
// Component : trion_cacheless
// Git hash  : 1fb38a27b9ebbf6c5c7da59c35daecc4f4e0186c



module trion_cacheless (
  input               jtagCtrl_tck,
  input               io_systemClk,
  input               io_asyncReset,
  input               jtagCtrl_tdi,
  input               jtagCtrl_enable,
  input               jtagCtrl_capture,
  input               jtagCtrl_shift,
  input               jtagCtrl_update,
  input               jtagCtrl_reset,
  output              jtagCtrl_tdo,
  output reg          io_systemReset,
  output              cpu0_customInstruction_cmd_valid,
  input               cpu0_customInstruction_cmd_ready,
  output     [9:0]    cpu0_customInstruction_function_id,
  output     [31:0]   cpu0_customInstruction_inputs_0,
  output     [31:0]   cpu0_customInstruction_inputs_1,
  input               cpu0_customInstruction_rsp_valid,
  output              cpu0_customInstruction_rsp_ready,
  input      [31:0]   cpu0_customInstruction_outputs_0,
  output              system_uart_0_io_txd,
  input               system_uart_0_io_rxd,
  input      [15:0]   system_gpio_0_io_read,
  output     [15:0]   system_gpio_0_io_write,
  output     [15:0]   system_gpio_0_io_writeEnable,
  output     [0:0]    system_spi_0_io_sclk_write,
  output              system_spi_0_io_data_0_writeEnable,
  input      [0:0]    system_spi_0_io_data_0_read,
  output     [0:0]    system_spi_0_io_data_0_write,
  output              system_spi_0_io_data_1_writeEnable,
  input      [0:0]    system_spi_0_io_data_1_read,
  output     [0:0]    system_spi_0_io_data_1_write,
  output              system_spi_0_io_data_2_writeEnable,
  input      [0:0]    system_spi_0_io_data_2_read,
  output     [0:0]    system_spi_0_io_data_2_write,
  output              system_spi_0_io_data_3_writeEnable,
  input      [0:0]    system_spi_0_io_data_3_read,
  output     [0:0]    system_spi_0_io_data_3_write,
  output     [0:0]    system_spi_0_io_ss
);

  wire                system_cores_0_logic_cpu_iBus_rsp_payload_error;
  wire                system_cores_0_logic_cpu_timerInterrupt;
  wire                system_cores_0_logic_cpu_softwareInterrupt;
  wire                system_cores_0_logic_cpu_debug_bus_cmd_payload_wr;
  wire                system_cores_0_logic_cpu_dBus_rsp_ready;
  wire                system_cores_0_logic_cpu_dBus_rsp_error;
  wire                hardJtag_debug_logic_jtagBridge_io_ctrl_tdo;
  wire                hardJtag_debug_logic_jtagBridge_io_remote_cmd_valid;
  wire                hardJtag_debug_logic_jtagBridge_io_remote_cmd_payload_last;
  wire       [0:0]    hardJtag_debug_logic_jtagBridge_io_remote_cmd_payload_fragment;
  wire                hardJtag_debug_logic_jtagBridge_io_remote_rsp_ready;
  wire                bufferCC_5_io_dataOut;
  wire                hardJtag_debug_logic_debugger_io_remote_cmd_ready;
  wire                hardJtag_debug_logic_debugger_io_remote_rsp_valid;
  wire                hardJtag_debug_logic_debugger_io_remote_rsp_payload_error;
  wire       [31:0]   hardJtag_debug_logic_debugger_io_remote_rsp_payload_data;
  wire                hardJtag_debug_logic_debugger_io_mem_cmd_valid;
  wire       [31:0]   hardJtag_debug_logic_debugger_io_mem_cmd_payload_address;
  wire       [31:0]   hardJtag_debug_logic_debugger_io_mem_cmd_payload_data;
  wire                hardJtag_debug_logic_debugger_io_mem_cmd_payload_wr;
  wire       [1:0]    hardJtag_debug_logic_debugger_io_mem_cmd_payload_size;
  wire                bufferCC_6_io_dataOut;
  wire                system_cores_0_logic_cpu_iBus_cmd_valid;
  wire       [31:0]   system_cores_0_logic_cpu_iBus_cmd_payload_pc;
  wire                system_cores_0_logic_cpu_CfuPlugin_bus_cmd_valid;
  wire       [9:0]    system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_function_id;
  wire       [31:0]   system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_inputs_0;
  wire       [31:0]   system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_inputs_1;
  wire                system_cores_0_logic_cpu_CfuPlugin_bus_rsp_ready;
  wire                system_cores_0_logic_cpu_debug_bus_cmd_ready;
  wire       [31:0]   system_cores_0_logic_cpu_debug_bus_rsp_data;
  wire                system_cores_0_logic_cpu_debug_resetOut;
  wire                system_cores_0_logic_cpu_dBus_cmd_valid;
  wire                system_cores_0_logic_cpu_dBus_cmd_payload_wr;
  wire       [31:0]   system_cores_0_logic_cpu_dBus_cmd_payload_address;
  wire       [31:0]   system_cores_0_logic_cpu_dBus_cmd_payload_data;
  wire       [1:0]    system_cores_0_logic_cpu_dBus_cmd_payload_size;
  wire                bufferCC_7_io_dataOut;
  wire                system_bridge_bmb_arbiter_io_inputs_0_cmd_ready;
  wire                system_bridge_bmb_arbiter_io_inputs_0_rsp_valid;
  wire                system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_last;
  wire       [0:0]    system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data;
  wire       [0:0]    system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context;
  wire                system_bridge_bmb_arbiter_io_inputs_1_cmd_ready;
  wire                system_bridge_bmb_arbiter_io_inputs_1_rsp_valid;
  wire                system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_last;
  wire       [0:0]    system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data;
  wire                system_bridge_bmb_arbiter_io_output_cmd_valid;
  wire                system_bridge_bmb_arbiter_io_output_cmd_payload_last;
  wire       [0:0]    system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_source;
  wire       [0:0]    system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_address;
  wire       [1:0]    system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_length;
  wire       [31:0]   system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_data;
  wire       [3:0]    system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_mask;
  wire       [0:0]    system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_context;
  wire                system_bridge_bmb_arbiter_io_output_rsp_ready;
  wire                system_cores_0_iBus_decoder_io_input_cmd_ready;
  wire                system_cores_0_iBus_decoder_io_input_rsp_valid;
  wire                system_cores_0_iBus_decoder_io_input_rsp_payload_last;
  wire       [0:0]    system_cores_0_iBus_decoder_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_iBus_decoder_io_input_rsp_payload_fragment_data;
  wire                system_cores_0_iBus_decoder_io_outputs_0_cmd_valid;
  wire                system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_last;
  wire       [0:0]    system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_address;
  wire       [1:0]    system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_length;
  wire                system_cores_0_iBus_decoder_io_outputs_0_rsp_ready;
  wire                system_bridge_bmb_decoder_io_input_cmd_ready;
  wire                system_bridge_bmb_decoder_io_input_rsp_valid;
  wire                system_bridge_bmb_decoder_io_input_rsp_payload_last;
  wire       [0:0]    system_bridge_bmb_decoder_io_input_rsp_payload_fragment_source;
  wire       [0:0]    system_bridge_bmb_decoder_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_decoder_io_input_rsp_payload_fragment_data;
  wire       [0:0]    system_bridge_bmb_decoder_io_input_rsp_payload_fragment_context;
  wire                system_bridge_bmb_decoder_io_outputs_0_cmd_valid;
  wire                system_bridge_bmb_decoder_io_outputs_0_cmd_payload_last;
  wire       [0:0]    system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_source;
  wire       [0:0]    system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address;
  wire       [1:0]    system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_length;
  wire       [31:0]   system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_data;
  wire       [3:0]    system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_mask;
  wire       [0:0]    system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_context;
  wire                system_bridge_bmb_decoder_io_outputs_0_rsp_ready;
  wire                system_bridge_bmb_decoder_io_outputs_1_cmd_valid;
  wire                system_bridge_bmb_decoder_io_outputs_1_cmd_payload_last;
  wire       [0:0]    system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_source;
  wire       [0:0]    system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_address;
  wire       [1:0]    system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_length;
  wire       [31:0]   system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_data;
  wire       [3:0]    system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_mask;
  wire       [0:0]    system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_context;
  wire                system_bridge_bmb_decoder_io_outputs_1_rsp_ready;
  wire                bmbDecoder_4_io_input_cmd_ready;
  wire                bmbDecoder_4_io_input_rsp_valid;
  wire                bmbDecoder_4_io_input_rsp_payload_last;
  wire       [0:0]    bmbDecoder_4_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   bmbDecoder_4_io_input_rsp_payload_fragment_data;
  wire                bmbDecoder_4_io_outputs_0_cmd_valid;
  wire                bmbDecoder_4_io_outputs_0_cmd_payload_last;
  wire       [0:0]    bmbDecoder_4_io_outputs_0_cmd_payload_fragment_opcode;
  wire       [31:0]   bmbDecoder_4_io_outputs_0_cmd_payload_fragment_address;
  wire       [1:0]    bmbDecoder_4_io_outputs_0_cmd_payload_fragment_length;
  wire       [31:0]   bmbDecoder_4_io_outputs_0_cmd_payload_fragment_data;
  wire       [3:0]    bmbDecoder_4_io_outputs_0_cmd_payload_fragment_mask;
  wire                bmbDecoder_4_io_outputs_0_rsp_ready;
  wire                system_ramA_logic_io_bus_cmd_ready;
  wire                system_ramA_logic_io_bus_rsp_valid;
  wire                system_ramA_logic_io_bus_rsp_payload_last;
  wire       [0:0]    system_ramA_logic_io_bus_rsp_payload_fragment_source;
  wire       [0:0]    system_ramA_logic_io_bus_rsp_payload_fragment_opcode;
  wire       [31:0]   system_ramA_logic_io_bus_rsp_payload_fragment_data;
  wire       [0:0]    system_ramA_logic_io_bus_rsp_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_input_cmd_ready;
  wire                system_bmbPeripheral_bmb_decoder_io_input_rsp_valid;
  wire                system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_data;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_valid;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_0_rsp_ready;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_valid;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_1_rsp_ready;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_valid;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_2_rsp_ready;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_valid;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_3_rsp_ready;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_valid;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_decoder_io_outputs_4_rsp_ready;
  wire                system_clint_logic_io_bus_cmd_ready;
  wire                system_clint_logic_io_bus_rsp_valid;
  wire                system_clint_logic_io_bus_rsp_payload_last;
  wire       [0:0]    system_clint_logic_io_bus_rsp_payload_fragment_source;
  wire       [0:0]    system_clint_logic_io_bus_rsp_payload_fragment_opcode;
  wire       [31:0]   system_clint_logic_io_bus_rsp_payload_fragment_data;
  wire       [0:0]    system_clint_logic_io_bus_rsp_payload_fragment_context;
  wire       [0:0]    system_clint_logic_io_timerInterrupt;
  wire       [0:0]    system_clint_logic_io_softwareInterrupt;
  wire       [63:0]   system_clint_logic_io_time;
  wire                system_uart_0_io_logic_io_bus_cmd_ready;
  wire                system_uart_0_io_logic_io_bus_rsp_valid;
  wire                system_uart_0_io_logic_io_bus_rsp_payload_last;
  wire       [0:0]    system_uart_0_io_logic_io_bus_rsp_payload_fragment_source;
  wire       [0:0]    system_uart_0_io_logic_io_bus_rsp_payload_fragment_opcode;
  wire       [31:0]   system_uart_0_io_logic_io_bus_rsp_payload_fragment_data;
  wire       [0:0]    system_uart_0_io_logic_io_bus_rsp_payload_fragment_context;
  wire                system_uart_0_io_logic_io_uart_txd;
  wire                system_uart_0_io_logic_io_interrupt;
  wire                system_spi_0_io_logic_io_ctrl_cmd_ready;
  wire                system_spi_0_io_logic_io_ctrl_rsp_valid;
  wire                system_spi_0_io_logic_io_ctrl_rsp_payload_last;
  wire       [0:0]    system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_source;
  wire       [0:0]    system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_opcode;
  wire       [31:0]   system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_data;
  wire       [0:0]    system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_context;
  wire       [0:0]    system_spi_0_io_logic_io_spi_sclk_write;
  wire       [0:0]    system_spi_0_io_logic_io_spi_ss;
  wire       [0:0]    system_spi_0_io_logic_io_spi_data_0_write;
  wire                system_spi_0_io_logic_io_spi_data_0_writeEnable;
  wire       [0:0]    system_spi_0_io_logic_io_spi_data_1_write;
  wire                system_spi_0_io_logic_io_spi_data_1_writeEnable;
  wire       [0:0]    system_spi_0_io_logic_io_spi_data_2_write;
  wire                system_spi_0_io_logic_io_spi_data_2_writeEnable;
  wire       [0:0]    system_spi_0_io_logic_io_spi_data_3_write;
  wire                system_spi_0_io_logic_io_spi_data_3_writeEnable;
  wire                system_spi_0_io_logic_io_interrupt;
  wire       [15:0]   system_gpio_0_io_logic_io_gpio_write;
  wire       [15:0]   system_gpio_0_io_logic_io_gpio_writeEnable;
  wire                system_gpio_0_io_logic_io_bus_cmd_ready;
  wire                system_gpio_0_io_logic_io_bus_rsp_valid;
  wire                system_gpio_0_io_logic_io_bus_rsp_payload_last;
  wire       [0:0]    system_gpio_0_io_logic_io_bus_rsp_payload_fragment_source;
  wire       [0:0]    system_gpio_0_io_logic_io_bus_rsp_payload_fragment_opcode;
  wire       [31:0]   system_gpio_0_io_logic_io_bus_rsp_payload_fragment_data;
  wire       [0:0]    system_gpio_0_io_logic_io_bus_rsp_payload_fragment_context;
  wire       [15:0]   system_gpio_0_io_logic_io_interrupt;
  wire       [29:0]   _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_address;
  wire       [6:0]    _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask_1;
  reg                 debugCd_logic_inputResetTrigger;
  reg                 debugCd_logic_outputResetUnbuffered;
  reg        [11:0]   debugCd_logic_holdingLogic_resetCounter = 12'h0;
  wire                when_ClockDomainGenerator_l77;
  reg                 debugCd_logic_outputReset = 1'b1;
  wire                debugCd_logic_inputResetAdapter_stuff_syncTrigger;
  wire                hardJtag_debug_logic_mmMaster_cmd_valid;
  wire                hardJtag_debug_logic_mmMaster_cmd_ready;
  wire                hardJtag_debug_logic_mmMaster_cmd_payload_last;
  wire       [0:0]    hardJtag_debug_logic_mmMaster_cmd_payload_fragment_opcode;
  wire       [31:0]   hardJtag_debug_logic_mmMaster_cmd_payload_fragment_address;
  wire       [1:0]    hardJtag_debug_logic_mmMaster_cmd_payload_fragment_length;
  wire       [31:0]   hardJtag_debug_logic_mmMaster_cmd_payload_fragment_data;
  wire       [3:0]    hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask;
  wire                hardJtag_debug_logic_mmMaster_rsp_valid;
  wire                hardJtag_debug_logic_mmMaster_rsp_ready;
  wire                hardJtag_debug_logic_mmMaster_rsp_payload_last;
  wire       [0:0]    hardJtag_debug_logic_mmMaster_rsp_payload_fragment_opcode;
  wire       [31:0]   hardJtag_debug_logic_mmMaster_rsp_payload_fragment_data;
  reg        [3:0]    _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask;
  reg                 systemCd_logic_inputResetTrigger;
  reg                 systemCd_logic_outputResetUnbuffered;
  reg        [5:0]    systemCd_logic_holdingLogic_resetCounter;
  wire                when_ClockDomainGenerator_l77_1;
  reg                 systemCd_logic_outputReset;
  wire                system_cores_0_iBus_cmd_valid;
  wire                system_cores_0_iBus_cmd_ready;
  wire                system_cores_0_iBus_cmd_payload_last;
  wire       [0:0]    system_cores_0_iBus_cmd_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_iBus_cmd_payload_fragment_address;
  wire       [1:0]    system_cores_0_iBus_cmd_payload_fragment_length;
  wire                system_cores_0_iBus_rsp_valid;
  wire                system_cores_0_iBus_rsp_ready;
  wire                system_cores_0_iBus_rsp_payload_last;
  wire       [0:0]    system_cores_0_iBus_rsp_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_iBus_rsp_payload_fragment_data;
  wire                system_cores_0_dBus_cmd_valid;
  wire                system_cores_0_dBus_cmd_ready;
  wire                system_cores_0_dBus_cmd_payload_last;
  wire       [0:0]    system_cores_0_dBus_cmd_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_dBus_cmd_payload_fragment_address;
  wire       [1:0]    system_cores_0_dBus_cmd_payload_fragment_length;
  wire       [31:0]   system_cores_0_dBus_cmd_payload_fragment_data;
  wire       [3:0]    system_cores_0_dBus_cmd_payload_fragment_mask;
  wire       [0:0]    system_cores_0_dBus_cmd_payload_fragment_context;
  wire                system_cores_0_dBus_rsp_valid;
  wire                system_cores_0_dBus_rsp_ready;
  wire                system_cores_0_dBus_rsp_payload_last;
  wire       [0:0]    system_cores_0_dBus_rsp_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_dBus_rsp_payload_fragment_data;
  wire       [0:0]    system_cores_0_dBus_rsp_payload_fragment_context;
  reg        [1:0]    _zz_system_cores_0_dBus_cmd_payload_fragment_length;
  reg        [3:0]    _zz_system_cores_0_dBus_cmd_payload_fragment_mask;
  reg                 system_cores_0_debugReset;
  wire                system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_valid;
  wire                system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_ready;
  wire                system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_last;
  wire       [0:0]    system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_address;
  wire       [1:0]    system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_length;
  wire       [31:0]   system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_data;
  wire       [3:0]    system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_mask;
  wire       [0:0]    system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_context;
  wire                system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_valid;
  wire                system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_ready;
  wire                system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_last;
  wire       [0:0]    system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_data;
  wire       [0:0]    system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_context;
  wire                system_cores_0_dBus_cmd_s2mPipe_valid;
  reg                 system_cores_0_dBus_cmd_s2mPipe_ready;
  wire                system_cores_0_dBus_cmd_s2mPipe_payload_last;
  wire       [0:0]    system_cores_0_dBus_cmd_s2mPipe_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_dBus_cmd_s2mPipe_payload_fragment_address;
  wire       [1:0]    system_cores_0_dBus_cmd_s2mPipe_payload_fragment_length;
  wire       [31:0]   system_cores_0_dBus_cmd_s2mPipe_payload_fragment_data;
  wire       [3:0]    system_cores_0_dBus_cmd_s2mPipe_payload_fragment_mask;
  wire       [0:0]    system_cores_0_dBus_cmd_s2mPipe_payload_fragment_context;
  reg                 system_cores_0_dBus_cmd_rValid;
  reg                 system_cores_0_dBus_cmd_rData_last;
  reg        [0:0]    system_cores_0_dBus_cmd_rData_fragment_opcode;
  reg        [31:0]   system_cores_0_dBus_cmd_rData_fragment_address;
  reg        [1:0]    system_cores_0_dBus_cmd_rData_fragment_length;
  reg        [31:0]   system_cores_0_dBus_cmd_rData_fragment_data;
  reg        [3:0]    system_cores_0_dBus_cmd_rData_fragment_mask;
  reg        [0:0]    system_cores_0_dBus_cmd_rData_fragment_context;
  wire                system_cores_0_dBus_cmd_s2mPipe_m2sPipe_valid;
  wire                system_cores_0_dBus_cmd_s2mPipe_m2sPipe_ready;
  wire                system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_last;
  wire       [0:0]    system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_address;
  wire       [1:0]    system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_length;
  wire       [31:0]   system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_data;
  wire       [3:0]    system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_mask;
  wire       [0:0]    system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_context;
  reg                 system_cores_0_dBus_cmd_s2mPipe_rValid;
  reg                 system_cores_0_dBus_cmd_s2mPipe_rData_last;
  reg        [0:0]    system_cores_0_dBus_cmd_s2mPipe_rData_fragment_opcode;
  reg        [31:0]   system_cores_0_dBus_cmd_s2mPipe_rData_fragment_address;
  reg        [1:0]    system_cores_0_dBus_cmd_s2mPipe_rData_fragment_length;
  reg        [31:0]   system_cores_0_dBus_cmd_s2mPipe_rData_fragment_data;
  reg        [3:0]    system_cores_0_dBus_cmd_s2mPipe_rData_fragment_mask;
  reg        [0:0]    system_cores_0_dBus_cmd_s2mPipe_rData_fragment_context;
  wire                when_Stream_l342;
  wire                hardJtag_debug_bmb_connector_decoder_cmd_valid;
  wire                hardJtag_debug_bmb_connector_decoder_cmd_ready;
  wire                hardJtag_debug_bmb_connector_decoder_cmd_payload_last;
  wire       [0:0]    hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_opcode;
  wire       [31:0]   hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_address;
  wire       [1:0]    hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_length;
  wire       [31:0]   hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_data;
  wire       [3:0]    hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_mask;
  wire                hardJtag_debug_bmb_connector_decoder_rsp_valid;
  wire                hardJtag_debug_bmb_connector_decoder_rsp_ready;
  wire                hardJtag_debug_bmb_connector_decoder_rsp_payload_last;
  wire       [0:0]    hardJtag_debug_bmb_connector_decoder_rsp_payload_fragment_opcode;
  wire       [31:0]   hardJtag_debug_bmb_connector_decoder_rsp_payload_fragment_data;
  wire                system_bridge_bmb_cmd_valid;
  wire                system_bridge_bmb_cmd_ready;
  wire                system_bridge_bmb_cmd_payload_last;
  wire       [0:0]    system_bridge_bmb_cmd_payload_fragment_source;
  wire       [0:0]    system_bridge_bmb_cmd_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_cmd_payload_fragment_address;
  wire       [1:0]    system_bridge_bmb_cmd_payload_fragment_length;
  wire       [31:0]   system_bridge_bmb_cmd_payload_fragment_data;
  wire       [3:0]    system_bridge_bmb_cmd_payload_fragment_mask;
  wire       [0:0]    system_bridge_bmb_cmd_payload_fragment_context;
  wire                system_bridge_bmb_rsp_valid;
  wire                system_bridge_bmb_rsp_ready;
  wire                system_bridge_bmb_rsp_payload_last;
  wire       [0:0]    system_bridge_bmb_rsp_payload_fragment_source;
  wire       [0:0]    system_bridge_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bridge_bmb_rsp_payload_fragment_data;
  wire       [0:0]    system_bridge_bmb_rsp_payload_fragment_context;
  wire                system_cores_0_iBus_cmd_s2mPipe_valid;
  reg                 system_cores_0_iBus_cmd_s2mPipe_ready;
  wire                system_cores_0_iBus_cmd_s2mPipe_payload_last;
  wire       [0:0]    system_cores_0_iBus_cmd_s2mPipe_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_iBus_cmd_s2mPipe_payload_fragment_address;
  wire       [1:0]    system_cores_0_iBus_cmd_s2mPipe_payload_fragment_length;
  reg                 system_cores_0_iBus_cmd_rValid;
  reg                 system_cores_0_iBus_cmd_rData_last;
  reg        [0:0]    system_cores_0_iBus_cmd_rData_fragment_opcode;
  reg        [31:0]   system_cores_0_iBus_cmd_rData_fragment_address;
  reg        [1:0]    system_cores_0_iBus_cmd_rData_fragment_length;
  wire                system_cores_0_iBus_cmd_s2mPipe_m2sPipe_valid;
  wire                system_cores_0_iBus_cmd_s2mPipe_m2sPipe_ready;
  wire                system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_last;
  wire       [0:0]    system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_address;
  wire       [1:0]    system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_length;
  reg                 system_cores_0_iBus_cmd_s2mPipe_rValid;
  reg                 system_cores_0_iBus_cmd_s2mPipe_rData_last;
  reg        [0:0]    system_cores_0_iBus_cmd_s2mPipe_rData_fragment_opcode;
  reg        [31:0]   system_cores_0_iBus_cmd_s2mPipe_rData_fragment_address;
  reg        [1:0]    system_cores_0_iBus_cmd_s2mPipe_rData_fragment_length;
  wire                when_Stream_l342_1;
  wire                system_bmbPeripheral_bmb_cmd_valid;
  wire                system_bmbPeripheral_bmb_cmd_ready;
  wire                system_bmbPeripheral_bmb_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_rsp_valid;
  wire                system_bmbPeripheral_bmb_rsp_ready;
  wire                system_bmbPeripheral_bmb_rsp_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_rsp_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bmbPeripheral_bmb_rsp_payload_fragment_data;
  wire       [0:0]    system_bmbPeripheral_bmb_rsp_payload_fragment_context;
  wire                system_cores_0_debugBmb_cmd_valid;
  wire                system_cores_0_debugBmb_cmd_ready;
  wire                system_cores_0_debugBmb_cmd_payload_last;
  wire       [0:0]    system_cores_0_debugBmb_cmd_payload_fragment_opcode;
  wire       [7:0]    system_cores_0_debugBmb_cmd_payload_fragment_address;
  wire       [1:0]    system_cores_0_debugBmb_cmd_payload_fragment_length;
  wire       [31:0]   system_cores_0_debugBmb_cmd_payload_fragment_data;
  wire       [3:0]    system_cores_0_debugBmb_cmd_payload_fragment_mask;
  wire                system_cores_0_debugBmb_rsp_valid;
  wire                system_cores_0_debugBmb_rsp_ready;
  wire                system_cores_0_debugBmb_rsp_payload_last;
  wire       [0:0]    system_cores_0_debugBmb_rsp_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_debugBmb_rsp_payload_fragment_data;
  wire                system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire                system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [7:0]    system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [3:0]    system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask;
  wire                system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire                system_cores_0_logic_cpu_debug_bus_cmd_fire;
  reg                 system_cores_0_logic_cpu_debug_bus_cmd_fire_regNext;
  wire                system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [12:0]   system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [3:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask;
  wire       [0:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire                _zz_io_input_rsp_ready;
  wire                system_bmbPeripheral_bmb_cmd_halfPipe_valid;
  wire                system_bmbPeripheral_bmb_cmd_halfPipe_ready;
  wire                system_bmbPeripheral_bmb_cmd_halfPipe_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_data;
  wire       [3:0]    system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_mask;
  wire       [0:0]    system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_context;
  reg                 system_bmbPeripheral_bmb_cmd_rValid;
  wire                system_bmbPeripheral_bmb_cmd_halfPipe_fire;
  reg                 system_bmbPeripheral_bmb_cmd_rData_last;
  reg        [0:0]    system_bmbPeripheral_bmb_cmd_rData_fragment_source;
  reg        [0:0]    system_bmbPeripheral_bmb_cmd_rData_fragment_opcode;
  reg        [23:0]   system_bmbPeripheral_bmb_cmd_rData_fragment_address;
  reg        [1:0]    system_bmbPeripheral_bmb_cmd_rData_fragment_length;
  reg        [31:0]   system_bmbPeripheral_bmb_cmd_rData_fragment_data;
  reg        [3:0]    system_bmbPeripheral_bmb_cmd_rData_fragment_mask;
  reg        [0:0]    system_bmbPeripheral_bmb_cmd_rData_fragment_context;
  wire                _zz_system_bmbPeripheral_bmb_rsp_valid;
  reg                 _zz_system_bmbPeripheral_bmb_rsp_valid_1;
  reg                 _zz_system_bmbPeripheral_bmb_rsp_payload_last;
  reg        [0:0]    _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_source;
  reg        [0:0]    _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_data;
  reg        [0:0]    _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_context;
  wire                system_gpio_0_io_interrupts_0;
  wire                system_gpio_0_io_interrupts_1;
  wire                system_gpio_0_io_interrupts_2;
  wire                system_gpio_0_io_interrupts_3;
  wire                system_gpio_0_io_interrupts_4;
  wire                system_gpio_0_io_interrupts_5;
  wire                system_gpio_0_io_interrupts_6;
  wire                system_gpio_0_io_interrupts_7;
  wire                system_gpio_0_io_interrupts_8;
  wire                system_gpio_0_io_interrupts_9;
  wire                system_gpio_0_io_interrupts_10;
  wire                system_gpio_0_io_interrupts_11;
  wire                system_gpio_0_io_interrupts_12;
  wire                system_gpio_0_io_interrupts_13;
  wire                system_gpio_0_io_interrupts_14;
  wire                system_gpio_0_io_interrupts_15;
  wire                system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [15:0]   system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [0:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [5:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire                _zz_io_bus_rsp_ready;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_ready;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_last;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_source;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_opcode;
  wire       [5:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_address;
  wire       [1:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_length;
  wire       [31:0]   system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_data;
  wire       [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_context;
  reg                 system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid;
  wire                system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_fire;
  reg                 system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_last;
  reg        [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_source;
  reg        [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_opcode;
  reg        [5:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_address;
  reg        [1:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_length;
  reg        [31:0]   system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_data;
  reg        [0:0]    system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_context;
  wire                _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  reg                 _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid_1;
  reg                 _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  reg        [0:0]    _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  reg        [0:0]    _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  reg        [0:0]    _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire       [1:0]    system_uart_0_io_interrupt_plic_gateway_priority;
  reg                 system_uart_0_io_interrupt_plic_gateway_ip;
  reg                 system_uart_0_io_interrupt_plic_gateway_waitCompletion;
  wire                when_PlicGateway_l21;
  wire       [1:0]    system_spi_0_io_interrupt_plic_gateway_priority;
  reg                 system_spi_0_io_interrupt_plic_gateway_ip;
  reg                 system_spi_0_io_interrupt_plic_gateway_waitCompletion;
  wire                when_PlicGateway_l21_1;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [11:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_ready;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_last;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_source;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_opcode;
  wire       [11:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_address;
  wire       [1:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_length;
  wire       [31:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_data;
  wire       [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_context;
  reg                 system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid;
  wire                system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_fire;
  reg                 system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_last;
  reg        [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_source;
  reg        [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_opcode;
  reg        [11:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_address;
  reg        [1:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_length;
  reg        [31:0]   system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_data;
  reg        [0:0]    system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_context;
  wire                system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [7:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [0:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire       [1:0]    system_gpio_0_io_interrupts_0_plic_gateway_priority;
  reg                 system_gpio_0_io_interrupts_0_plic_gateway_ip;
  reg                 system_gpio_0_io_interrupts_0_plic_gateway_waitCompletion;
  wire                when_PlicGateway_l21_2;
  wire       [1:0]    system_gpio_0_io_interrupts_1_plic_gateway_priority;
  reg                 system_gpio_0_io_interrupts_1_plic_gateway_ip;
  reg                 system_gpio_0_io_interrupts_1_plic_gateway_waitCompletion;
  wire                when_PlicGateway_l21_3;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_valid;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_ready;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode;
  wire       [23:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address;
  wire       [1:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_valid;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_ready;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_payload_last;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_valid_1;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_ready_1;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_1;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_1;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_1;
  wire       [23:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_1;
  wire       [1:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_1;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_1;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_1;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_valid_1;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_ready_1;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_1;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_1;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_1;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_1;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_1;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_valid_2;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_ready_2;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_2;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_2;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_2;
  wire       [23:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_2;
  wire       [1:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_2;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_2;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_2;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_valid_2;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_ready_2;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_2;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_2;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_2;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_2;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_2;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_valid_3;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_ready_3;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_3;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_3;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_3;
  wire       [23:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_3;
  wire       [1:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_3;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_3;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_3;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_valid_3;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_ready_3;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_3;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_3;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_3;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_3;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_3;
  wire                system_plic_logic_bmb_cmd_valid;
  wire                system_plic_logic_bmb_cmd_ready;
  wire                system_plic_logic_bmb_cmd_payload_last;
  wire       [0:0]    system_plic_logic_bmb_cmd_payload_fragment_source;
  wire       [0:0]    system_plic_logic_bmb_cmd_payload_fragment_opcode;
  wire       [21:0]   system_plic_logic_bmb_cmd_payload_fragment_address;
  wire       [1:0]    system_plic_logic_bmb_cmd_payload_fragment_length;
  wire       [31:0]   system_plic_logic_bmb_cmd_payload_fragment_data;
  wire       [0:0]    system_plic_logic_bmb_cmd_payload_fragment_context;
  wire                system_plic_logic_bmb_rsp_valid;
  wire                system_plic_logic_bmb_rsp_ready;
  wire                system_plic_logic_bmb_rsp_payload_last;
  wire       [0:0]    system_plic_logic_bmb_rsp_payload_fragment_source;
  wire       [0:0]    system_plic_logic_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   system_plic_logic_bmb_rsp_payload_fragment_data;
  wire       [0:0]    system_plic_logic_bmb_rsp_payload_fragment_context;
  reg                 system_plic_logic_bus_readHaltTrigger;
  wire                system_plic_logic_bus_writeHaltTrigger;
  wire                system_plic_logic_bus_rsp_valid;
  wire                system_plic_logic_bus_rsp_ready;
  wire                system_plic_logic_bus_rsp_payload_last;
  wire       [0:0]    system_plic_logic_bus_rsp_payload_fragment_source;
  wire       [0:0]    system_plic_logic_bus_rsp_payload_fragment_opcode;
  reg        [31:0]   system_plic_logic_bus_rsp_payload_fragment_data;
  wire       [0:0]    system_plic_logic_bus_rsp_payload_fragment_context;
  wire                _zz_system_plic_logic_bmb_rsp_valid;
  reg                 _zz_system_plic_logic_bus_rsp_ready;
  wire                _zz_system_plic_logic_bmb_rsp_valid_1;
  reg                 _zz_system_plic_logic_bmb_rsp_valid_2;
  reg                 _zz_system_plic_logic_bmb_rsp_payload_last;
  reg        [0:0]    _zz_system_plic_logic_bmb_rsp_payload_fragment_source;
  reg        [0:0]    _zz_system_plic_logic_bmb_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_system_plic_logic_bmb_rsp_payload_fragment_data;
  reg        [0:0]    _zz_system_plic_logic_bmb_rsp_payload_fragment_context;
  wire                when_Stream_l342_2;
  wire                system_plic_logic_bus_askWrite;
  wire                system_plic_logic_bus_askRead;
  wire                system_plic_logic_bmb_cmd_fire;
  wire                system_plic_logic_bus_doWrite;
  wire                system_plic_logic_bmb_cmd_fire_1;
  wire                system_plic_logic_bus_doRead;
  wire                system_cores_0_externalInterrupt_plic_target_ie_0;
  wire                system_cores_0_externalInterrupt_plic_target_ie_1;
  wire                system_cores_0_externalInterrupt_plic_target_ie_2;
  wire                system_cores_0_externalInterrupt_plic_target_ie_3;
  wire       [1:0]    system_cores_0_externalInterrupt_plic_target_threshold;
  wire       [1:0]    system_cores_0_externalInterrupt_plic_target_requests_0_priority;
  wire       [3:0]    system_cores_0_externalInterrupt_plic_target_requests_0_id;
  wire                system_cores_0_externalInterrupt_plic_target_requests_0_valid;
  wire       [1:0]    system_cores_0_externalInterrupt_plic_target_requests_1_priority;
  wire       [3:0]    system_cores_0_externalInterrupt_plic_target_requests_1_id;
  wire                system_cores_0_externalInterrupt_plic_target_requests_1_valid;
  wire       [1:0]    system_cores_0_externalInterrupt_plic_target_requests_2_priority;
  wire       [3:0]    system_cores_0_externalInterrupt_plic_target_requests_2_id;
  wire                system_cores_0_externalInterrupt_plic_target_requests_2_valid;
  wire       [1:0]    system_cores_0_externalInterrupt_plic_target_requests_3_priority;
  wire       [3:0]    system_cores_0_externalInterrupt_plic_target_requests_3_id;
  wire                system_cores_0_externalInterrupt_plic_target_requests_3_valid;
  wire       [1:0]    system_cores_0_externalInterrupt_plic_target_requests_4_priority;
  wire       [3:0]    system_cores_0_externalInterrupt_plic_target_requests_4_id;
  wire                system_cores_0_externalInterrupt_plic_target_requests_4_valid;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority;
  wire       [1:0]    _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_1;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_2;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_3;
  wire       [1:0]    _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_4;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_5;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_6;
  wire       [1:0]    _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_7;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_8;
  wire                _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_9;
  reg        [1:0]    system_cores_0_externalInterrupt_plic_target_bestRequest_priority;
  reg        [3:0]    system_cores_0_externalInterrupt_plic_target_bestRequest_id;
  reg                 system_cores_0_externalInterrupt_plic_target_bestRequest_valid;
  wire                system_cores_0_externalInterrupt_plic_target_iep;
  wire       [3:0]    system_cores_0_externalInterrupt_plic_target_claim;
  reg        [1:0]    _zz_system_uart_0_io_interrupt_plic_gateway_priority;
  reg        [1:0]    _zz_system_spi_0_io_interrupt_plic_gateway_priority;
  reg        [1:0]    _zz_system_gpio_0_io_interrupts_0_plic_gateway_priority;
  reg        [1:0]    _zz_system_gpio_0_io_interrupts_1_plic_gateway_priority;
  reg                 system_plic_logic_bridge_claim_valid;
  reg        [3:0]    system_plic_logic_bridge_claim_payload;
  reg                 system_plic_logic_bridge_completion_valid;
  reg        [3:0]    system_plic_logic_bridge_completion_payload;
  reg                 system_plic_logic_bridge_coherencyStall_willIncrement;
  wire                system_plic_logic_bridge_coherencyStall_willClear;
  reg        [0:0]    system_plic_logic_bridge_coherencyStall_valueNext;
  reg        [0:0]    system_plic_logic_bridge_coherencyStall_value;
  wire                system_plic_logic_bridge_coherencyStall_willOverflowIfInc;
  wire                system_plic_logic_bridge_coherencyStall_willOverflow;
  wire                when_PlicMapper_l122;
  reg        [1:0]    _zz_system_cores_0_externalInterrupt_plic_target_threshold;
  reg                 system_plic_logic_bridge_targetMapping_0_targetCompletion_valid;
  wire       [3:0]    system_plic_logic_bridge_targetMapping_0_targetCompletion_payload;
  reg                 _zz_system_cores_0_externalInterrupt_plic_target_ie_0;
  reg                 _zz_system_cores_0_externalInterrupt_plic_target_ie_1;
  reg                 _zz_system_cores_0_externalInterrupt_plic_target_ie_2;
  reg                 _zz_system_cores_0_externalInterrupt_plic_target_ie_3;
  wire                system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  wire                system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  wire                system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  wire       [0:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  wire       [0:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  wire       [21:0]   system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  wire       [1:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  wire       [31:0]   system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  wire       [0:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  wire                system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  wire                system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  wire                system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  wire       [0:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  wire       [0:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  wire       [31:0]   system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  wire       [0:0]    system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_valid_4;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_ready_4;
  wire                system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_4;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_4;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_4;
  wire       [23:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_4;
  wire       [1:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_4;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_4;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_4;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_valid_4;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_ready_4;
  wire                system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_4;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_4;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_4;
  wire       [31:0]   system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_4;
  wire       [0:0]    system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_4;
  wire                when_BmbSlaveFactory_l71;

  assign _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_address = (hardJtag_debug_logic_debugger_io_mem_cmd_payload_address >>> 2);
  assign _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask_1 = ({3'd0,_zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask} <<< hardJtag_debug_logic_debugger_io_mem_cmd_payload_address[1 : 0]);
  JtagBridgeNoTap hardJtag_debug_logic_jtagBridge (
    .io_ctrl_tdi                       (jtagCtrl_tdi                                                    ), //i
    .io_ctrl_enable                    (jtagCtrl_enable                                                 ), //i
    .io_ctrl_capture                   (jtagCtrl_capture                                                ), //i
    .io_ctrl_shift                     (jtagCtrl_shift                                                  ), //i
    .io_ctrl_update                    (jtagCtrl_update                                                 ), //i
    .io_ctrl_reset                     (jtagCtrl_reset                                                  ), //i
    .io_ctrl_tdo                       (hardJtag_debug_logic_jtagBridge_io_ctrl_tdo                     ), //o
    .io_remote_cmd_valid               (hardJtag_debug_logic_jtagBridge_io_remote_cmd_valid             ), //o
    .io_remote_cmd_ready               (hardJtag_debug_logic_debugger_io_remote_cmd_ready               ), //i
    .io_remote_cmd_payload_last        (hardJtag_debug_logic_jtagBridge_io_remote_cmd_payload_last      ), //o
    .io_remote_cmd_payload_fragment    (hardJtag_debug_logic_jtagBridge_io_remote_cmd_payload_fragment  ), //o
    .io_remote_rsp_valid               (hardJtag_debug_logic_debugger_io_remote_rsp_valid               ), //i
    .io_remote_rsp_ready               (hardJtag_debug_logic_jtagBridge_io_remote_rsp_ready             ), //o
    .io_remote_rsp_payload_error       (hardJtag_debug_logic_debugger_io_remote_rsp_payload_error       ), //i
    .io_remote_rsp_payload_data        (hardJtag_debug_logic_debugger_io_remote_rsp_payload_data[31:0]  ), //i
    .io_systemClk                      (io_systemClk                                                    ), //i
    .debugCd_logic_outputReset         (debugCd_logic_outputReset                                       ), //i
    .jtagCtrl_tck                      (jtagCtrl_tck                                                    )  //i
  );
  BufferCC_2 bufferCC_5 (
    .io_dataIn        (1'b0                   ), //i
    .io_dataOut       (bufferCC_5_io_dataOut  ), //o
    .io_systemClk     (io_systemClk           ), //i
    .io_asyncReset    (io_asyncReset          )  //i
  );
  SystemDebugger hardJtag_debug_logic_debugger (
    .io_remote_cmd_valid               (hardJtag_debug_logic_jtagBridge_io_remote_cmd_valid             ), //i
    .io_remote_cmd_ready               (hardJtag_debug_logic_debugger_io_remote_cmd_ready               ), //o
    .io_remote_cmd_payload_last        (hardJtag_debug_logic_jtagBridge_io_remote_cmd_payload_last      ), //i
    .io_remote_cmd_payload_fragment    (hardJtag_debug_logic_jtagBridge_io_remote_cmd_payload_fragment  ), //i
    .io_remote_rsp_valid               (hardJtag_debug_logic_debugger_io_remote_rsp_valid               ), //o
    .io_remote_rsp_ready               (hardJtag_debug_logic_jtagBridge_io_remote_rsp_ready             ), //i
    .io_remote_rsp_payload_error       (hardJtag_debug_logic_debugger_io_remote_rsp_payload_error       ), //o
    .io_remote_rsp_payload_data        (hardJtag_debug_logic_debugger_io_remote_rsp_payload_data[31:0]  ), //o
    .io_mem_cmd_valid                  (hardJtag_debug_logic_debugger_io_mem_cmd_valid                  ), //o
    .io_mem_cmd_ready                  (hardJtag_debug_logic_mmMaster_cmd_ready                         ), //i
    .io_mem_cmd_payload_address        (hardJtag_debug_logic_debugger_io_mem_cmd_payload_address[31:0]  ), //o
    .io_mem_cmd_payload_data           (hardJtag_debug_logic_debugger_io_mem_cmd_payload_data[31:0]     ), //o
    .io_mem_cmd_payload_wr             (hardJtag_debug_logic_debugger_io_mem_cmd_payload_wr             ), //o
    .io_mem_cmd_payload_size           (hardJtag_debug_logic_debugger_io_mem_cmd_payload_size[1:0]      ), //o
    .io_mem_rsp_valid                  (hardJtag_debug_logic_mmMaster_rsp_valid                         ), //i
    .io_mem_rsp_payload                (hardJtag_debug_logic_mmMaster_rsp_payload_fragment_data[31:0]   ), //i
    .io_systemClk                      (io_systemClk                                                    ), //i
    .debugCd_logic_outputReset         (debugCd_logic_outputReset                                       )  //i
  );
  BufferCC_3 bufferCC_6 (
    .io_dataIn                    (1'b0                       ), //i
    .io_dataOut                   (bufferCC_6_io_dataOut      ), //o
    .io_systemClk                 (io_systemClk               ), //i
    .debugCd_logic_outputReset    (debugCd_logic_outputReset  )  //i
  );
  VexRiscv system_cores_0_logic_cpu (
    .iBus_cmd_valid                           (system_cores_0_logic_cpu_iBus_cmd_valid                              ), //o
    .iBus_cmd_ready                           (system_cores_0_iBus_cmd_ready                                        ), //i
    .iBus_cmd_payload_pc                      (system_cores_0_logic_cpu_iBus_cmd_payload_pc[31:0]                   ), //o
    .iBus_rsp_valid                           (system_cores_0_iBus_rsp_valid                                        ), //i
    .iBus_rsp_payload_error                   (system_cores_0_logic_cpu_iBus_rsp_payload_error                      ), //i
    .iBus_rsp_payload_inst                    (system_cores_0_iBus_rsp_payload_fragment_data[31:0]                  ), //i
    .timerInterrupt                           (system_cores_0_logic_cpu_timerInterrupt                              ), //i
    .externalInterrupt                        (system_cores_0_externalInterrupt_plic_target_iep                     ), //i
    .softwareInterrupt                        (system_cores_0_logic_cpu_softwareInterrupt                           ), //i
    .CfuPlugin_bus_cmd_valid                  (system_cores_0_logic_cpu_CfuPlugin_bus_cmd_valid                     ), //o
    .CfuPlugin_bus_cmd_ready                  (cpu0_customInstruction_cmd_ready                                     ), //i
    .CfuPlugin_bus_cmd_payload_function_id    (system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_function_id[9:0]  ), //o
    .CfuPlugin_bus_cmd_payload_inputs_0       (system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_inputs_0[31:0]    ), //o
    .CfuPlugin_bus_cmd_payload_inputs_1       (system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_inputs_1[31:0]    ), //o
    .CfuPlugin_bus_rsp_valid                  (cpu0_customInstruction_rsp_valid                                     ), //i
    .CfuPlugin_bus_rsp_ready                  (system_cores_0_logic_cpu_CfuPlugin_bus_rsp_ready                     ), //o
    .CfuPlugin_bus_rsp_payload_outputs_0      (cpu0_customInstruction_outputs_0[31:0]                               ), //i
    .debug_bus_cmd_valid                      (system_cores_0_debugBmb_cmd_valid                                    ), //i
    .debug_bus_cmd_ready                      (system_cores_0_logic_cpu_debug_bus_cmd_ready                         ), //o
    .debug_bus_cmd_payload_wr                 (system_cores_0_logic_cpu_debug_bus_cmd_payload_wr                    ), //i
    .debug_bus_cmd_payload_address            (system_cores_0_debugBmb_cmd_payload_fragment_address[7:0]            ), //i
    .debug_bus_cmd_payload_data               (system_cores_0_debugBmb_cmd_payload_fragment_data[31:0]              ), //i
    .debug_bus_rsp_data                       (system_cores_0_logic_cpu_debug_bus_rsp_data[31:0]                    ), //o
    .debug_resetOut                           (system_cores_0_logic_cpu_debug_resetOut                              ), //o
    .dBus_cmd_valid                           (system_cores_0_logic_cpu_dBus_cmd_valid                              ), //o
    .dBus_cmd_ready                           (system_cores_0_dBus_cmd_ready                                        ), //i
    .dBus_cmd_payload_wr                      (system_cores_0_logic_cpu_dBus_cmd_payload_wr                         ), //o
    .dBus_cmd_payload_address                 (system_cores_0_logic_cpu_dBus_cmd_payload_address[31:0]              ), //o
    .dBus_cmd_payload_data                    (system_cores_0_logic_cpu_dBus_cmd_payload_data[31:0]                 ), //o
    .dBus_cmd_payload_size                    (system_cores_0_logic_cpu_dBus_cmd_payload_size[1:0]                  ), //o
    .dBus_rsp_ready                           (system_cores_0_logic_cpu_dBus_rsp_ready                              ), //i
    .dBus_rsp_error                           (system_cores_0_logic_cpu_dBus_rsp_error                              ), //i
    .dBus_rsp_data                            (system_cores_0_dBus_rsp_payload_fragment_data[31:0]                  ), //i
    .io_systemClk                             (io_systemClk                                                         ), //i
    .systemCd_logic_outputReset               (systemCd_logic_outputReset                                           ), //i
    .debugCd_logic_outputReset                (debugCd_logic_outputReset                                            )  //i
  );
  BufferCC_4 bufferCC_7 (
    .io_dataIn                    (1'b0                       ), //i
    .io_dataOut                   (bufferCC_7_io_dataOut      ), //o
    .io_systemClk                 (io_systemClk               ), //i
    .system_cores_0_debugReset    (system_cores_0_debugReset  )  //i
  );
  BmbArbiter system_bridge_bmb_arbiter (
    .io_inputs_0_cmd_valid                       (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_valid                           ), //i
    .io_inputs_0_cmd_ready                       (system_bridge_bmb_arbiter_io_inputs_0_cmd_ready                                                    ), //o
    .io_inputs_0_cmd_payload_last                (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_last                    ), //i
    .io_inputs_0_cmd_payload_fragment_opcode     (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_opcode         ), //i
    .io_inputs_0_cmd_payload_fragment_address    (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_address[31:0]  ), //i
    .io_inputs_0_cmd_payload_fragment_length     (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_length[1:0]    ), //i
    .io_inputs_0_cmd_payload_fragment_data       (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_data[31:0]     ), //i
    .io_inputs_0_cmd_payload_fragment_mask       (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_mask[3:0]      ), //i
    .io_inputs_0_cmd_payload_fragment_context    (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_context        ), //i
    .io_inputs_0_rsp_valid                       (system_bridge_bmb_arbiter_io_inputs_0_rsp_valid                                                    ), //o
    .io_inputs_0_rsp_ready                       (system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_ready                           ), //i
    .io_inputs_0_rsp_payload_last                (system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_last                                             ), //o
    .io_inputs_0_rsp_payload_fragment_opcode     (system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode                                  ), //o
    .io_inputs_0_rsp_payload_fragment_data       (system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data[31:0]                              ), //o
    .io_inputs_0_rsp_payload_fragment_context    (system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context                                 ), //o
    .io_inputs_1_cmd_valid                       (system_cores_0_iBus_decoder_io_outputs_0_cmd_valid                                                 ), //i
    .io_inputs_1_cmd_ready                       (system_bridge_bmb_arbiter_io_inputs_1_cmd_ready                                                    ), //o
    .io_inputs_1_cmd_payload_last                (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_last                                          ), //i
    .io_inputs_1_cmd_payload_fragment_opcode     (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_opcode                               ), //i
    .io_inputs_1_cmd_payload_fragment_address    (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_address[31:0]                        ), //i
    .io_inputs_1_cmd_payload_fragment_length     (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_length[1:0]                          ), //i
    .io_inputs_1_cmd_payload_fragment_data       (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                                                               ), //i
    .io_inputs_1_cmd_payload_fragment_mask       (4'bxxxx                                                                                            ), //i
    .io_inputs_1_rsp_valid                       (system_bridge_bmb_arbiter_io_inputs_1_rsp_valid                                                    ), //o
    .io_inputs_1_rsp_ready                       (system_cores_0_iBus_decoder_io_outputs_0_rsp_ready                                                 ), //i
    .io_inputs_1_rsp_payload_last                (system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_last                                             ), //o
    .io_inputs_1_rsp_payload_fragment_opcode     (system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode                                  ), //o
    .io_inputs_1_rsp_payload_fragment_data       (system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data[31:0]                              ), //o
    .io_output_cmd_valid                         (system_bridge_bmb_arbiter_io_output_cmd_valid                                                      ), //o
    .io_output_cmd_ready                         (system_bridge_bmb_cmd_ready                                                                        ), //i
    .io_output_cmd_payload_last                  (system_bridge_bmb_arbiter_io_output_cmd_payload_last                                               ), //o
    .io_output_cmd_payload_fragment_source       (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_source                                    ), //o
    .io_output_cmd_payload_fragment_opcode       (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_opcode                                    ), //o
    .io_output_cmd_payload_fragment_address      (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_address[31:0]                             ), //o
    .io_output_cmd_payload_fragment_length       (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_length[1:0]                               ), //o
    .io_output_cmd_payload_fragment_data         (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_data[31:0]                                ), //o
    .io_output_cmd_payload_fragment_mask         (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_mask[3:0]                                 ), //o
    .io_output_cmd_payload_fragment_context      (system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_context                                   ), //o
    .io_output_rsp_valid                         (system_bridge_bmb_rsp_valid                                                                        ), //i
    .io_output_rsp_ready                         (system_bridge_bmb_arbiter_io_output_rsp_ready                                                      ), //o
    .io_output_rsp_payload_last                  (system_bridge_bmb_rsp_payload_last                                                                 ), //i
    .io_output_rsp_payload_fragment_source       (system_bridge_bmb_rsp_payload_fragment_source                                                      ), //i
    .io_output_rsp_payload_fragment_opcode       (system_bridge_bmb_rsp_payload_fragment_opcode                                                      ), //i
    .io_output_rsp_payload_fragment_data         (system_bridge_bmb_rsp_payload_fragment_data[31:0]                                                  ), //i
    .io_output_rsp_payload_fragment_context      (system_bridge_bmb_rsp_payload_fragment_context                                                     ), //i
    .io_systemClk                                (io_systemClk                                                                                       ), //i
    .systemCd_logic_outputReset                  (systemCd_logic_outputReset                                                                         )  //i
  );
  BmbDecoder system_cores_0_iBus_decoder (
    .io_input_cmd_valid                           (system_cores_0_iBus_cmd_s2mPipe_m2sPipe_valid                                ), //i
    .io_input_cmd_ready                           (system_cores_0_iBus_decoder_io_input_cmd_ready                               ), //o
    .io_input_cmd_payload_last                    (system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_last                         ), //i
    .io_input_cmd_payload_fragment_opcode         (system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_opcode              ), //i
    .io_input_cmd_payload_fragment_address        (system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_address[31:0]       ), //i
    .io_input_cmd_payload_fragment_length         (system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_length[1:0]         ), //i
    .io_input_rsp_valid                           (system_cores_0_iBus_decoder_io_input_rsp_valid                               ), //o
    .io_input_rsp_ready                           (system_cores_0_iBus_rsp_ready                                                ), //i
    .io_input_rsp_payload_last                    (system_cores_0_iBus_decoder_io_input_rsp_payload_last                        ), //o
    .io_input_rsp_payload_fragment_opcode         (system_cores_0_iBus_decoder_io_input_rsp_payload_fragment_opcode             ), //o
    .io_input_rsp_payload_fragment_data           (system_cores_0_iBus_decoder_io_input_rsp_payload_fragment_data[31:0]         ), //o
    .io_outputs_0_cmd_valid                       (system_cores_0_iBus_decoder_io_outputs_0_cmd_valid                           ), //o
    .io_outputs_0_cmd_ready                       (system_bridge_bmb_arbiter_io_inputs_1_cmd_ready                              ), //i
    .io_outputs_0_cmd_payload_last                (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_last                    ), //o
    .io_outputs_0_cmd_payload_fragment_opcode     (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_opcode         ), //o
    .io_outputs_0_cmd_payload_fragment_address    (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_address[31:0]  ), //o
    .io_outputs_0_cmd_payload_fragment_length     (system_cores_0_iBus_decoder_io_outputs_0_cmd_payload_fragment_length[1:0]    ), //o
    .io_outputs_0_rsp_valid                       (system_bridge_bmb_arbiter_io_inputs_1_rsp_valid                              ), //i
    .io_outputs_0_rsp_ready                       (system_cores_0_iBus_decoder_io_outputs_0_rsp_ready                           ), //o
    .io_outputs_0_rsp_payload_last                (system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_last                       ), //i
    .io_outputs_0_rsp_payload_fragment_opcode     (system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode            ), //i
    .io_outputs_0_rsp_payload_fragment_data       (system_bridge_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data[31:0]        )  //i
  );
  BmbDecoder_1 system_bridge_bmb_decoder (
    .io_input_cmd_valid                           (system_bridge_bmb_cmd_valid                                                                      ), //i
    .io_input_cmd_ready                           (system_bridge_bmb_decoder_io_input_cmd_ready                                                     ), //o
    .io_input_cmd_payload_last                    (system_bridge_bmb_cmd_payload_last                                                               ), //i
    .io_input_cmd_payload_fragment_source         (system_bridge_bmb_cmd_payload_fragment_source                                                    ), //i
    .io_input_cmd_payload_fragment_opcode         (system_bridge_bmb_cmd_payload_fragment_opcode                                                    ), //i
    .io_input_cmd_payload_fragment_address        (system_bridge_bmb_cmd_payload_fragment_address[31:0]                                             ), //i
    .io_input_cmd_payload_fragment_length         (system_bridge_bmb_cmd_payload_fragment_length[1:0]                                               ), //i
    .io_input_cmd_payload_fragment_data           (system_bridge_bmb_cmd_payload_fragment_data[31:0]                                                ), //i
    .io_input_cmd_payload_fragment_mask           (system_bridge_bmb_cmd_payload_fragment_mask[3:0]                                                 ), //i
    .io_input_cmd_payload_fragment_context        (system_bridge_bmb_cmd_payload_fragment_context                                                   ), //i
    .io_input_rsp_valid                           (system_bridge_bmb_decoder_io_input_rsp_valid                                                     ), //o
    .io_input_rsp_ready                           (system_bridge_bmb_rsp_ready                                                                      ), //i
    .io_input_rsp_payload_last                    (system_bridge_bmb_decoder_io_input_rsp_payload_last                                              ), //o
    .io_input_rsp_payload_fragment_source         (system_bridge_bmb_decoder_io_input_rsp_payload_fragment_source                                   ), //o
    .io_input_rsp_payload_fragment_opcode         (system_bridge_bmb_decoder_io_input_rsp_payload_fragment_opcode                                   ), //o
    .io_input_rsp_payload_fragment_data           (system_bridge_bmb_decoder_io_input_rsp_payload_fragment_data[31:0]                               ), //o
    .io_input_rsp_payload_fragment_context        (system_bridge_bmb_decoder_io_input_rsp_payload_fragment_context                                  ), //o
    .io_outputs_0_cmd_valid                       (system_bridge_bmb_decoder_io_outputs_0_cmd_valid                                                 ), //o
    .io_outputs_0_cmd_ready                       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready                                ), //i
    .io_outputs_0_cmd_payload_last                (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_last                                          ), //o
    .io_outputs_0_cmd_payload_fragment_source     (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_source                               ), //o
    .io_outputs_0_cmd_payload_fragment_opcode     (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_opcode                               ), //o
    .io_outputs_0_cmd_payload_fragment_address    (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address[31:0]                        ), //o
    .io_outputs_0_cmd_payload_fragment_length     (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_length[1:0]                          ), //o
    .io_outputs_0_cmd_payload_fragment_data       (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_data[31:0]                           ), //o
    .io_outputs_0_cmd_payload_fragment_mask       (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_mask[3:0]                            ), //o
    .io_outputs_0_cmd_payload_fragment_context    (system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_context                              ), //o
    .io_outputs_0_rsp_valid                       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid                                ), //i
    .io_outputs_0_rsp_ready                       (system_bridge_bmb_decoder_io_outputs_0_rsp_ready                                                 ), //o
    .io_outputs_0_rsp_payload_last                (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last                         ), //i
    .io_outputs_0_rsp_payload_fragment_source     (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source              ), //i
    .io_outputs_0_rsp_payload_fragment_opcode     (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode              ), //i
    .io_outputs_0_rsp_payload_fragment_data       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data[31:0]          ), //i
    .io_outputs_0_rsp_payload_fragment_context    (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context             ), //i
    .io_outputs_1_cmd_valid                       (system_bridge_bmb_decoder_io_outputs_1_cmd_valid                                                 ), //o
    .io_outputs_1_cmd_ready                       (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready                        ), //i
    .io_outputs_1_cmd_payload_last                (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_last                                          ), //o
    .io_outputs_1_cmd_payload_fragment_source     (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_source                               ), //o
    .io_outputs_1_cmd_payload_fragment_opcode     (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_opcode                               ), //o
    .io_outputs_1_cmd_payload_fragment_address    (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_address[31:0]                        ), //o
    .io_outputs_1_cmd_payload_fragment_length     (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_length[1:0]                          ), //o
    .io_outputs_1_cmd_payload_fragment_data       (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_data[31:0]                           ), //o
    .io_outputs_1_cmd_payload_fragment_mask       (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_mask[3:0]                            ), //o
    .io_outputs_1_cmd_payload_fragment_context    (system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_context                              ), //o
    .io_outputs_1_rsp_valid                       (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid                        ), //i
    .io_outputs_1_rsp_ready                       (system_bridge_bmb_decoder_io_outputs_1_rsp_ready                                                 ), //o
    .io_outputs_1_rsp_payload_last                (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last                 ), //i
    .io_outputs_1_rsp_payload_fragment_source     (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source      ), //i
    .io_outputs_1_rsp_payload_fragment_opcode     (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode      ), //i
    .io_outputs_1_rsp_payload_fragment_data       (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data[31:0]  ), //i
    .io_outputs_1_rsp_payload_fragment_context    (system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context     ), //i
    .io_systemClk                                 (io_systemClk                                                                                     ), //i
    .systemCd_logic_outputReset                   (systemCd_logic_outputReset                                                                       )  //i
  );
  BmbDecoder_2 bmbDecoder_4 (
    .io_input_cmd_valid                           (hardJtag_debug_bmb_connector_decoder_cmd_valid                                                  ), //i
    .io_input_cmd_ready                           (bmbDecoder_4_io_input_cmd_ready                                                                 ), //o
    .io_input_cmd_payload_last                    (hardJtag_debug_bmb_connector_decoder_cmd_payload_last                                           ), //i
    .io_input_cmd_payload_fragment_opcode         (hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_opcode                                ), //i
    .io_input_cmd_payload_fragment_address        (hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_address[31:0]                         ), //i
    .io_input_cmd_payload_fragment_length         (hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_length[1:0]                           ), //i
    .io_input_cmd_payload_fragment_data           (hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_data[31:0]                            ), //i
    .io_input_cmd_payload_fragment_mask           (hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_mask[3:0]                             ), //i
    .io_input_rsp_valid                           (bmbDecoder_4_io_input_rsp_valid                                                                 ), //o
    .io_input_rsp_ready                           (hardJtag_debug_bmb_connector_decoder_rsp_ready                                                  ), //i
    .io_input_rsp_payload_last                    (bmbDecoder_4_io_input_rsp_payload_last                                                          ), //o
    .io_input_rsp_payload_fragment_opcode         (bmbDecoder_4_io_input_rsp_payload_fragment_opcode                                               ), //o
    .io_input_rsp_payload_fragment_data           (bmbDecoder_4_io_input_rsp_payload_fragment_data[31:0]                                           ), //o
    .io_outputs_0_cmd_valid                       (bmbDecoder_4_io_outputs_0_cmd_valid                                                             ), //o
    .io_outputs_0_cmd_ready                       (system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready                        ), //i
    .io_outputs_0_cmd_payload_last                (bmbDecoder_4_io_outputs_0_cmd_payload_last                                                      ), //o
    .io_outputs_0_cmd_payload_fragment_opcode     (bmbDecoder_4_io_outputs_0_cmd_payload_fragment_opcode                                           ), //o
    .io_outputs_0_cmd_payload_fragment_address    (bmbDecoder_4_io_outputs_0_cmd_payload_fragment_address[31:0]                                    ), //o
    .io_outputs_0_cmd_payload_fragment_length     (bmbDecoder_4_io_outputs_0_cmd_payload_fragment_length[1:0]                                      ), //o
    .io_outputs_0_cmd_payload_fragment_data       (bmbDecoder_4_io_outputs_0_cmd_payload_fragment_data[31:0]                                       ), //o
    .io_outputs_0_cmd_payload_fragment_mask       (bmbDecoder_4_io_outputs_0_cmd_payload_fragment_mask[3:0]                                        ), //o
    .io_outputs_0_rsp_valid                       (system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid                        ), //i
    .io_outputs_0_rsp_ready                       (bmbDecoder_4_io_outputs_0_rsp_ready                                                             ), //o
    .io_outputs_0_rsp_payload_last                (system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last                 ), //i
    .io_outputs_0_rsp_payload_fragment_opcode     (system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode      ), //i
    .io_outputs_0_rsp_payload_fragment_data       (system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data[31:0]  ), //i
    .io_systemClk                                 (io_systemClk                                                                                    ), //i
    .debugCd_logic_outputReset                    (debugCd_logic_outputReset                                                                       )  //i
  );
  BmbOnChipRam system_ramA_logic (
    .io_bus_cmd_valid                       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid                           ), //i
    .io_bus_cmd_ready                       (system_ramA_logic_io_bus_cmd_ready                                                          ), //o
    .io_bus_cmd_payload_last                (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last                    ), //i
    .io_bus_cmd_payload_fragment_source     (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source         ), //i
    .io_bus_cmd_payload_fragment_opcode     (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode         ), //i
    .io_bus_cmd_payload_fragment_address    (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address[12:0]  ), //i
    .io_bus_cmd_payload_fragment_length     (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length[1:0]    ), //i
    .io_bus_cmd_payload_fragment_data       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data[31:0]     ), //i
    .io_bus_cmd_payload_fragment_mask       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask[3:0]      ), //i
    .io_bus_cmd_payload_fragment_context    (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context        ), //i
    .io_bus_rsp_valid                       (system_ramA_logic_io_bus_rsp_valid                                                          ), //o
    .io_bus_rsp_ready                       (system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready                           ), //i
    .io_bus_rsp_payload_last                (system_ramA_logic_io_bus_rsp_payload_last                                                   ), //o
    .io_bus_rsp_payload_fragment_source     (system_ramA_logic_io_bus_rsp_payload_fragment_source                                        ), //o
    .io_bus_rsp_payload_fragment_opcode     (system_ramA_logic_io_bus_rsp_payload_fragment_opcode                                        ), //o
    .io_bus_rsp_payload_fragment_data       (system_ramA_logic_io_bus_rsp_payload_fragment_data[31:0]                                    ), //o
    .io_bus_rsp_payload_fragment_context    (system_ramA_logic_io_bus_rsp_payload_fragment_context                                       ), //o
    .io_systemClk                           (io_systemClk                                                                                ), //i
    .systemCd_logic_outputReset             (systemCd_logic_outputReset                                                                  )  //i
  );
  BmbDecoder_3 system_bmbPeripheral_bmb_decoder (
    .io_input_cmd_valid                           (system_bmbPeripheral_bmb_cmd_halfPipe_valid                                       ), //i
    .io_input_cmd_ready                           (system_bmbPeripheral_bmb_decoder_io_input_cmd_ready                               ), //o
    .io_input_cmd_payload_last                    (system_bmbPeripheral_bmb_cmd_halfPipe_payload_last                                ), //i
    .io_input_cmd_payload_fragment_source         (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_source                     ), //i
    .io_input_cmd_payload_fragment_opcode         (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_opcode                     ), //i
    .io_input_cmd_payload_fragment_address        (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_address[23:0]              ), //i
    .io_input_cmd_payload_fragment_length         (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_length[1:0]                ), //i
    .io_input_cmd_payload_fragment_data           (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_data[31:0]                 ), //i
    .io_input_cmd_payload_fragment_mask           (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_mask[3:0]                  ), //i
    .io_input_cmd_payload_fragment_context        (system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_context                    ), //i
    .io_input_rsp_valid                           (system_bmbPeripheral_bmb_decoder_io_input_rsp_valid                               ), //o
    .io_input_rsp_ready                           (_zz_io_input_rsp_ready                                                            ), //i
    .io_input_rsp_payload_last                    (system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_last                        ), //o
    .io_input_rsp_payload_fragment_source         (system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_source             ), //o
    .io_input_rsp_payload_fragment_opcode         (system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_opcode             ), //o
    .io_input_rsp_payload_fragment_data           (system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_data[31:0]         ), //o
    .io_input_rsp_payload_fragment_context        (system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_context            ), //o
    .io_outputs_0_cmd_valid                       (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_valid                           ), //o
    .io_outputs_0_cmd_ready                       (system_bmbPeripheral_bmb_withoutMask_cmd_ready_4                                  ), //i
    .io_outputs_0_cmd_payload_last                (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_last                    ), //o
    .io_outputs_0_cmd_payload_fragment_source     (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_source         ), //o
    .io_outputs_0_cmd_payload_fragment_opcode     (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_opcode         ), //o
    .io_outputs_0_cmd_payload_fragment_address    (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_address[23:0]  ), //o
    .io_outputs_0_cmd_payload_fragment_length     (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_length[1:0]    ), //o
    .io_outputs_0_cmd_payload_fragment_data       (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_data[31:0]     ), //o
    .io_outputs_0_cmd_payload_fragment_mask       (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_mask[3:0]      ), //o
    .io_outputs_0_cmd_payload_fragment_context    (system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_context        ), //o
    .io_outputs_0_rsp_valid                       (system_bmbPeripheral_bmb_withoutMask_rsp_valid_4                                  ), //i
    .io_outputs_0_rsp_ready                       (system_bmbPeripheral_bmb_decoder_io_outputs_0_rsp_ready                           ), //o
    .io_outputs_0_rsp_payload_last                (system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_4                           ), //i
    .io_outputs_0_rsp_payload_fragment_source     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_4                ), //i
    .io_outputs_0_rsp_payload_fragment_opcode     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_4                ), //i
    .io_outputs_0_rsp_payload_fragment_data       (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_4[31:0]            ), //i
    .io_outputs_0_rsp_payload_fragment_context    (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_4               ), //i
    .io_outputs_1_cmd_valid                       (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_valid                           ), //o
    .io_outputs_1_cmd_ready                       (system_bmbPeripheral_bmb_withoutMask_cmd_ready                                    ), //i
    .io_outputs_1_cmd_payload_last                (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_last                    ), //o
    .io_outputs_1_cmd_payload_fragment_source     (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_source         ), //o
    .io_outputs_1_cmd_payload_fragment_opcode     (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_opcode         ), //o
    .io_outputs_1_cmd_payload_fragment_address    (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_address[23:0]  ), //o
    .io_outputs_1_cmd_payload_fragment_length     (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_length[1:0]    ), //o
    .io_outputs_1_cmd_payload_fragment_data       (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_data[31:0]     ), //o
    .io_outputs_1_cmd_payload_fragment_mask       (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_mask[3:0]      ), //o
    .io_outputs_1_cmd_payload_fragment_context    (system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_context        ), //o
    .io_outputs_1_rsp_valid                       (system_bmbPeripheral_bmb_withoutMask_rsp_valid                                    ), //i
    .io_outputs_1_rsp_ready                       (system_bmbPeripheral_bmb_decoder_io_outputs_1_rsp_ready                           ), //o
    .io_outputs_1_rsp_payload_last                (system_bmbPeripheral_bmb_withoutMask_rsp_payload_last                             ), //i
    .io_outputs_1_rsp_payload_fragment_source     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source                  ), //i
    .io_outputs_1_rsp_payload_fragment_opcode     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode                  ), //i
    .io_outputs_1_rsp_payload_fragment_data       (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data[31:0]              ), //i
    .io_outputs_1_rsp_payload_fragment_context    (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context                 ), //i
    .io_outputs_2_cmd_valid                       (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_valid                           ), //o
    .io_outputs_2_cmd_ready                       (system_bmbPeripheral_bmb_withoutMask_cmd_ready_1                                  ), //i
    .io_outputs_2_cmd_payload_last                (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_last                    ), //o
    .io_outputs_2_cmd_payload_fragment_source     (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_source         ), //o
    .io_outputs_2_cmd_payload_fragment_opcode     (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_opcode         ), //o
    .io_outputs_2_cmd_payload_fragment_address    (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_address[23:0]  ), //o
    .io_outputs_2_cmd_payload_fragment_length     (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_length[1:0]    ), //o
    .io_outputs_2_cmd_payload_fragment_data       (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_data[31:0]     ), //o
    .io_outputs_2_cmd_payload_fragment_mask       (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_mask[3:0]      ), //o
    .io_outputs_2_cmd_payload_fragment_context    (system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_context        ), //o
    .io_outputs_2_rsp_valid                       (system_bmbPeripheral_bmb_withoutMask_rsp_valid_1                                  ), //i
    .io_outputs_2_rsp_ready                       (system_bmbPeripheral_bmb_decoder_io_outputs_2_rsp_ready                           ), //o
    .io_outputs_2_rsp_payload_last                (system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_1                           ), //i
    .io_outputs_2_rsp_payload_fragment_source     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_1                ), //i
    .io_outputs_2_rsp_payload_fragment_opcode     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_1                ), //i
    .io_outputs_2_rsp_payload_fragment_data       (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_1[31:0]            ), //i
    .io_outputs_2_rsp_payload_fragment_context    (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_1               ), //i
    .io_outputs_3_cmd_valid                       (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_valid                           ), //o
    .io_outputs_3_cmd_ready                       (system_bmbPeripheral_bmb_withoutMask_cmd_ready_2                                  ), //i
    .io_outputs_3_cmd_payload_last                (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_last                    ), //o
    .io_outputs_3_cmd_payload_fragment_source     (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_source         ), //o
    .io_outputs_3_cmd_payload_fragment_opcode     (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_opcode         ), //o
    .io_outputs_3_cmd_payload_fragment_address    (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_address[23:0]  ), //o
    .io_outputs_3_cmd_payload_fragment_length     (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_length[1:0]    ), //o
    .io_outputs_3_cmd_payload_fragment_data       (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_data[31:0]     ), //o
    .io_outputs_3_cmd_payload_fragment_mask       (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_mask[3:0]      ), //o
    .io_outputs_3_cmd_payload_fragment_context    (system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_context        ), //o
    .io_outputs_3_rsp_valid                       (system_bmbPeripheral_bmb_withoutMask_rsp_valid_2                                  ), //i
    .io_outputs_3_rsp_ready                       (system_bmbPeripheral_bmb_decoder_io_outputs_3_rsp_ready                           ), //o
    .io_outputs_3_rsp_payload_last                (system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_2                           ), //i
    .io_outputs_3_rsp_payload_fragment_source     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_2                ), //i
    .io_outputs_3_rsp_payload_fragment_opcode     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_2                ), //i
    .io_outputs_3_rsp_payload_fragment_data       (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_2[31:0]            ), //i
    .io_outputs_3_rsp_payload_fragment_context    (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_2               ), //i
    .io_outputs_4_cmd_valid                       (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_valid                           ), //o
    .io_outputs_4_cmd_ready                       (system_bmbPeripheral_bmb_withoutMask_cmd_ready_3                                  ), //i
    .io_outputs_4_cmd_payload_last                (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_last                    ), //o
    .io_outputs_4_cmd_payload_fragment_source     (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_source         ), //o
    .io_outputs_4_cmd_payload_fragment_opcode     (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_opcode         ), //o
    .io_outputs_4_cmd_payload_fragment_address    (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_address[23:0]  ), //o
    .io_outputs_4_cmd_payload_fragment_length     (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_length[1:0]    ), //o
    .io_outputs_4_cmd_payload_fragment_data       (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_data[31:0]     ), //o
    .io_outputs_4_cmd_payload_fragment_mask       (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_mask[3:0]      ), //o
    .io_outputs_4_cmd_payload_fragment_context    (system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_context        ), //o
    .io_outputs_4_rsp_valid                       (system_bmbPeripheral_bmb_withoutMask_rsp_valid_3                                  ), //i
    .io_outputs_4_rsp_ready                       (system_bmbPeripheral_bmb_decoder_io_outputs_4_rsp_ready                           ), //o
    .io_outputs_4_rsp_payload_last                (system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_3                           ), //i
    .io_outputs_4_rsp_payload_fragment_source     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_3                ), //i
    .io_outputs_4_rsp_payload_fragment_opcode     (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_3                ), //i
    .io_outputs_4_rsp_payload_fragment_data       (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_3[31:0]            ), //i
    .io_outputs_4_rsp_payload_fragment_context    (system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_3               ), //i
    .io_systemClk                                 (io_systemClk                                                                      ), //i
    .systemCd_logic_outputReset                   (systemCd_logic_outputReset                                                        )  //i
  );
  BmbClint system_clint_logic (
    .io_bus_cmd_valid                       (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid                           ), //i
    .io_bus_cmd_ready                       (system_clint_logic_io_bus_cmd_ready                                                          ), //o
    .io_bus_cmd_payload_last                (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last                    ), //i
    .io_bus_cmd_payload_fragment_source     (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source         ), //i
    .io_bus_cmd_payload_fragment_opcode     (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode         ), //i
    .io_bus_cmd_payload_fragment_address    (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address[15:0]  ), //i
    .io_bus_cmd_payload_fragment_length     (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length[1:0]    ), //i
    .io_bus_cmd_payload_fragment_data       (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data[31:0]     ), //i
    .io_bus_cmd_payload_fragment_context    (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context        ), //i
    .io_bus_rsp_valid                       (system_clint_logic_io_bus_rsp_valid                                                          ), //o
    .io_bus_rsp_ready                       (system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready                           ), //i
    .io_bus_rsp_payload_last                (system_clint_logic_io_bus_rsp_payload_last                                                   ), //o
    .io_bus_rsp_payload_fragment_source     (system_clint_logic_io_bus_rsp_payload_fragment_source                                        ), //o
    .io_bus_rsp_payload_fragment_opcode     (system_clint_logic_io_bus_rsp_payload_fragment_opcode                                        ), //o
    .io_bus_rsp_payload_fragment_data       (system_clint_logic_io_bus_rsp_payload_fragment_data[31:0]                                    ), //o
    .io_bus_rsp_payload_fragment_context    (system_clint_logic_io_bus_rsp_payload_fragment_context                                       ), //o
    .io_timerInterrupt                      (system_clint_logic_io_timerInterrupt                                                         ), //o
    .io_softwareInterrupt                   (system_clint_logic_io_softwareInterrupt                                                      ), //o
    .io_time                                (system_clint_logic_io_time[63:0]                                                             ), //o
    .io_systemClk                           (io_systemClk                                                                                 ), //i
    .systemCd_logic_outputReset             (systemCd_logic_outputReset                                                                   )  //i
  );
  BmbUartCtrl system_uart_0_io_logic (
    .io_bus_cmd_valid                       (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid                          ), //i
    .io_bus_cmd_ready                       (system_uart_0_io_logic_io_bus_cmd_ready                                                                  ), //o
    .io_bus_cmd_payload_last                (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_last                   ), //i
    .io_bus_cmd_payload_fragment_source     (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_source        ), //i
    .io_bus_cmd_payload_fragment_opcode     (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_opcode        ), //i
    .io_bus_cmd_payload_fragment_address    (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_address[5:0]  ), //i
    .io_bus_cmd_payload_fragment_length     (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_length[1:0]   ), //i
    .io_bus_cmd_payload_fragment_data       (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_data[31:0]    ), //i
    .io_bus_cmd_payload_fragment_context    (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_context       ), //i
    .io_bus_rsp_valid                       (system_uart_0_io_logic_io_bus_rsp_valid                                                                  ), //o
    .io_bus_rsp_ready                       (_zz_io_bus_rsp_ready                                                                                     ), //i
    .io_bus_rsp_payload_last                (system_uart_0_io_logic_io_bus_rsp_payload_last                                                           ), //o
    .io_bus_rsp_payload_fragment_source     (system_uart_0_io_logic_io_bus_rsp_payload_fragment_source                                                ), //o
    .io_bus_rsp_payload_fragment_opcode     (system_uart_0_io_logic_io_bus_rsp_payload_fragment_opcode                                                ), //o
    .io_bus_rsp_payload_fragment_data       (system_uart_0_io_logic_io_bus_rsp_payload_fragment_data[31:0]                                            ), //o
    .io_bus_rsp_payload_fragment_context    (system_uart_0_io_logic_io_bus_rsp_payload_fragment_context                                               ), //o
    .io_uart_txd                            (system_uart_0_io_logic_io_uart_txd                                                                       ), //o
    .io_uart_rxd                            (system_uart_0_io_rxd                                                                                     ), //i
    .io_interrupt                           (system_uart_0_io_logic_io_interrupt                                                                      ), //o
    .io_systemClk                           (io_systemClk                                                                                             ), //i
    .systemCd_logic_outputReset             (systemCd_logic_outputReset                                                                               )  //i
  );
  BmbSpiXdrMasterCtrl system_spi_0_io_logic (
    .io_ctrl_cmd_valid                       (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid                           ), //i
    .io_ctrl_cmd_ready                       (system_spi_0_io_logic_io_ctrl_cmd_ready                                                                  ), //o
    .io_ctrl_cmd_payload_last                (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_last                    ), //i
    .io_ctrl_cmd_payload_fragment_source     (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_source         ), //i
    .io_ctrl_cmd_payload_fragment_opcode     (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_opcode         ), //i
    .io_ctrl_cmd_payload_fragment_address    (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_address[11:0]  ), //i
    .io_ctrl_cmd_payload_fragment_length     (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_length[1:0]    ), //i
    .io_ctrl_cmd_payload_fragment_data       (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_data[31:0]     ), //i
    .io_ctrl_cmd_payload_fragment_context    (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_context        ), //i
    .io_ctrl_rsp_valid                       (system_spi_0_io_logic_io_ctrl_rsp_valid                                                                  ), //o
    .io_ctrl_rsp_ready                       (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready                                    ), //i
    .io_ctrl_rsp_payload_last                (system_spi_0_io_logic_io_ctrl_rsp_payload_last                                                           ), //o
    .io_ctrl_rsp_payload_fragment_source     (system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_source                                                ), //o
    .io_ctrl_rsp_payload_fragment_opcode     (system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_opcode                                                ), //o
    .io_ctrl_rsp_payload_fragment_data       (system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_data[31:0]                                            ), //o
    .io_ctrl_rsp_payload_fragment_context    (system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_context                                               ), //o
    .io_spi_sclk_write                       (system_spi_0_io_logic_io_spi_sclk_write                                                                  ), //o
    .io_spi_data_0_writeEnable               (system_spi_0_io_logic_io_spi_data_0_writeEnable                                                          ), //o
    .io_spi_data_0_read                      (system_spi_0_io_data_0_read                                                                              ), //i
    .io_spi_data_0_write                     (system_spi_0_io_logic_io_spi_data_0_write                                                                ), //o
    .io_spi_data_1_writeEnable               (system_spi_0_io_logic_io_spi_data_1_writeEnable                                                          ), //o
    .io_spi_data_1_read                      (system_spi_0_io_data_1_read                                                                              ), //i
    .io_spi_data_1_write                     (system_spi_0_io_logic_io_spi_data_1_write                                                                ), //o
    .io_spi_data_2_writeEnable               (system_spi_0_io_logic_io_spi_data_2_writeEnable                                                          ), //o
    .io_spi_data_2_read                      (system_spi_0_io_data_2_read                                                                              ), //i
    .io_spi_data_2_write                     (system_spi_0_io_logic_io_spi_data_2_write                                                                ), //o
    .io_spi_data_3_writeEnable               (system_spi_0_io_logic_io_spi_data_3_writeEnable                                                          ), //o
    .io_spi_data_3_read                      (system_spi_0_io_data_3_read                                                                              ), //i
    .io_spi_data_3_write                     (system_spi_0_io_logic_io_spi_data_3_write                                                                ), //o
    .io_spi_ss                               (system_spi_0_io_logic_io_spi_ss                                                                          ), //o
    .io_interrupt                            (system_spi_0_io_logic_io_interrupt                                                                       ), //o
    .io_systemClk                            (io_systemClk                                                                                             ), //i
    .systemCd_logic_outputReset              (systemCd_logic_outputReset                                                                               )  //i
  );
  BmbGpio2 system_gpio_0_io_logic (
    .io_gpio_read                           (system_gpio_0_io_read[15:0]                                                                     ), //i
    .io_gpio_write                          (system_gpio_0_io_logic_io_gpio_write[15:0]                                                      ), //o
    .io_gpio_writeEnable                    (system_gpio_0_io_logic_io_gpio_writeEnable[15:0]                                                ), //o
    .io_bus_cmd_valid                       (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid                          ), //i
    .io_bus_cmd_ready                       (system_gpio_0_io_logic_io_bus_cmd_ready                                                         ), //o
    .io_bus_cmd_payload_last                (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last                   ), //i
    .io_bus_cmd_payload_fragment_source     (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source        ), //i
    .io_bus_cmd_payload_fragment_opcode     (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode        ), //i
    .io_bus_cmd_payload_fragment_address    (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address[7:0]  ), //i
    .io_bus_cmd_payload_fragment_length     (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length[1:0]   ), //i
    .io_bus_cmd_payload_fragment_data       (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data[31:0]    ), //i
    .io_bus_cmd_payload_fragment_context    (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context       ), //i
    .io_bus_rsp_valid                       (system_gpio_0_io_logic_io_bus_rsp_valid                                                         ), //o
    .io_bus_rsp_ready                       (system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready                          ), //i
    .io_bus_rsp_payload_last                (system_gpio_0_io_logic_io_bus_rsp_payload_last                                                  ), //o
    .io_bus_rsp_payload_fragment_source     (system_gpio_0_io_logic_io_bus_rsp_payload_fragment_source                                       ), //o
    .io_bus_rsp_payload_fragment_opcode     (system_gpio_0_io_logic_io_bus_rsp_payload_fragment_opcode                                       ), //o
    .io_bus_rsp_payload_fragment_data       (system_gpio_0_io_logic_io_bus_rsp_payload_fragment_data[31:0]                                   ), //o
    .io_bus_rsp_payload_fragment_context    (system_gpio_0_io_logic_io_bus_rsp_payload_fragment_context                                      ), //o
    .io_interrupt                           (system_gpio_0_io_logic_io_interrupt[15:0]                                                       ), //o
    .io_systemClk                           (io_systemClk                                                                                    ), //i
    .systemCd_logic_outputReset             (systemCd_logic_outputReset                                                                      )  //i
  );
  always @(*) begin
    debugCd_logic_inputResetTrigger = 1'b0;
    if(debugCd_logic_inputResetAdapter_stuff_syncTrigger) begin
      debugCd_logic_inputResetTrigger = 1'b1;
    end
  end

  always @(*) begin
    debugCd_logic_outputResetUnbuffered = 1'b0;
    if(when_ClockDomainGenerator_l77) begin
      debugCd_logic_outputResetUnbuffered = 1'b1;
    end
  end

  assign when_ClockDomainGenerator_l77 = (debugCd_logic_holdingLogic_resetCounter != 12'hfff);
  assign debugCd_logic_inputResetAdapter_stuff_syncTrigger = bufferCC_5_io_dataOut;
  assign hardJtag_debug_logic_mmMaster_cmd_valid = hardJtag_debug_logic_debugger_io_mem_cmd_valid;
  assign hardJtag_debug_logic_mmMaster_cmd_payload_last = 1'b1;
  assign hardJtag_debug_logic_mmMaster_cmd_payload_fragment_length = 2'b11;
  assign hardJtag_debug_logic_mmMaster_cmd_payload_fragment_opcode = (hardJtag_debug_logic_debugger_io_mem_cmd_payload_wr ? 1'b1 : 1'b0);
  assign hardJtag_debug_logic_mmMaster_cmd_payload_fragment_address = {_zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_address,2'b00};
  assign hardJtag_debug_logic_mmMaster_cmd_payload_fragment_data = hardJtag_debug_logic_debugger_io_mem_cmd_payload_data;
  always @(*) begin
    case(hardJtag_debug_logic_debugger_io_mem_cmd_payload_size)
      2'b00 : begin
        _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask = 4'b0001;
      end
      2'b01 : begin
        _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask = 4'b0011;
      end
      default : begin
        _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask = 4'b1111;
      end
    endcase
  end

  assign hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask = _zz_hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask_1[3:0];
  assign hardJtag_debug_logic_mmMaster_rsp_ready = 1'b1;
  always @(*) begin
    systemCd_logic_inputResetTrigger = 1'b0;
    if(bufferCC_6_io_dataOut) begin
      systemCd_logic_inputResetTrigger = 1'b1;
    end
    if(bufferCC_7_io_dataOut) begin
      systemCd_logic_inputResetTrigger = 1'b1;
    end
  end

  always @(*) begin
    systemCd_logic_outputResetUnbuffered = 1'b0;
    if(when_ClockDomainGenerator_l77_1) begin
      systemCd_logic_outputResetUnbuffered = 1'b1;
    end
  end

  assign when_ClockDomainGenerator_l77_1 = (systemCd_logic_holdingLogic_resetCounter != 6'h3f);
  assign jtagCtrl_tdo = hardJtag_debug_logic_jtagBridge_io_ctrl_tdo;
  assign system_cores_0_iBus_cmd_valid = system_cores_0_logic_cpu_iBus_cmd_valid;
  assign system_cores_0_iBus_cmd_payload_fragment_opcode = 1'b0;
  assign system_cores_0_iBus_cmd_payload_fragment_address = system_cores_0_logic_cpu_iBus_cmd_payload_pc;
  assign system_cores_0_iBus_cmd_payload_fragment_length = 2'b11;
  assign system_cores_0_iBus_cmd_payload_last = 1'b1;
  assign system_cores_0_logic_cpu_iBus_rsp_payload_error = (system_cores_0_iBus_rsp_payload_fragment_opcode == 1'b1);
  assign system_cores_0_iBus_rsp_ready = 1'b1;
  assign system_cores_0_dBus_cmd_valid = system_cores_0_logic_cpu_dBus_cmd_valid;
  assign system_cores_0_dBus_cmd_payload_last = 1'b1;
  assign system_cores_0_dBus_cmd_payload_fragment_context[0] = system_cores_0_logic_cpu_dBus_cmd_payload_wr;
  assign system_cores_0_dBus_cmd_payload_fragment_opcode = (system_cores_0_logic_cpu_dBus_cmd_payload_wr ? 1'b1 : 1'b0);
  assign system_cores_0_dBus_cmd_payload_fragment_address = system_cores_0_logic_cpu_dBus_cmd_payload_address;
  assign system_cores_0_dBus_cmd_payload_fragment_data = system_cores_0_logic_cpu_dBus_cmd_payload_data;
  always @(*) begin
    case(system_cores_0_logic_cpu_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_system_cores_0_dBus_cmd_payload_fragment_length = 2'b00;
      end
      2'b01 : begin
        _zz_system_cores_0_dBus_cmd_payload_fragment_length = 2'b01;
      end
      default : begin
        _zz_system_cores_0_dBus_cmd_payload_fragment_length = 2'b11;
      end
    endcase
  end

  assign system_cores_0_dBus_cmd_payload_fragment_length = _zz_system_cores_0_dBus_cmd_payload_fragment_length;
  always @(*) begin
    case(system_cores_0_logic_cpu_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_system_cores_0_dBus_cmd_payload_fragment_mask = 4'b0001;
      end
      2'b01 : begin
        _zz_system_cores_0_dBus_cmd_payload_fragment_mask = 4'b0011;
      end
      default : begin
        _zz_system_cores_0_dBus_cmd_payload_fragment_mask = 4'b1111;
      end
    endcase
  end

  assign system_cores_0_dBus_cmd_payload_fragment_mask = (_zz_system_cores_0_dBus_cmd_payload_fragment_mask <<< system_cores_0_logic_cpu_dBus_cmd_payload_address[1 : 0]);
  assign system_cores_0_logic_cpu_dBus_rsp_ready = (system_cores_0_dBus_rsp_valid && (! system_cores_0_dBus_rsp_payload_fragment_context[0]));
  assign system_cores_0_logic_cpu_dBus_rsp_error = (system_cores_0_dBus_rsp_payload_fragment_opcode == 1'b1);
  assign system_cores_0_dBus_rsp_ready = 1'b1;
  assign system_cores_0_dBus_cmd_ready = (! system_cores_0_dBus_cmd_rValid);
  assign system_cores_0_dBus_cmd_s2mPipe_valid = (system_cores_0_dBus_cmd_valid || system_cores_0_dBus_cmd_rValid);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_last = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_last : system_cores_0_dBus_cmd_payload_last);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_fragment_opcode = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_fragment_opcode : system_cores_0_dBus_cmd_payload_fragment_opcode);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_fragment_address = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_fragment_address : system_cores_0_dBus_cmd_payload_fragment_address);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_fragment_length = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_fragment_length : system_cores_0_dBus_cmd_payload_fragment_length);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_fragment_data = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_fragment_data : system_cores_0_dBus_cmd_payload_fragment_data);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_fragment_mask = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_fragment_mask : system_cores_0_dBus_cmd_payload_fragment_mask);
  assign system_cores_0_dBus_cmd_s2mPipe_payload_fragment_context = (system_cores_0_dBus_cmd_rValid ? system_cores_0_dBus_cmd_rData_fragment_context : system_cores_0_dBus_cmd_payload_fragment_context);
  always @(*) begin
    system_cores_0_dBus_cmd_s2mPipe_ready = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_ready;
    if(when_Stream_l342) begin
      system_cores_0_dBus_cmd_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! system_cores_0_dBus_cmd_s2mPipe_m2sPipe_valid);
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_valid = system_cores_0_dBus_cmd_s2mPipe_rValid;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_last = system_cores_0_dBus_cmd_s2mPipe_rData_last;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_opcode = system_cores_0_dBus_cmd_s2mPipe_rData_fragment_opcode;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_address = system_cores_0_dBus_cmd_s2mPipe_rData_fragment_address;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_length = system_cores_0_dBus_cmd_s2mPipe_rData_fragment_length;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_data = system_cores_0_dBus_cmd_s2mPipe_rData_fragment_data;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_mask = system_cores_0_dBus_cmd_s2mPipe_rData_fragment_mask;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_context = system_cores_0_dBus_cmd_s2mPipe_rData_fragment_context;
  assign system_cores_0_dBus_cmd_s2mPipe_m2sPipe_ready = system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_ready;
  assign system_cores_0_dBus_rsp_valid = system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_valid;
  assign system_cores_0_dBus_rsp_payload_last = system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_last;
  assign system_cores_0_dBus_rsp_payload_fragment_opcode = system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_opcode;
  assign system_cores_0_dBus_rsp_payload_fragment_data = system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_data;
  assign system_cores_0_dBus_rsp_payload_fragment_context = system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_context;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_valid = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_valid;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_ready = system_cores_0_dBus_rsp_ready;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_last = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_last;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_opcode = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_opcode;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_address = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_address;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_length = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_length;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_data = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_data;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_mask = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_mask;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_payload_fragment_context = system_cores_0_dBus_cmd_s2mPipe_m2sPipe_payload_fragment_context;
  assign hardJtag_debug_bmb_connector_decoder_cmd_valid = hardJtag_debug_logic_mmMaster_cmd_valid;
  assign hardJtag_debug_logic_mmMaster_cmd_ready = hardJtag_debug_bmb_connector_decoder_cmd_ready;
  assign hardJtag_debug_logic_mmMaster_rsp_valid = hardJtag_debug_bmb_connector_decoder_rsp_valid;
  assign hardJtag_debug_bmb_connector_decoder_rsp_ready = hardJtag_debug_logic_mmMaster_rsp_ready;
  assign hardJtag_debug_bmb_connector_decoder_cmd_payload_last = hardJtag_debug_logic_mmMaster_cmd_payload_last;
  assign hardJtag_debug_logic_mmMaster_rsp_payload_last = hardJtag_debug_bmb_connector_decoder_rsp_payload_last;
  assign hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_opcode = hardJtag_debug_logic_mmMaster_cmd_payload_fragment_opcode;
  assign hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_address = hardJtag_debug_logic_mmMaster_cmd_payload_fragment_address;
  assign hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_length = hardJtag_debug_logic_mmMaster_cmd_payload_fragment_length;
  assign hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_data = hardJtag_debug_logic_mmMaster_cmd_payload_fragment_data;
  assign hardJtag_debug_bmb_connector_decoder_cmd_payload_fragment_mask = hardJtag_debug_logic_mmMaster_cmd_payload_fragment_mask;
  assign hardJtag_debug_logic_mmMaster_rsp_payload_fragment_opcode = hardJtag_debug_bmb_connector_decoder_rsp_payload_fragment_opcode;
  assign hardJtag_debug_logic_mmMaster_rsp_payload_fragment_data = hardJtag_debug_bmb_connector_decoder_rsp_payload_fragment_data;
  assign system_bridge_bmb_cmd_valid = system_bridge_bmb_arbiter_io_output_cmd_valid;
  assign system_bridge_bmb_rsp_ready = system_bridge_bmb_arbiter_io_output_rsp_ready;
  assign system_bridge_bmb_cmd_payload_last = system_bridge_bmb_arbiter_io_output_cmd_payload_last;
  assign system_bridge_bmb_cmd_payload_fragment_source = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_source;
  assign system_bridge_bmb_cmd_payload_fragment_opcode = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_opcode;
  assign system_bridge_bmb_cmd_payload_fragment_address = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_address;
  assign system_bridge_bmb_cmd_payload_fragment_length = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_length;
  assign system_bridge_bmb_cmd_payload_fragment_data = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_data;
  assign system_bridge_bmb_cmd_payload_fragment_mask = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_mask;
  assign system_bridge_bmb_cmd_payload_fragment_context = system_bridge_bmb_arbiter_io_output_cmd_payload_fragment_context;
  assign hardJtag_debug_bmb_connector_decoder_cmd_ready = bmbDecoder_4_io_input_cmd_ready;
  assign hardJtag_debug_bmb_connector_decoder_rsp_valid = bmbDecoder_4_io_input_rsp_valid;
  assign hardJtag_debug_bmb_connector_decoder_rsp_payload_last = bmbDecoder_4_io_input_rsp_payload_last;
  assign hardJtag_debug_bmb_connector_decoder_rsp_payload_fragment_opcode = bmbDecoder_4_io_input_rsp_payload_fragment_opcode;
  assign hardJtag_debug_bmb_connector_decoder_rsp_payload_fragment_data = bmbDecoder_4_io_input_rsp_payload_fragment_data;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_cmd_ready = system_bridge_bmb_arbiter_io_inputs_0_cmd_ready;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_valid = system_bridge_bmb_arbiter_io_inputs_0_rsp_valid;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_last = system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_last;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_opcode = system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_data = system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data;
  assign system_bridge_bmb_slaveModel_arbiterGen_logic_sorted_0_decoder_rsp_payload_fragment_context = system_bridge_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context;
  assign system_cores_0_iBus_cmd_ready = (! system_cores_0_iBus_cmd_rValid);
  assign system_cores_0_iBus_cmd_s2mPipe_valid = (system_cores_0_iBus_cmd_valid || system_cores_0_iBus_cmd_rValid);
  assign system_cores_0_iBus_cmd_s2mPipe_payload_last = (system_cores_0_iBus_cmd_rValid ? system_cores_0_iBus_cmd_rData_last : system_cores_0_iBus_cmd_payload_last);
  assign system_cores_0_iBus_cmd_s2mPipe_payload_fragment_opcode = (system_cores_0_iBus_cmd_rValid ? system_cores_0_iBus_cmd_rData_fragment_opcode : system_cores_0_iBus_cmd_payload_fragment_opcode);
  assign system_cores_0_iBus_cmd_s2mPipe_payload_fragment_address = (system_cores_0_iBus_cmd_rValid ? system_cores_0_iBus_cmd_rData_fragment_address : system_cores_0_iBus_cmd_payload_fragment_address);
  assign system_cores_0_iBus_cmd_s2mPipe_payload_fragment_length = (system_cores_0_iBus_cmd_rValid ? system_cores_0_iBus_cmd_rData_fragment_length : system_cores_0_iBus_cmd_payload_fragment_length);
  always @(*) begin
    system_cores_0_iBus_cmd_s2mPipe_ready = system_cores_0_iBus_cmd_s2mPipe_m2sPipe_ready;
    if(when_Stream_l342_1) begin
      system_cores_0_iBus_cmd_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l342_1 = (! system_cores_0_iBus_cmd_s2mPipe_m2sPipe_valid);
  assign system_cores_0_iBus_cmd_s2mPipe_m2sPipe_valid = system_cores_0_iBus_cmd_s2mPipe_rValid;
  assign system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_last = system_cores_0_iBus_cmd_s2mPipe_rData_last;
  assign system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_opcode = system_cores_0_iBus_cmd_s2mPipe_rData_fragment_opcode;
  assign system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_address = system_cores_0_iBus_cmd_s2mPipe_rData_fragment_address;
  assign system_cores_0_iBus_cmd_s2mPipe_m2sPipe_payload_fragment_length = system_cores_0_iBus_cmd_s2mPipe_rData_fragment_length;
  assign system_cores_0_iBus_cmd_s2mPipe_m2sPipe_ready = system_cores_0_iBus_decoder_io_input_cmd_ready;
  assign system_cores_0_iBus_rsp_valid = system_cores_0_iBus_decoder_io_input_rsp_valid;
  assign system_cores_0_iBus_rsp_payload_last = system_cores_0_iBus_decoder_io_input_rsp_payload_last;
  assign system_cores_0_iBus_rsp_payload_fragment_opcode = system_cores_0_iBus_decoder_io_input_rsp_payload_fragment_opcode;
  assign system_cores_0_iBus_rsp_payload_fragment_data = system_cores_0_iBus_decoder_io_input_rsp_payload_fragment_data;
  assign system_bridge_bmb_cmd_ready = system_bridge_bmb_decoder_io_input_cmd_ready;
  assign system_bridge_bmb_rsp_valid = system_bridge_bmb_decoder_io_input_rsp_valid;
  assign system_bridge_bmb_rsp_payload_last = system_bridge_bmb_decoder_io_input_rsp_payload_last;
  assign system_bridge_bmb_rsp_payload_fragment_source = system_bridge_bmb_decoder_io_input_rsp_payload_fragment_source;
  assign system_bridge_bmb_rsp_payload_fragment_opcode = system_bridge_bmb_decoder_io_input_rsp_payload_fragment_opcode;
  assign system_bridge_bmb_rsp_payload_fragment_data = system_bridge_bmb_decoder_io_input_rsp_payload_fragment_data;
  assign system_bridge_bmb_rsp_payload_fragment_context = system_bridge_bmb_decoder_io_input_rsp_payload_fragment_context;
  assign system_bmbPeripheral_bmb_cmd_valid = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = system_bmbPeripheral_bmb_cmd_ready;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_bmbPeripheral_bmb_rsp_valid;
  assign system_bmbPeripheral_bmb_rsp_ready = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  assign system_bmbPeripheral_bmb_cmd_payload_last = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_bmbPeripheral_bmb_rsp_payload_last;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_source = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_address = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_length = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_data = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_mask = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask;
  assign system_bmbPeripheral_bmb_cmd_payload_fragment_context = system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = system_bmbPeripheral_bmb_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_bmbPeripheral_bmb_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_bmbPeripheral_bmb_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = system_bmbPeripheral_bmb_rsp_payload_fragment_context;
  assign system_cores_0_debugBmb_cmd_valid = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = system_cores_0_debugBmb_cmd_ready;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_cores_0_debugBmb_rsp_valid;
  assign system_cores_0_debugBmb_rsp_ready = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  assign system_cores_0_debugBmb_cmd_payload_last = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_cores_0_debugBmb_rsp_payload_last;
  assign system_cores_0_debugBmb_cmd_payload_fragment_opcode = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  assign system_cores_0_debugBmb_cmd_payload_fragment_address = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  assign system_cores_0_debugBmb_cmd_payload_fragment_length = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  assign system_cores_0_debugBmb_cmd_payload_fragment_data = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  assign system_cores_0_debugBmb_cmd_payload_fragment_mask = system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_cores_0_debugBmb_rsp_payload_fragment_opcode;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_cores_0_debugBmb_rsp_payload_fragment_data;
  assign system_cores_0_logic_cpu_debug_bus_cmd_payload_wr = (system_cores_0_debugBmb_cmd_payload_fragment_opcode == 1'b1);
  assign system_cores_0_logic_cpu_debug_bus_cmd_fire = (system_cores_0_debugBmb_cmd_valid && system_cores_0_logic_cpu_debug_bus_cmd_ready);
  assign system_cores_0_debugBmb_cmd_ready = system_cores_0_logic_cpu_debug_bus_cmd_ready;
  assign system_cores_0_debugBmb_rsp_valid = system_cores_0_logic_cpu_debug_bus_cmd_fire_regNext;
  assign system_cores_0_debugBmb_rsp_payload_last = 1'b1;
  assign system_cores_0_debugBmb_rsp_payload_fragment_opcode = 1'b0;
  assign system_cores_0_debugBmb_rsp_payload_fragment_data = system_cores_0_logic_cpu_debug_bus_rsp_data;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bridge_bmb_decoder_io_outputs_1_cmd_valid;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bridge_bmb_decoder_io_outputs_1_rsp_ready;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_last;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_address[23:0];
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_mask;
  assign system_bmbPeripheral_bmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bridge_bmb_decoder_io_outputs_1_cmd_payload_fragment_context;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = system_ramA_logic_io_bus_cmd_ready;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_ramA_logic_io_bus_rsp_valid;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_ramA_logic_io_bus_rsp_payload_last;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = system_ramA_logic_io_bus_rsp_payload_fragment_source;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_ramA_logic_io_bus_rsp_payload_fragment_opcode;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_ramA_logic_io_bus_rsp_payload_fragment_data;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = system_ramA_logic_io_bus_rsp_payload_fragment_context;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = bmbDecoder_4_io_outputs_0_cmd_valid;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = bmbDecoder_4_io_outputs_0_rsp_ready;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = bmbDecoder_4_io_outputs_0_cmd_payload_last;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = bmbDecoder_4_io_outputs_0_cmd_payload_fragment_opcode;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = bmbDecoder_4_io_outputs_0_cmd_payload_fragment_address[7:0];
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = bmbDecoder_4_io_outputs_0_cmd_payload_fragment_length;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = bmbDecoder_4_io_outputs_0_cmd_payload_fragment_data;
  assign system_cores_0_debugBmb_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask = bmbDecoder_4_io_outputs_0_cmd_payload_fragment_mask;
  assign cpu0_customInstruction_cmd_valid = system_cores_0_logic_cpu_CfuPlugin_bus_cmd_valid;
  assign cpu0_customInstruction_function_id = system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_function_id;
  assign cpu0_customInstruction_inputs_0 = system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_inputs_0;
  assign cpu0_customInstruction_inputs_1 = system_cores_0_logic_cpu_CfuPlugin_bus_cmd_payload_inputs_1;
  assign cpu0_customInstruction_rsp_ready = system_cores_0_logic_cpu_CfuPlugin_bus_rsp_ready;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bridge_bmb_decoder_io_outputs_0_cmd_valid;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bridge_bmb_decoder_io_outputs_0_rsp_ready;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_last;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_source;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_address[12:0];
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_length;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_data;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_mask = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_mask;
  assign system_ramA_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bridge_bmb_decoder_io_outputs_0_cmd_payload_fragment_context;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_fire = (system_bmbPeripheral_bmb_cmd_halfPipe_valid && system_bmbPeripheral_bmb_cmd_halfPipe_ready);
  assign system_bmbPeripheral_bmb_cmd_ready = (! system_bmbPeripheral_bmb_cmd_rValid);
  assign system_bmbPeripheral_bmb_cmd_halfPipe_valid = system_bmbPeripheral_bmb_cmd_rValid;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_last = system_bmbPeripheral_bmb_cmd_rData_last;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_source = system_bmbPeripheral_bmb_cmd_rData_fragment_source;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_opcode = system_bmbPeripheral_bmb_cmd_rData_fragment_opcode;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_address = system_bmbPeripheral_bmb_cmd_rData_fragment_address;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_length = system_bmbPeripheral_bmb_cmd_rData_fragment_length;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_data = system_bmbPeripheral_bmb_cmd_rData_fragment_data;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_mask = system_bmbPeripheral_bmb_cmd_rData_fragment_mask;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_payload_fragment_context = system_bmbPeripheral_bmb_cmd_rData_fragment_context;
  assign system_bmbPeripheral_bmb_cmd_halfPipe_ready = system_bmbPeripheral_bmb_decoder_io_input_cmd_ready;
  assign _zz_io_input_rsp_ready = (! _zz_system_bmbPeripheral_bmb_rsp_valid_1);
  assign _zz_system_bmbPeripheral_bmb_rsp_valid = _zz_system_bmbPeripheral_bmb_rsp_valid_1;
  assign system_bmbPeripheral_bmb_rsp_valid = _zz_system_bmbPeripheral_bmb_rsp_valid;
  assign system_bmbPeripheral_bmb_rsp_payload_last = _zz_system_bmbPeripheral_bmb_rsp_payload_last;
  assign system_bmbPeripheral_bmb_rsp_payload_fragment_source = _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_rsp_payload_fragment_opcode = _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_rsp_payload_fragment_data = _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_rsp_payload_fragment_context = _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_context;
  assign system_uart_0_io_txd = system_uart_0_io_logic_io_uart_txd;
  assign system_gpio_0_io_write = system_gpio_0_io_logic_io_gpio_write;
  assign system_gpio_0_io_writeEnable = system_gpio_0_io_logic_io_gpio_writeEnable;
  assign system_gpio_0_io_interrupts_0 = system_gpio_0_io_logic_io_interrupt[0];
  assign system_gpio_0_io_interrupts_1 = system_gpio_0_io_logic_io_interrupt[1];
  assign system_gpio_0_io_interrupts_2 = system_gpio_0_io_logic_io_interrupt[2];
  assign system_gpio_0_io_interrupts_3 = system_gpio_0_io_logic_io_interrupt[3];
  assign system_gpio_0_io_interrupts_4 = system_gpio_0_io_logic_io_interrupt[4];
  assign system_gpio_0_io_interrupts_5 = system_gpio_0_io_logic_io_interrupt[5];
  assign system_gpio_0_io_interrupts_6 = system_gpio_0_io_logic_io_interrupt[6];
  assign system_gpio_0_io_interrupts_7 = system_gpio_0_io_logic_io_interrupt[7];
  assign system_gpio_0_io_interrupts_8 = system_gpio_0_io_logic_io_interrupt[8];
  assign system_gpio_0_io_interrupts_9 = system_gpio_0_io_logic_io_interrupt[9];
  assign system_gpio_0_io_interrupts_10 = system_gpio_0_io_logic_io_interrupt[10];
  assign system_gpio_0_io_interrupts_11 = system_gpio_0_io_logic_io_interrupt[11];
  assign system_gpio_0_io_interrupts_12 = system_gpio_0_io_logic_io_interrupt[12];
  assign system_gpio_0_io_interrupts_13 = system_gpio_0_io_logic_io_interrupt[13];
  assign system_gpio_0_io_interrupts_14 = system_gpio_0_io_logic_io_interrupt[14];
  assign system_gpio_0_io_interrupts_15 = system_gpio_0_io_logic_io_interrupt[15];
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = system_clint_logic_io_bus_cmd_ready;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_clint_logic_io_bus_rsp_valid;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_clint_logic_io_bus_rsp_payload_last;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = system_clint_logic_io_bus_rsp_payload_fragment_source;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_clint_logic_io_bus_rsp_payload_fragment_opcode;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_clint_logic_io_bus_rsp_payload_fragment_data;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = system_clint_logic_io_bus_rsp_payload_fragment_context;
  assign system_cores_0_logic_cpu_timerInterrupt = system_clint_logic_io_timerInterrupt[0];
  assign system_cores_0_logic_cpu_softwareInterrupt = system_clint_logic_io_softwareInterrupt[0];
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_fire = (system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid && system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_ready);
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = (! system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid);
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_last = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_last;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_source = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_source;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_opcode = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_opcode;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_address = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_address;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_length = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_length;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_data = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_data;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_context = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_context;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_ready = system_uart_0_io_logic_io_bus_cmd_ready;
  assign _zz_io_bus_rsp_ready = (! _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid_1);
  assign _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid_1;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  assign when_PlicGateway_l21 = (! system_uart_0_io_interrupt_plic_gateway_waitCompletion);
  assign when_PlicGateway_l21_1 = (! system_spi_0_io_interrupt_plic_gateway_waitCompletion);
  assign system_spi_0_io_sclk_write = system_spi_0_io_logic_io_spi_sclk_write;
  assign system_spi_0_io_data_0_writeEnable = system_spi_0_io_logic_io_spi_data_0_writeEnable;
  assign system_spi_0_io_data_0_write = system_spi_0_io_logic_io_spi_data_0_write;
  assign system_spi_0_io_data_1_writeEnable = system_spi_0_io_logic_io_spi_data_1_writeEnable;
  assign system_spi_0_io_data_1_write = system_spi_0_io_logic_io_spi_data_1_write;
  assign system_spi_0_io_data_2_writeEnable = system_spi_0_io_logic_io_spi_data_2_writeEnable;
  assign system_spi_0_io_data_2_write = system_spi_0_io_logic_io_spi_data_2_write;
  assign system_spi_0_io_data_3_writeEnable = system_spi_0_io_logic_io_spi_data_3_writeEnable;
  assign system_spi_0_io_data_3_write = system_spi_0_io_logic_io_spi_data_3_write;
  assign system_spi_0_io_ss = system_spi_0_io_logic_io_spi_ss;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_fire = (system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid && system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_ready);
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = (! system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid);
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_valid = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_last = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_last;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_source = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_source;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_opcode = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_opcode;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_address = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_address;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_length = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_length;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_data = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_data;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_payload_fragment_context = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_context;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_ready = system_spi_0_io_logic_io_ctrl_cmd_ready;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_spi_0_io_logic_io_ctrl_rsp_valid;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_spi_0_io_logic_io_ctrl_rsp_payload_last;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_source;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_opcode;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_data;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = system_spi_0_io_logic_io_ctrl_rsp_payload_fragment_context;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = system_gpio_0_io_logic_io_bus_cmd_ready;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_gpio_0_io_logic_io_bus_rsp_valid;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_gpio_0_io_logic_io_bus_rsp_payload_last;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = system_gpio_0_io_logic_io_bus_rsp_payload_fragment_source;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_gpio_0_io_logic_io_bus_rsp_payload_fragment_opcode;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_gpio_0_io_logic_io_bus_rsp_payload_fragment_data;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = system_gpio_0_io_logic_io_bus_rsp_payload_fragment_context;
  assign when_PlicGateway_l21_2 = (! system_gpio_0_io_interrupts_0_plic_gateway_waitCompletion);
  assign when_PlicGateway_l21_3 = (! system_gpio_0_io_interrupts_1_plic_gateway_waitCompletion);
  assign system_bmbPeripheral_bmb_withoutMask_cmd_valid = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_valid;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_ready = system_bmbPeripheral_bmb_decoder_io_outputs_1_rsp_ready;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_last = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_last;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_address;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context = system_bmbPeripheral_bmb_decoder_io_outputs_1_cmd_payload_fragment_context;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bmbPeripheral_bmb_withoutMask_cmd_valid;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_ready = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_valid = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bmbPeripheral_bmb_withoutMask_rsp_ready;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bmbPeripheral_bmb_withoutMask_cmd_payload_last;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_last = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address[15:0];
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data;
  assign system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context = system_clint_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_valid_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_valid;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_ready_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_rsp_ready;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_last;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_address;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_1 = system_bmbPeripheral_bmb_decoder_io_outputs_2_cmd_payload_fragment_context;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bmbPeripheral_bmb_withoutMask_cmd_valid_1;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_ready_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_valid_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bmbPeripheral_bmb_withoutMask_rsp_ready_1;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_1;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_1;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_1;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_1[5:0];
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_1;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_1;
  assign system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_1;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_1 = system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_valid_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_valid;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_ready_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_rsp_ready;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_last;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_address;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_2 = system_bmbPeripheral_bmb_decoder_io_outputs_3_cmd_payload_fragment_context;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bmbPeripheral_bmb_withoutMask_cmd_valid_2;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_ready_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_valid_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bmbPeripheral_bmb_withoutMask_rsp_ready_2;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_2;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_2;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_2;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_2[11:0];
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_2;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_2;
  assign system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_2;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_2 = system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_valid_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_valid;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_ready_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_rsp_ready;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_last;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_address;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_3 = system_bmbPeripheral_bmb_decoder_io_outputs_4_cmd_payload_fragment_context;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bmbPeripheral_bmb_withoutMask_cmd_valid_3;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_ready_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_valid_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bmbPeripheral_bmb_withoutMask_rsp_ready_3;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_3;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_3;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_3;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_3[7:0];
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_3;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_3;
  assign system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_3;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_3 = system_gpio_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  always @(*) begin
    system_plic_logic_bus_readHaltTrigger = 1'b0;
    if(when_PlicMapper_l122) begin
      system_plic_logic_bus_readHaltTrigger = 1'b1;
    end
  end

  assign system_plic_logic_bus_writeHaltTrigger = 1'b0;
  assign _zz_system_plic_logic_bmb_rsp_valid = (! (system_plic_logic_bus_readHaltTrigger || system_plic_logic_bus_writeHaltTrigger));
  assign system_plic_logic_bus_rsp_ready = (_zz_system_plic_logic_bus_rsp_ready && _zz_system_plic_logic_bmb_rsp_valid);
  always @(*) begin
    _zz_system_plic_logic_bus_rsp_ready = system_plic_logic_bmb_rsp_ready;
    if(when_Stream_l342_2) begin
      _zz_system_plic_logic_bus_rsp_ready = 1'b1;
    end
  end

  assign when_Stream_l342_2 = (! _zz_system_plic_logic_bmb_rsp_valid_1);
  assign _zz_system_plic_logic_bmb_rsp_valid_1 = _zz_system_plic_logic_bmb_rsp_valid_2;
  assign system_plic_logic_bmb_rsp_valid = _zz_system_plic_logic_bmb_rsp_valid_1;
  assign system_plic_logic_bmb_rsp_payload_last = _zz_system_plic_logic_bmb_rsp_payload_last;
  assign system_plic_logic_bmb_rsp_payload_fragment_source = _zz_system_plic_logic_bmb_rsp_payload_fragment_source;
  assign system_plic_logic_bmb_rsp_payload_fragment_opcode = _zz_system_plic_logic_bmb_rsp_payload_fragment_opcode;
  assign system_plic_logic_bmb_rsp_payload_fragment_data = _zz_system_plic_logic_bmb_rsp_payload_fragment_data;
  assign system_plic_logic_bmb_rsp_payload_fragment_context = _zz_system_plic_logic_bmb_rsp_payload_fragment_context;
  assign system_plic_logic_bus_askWrite = (system_plic_logic_bmb_cmd_valid && (system_plic_logic_bmb_cmd_payload_fragment_opcode == 1'b1));
  assign system_plic_logic_bus_askRead = (system_plic_logic_bmb_cmd_valid && (system_plic_logic_bmb_cmd_payload_fragment_opcode == 1'b0));
  assign system_plic_logic_bmb_cmd_fire = (system_plic_logic_bmb_cmd_valid && system_plic_logic_bmb_cmd_ready);
  assign system_plic_logic_bus_doWrite = (system_plic_logic_bmb_cmd_fire && (system_plic_logic_bmb_cmd_payload_fragment_opcode == 1'b1));
  assign system_plic_logic_bmb_cmd_fire_1 = (system_plic_logic_bmb_cmd_valid && system_plic_logic_bmb_cmd_ready);
  assign system_plic_logic_bus_doRead = (system_plic_logic_bmb_cmd_fire_1 && (system_plic_logic_bmb_cmd_payload_fragment_opcode == 1'b0));
  assign system_plic_logic_bus_rsp_valid = system_plic_logic_bmb_cmd_valid;
  assign system_plic_logic_bmb_cmd_ready = system_plic_logic_bus_rsp_ready;
  assign system_plic_logic_bus_rsp_payload_last = 1'b1;
  assign system_plic_logic_bus_rsp_payload_fragment_opcode = 1'b0;
  always @(*) begin
    system_plic_logic_bus_rsp_payload_fragment_data = 32'h0;
    case(system_plic_logic_bmb_cmd_payload_fragment_address)
      22'h000004 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 0] = system_uart_0_io_interrupt_plic_gateway_priority;
      end
      22'h001000 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 1] = system_uart_0_io_interrupt_plic_gateway_ip;
        system_plic_logic_bus_rsp_payload_fragment_data[4 : 4] = system_spi_0_io_interrupt_plic_gateway_ip;
        system_plic_logic_bus_rsp_payload_fragment_data[12 : 12] = system_gpio_0_io_interrupts_0_plic_gateway_ip;
        system_plic_logic_bus_rsp_payload_fragment_data[13 : 13] = system_gpio_0_io_interrupts_1_plic_gateway_ip;
      end
      22'h000010 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 0] = system_spi_0_io_interrupt_plic_gateway_priority;
      end
      22'h000030 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 0] = system_gpio_0_io_interrupts_0_plic_gateway_priority;
      end
      22'h000034 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 0] = system_gpio_0_io_interrupts_1_plic_gateway_priority;
      end
      22'h200000 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 0] = system_cores_0_externalInterrupt_plic_target_threshold;
      end
      22'h200004 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[3 : 0] = system_cores_0_externalInterrupt_plic_target_claim;
      end
      22'h002000 : begin
        system_plic_logic_bus_rsp_payload_fragment_data[1 : 1] = system_cores_0_externalInterrupt_plic_target_ie_0;
        system_plic_logic_bus_rsp_payload_fragment_data[4 : 4] = system_cores_0_externalInterrupt_plic_target_ie_1;
        system_plic_logic_bus_rsp_payload_fragment_data[12 : 12] = system_cores_0_externalInterrupt_plic_target_ie_2;
        system_plic_logic_bus_rsp_payload_fragment_data[13 : 13] = system_cores_0_externalInterrupt_plic_target_ie_3;
      end
      default : begin
      end
    endcase
  end

  assign system_plic_logic_bus_rsp_payload_fragment_context = system_plic_logic_bmb_cmd_payload_fragment_context;
  assign system_plic_logic_bus_rsp_payload_fragment_source = system_plic_logic_bmb_cmd_payload_fragment_source;
  assign system_cores_0_externalInterrupt_plic_target_requests_0_priority = 2'b00;
  assign system_cores_0_externalInterrupt_plic_target_requests_0_id = 4'b0000;
  assign system_cores_0_externalInterrupt_plic_target_requests_0_valid = 1'b1;
  assign system_cores_0_externalInterrupt_plic_target_requests_1_priority = system_uart_0_io_interrupt_plic_gateway_priority;
  assign system_cores_0_externalInterrupt_plic_target_requests_1_id = 4'b0001;
  assign system_cores_0_externalInterrupt_plic_target_requests_1_valid = (system_uart_0_io_interrupt_plic_gateway_ip && system_cores_0_externalInterrupt_plic_target_ie_0);
  assign system_cores_0_externalInterrupt_plic_target_requests_2_priority = system_spi_0_io_interrupt_plic_gateway_priority;
  assign system_cores_0_externalInterrupt_plic_target_requests_2_id = 4'b0100;
  assign system_cores_0_externalInterrupt_plic_target_requests_2_valid = (system_spi_0_io_interrupt_plic_gateway_ip && system_cores_0_externalInterrupt_plic_target_ie_1);
  assign system_cores_0_externalInterrupt_plic_target_requests_3_priority = system_gpio_0_io_interrupts_0_plic_gateway_priority;
  assign system_cores_0_externalInterrupt_plic_target_requests_3_id = 4'b1100;
  assign system_cores_0_externalInterrupt_plic_target_requests_3_valid = (system_gpio_0_io_interrupts_0_plic_gateway_ip && system_cores_0_externalInterrupt_plic_target_ie_2);
  assign system_cores_0_externalInterrupt_plic_target_requests_4_priority = system_gpio_0_io_interrupts_1_plic_gateway_priority;
  assign system_cores_0_externalInterrupt_plic_target_requests_4_id = 4'b1101;
  assign system_cores_0_externalInterrupt_plic_target_requests_4_valid = (system_gpio_0_io_interrupts_1_plic_gateway_ip && system_cores_0_externalInterrupt_plic_target_ie_3);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority = ((! system_cores_0_externalInterrupt_plic_target_requests_1_valid) || (system_cores_0_externalInterrupt_plic_target_requests_0_valid && (system_cores_0_externalInterrupt_plic_target_requests_1_priority <= system_cores_0_externalInterrupt_plic_target_requests_0_priority)));
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_1 = (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority ? system_cores_0_externalInterrupt_plic_target_requests_0_priority : system_cores_0_externalInterrupt_plic_target_requests_1_priority);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_2 = (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority ? system_cores_0_externalInterrupt_plic_target_requests_0_valid : system_cores_0_externalInterrupt_plic_target_requests_1_valid);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_3 = ((! system_cores_0_externalInterrupt_plic_target_requests_3_valid) || (system_cores_0_externalInterrupt_plic_target_requests_2_valid && (system_cores_0_externalInterrupt_plic_target_requests_3_priority <= system_cores_0_externalInterrupt_plic_target_requests_2_priority)));
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_4 = (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_3 ? system_cores_0_externalInterrupt_plic_target_requests_2_priority : system_cores_0_externalInterrupt_plic_target_requests_3_priority);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_5 = (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_3 ? system_cores_0_externalInterrupt_plic_target_requests_2_valid : system_cores_0_externalInterrupt_plic_target_requests_3_valid);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_6 = ((! _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_5) || (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_2 && (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_4 <= _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_1)));
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_7 = (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_6 ? _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_1 : _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_4);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_8 = (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_6 ? _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_2 : _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_5);
  assign _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_9 = ((! system_cores_0_externalInterrupt_plic_target_requests_4_valid) || (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_8 && (system_cores_0_externalInterrupt_plic_target_requests_4_priority <= _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_7)));
  assign system_cores_0_externalInterrupt_plic_target_iep = (system_cores_0_externalInterrupt_plic_target_threshold < system_cores_0_externalInterrupt_plic_target_bestRequest_priority);
  assign system_cores_0_externalInterrupt_plic_target_claim = (system_cores_0_externalInterrupt_plic_target_iep ? system_cores_0_externalInterrupt_plic_target_bestRequest_id : 4'b0000);
  assign system_uart_0_io_interrupt_plic_gateway_priority = _zz_system_uart_0_io_interrupt_plic_gateway_priority;
  assign system_spi_0_io_interrupt_plic_gateway_priority = _zz_system_spi_0_io_interrupt_plic_gateway_priority;
  assign system_gpio_0_io_interrupts_0_plic_gateway_priority = _zz_system_gpio_0_io_interrupts_0_plic_gateway_priority;
  assign system_gpio_0_io_interrupts_1_plic_gateway_priority = _zz_system_gpio_0_io_interrupts_1_plic_gateway_priority;
  always @(*) begin
    system_plic_logic_bridge_claim_valid = 1'b0;
    case(system_plic_logic_bmb_cmd_payload_fragment_address)
      22'h200004 : begin
        if(system_plic_logic_bus_doRead) begin
          system_plic_logic_bridge_claim_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    system_plic_logic_bridge_claim_payload = 4'bxxxx;
    case(system_plic_logic_bmb_cmd_payload_fragment_address)
      22'h200004 : begin
        if(system_plic_logic_bus_doRead) begin
          system_plic_logic_bridge_claim_payload = system_cores_0_externalInterrupt_plic_target_claim;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    system_plic_logic_bridge_completion_valid = 1'b0;
    if(system_plic_logic_bridge_targetMapping_0_targetCompletion_valid) begin
      system_plic_logic_bridge_completion_valid = 1'b1;
    end
  end

  always @(*) begin
    system_plic_logic_bridge_completion_payload = 4'bxxxx;
    if(system_plic_logic_bridge_targetMapping_0_targetCompletion_valid) begin
      system_plic_logic_bridge_completion_payload = system_plic_logic_bridge_targetMapping_0_targetCompletion_payload;
    end
  end

  always @(*) begin
    system_plic_logic_bridge_coherencyStall_willIncrement = 1'b0;
    if(when_PlicMapper_l122) begin
      system_plic_logic_bridge_coherencyStall_willIncrement = 1'b1;
    end
    if(when_BmbSlaveFactory_l71) begin
      if(system_plic_logic_bus_askWrite) begin
        system_plic_logic_bridge_coherencyStall_willIncrement = 1'b1;
      end
      if(system_plic_logic_bus_askRead) begin
        system_plic_logic_bridge_coherencyStall_willIncrement = 1'b1;
      end
    end
  end

  assign system_plic_logic_bridge_coherencyStall_willClear = 1'b0;
  assign system_plic_logic_bridge_coherencyStall_willOverflowIfInc = (system_plic_logic_bridge_coherencyStall_value == 1'b1);
  assign system_plic_logic_bridge_coherencyStall_willOverflow = (system_plic_logic_bridge_coherencyStall_willOverflowIfInc && system_plic_logic_bridge_coherencyStall_willIncrement);
  always @(*) begin
    system_plic_logic_bridge_coherencyStall_valueNext = (system_plic_logic_bridge_coherencyStall_value + system_plic_logic_bridge_coherencyStall_willIncrement);
    if(system_plic_logic_bridge_coherencyStall_willClear) begin
      system_plic_logic_bridge_coherencyStall_valueNext = 1'b0;
    end
  end

  assign when_PlicMapper_l122 = (system_plic_logic_bridge_coherencyStall_value != 1'b0);
  assign system_cores_0_externalInterrupt_plic_target_threshold = _zz_system_cores_0_externalInterrupt_plic_target_threshold;
  always @(*) begin
    system_plic_logic_bridge_targetMapping_0_targetCompletion_valid = 1'b0;
    case(system_plic_logic_bmb_cmd_payload_fragment_address)
      22'h200004 : begin
        if(system_plic_logic_bus_doWrite) begin
          system_plic_logic_bridge_targetMapping_0_targetCompletion_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign system_cores_0_externalInterrupt_plic_target_ie_0 = _zz_system_cores_0_externalInterrupt_plic_target_ie_0;
  assign system_cores_0_externalInterrupt_plic_target_ie_1 = _zz_system_cores_0_externalInterrupt_plic_target_ie_1;
  assign system_cores_0_externalInterrupt_plic_target_ie_2 = _zz_system_cores_0_externalInterrupt_plic_target_ie_2;
  assign system_cores_0_externalInterrupt_plic_target_ie_3 = _zz_system_cores_0_externalInterrupt_plic_target_ie_3;
  assign system_plic_logic_bmb_cmd_valid = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready = system_plic_logic_bmb_cmd_ready;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid = system_plic_logic_bmb_rsp_valid;
  assign system_plic_logic_bmb_rsp_ready = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready;
  assign system_plic_logic_bmb_cmd_payload_last = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last = system_plic_logic_bmb_rsp_payload_last;
  assign system_plic_logic_bmb_cmd_payload_fragment_source = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
  assign system_plic_logic_bmb_cmd_payload_fragment_opcode = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
  assign system_plic_logic_bmb_cmd_payload_fragment_address = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
  assign system_plic_logic_bmb_cmd_payload_fragment_length = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
  assign system_plic_logic_bmb_cmd_payload_fragment_data = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
  assign system_plic_logic_bmb_cmd_payload_fragment_context = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source = system_plic_logic_bmb_rsp_payload_fragment_source;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode = system_plic_logic_bmb_rsp_payload_fragment_opcode;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data = system_plic_logic_bmb_rsp_payload_fragment_data;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context = system_plic_logic_bmb_rsp_payload_fragment_context;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_valid_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_valid;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_ready_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_rsp_ready;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_last;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_address;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_length;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_4 = system_bmbPeripheral_bmb_decoder_io_outputs_0_cmd_payload_fragment_context;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid = system_bmbPeripheral_bmb_withoutMask_cmd_valid_4;
  assign system_bmbPeripheral_bmb_withoutMask_cmd_ready_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_valid_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready = system_bmbPeripheral_bmb_withoutMask_rsp_ready_4;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last = system_bmbPeripheral_bmb_withoutMask_cmd_payload_last_4;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_last_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_source_4;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_opcode_4;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_address_4[21:0];
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_length_4;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_data_4;
  assign system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context = system_bmbPeripheral_bmb_withoutMask_cmd_payload_fragment_context_4;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_source_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_opcode_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_data_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data;
  assign system_bmbPeripheral_bmb_withoutMask_rsp_payload_fragment_context_4 = system_plic_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context;
  assign system_plic_logic_bridge_targetMapping_0_targetCompletion_payload = system_plic_logic_bmb_cmd_payload_fragment_data[3 : 0];
  assign when_BmbSlaveFactory_l71 = 1'b1;
  always @(posedge io_systemClk) begin
    if(when_ClockDomainGenerator_l77) begin
      debugCd_logic_holdingLogic_resetCounter <= (debugCd_logic_holdingLogic_resetCounter + 12'h001);
    end
    if(debugCd_logic_inputResetTrigger) begin
      debugCd_logic_holdingLogic_resetCounter <= 12'h0;
    end
    debugCd_logic_outputReset <= debugCd_logic_outputResetUnbuffered;
  end

  always @(posedge io_systemClk) begin
    if(when_ClockDomainGenerator_l77_1) begin
      systemCd_logic_holdingLogic_resetCounter <= (systemCd_logic_holdingLogic_resetCounter + 6'h01);
    end
    if(systemCd_logic_inputResetTrigger) begin
      systemCd_logic_holdingLogic_resetCounter <= 6'h0;
    end
    systemCd_logic_outputReset <= systemCd_logic_outputResetUnbuffered;
  end

  always @(posedge io_systemClk) begin
    io_systemReset <= systemCd_logic_outputReset;
    if(system_cores_0_dBus_cmd_ready) begin
      system_cores_0_dBus_cmd_rData_last <= system_cores_0_dBus_cmd_payload_last;
      system_cores_0_dBus_cmd_rData_fragment_opcode <= system_cores_0_dBus_cmd_payload_fragment_opcode;
      system_cores_0_dBus_cmd_rData_fragment_address <= system_cores_0_dBus_cmd_payload_fragment_address;
      system_cores_0_dBus_cmd_rData_fragment_length <= system_cores_0_dBus_cmd_payload_fragment_length;
      system_cores_0_dBus_cmd_rData_fragment_data <= system_cores_0_dBus_cmd_payload_fragment_data;
      system_cores_0_dBus_cmd_rData_fragment_mask <= system_cores_0_dBus_cmd_payload_fragment_mask;
      system_cores_0_dBus_cmd_rData_fragment_context <= system_cores_0_dBus_cmd_payload_fragment_context;
    end
    if(system_cores_0_dBus_cmd_s2mPipe_ready) begin
      system_cores_0_dBus_cmd_s2mPipe_rData_last <= system_cores_0_dBus_cmd_s2mPipe_payload_last;
      system_cores_0_dBus_cmd_s2mPipe_rData_fragment_opcode <= system_cores_0_dBus_cmd_s2mPipe_payload_fragment_opcode;
      system_cores_0_dBus_cmd_s2mPipe_rData_fragment_address <= system_cores_0_dBus_cmd_s2mPipe_payload_fragment_address;
      system_cores_0_dBus_cmd_s2mPipe_rData_fragment_length <= system_cores_0_dBus_cmd_s2mPipe_payload_fragment_length;
      system_cores_0_dBus_cmd_s2mPipe_rData_fragment_data <= system_cores_0_dBus_cmd_s2mPipe_payload_fragment_data;
      system_cores_0_dBus_cmd_s2mPipe_rData_fragment_mask <= system_cores_0_dBus_cmd_s2mPipe_payload_fragment_mask;
      system_cores_0_dBus_cmd_s2mPipe_rData_fragment_context <= system_cores_0_dBus_cmd_s2mPipe_payload_fragment_context;
    end
    if(system_cores_0_iBus_cmd_ready) begin
      system_cores_0_iBus_cmd_rData_last <= system_cores_0_iBus_cmd_payload_last;
      system_cores_0_iBus_cmd_rData_fragment_opcode <= system_cores_0_iBus_cmd_payload_fragment_opcode;
      system_cores_0_iBus_cmd_rData_fragment_address <= system_cores_0_iBus_cmd_payload_fragment_address;
      system_cores_0_iBus_cmd_rData_fragment_length <= system_cores_0_iBus_cmd_payload_fragment_length;
    end
    if(system_cores_0_iBus_cmd_s2mPipe_ready) begin
      system_cores_0_iBus_cmd_s2mPipe_rData_last <= system_cores_0_iBus_cmd_s2mPipe_payload_last;
      system_cores_0_iBus_cmd_s2mPipe_rData_fragment_opcode <= system_cores_0_iBus_cmd_s2mPipe_payload_fragment_opcode;
      system_cores_0_iBus_cmd_s2mPipe_rData_fragment_address <= system_cores_0_iBus_cmd_s2mPipe_payload_fragment_address;
      system_cores_0_iBus_cmd_s2mPipe_rData_fragment_length <= system_cores_0_iBus_cmd_s2mPipe_payload_fragment_length;
    end
    if(system_bmbPeripheral_bmb_cmd_ready) begin
      system_bmbPeripheral_bmb_cmd_rData_last <= system_bmbPeripheral_bmb_cmd_payload_last;
      system_bmbPeripheral_bmb_cmd_rData_fragment_source <= system_bmbPeripheral_bmb_cmd_payload_fragment_source;
      system_bmbPeripheral_bmb_cmd_rData_fragment_opcode <= system_bmbPeripheral_bmb_cmd_payload_fragment_opcode;
      system_bmbPeripheral_bmb_cmd_rData_fragment_address <= system_bmbPeripheral_bmb_cmd_payload_fragment_address;
      system_bmbPeripheral_bmb_cmd_rData_fragment_length <= system_bmbPeripheral_bmb_cmd_payload_fragment_length;
      system_bmbPeripheral_bmb_cmd_rData_fragment_data <= system_bmbPeripheral_bmb_cmd_payload_fragment_data;
      system_bmbPeripheral_bmb_cmd_rData_fragment_mask <= system_bmbPeripheral_bmb_cmd_payload_fragment_mask;
      system_bmbPeripheral_bmb_cmd_rData_fragment_context <= system_bmbPeripheral_bmb_cmd_payload_fragment_context;
    end
    if(_zz_io_input_rsp_ready) begin
      _zz_system_bmbPeripheral_bmb_rsp_payload_last <= system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_last;
      _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_source <= system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_source;
      _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_opcode <= system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_opcode;
      _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_data <= system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_data;
      _zz_system_bmbPeripheral_bmb_rsp_payload_fragment_context <= system_bmbPeripheral_bmb_decoder_io_input_rsp_payload_fragment_context;
    end
    if(system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready) begin
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_last <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_source <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_opcode <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_address <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_length <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_data <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_context <= system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
    end
    if(_zz_io_bus_rsp_ready) begin
      _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_last <= system_uart_0_io_logic_io_bus_rsp_payload_last;
      _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_source <= system_uart_0_io_logic_io_bus_rsp_payload_fragment_source;
      _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_opcode <= system_uart_0_io_logic_io_bus_rsp_payload_fragment_opcode;
      _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_data <= system_uart_0_io_logic_io_bus_rsp_payload_fragment_data;
      _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_payload_fragment_context <= system_uart_0_io_logic_io_bus_rsp_payload_fragment_context;
    end
    if(system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_ready) begin
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_last <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_last;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_source <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_source;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_opcode <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_opcode;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_address <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_address;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_length <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_length;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_data <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_data;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rData_fragment_context <= system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_payload_fragment_context;
    end
    if(_zz_system_plic_logic_bus_rsp_ready) begin
      _zz_system_plic_logic_bmb_rsp_payload_last <= system_plic_logic_bus_rsp_payload_last;
      _zz_system_plic_logic_bmb_rsp_payload_fragment_source <= system_plic_logic_bus_rsp_payload_fragment_source;
      _zz_system_plic_logic_bmb_rsp_payload_fragment_opcode <= system_plic_logic_bus_rsp_payload_fragment_opcode;
      _zz_system_plic_logic_bmb_rsp_payload_fragment_data <= system_plic_logic_bus_rsp_payload_fragment_data;
      _zz_system_plic_logic_bmb_rsp_payload_fragment_context <= system_plic_logic_bus_rsp_payload_fragment_context;
    end
    system_cores_0_externalInterrupt_plic_target_bestRequest_priority <= (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_9 ? _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_7 : system_cores_0_externalInterrupt_plic_target_requests_4_priority);
    system_cores_0_externalInterrupt_plic_target_bestRequest_id <= (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_9 ? (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_6 ? (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority ? system_cores_0_externalInterrupt_plic_target_requests_0_id : system_cores_0_externalInterrupt_plic_target_requests_1_id) : (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_3 ? system_cores_0_externalInterrupt_plic_target_requests_2_id : system_cores_0_externalInterrupt_plic_target_requests_3_id)) : system_cores_0_externalInterrupt_plic_target_requests_4_id);
    system_cores_0_externalInterrupt_plic_target_bestRequest_valid <= (_zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_9 ? _zz_system_cores_0_externalInterrupt_plic_target_bestRequest_priority_8 : system_cores_0_externalInterrupt_plic_target_requests_4_valid);
  end

  always @(posedge io_systemClk) begin
    system_cores_0_debugReset <= system_cores_0_logic_cpu_debug_resetOut;
  end

  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      system_cores_0_dBus_cmd_rValid <= 1'b0;
      system_cores_0_dBus_cmd_s2mPipe_rValid <= 1'b0;
      system_cores_0_iBus_cmd_rValid <= 1'b0;
      system_cores_0_iBus_cmd_s2mPipe_rValid <= 1'b0;
      system_bmbPeripheral_bmb_cmd_rValid <= 1'b0;
      _zz_system_bmbPeripheral_bmb_rsp_valid_1 <= 1'b0;
      system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid <= 1'b0;
      _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid_1 <= 1'b0;
      system_uart_0_io_interrupt_plic_gateway_ip <= 1'b0;
      system_uart_0_io_interrupt_plic_gateway_waitCompletion <= 1'b0;
      system_spi_0_io_interrupt_plic_gateway_ip <= 1'b0;
      system_spi_0_io_interrupt_plic_gateway_waitCompletion <= 1'b0;
      system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid <= 1'b0;
      system_gpio_0_io_interrupts_0_plic_gateway_ip <= 1'b0;
      system_gpio_0_io_interrupts_0_plic_gateway_waitCompletion <= 1'b0;
      system_gpio_0_io_interrupts_1_plic_gateway_ip <= 1'b0;
      system_gpio_0_io_interrupts_1_plic_gateway_waitCompletion <= 1'b0;
      _zz_system_plic_logic_bmb_rsp_valid_2 <= 1'b0;
      _zz_system_uart_0_io_interrupt_plic_gateway_priority <= 2'b00;
      _zz_system_spi_0_io_interrupt_plic_gateway_priority <= 2'b00;
      _zz_system_gpio_0_io_interrupts_0_plic_gateway_priority <= 2'b00;
      _zz_system_gpio_0_io_interrupts_1_plic_gateway_priority <= 2'b00;
      system_plic_logic_bridge_coherencyStall_value <= 1'b0;
      _zz_system_cores_0_externalInterrupt_plic_target_threshold <= 2'b00;
      _zz_system_cores_0_externalInterrupt_plic_target_ie_0 <= 1'b0;
      _zz_system_cores_0_externalInterrupt_plic_target_ie_1 <= 1'b0;
      _zz_system_cores_0_externalInterrupt_plic_target_ie_2 <= 1'b0;
      _zz_system_cores_0_externalInterrupt_plic_target_ie_3 <= 1'b0;
    end else begin
      if(system_cores_0_dBus_cmd_valid) begin
        system_cores_0_dBus_cmd_rValid <= 1'b1;
      end
      if(system_cores_0_dBus_cmd_s2mPipe_ready) begin
        system_cores_0_dBus_cmd_rValid <= 1'b0;
      end
      if(system_cores_0_dBus_cmd_s2mPipe_ready) begin
        system_cores_0_dBus_cmd_s2mPipe_rValid <= system_cores_0_dBus_cmd_s2mPipe_valid;
      end
      if(system_cores_0_iBus_cmd_valid) begin
        system_cores_0_iBus_cmd_rValid <= 1'b1;
      end
      if(system_cores_0_iBus_cmd_s2mPipe_ready) begin
        system_cores_0_iBus_cmd_rValid <= 1'b0;
      end
      if(system_cores_0_iBus_cmd_s2mPipe_ready) begin
        system_cores_0_iBus_cmd_s2mPipe_rValid <= system_cores_0_iBus_cmd_s2mPipe_valid;
      end
      if(system_bmbPeripheral_bmb_cmd_valid) begin
        system_bmbPeripheral_bmb_cmd_rValid <= 1'b1;
      end
      if(system_bmbPeripheral_bmb_cmd_halfPipe_fire) begin
        system_bmbPeripheral_bmb_cmd_rValid <= 1'b0;
      end
      if(system_bmbPeripheral_bmb_decoder_io_input_rsp_valid) begin
        _zz_system_bmbPeripheral_bmb_rsp_valid_1 <= 1'b1;
      end
      if((_zz_system_bmbPeripheral_bmb_rsp_valid && system_bmbPeripheral_bmb_rsp_ready)) begin
        _zz_system_bmbPeripheral_bmb_rsp_valid_1 <= 1'b0;
      end
      if(system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid) begin
        system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid <= 1'b1;
      end
      if(system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_fire) begin
        system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid <= 1'b0;
      end
      if(system_uart_0_io_logic_io_bus_rsp_valid) begin
        _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid_1 <= 1'b1;
      end
      if((_zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid && system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_ready)) begin
        _zz_system_uart_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_rsp_valid_1 <= 1'b0;
      end
      if(when_PlicGateway_l21) begin
        system_uart_0_io_interrupt_plic_gateway_ip <= system_uart_0_io_logic_io_interrupt;
        system_uart_0_io_interrupt_plic_gateway_waitCompletion <= system_uart_0_io_logic_io_interrupt;
      end
      if(when_PlicGateway_l21_1) begin
        system_spi_0_io_interrupt_plic_gateway_ip <= system_spi_0_io_logic_io_interrupt;
        system_spi_0_io_interrupt_plic_gateway_waitCompletion <= system_spi_0_io_logic_io_interrupt;
      end
      if(system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_valid) begin
        system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid <= 1'b1;
      end
      if(system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_halfPipe_fire) begin
        system_spi_0_io_ctrl_slaveModel_arbiterGen_oneToOne_arbiter_cmd_rValid <= 1'b0;
      end
      if(when_PlicGateway_l21_2) begin
        system_gpio_0_io_interrupts_0_plic_gateway_ip <= system_gpio_0_io_interrupts_0;
        system_gpio_0_io_interrupts_0_plic_gateway_waitCompletion <= system_gpio_0_io_interrupts_0;
      end
      if(when_PlicGateway_l21_3) begin
        system_gpio_0_io_interrupts_1_plic_gateway_ip <= system_gpio_0_io_interrupts_1;
        system_gpio_0_io_interrupts_1_plic_gateway_waitCompletion <= system_gpio_0_io_interrupts_1;
      end
      if(_zz_system_plic_logic_bus_rsp_ready) begin
        _zz_system_plic_logic_bmb_rsp_valid_2 <= (system_plic_logic_bus_rsp_valid && _zz_system_plic_logic_bmb_rsp_valid);
      end
      if(system_plic_logic_bridge_claim_valid) begin
        case(system_plic_logic_bridge_claim_payload)
          4'b0001 : begin
            system_uart_0_io_interrupt_plic_gateway_ip <= 1'b0;
          end
          4'b0100 : begin
            system_spi_0_io_interrupt_plic_gateway_ip <= 1'b0;
          end
          4'b1100 : begin
            system_gpio_0_io_interrupts_0_plic_gateway_ip <= 1'b0;
          end
          4'b1101 : begin
            system_gpio_0_io_interrupts_1_plic_gateway_ip <= 1'b0;
          end
          default : begin
          end
        endcase
      end
      if(system_plic_logic_bridge_completion_valid) begin
        case(system_plic_logic_bridge_completion_payload)
          4'b0001 : begin
            system_uart_0_io_interrupt_plic_gateway_waitCompletion <= 1'b0;
          end
          4'b0100 : begin
            system_spi_0_io_interrupt_plic_gateway_waitCompletion <= 1'b0;
          end
          4'b1100 : begin
            system_gpio_0_io_interrupts_0_plic_gateway_waitCompletion <= 1'b0;
          end
          4'b1101 : begin
            system_gpio_0_io_interrupts_1_plic_gateway_waitCompletion <= 1'b0;
          end
          default : begin
          end
        endcase
      end
      system_plic_logic_bridge_coherencyStall_value <= system_plic_logic_bridge_coherencyStall_valueNext;
      case(system_plic_logic_bmb_cmd_payload_fragment_address)
        22'h000004 : begin
          if(system_plic_logic_bus_doWrite) begin
            _zz_system_uart_0_io_interrupt_plic_gateway_priority <= system_plic_logic_bmb_cmd_payload_fragment_data[1 : 0];
          end
        end
        22'h000010 : begin
          if(system_plic_logic_bus_doWrite) begin
            _zz_system_spi_0_io_interrupt_plic_gateway_priority <= system_plic_logic_bmb_cmd_payload_fragment_data[1 : 0];
          end
        end
        22'h000030 : begin
          if(system_plic_logic_bus_doWrite) begin
            _zz_system_gpio_0_io_interrupts_0_plic_gateway_priority <= system_plic_logic_bmb_cmd_payload_fragment_data[1 : 0];
          end
        end
        22'h000034 : begin
          if(system_plic_logic_bus_doWrite) begin
            _zz_system_gpio_0_io_interrupts_1_plic_gateway_priority <= system_plic_logic_bmb_cmd_payload_fragment_data[1 : 0];
          end
        end
        22'h200000 : begin
          if(system_plic_logic_bus_doWrite) begin
            _zz_system_cores_0_externalInterrupt_plic_target_threshold <= system_plic_logic_bmb_cmd_payload_fragment_data[1 : 0];
          end
        end
        22'h002000 : begin
          if(system_plic_logic_bus_doWrite) begin
            _zz_system_cores_0_externalInterrupt_plic_target_ie_0 <= system_plic_logic_bmb_cmd_payload_fragment_data[1];
            _zz_system_cores_0_externalInterrupt_plic_target_ie_1 <= system_plic_logic_bmb_cmd_payload_fragment_data[4];
            _zz_system_cores_0_externalInterrupt_plic_target_ie_2 <= system_plic_logic_bmb_cmd_payload_fragment_data[12];
            _zz_system_cores_0_externalInterrupt_plic_target_ie_3 <= system_plic_logic_bmb_cmd_payload_fragment_data[13];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge io_systemClk) begin
    if(debugCd_logic_outputReset) begin
      system_cores_0_logic_cpu_debug_bus_cmd_fire_regNext <= 1'b0;
    end else begin
      system_cores_0_logic_cpu_debug_bus_cmd_fire_regNext <= system_cores_0_logic_cpu_debug_bus_cmd_fire;
    end
  end


endmodule

module BmbGpio2 (
  input      [15:0]   io_gpio_read,
  output reg [15:0]   io_gpio_write,
  output reg [15:0]   io_gpio_writeEnable,
  input               io_bus_cmd_valid,
  output              io_bus_cmd_ready,
  input               io_bus_cmd_payload_last,
  input      [0:0]    io_bus_cmd_payload_fragment_source,
  input      [0:0]    io_bus_cmd_payload_fragment_opcode,
  input      [7:0]    io_bus_cmd_payload_fragment_address,
  input      [1:0]    io_bus_cmd_payload_fragment_length,
  input      [31:0]   io_bus_cmd_payload_fragment_data,
  input      [0:0]    io_bus_cmd_payload_fragment_context,
  output              io_bus_rsp_valid,
  input               io_bus_rsp_ready,
  output              io_bus_rsp_payload_last,
  output     [0:0]    io_bus_rsp_payload_fragment_source,
  output     [0:0]    io_bus_rsp_payload_fragment_opcode,
  output     [31:0]   io_bus_rsp_payload_fragment_data,
  output     [0:0]    io_bus_rsp_payload_fragment_context,
  output reg [15:0]   io_interrupt,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire                mapper_readHaltTrigger;
  wire                mapper_writeHaltTrigger;
  wire                mapper_rsp_valid;
  wire                mapper_rsp_ready;
  wire                mapper_rsp_payload_last;
  wire       [0:0]    mapper_rsp_payload_fragment_source;
  wire       [0:0]    mapper_rsp_payload_fragment_opcode;
  reg        [31:0]   mapper_rsp_payload_fragment_data;
  wire       [0:0]    mapper_rsp_payload_fragment_context;
  wire                _zz_io_bus_rsp_valid;
  reg                 _zz_mapper_rsp_ready;
  wire                _zz_io_bus_rsp_valid_1;
  reg                 _zz_io_bus_rsp_valid_2;
  reg                 _zz_io_bus_rsp_payload_last;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_source;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_io_bus_rsp_payload_fragment_data;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_context;
  wire                when_Stream_l342;
  wire                mapper_askWrite;
  wire                mapper_askRead;
  wire                io_bus_cmd_fire;
  wire                mapper_doWrite;
  wire                io_bus_cmd_fire_1;
  wire                mapper_doRead;
  reg        [15:0]   io_gpio_read_delay_1;
  reg        [15:0]   syncronized;
  reg        [15:0]   last;
  reg                 _zz_io_gpio_write;
  reg                 _zz_io_gpio_writeEnable;
  reg                 _zz_io_gpio_write_1;
  reg                 _zz_io_gpio_writeEnable_1;
  reg                 _zz_io_gpio_write_2;
  reg                 _zz_io_gpio_writeEnable_2;
  reg                 _zz_io_gpio_write_3;
  reg                 _zz_io_gpio_writeEnable_3;
  reg                 _zz_io_gpio_write_4;
  reg                 _zz_io_gpio_writeEnable_4;
  reg                 _zz_io_gpio_write_5;
  reg                 _zz_io_gpio_writeEnable_5;
  reg                 _zz_io_gpio_write_6;
  reg                 _zz_io_gpio_writeEnable_6;
  reg                 _zz_io_gpio_write_7;
  reg                 _zz_io_gpio_writeEnable_7;
  reg                 _zz_io_gpio_write_8;
  reg                 _zz_io_gpio_writeEnable_8;
  reg                 _zz_io_gpio_write_9;
  reg                 _zz_io_gpio_writeEnable_9;
  reg                 _zz_io_gpio_write_10;
  reg                 _zz_io_gpio_writeEnable_10;
  reg                 _zz_io_gpio_write_11;
  reg                 _zz_io_gpio_writeEnable_11;
  reg                 _zz_io_gpio_write_12;
  reg                 _zz_io_gpio_writeEnable_12;
  reg                 _zz_io_gpio_write_13;
  reg                 _zz_io_gpio_writeEnable_13;
  reg                 _zz_io_gpio_write_14;
  reg                 _zz_io_gpio_writeEnable_14;
  reg                 _zz_io_gpio_write_15;
  reg                 _zz_io_gpio_writeEnable_15;
  reg        [15:0]   interrupt_enable_high;
  reg        [15:0]   interrupt_enable_low;
  reg        [15:0]   interrupt_enable_rise;
  reg        [15:0]   interrupt_enable_fall;
  wire       [15:0]   interrupt_valid;
  reg                 _zz_mapper_rsp_payload_fragment_data;
  reg                 _zz_mapper_rsp_payload_fragment_data_1;
  reg                 _zz_mapper_rsp_payload_fragment_data_2;
  reg                 _zz_mapper_rsp_payload_fragment_data_3;
  reg                 _zz_mapper_rsp_payload_fragment_data_4;
  reg                 _zz_mapper_rsp_payload_fragment_data_5;
  reg                 _zz_mapper_rsp_payload_fragment_data_6;
  reg                 _zz_mapper_rsp_payload_fragment_data_7;

  assign mapper_readHaltTrigger = 1'b0;
  assign mapper_writeHaltTrigger = 1'b0;
  assign _zz_io_bus_rsp_valid = (! (mapper_readHaltTrigger || mapper_writeHaltTrigger));
  assign mapper_rsp_ready = (_zz_mapper_rsp_ready && _zz_io_bus_rsp_valid);
  always @(*) begin
    _zz_mapper_rsp_ready = io_bus_rsp_ready;
    if(when_Stream_l342) begin
      _zz_mapper_rsp_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! _zz_io_bus_rsp_valid_1);
  assign _zz_io_bus_rsp_valid_1 = _zz_io_bus_rsp_valid_2;
  assign io_bus_rsp_valid = _zz_io_bus_rsp_valid_1;
  assign io_bus_rsp_payload_last = _zz_io_bus_rsp_payload_last;
  assign io_bus_rsp_payload_fragment_source = _zz_io_bus_rsp_payload_fragment_source;
  assign io_bus_rsp_payload_fragment_opcode = _zz_io_bus_rsp_payload_fragment_opcode;
  assign io_bus_rsp_payload_fragment_data = _zz_io_bus_rsp_payload_fragment_data;
  assign io_bus_rsp_payload_fragment_context = _zz_io_bus_rsp_payload_fragment_context;
  assign mapper_askWrite = (io_bus_cmd_valid && (io_bus_cmd_payload_fragment_opcode == 1'b1));
  assign mapper_askRead = (io_bus_cmd_valid && (io_bus_cmd_payload_fragment_opcode == 1'b0));
  assign io_bus_cmd_fire = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign mapper_doWrite = (io_bus_cmd_fire && (io_bus_cmd_payload_fragment_opcode == 1'b1));
  assign io_bus_cmd_fire_1 = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign mapper_doRead = (io_bus_cmd_fire_1 && (io_bus_cmd_payload_fragment_opcode == 1'b0));
  assign mapper_rsp_valid = io_bus_cmd_valid;
  assign io_bus_cmd_ready = mapper_rsp_ready;
  assign mapper_rsp_payload_last = 1'b1;
  assign mapper_rsp_payload_fragment_opcode = 1'b0;
  always @(*) begin
    mapper_rsp_payload_fragment_data = 32'h0;
    case(io_bus_cmd_payload_fragment_address)
      8'h0 : begin
        mapper_rsp_payload_fragment_data[0 : 0] = syncronized[0];
        mapper_rsp_payload_fragment_data[1 : 1] = syncronized[1];
        mapper_rsp_payload_fragment_data[2 : 2] = syncronized[2];
        mapper_rsp_payload_fragment_data[3 : 3] = syncronized[3];
        mapper_rsp_payload_fragment_data[4 : 4] = syncronized[4];
        mapper_rsp_payload_fragment_data[5 : 5] = syncronized[5];
        mapper_rsp_payload_fragment_data[6 : 6] = syncronized[6];
        mapper_rsp_payload_fragment_data[7 : 7] = syncronized[7];
        mapper_rsp_payload_fragment_data[8 : 8] = syncronized[8];
        mapper_rsp_payload_fragment_data[9 : 9] = syncronized[9];
        mapper_rsp_payload_fragment_data[10 : 10] = syncronized[10];
        mapper_rsp_payload_fragment_data[11 : 11] = syncronized[11];
        mapper_rsp_payload_fragment_data[12 : 12] = syncronized[12];
        mapper_rsp_payload_fragment_data[13 : 13] = syncronized[13];
        mapper_rsp_payload_fragment_data[14 : 14] = syncronized[14];
        mapper_rsp_payload_fragment_data[15 : 15] = syncronized[15];
      end
      8'h04 : begin
        mapper_rsp_payload_fragment_data[0 : 0] = _zz_io_gpio_write;
        mapper_rsp_payload_fragment_data[1 : 1] = _zz_io_gpio_write_1;
        mapper_rsp_payload_fragment_data[2 : 2] = _zz_io_gpio_write_2;
        mapper_rsp_payload_fragment_data[3 : 3] = _zz_io_gpio_write_3;
        mapper_rsp_payload_fragment_data[4 : 4] = _zz_io_gpio_write_4;
        mapper_rsp_payload_fragment_data[5 : 5] = _zz_io_gpio_write_5;
        mapper_rsp_payload_fragment_data[6 : 6] = _zz_io_gpio_write_6;
        mapper_rsp_payload_fragment_data[7 : 7] = _zz_io_gpio_write_7;
        mapper_rsp_payload_fragment_data[8 : 8] = _zz_io_gpio_write_8;
        mapper_rsp_payload_fragment_data[9 : 9] = _zz_io_gpio_write_9;
        mapper_rsp_payload_fragment_data[10 : 10] = _zz_io_gpio_write_10;
        mapper_rsp_payload_fragment_data[11 : 11] = _zz_io_gpio_write_11;
        mapper_rsp_payload_fragment_data[12 : 12] = _zz_io_gpio_write_12;
        mapper_rsp_payload_fragment_data[13 : 13] = _zz_io_gpio_write_13;
        mapper_rsp_payload_fragment_data[14 : 14] = _zz_io_gpio_write_14;
        mapper_rsp_payload_fragment_data[15 : 15] = _zz_io_gpio_write_15;
      end
      8'h08 : begin
        mapper_rsp_payload_fragment_data[0 : 0] = _zz_io_gpio_writeEnable;
        mapper_rsp_payload_fragment_data[1 : 1] = _zz_io_gpio_writeEnable_1;
        mapper_rsp_payload_fragment_data[2 : 2] = _zz_io_gpio_writeEnable_2;
        mapper_rsp_payload_fragment_data[3 : 3] = _zz_io_gpio_writeEnable_3;
        mapper_rsp_payload_fragment_data[4 : 4] = _zz_io_gpio_writeEnable_4;
        mapper_rsp_payload_fragment_data[5 : 5] = _zz_io_gpio_writeEnable_5;
        mapper_rsp_payload_fragment_data[6 : 6] = _zz_io_gpio_writeEnable_6;
        mapper_rsp_payload_fragment_data[7 : 7] = _zz_io_gpio_writeEnable_7;
        mapper_rsp_payload_fragment_data[8 : 8] = _zz_io_gpio_writeEnable_8;
        mapper_rsp_payload_fragment_data[9 : 9] = _zz_io_gpio_writeEnable_9;
        mapper_rsp_payload_fragment_data[10 : 10] = _zz_io_gpio_writeEnable_10;
        mapper_rsp_payload_fragment_data[11 : 11] = _zz_io_gpio_writeEnable_11;
        mapper_rsp_payload_fragment_data[12 : 12] = _zz_io_gpio_writeEnable_12;
        mapper_rsp_payload_fragment_data[13 : 13] = _zz_io_gpio_writeEnable_13;
        mapper_rsp_payload_fragment_data[14 : 14] = _zz_io_gpio_writeEnable_14;
        mapper_rsp_payload_fragment_data[15 : 15] = _zz_io_gpio_writeEnable_15;
      end
      8'h20 : begin
        mapper_rsp_payload_fragment_data[0 : 0] = _zz_mapper_rsp_payload_fragment_data;
        mapper_rsp_payload_fragment_data[1 : 1] = _zz_mapper_rsp_payload_fragment_data_4;
      end
      8'h24 : begin
        mapper_rsp_payload_fragment_data[0 : 0] = _zz_mapper_rsp_payload_fragment_data_1;
        mapper_rsp_payload_fragment_data[1 : 1] = _zz_mapper_rsp_payload_fragment_data_5;
      end
      8'h28 : begin
        mapper_rsp_payload_fragment_data[0 : 0] = _zz_mapper_rsp_payload_fragment_data_2;
        mapper_rsp_payload_fragment_data[1 : 1] = _zz_mapper_rsp_payload_fragment_data_6;
      end
      8'h2c : begin
        mapper_rsp_payload_fragment_data[0 : 0] = _zz_mapper_rsp_payload_fragment_data_3;
        mapper_rsp_payload_fragment_data[1 : 1] = _zz_mapper_rsp_payload_fragment_data_7;
      end
      default : begin
      end
    endcase
  end

  assign mapper_rsp_payload_fragment_context = io_bus_cmd_payload_fragment_context;
  assign mapper_rsp_payload_fragment_source = io_bus_cmd_payload_fragment_source;
  always @(*) begin
    io_gpio_write[0] = _zz_io_gpio_write;
    io_gpio_write[1] = _zz_io_gpio_write_1;
    io_gpio_write[2] = _zz_io_gpio_write_2;
    io_gpio_write[3] = _zz_io_gpio_write_3;
    io_gpio_write[4] = _zz_io_gpio_write_4;
    io_gpio_write[5] = _zz_io_gpio_write_5;
    io_gpio_write[6] = _zz_io_gpio_write_6;
    io_gpio_write[7] = _zz_io_gpio_write_7;
    io_gpio_write[8] = _zz_io_gpio_write_8;
    io_gpio_write[9] = _zz_io_gpio_write_9;
    io_gpio_write[10] = _zz_io_gpio_write_10;
    io_gpio_write[11] = _zz_io_gpio_write_11;
    io_gpio_write[12] = _zz_io_gpio_write_12;
    io_gpio_write[13] = _zz_io_gpio_write_13;
    io_gpio_write[14] = _zz_io_gpio_write_14;
    io_gpio_write[15] = _zz_io_gpio_write_15;
  end

  always @(*) begin
    io_gpio_writeEnable[0] = _zz_io_gpio_writeEnable;
    io_gpio_writeEnable[1] = _zz_io_gpio_writeEnable_1;
    io_gpio_writeEnable[2] = _zz_io_gpio_writeEnable_2;
    io_gpio_writeEnable[3] = _zz_io_gpio_writeEnable_3;
    io_gpio_writeEnable[4] = _zz_io_gpio_writeEnable_4;
    io_gpio_writeEnable[5] = _zz_io_gpio_writeEnable_5;
    io_gpio_writeEnable[6] = _zz_io_gpio_writeEnable_6;
    io_gpio_writeEnable[7] = _zz_io_gpio_writeEnable_7;
    io_gpio_writeEnable[8] = _zz_io_gpio_writeEnable_8;
    io_gpio_writeEnable[9] = _zz_io_gpio_writeEnable_9;
    io_gpio_writeEnable[10] = _zz_io_gpio_writeEnable_10;
    io_gpio_writeEnable[11] = _zz_io_gpio_writeEnable_11;
    io_gpio_writeEnable[12] = _zz_io_gpio_writeEnable_12;
    io_gpio_writeEnable[13] = _zz_io_gpio_writeEnable_13;
    io_gpio_writeEnable[14] = _zz_io_gpio_writeEnable_14;
    io_gpio_writeEnable[15] = _zz_io_gpio_writeEnable_15;
  end

  assign interrupt_valid = ((((interrupt_enable_high & syncronized) | (interrupt_enable_low & (~ syncronized))) | (interrupt_enable_rise & (syncronized & (~ last)))) | (interrupt_enable_fall & ((~ syncronized) & last)));
  always @(*) begin
    io_interrupt[0] = interrupt_valid[0];
    io_interrupt[1] = interrupt_valid[1];
    io_interrupt[2] = 1'b0;
    io_interrupt[3] = 1'b0;
    io_interrupt[4] = 1'b0;
    io_interrupt[5] = 1'b0;
    io_interrupt[6] = 1'b0;
    io_interrupt[7] = 1'b0;
    io_interrupt[8] = 1'b0;
    io_interrupt[9] = 1'b0;
    io_interrupt[10] = 1'b0;
    io_interrupt[11] = 1'b0;
    io_interrupt[12] = 1'b0;
    io_interrupt[13] = 1'b0;
    io_interrupt[14] = 1'b0;
    io_interrupt[15] = 1'b0;
  end

  always @(*) begin
    interrupt_enable_rise[0] = _zz_mapper_rsp_payload_fragment_data;
    interrupt_enable_rise[1] = _zz_mapper_rsp_payload_fragment_data_4;
    interrupt_enable_rise[2] = 1'b0;
    interrupt_enable_rise[3] = 1'b0;
    interrupt_enable_rise[4] = 1'b0;
    interrupt_enable_rise[5] = 1'b0;
    interrupt_enable_rise[6] = 1'b0;
    interrupt_enable_rise[7] = 1'b0;
    interrupt_enable_rise[8] = 1'b0;
    interrupt_enable_rise[9] = 1'b0;
    interrupt_enable_rise[10] = 1'b0;
    interrupt_enable_rise[11] = 1'b0;
    interrupt_enable_rise[12] = 1'b0;
    interrupt_enable_rise[13] = 1'b0;
    interrupt_enable_rise[14] = 1'b0;
    interrupt_enable_rise[15] = 1'b0;
  end

  always @(*) begin
    interrupt_enable_fall[0] = _zz_mapper_rsp_payload_fragment_data_1;
    interrupt_enable_fall[1] = _zz_mapper_rsp_payload_fragment_data_5;
    interrupt_enable_fall[2] = 1'b0;
    interrupt_enable_fall[3] = 1'b0;
    interrupt_enable_fall[4] = 1'b0;
    interrupt_enable_fall[5] = 1'b0;
    interrupt_enable_fall[6] = 1'b0;
    interrupt_enable_fall[7] = 1'b0;
    interrupt_enable_fall[8] = 1'b0;
    interrupt_enable_fall[9] = 1'b0;
    interrupt_enable_fall[10] = 1'b0;
    interrupt_enable_fall[11] = 1'b0;
    interrupt_enable_fall[12] = 1'b0;
    interrupt_enable_fall[13] = 1'b0;
    interrupt_enable_fall[14] = 1'b0;
    interrupt_enable_fall[15] = 1'b0;
  end

  always @(*) begin
    interrupt_enable_high[0] = _zz_mapper_rsp_payload_fragment_data_2;
    interrupt_enable_high[1] = _zz_mapper_rsp_payload_fragment_data_6;
    interrupt_enable_high[2] = 1'b0;
    interrupt_enable_high[3] = 1'b0;
    interrupt_enable_high[4] = 1'b0;
    interrupt_enable_high[5] = 1'b0;
    interrupt_enable_high[6] = 1'b0;
    interrupt_enable_high[7] = 1'b0;
    interrupt_enable_high[8] = 1'b0;
    interrupt_enable_high[9] = 1'b0;
    interrupt_enable_high[10] = 1'b0;
    interrupt_enable_high[11] = 1'b0;
    interrupt_enable_high[12] = 1'b0;
    interrupt_enable_high[13] = 1'b0;
    interrupt_enable_high[14] = 1'b0;
    interrupt_enable_high[15] = 1'b0;
  end

  always @(*) begin
    interrupt_enable_low[0] = _zz_mapper_rsp_payload_fragment_data_3;
    interrupt_enable_low[1] = _zz_mapper_rsp_payload_fragment_data_7;
    interrupt_enable_low[2] = 1'b0;
    interrupt_enable_low[3] = 1'b0;
    interrupt_enable_low[4] = 1'b0;
    interrupt_enable_low[5] = 1'b0;
    interrupt_enable_low[6] = 1'b0;
    interrupt_enable_low[7] = 1'b0;
    interrupt_enable_low[8] = 1'b0;
    interrupt_enable_low[9] = 1'b0;
    interrupt_enable_low[10] = 1'b0;
    interrupt_enable_low[11] = 1'b0;
    interrupt_enable_low[12] = 1'b0;
    interrupt_enable_low[13] = 1'b0;
    interrupt_enable_low[14] = 1'b0;
    interrupt_enable_low[15] = 1'b0;
  end

  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      _zz_io_bus_rsp_valid_2 <= 1'b0;
      _zz_io_gpio_writeEnable <= 1'b0;
      _zz_io_gpio_writeEnable_1 <= 1'b0;
      _zz_io_gpio_writeEnable_2 <= 1'b0;
      _zz_io_gpio_writeEnable_3 <= 1'b0;
      _zz_io_gpio_writeEnable_4 <= 1'b0;
      _zz_io_gpio_writeEnable_5 <= 1'b0;
      _zz_io_gpio_writeEnable_6 <= 1'b0;
      _zz_io_gpio_writeEnable_7 <= 1'b0;
      _zz_io_gpio_writeEnable_8 <= 1'b0;
      _zz_io_gpio_writeEnable_9 <= 1'b0;
      _zz_io_gpio_writeEnable_10 <= 1'b0;
      _zz_io_gpio_writeEnable_11 <= 1'b0;
      _zz_io_gpio_writeEnable_12 <= 1'b0;
      _zz_io_gpio_writeEnable_13 <= 1'b0;
      _zz_io_gpio_writeEnable_14 <= 1'b0;
      _zz_io_gpio_writeEnable_15 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_1 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_2 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_3 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_4 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_5 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_6 <= 1'b0;
      _zz_mapper_rsp_payload_fragment_data_7 <= 1'b0;
    end else begin
      if(_zz_mapper_rsp_ready) begin
        _zz_io_bus_rsp_valid_2 <= (mapper_rsp_valid && _zz_io_bus_rsp_valid);
      end
      case(io_bus_cmd_payload_fragment_address)
        8'h08 : begin
          if(mapper_doWrite) begin
            _zz_io_gpio_writeEnable <= io_bus_cmd_payload_fragment_data[0];
            _zz_io_gpio_writeEnable_1 <= io_bus_cmd_payload_fragment_data[1];
            _zz_io_gpio_writeEnable_2 <= io_bus_cmd_payload_fragment_data[2];
            _zz_io_gpio_writeEnable_3 <= io_bus_cmd_payload_fragment_data[3];
            _zz_io_gpio_writeEnable_4 <= io_bus_cmd_payload_fragment_data[4];
            _zz_io_gpio_writeEnable_5 <= io_bus_cmd_payload_fragment_data[5];
            _zz_io_gpio_writeEnable_6 <= io_bus_cmd_payload_fragment_data[6];
            _zz_io_gpio_writeEnable_7 <= io_bus_cmd_payload_fragment_data[7];
            _zz_io_gpio_writeEnable_8 <= io_bus_cmd_payload_fragment_data[8];
            _zz_io_gpio_writeEnable_9 <= io_bus_cmd_payload_fragment_data[9];
            _zz_io_gpio_writeEnable_10 <= io_bus_cmd_payload_fragment_data[10];
            _zz_io_gpio_writeEnable_11 <= io_bus_cmd_payload_fragment_data[11];
            _zz_io_gpio_writeEnable_12 <= io_bus_cmd_payload_fragment_data[12];
            _zz_io_gpio_writeEnable_13 <= io_bus_cmd_payload_fragment_data[13];
            _zz_io_gpio_writeEnable_14 <= io_bus_cmd_payload_fragment_data[14];
            _zz_io_gpio_writeEnable_15 <= io_bus_cmd_payload_fragment_data[15];
          end
        end
        8'h20 : begin
          if(mapper_doWrite) begin
            _zz_mapper_rsp_payload_fragment_data <= io_bus_cmd_payload_fragment_data[0];
            _zz_mapper_rsp_payload_fragment_data_4 <= io_bus_cmd_payload_fragment_data[1];
          end
        end
        8'h24 : begin
          if(mapper_doWrite) begin
            _zz_mapper_rsp_payload_fragment_data_1 <= io_bus_cmd_payload_fragment_data[0];
            _zz_mapper_rsp_payload_fragment_data_5 <= io_bus_cmd_payload_fragment_data[1];
          end
        end
        8'h28 : begin
          if(mapper_doWrite) begin
            _zz_mapper_rsp_payload_fragment_data_2 <= io_bus_cmd_payload_fragment_data[0];
            _zz_mapper_rsp_payload_fragment_data_6 <= io_bus_cmd_payload_fragment_data[1];
          end
        end
        8'h2c : begin
          if(mapper_doWrite) begin
            _zz_mapper_rsp_payload_fragment_data_3 <= io_bus_cmd_payload_fragment_data[0];
            _zz_mapper_rsp_payload_fragment_data_7 <= io_bus_cmd_payload_fragment_data[1];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_mapper_rsp_ready) begin
      _zz_io_bus_rsp_payload_last <= mapper_rsp_payload_last;
      _zz_io_bus_rsp_payload_fragment_source <= mapper_rsp_payload_fragment_source;
      _zz_io_bus_rsp_payload_fragment_opcode <= mapper_rsp_payload_fragment_opcode;
      _zz_io_bus_rsp_payload_fragment_data <= mapper_rsp_payload_fragment_data;
      _zz_io_bus_rsp_payload_fragment_context <= mapper_rsp_payload_fragment_context;
    end
    io_gpio_read_delay_1 <= io_gpio_read;
    syncronized <= io_gpio_read_delay_1;
    last <= syncronized;
    case(io_bus_cmd_payload_fragment_address)
      8'h04 : begin
        if(mapper_doWrite) begin
          _zz_io_gpio_write <= io_bus_cmd_payload_fragment_data[0];
          _zz_io_gpio_write_1 <= io_bus_cmd_payload_fragment_data[1];
          _zz_io_gpio_write_2 <= io_bus_cmd_payload_fragment_data[2];
          _zz_io_gpio_write_3 <= io_bus_cmd_payload_fragment_data[3];
          _zz_io_gpio_write_4 <= io_bus_cmd_payload_fragment_data[4];
          _zz_io_gpio_write_5 <= io_bus_cmd_payload_fragment_data[5];
          _zz_io_gpio_write_6 <= io_bus_cmd_payload_fragment_data[6];
          _zz_io_gpio_write_7 <= io_bus_cmd_payload_fragment_data[7];
          _zz_io_gpio_write_8 <= io_bus_cmd_payload_fragment_data[8];
          _zz_io_gpio_write_9 <= io_bus_cmd_payload_fragment_data[9];
          _zz_io_gpio_write_10 <= io_bus_cmd_payload_fragment_data[10];
          _zz_io_gpio_write_11 <= io_bus_cmd_payload_fragment_data[11];
          _zz_io_gpio_write_12 <= io_bus_cmd_payload_fragment_data[12];
          _zz_io_gpio_write_13 <= io_bus_cmd_payload_fragment_data[13];
          _zz_io_gpio_write_14 <= io_bus_cmd_payload_fragment_data[14];
          _zz_io_gpio_write_15 <= io_bus_cmd_payload_fragment_data[15];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BmbSpiXdrMasterCtrl (
  input               io_ctrl_cmd_valid,
  output              io_ctrl_cmd_ready,
  input               io_ctrl_cmd_payload_last,
  input      [0:0]    io_ctrl_cmd_payload_fragment_source,
  input      [0:0]    io_ctrl_cmd_payload_fragment_opcode,
  input      [11:0]   io_ctrl_cmd_payload_fragment_address,
  input      [1:0]    io_ctrl_cmd_payload_fragment_length,
  input      [31:0]   io_ctrl_cmd_payload_fragment_data,
  input      [0:0]    io_ctrl_cmd_payload_fragment_context,
  output              io_ctrl_rsp_valid,
  input               io_ctrl_rsp_ready,
  output              io_ctrl_rsp_payload_last,
  output     [0:0]    io_ctrl_rsp_payload_fragment_source,
  output     [0:0]    io_ctrl_rsp_payload_fragment_opcode,
  output     [31:0]   io_ctrl_rsp_payload_fragment_data,
  output     [0:0]    io_ctrl_rsp_payload_fragment_context,
  output     [0:0]    io_spi_sclk_write,
  output              io_spi_data_0_writeEnable,
  input      [0:0]    io_spi_data_0_read,
  output     [0:0]    io_spi_data_0_write,
  output              io_spi_data_1_writeEnable,
  input      [0:0]    io_spi_data_1_read,
  output     [0:0]    io_spi_data_1_write,
  output              io_spi_data_2_writeEnable,
  input      [0:0]    io_spi_data_2_read,
  output     [0:0]    io_spi_data_2_write,
  output              io_spi_data_3_writeEnable,
  input      [0:0]    io_spi_data_3_read,
  output     [0:0]    io_spi_data_3_write,
  output     [0:0]    io_spi_ss,
  output              io_interrupt,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_ready;
  reg                 ctrl_io_rsp_queueWithOccupancy_io_pop_ready;
  wire                ctrl_io_cmd_ready;
  wire                ctrl_io_rsp_valid;
  wire       [7:0]    ctrl_io_rsp_payload_data;
  wire       [0:0]    ctrl_io_spi_sclk_write;
  wire       [0:0]    ctrl_io_spi_ss;
  wire       [0:0]    ctrl_io_spi_data_0_write;
  wire                ctrl_io_spi_data_0_writeEnable;
  wire       [0:0]    ctrl_io_spi_data_1_write;
  wire                ctrl_io_spi_data_1_writeEnable;
  wire       [0:0]    ctrl_io_spi_data_2_write;
  wire                ctrl_io_spi_data_2_writeEnable;
  wire       [0:0]    ctrl_io_spi_data_3_write;
  wire                ctrl_io_spi_data_3_writeEnable;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_kind;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_read;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_write;
  wire       [7:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_data;
  wire       [8:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_occupancy;
  wire       [8:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability;
  wire                ctrl_io_rsp_queueWithOccupancy_io_push_ready;
  wire                ctrl_io_rsp_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    ctrl_io_rsp_queueWithOccupancy_io_pop_payload_data;
  wire       [8:0]    ctrl_io_rsp_queueWithOccupancy_io_occupancy;
  wire       [8:0]    ctrl_io_rsp_queueWithOccupancy_io_availability;
  wire                factory_readHaltTrigger;
  wire                factory_writeHaltTrigger;
  wire                factory_rsp_valid;
  wire                factory_rsp_ready;
  wire                factory_rsp_payload_last;
  wire       [0:0]    factory_rsp_payload_fragment_source;
  wire       [0:0]    factory_rsp_payload_fragment_opcode;
  reg        [31:0]   factory_rsp_payload_fragment_data;
  wire       [0:0]    factory_rsp_payload_fragment_context;
  wire                _zz_io_ctrl_rsp_valid;
  reg                 _zz_factory_rsp_ready;
  wire                _zz_io_ctrl_rsp_valid_1;
  reg                 _zz_io_ctrl_rsp_valid_2;
  reg                 _zz_io_ctrl_rsp_payload_last;
  reg        [0:0]    _zz_io_ctrl_rsp_payload_fragment_source;
  reg        [0:0]    _zz_io_ctrl_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_io_ctrl_rsp_payload_fragment_data;
  reg        [0:0]    _zz_io_ctrl_rsp_payload_fragment_context;
  wire                when_Stream_l342;
  wire                factory_askWrite;
  wire                factory_askRead;
  wire                io_ctrl_cmd_fire;
  wire                factory_doWrite;
  wire                io_ctrl_cmd_fire_1;
  wire                factory_doRead;
  wire                mapping_cmdLogic_streamUnbuffered_valid;
  wire                mapping_cmdLogic_streamUnbuffered_ready;
  wire                mapping_cmdLogic_streamUnbuffered_payload_kind;
  wire                mapping_cmdLogic_streamUnbuffered_payload_read;
  wire                mapping_cmdLogic_streamUnbuffered_payload_write;
  wire       [7:0]    mapping_cmdLogic_streamUnbuffered_payload_data;
  reg                 _zz_mapping_cmdLogic_streamUnbuffered_valid;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_valid;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_ready;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_kind;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_read;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_write;
  wire       [7:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_data;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_kind;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_read;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_write;
  reg        [7:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_data;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_valid;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_ready;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_kind;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_read;
  wire                mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_write;
  wire       [7:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_data;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rValid;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_kind;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_read;
  reg                 mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_write;
  reg        [7:0]    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_data;
  wire                when_Stream_l342_1;
  reg                 mapping_interruptCtrl_cmdIntEnable;
  reg                 mapping_interruptCtrl_rspIntEnable;
  wire                mapping_interruptCtrl_cmdInt;
  wire                mapping_interruptCtrl_rspInt;
  wire                mapping_interruptCtrl_interrupt;
  reg                 _zz_io_config_kind_cpol;
  reg                 _zz_io_config_kind_cpha;
  reg        [1:0]    _zz_io_config_mod;
  reg        [11:0]   _zz_io_config_sclkToogle;
  reg        [11:0]   _zz_io_config_ss_setup;
  reg        [11:0]   _zz_io_config_ss_hold;
  reg        [11:0]   _zz_io_config_ss_disable;
  reg        [0:0]    _zz_io_config_ss_activeHigh;
  wire       [1:0]    _zz_io_config_kind_cpol_1;

  SpiXdrMasterCtrl ctrl (
    .io_config_kind_cpol           (_zz_io_config_kind_cpol                                                                           ), //i
    .io_config_kind_cpha           (_zz_io_config_kind_cpha                                                                           ), //i
    .io_config_sclkToogle          (_zz_io_config_sclkToogle[11:0]                                                                    ), //i
    .io_config_mod                 (_zz_io_config_mod[1:0]                                                                            ), //i
    .io_config_ss_activeHigh       (_zz_io_config_ss_activeHigh                                                                       ), //i
    .io_config_ss_setup            (_zz_io_config_ss_setup[11:0]                                                                      ), //i
    .io_config_ss_hold             (_zz_io_config_ss_hold[11:0]                                                                       ), //i
    .io_config_ss_disable          (_zz_io_config_ss_disable[11:0]                                                                    ), //i
    .io_cmd_valid                  (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_valid              ), //i
    .io_cmd_ready                  (ctrl_io_cmd_ready                                                                                 ), //o
    .io_cmd_payload_kind           (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_kind       ), //i
    .io_cmd_payload_read           (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_read       ), //i
    .io_cmd_payload_write          (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_write      ), //i
    .io_cmd_payload_data           (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_data[7:0]  ), //i
    .io_rsp_valid                  (ctrl_io_rsp_valid                                                                                 ), //o
    .io_rsp_payload_data           (ctrl_io_rsp_payload_data[7:0]                                                                     ), //o
    .io_spi_sclk_write             (ctrl_io_spi_sclk_write                                                                            ), //o
    .io_spi_data_0_writeEnable     (ctrl_io_spi_data_0_writeEnable                                                                    ), //o
    .io_spi_data_0_read            (io_spi_data_0_read                                                                                ), //i
    .io_spi_data_0_write           (ctrl_io_spi_data_0_write                                                                          ), //o
    .io_spi_data_1_writeEnable     (ctrl_io_spi_data_1_writeEnable                                                                    ), //o
    .io_spi_data_1_read            (io_spi_data_1_read                                                                                ), //i
    .io_spi_data_1_write           (ctrl_io_spi_data_1_write                                                                          ), //o
    .io_spi_data_2_writeEnable     (ctrl_io_spi_data_2_writeEnable                                                                    ), //o
    .io_spi_data_2_read            (io_spi_data_2_read                                                                                ), //i
    .io_spi_data_2_write           (ctrl_io_spi_data_2_write                                                                          ), //o
    .io_spi_data_3_writeEnable     (ctrl_io_spi_data_3_writeEnable                                                                    ), //o
    .io_spi_data_3_read            (io_spi_data_3_read                                                                                ), //i
    .io_spi_data_3_write           (ctrl_io_spi_data_3_write                                                                          ), //o
    .io_spi_ss                     (ctrl_io_spi_ss                                                                                    ), //o
    .io_systemClk                  (io_systemClk                                                                                      ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                                                                        )  //i
  );
  StreamFifo_2 mapping_cmdLogic_streamUnbuffered_queueWithAvailability (
    .io_push_valid                 (mapping_cmdLogic_streamUnbuffered_valid                                           ), //i
    .io_push_ready                 (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready             ), //o
    .io_push_payload_kind          (mapping_cmdLogic_streamUnbuffered_payload_kind                                    ), //i
    .io_push_payload_read          (mapping_cmdLogic_streamUnbuffered_payload_read                                    ), //i
    .io_push_payload_write         (mapping_cmdLogic_streamUnbuffered_payload_write                                   ), //i
    .io_push_payload_data          (mapping_cmdLogic_streamUnbuffered_payload_data[7:0]                               ), //i
    .io_pop_valid                  (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid              ), //o
    .io_pop_ready                  (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_ready              ), //i
    .io_pop_payload_kind           (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_kind       ), //o
    .io_pop_payload_read           (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_read       ), //o
    .io_pop_payload_write          (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_write      ), //o
    .io_pop_payload_data           (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_data[7:0]  ), //o
    .io_flush                      (1'b0                                                                              ), //i
    .io_occupancy                  (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_occupancy[8:0]         ), //o
    .io_availability               (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability[8:0]      ), //o
    .io_systemClk                  (io_systemClk                                                                      ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                                                        )  //i
  );
  StreamFifo_3 ctrl_io_rsp_queueWithOccupancy (
    .io_push_valid                 (ctrl_io_rsp_valid                                        ), //i
    .io_push_ready                 (ctrl_io_rsp_queueWithOccupancy_io_push_ready             ), //o
    .io_push_payload_data          (ctrl_io_rsp_payload_data[7:0]                            ), //i
    .io_pop_valid                  (ctrl_io_rsp_queueWithOccupancy_io_pop_valid              ), //o
    .io_pop_ready                  (ctrl_io_rsp_queueWithOccupancy_io_pop_ready              ), //i
    .io_pop_payload_data           (ctrl_io_rsp_queueWithOccupancy_io_pop_payload_data[7:0]  ), //o
    .io_flush                      (1'b0                                                     ), //i
    .io_occupancy                  (ctrl_io_rsp_queueWithOccupancy_io_occupancy[8:0]         ), //o
    .io_availability               (ctrl_io_rsp_queueWithOccupancy_io_availability[8:0]      ), //o
    .io_systemClk                  (io_systemClk                                             ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                               )  //i
  );
  assign factory_readHaltTrigger = 1'b0;
  assign factory_writeHaltTrigger = 1'b0;
  assign _zz_io_ctrl_rsp_valid = (! (factory_readHaltTrigger || factory_writeHaltTrigger));
  assign factory_rsp_ready = (_zz_factory_rsp_ready && _zz_io_ctrl_rsp_valid);
  always @(*) begin
    _zz_factory_rsp_ready = io_ctrl_rsp_ready;
    if(when_Stream_l342) begin
      _zz_factory_rsp_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! _zz_io_ctrl_rsp_valid_1);
  assign _zz_io_ctrl_rsp_valid_1 = _zz_io_ctrl_rsp_valid_2;
  assign io_ctrl_rsp_valid = _zz_io_ctrl_rsp_valid_1;
  assign io_ctrl_rsp_payload_last = _zz_io_ctrl_rsp_payload_last;
  assign io_ctrl_rsp_payload_fragment_source = _zz_io_ctrl_rsp_payload_fragment_source;
  assign io_ctrl_rsp_payload_fragment_opcode = _zz_io_ctrl_rsp_payload_fragment_opcode;
  assign io_ctrl_rsp_payload_fragment_data = _zz_io_ctrl_rsp_payload_fragment_data;
  assign io_ctrl_rsp_payload_fragment_context = _zz_io_ctrl_rsp_payload_fragment_context;
  assign factory_askWrite = (io_ctrl_cmd_valid && (io_ctrl_cmd_payload_fragment_opcode == 1'b1));
  assign factory_askRead = (io_ctrl_cmd_valid && (io_ctrl_cmd_payload_fragment_opcode == 1'b0));
  assign io_ctrl_cmd_fire = (io_ctrl_cmd_valid && io_ctrl_cmd_ready);
  assign factory_doWrite = (io_ctrl_cmd_fire && (io_ctrl_cmd_payload_fragment_opcode == 1'b1));
  assign io_ctrl_cmd_fire_1 = (io_ctrl_cmd_valid && io_ctrl_cmd_ready);
  assign factory_doRead = (io_ctrl_cmd_fire_1 && (io_ctrl_cmd_payload_fragment_opcode == 1'b0));
  assign factory_rsp_valid = io_ctrl_cmd_valid;
  assign io_ctrl_cmd_ready = factory_rsp_ready;
  assign factory_rsp_payload_last = 1'b1;
  assign factory_rsp_payload_fragment_opcode = 1'b0;
  always @(*) begin
    factory_rsp_payload_fragment_data = 32'h0;
    case(io_ctrl_cmd_payload_fragment_address)
      12'h0 : begin
        factory_rsp_payload_fragment_data[31 : 31] = (ctrl_io_rsp_queueWithOccupancy_io_pop_valid ^ 1'b1);
        factory_rsp_payload_fragment_data[7 : 0] = ctrl_io_rsp_queueWithOccupancy_io_pop_payload_data;
      end
      12'h004 : begin
        factory_rsp_payload_fragment_data[8 : 0] = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability;
        factory_rsp_payload_fragment_data[24 : 16] = ctrl_io_rsp_queueWithOccupancy_io_occupancy;
      end
      12'h00c : begin
        factory_rsp_payload_fragment_data[16 : 16] = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_valid;
        factory_rsp_payload_fragment_data[0 : 0] = mapping_interruptCtrl_cmdIntEnable;
        factory_rsp_payload_fragment_data[1 : 1] = mapping_interruptCtrl_rspIntEnable;
        factory_rsp_payload_fragment_data[8 : 8] = mapping_interruptCtrl_cmdInt;
        factory_rsp_payload_fragment_data[9 : 9] = mapping_interruptCtrl_rspInt;
      end
      default : begin
      end
    endcase
  end

  assign factory_rsp_payload_fragment_context = io_ctrl_cmd_payload_fragment_context;
  assign factory_rsp_payload_fragment_source = io_ctrl_cmd_payload_fragment_source;
  always @(*) begin
    _zz_mapping_cmdLogic_streamUnbuffered_valid = 1'b0;
    case(io_ctrl_cmd_payload_fragment_address)
      12'h0 : begin
        if(factory_doWrite) begin
          _zz_mapping_cmdLogic_streamUnbuffered_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign mapping_cmdLogic_streamUnbuffered_valid = _zz_mapping_cmdLogic_streamUnbuffered_valid;
  assign mapping_cmdLogic_streamUnbuffered_ready = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready;
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_ready = (! mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid);
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_valid = (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid || mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid);
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_kind = (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid ? mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_kind : mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_kind);
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_read = (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid ? mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_read : mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_read);
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_write = (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid ? mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_write : mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_write);
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_data = (mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid ? mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_data : mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_data);
  always @(*) begin
    mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_ready = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_ready;
    if(when_Stream_l342_1) begin
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l342_1 = (! mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_valid);
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_valid = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rValid;
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_kind = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_kind;
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_read = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_read;
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_write = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_write;
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_payload_data = mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_data;
  assign mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_m2sPipe_ready = ctrl_io_cmd_ready;
  always @(*) begin
    ctrl_io_rsp_queueWithOccupancy_io_pop_ready = 1'b0;
    case(io_ctrl_cmd_payload_fragment_address)
      12'h0 : begin
        if(factory_doRead) begin
          ctrl_io_rsp_queueWithOccupancy_io_pop_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign mapping_interruptCtrl_cmdInt = (mapping_interruptCtrl_cmdIntEnable && (! mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid));
  assign mapping_interruptCtrl_rspInt = (mapping_interruptCtrl_rspIntEnable && ctrl_io_rsp_queueWithOccupancy_io_pop_valid);
  assign mapping_interruptCtrl_interrupt = (mapping_interruptCtrl_rspInt || mapping_interruptCtrl_cmdInt);
  assign io_spi_sclk_write = ctrl_io_spi_sclk_write;
  assign io_spi_data_0_writeEnable = ctrl_io_spi_data_0_writeEnable;
  assign io_spi_data_0_write = ctrl_io_spi_data_0_write;
  assign io_spi_data_1_writeEnable = ctrl_io_spi_data_1_writeEnable;
  assign io_spi_data_1_write = ctrl_io_spi_data_1_write;
  assign io_spi_data_2_writeEnable = ctrl_io_spi_data_2_writeEnable;
  assign io_spi_data_2_write = ctrl_io_spi_data_2_write;
  assign io_spi_data_3_writeEnable = ctrl_io_spi_data_3_writeEnable;
  assign io_spi_data_3_write = ctrl_io_spi_data_3_write;
  assign io_spi_ss = ctrl_io_spi_ss;
  assign io_interrupt = mapping_interruptCtrl_interrupt;
  assign mapping_cmdLogic_streamUnbuffered_payload_data = io_ctrl_cmd_payload_fragment_data[7 : 0];
  assign mapping_cmdLogic_streamUnbuffered_payload_write = io_ctrl_cmd_payload_fragment_data[8];
  assign mapping_cmdLogic_streamUnbuffered_payload_read = io_ctrl_cmd_payload_fragment_data[9];
  assign mapping_cmdLogic_streamUnbuffered_payload_kind = io_ctrl_cmd_payload_fragment_data[11];
  assign _zz_io_config_kind_cpol_1 = io_ctrl_cmd_payload_fragment_data[1 : 0];
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      _zz_io_ctrl_rsp_valid_2 <= 1'b0;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid <= 1'b0;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rValid <= 1'b0;
      mapping_interruptCtrl_cmdIntEnable <= 1'b0;
      mapping_interruptCtrl_rspIntEnable <= 1'b0;
      _zz_io_config_ss_activeHigh <= 1'b0;
    end else begin
      if(_zz_factory_rsp_ready) begin
        _zz_io_ctrl_rsp_valid_2 <= (factory_rsp_valid && _zz_io_ctrl_rsp_valid);
      end
      if(mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid) begin
        mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid <= 1'b1;
      end
      if(mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_ready) begin
        mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rValid <= 1'b0;
      end
      if(mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_ready) begin
        mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rValid <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_valid;
      end
      case(io_ctrl_cmd_payload_fragment_address)
        12'h00c : begin
          if(factory_doWrite) begin
            mapping_interruptCtrl_cmdIntEnable <= io_ctrl_cmd_payload_fragment_data[0];
            mapping_interruptCtrl_rspIntEnable <= io_ctrl_cmd_payload_fragment_data[1];
          end
        end
        12'h030 : begin
          if(factory_doWrite) begin
            _zz_io_config_ss_activeHigh <= io_ctrl_cmd_payload_fragment_data[0 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_factory_rsp_ready) begin
      _zz_io_ctrl_rsp_payload_last <= factory_rsp_payload_last;
      _zz_io_ctrl_rsp_payload_fragment_source <= factory_rsp_payload_fragment_source;
      _zz_io_ctrl_rsp_payload_fragment_opcode <= factory_rsp_payload_fragment_opcode;
      _zz_io_ctrl_rsp_payload_fragment_data <= factory_rsp_payload_fragment_data;
      _zz_io_ctrl_rsp_payload_fragment_context <= factory_rsp_payload_fragment_context;
    end
    if(mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_ready) begin
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_kind <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_kind;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_read <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_read;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_write <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_write;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_rData_data <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_data;
    end
    if(mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_ready) begin
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_kind <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_kind;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_read <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_read;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_write <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_write;
      mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_rData_data <= mapping_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_s2mPipe_payload_data;
    end
    case(io_ctrl_cmd_payload_fragment_address)
      12'h008 : begin
        if(factory_doWrite) begin
          _zz_io_config_kind_cpol <= _zz_io_config_kind_cpol_1[0];
          _zz_io_config_kind_cpha <= _zz_io_config_kind_cpol_1[1];
          _zz_io_config_mod <= io_ctrl_cmd_payload_fragment_data[5 : 4];
        end
      end
      12'h020 : begin
        if(factory_doWrite) begin
          _zz_io_config_sclkToogle <= io_ctrl_cmd_payload_fragment_data[11 : 0];
        end
      end
      12'h024 : begin
        if(factory_doWrite) begin
          _zz_io_config_ss_setup <= io_ctrl_cmd_payload_fragment_data[11 : 0];
        end
      end
      12'h028 : begin
        if(factory_doWrite) begin
          _zz_io_config_ss_hold <= io_ctrl_cmd_payload_fragment_data[11 : 0];
        end
      end
      12'h02c : begin
        if(factory_doWrite) begin
          _zz_io_config_ss_disable <= io_ctrl_cmd_payload_fragment_data[11 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BmbUartCtrl (
  input               io_bus_cmd_valid,
  output              io_bus_cmd_ready,
  input               io_bus_cmd_payload_last,
  input      [0:0]    io_bus_cmd_payload_fragment_source,
  input      [0:0]    io_bus_cmd_payload_fragment_opcode,
  input      [5:0]    io_bus_cmd_payload_fragment_address,
  input      [1:0]    io_bus_cmd_payload_fragment_length,
  input      [31:0]   io_bus_cmd_payload_fragment_data,
  input      [0:0]    io_bus_cmd_payload_fragment_context,
  output              io_bus_rsp_valid,
  input               io_bus_rsp_ready,
  output              io_bus_rsp_payload_last,
  output     [0:0]    io_bus_rsp_payload_fragment_source,
  output     [0:0]    io_bus_rsp_payload_fragment_opcode,
  output     [31:0]   io_bus_rsp_payload_fragment_data,
  output     [0:0]    io_bus_rsp_payload_fragment_context,
  output              io_uart_txd,
  input               io_uart_rxd,
  output              io_interrupt,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;

  reg                 uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready;
  wire                uartCtrl_1_io_write_ready;
  wire                uartCtrl_1_io_read_valid;
  wire       [7:0]    uartCtrl_1_io_read_payload;
  wire                uartCtrl_1_io_uart_txd;
  wire                uartCtrl_1_io_readError;
  wire                uartCtrl_1_io_readBreak;
  wire                bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  wire                bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload;
  wire       [7:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy;
  wire       [7:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_availability;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_push_ready;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  wire       [7:0]    uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
  wire       [7:0]    uartCtrl_1_io_read_queueWithOccupancy_io_availability;
  wire       [0:0]    _zz_bridge_misc_readError;
  wire       [0:0]    _zz_bridge_misc_readOverflowError;
  wire       [0:0]    _zz_bridge_misc_breakDetected;
  wire       [0:0]    _zz_bridge_misc_doBreak;
  wire       [0:0]    _zz_bridge_misc_doBreak_1;
  wire       [7:0]    _zz_busCtrl_rsp_payload_fragment_data;
  wire       [19:0]   _zz_bridge_uartConfigReg_clockDivider;
  wire       [19:0]   _zz_bridge_uartConfigReg_clockDivider_1;
  wire                busCtrl_readHaltTrigger;
  wire                busCtrl_writeHaltTrigger;
  wire                busCtrl_rsp_valid;
  wire                busCtrl_rsp_ready;
  wire                busCtrl_rsp_payload_last;
  wire       [0:0]    busCtrl_rsp_payload_fragment_source;
  wire       [0:0]    busCtrl_rsp_payload_fragment_opcode;
  reg        [31:0]   busCtrl_rsp_payload_fragment_data;
  wire       [0:0]    busCtrl_rsp_payload_fragment_context;
  wire                _zz_io_bus_rsp_valid;
  reg                 _zz_busCtrl_rsp_ready;
  wire                _zz_io_bus_rsp_valid_1;
  reg                 _zz_io_bus_rsp_valid_2;
  reg                 _zz_io_bus_rsp_payload_last;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_source;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_io_bus_rsp_payload_fragment_data;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_context;
  wire                when_Stream_l342;
  wire                busCtrl_askWrite;
  wire                busCtrl_askRead;
  wire                io_bus_cmd_fire;
  wire                busCtrl_doWrite;
  wire                io_bus_cmd_fire_1;
  wire                busCtrl_doRead;
  reg        [2:0]    bridge_uartConfigReg_frame_dataLength;
  reg        [0:0]    bridge_uartConfigReg_frame_stop;
  reg        [1:0]    bridge_uartConfigReg_frame_parity;
  reg        [19:0]   bridge_uartConfigReg_clockDivider;
  reg                 _zz_bridge_write_streamUnbuffered_valid;
  wire                bridge_write_streamUnbuffered_valid;
  wire                bridge_write_streamUnbuffered_ready;
  wire       [7:0]    bridge_write_streamUnbuffered_payload;
  reg                 bridge_read_streamBreaked_valid;
  reg                 bridge_read_streamBreaked_ready;
  wire       [7:0]    bridge_read_streamBreaked_payload;
  reg                 bridge_interruptCtrl_writeIntEnable;
  reg                 bridge_interruptCtrl_readIntEnable;
  wire                bridge_interruptCtrl_readInt;
  wire                bridge_interruptCtrl_writeInt;
  wire                bridge_interruptCtrl_interrupt;
  reg                 bridge_misc_readError;
  reg                 when_BusSlaveFactory_l335;
  wire                when_BusSlaveFactory_l337;
  reg                 bridge_misc_readOverflowError;
  reg                 when_BusSlaveFactory_l335_1;
  wire                when_BusSlaveFactory_l337_1;
  wire                uartCtrl_1_io_read_isStall;
  reg                 bridge_misc_breakDetected;
  reg                 uartCtrl_1_io_readBreak_regNext;
  wire                when_UartCtrl_l155;
  reg                 when_BusSlaveFactory_l335_2;
  wire                when_BusSlaveFactory_l337_2;
  reg                 bridge_misc_doBreak;
  reg                 when_BusSlaveFactory_l366;
  wire                when_BusSlaveFactory_l368;
  reg                 when_BusSlaveFactory_l335_3;
  wire                when_BusSlaveFactory_l337_3;
  wire       [1:0]    _zz_bridge_uartConfigReg_frame_parity;
  wire       [0:0]    _zz_bridge_uartConfigReg_frame_stop;
  wire                when_BmbSlaveFactory_l71;
  `ifndef SYNTHESIS
  reg [23:0] bridge_uartConfigReg_frame_stop_string;
  reg [31:0] bridge_uartConfigReg_frame_parity_string;
  reg [31:0] _zz_bridge_uartConfigReg_frame_parity_string;
  reg [23:0] _zz_bridge_uartConfigReg_frame_stop_string;
  `endif


  assign _zz_bridge_misc_readError = 1'b0;
  assign _zz_bridge_misc_readOverflowError = 1'b0;
  assign _zz_bridge_misc_breakDetected = 1'b0;
  assign _zz_bridge_misc_doBreak = 1'b1;
  assign _zz_bridge_misc_doBreak_1 = 1'b0;
  assign _zz_busCtrl_rsp_payload_fragment_data = (8'h80 - bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy);
  assign _zz_bridge_uartConfigReg_clockDivider_1 = io_bus_cmd_payload_fragment_data[19 : 0];
  assign _zz_bridge_uartConfigReg_clockDivider = _zz_bridge_uartConfigReg_clockDivider_1;
  UartCtrl uartCtrl_1 (
    .io_config_frame_dataLength    (bridge_uartConfigReg_frame_dataLength[2:0]                            ), //i
    .io_config_frame_stop          (bridge_uartConfigReg_frame_stop                                       ), //i
    .io_config_frame_parity        (bridge_uartConfigReg_frame_parity[1:0]                                ), //i
    .io_config_clockDivider        (bridge_uartConfigReg_clockDivider[19:0]                               ), //i
    .io_write_valid                (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid         ), //i
    .io_write_ready                (uartCtrl_1_io_write_ready                                             ), //o
    .io_write_payload              (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload[7:0]  ), //i
    .io_read_valid                 (uartCtrl_1_io_read_valid                                              ), //o
    .io_read_ready                 (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready                   ), //i
    .io_read_payload               (uartCtrl_1_io_read_payload[7:0]                                       ), //o
    .io_uart_txd                   (uartCtrl_1_io_uart_txd                                                ), //o
    .io_uart_rxd                   (io_uart_rxd                                                           ), //i
    .io_readError                  (uartCtrl_1_io_readError                                               ), //o
    .io_writeBreak                 (bridge_misc_doBreak                                                   ), //i
    .io_readBreak                  (uartCtrl_1_io_readBreak                                               ), //o
    .io_systemClk                  (io_systemClk                                                          ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                                            )  //i
  );
  StreamFifo bridge_write_streamUnbuffered_queueWithOccupancy (
    .io_push_valid                 (bridge_write_streamUnbuffered_valid                                    ), //i
    .io_push_ready                 (bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready         ), //o
    .io_push_payload               (bridge_write_streamUnbuffered_payload[7:0]                             ), //i
    .io_pop_valid                  (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid          ), //o
    .io_pop_ready                  (uartCtrl_1_io_write_ready                                              ), //i
    .io_pop_payload                (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload[7:0]   ), //o
    .io_flush                      (1'b0                                                                   ), //i
    .io_occupancy                  (bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy[7:0]     ), //o
    .io_availability               (bridge_write_streamUnbuffered_queueWithOccupancy_io_availability[7:0]  ), //o
    .io_systemClk                  (io_systemClk                                                           ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                                             )  //i
  );
  StreamFifo uartCtrl_1_io_read_queueWithOccupancy (
    .io_push_valid                 (uartCtrl_1_io_read_valid                                    ), //i
    .io_push_ready                 (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready         ), //o
    .io_push_payload               (uartCtrl_1_io_read_payload[7:0]                             ), //i
    .io_pop_valid                  (uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid          ), //o
    .io_pop_ready                  (uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready          ), //i
    .io_pop_payload                (uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload[7:0]   ), //o
    .io_flush                      (1'b0                                                        ), //i
    .io_occupancy                  (uartCtrl_1_io_read_queueWithOccupancy_io_occupancy[7:0]     ), //o
    .io_availability               (uartCtrl_1_io_read_queueWithOccupancy_io_availability[7:0]  ), //o
    .io_systemClk                  (io_systemClk                                                ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                                  )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(bridge_uartConfigReg_frame_stop)
      UartStopType_ONE : bridge_uartConfigReg_frame_stop_string = "ONE";
      UartStopType_TWO : bridge_uartConfigReg_frame_stop_string = "TWO";
      default : bridge_uartConfigReg_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(bridge_uartConfigReg_frame_parity)
      UartParityType_NONE : bridge_uartConfigReg_frame_parity_string = "NONE";
      UartParityType_EVEN : bridge_uartConfigReg_frame_parity_string = "EVEN";
      UartParityType_ODD : bridge_uartConfigReg_frame_parity_string = "ODD ";
      default : bridge_uartConfigReg_frame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_bridge_uartConfigReg_frame_parity)
      UartParityType_NONE : _zz_bridge_uartConfigReg_frame_parity_string = "NONE";
      UartParityType_EVEN : _zz_bridge_uartConfigReg_frame_parity_string = "EVEN";
      UartParityType_ODD : _zz_bridge_uartConfigReg_frame_parity_string = "ODD ";
      default : _zz_bridge_uartConfigReg_frame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_bridge_uartConfigReg_frame_stop)
      UartStopType_ONE : _zz_bridge_uartConfigReg_frame_stop_string = "ONE";
      UartStopType_TWO : _zz_bridge_uartConfigReg_frame_stop_string = "TWO";
      default : _zz_bridge_uartConfigReg_frame_stop_string = "???";
    endcase
  end
  `endif

  assign io_uart_txd = uartCtrl_1_io_uart_txd;
  assign busCtrl_readHaltTrigger = 1'b0;
  assign busCtrl_writeHaltTrigger = 1'b0;
  assign _zz_io_bus_rsp_valid = (! (busCtrl_readHaltTrigger || busCtrl_writeHaltTrigger));
  assign busCtrl_rsp_ready = (_zz_busCtrl_rsp_ready && _zz_io_bus_rsp_valid);
  always @(*) begin
    _zz_busCtrl_rsp_ready = io_bus_rsp_ready;
    if(when_Stream_l342) begin
      _zz_busCtrl_rsp_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! _zz_io_bus_rsp_valid_1);
  assign _zz_io_bus_rsp_valid_1 = _zz_io_bus_rsp_valid_2;
  assign io_bus_rsp_valid = _zz_io_bus_rsp_valid_1;
  assign io_bus_rsp_payload_last = _zz_io_bus_rsp_payload_last;
  assign io_bus_rsp_payload_fragment_source = _zz_io_bus_rsp_payload_fragment_source;
  assign io_bus_rsp_payload_fragment_opcode = _zz_io_bus_rsp_payload_fragment_opcode;
  assign io_bus_rsp_payload_fragment_data = _zz_io_bus_rsp_payload_fragment_data;
  assign io_bus_rsp_payload_fragment_context = _zz_io_bus_rsp_payload_fragment_context;
  assign busCtrl_askWrite = (io_bus_cmd_valid && (io_bus_cmd_payload_fragment_opcode == 1'b1));
  assign busCtrl_askRead = (io_bus_cmd_valid && (io_bus_cmd_payload_fragment_opcode == 1'b0));
  assign io_bus_cmd_fire = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign busCtrl_doWrite = (io_bus_cmd_fire && (io_bus_cmd_payload_fragment_opcode == 1'b1));
  assign io_bus_cmd_fire_1 = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign busCtrl_doRead = (io_bus_cmd_fire_1 && (io_bus_cmd_payload_fragment_opcode == 1'b0));
  assign busCtrl_rsp_valid = io_bus_cmd_valid;
  assign io_bus_cmd_ready = busCtrl_rsp_ready;
  assign busCtrl_rsp_payload_last = 1'b1;
  assign busCtrl_rsp_payload_fragment_opcode = 1'b0;
  always @(*) begin
    busCtrl_rsp_payload_fragment_data = 32'h0;
    case(io_bus_cmd_payload_fragment_address)
      6'h0 : begin
        busCtrl_rsp_payload_fragment_data[16 : 16] = (bridge_read_streamBreaked_valid ^ 1'b0);
        busCtrl_rsp_payload_fragment_data[7 : 0] = bridge_read_streamBreaked_payload;
      end
      6'h04 : begin
        busCtrl_rsp_payload_fragment_data[23 : 16] = _zz_busCtrl_rsp_payload_fragment_data;
        busCtrl_rsp_payload_fragment_data[15 : 15] = bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
        busCtrl_rsp_payload_fragment_data[31 : 24] = uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
        busCtrl_rsp_payload_fragment_data[0 : 0] = bridge_interruptCtrl_writeIntEnable;
        busCtrl_rsp_payload_fragment_data[1 : 1] = bridge_interruptCtrl_readIntEnable;
        busCtrl_rsp_payload_fragment_data[8 : 8] = bridge_interruptCtrl_writeInt;
        busCtrl_rsp_payload_fragment_data[9 : 9] = bridge_interruptCtrl_readInt;
      end
      6'h10 : begin
        busCtrl_rsp_payload_fragment_data[0 : 0] = bridge_misc_readError;
        busCtrl_rsp_payload_fragment_data[1 : 1] = bridge_misc_readOverflowError;
        busCtrl_rsp_payload_fragment_data[8 : 8] = uartCtrl_1_io_readBreak;
        busCtrl_rsp_payload_fragment_data[9 : 9] = bridge_misc_breakDetected;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_rsp_payload_fragment_context = io_bus_cmd_payload_fragment_context;
  assign busCtrl_rsp_payload_fragment_source = io_bus_cmd_payload_fragment_source;
  always @(*) begin
    _zz_bridge_write_streamUnbuffered_valid = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h0 : begin
        if(busCtrl_doWrite) begin
          _zz_bridge_write_streamUnbuffered_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_write_streamUnbuffered_valid = _zz_bridge_write_streamUnbuffered_valid;
  assign bridge_write_streamUnbuffered_payload = io_bus_cmd_payload_fragment_data[7 : 0];
  assign bridge_write_streamUnbuffered_ready = bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  always @(*) begin
    bridge_read_streamBreaked_valid = uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
    if(uartCtrl_1_io_readBreak) begin
      bridge_read_streamBreaked_valid = 1'b0;
    end
  end

  always @(*) begin
    uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready = bridge_read_streamBreaked_ready;
    if(uartCtrl_1_io_readBreak) begin
      uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready = 1'b1;
    end
  end

  assign bridge_read_streamBreaked_payload = uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  always @(*) begin
    bridge_read_streamBreaked_ready = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h0 : begin
        if(busCtrl_doRead) begin
          bridge_read_streamBreaked_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_readInt = (bridge_interruptCtrl_readIntEnable && bridge_read_streamBreaked_valid);
  assign bridge_interruptCtrl_writeInt = (bridge_interruptCtrl_writeIntEnable && (! bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid));
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_readInt || bridge_interruptCtrl_writeInt);
  always @(*) begin
    when_BusSlaveFactory_l335 = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l335 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l337 = io_bus_cmd_payload_fragment_data[0];
  always @(*) begin
    when_BusSlaveFactory_l335_1 = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l335_1 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l337_1 = io_bus_cmd_payload_fragment_data[1];
  assign uartCtrl_1_io_read_isStall = (uartCtrl_1_io_read_valid && (! uartCtrl_1_io_read_queueWithOccupancy_io_push_ready));
  assign when_UartCtrl_l155 = (uartCtrl_1_io_readBreak && (! uartCtrl_1_io_readBreak_regNext));
  always @(*) begin
    when_BusSlaveFactory_l335_2 = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l335_2 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l337_2 = io_bus_cmd_payload_fragment_data[9];
  always @(*) begin
    when_BusSlaveFactory_l366 = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l366 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l368 = io_bus_cmd_payload_fragment_data[10];
  always @(*) begin
    when_BusSlaveFactory_l335_3 = 1'b0;
    case(io_bus_cmd_payload_fragment_address)
      6'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l335_3 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l337_3 = io_bus_cmd_payload_fragment_data[11];
  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign _zz_bridge_uartConfigReg_frame_parity = io_bus_cmd_payload_fragment_data[9 : 8];
  assign _zz_bridge_uartConfigReg_frame_stop = io_bus_cmd_payload_fragment_data[16 : 16];
  assign when_BmbSlaveFactory_l71 = ((io_bus_cmd_payload_fragment_address & (~ 6'h03)) == 6'h08);
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      _zz_io_bus_rsp_valid_2 <= 1'b0;
      bridge_uartConfigReg_clockDivider <= 20'h0;
      bridge_uartConfigReg_clockDivider <= 20'h00047;
      bridge_uartConfigReg_frame_dataLength <= 3'b111;
      bridge_uartConfigReg_frame_parity <= UartParityType_NONE;
      bridge_uartConfigReg_frame_stop <= UartStopType_ONE;
      bridge_interruptCtrl_writeIntEnable <= 1'b0;
      bridge_interruptCtrl_readIntEnable <= 1'b0;
      bridge_misc_readError <= 1'b0;
      bridge_misc_readOverflowError <= 1'b0;
      bridge_misc_breakDetected <= 1'b0;
      bridge_misc_doBreak <= 1'b0;
    end else begin
      if(_zz_busCtrl_rsp_ready) begin
        _zz_io_bus_rsp_valid_2 <= (busCtrl_rsp_valid && _zz_io_bus_rsp_valid);
      end
      if(when_BusSlaveFactory_l335) begin
        if(when_BusSlaveFactory_l337) begin
          bridge_misc_readError <= _zz_bridge_misc_readError[0];
        end
      end
      if(uartCtrl_1_io_readError) begin
        bridge_misc_readError <= 1'b1;
      end
      if(when_BusSlaveFactory_l335_1) begin
        if(when_BusSlaveFactory_l337_1) begin
          bridge_misc_readOverflowError <= _zz_bridge_misc_readOverflowError[0];
        end
      end
      if(uartCtrl_1_io_read_isStall) begin
        bridge_misc_readOverflowError <= 1'b1;
      end
      if(when_UartCtrl_l155) begin
        bridge_misc_breakDetected <= 1'b1;
      end
      if(when_BusSlaveFactory_l335_2) begin
        if(when_BusSlaveFactory_l337_2) begin
          bridge_misc_breakDetected <= _zz_bridge_misc_breakDetected[0];
        end
      end
      if(when_BusSlaveFactory_l366) begin
        if(when_BusSlaveFactory_l368) begin
          bridge_misc_doBreak <= _zz_bridge_misc_doBreak[0];
        end
      end
      if(when_BusSlaveFactory_l335_3) begin
        if(when_BusSlaveFactory_l337_3) begin
          bridge_misc_doBreak <= _zz_bridge_misc_doBreak_1[0];
        end
      end
      case(io_bus_cmd_payload_fragment_address)
        6'h0c : begin
          if(busCtrl_doWrite) begin
            bridge_uartConfigReg_frame_dataLength <= io_bus_cmd_payload_fragment_data[2 : 0];
            bridge_uartConfigReg_frame_parity <= _zz_bridge_uartConfigReg_frame_parity;
            bridge_uartConfigReg_frame_stop <= _zz_bridge_uartConfigReg_frame_stop;
          end
        end
        6'h04 : begin
          if(busCtrl_doWrite) begin
            bridge_interruptCtrl_writeIntEnable <= io_bus_cmd_payload_fragment_data[0];
            bridge_interruptCtrl_readIntEnable <= io_bus_cmd_payload_fragment_data[1];
          end
        end
        default : begin
        end
      endcase
      if(when_BmbSlaveFactory_l71) begin
        if(busCtrl_doWrite) begin
          bridge_uartConfigReg_clockDivider[19 : 0] <= _zz_bridge_uartConfigReg_clockDivider;
        end
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_busCtrl_rsp_ready) begin
      _zz_io_bus_rsp_payload_last <= busCtrl_rsp_payload_last;
      _zz_io_bus_rsp_payload_fragment_source <= busCtrl_rsp_payload_fragment_source;
      _zz_io_bus_rsp_payload_fragment_opcode <= busCtrl_rsp_payload_fragment_opcode;
      _zz_io_bus_rsp_payload_fragment_data <= busCtrl_rsp_payload_fragment_data;
      _zz_io_bus_rsp_payload_fragment_context <= busCtrl_rsp_payload_fragment_context;
    end
    uartCtrl_1_io_readBreak_regNext <= uartCtrl_1_io_readBreak;
  end


endmodule

module BmbClint (
  input               io_bus_cmd_valid,
  output              io_bus_cmd_ready,
  input               io_bus_cmd_payload_last,
  input      [0:0]    io_bus_cmd_payload_fragment_source,
  input      [0:0]    io_bus_cmd_payload_fragment_opcode,
  input      [15:0]   io_bus_cmd_payload_fragment_address,
  input      [1:0]    io_bus_cmd_payload_fragment_length,
  input      [31:0]   io_bus_cmd_payload_fragment_data,
  input      [0:0]    io_bus_cmd_payload_fragment_context,
  output              io_bus_rsp_valid,
  input               io_bus_rsp_ready,
  output              io_bus_rsp_payload_last,
  output     [0:0]    io_bus_rsp_payload_fragment_source,
  output     [0:0]    io_bus_rsp_payload_fragment_opcode,
  output     [31:0]   io_bus_rsp_payload_fragment_data,
  output     [0:0]    io_bus_rsp_payload_fragment_context,
  output     [0:0]    io_timerInterrupt,
  output     [0:0]    io_softwareInterrupt,
  output     [63:0]   io_time,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire       [31:0]   _zz_logic_harts_0_cmp;
  wire       [31:0]   _zz_logic_harts_0_cmp_1;
  wire       [31:0]   _zz_logic_harts_0_cmp_2;
  wire       [31:0]   _zz_logic_harts_0_cmp_3;
  wire                factory_readHaltTrigger;
  wire                factory_writeHaltTrigger;
  wire                factory_rsp_valid;
  wire                factory_rsp_ready;
  wire                factory_rsp_payload_last;
  wire       [0:0]    factory_rsp_payload_fragment_source;
  wire       [0:0]    factory_rsp_payload_fragment_opcode;
  reg        [31:0]   factory_rsp_payload_fragment_data;
  wire       [0:0]    factory_rsp_payload_fragment_context;
  wire                _zz_io_bus_rsp_valid;
  reg                 _zz_factory_rsp_ready;
  wire                _zz_io_bus_rsp_valid_1;
  reg                 _zz_io_bus_rsp_valid_2;
  reg                 _zz_io_bus_rsp_payload_last;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_source;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_io_bus_rsp_payload_fragment_data;
  reg        [0:0]    _zz_io_bus_rsp_payload_fragment_context;
  wire                when_Stream_l342;
  wire                factory_askWrite;
  wire                factory_askRead;
  wire                io_bus_cmd_fire;
  wire                factory_doWrite;
  wire                io_bus_cmd_fire_1;
  wire                factory_doRead;
  reg        [63:0]   logic_time;
  reg        [63:0]   logic_harts_0_cmp;
  reg                 logic_harts_0_timerInterrupt;
  reg                 logic_harts_0_softwareInterrupt;
  wire       [63:0]   _zz_factory_rsp_payload_fragment_data;
  wire                when_BmbSlaveFactory_l71;
  wire                when_BmbSlaveFactory_l71_1;
  wire                when_BmbSlaveFactory_l71_2;
  wire                when_BmbSlaveFactory_l71_3;

  assign _zz_logic_harts_0_cmp_1 = io_bus_cmd_payload_fragment_data[31 : 0];
  assign _zz_logic_harts_0_cmp = _zz_logic_harts_0_cmp_1;
  assign _zz_logic_harts_0_cmp_3 = io_bus_cmd_payload_fragment_data[31 : 0];
  assign _zz_logic_harts_0_cmp_2 = _zz_logic_harts_0_cmp_3;
  assign factory_readHaltTrigger = 1'b0;
  assign factory_writeHaltTrigger = 1'b0;
  assign _zz_io_bus_rsp_valid = (! (factory_readHaltTrigger || factory_writeHaltTrigger));
  assign factory_rsp_ready = (_zz_factory_rsp_ready && _zz_io_bus_rsp_valid);
  always @(*) begin
    _zz_factory_rsp_ready = io_bus_rsp_ready;
    if(when_Stream_l342) begin
      _zz_factory_rsp_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! _zz_io_bus_rsp_valid_1);
  assign _zz_io_bus_rsp_valid_1 = _zz_io_bus_rsp_valid_2;
  assign io_bus_rsp_valid = _zz_io_bus_rsp_valid_1;
  assign io_bus_rsp_payload_last = _zz_io_bus_rsp_payload_last;
  assign io_bus_rsp_payload_fragment_source = _zz_io_bus_rsp_payload_fragment_source;
  assign io_bus_rsp_payload_fragment_opcode = _zz_io_bus_rsp_payload_fragment_opcode;
  assign io_bus_rsp_payload_fragment_data = _zz_io_bus_rsp_payload_fragment_data;
  assign io_bus_rsp_payload_fragment_context = _zz_io_bus_rsp_payload_fragment_context;
  assign factory_askWrite = (io_bus_cmd_valid && (io_bus_cmd_payload_fragment_opcode == 1'b1));
  assign factory_askRead = (io_bus_cmd_valid && (io_bus_cmd_payload_fragment_opcode == 1'b0));
  assign io_bus_cmd_fire = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign factory_doWrite = (io_bus_cmd_fire && (io_bus_cmd_payload_fragment_opcode == 1'b1));
  assign io_bus_cmd_fire_1 = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign factory_doRead = (io_bus_cmd_fire_1 && (io_bus_cmd_payload_fragment_opcode == 1'b0));
  assign factory_rsp_valid = io_bus_cmd_valid;
  assign io_bus_cmd_ready = factory_rsp_ready;
  assign factory_rsp_payload_last = 1'b1;
  assign factory_rsp_payload_fragment_opcode = 1'b0;
  always @(*) begin
    factory_rsp_payload_fragment_data = 32'h0;
    case(io_bus_cmd_payload_fragment_address)
      16'h0 : begin
        factory_rsp_payload_fragment_data[0 : 0] = logic_harts_0_softwareInterrupt;
      end
      default : begin
      end
    endcase
    if(when_BmbSlaveFactory_l71) begin
      factory_rsp_payload_fragment_data[31 : 0] = _zz_factory_rsp_payload_fragment_data[31 : 0];
    end
    if(when_BmbSlaveFactory_l71_1) begin
      factory_rsp_payload_fragment_data[31 : 0] = _zz_factory_rsp_payload_fragment_data[63 : 32];
    end
  end

  assign factory_rsp_payload_fragment_context = io_bus_cmd_payload_fragment_context;
  assign factory_rsp_payload_fragment_source = io_bus_cmd_payload_fragment_source;
  assign _zz_factory_rsp_payload_fragment_data = logic_time;
  assign io_timerInterrupt[0] = logic_harts_0_timerInterrupt;
  assign io_softwareInterrupt[0] = logic_harts_0_softwareInterrupt;
  assign io_time = logic_time;
  assign when_BmbSlaveFactory_l71 = ((io_bus_cmd_payload_fragment_address & (~ 16'h0003)) == 16'hbff8);
  assign when_BmbSlaveFactory_l71_1 = ((io_bus_cmd_payload_fragment_address & (~ 16'h0003)) == 16'hbffc);
  assign when_BmbSlaveFactory_l71_2 = ((io_bus_cmd_payload_fragment_address & (~ 16'h0003)) == 16'h4000);
  assign when_BmbSlaveFactory_l71_3 = ((io_bus_cmd_payload_fragment_address & (~ 16'h0003)) == 16'h4004);
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      _zz_io_bus_rsp_valid_2 <= 1'b0;
      logic_time <= 64'h0;
      logic_harts_0_softwareInterrupt <= 1'b0;
    end else begin
      if(_zz_factory_rsp_ready) begin
        _zz_io_bus_rsp_valid_2 <= (factory_rsp_valid && _zz_io_bus_rsp_valid);
      end
      logic_time <= (logic_time + 64'h0000000000000001);
      case(io_bus_cmd_payload_fragment_address)
        16'h0 : begin
          if(factory_doWrite) begin
            logic_harts_0_softwareInterrupt <= io_bus_cmd_payload_fragment_data[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_factory_rsp_ready) begin
      _zz_io_bus_rsp_payload_last <= factory_rsp_payload_last;
      _zz_io_bus_rsp_payload_fragment_source <= factory_rsp_payload_fragment_source;
      _zz_io_bus_rsp_payload_fragment_opcode <= factory_rsp_payload_fragment_opcode;
      _zz_io_bus_rsp_payload_fragment_data <= factory_rsp_payload_fragment_data;
      _zz_io_bus_rsp_payload_fragment_context <= factory_rsp_payload_fragment_context;
    end
    logic_harts_0_timerInterrupt <= (logic_harts_0_cmp <= logic_time);
    if(when_BmbSlaveFactory_l71_2) begin
      if(factory_doWrite) begin
        logic_harts_0_cmp[31 : 0] <= _zz_logic_harts_0_cmp;
      end
    end
    if(when_BmbSlaveFactory_l71_3) begin
      if(factory_doWrite) begin
        logic_harts_0_cmp[63 : 32] <= _zz_logic_harts_0_cmp_2;
      end
    end
  end


endmodule

module BmbDecoder_3 (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_source,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [23:0]   io_input_cmd_payload_fragment_address,
  input      [1:0]    io_input_cmd_payload_fragment_length,
  input      [31:0]   io_input_cmd_payload_fragment_data,
  input      [3:0]    io_input_cmd_payload_fragment_mask,
  input      [0:0]    io_input_cmd_payload_fragment_context,
  output reg          io_input_rsp_valid,
  input               io_input_rsp_ready,
  output reg          io_input_rsp_payload_last,
  output reg [0:0]    io_input_rsp_payload_fragment_source,
  output reg [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [31:0]   io_input_rsp_payload_fragment_data,
  output reg [0:0]    io_input_rsp_payload_fragment_context,
  output reg          io_outputs_0_cmd_valid,
  input               io_outputs_0_cmd_ready,
  output              io_outputs_0_cmd_payload_last,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_opcode,
  output     [23:0]   io_outputs_0_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_0_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_0_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_0_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_context,
  input               io_outputs_0_rsp_valid,
  output              io_outputs_0_rsp_ready,
  input               io_outputs_0_rsp_payload_last,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_0_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_context,
  output reg          io_outputs_1_cmd_valid,
  input               io_outputs_1_cmd_ready,
  output              io_outputs_1_cmd_payload_last,
  output     [0:0]    io_outputs_1_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_1_cmd_payload_fragment_opcode,
  output     [23:0]   io_outputs_1_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_1_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_1_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_1_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_1_cmd_payload_fragment_context,
  input               io_outputs_1_rsp_valid,
  output              io_outputs_1_rsp_ready,
  input               io_outputs_1_rsp_payload_last,
  input      [0:0]    io_outputs_1_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_1_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_1_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_1_rsp_payload_fragment_context,
  output reg          io_outputs_2_cmd_valid,
  input               io_outputs_2_cmd_ready,
  output              io_outputs_2_cmd_payload_last,
  output     [0:0]    io_outputs_2_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_2_cmd_payload_fragment_opcode,
  output     [23:0]   io_outputs_2_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_2_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_2_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_2_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_2_cmd_payload_fragment_context,
  input               io_outputs_2_rsp_valid,
  output              io_outputs_2_rsp_ready,
  input               io_outputs_2_rsp_payload_last,
  input      [0:0]    io_outputs_2_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_2_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_2_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_2_rsp_payload_fragment_context,
  output reg          io_outputs_3_cmd_valid,
  input               io_outputs_3_cmd_ready,
  output              io_outputs_3_cmd_payload_last,
  output     [0:0]    io_outputs_3_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_3_cmd_payload_fragment_opcode,
  output     [23:0]   io_outputs_3_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_3_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_3_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_3_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_3_cmd_payload_fragment_context,
  input               io_outputs_3_rsp_valid,
  output              io_outputs_3_rsp_ready,
  input               io_outputs_3_rsp_payload_last,
  input      [0:0]    io_outputs_3_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_3_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_3_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_3_rsp_payload_fragment_context,
  output reg          io_outputs_4_cmd_valid,
  input               io_outputs_4_cmd_ready,
  output              io_outputs_4_cmd_payload_last,
  output     [0:0]    io_outputs_4_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_4_cmd_payload_fragment_opcode,
  output     [23:0]   io_outputs_4_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_4_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_4_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_4_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_4_cmd_payload_fragment_context,
  input               io_outputs_4_rsp_valid,
  output              io_outputs_4_rsp_ready,
  input               io_outputs_4_rsp_payload_last,
  input      [0:0]    io_outputs_4_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_4_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_4_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_4_rsp_payload_fragment_context,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire       [3:0]    _zz_logic_rspPendingCounter;
  wire       [3:0]    _zz_logic_rspPendingCounter_1;
  wire       [0:0]    _zz_logic_rspPendingCounter_2;
  wire       [3:0]    _zz_logic_rspPendingCounter_3;
  wire       [0:0]    _zz_logic_rspPendingCounter_4;
  reg                 _zz_io_input_rsp_payload_last_3;
  reg        [0:0]    _zz_io_input_rsp_payload_fragment_source;
  reg        [0:0]    _zz_io_input_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_io_input_rsp_payload_fragment_data;
  reg        [0:0]    _zz_io_input_rsp_payload_fragment_context;
  wire                io_input_cmd_input_valid;
  reg                 io_input_cmd_input_ready;
  wire                io_input_cmd_input_payload_last;
  wire       [0:0]    io_input_cmd_input_payload_fragment_source;
  wire       [0:0]    io_input_cmd_input_payload_fragment_opcode;
  wire       [23:0]   io_input_cmd_input_payload_fragment_address;
  wire       [1:0]    io_input_cmd_input_payload_fragment_length;
  wire       [31:0]   io_input_cmd_input_payload_fragment_data;
  wire       [3:0]    io_input_cmd_input_payload_fragment_mask;
  wire       [0:0]    io_input_cmd_input_payload_fragment_context;
  reg                 io_input_cmd_rValid;
  wire                io_input_cmd_input_fire;
  reg                 io_input_cmd_rData_last;
  reg        [0:0]    io_input_cmd_rData_fragment_source;
  reg        [0:0]    io_input_cmd_rData_fragment_opcode;
  reg        [23:0]   io_input_cmd_rData_fragment_address;
  reg        [1:0]    io_input_cmd_rData_fragment_length;
  reg        [31:0]   io_input_cmd_rData_fragment_data;
  reg        [3:0]    io_input_cmd_rData_fragment_mask;
  reg        [0:0]    io_input_cmd_rData_fragment_context;
  wire                logic_hitsS0_0;
  wire                logic_hitsS0_1;
  wire                logic_hitsS0_2;
  wire                logic_hitsS0_3;
  wire                logic_hitsS0_4;
  wire                logic_noHitS0;
  wire                io_input_cmd_fire;
  reg                 logic_hitsS1_0;
  reg                 logic_hitsS1_1;
  reg                 logic_hitsS1_2;
  reg                 logic_hitsS1_3;
  reg                 logic_hitsS1_4;
  wire                io_input_cmd_fire_1;
  reg                 logic_noHitS1;
  wire                _zz_io_outputs_0_cmd_payload_last;
  wire                _zz_io_outputs_1_cmd_payload_last;
  wire                _zz_io_outputs_2_cmd_payload_last;
  wire                _zz_io_outputs_3_cmd_payload_last;
  wire                _zz_io_outputs_4_cmd_payload_last;
  reg        [3:0]    logic_rspPendingCounter;
  wire                io_input_cmd_input_fire_1;
  wire                io_input_rsp_fire;
  wire                logic_cmdWait;
  wire                when_BmbDecoder_l56;
  reg                 logic_rspHits_0;
  reg                 logic_rspHits_1;
  reg                 logic_rspHits_2;
  reg                 logic_rspHits_3;
  reg                 logic_rspHits_4;
  wire                logic_rspPending;
  wire                logic_rspNoHitValid;
  reg                 logic_rspNoHit_doIt;
  wire                io_input_rsp_fire_1;
  wire                when_BmbDecoder_l60;
  wire                io_input_cmd_input_fire_2;
  wire                when_BmbDecoder_l60_1;
  wire                io_input_cmd_input_fire_3;
  reg                 logic_rspNoHit_singleBeatRsp;
  wire                io_input_cmd_input_fire_4;
  reg        [0:0]    logic_rspNoHit_source;
  wire                io_input_cmd_input_fire_5;
  reg        [0:0]    logic_rspNoHit_context;
  wire                io_input_cmd_input_fire_6;
  wire                _zz_io_input_rsp_payload_last;
  wire                _zz_io_input_rsp_payload_last_1;
  wire       [2:0]    _zz_io_input_rsp_payload_last_2;

  assign _zz_logic_rspPendingCounter = (logic_rspPendingCounter + _zz_logic_rspPendingCounter_1);
  assign _zz_logic_rspPendingCounter_2 = (io_input_cmd_input_fire_1 && io_input_cmd_input_payload_last);
  assign _zz_logic_rspPendingCounter_1 = {3'd0, _zz_logic_rspPendingCounter_2};
  assign _zz_logic_rspPendingCounter_4 = (io_input_rsp_fire && io_input_rsp_payload_last);
  assign _zz_logic_rspPendingCounter_3 = {3'd0, _zz_logic_rspPendingCounter_4};
  always @(*) begin
    case(_zz_io_input_rsp_payload_last_2)
      3'b000 : begin
        _zz_io_input_rsp_payload_last_3 = io_outputs_0_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_0_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_0_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_0_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_0_rsp_payload_fragment_context;
      end
      3'b001 : begin
        _zz_io_input_rsp_payload_last_3 = io_outputs_1_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_1_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_1_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_1_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_1_rsp_payload_fragment_context;
      end
      3'b010 : begin
        _zz_io_input_rsp_payload_last_3 = io_outputs_2_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_2_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_2_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_2_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_2_rsp_payload_fragment_context;
      end
      3'b011 : begin
        _zz_io_input_rsp_payload_last_3 = io_outputs_3_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_3_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_3_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_3_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_3_rsp_payload_fragment_context;
      end
      default : begin
        _zz_io_input_rsp_payload_last_3 = io_outputs_4_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_4_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_4_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_4_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_4_rsp_payload_fragment_context;
      end
    endcase
  end

  assign io_input_cmd_input_fire = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  assign io_input_cmd_ready = (! io_input_cmd_rValid);
  assign io_input_cmd_input_valid = io_input_cmd_rValid;
  assign io_input_cmd_input_payload_last = io_input_cmd_rData_last;
  assign io_input_cmd_input_payload_fragment_source = io_input_cmd_rData_fragment_source;
  assign io_input_cmd_input_payload_fragment_opcode = io_input_cmd_rData_fragment_opcode;
  assign io_input_cmd_input_payload_fragment_address = io_input_cmd_rData_fragment_address;
  assign io_input_cmd_input_payload_fragment_length = io_input_cmd_rData_fragment_length;
  assign io_input_cmd_input_payload_fragment_data = io_input_cmd_rData_fragment_data;
  assign io_input_cmd_input_payload_fragment_mask = io_input_cmd_rData_fragment_mask;
  assign io_input_cmd_input_payload_fragment_context = io_input_cmd_rData_fragment_context;
  assign logic_noHitS0 = (! ({logic_hitsS0_4,{logic_hitsS0_3,{logic_hitsS0_2,{logic_hitsS0_1,logic_hitsS0_0}}}} != 5'h0));
  assign io_input_cmd_fire = (io_input_cmd_valid && io_input_cmd_ready);
  assign io_input_cmd_fire_1 = (io_input_cmd_valid && io_input_cmd_ready);
  assign logic_hitsS0_0 = ((io_input_cmd_payload_fragment_address & (~ 24'h3fffff)) == 24'hc00000);
  always @(*) begin
    io_outputs_0_cmd_valid = (io_input_cmd_input_valid && logic_hitsS1_0);
    if(logic_cmdWait) begin
      io_outputs_0_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_0_cmd_payload_last = io_input_cmd_input_payload_last;
  assign io_outputs_0_cmd_payload_last = _zz_io_outputs_0_cmd_payload_last;
  assign io_outputs_0_cmd_payload_fragment_source = io_input_cmd_input_payload_fragment_source;
  assign io_outputs_0_cmd_payload_fragment_opcode = io_input_cmd_input_payload_fragment_opcode;
  assign io_outputs_0_cmd_payload_fragment_address = io_input_cmd_input_payload_fragment_address;
  assign io_outputs_0_cmd_payload_fragment_length = io_input_cmd_input_payload_fragment_length;
  assign io_outputs_0_cmd_payload_fragment_data = io_input_cmd_input_payload_fragment_data;
  assign io_outputs_0_cmd_payload_fragment_mask = io_input_cmd_input_payload_fragment_mask;
  assign io_outputs_0_cmd_payload_fragment_context = io_input_cmd_input_payload_fragment_context;
  assign logic_hitsS0_1 = ((io_input_cmd_payload_fragment_address & (~ 24'h00ffff)) == 24'hb00000);
  always @(*) begin
    io_outputs_1_cmd_valid = (io_input_cmd_input_valid && logic_hitsS1_1);
    if(logic_cmdWait) begin
      io_outputs_1_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_1_cmd_payload_last = io_input_cmd_input_payload_last;
  assign io_outputs_1_cmd_payload_last = _zz_io_outputs_1_cmd_payload_last;
  assign io_outputs_1_cmd_payload_fragment_source = io_input_cmd_input_payload_fragment_source;
  assign io_outputs_1_cmd_payload_fragment_opcode = io_input_cmd_input_payload_fragment_opcode;
  assign io_outputs_1_cmd_payload_fragment_address = io_input_cmd_input_payload_fragment_address;
  assign io_outputs_1_cmd_payload_fragment_length = io_input_cmd_input_payload_fragment_length;
  assign io_outputs_1_cmd_payload_fragment_data = io_input_cmd_input_payload_fragment_data;
  assign io_outputs_1_cmd_payload_fragment_mask = io_input_cmd_input_payload_fragment_mask;
  assign io_outputs_1_cmd_payload_fragment_context = io_input_cmd_input_payload_fragment_context;
  assign logic_hitsS0_2 = ((io_input_cmd_payload_fragment_address & (~ 24'h00003f)) == 24'h010000);
  always @(*) begin
    io_outputs_2_cmd_valid = (io_input_cmd_input_valid && logic_hitsS1_2);
    if(logic_cmdWait) begin
      io_outputs_2_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_2_cmd_payload_last = io_input_cmd_input_payload_last;
  assign io_outputs_2_cmd_payload_last = _zz_io_outputs_2_cmd_payload_last;
  assign io_outputs_2_cmd_payload_fragment_source = io_input_cmd_input_payload_fragment_source;
  assign io_outputs_2_cmd_payload_fragment_opcode = io_input_cmd_input_payload_fragment_opcode;
  assign io_outputs_2_cmd_payload_fragment_address = io_input_cmd_input_payload_fragment_address;
  assign io_outputs_2_cmd_payload_fragment_length = io_input_cmd_input_payload_fragment_length;
  assign io_outputs_2_cmd_payload_fragment_data = io_input_cmd_input_payload_fragment_data;
  assign io_outputs_2_cmd_payload_fragment_mask = io_input_cmd_input_payload_fragment_mask;
  assign io_outputs_2_cmd_payload_fragment_context = io_input_cmd_input_payload_fragment_context;
  assign logic_hitsS0_3 = ((io_input_cmd_payload_fragment_address & (~ 24'h000fff)) == 24'h014000);
  always @(*) begin
    io_outputs_3_cmd_valid = (io_input_cmd_input_valid && logic_hitsS1_3);
    if(logic_cmdWait) begin
      io_outputs_3_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_3_cmd_payload_last = io_input_cmd_input_payload_last;
  assign io_outputs_3_cmd_payload_last = _zz_io_outputs_3_cmd_payload_last;
  assign io_outputs_3_cmd_payload_fragment_source = io_input_cmd_input_payload_fragment_source;
  assign io_outputs_3_cmd_payload_fragment_opcode = io_input_cmd_input_payload_fragment_opcode;
  assign io_outputs_3_cmd_payload_fragment_address = io_input_cmd_input_payload_fragment_address;
  assign io_outputs_3_cmd_payload_fragment_length = io_input_cmd_input_payload_fragment_length;
  assign io_outputs_3_cmd_payload_fragment_data = io_input_cmd_input_payload_fragment_data;
  assign io_outputs_3_cmd_payload_fragment_mask = io_input_cmd_input_payload_fragment_mask;
  assign io_outputs_3_cmd_payload_fragment_context = io_input_cmd_input_payload_fragment_context;
  assign logic_hitsS0_4 = ((io_input_cmd_payload_fragment_address & (~ 24'h0000ff)) == 24'h0);
  always @(*) begin
    io_outputs_4_cmd_valid = (io_input_cmd_input_valid && logic_hitsS1_4);
    if(logic_cmdWait) begin
      io_outputs_4_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_4_cmd_payload_last = io_input_cmd_input_payload_last;
  assign io_outputs_4_cmd_payload_last = _zz_io_outputs_4_cmd_payload_last;
  assign io_outputs_4_cmd_payload_fragment_source = io_input_cmd_input_payload_fragment_source;
  assign io_outputs_4_cmd_payload_fragment_opcode = io_input_cmd_input_payload_fragment_opcode;
  assign io_outputs_4_cmd_payload_fragment_address = io_input_cmd_input_payload_fragment_address;
  assign io_outputs_4_cmd_payload_fragment_length = io_input_cmd_input_payload_fragment_length;
  assign io_outputs_4_cmd_payload_fragment_data = io_input_cmd_input_payload_fragment_data;
  assign io_outputs_4_cmd_payload_fragment_mask = io_input_cmd_input_payload_fragment_mask;
  assign io_outputs_4_cmd_payload_fragment_context = io_input_cmd_input_payload_fragment_context;
  always @(*) begin
    io_input_cmd_input_ready = (({(logic_hitsS1_4 && io_outputs_4_cmd_ready),{(logic_hitsS1_3 && io_outputs_3_cmd_ready),{(logic_hitsS1_2 && io_outputs_2_cmd_ready),{(logic_hitsS1_1 && io_outputs_1_cmd_ready),(logic_hitsS1_0 && io_outputs_0_cmd_ready)}}}} != 5'h0) || logic_noHitS1);
    if(logic_cmdWait) begin
      io_input_cmd_input_ready = 1'b0;
    end
  end

  assign io_input_cmd_input_fire_1 = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  assign io_input_rsp_fire = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbDecoder_l56 = (io_input_cmd_input_valid && (! logic_cmdWait));
  assign logic_rspPending = (logic_rspPendingCounter != 4'b0000);
  assign logic_rspNoHitValid = (! ({logic_rspHits_4,{logic_rspHits_3,{logic_rspHits_2,{logic_rspHits_1,logic_rspHits_0}}}} != 5'h0));
  assign io_input_rsp_fire_1 = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbDecoder_l60 = (io_input_rsp_fire_1 && io_input_rsp_payload_last);
  assign io_input_cmd_input_fire_2 = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  assign when_BmbDecoder_l60_1 = ((io_input_cmd_input_fire_2 && logic_noHitS1) && io_input_cmd_input_payload_last);
  assign io_input_cmd_input_fire_3 = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  assign io_input_cmd_input_fire_4 = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  assign io_input_cmd_input_fire_5 = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  assign io_input_cmd_input_fire_6 = (io_input_cmd_input_valid && io_input_cmd_input_ready);
  always @(*) begin
    io_input_rsp_valid = (({io_outputs_4_rsp_valid,{io_outputs_3_rsp_valid,{io_outputs_2_rsp_valid,{io_outputs_1_rsp_valid,io_outputs_0_rsp_valid}}}} != 5'h0) || (logic_rspPending && logic_rspNoHitValid));
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_valid = 1'b1;
    end
  end

  assign _zz_io_input_rsp_payload_last = (logic_rspHits_1 || logic_rspHits_3);
  assign _zz_io_input_rsp_payload_last_1 = (logic_rspHits_2 || logic_rspHits_3);
  assign _zz_io_input_rsp_payload_last_2 = {logic_rspHits_4,{_zz_io_input_rsp_payload_last_1,_zz_io_input_rsp_payload_last}};
  always @(*) begin
    io_input_rsp_payload_last = _zz_io_input_rsp_payload_last_3;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_last = 1'b1;
    end
  end

  always @(*) begin
    io_input_rsp_payload_fragment_source = _zz_io_input_rsp_payload_fragment_source;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_source = logic_rspNoHit_source;
    end
  end

  always @(*) begin
    io_input_rsp_payload_fragment_opcode = _zz_io_input_rsp_payload_fragment_opcode;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_opcode = 1'b1;
    end
  end

  assign io_input_rsp_payload_fragment_data = _zz_io_input_rsp_payload_fragment_data;
  always @(*) begin
    io_input_rsp_payload_fragment_context = _zz_io_input_rsp_payload_fragment_context;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_context = logic_rspNoHit_context;
    end
  end

  assign io_outputs_0_rsp_ready = io_input_rsp_ready;
  assign io_outputs_1_rsp_ready = io_input_rsp_ready;
  assign io_outputs_2_rsp_ready = io_input_rsp_ready;
  assign io_outputs_3_rsp_ready = io_input_rsp_ready;
  assign io_outputs_4_rsp_ready = io_input_rsp_ready;
  assign logic_cmdWait = ((logic_rspPending && ((((((logic_hitsS1_0 != logic_rspHits_0) || (logic_hitsS1_1 != logic_rspHits_1)) || (logic_hitsS1_2 != logic_rspHits_2)) || (logic_hitsS1_3 != logic_rspHits_3)) || (logic_hitsS1_4 != logic_rspHits_4)) || logic_rspNoHitValid)) || (logic_rspPendingCounter == 4'b1000));
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      io_input_cmd_rValid <= 1'b0;
      logic_rspPendingCounter <= 4'b0000;
      logic_rspNoHit_doIt <= 1'b0;
    end else begin
      if(io_input_cmd_valid) begin
        io_input_cmd_rValid <= 1'b1;
      end
      if(io_input_cmd_input_fire) begin
        io_input_cmd_rValid <= 1'b0;
      end
      logic_rspPendingCounter <= (_zz_logic_rspPendingCounter - _zz_logic_rspPendingCounter_3);
      if(when_BmbDecoder_l60) begin
        logic_rspNoHit_doIt <= 1'b0;
      end
      if(when_BmbDecoder_l60_1) begin
        logic_rspNoHit_doIt <= 1'b1;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(io_input_cmd_ready) begin
      io_input_cmd_rData_last <= io_input_cmd_payload_last;
      io_input_cmd_rData_fragment_source <= io_input_cmd_payload_fragment_source;
      io_input_cmd_rData_fragment_opcode <= io_input_cmd_payload_fragment_opcode;
      io_input_cmd_rData_fragment_address <= io_input_cmd_payload_fragment_address;
      io_input_cmd_rData_fragment_length <= io_input_cmd_payload_fragment_length;
      io_input_cmd_rData_fragment_data <= io_input_cmd_payload_fragment_data;
      io_input_cmd_rData_fragment_mask <= io_input_cmd_payload_fragment_mask;
      io_input_cmd_rData_fragment_context <= io_input_cmd_payload_fragment_context;
    end
    if(io_input_cmd_fire) begin
      logic_hitsS1_0 <= logic_hitsS0_0;
      logic_hitsS1_1 <= logic_hitsS0_1;
      logic_hitsS1_2 <= logic_hitsS0_2;
      logic_hitsS1_3 <= logic_hitsS0_3;
      logic_hitsS1_4 <= logic_hitsS0_4;
    end
    if(io_input_cmd_fire_1) begin
      logic_noHitS1 <= logic_noHitS0;
    end
    if(when_BmbDecoder_l56) begin
      logic_rspHits_0 <= logic_hitsS1_0;
      logic_rspHits_1 <= logic_hitsS1_1;
      logic_rspHits_2 <= logic_hitsS1_2;
      logic_rspHits_3 <= logic_hitsS1_3;
      logic_rspHits_4 <= logic_hitsS1_4;
    end
    if(io_input_cmd_input_fire_3) begin
      logic_rspNoHit_singleBeatRsp <= (io_input_cmd_input_payload_fragment_opcode == 1'b1);
    end
    if(io_input_cmd_input_fire_4) begin
      logic_rspNoHit_source <= io_input_cmd_input_payload_fragment_source;
    end
    if(io_input_cmd_input_fire_5) begin
      logic_rspNoHit_context <= io_input_cmd_input_payload_fragment_context;
    end
  end


endmodule

module BmbOnChipRam (
  input               io_bus_cmd_valid,
  output              io_bus_cmd_ready,
  input               io_bus_cmd_payload_last,
  input      [0:0]    io_bus_cmd_payload_fragment_source,
  input      [0:0]    io_bus_cmd_payload_fragment_opcode,
  input      [12:0]   io_bus_cmd_payload_fragment_address,
  input      [1:0]    io_bus_cmd_payload_fragment_length,
  input      [31:0]   io_bus_cmd_payload_fragment_data,
  input      [3:0]    io_bus_cmd_payload_fragment_mask,
  input      [0:0]    io_bus_cmd_payload_fragment_context,
  output              io_bus_rsp_valid,
  input               io_bus_rsp_ready,
  output              io_bus_rsp_payload_last,
  output     [0:0]    io_bus_rsp_payload_fragment_source,
  output     [0:0]    io_bus_rsp_payload_fragment_opcode,
  output     [31:0]   io_bus_rsp_payload_fragment_data,
  output     [0:0]    io_bus_rsp_payload_fragment_context,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  reg        [31:0]   _zz_ram_port0;
  wire                io_bus_rsp_isStall;
  reg                 io_bus_cmd_valid_regNextWhen;
  reg        [0:0]    io_bus_cmd_payload_fragment_source_regNextWhen;
  reg        [0:0]    io_bus_cmd_payload_fragment_context_regNextWhen;
  wire       [10:0]   _zz_io_bus_rsp_payload_fragment_data;
  wire                io_bus_cmd_fire;
  wire                _zz_io_bus_rsp_payload_fragment_data_1;
  wire       [31:0]   _zz_io_bus_rsp_payload_fragment_data_2;
  reg [7:0] ram_symbol0 [0:2047];
  reg [7:0] ram_symbol1 [0:2047];
  reg [7:0] ram_symbol2 [0:2047];
  reg [7:0] ram_symbol3 [0:2047];
  reg [7:0] _zz_ramsymbol_read;
  reg [7:0] _zz_ramsymbol_read_1;
  reg [7:0] _zz_ramsymbol_read_2;
  reg [7:0] _zz_ramsymbol_read_3;

  initial begin
    $readmemb("trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol0.bin",ram_symbol0);
    $readmemb("trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol1.bin",ram_symbol1);
    $readmemb("trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol2.bin",ram_symbol2);
    $readmemb("trion_cacheless.v_toplevel_system_ramA_logic_ram_symbol3.bin",ram_symbol3);
  end
  always @(*) begin
    _zz_ram_port0 = {_zz_ramsymbol_read_3, _zz_ramsymbol_read_2, _zz_ramsymbol_read_1, _zz_ramsymbol_read};
  end
  always @(posedge io_systemClk) begin
    if(io_bus_cmd_fire) begin
      _zz_ramsymbol_read <= ram_symbol0[_zz_io_bus_rsp_payload_fragment_data];
      _zz_ramsymbol_read_1 <= ram_symbol1[_zz_io_bus_rsp_payload_fragment_data];
      _zz_ramsymbol_read_2 <= ram_symbol2[_zz_io_bus_rsp_payload_fragment_data];
      _zz_ramsymbol_read_3 <= ram_symbol3[_zz_io_bus_rsp_payload_fragment_data];
    end
  end

  always @(posedge io_systemClk) begin
    if(io_bus_cmd_payload_fragment_mask[0] && io_bus_cmd_fire && _zz_io_bus_rsp_payload_fragment_data_1 ) begin
      ram_symbol0[_zz_io_bus_rsp_payload_fragment_data] <= _zz_io_bus_rsp_payload_fragment_data_2[7 : 0];
    end
    if(io_bus_cmd_payload_fragment_mask[1] && io_bus_cmd_fire && _zz_io_bus_rsp_payload_fragment_data_1 ) begin
      ram_symbol1[_zz_io_bus_rsp_payload_fragment_data] <= _zz_io_bus_rsp_payload_fragment_data_2[15 : 8];
    end
    if(io_bus_cmd_payload_fragment_mask[2] && io_bus_cmd_fire && _zz_io_bus_rsp_payload_fragment_data_1 ) begin
      ram_symbol2[_zz_io_bus_rsp_payload_fragment_data] <= _zz_io_bus_rsp_payload_fragment_data_2[23 : 16];
    end
    if(io_bus_cmd_payload_fragment_mask[3] && io_bus_cmd_fire && _zz_io_bus_rsp_payload_fragment_data_1 ) begin
      ram_symbol3[_zz_io_bus_rsp_payload_fragment_data] <= _zz_io_bus_rsp_payload_fragment_data_2[31 : 24];
    end
  end

  assign io_bus_rsp_isStall = (io_bus_rsp_valid && (! io_bus_rsp_ready));
  assign io_bus_cmd_ready = (! io_bus_rsp_isStall);
  assign io_bus_rsp_valid = io_bus_cmd_valid_regNextWhen;
  assign io_bus_rsp_payload_fragment_source = io_bus_cmd_payload_fragment_source_regNextWhen;
  assign io_bus_rsp_payload_fragment_context = io_bus_cmd_payload_fragment_context_regNextWhen;
  assign _zz_io_bus_rsp_payload_fragment_data = (io_bus_cmd_payload_fragment_address >>> 2);
  assign io_bus_cmd_fire = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign _zz_io_bus_rsp_payload_fragment_data_1 = (io_bus_cmd_payload_fragment_opcode == 1'b1);
  assign _zz_io_bus_rsp_payload_fragment_data_2 = io_bus_cmd_payload_fragment_data;
  assign io_bus_rsp_payload_fragment_data = _zz_ram_port0;
  assign io_bus_rsp_payload_fragment_opcode = 1'b0;
  assign io_bus_rsp_payload_last = 1'b1;
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      io_bus_cmd_valid_regNextWhen <= 1'b0;
    end else begin
      if(io_bus_cmd_ready) begin
        io_bus_cmd_valid_regNextWhen <= io_bus_cmd_valid;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(io_bus_cmd_ready) begin
      io_bus_cmd_payload_fragment_source_regNextWhen <= io_bus_cmd_payload_fragment_source;
    end
    if(io_bus_cmd_ready) begin
      io_bus_cmd_payload_fragment_context_regNextWhen <= io_bus_cmd_payload_fragment_context;
    end
  end


endmodule

module BmbDecoder_2 (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [1:0]    io_input_cmd_payload_fragment_length,
  input      [31:0]   io_input_cmd_payload_fragment_data,
  input      [3:0]    io_input_cmd_payload_fragment_mask,
  output reg          io_input_rsp_valid,
  input               io_input_rsp_ready,
  output reg          io_input_rsp_payload_last,
  output reg [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [31:0]   io_input_rsp_payload_fragment_data,
  output reg          io_outputs_0_cmd_valid,
  input               io_outputs_0_cmd_ready,
  output              io_outputs_0_cmd_payload_last,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_opcode,
  output     [31:0]   io_outputs_0_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_0_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_0_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_0_cmd_payload_fragment_mask,
  input               io_outputs_0_rsp_valid,
  output              io_outputs_0_rsp_ready,
  input               io_outputs_0_rsp_payload_last,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_0_rsp_payload_fragment_data,
  input               io_systemClk,
  input               debugCd_logic_outputReset
);

  wire       [6:0]    _zz_logic_rspPendingCounter;
  wire       [6:0]    _zz_logic_rspPendingCounter_1;
  wire       [0:0]    _zz_logic_rspPendingCounter_2;
  wire       [6:0]    _zz_logic_rspPendingCounter_3;
  wire       [0:0]    _zz_logic_rspPendingCounter_4;
  wire                logic_input_valid;
  reg                 logic_input_ready;
  wire                logic_input_payload_last;
  wire       [0:0]    logic_input_payload_fragment_opcode;
  wire       [31:0]   logic_input_payload_fragment_address;
  wire       [1:0]    logic_input_payload_fragment_length;
  wire       [31:0]   logic_input_payload_fragment_data;
  wire       [3:0]    logic_input_payload_fragment_mask;
  wire                logic_hitsS0_0;
  wire                logic_noHitS0;
  wire                _zz_io_outputs_0_cmd_payload_last;
  reg        [6:0]    logic_rspPendingCounter;
  wire                logic_input_fire;
  wire                io_input_rsp_fire;
  wire                logic_cmdWait;
  wire                when_BmbDecoder_l56;
  reg                 logic_rspHits_0;
  wire                logic_rspPending;
  wire                logic_rspNoHitValid;
  reg                 logic_rspNoHit_doIt;
  wire                io_input_rsp_fire_1;
  wire                when_BmbDecoder_l60;
  wire                logic_input_fire_1;
  wire                when_BmbDecoder_l60_1;
  wire                logic_input_fire_2;
  reg                 logic_rspNoHit_singleBeatRsp;
  wire                logic_input_fire_3;
  wire                logic_input_fire_4;
  wire                logic_input_fire_5;

  assign _zz_logic_rspPendingCounter = (logic_rspPendingCounter + _zz_logic_rspPendingCounter_1);
  assign _zz_logic_rspPendingCounter_2 = (logic_input_fire && logic_input_payload_last);
  assign _zz_logic_rspPendingCounter_1 = {6'd0, _zz_logic_rspPendingCounter_2};
  assign _zz_logic_rspPendingCounter_4 = (io_input_rsp_fire && io_input_rsp_payload_last);
  assign _zz_logic_rspPendingCounter_3 = {6'd0, _zz_logic_rspPendingCounter_4};
  assign logic_input_valid = io_input_cmd_valid;
  assign io_input_cmd_ready = logic_input_ready;
  assign logic_input_payload_last = io_input_cmd_payload_last;
  assign logic_input_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign logic_input_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign logic_input_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign logic_input_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign logic_input_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign logic_noHitS0 = (! (logic_hitsS0_0 != 1'b0));
  assign logic_hitsS0_0 = ((io_input_cmd_payload_fragment_address & (~ 32'h00000fff)) == 32'h10b80000);
  always @(*) begin
    io_outputs_0_cmd_valid = (logic_input_valid && logic_hitsS0_0);
    if(logic_cmdWait) begin
      io_outputs_0_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_0_cmd_payload_last = logic_input_payload_last;
  assign io_outputs_0_cmd_payload_last = _zz_io_outputs_0_cmd_payload_last;
  assign io_outputs_0_cmd_payload_fragment_opcode = logic_input_payload_fragment_opcode;
  assign io_outputs_0_cmd_payload_fragment_address = logic_input_payload_fragment_address;
  assign io_outputs_0_cmd_payload_fragment_length = logic_input_payload_fragment_length;
  assign io_outputs_0_cmd_payload_fragment_data = logic_input_payload_fragment_data;
  assign io_outputs_0_cmd_payload_fragment_mask = logic_input_payload_fragment_mask;
  always @(*) begin
    logic_input_ready = (((logic_hitsS0_0 && io_outputs_0_cmd_ready) != 1'b0) || logic_noHitS0);
    if(logic_cmdWait) begin
      logic_input_ready = 1'b0;
    end
  end

  assign logic_input_fire = (logic_input_valid && logic_input_ready);
  assign io_input_rsp_fire = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbDecoder_l56 = (logic_input_valid && (! logic_cmdWait));
  assign logic_rspPending = (logic_rspPendingCounter != 7'h0);
  assign logic_rspNoHitValid = (! (logic_rspHits_0 != 1'b0));
  assign io_input_rsp_fire_1 = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbDecoder_l60 = (io_input_rsp_fire_1 && io_input_rsp_payload_last);
  assign logic_input_fire_1 = (logic_input_valid && logic_input_ready);
  assign when_BmbDecoder_l60_1 = ((logic_input_fire_1 && logic_noHitS0) && logic_input_payload_last);
  assign logic_input_fire_2 = (logic_input_valid && logic_input_ready);
  assign logic_input_fire_3 = (logic_input_valid && logic_input_ready);
  assign logic_input_fire_4 = (logic_input_valid && logic_input_ready);
  assign logic_input_fire_5 = (logic_input_valid && logic_input_ready);
  always @(*) begin
    io_input_rsp_valid = ((io_outputs_0_rsp_valid != 1'b0) || (logic_rspPending && logic_rspNoHitValid));
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_valid = 1'b1;
    end
  end

  always @(*) begin
    io_input_rsp_payload_last = io_outputs_0_rsp_payload_last;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_last = 1'b1;
    end
  end

  always @(*) begin
    io_input_rsp_payload_fragment_opcode = io_outputs_0_rsp_payload_fragment_opcode;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_opcode = 1'b1;
    end
  end

  assign io_input_rsp_payload_fragment_data = io_outputs_0_rsp_payload_fragment_data;
  assign io_outputs_0_rsp_ready = io_input_rsp_ready;
  assign logic_cmdWait = ((logic_rspPending && ((logic_hitsS0_0 != logic_rspHits_0) || logic_rspNoHitValid)) || (logic_rspPendingCounter == 7'h40));
  always @(posedge io_systemClk) begin
    if(debugCd_logic_outputReset) begin
      logic_rspPendingCounter <= 7'h0;
      logic_rspNoHit_doIt <= 1'b0;
    end else begin
      logic_rspPendingCounter <= (_zz_logic_rspPendingCounter - _zz_logic_rspPendingCounter_3);
      if(when_BmbDecoder_l60) begin
        logic_rspNoHit_doIt <= 1'b0;
      end
      if(when_BmbDecoder_l60_1) begin
        logic_rspNoHit_doIt <= 1'b1;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(when_BmbDecoder_l56) begin
      logic_rspHits_0 <= logic_hitsS0_0;
    end
    if(logic_input_fire_2) begin
      logic_rspNoHit_singleBeatRsp <= (logic_input_payload_fragment_opcode == 1'b1);
    end
  end


endmodule

module BmbDecoder_1 (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_source,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [1:0]    io_input_cmd_payload_fragment_length,
  input      [31:0]   io_input_cmd_payload_fragment_data,
  input      [3:0]    io_input_cmd_payload_fragment_mask,
  input      [0:0]    io_input_cmd_payload_fragment_context,
  output reg          io_input_rsp_valid,
  input               io_input_rsp_ready,
  output reg          io_input_rsp_payload_last,
  output reg [0:0]    io_input_rsp_payload_fragment_source,
  output reg [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [31:0]   io_input_rsp_payload_fragment_data,
  output reg [0:0]    io_input_rsp_payload_fragment_context,
  output reg          io_outputs_0_cmd_valid,
  input               io_outputs_0_cmd_ready,
  output              io_outputs_0_cmd_payload_last,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_opcode,
  output     [31:0]   io_outputs_0_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_0_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_0_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_0_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_context,
  input               io_outputs_0_rsp_valid,
  output              io_outputs_0_rsp_ready,
  input               io_outputs_0_rsp_payload_last,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_0_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_context,
  output reg          io_outputs_1_cmd_valid,
  input               io_outputs_1_cmd_ready,
  output              io_outputs_1_cmd_payload_last,
  output     [0:0]    io_outputs_1_cmd_payload_fragment_source,
  output     [0:0]    io_outputs_1_cmd_payload_fragment_opcode,
  output     [31:0]   io_outputs_1_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_1_cmd_payload_fragment_length,
  output     [31:0]   io_outputs_1_cmd_payload_fragment_data,
  output     [3:0]    io_outputs_1_cmd_payload_fragment_mask,
  output     [0:0]    io_outputs_1_cmd_payload_fragment_context,
  input               io_outputs_1_rsp_valid,
  output              io_outputs_1_rsp_ready,
  input               io_outputs_1_rsp_payload_last,
  input      [0:0]    io_outputs_1_rsp_payload_fragment_source,
  input      [0:0]    io_outputs_1_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_1_rsp_payload_fragment_data,
  input      [0:0]    io_outputs_1_rsp_payload_fragment_context,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire       [6:0]    _zz_logic_rspPendingCounter;
  wire       [6:0]    _zz_logic_rspPendingCounter_1;
  wire       [0:0]    _zz_logic_rspPendingCounter_2;
  wire       [6:0]    _zz_logic_rspPendingCounter_3;
  wire       [0:0]    _zz_logic_rspPendingCounter_4;
  reg                 _zz_io_input_rsp_payload_last_1;
  reg        [0:0]    _zz_io_input_rsp_payload_fragment_source;
  reg        [0:0]    _zz_io_input_rsp_payload_fragment_opcode;
  reg        [31:0]   _zz_io_input_rsp_payload_fragment_data;
  reg        [0:0]    _zz_io_input_rsp_payload_fragment_context;
  wire                logic_input_valid;
  reg                 logic_input_ready;
  wire                logic_input_payload_last;
  wire       [0:0]    logic_input_payload_fragment_source;
  wire       [0:0]    logic_input_payload_fragment_opcode;
  wire       [31:0]   logic_input_payload_fragment_address;
  wire       [1:0]    logic_input_payload_fragment_length;
  wire       [31:0]   logic_input_payload_fragment_data;
  wire       [3:0]    logic_input_payload_fragment_mask;
  wire       [0:0]    logic_input_payload_fragment_context;
  wire                logic_hitsS0_0;
  wire                logic_hitsS0_1;
  wire                logic_noHitS0;
  wire                _zz_io_outputs_0_cmd_payload_last;
  wire                _zz_io_outputs_1_cmd_payload_last;
  reg        [6:0]    logic_rspPendingCounter;
  wire                logic_input_fire;
  wire                io_input_rsp_fire;
  wire                logic_cmdWait;
  wire                when_BmbDecoder_l56;
  reg                 logic_rspHits_0;
  reg                 logic_rspHits_1;
  wire                logic_rspPending;
  wire                logic_rspNoHitValid;
  reg                 logic_rspNoHit_doIt;
  wire                io_input_rsp_fire_1;
  wire                when_BmbDecoder_l60;
  wire                logic_input_fire_1;
  wire                when_BmbDecoder_l60_1;
  wire                logic_input_fire_2;
  reg                 logic_rspNoHit_singleBeatRsp;
  wire                logic_input_fire_3;
  reg        [0:0]    logic_rspNoHit_source;
  wire                logic_input_fire_4;
  reg        [0:0]    logic_rspNoHit_context;
  wire                logic_input_fire_5;
  wire       [0:0]    _zz_io_input_rsp_payload_last;

  assign _zz_logic_rspPendingCounter = (logic_rspPendingCounter + _zz_logic_rspPendingCounter_1);
  assign _zz_logic_rspPendingCounter_2 = (logic_input_fire && logic_input_payload_last);
  assign _zz_logic_rspPendingCounter_1 = {6'd0, _zz_logic_rspPendingCounter_2};
  assign _zz_logic_rspPendingCounter_4 = (io_input_rsp_fire && io_input_rsp_payload_last);
  assign _zz_logic_rspPendingCounter_3 = {6'd0, _zz_logic_rspPendingCounter_4};
  always @(*) begin
    case(_zz_io_input_rsp_payload_last)
      1'b0 : begin
        _zz_io_input_rsp_payload_last_1 = io_outputs_0_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_0_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_0_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_0_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_0_rsp_payload_fragment_context;
      end
      default : begin
        _zz_io_input_rsp_payload_last_1 = io_outputs_1_rsp_payload_last;
        _zz_io_input_rsp_payload_fragment_source = io_outputs_1_rsp_payload_fragment_source;
        _zz_io_input_rsp_payload_fragment_opcode = io_outputs_1_rsp_payload_fragment_opcode;
        _zz_io_input_rsp_payload_fragment_data = io_outputs_1_rsp_payload_fragment_data;
        _zz_io_input_rsp_payload_fragment_context = io_outputs_1_rsp_payload_fragment_context;
      end
    endcase
  end

  assign logic_input_valid = io_input_cmd_valid;
  assign io_input_cmd_ready = logic_input_ready;
  assign logic_input_payload_last = io_input_cmd_payload_last;
  assign logic_input_payload_fragment_source = io_input_cmd_payload_fragment_source;
  assign logic_input_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign logic_input_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign logic_input_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign logic_input_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign logic_input_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign logic_input_payload_fragment_context = io_input_cmd_payload_fragment_context;
  assign logic_noHitS0 = (! ({logic_hitsS0_1,logic_hitsS0_0} != 2'b00));
  assign logic_hitsS0_0 = ((io_input_cmd_payload_fragment_address & (~ 32'h00001fff)) == 32'hf9000000);
  always @(*) begin
    io_outputs_0_cmd_valid = (logic_input_valid && logic_hitsS0_0);
    if(logic_cmdWait) begin
      io_outputs_0_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_0_cmd_payload_last = logic_input_payload_last;
  assign io_outputs_0_cmd_payload_last = _zz_io_outputs_0_cmd_payload_last;
  assign io_outputs_0_cmd_payload_fragment_source = logic_input_payload_fragment_source;
  assign io_outputs_0_cmd_payload_fragment_opcode = logic_input_payload_fragment_opcode;
  assign io_outputs_0_cmd_payload_fragment_address = logic_input_payload_fragment_address;
  assign io_outputs_0_cmd_payload_fragment_length = logic_input_payload_fragment_length;
  assign io_outputs_0_cmd_payload_fragment_data = logic_input_payload_fragment_data;
  assign io_outputs_0_cmd_payload_fragment_mask = logic_input_payload_fragment_mask;
  assign io_outputs_0_cmd_payload_fragment_context = logic_input_payload_fragment_context;
  assign logic_hitsS0_1 = ((io_input_cmd_payload_fragment_address & (~ 32'h00ffffff)) == 32'hf8000000);
  always @(*) begin
    io_outputs_1_cmd_valid = (logic_input_valid && logic_hitsS0_1);
    if(logic_cmdWait) begin
      io_outputs_1_cmd_valid = 1'b0;
    end
  end

  assign _zz_io_outputs_1_cmd_payload_last = logic_input_payload_last;
  assign io_outputs_1_cmd_payload_last = _zz_io_outputs_1_cmd_payload_last;
  assign io_outputs_1_cmd_payload_fragment_source = logic_input_payload_fragment_source;
  assign io_outputs_1_cmd_payload_fragment_opcode = logic_input_payload_fragment_opcode;
  assign io_outputs_1_cmd_payload_fragment_address = logic_input_payload_fragment_address;
  assign io_outputs_1_cmd_payload_fragment_length = logic_input_payload_fragment_length;
  assign io_outputs_1_cmd_payload_fragment_data = logic_input_payload_fragment_data;
  assign io_outputs_1_cmd_payload_fragment_mask = logic_input_payload_fragment_mask;
  assign io_outputs_1_cmd_payload_fragment_context = logic_input_payload_fragment_context;
  always @(*) begin
    logic_input_ready = (({(logic_hitsS0_1 && io_outputs_1_cmd_ready),(logic_hitsS0_0 && io_outputs_0_cmd_ready)} != 2'b00) || logic_noHitS0);
    if(logic_cmdWait) begin
      logic_input_ready = 1'b0;
    end
  end

  assign logic_input_fire = (logic_input_valid && logic_input_ready);
  assign io_input_rsp_fire = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbDecoder_l56 = (logic_input_valid && (! logic_cmdWait));
  assign logic_rspPending = (logic_rspPendingCounter != 7'h0);
  assign logic_rspNoHitValid = (! ({logic_rspHits_1,logic_rspHits_0} != 2'b00));
  assign io_input_rsp_fire_1 = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbDecoder_l60 = (io_input_rsp_fire_1 && io_input_rsp_payload_last);
  assign logic_input_fire_1 = (logic_input_valid && logic_input_ready);
  assign when_BmbDecoder_l60_1 = ((logic_input_fire_1 && logic_noHitS0) && logic_input_payload_last);
  assign logic_input_fire_2 = (logic_input_valid && logic_input_ready);
  assign logic_input_fire_3 = (logic_input_valid && logic_input_ready);
  assign logic_input_fire_4 = (logic_input_valid && logic_input_ready);
  assign logic_input_fire_5 = (logic_input_valid && logic_input_ready);
  always @(*) begin
    io_input_rsp_valid = (({io_outputs_1_rsp_valid,io_outputs_0_rsp_valid} != 2'b00) || (logic_rspPending && logic_rspNoHitValid));
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_valid = 1'b1;
    end
  end

  assign _zz_io_input_rsp_payload_last = logic_rspHits_1;
  always @(*) begin
    io_input_rsp_payload_last = _zz_io_input_rsp_payload_last_1;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_last = 1'b1;
    end
  end

  always @(*) begin
    io_input_rsp_payload_fragment_source = _zz_io_input_rsp_payload_fragment_source;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_source = logic_rspNoHit_source;
    end
  end

  always @(*) begin
    io_input_rsp_payload_fragment_opcode = _zz_io_input_rsp_payload_fragment_opcode;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_opcode = 1'b1;
    end
  end

  assign io_input_rsp_payload_fragment_data = _zz_io_input_rsp_payload_fragment_data;
  always @(*) begin
    io_input_rsp_payload_fragment_context = _zz_io_input_rsp_payload_fragment_context;
    if(logic_rspNoHit_doIt) begin
      io_input_rsp_payload_fragment_context = logic_rspNoHit_context;
    end
  end

  assign io_outputs_0_rsp_ready = io_input_rsp_ready;
  assign io_outputs_1_rsp_ready = io_input_rsp_ready;
  assign logic_cmdWait = ((logic_rspPending && (((logic_hitsS0_0 != logic_rspHits_0) || (logic_hitsS0_1 != logic_rspHits_1)) || logic_rspNoHitValid)) || (logic_rspPendingCounter == 7'h40));
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      logic_rspPendingCounter <= 7'h0;
      logic_rspNoHit_doIt <= 1'b0;
    end else begin
      logic_rspPendingCounter <= (_zz_logic_rspPendingCounter - _zz_logic_rspPendingCounter_3);
      if(when_BmbDecoder_l60) begin
        logic_rspNoHit_doIt <= 1'b0;
      end
      if(when_BmbDecoder_l60_1) begin
        logic_rspNoHit_doIt <= 1'b1;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(when_BmbDecoder_l56) begin
      logic_rspHits_0 <= logic_hitsS0_0;
      logic_rspHits_1 <= logic_hitsS0_1;
    end
    if(logic_input_fire_2) begin
      logic_rspNoHit_singleBeatRsp <= (logic_input_payload_fragment_opcode == 1'b1);
    end
    if(logic_input_fire_3) begin
      logic_rspNoHit_source <= logic_input_payload_fragment_source;
    end
    if(logic_input_fire_4) begin
      logic_rspNoHit_context <= logic_input_payload_fragment_context;
    end
  end


endmodule

module BmbDecoder (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [1:0]    io_input_cmd_payload_fragment_length,
  output              io_input_rsp_valid,
  input               io_input_rsp_ready,
  output              io_input_rsp_payload_last,
  output     [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [31:0]   io_input_rsp_payload_fragment_data,
  output              io_outputs_0_cmd_valid,
  input               io_outputs_0_cmd_ready,
  output              io_outputs_0_cmd_payload_last,
  output     [0:0]    io_outputs_0_cmd_payload_fragment_opcode,
  output     [31:0]   io_outputs_0_cmd_payload_fragment_address,
  output     [1:0]    io_outputs_0_cmd_payload_fragment_length,
  input               io_outputs_0_rsp_valid,
  output              io_outputs_0_rsp_ready,
  input               io_outputs_0_rsp_payload_last,
  input      [0:0]    io_outputs_0_rsp_payload_fragment_opcode,
  input      [31:0]   io_outputs_0_rsp_payload_fragment_data
);


  assign io_outputs_0_cmd_valid = io_input_cmd_valid;
  assign io_input_cmd_ready = io_outputs_0_cmd_ready;
  assign io_input_rsp_valid = io_outputs_0_rsp_valid;
  assign io_outputs_0_rsp_ready = io_input_rsp_ready;
  assign io_outputs_0_cmd_payload_last = io_input_cmd_payload_last;
  assign io_input_rsp_payload_last = io_outputs_0_rsp_payload_last;
  assign io_outputs_0_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_outputs_0_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_outputs_0_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_input_rsp_payload_fragment_opcode = io_outputs_0_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = io_outputs_0_rsp_payload_fragment_data;

endmodule

module BmbArbiter (
  input               io_inputs_0_cmd_valid,
  output              io_inputs_0_cmd_ready,
  input               io_inputs_0_cmd_payload_last,
  input      [0:0]    io_inputs_0_cmd_payload_fragment_opcode,
  input      [31:0]   io_inputs_0_cmd_payload_fragment_address,
  input      [1:0]    io_inputs_0_cmd_payload_fragment_length,
  input      [31:0]   io_inputs_0_cmd_payload_fragment_data,
  input      [3:0]    io_inputs_0_cmd_payload_fragment_mask,
  input      [0:0]    io_inputs_0_cmd_payload_fragment_context,
  output              io_inputs_0_rsp_valid,
  input               io_inputs_0_rsp_ready,
  output              io_inputs_0_rsp_payload_last,
  output     [0:0]    io_inputs_0_rsp_payload_fragment_opcode,
  output     [31:0]   io_inputs_0_rsp_payload_fragment_data,
  output     [0:0]    io_inputs_0_rsp_payload_fragment_context,
  input               io_inputs_1_cmd_valid,
  output              io_inputs_1_cmd_ready,
  input               io_inputs_1_cmd_payload_last,
  input      [0:0]    io_inputs_1_cmd_payload_fragment_opcode,
  input      [31:0]   io_inputs_1_cmd_payload_fragment_address,
  input      [1:0]    io_inputs_1_cmd_payload_fragment_length,
  input      [31:0]   io_inputs_1_cmd_payload_fragment_data,
  input      [3:0]    io_inputs_1_cmd_payload_fragment_mask,
  output              io_inputs_1_rsp_valid,
  input               io_inputs_1_rsp_ready,
  output              io_inputs_1_rsp_payload_last,
  output     [0:0]    io_inputs_1_rsp_payload_fragment_opcode,
  output     [31:0]   io_inputs_1_rsp_payload_fragment_data,
  output              io_output_cmd_valid,
  input               io_output_cmd_ready,
  output              io_output_cmd_payload_last,
  output     [0:0]    io_output_cmd_payload_fragment_source,
  output     [0:0]    io_output_cmd_payload_fragment_opcode,
  output     [31:0]   io_output_cmd_payload_fragment_address,
  output     [1:0]    io_output_cmd_payload_fragment_length,
  output     [31:0]   io_output_cmd_payload_fragment_data,
  output     [3:0]    io_output_cmd_payload_fragment_mask,
  output     [0:0]    io_output_cmd_payload_fragment_context,
  input               io_output_rsp_valid,
  output              io_output_rsp_ready,
  input               io_output_rsp_payload_last,
  input      [0:0]    io_output_rsp_payload_fragment_source,
  input      [0:0]    io_output_rsp_payload_fragment_opcode,
  input      [31:0]   io_output_rsp_payload_fragment_data,
  input      [0:0]    io_output_rsp_payload_fragment_context,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire                memory_arbiter_io_inputs_0_ready;
  wire                memory_arbiter_io_inputs_1_ready;
  wire                memory_arbiter_io_output_valid;
  wire                memory_arbiter_io_output_payload_last;
  wire       [0:0]    memory_arbiter_io_output_payload_fragment_source;
  wire       [0:0]    memory_arbiter_io_output_payload_fragment_opcode;
  wire       [31:0]   memory_arbiter_io_output_payload_fragment_address;
  wire       [1:0]    memory_arbiter_io_output_payload_fragment_length;
  wire       [31:0]   memory_arbiter_io_output_payload_fragment_data;
  wire       [3:0]    memory_arbiter_io_output_payload_fragment_mask;
  wire       [0:0]    memory_arbiter_io_output_payload_fragment_context;
  wire       [0:0]    memory_arbiter_io_chosen;
  wire       [1:0]    memory_arbiter_io_chosenOH;
  wire       [1:0]    _zz_io_output_cmd_payload_fragment_source;
  reg                 _zz_io_output_rsp_ready;
  wire       [0:0]    memory_rspSel;

  assign _zz_io_output_cmd_payload_fragment_source = {memory_arbiter_io_output_payload_fragment_source,memory_arbiter_io_chosen};
  StreamArbiter memory_arbiter (
    .io_inputs_0_valid                       (io_inputs_0_cmd_valid                                    ), //i
    .io_inputs_0_ready                       (memory_arbiter_io_inputs_0_ready                         ), //o
    .io_inputs_0_payload_last                (io_inputs_0_cmd_payload_last                             ), //i
    .io_inputs_0_payload_fragment_source     (1'b0                                                     ), //i
    .io_inputs_0_payload_fragment_opcode     (io_inputs_0_cmd_payload_fragment_opcode                  ), //i
    .io_inputs_0_payload_fragment_address    (io_inputs_0_cmd_payload_fragment_address[31:0]           ), //i
    .io_inputs_0_payload_fragment_length     (io_inputs_0_cmd_payload_fragment_length[1:0]             ), //i
    .io_inputs_0_payload_fragment_data       (io_inputs_0_cmd_payload_fragment_data[31:0]              ), //i
    .io_inputs_0_payload_fragment_mask       (io_inputs_0_cmd_payload_fragment_mask[3:0]               ), //i
    .io_inputs_0_payload_fragment_context    (io_inputs_0_cmd_payload_fragment_context                 ), //i
    .io_inputs_1_valid                       (io_inputs_1_cmd_valid                                    ), //i
    .io_inputs_1_ready                       (memory_arbiter_io_inputs_1_ready                         ), //o
    .io_inputs_1_payload_last                (io_inputs_1_cmd_payload_last                             ), //i
    .io_inputs_1_payload_fragment_source     (1'b0                                                     ), //i
    .io_inputs_1_payload_fragment_opcode     (io_inputs_1_cmd_payload_fragment_opcode                  ), //i
    .io_inputs_1_payload_fragment_address    (io_inputs_1_cmd_payload_fragment_address[31:0]           ), //i
    .io_inputs_1_payload_fragment_length     (io_inputs_1_cmd_payload_fragment_length[1:0]             ), //i
    .io_inputs_1_payload_fragment_data       (io_inputs_1_cmd_payload_fragment_data[31:0]              ), //i
    .io_inputs_1_payload_fragment_mask       (io_inputs_1_cmd_payload_fragment_mask[3:0]               ), //i
    .io_inputs_1_payload_fragment_context    (1'b0                                                     ), //i
    .io_output_valid                         (memory_arbiter_io_output_valid                           ), //o
    .io_output_ready                         (io_output_cmd_ready                                      ), //i
    .io_output_payload_last                  (memory_arbiter_io_output_payload_last                    ), //o
    .io_output_payload_fragment_source       (memory_arbiter_io_output_payload_fragment_source         ), //o
    .io_output_payload_fragment_opcode       (memory_arbiter_io_output_payload_fragment_opcode         ), //o
    .io_output_payload_fragment_address      (memory_arbiter_io_output_payload_fragment_address[31:0]  ), //o
    .io_output_payload_fragment_length       (memory_arbiter_io_output_payload_fragment_length[1:0]    ), //o
    .io_output_payload_fragment_data         (memory_arbiter_io_output_payload_fragment_data[31:0]     ), //o
    .io_output_payload_fragment_mask         (memory_arbiter_io_output_payload_fragment_mask[3:0]      ), //o
    .io_output_payload_fragment_context      (memory_arbiter_io_output_payload_fragment_context        ), //o
    .io_chosen                               (memory_arbiter_io_chosen                                 ), //o
    .io_chosenOH                             (memory_arbiter_io_chosenOH[1:0]                          ), //o
    .io_systemClk                            (io_systemClk                                             ), //i
    .systemCd_logic_outputReset              (systemCd_logic_outputReset                               )  //i
  );
  always @(*) begin
    case(memory_rspSel)
      1'b0 : begin
        _zz_io_output_rsp_ready = io_inputs_0_rsp_ready;
      end
      default : begin
        _zz_io_output_rsp_ready = io_inputs_1_rsp_ready;
      end
    endcase
  end

  assign io_inputs_0_cmd_ready = memory_arbiter_io_inputs_0_ready;
  assign io_inputs_1_cmd_ready = memory_arbiter_io_inputs_1_ready;
  assign io_output_cmd_valid = memory_arbiter_io_output_valid;
  assign io_output_cmd_payload_last = memory_arbiter_io_output_payload_last;
  assign io_output_cmd_payload_fragment_opcode = memory_arbiter_io_output_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = memory_arbiter_io_output_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = memory_arbiter_io_output_payload_fragment_length;
  assign io_output_cmd_payload_fragment_data = memory_arbiter_io_output_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = memory_arbiter_io_output_payload_fragment_mask;
  assign io_output_cmd_payload_fragment_context = memory_arbiter_io_output_payload_fragment_context;
  assign io_output_cmd_payload_fragment_source = _zz_io_output_cmd_payload_fragment_source[0:0];
  assign memory_rspSel = io_output_rsp_payload_fragment_source[0 : 0];
  assign io_inputs_0_rsp_valid = (io_output_rsp_valid && (memory_rspSel == 1'b0));
  assign io_inputs_0_rsp_payload_last = io_output_rsp_payload_last;
  assign io_inputs_0_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_0_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_inputs_0_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context;
  assign io_inputs_1_rsp_valid = (io_output_rsp_valid && (memory_rspSel == 1'b1));
  assign io_inputs_1_rsp_payload_last = io_output_rsp_payload_last;
  assign io_inputs_1_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_1_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_output_rsp_ready = _zz_io_output_rsp_ready;

endmodule

module BufferCC_4 (
  input               io_dataIn,
  output              io_dataOut,
  input               io_systemClk,
  input               system_cores_0_debugReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_systemClk or posedge system_cores_0_debugReset) begin
    if(system_cores_0_debugReset) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module VexRiscv (
  output              iBus_cmd_valid,
  input               iBus_cmd_ready,
  output     [31:0]   iBus_cmd_payload_pc,
  input               iBus_rsp_valid,
  input               iBus_rsp_payload_error,
  input      [31:0]   iBus_rsp_payload_inst,
  input               timerInterrupt,
  input               externalInterrupt,
  input               softwareInterrupt,
  output              CfuPlugin_bus_cmd_valid,
  input               CfuPlugin_bus_cmd_ready,
  output     [9:0]    CfuPlugin_bus_cmd_payload_function_id,
  output     [31:0]   CfuPlugin_bus_cmd_payload_inputs_0,
  output     [31:0]   CfuPlugin_bus_cmd_payload_inputs_1,
  input               CfuPlugin_bus_rsp_valid,
  output              CfuPlugin_bus_rsp_ready,
  input      [31:0]   CfuPlugin_bus_rsp_payload_outputs_0,
  input               debug_bus_cmd_valid,
  output reg          debug_bus_cmd_ready,
  input               debug_bus_cmd_payload_wr,
  input      [7:0]    debug_bus_cmd_payload_address,
  input      [31:0]   debug_bus_cmd_payload_data,
  output reg [31:0]   debug_bus_rsp_data,
  output              debug_resetOut,
  output              dBus_cmd_valid,
  input               dBus_cmd_ready,
  output              dBus_cmd_payload_wr,
  output     [31:0]   dBus_cmd_payload_address,
  output     [31:0]   dBus_cmd_payload_data,
  output     [1:0]    dBus_cmd_payload_size,
  input               dBus_rsp_ready,
  input               dBus_rsp_error,
  input      [31:0]   dBus_rsp_data,
  input               io_systemClk,
  input               systemCd_logic_outputReset,
  input               debugCd_logic_outputReset
);
  localparam ShiftCtrlEnum_DISABLE_1 = 2'd0;
  localparam ShiftCtrlEnum_SLL_1 = 2'd1;
  localparam ShiftCtrlEnum_SRL_1 = 2'd2;
  localparam ShiftCtrlEnum_SRA_1 = 2'd3;
  localparam Input2Kind_RS = 1'd0;
  localparam Input2Kind_IMM_I = 1'd1;
  localparam BranchCtrlEnum_INC = 2'd0;
  localparam BranchCtrlEnum_B = 2'd1;
  localparam BranchCtrlEnum_JAL = 2'd2;
  localparam BranchCtrlEnum_JALR = 2'd3;
  localparam EnvCtrlEnum_NONE = 2'd0;
  localparam EnvCtrlEnum_XRET = 2'd1;
  localparam EnvCtrlEnum_ECALL = 2'd2;
  localparam EnvCtrlEnum_EBREAK = 2'd3;
  localparam AluBitwiseCtrlEnum_XOR_1 = 2'd0;
  localparam AluBitwiseCtrlEnum_OR_1 = 2'd1;
  localparam AluBitwiseCtrlEnum_AND_1 = 2'd2;
  localparam AluCtrlEnum_ADD_SUB = 2'd0;
  localparam AluCtrlEnum_SLT_SLTU = 2'd1;
  localparam AluCtrlEnum_BITWISE = 2'd2;
  localparam Src2CtrlEnum_RS = 2'd0;
  localparam Src2CtrlEnum_IMI = 2'd1;
  localparam Src2CtrlEnum_IMS = 2'd2;
  localparam Src2CtrlEnum_PC = 2'd3;
  localparam Src1CtrlEnum_RS = 2'd0;
  localparam Src1CtrlEnum_IMU = 2'd1;
  localparam Src1CtrlEnum_PC_INCREMENT = 2'd2;
  localparam Src1CtrlEnum_URS1 = 2'd3;

  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready;
  reg        [31:0]   _zz_RegFilePlugin_regFile_port0;
  reg        [31:0]   _zz_RegFilePlugin_regFile_port1;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire       [1:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire       [51:0]   _zz_memory_MUL_LOW;
  wire       [51:0]   _zz_memory_MUL_LOW_1;
  wire       [51:0]   _zz_memory_MUL_LOW_2;
  wire       [51:0]   _zz_memory_MUL_LOW_3;
  wire       [32:0]   _zz_memory_MUL_LOW_4;
  wire       [51:0]   _zz_memory_MUL_LOW_5;
  wire       [49:0]   _zz_memory_MUL_LOW_6;
  wire       [51:0]   _zz_memory_MUL_LOW_7;
  wire       [49:0]   _zz_memory_MUL_LOW_8;
  wire       [31:0]   _zz_execute_SHIFT_RIGHT;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_1;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_2;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_1;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_2;
  wire                _zz_decode_LEGAL_INSTRUCTION_3;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_4;
  wire       [13:0]   _zz_decode_LEGAL_INSTRUCTION_5;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_6;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_7;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_8;
  wire                _zz_decode_LEGAL_INSTRUCTION_9;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_10;
  wire       [7:0]    _zz_decode_LEGAL_INSTRUCTION_11;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_12;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_13;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_14;
  wire                _zz_decode_LEGAL_INSTRUCTION_15;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_16;
  wire       [1:0]    _zz_decode_LEGAL_INSTRUCTION_17;
  wire       [1:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload_1;
  wire       [1:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload_2;
  wire       [31:0]   _zz_IBusSimplePlugin_fetchPc_pc;
  wire       [2:0]    _zz_IBusSimplePlugin_fetchPc_pc_1;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next_1;
  wire       [0:0]    _zz_IBusSimplePlugin_pending_next_2;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next_3;
  wire       [0:0]    _zz_IBusSimplePlugin_pending_next_4;
  wire       [2:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire       [0:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1;
  wire       [2:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2;
  wire       [0:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_1;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_2;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_3;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_4;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_5;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_6;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_7;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_8;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_9;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_10;
  wire       [24:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_11;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_12;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_13;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_14;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_15;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_16;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_17;
  wire       [20:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_18;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_19;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_20;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_21;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_22;
  wire       [2:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_23;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_24;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_25;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_26;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_27;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_28;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_29;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_30;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_31;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_32;
  wire       [16:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_33;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_34;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_35;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_36;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_37;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_38;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_39;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_40;
  wire       [13:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_41;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_42;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_43;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_44;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_45;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_46;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_47;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_48;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_49;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_50;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_51;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_52;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_53;
  wire       [2:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_54;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_55;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_56;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_57;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_58;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_59;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_60;
  wire       [10:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_61;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_62;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_63;
  wire       [4:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_64;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_65;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_66;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_67;
  wire       [2:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_68;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_69;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_70;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_71;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_72;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_73;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_74;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_75;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_76;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_77;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_78;
  wire       [3:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_79;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_80;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_81;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_82;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_83;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_84;
  wire       [1:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_85;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_86;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_87;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_88;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_89;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_90;
  wire       [5:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_91;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_92;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_93;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_94;
  wire       [3:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_95;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_96;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_97;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_98;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_99;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_100;
  wire       [1:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_101;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_102;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_103;
  wire       [6:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_104;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_105;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_106;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_107;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_108;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_109;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_110;
  wire       [1:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_111;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_112;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_113;
  wire       [4:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_114;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_115;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_116;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_117;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_118;
  wire       [2:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_119;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_120;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_121;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_122;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_123;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_124;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_125;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_126;
  wire       [2:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_127;
  wire                _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_128;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_129;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_130;
  wire       [1:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_131;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_132;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_133;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_134;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_135;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_136;
  wire       [1:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_137;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_138;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_139;
  wire       [0:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_140;
  wire       [1:0]    _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_141;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_142;
  wire       [31:0]   _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_143;
  wire                _zz_RegFilePlugin_regFile_port;
  wire                _zz_decode_RegFilePlugin_rs1Data;
  wire                _zz_RegFilePlugin_regFile_port_1;
  wire                _zz_decode_RegFilePlugin_rs2Data;
  wire       [0:0]    _zz__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz__zz_decode_SRC1_1;
  wire       [4:0]    _zz__zz_decode_SRC1_1_1;
  wire       [11:0]   _zz__zz_decode_SRC2_4;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_4;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_5;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_6;
  wire       [65:0]   _zz_writeBack_MulPlugin_result;
  wire       [65:0]   _zz_writeBack_MulPlugin_result_1;
  wire       [31:0]   _zz__zz_decode_RS2_2;
  wire       [31:0]   _zz__zz_decode_RS2_2_1;
  wire       [5:0]    _zz_memory_MulDivIterativePlugin_div_counter_valueNext;
  wire       [0:0]    _zz_memory_MulDivIterativePlugin_div_counter_valueNext_1;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   _zz_memory_MulDivIterativePlugin_div_stage_0_outRemainder;
  wire       [31:0]   _zz_memory_MulDivIterativePlugin_div_stage_0_outRemainder_1;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_div_stage_0_outNumerator;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_div_result_1;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_div_result_2;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_div_result_3;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_div_result_4;
  wire       [0:0]    _zz_memory_MulDivIterativePlugin_div_result_5;
  wire       [32:0]   _zz_memory_MulDivIterativePlugin_rs1_2;
  wire       [0:0]    _zz_memory_MulDivIterativePlugin_rs1_3;
  wire       [31:0]   _zz_memory_MulDivIterativePlugin_rs2_1;
  wire       [0:0]    _zz_memory_MulDivIterativePlugin_rs2_2;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_branch_src2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_branch_src2_4;
  wire       [9:0]    _zz_execute_CfuPlugin_functionsIds_0;
  wire       [51:0]   memory_MUL_LOW;
  wire       [31:0]   memory_MEMORY_READ_DATA;
  wire                memory_CfuPlugin_CFU_IN_FLIGHT;
  wire                execute_CfuPlugin_CFU_IN_FLIGHT;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire       [33:0]   memory_MUL_HH;
  wire       [33:0]   execute_MUL_HH;
  wire       [33:0]   execute_MUL_HL;
  wire       [33:0]   execute_MUL_LH;
  wire       [31:0]   execute_MUL_LL;
  wire       [31:0]   execute_SHIFT_RIGHT;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [1:0]    memory_MEMORY_ADDRESS_LOW;
  wire       [1:0]    execute_MEMORY_ADDRESS_LOW;
  wire                decode_DO_EBREAK;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire       [31:0]   decode_SRC2;
  wire       [31:0]   decode_SRC1;
  wire                decode_SRC2_FORCE_ZERO;
  wire       [0:0]    decode_CfuPlugin_CFU_INPUT_2_KIND;
  wire       [0:0]    _zz_decode_CfuPlugin_CFU_INPUT_2_KIND;
  wire       [0:0]    _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND;
  wire       [0:0]    _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1;
  wire                decode_CfuPlugin_CFU_ENABLE;
  wire       [1:0]    decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       [1:0]    _zz_memory_to_writeBack_ENV_CTRL;
  wire       [1:0]    _zz_memory_to_writeBack_ENV_CTRL_1;
  wire       [1:0]    _zz_execute_to_memory_ENV_CTRL;
  wire       [1:0]    _zz_execute_to_memory_ENV_CTRL_1;
  wire       [1:0]    decode_ENV_CTRL;
  wire       [1:0]    _zz_decode_ENV_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ENV_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ENV_CTRL_1;
  wire                decode_IS_CSR;
  wire                decode_IS_RS2_SIGNED;
  wire                decode_IS_RS1_SIGNED;
  wire                decode_IS_DIV;
  wire                memory_IS_MUL;
  wire                decode_IS_MUL;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL_1;
  wire       [1:0]    decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       [1:0]    decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire       [1:0]    decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL_1;
  wire                execute_HAS_SIDE_EFFECT;
  wire                decode_HAS_SIDE_EFFECT;
  wire                decode_MEMORY_STORE;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire                decode_MEMORY_ENABLE;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire                execute_DO_EBREAK;
  wire                decode_IS_EBREAK;
  reg                 _zz_memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT;
  reg                 _zz_execute_to_memory_CfuPlugin_CFU_IN_FLIGHT;
  wire                writeBack_CfuPlugin_CFU_IN_FLIGHT;
  wire       [0:0]    execute_CfuPlugin_CFU_INPUT_2_KIND;
  wire       [0:0]    _zz_execute_CfuPlugin_CFU_INPUT_2_KIND;
  wire                execute_CfuPlugin_CFU_ENABLE;
  wire                writeBack_HAS_SIDE_EFFECT;
  wire                memory_HAS_SIDE_EFFECT;
  wire       [31:0]   memory_BRANCH_CALC;
  wire                memory_BRANCH_DO;
  wire       [31:0]   execute_PC;
  wire       [1:0]    execute_BRANCH_CTRL;
  wire       [1:0]    _zz_execute_BRANCH_CTRL;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire                execute_IS_CSR;
  wire       [1:0]    memory_ENV_CTRL;
  wire       [1:0]    _zz_memory_ENV_CTRL;
  wire       [1:0]    execute_ENV_CTRL;
  wire       [1:0]    _zz_execute_ENV_CTRL;
  wire       [1:0]    writeBack_ENV_CTRL;
  wire       [1:0]    _zz_writeBack_ENV_CTRL;
  wire                execute_IS_RS1_SIGNED;
  wire                execute_IS_DIV;
  wire                execute_IS_RS2_SIGNED;
  wire                memory_IS_DIV;
  wire                writeBack_IS_MUL;
  wire       [33:0]   writeBack_MUL_HH;
  wire       [51:0]   writeBack_MUL_LOW;
  wire       [33:0]   memory_MUL_HL;
  wire       [33:0]   memory_MUL_LH;
  wire       [31:0]   memory_MUL_LL;
  (* keep , syn_keep *) wire       [31:0]   execute_RS1 /* synthesis syn_keep = 1 */ ;
  wire                execute_IS_MUL;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  reg        [31:0]   _zz_decode_RS2;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  reg        [31:0]   decode_RS2;
  reg        [31:0]   decode_RS1;
  wire       [31:0]   memory_SHIFT_RIGHT;
  reg        [31:0]   _zz_decode_RS2_1;
  wire       [1:0]    memory_SHIFT_CTRL;
  wire       [1:0]    _zz_memory_SHIFT_CTRL;
  wire       [1:0]    execute_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_decode_SRC2;
  wire       [31:0]   _zz_decode_SRC2_1;
  wire       [1:0]    decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_SRC2_CTRL;
  wire       [31:0]   _zz_decode_SRC1;
  wire       [1:0]    decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       [1:0]    execute_ALU_CTRL;
  wire       [1:0]    _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       [31:0]   execute_SRC1;
  wire       [1:0]    execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_1;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire                decode_LEGAL_INSTRUCTION;
  wire       [0:0]    _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_1;
  wire       [1:0]    _zz_decode_ENV_CTRL_1;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_CTRL_1;
  wire       [1:0]    _zz_decode_SRC2_CTRL_1;
  wire       [1:0]    _zz_decode_SRC1_CTRL_1;
  wire                writeBack_MEMORY_STORE;
  reg        [31:0]   _zz_decode_RS2_2;
  wire                writeBack_MEMORY_ENABLE;
  wire       [1:0]    writeBack_MEMORY_ADDRESS_LOW;
  wire       [31:0]   writeBack_MEMORY_READ_DATA;
  wire                memory_MEMORY_STORE;
  wire                memory_MEMORY_ENABLE;
  wire       [31:0]   execute_SRC_ADD;
  (* keep , syn_keep *) wire       [31:0]   execute_RS2 /* synthesis syn_keep = 1 */ ;
  wire       [31:0]   execute_INSTRUCTION;
  wire                execute_MEMORY_STORE;
  wire                execute_MEMORY_ENABLE;
  wire                execute_ALIGNEMENT_FAULT;
  reg        [31:0]   _zz_memory_to_writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   decode_PC;
  wire       [31:0]   decode_INSTRUCTION;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  reg                 decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  reg                 execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  reg                 execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  reg                 memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  reg                 writeBack_arbitration_haltItself;
  wire                writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  wire                writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusSimplePlugin_fetcherHalt;
  reg                 IBusSimplePlugin_incomingInstruction;
  wire                IBusSimplePlugin_pcValids_0;
  wire                IBusSimplePlugin_pcValids_1;
  wire                IBusSimplePlugin_pcValids_2;
  wire                IBusSimplePlugin_pcValids_3;
  wire                decodeExceptionPort_valid;
  wire       [3:0]    decodeExceptionPort_payload_code;
  wire       [31:0]   decodeExceptionPort_payload_badAddr;
  wire       [31:0]   CsrPlugin_csrMapping_readDataSignal;
  wire       [31:0]   CsrPlugin_csrMapping_readDataInit;
  wire       [31:0]   CsrPlugin_csrMapping_writeDataSignal;
  wire                CsrPlugin_csrMapping_allowCsrSignal;
  wire                CsrPlugin_csrMapping_hazardFree;
  wire                CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  reg                 CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_selfException_valid;
  reg        [3:0]    CsrPlugin_selfException_payload_code;
  wire       [31:0]   CsrPlugin_selfException_payload_badAddr;
  reg                 CsrPlugin_allowInterrupts;
  reg                 CsrPlugin_allowException;
  reg                 CsrPlugin_allowEbreakException;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  wire                BranchPlugin_branchExceptionPort_valid;
  wire       [3:0]    BranchPlugin_branchExceptionPort_payload_code;
  wire       [31:0]   BranchPlugin_branchExceptionPort_payload_badAddr;
  reg                 IBusSimplePlugin_injectionPort_valid;
  reg                 IBusSimplePlugin_injectionPort_ready;
  wire       [31:0]   IBusSimplePlugin_injectionPort_payload;
  wire                IBusSimplePlugin_externalFlush;
  wire                IBusSimplePlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusSimplePlugin_jump_pcLoad_payload;
  wire       [1:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload;
  wire                IBusSimplePlugin_fetchPc_output_valid;
  wire                IBusSimplePlugin_fetchPc_output_ready;
  wire       [31:0]   IBusSimplePlugin_fetchPc_output_payload;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusSimplePlugin_fetchPc_correction;
  reg                 IBusSimplePlugin_fetchPc_correctionReg;
  wire                IBusSimplePlugin_fetchPc_output_fire;
  wire                IBusSimplePlugin_fetchPc_corrected;
  reg                 IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg                 IBusSimplePlugin_fetchPc_booted;
  reg                 IBusSimplePlugin_fetchPc_inc;
  wire                when_Fetcher_l131;
  wire                IBusSimplePlugin_fetchPc_output_fire_1;
  wire                when_Fetcher_l131_1;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pc;
  reg                 IBusSimplePlugin_fetchPc_flushed;
  wire                when_Fetcher_l158;
  wire                IBusSimplePlugin_iBusRsp_redoFetch;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_2_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_2_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_2_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_2_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_2_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_2_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_2_halt;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_2_input_ready;
  wire                IBusSimplePlugin_iBusRsp_flush;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1;
  reg                 _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  reg                 _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  reg        [31:0]   _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  reg                 IBusSimplePlugin_iBusRsp_readyForError;
  wire                IBusSimplePlugin_iBusRsp_output_valid;
  wire                IBusSimplePlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire                IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire                when_Fetcher_l240;
  wire                IBusSimplePlugin_injector_decodeInput_valid;
  wire                IBusSimplePlugin_injector_decodeInput_ready;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire                IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire                IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_valid;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  wire                when_Fetcher_l320;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l329;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l329_1;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l329_2;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l329_3;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_4;
  wire                when_Fetcher_l329_4;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_5;
  wire                when_Fetcher_l329_5;
  reg        [31:0]   IBusSimplePlugin_injector_formal_rawInDecode;
  wire                IBusSimplePlugin_cmd_valid;
  wire                IBusSimplePlugin_cmd_ready;
  wire       [31:0]   IBusSimplePlugin_cmd_payload_pc;
  wire                IBusSimplePlugin_pending_inc;
  wire                IBusSimplePlugin_pending_dec;
  reg        [2:0]    IBusSimplePlugin_pending_value;
  wire       [2:0]    IBusSimplePlugin_pending_next;
  wire                IBusSimplePlugin_cmdFork_canEmit;
  wire                when_IBusSimplePlugin_l305;
  wire                IBusSimplePlugin_cmd_fire;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  reg        [2:0]    IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_flush;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_fire;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg                 IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire                when_IBusSimplePlugin_l376;
  wire                IBusSimplePlugin_rspJoin_join_valid;
  wire                IBusSimplePlugin_rspJoin_join_ready;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_pc;
  wire                IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire                IBusSimplePlugin_rspJoin_exceptionDetected;
  wire                IBusSimplePlugin_rspJoin_join_fire;
  wire                IBusSimplePlugin_rspJoin_join_fire_1;
  wire                _zz_IBusSimplePlugin_iBusRsp_output_valid;
  wire                _zz_dBus_cmd_valid;
  reg                 execute_DBusSimplePlugin_skipCmd;
  reg        [31:0]   _zz_dBus_cmd_payload_data;
  wire                when_DBusSimplePlugin_l428;
  reg        [3:0]    _zz_execute_DBusSimplePlugin_formalMask;
  wire       [3:0]    execute_DBusSimplePlugin_formalMask;
  wire                when_DBusSimplePlugin_l481;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspShifted;
  wire       [1:0]    switch_Misc_l203;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_1;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspFormated;
  wire                when_DBusSimplePlugin_l560;
  wire       [32:0]   _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_3;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_4;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_5;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_6;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_7;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_8;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_9;
  wire                _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_10;
  wire       [1:0]    _zz_decode_SRC1_CTRL_2;
  wire       [1:0]    _zz_decode_SRC2_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_2;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_2;
  wire       [1:0]    _zz_decode_ENV_CTRL_2;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_2;
  wire       [0:0]    _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11;
  wire                when_RegFilePlugin_l63;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_2;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_decode_SRC1_1;
  wire                _zz_decode_SRC2_2;
  reg        [19:0]   _zz_decode_SRC2_3;
  wire                _zz_decode_SRC2_4;
  reg        [19:0]   _zz_decode_SRC2_5;
  reg        [31:0]   _zz_decode_SRC2_6;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  wire       [4:0]    execute_FullBarrelShifterPlugin_amplitude;
  reg        [31:0]   _zz_execute_FullBarrelShifterPlugin_reversed;
  wire       [31:0]   execute_FullBarrelShifterPlugin_reversed;
  reg        [31:0]   _zz_decode_RS2_3;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l47;
  wire                when_HazardSimplePlugin_l48;
  wire                when_HazardSimplePlugin_l51;
  wire                when_HazardSimplePlugin_l45;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l48_1;
  wire                when_HazardSimplePlugin_l51_1;
  wire                when_HazardSimplePlugin_l45_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l48_2;
  wire                when_HazardSimplePlugin_l51_2;
  wire                when_HazardSimplePlugin_l45_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  reg                 execute_MulPlugin_aSigned;
  reg                 execute_MulPlugin_bSigned;
  wire       [31:0]   execute_MulPlugin_a;
  wire       [31:0]   execute_MulPlugin_b;
  reg        [0:0]    execute_MulPlugin_delayLogic_counter;
  wire                when_MulPlugin_l65;
  wire                when_MulPlugin_l70;
  wire       [1:0]    switch_MulPlugin_l87;
  wire       [15:0]   execute_MulPlugin_aULow;
  wire       [15:0]   execute_MulPlugin_bULow;
  wire       [16:0]   execute_MulPlugin_aSLow;
  wire       [16:0]   execute_MulPlugin_bSLow;
  wire       [16:0]   execute_MulPlugin_aHigh;
  wire       [16:0]   execute_MulPlugin_bHigh;
  reg        [31:0]   execute_MulPlugin_withOuputBuffer_mul_ll;
  reg        [33:0]   execute_MulPlugin_withOuputBuffer_mul_lh;
  reg        [33:0]   execute_MulPlugin_withOuputBuffer_mul_hl;
  reg        [33:0]   execute_MulPlugin_withOuputBuffer_mul_hh;
  wire       [65:0]   writeBack_MulPlugin_result;
  wire                when_MulPlugin_l147;
  wire       [1:0]    switch_MulPlugin_l148;
  reg        [32:0]   memory_MulDivIterativePlugin_rs1;
  reg        [31:0]   memory_MulDivIterativePlugin_rs2;
  reg        [64:0]   memory_MulDivIterativePlugin_accumulator;
  wire                memory_MulDivIterativePlugin_frontendOk;
  reg                 memory_MulDivIterativePlugin_div_needRevert;
  reg                 memory_MulDivIterativePlugin_div_counter_willIncrement;
  reg                 memory_MulDivIterativePlugin_div_counter_willClear;
  reg        [5:0]    memory_MulDivIterativePlugin_div_counter_valueNext;
  reg        [5:0]    memory_MulDivIterativePlugin_div_counter_value;
  wire                memory_MulDivIterativePlugin_div_counter_willOverflowIfInc;
  wire                memory_MulDivIterativePlugin_div_counter_willOverflow;
  reg                 memory_MulDivIterativePlugin_div_done;
  wire                when_MulDivIterativePlugin_l126;
  wire                when_MulDivIterativePlugin_l126_1;
  reg        [31:0]   memory_MulDivIterativePlugin_div_result;
  wire                when_MulDivIterativePlugin_l128;
  wire                when_MulDivIterativePlugin_l129;
  wire                when_MulDivIterativePlugin_l132;
  wire       [31:0]   _zz_memory_MulDivIterativePlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_MulDivIterativePlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   memory_MulDivIterativePlugin_div_stage_0_outRemainder;
  wire       [31:0]   memory_MulDivIterativePlugin_div_stage_0_outNumerator;
  wire                when_MulDivIterativePlugin_l151;
  wire       [31:0]   _zz_memory_MulDivIterativePlugin_div_result;
  wire                when_MulDivIterativePlugin_l162;
  wire                _zz_memory_MulDivIterativePlugin_rs2;
  wire                _zz_memory_MulDivIterativePlugin_rs1;
  reg        [32:0]   _zz_memory_MulDivIterativePlugin_rs1_1;
  wire       [1:0]    CsrPlugin_misa_base;
  wire       [25:0]   CsrPlugin_misa_extensions;
  reg        [1:0]    CsrPlugin_mtvec_mode;
  reg        [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg        [63:0]   CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire                _zz_when_CsrPlugin_l952;
  wire                _zz_when_CsrPlugin_l952_1;
  wire                _zz_when_CsrPlugin_l952_2;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire                when_CsrPlugin_l909;
  wire                when_CsrPlugin_l909_1;
  wire                when_CsrPlugin_l909_2;
  wire                when_CsrPlugin_l909_3;
  wire                when_CsrPlugin_l922;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                when_CsrPlugin_l946;
  wire                when_CsrPlugin_l952;
  wire                when_CsrPlugin_l952_1;
  wire                when_CsrPlugin_l952_2;
  wire                CsrPlugin_exception;
  wire                CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  wire                when_CsrPlugin_l980;
  wire                when_CsrPlugin_l980_1;
  wire                when_CsrPlugin_l980_2;
  wire                when_CsrPlugin_l985;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                when_CsrPlugin_l991;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  wire                when_CsrPlugin_l1019;
  wire                when_CsrPlugin_l1064;
  wire       [1:0]    switch_CsrPlugin_l1068;
  reg                 execute_CsrPlugin_wfiWake;
  wire                when_CsrPlugin_l1116;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire                when_CsrPlugin_l1129;
  wire                when_CsrPlugin_l1136;
  wire                when_CsrPlugin_l1137;
  wire                when_CsrPlugin_l1144;
  wire                when_CsrPlugin_l1154;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  wire       [31:0]   execute_CsrPlugin_readToWriteData;
  wire                switch_Misc_l203_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_writeDataSignal;
  wire                when_CsrPlugin_l1176;
  wire                when_CsrPlugin_l1180;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l203_2;
  reg                 _zz_execute_BRANCH_DO;
  reg                 _zz_execute_BRANCH_DO_1;
  wire       [31:0]   execute_BranchPlugin_branch_src1;
  wire                _zz_execute_BranchPlugin_branch_src2;
  reg        [10:0]   _zz_execute_BranchPlugin_branch_src2_1;
  wire                _zz_execute_BranchPlugin_branch_src2_2;
  reg        [19:0]   _zz_execute_BranchPlugin_branch_src2_3;
  wire                _zz_execute_BranchPlugin_branch_src2_4;
  reg        [18:0]   _zz_execute_BranchPlugin_branch_src2_5;
  reg        [31:0]   _zz_execute_BranchPlugin_branch_src2_6;
  wire       [31:0]   execute_BranchPlugin_branch_src2;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  wire                execute_CfuPlugin_hazard;
  wire                execute_CfuPlugin_scheduleWish;
  wire                execute_CfuPlugin_schedule;
  wire                when_CfuPlugin_l172;
  reg                 execute_CfuPlugin_hold;
  reg                 execute_CfuPlugin_fired;
  wire                CfuPlugin_bus_cmd_fire;
  wire                when_CfuPlugin_l175;
  wire                when_CfuPlugin_l179;
  wire       [9:0]    execute_CfuPlugin_functionsIds_0;
  wire                _zz_CfuPlugin_bus_cmd_payload_inputs_1;
  reg        [23:0]   _zz_CfuPlugin_bus_cmd_payload_inputs_1_1;
  reg        [31:0]   _zz_CfuPlugin_bus_cmd_payload_inputs_1_2;
  wire                CfuPlugin_bus_rsp_rsp_valid;
  reg                 CfuPlugin_bus_rsp_rsp_ready;
  wire       [31:0]   CfuPlugin_bus_rsp_rsp_payload_outputs_0;
  reg                 CfuPlugin_bus_rsp_rValid;
  reg        [31:0]   CfuPlugin_bus_rsp_rData_outputs_0;
  wire                when_CfuPlugin_l212;
  reg                 DebugPlugin_firstCycle;
  reg                 DebugPlugin_secondCycle;
  reg                 DebugPlugin_resetIt;
  reg                 DebugPlugin_haltIt;
  reg                 DebugPlugin_stepIt;
  reg                 DebugPlugin_isPipBusy;
  reg                 DebugPlugin_godmode;
  wire                when_DebugPlugin_l225;
  reg                 DebugPlugin_haltedByBreak;
  reg                 DebugPlugin_debugUsed /* verilator public */ ;
  reg                 DebugPlugin_disableEbreak;
  wire                DebugPlugin_allowEBreak;
  reg        [31:0]   DebugPlugin_busReadDataReg;
  reg                 _zz_when_DebugPlugin_l244;
  wire                when_DebugPlugin_l244;
  wire       [5:0]    switch_DebugPlugin_l256;
  wire                when_DebugPlugin_l260;
  wire                when_DebugPlugin_l260_1;
  wire                when_DebugPlugin_l261;
  wire                when_DebugPlugin_l261_1;
  wire                when_DebugPlugin_l262;
  wire                when_DebugPlugin_l263;
  wire                when_DebugPlugin_l264;
  wire                when_DebugPlugin_l264_1;
  wire                when_DebugPlugin_l284;
  wire                when_DebugPlugin_l287;
  wire                when_DebugPlugin_l300;
  reg                 DebugPlugin_resetIt_regNext;
  wire                when_DebugPlugin_l316;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_9;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_10;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_11;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_12;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_13;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_14;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_15;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_16;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_17;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_18;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_19;
  reg                 decode_to_execute_MEMORY_STORE;
  wire                when_Pipeline_l124_20;
  reg                 execute_to_memory_MEMORY_STORE;
  wire                when_Pipeline_l124_21;
  reg                 memory_to_writeBack_MEMORY_STORE;
  wire                when_Pipeline_l124_22;
  reg                 decode_to_execute_HAS_SIDE_EFFECT;
  wire                when_Pipeline_l124_23;
  reg                 execute_to_memory_HAS_SIDE_EFFECT;
  wire                when_Pipeline_l124_24;
  reg                 memory_to_writeBack_HAS_SIDE_EFFECT;
  wire                when_Pipeline_l124_25;
  reg        [1:0]    decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_26;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_27;
  reg        [1:0]    decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_28;
  reg        [1:0]    decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_29;
  reg        [1:0]    execute_to_memory_SHIFT_CTRL;
  wire                when_Pipeline_l124_30;
  reg                 decode_to_execute_IS_MUL;
  wire                when_Pipeline_l124_31;
  reg                 execute_to_memory_IS_MUL;
  wire                when_Pipeline_l124_32;
  reg                 memory_to_writeBack_IS_MUL;
  wire                when_Pipeline_l124_33;
  reg                 decode_to_execute_IS_DIV;
  wire                when_Pipeline_l124_34;
  reg                 execute_to_memory_IS_DIV;
  wire                when_Pipeline_l124_35;
  reg                 decode_to_execute_IS_RS1_SIGNED;
  wire                when_Pipeline_l124_36;
  reg                 decode_to_execute_IS_RS2_SIGNED;
  wire                when_Pipeline_l124_37;
  reg                 decode_to_execute_IS_CSR;
  wire                when_Pipeline_l124_38;
  reg        [1:0]    decode_to_execute_ENV_CTRL;
  wire                when_Pipeline_l124_39;
  reg        [1:0]    execute_to_memory_ENV_CTRL;
  wire                when_Pipeline_l124_40;
  reg        [1:0]    memory_to_writeBack_ENV_CTRL;
  wire                when_Pipeline_l124_41;
  reg        [1:0]    decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_42;
  reg                 decode_to_execute_CfuPlugin_CFU_ENABLE;
  wire                when_Pipeline_l124_43;
  reg        [0:0]    decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND;
  wire                when_Pipeline_l124_44;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_45;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_46;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_47;
  reg        [31:0]   decode_to_execute_SRC1;
  wire                when_Pipeline_l124_48;
  reg        [31:0]   decode_to_execute_SRC2;
  wire                when_Pipeline_l124_49;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  wire                when_Pipeline_l124_50;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  wire                when_Pipeline_l124_51;
  reg                 decode_to_execute_DO_EBREAK;
  wire                when_Pipeline_l124_52;
  reg        [1:0]    execute_to_memory_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_53;
  reg        [1:0]    memory_to_writeBack_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_54;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_55;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_56;
  reg        [31:0]   execute_to_memory_SHIFT_RIGHT;
  wire                when_Pipeline_l124_57;
  reg        [31:0]   execute_to_memory_MUL_LL;
  wire                when_Pipeline_l124_58;
  reg        [33:0]   execute_to_memory_MUL_LH;
  wire                when_Pipeline_l124_59;
  reg        [33:0]   execute_to_memory_MUL_HL;
  wire                when_Pipeline_l124_60;
  reg        [33:0]   execute_to_memory_MUL_HH;
  wire                when_Pipeline_l124_61;
  reg        [33:0]   memory_to_writeBack_MUL_HH;
  wire                when_Pipeline_l124_62;
  reg                 execute_to_memory_BRANCH_DO;
  wire                when_Pipeline_l124_63;
  reg        [31:0]   execute_to_memory_BRANCH_CALC;
  wire                when_Pipeline_l124_64;
  reg                 execute_to_memory_CfuPlugin_CFU_IN_FLIGHT;
  wire                when_Pipeline_l124_65;
  reg                 memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT;
  wire                when_Pipeline_l124_66;
  reg        [31:0]   memory_to_writeBack_MEMORY_READ_DATA;
  wire                when_Pipeline_l124_67;
  reg        [51:0]   memory_to_writeBack_MUL_LOW;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  reg        [2:0]    switch_Fetcher_l362;
  wire                when_Fetcher_l378;
  wire                when_Fetcher_l398;
  wire                when_CsrPlugin_l1264;
  reg                 execute_CsrPlugin_csr_3860;
  wire                when_CsrPlugin_l1264_1;
  reg                 execute_CsrPlugin_csr_768;
  wire                when_CsrPlugin_l1264_2;
  reg                 execute_CsrPlugin_csr_836;
  wire                when_CsrPlugin_l1264_3;
  reg                 execute_CsrPlugin_csr_772;
  wire                when_CsrPlugin_l1264_4;
  reg                 execute_CsrPlugin_csr_773;
  wire                when_CsrPlugin_l1264_5;
  reg                 execute_CsrPlugin_csr_833;
  wire                when_CsrPlugin_l1264_6;
  reg                 execute_CsrPlugin_csr_834;
  wire                when_CsrPlugin_l1264_7;
  reg                 execute_CsrPlugin_csr_835;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_5;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_6;
  wire                when_CsrPlugin_l1297;
  wire                when_CsrPlugin_l1302;
  `ifndef SYNTHESIS
  reg [39:0] decode_CfuPlugin_CFU_INPUT_2_KIND_string;
  reg [39:0] _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_string;
  reg [39:0] _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string;
  reg [39:0] _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1_string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_1_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_1_string;
  reg [47:0] decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_1_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_1_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [39:0] execute_CfuPlugin_CFU_INPUT_2_KIND_string;
  reg [39:0] _zz_execute_CfuPlugin_CFU_INPUT_2_KIND_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [47:0] memory_ENV_CTRL_string;
  reg [47:0] _zz_memory_ENV_CTRL_string;
  reg [47:0] execute_ENV_CTRL_string;
  reg [47:0] _zz_execute_ENV_CTRL_string;
  reg [47:0] writeBack_ENV_CTRL_string;
  reg [47:0] _zz_writeBack_ENV_CTRL_string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_memory_SHIFT_CTRL_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [47:0] _zz_decode_ENV_CTRL_1_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_2_string;
  reg [47:0] _zz_decode_ENV_CTRL_2_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [39:0] _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  reg [47:0] decode_to_execute_ENV_CTRL_string;
  reg [47:0] execute_to_memory_ENV_CTRL_string;
  reg [47:0] memory_to_writeBack_ENV_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [39:0] decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_memory_MUL_LOW = ($signed(_zz_memory_MUL_LOW_1) + $signed(_zz_memory_MUL_LOW_5));
  assign _zz_memory_MUL_LOW_1 = ($signed(_zz_memory_MUL_LOW_2) + $signed(_zz_memory_MUL_LOW_3));
  assign _zz_memory_MUL_LOW_2 = 52'h0;
  assign _zz_memory_MUL_LOW_4 = {1'b0,memory_MUL_LL};
  assign _zz_memory_MUL_LOW_3 = {{19{_zz_memory_MUL_LOW_4[32]}}, _zz_memory_MUL_LOW_4};
  assign _zz_memory_MUL_LOW_6 = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_memory_MUL_LOW_5 = {{2{_zz_memory_MUL_LOW_6[49]}}, _zz_memory_MUL_LOW_6};
  assign _zz_memory_MUL_LOW_8 = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_memory_MUL_LOW_7 = {{2{_zz_memory_MUL_LOW_8[49]}}, _zz_memory_MUL_LOW_8};
  assign _zz_execute_SHIFT_RIGHT_1 = ($signed(_zz_execute_SHIFT_RIGHT_2) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT_1[31 : 0];
  assign _zz_execute_SHIFT_RIGHT_2 = {((execute_SHIFT_CTRL == ShiftCtrlEnum_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_1 = (_zz_IBusSimplePlugin_jump_pcLoad_payload & (~ _zz_IBusSimplePlugin_jump_pcLoad_payload_2));
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_2 = (_zz_IBusSimplePlugin_jump_pcLoad_payload - 2'b01);
  assign _zz_IBusSimplePlugin_fetchPc_pc_1 = {IBusSimplePlugin_fetchPc_inc,2'b00};
  assign _zz_IBusSimplePlugin_fetchPc_pc = {29'd0, _zz_IBusSimplePlugin_fetchPc_pc_1};
  assign _zz_IBusSimplePlugin_pending_next = (IBusSimplePlugin_pending_value + _zz_IBusSimplePlugin_pending_next_1);
  assign _zz_IBusSimplePlugin_pending_next_2 = IBusSimplePlugin_pending_inc;
  assign _zz_IBusSimplePlugin_pending_next_1 = {2'd0, _zz_IBusSimplePlugin_pending_next_2};
  assign _zz_IBusSimplePlugin_pending_next_4 = IBusSimplePlugin_pending_dec;
  assign _zz_IBusSimplePlugin_pending_next_3 = {2'd0, _zz_IBusSimplePlugin_pending_next_4};
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1 = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000));
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter = {2'd0, _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1};
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3 = IBusSimplePlugin_pending_dec;
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2 = {2'd0, _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3};
  assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz__zz_decode_SRC1_1 = 3'b100;
  assign _zz__zz_decode_SRC1_1_1 = decode_INSTRUCTION[19 : 15];
  assign _zz__zz_decode_SRC2_4 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_execute_SrcPlugin_addSub = ($signed(_zz_execute_SrcPlugin_addSub_1) + $signed(_zz_execute_SrcPlugin_addSub_4));
  assign _zz_execute_SrcPlugin_addSub_1 = ($signed(_zz_execute_SrcPlugin_addSub_2) + $signed(_zz_execute_SrcPlugin_addSub_3));
  assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? _zz_execute_SrcPlugin_addSub_5 : _zz_execute_SrcPlugin_addSub_6);
  assign _zz_execute_SrcPlugin_addSub_5 = 32'h00000001;
  assign _zz_execute_SrcPlugin_addSub_6 = 32'h0;
  assign _zz_writeBack_MulPlugin_result = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_writeBack_MulPlugin_result_1 = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz__zz_decode_RS2_2 = writeBack_MUL_LOW[31 : 0];
  assign _zz__zz_decode_RS2_2_1 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_memory_MulDivIterativePlugin_div_counter_valueNext_1 = memory_MulDivIterativePlugin_div_counter_willIncrement;
  assign _zz_memory_MulDivIterativePlugin_div_counter_valueNext = {5'd0, _zz_memory_MulDivIterativePlugin_div_counter_valueNext_1};
  assign _zz_memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator = {1'd0, memory_MulDivIterativePlugin_rs2};
  assign _zz_memory_MulDivIterativePlugin_div_stage_0_outRemainder = memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator[31:0];
  assign _zz_memory_MulDivIterativePlugin_div_stage_0_outRemainder_1 = memory_MulDivIterativePlugin_div_stage_0_remainderShifted[31:0];
  assign _zz_memory_MulDivIterativePlugin_div_stage_0_outNumerator = {_zz_memory_MulDivIterativePlugin_div_stage_0_remainderShifted,(! memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator[32])};
  assign _zz_memory_MulDivIterativePlugin_div_result_1 = _zz_memory_MulDivIterativePlugin_div_result_2;
  assign _zz_memory_MulDivIterativePlugin_div_result_2 = _zz_memory_MulDivIterativePlugin_div_result_3;
  assign _zz_memory_MulDivIterativePlugin_div_result_3 = ({memory_MulDivIterativePlugin_div_needRevert,(memory_MulDivIterativePlugin_div_needRevert ? (~ _zz_memory_MulDivIterativePlugin_div_result) : _zz_memory_MulDivIterativePlugin_div_result)} + _zz_memory_MulDivIterativePlugin_div_result_4);
  assign _zz_memory_MulDivIterativePlugin_div_result_5 = memory_MulDivIterativePlugin_div_needRevert;
  assign _zz_memory_MulDivIterativePlugin_div_result_4 = {32'd0, _zz_memory_MulDivIterativePlugin_div_result_5};
  assign _zz_memory_MulDivIterativePlugin_rs1_3 = _zz_memory_MulDivIterativePlugin_rs1;
  assign _zz_memory_MulDivIterativePlugin_rs1_2 = {32'd0, _zz_memory_MulDivIterativePlugin_rs1_3};
  assign _zz_memory_MulDivIterativePlugin_rs2_2 = _zz_memory_MulDivIterativePlugin_rs2;
  assign _zz_memory_MulDivIterativePlugin_rs2_1 = {31'd0, _zz_memory_MulDivIterativePlugin_rs2_2};
  assign _zz__zz_execute_BranchPlugin_branch_src2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_branch_src2_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_execute_CfuPlugin_functionsIds_0 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[14 : 12]};
  assign _zz_decode_RegFilePlugin_rs1Data = 1'b1;
  assign _zz_decode_RegFilePlugin_rs2Data = 1'b1;
  assign _zz_decode_LEGAL_INSTRUCTION = 32'h0000106f;
  assign _zz_decode_LEGAL_INSTRUCTION_1 = (decode_INSTRUCTION & 32'h0000107f);
  assign _zz_decode_LEGAL_INSTRUCTION_2 = 32'h00001073;
  assign _zz_decode_LEGAL_INSTRUCTION_3 = ((decode_INSTRUCTION & 32'h0000207f) == 32'h00002073);
  assign _zz_decode_LEGAL_INSTRUCTION_4 = ((decode_INSTRUCTION & 32'h0000407f) == 32'h00004063);
  assign _zz_decode_LEGAL_INSTRUCTION_5 = {((decode_INSTRUCTION & 32'h0000207f) == 32'h00002013),{((decode_INSTRUCTION & 32'h0000603f) == 32'h00000023),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_6) == 32'h00000003),{(_zz_decode_LEGAL_INSTRUCTION_7 == _zz_decode_LEGAL_INSTRUCTION_8),{_zz_decode_LEGAL_INSTRUCTION_9,{_zz_decode_LEGAL_INSTRUCTION_10,_zz_decode_LEGAL_INSTRUCTION_11}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_6 = 32'h0000207f;
  assign _zz_decode_LEGAL_INSTRUCTION_7 = (decode_INSTRUCTION & 32'h0000505f);
  assign _zz_decode_LEGAL_INSTRUCTION_8 = 32'h00000003;
  assign _zz_decode_LEGAL_INSTRUCTION_9 = ((decode_INSTRUCTION & 32'h0000707b) == 32'h00000063);
  assign _zz_decode_LEGAL_INSTRUCTION_10 = ((decode_INSTRUCTION & 32'h0000607f) == 32'h0000000f);
  assign _zz_decode_LEGAL_INSTRUCTION_11 = {((decode_INSTRUCTION & 32'hfc00007f) == 32'h00000033),{((decode_INSTRUCTION & 32'hbc00707f) == 32'h00005013),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_12) == 32'h00001013),{(_zz_decode_LEGAL_INSTRUCTION_13 == _zz_decode_LEGAL_INSTRUCTION_14),{_zz_decode_LEGAL_INSTRUCTION_15,{_zz_decode_LEGAL_INSTRUCTION_16,_zz_decode_LEGAL_INSTRUCTION_17}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_12 = 32'hfc00307f;
  assign _zz_decode_LEGAL_INSTRUCTION_13 = (decode_INSTRUCTION & 32'hbe00707f);
  assign _zz_decode_LEGAL_INSTRUCTION_14 = 32'h00005033;
  assign _zz_decode_LEGAL_INSTRUCTION_15 = ((decode_INSTRUCTION & 32'hbe00707f) == 32'h00000033);
  assign _zz_decode_LEGAL_INSTRUCTION_16 = ((decode_INSTRUCTION & 32'hdfffffff) == 32'h10200073);
  assign _zz_decode_LEGAL_INSTRUCTION_17 = {((decode_INSTRUCTION & 32'hffefffff) == 32'h00000073),((decode_INSTRUCTION & 32'hffffffff) == 32'h10500073)};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2 = (decode_INSTRUCTION & 32'h0000001c);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_1 = 32'h00000004;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_2 = (decode_INSTRUCTION & 32'h00000058);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_3 = 32'h00000040;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_4 = ((decode_INSTRUCTION & 32'h10003050) == 32'h00000050);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_5 = (|{_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_10,(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_6 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_7)});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_8 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_9,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_10});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_11 = {(|_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_9),{(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_12),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_13,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_15,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_18}}}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_6 = (decode_INSTRUCTION & 32'h10403050);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_7 = 32'h10000050;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_9 = ((decode_INSTRUCTION & 32'h00001050) == 32'h00001050);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_10 = ((decode_INSTRUCTION & 32'h00002050) == 32'h00002050);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_12 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_9;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_13 = (|((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_14) == 32'h02004020));
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_15 = (|(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_16 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_17));
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_18 = {(|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_19,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_21}),{(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_23),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_28,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_31,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_33}}}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_14 = 32'h02004064;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_16 = (decode_INSTRUCTION & 32'h02004074);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_17 = 32'h02000030;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_19 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_20) == 32'h00005010);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_21 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_22) == 32'h00005020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_23 = {(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_24 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_25),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_26,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_27}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_28 = (|(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_29 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_30));
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_31 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_32);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_33 = {(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_34),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_36,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_39,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_41}}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_20 = 32'h00007034;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_22 = 32'h02007064;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_24 = (decode_INSTRUCTION & 32'h40003054);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_25 = 32'h40001010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_26 = ((decode_INSTRUCTION & 32'h00007034) == 32'h00001010);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_27 = ((decode_INSTRUCTION & 32'h02007054) == 32'h00001010);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_29 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_30 = 32'h00000024;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_32 = ((decode_INSTRUCTION & 32'h00001000) == 32'h00001000);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_34 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_35) == 32'h00002000);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_36 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_37,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_38});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_39 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_40);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_41 = {(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_42),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_43,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_48,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_61}}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_35 = 32'h00003000;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_37 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002000);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_38 = ((decode_INSTRUCTION & 32'h00005000) == 32'h00001000);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_40 = ((decode_INSTRUCTION & 32'h00004004) == 32'h00004000);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_42 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_4;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_43 = (|{_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_8,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_44,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_46}});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_48 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_49,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_51,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_54}});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_61 = {(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_62),{(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_64),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_77,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_90,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_104}}}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_44 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_45) == 32'h00000020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_46 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_47) == 32'h00000020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_49 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_50) == 32'h00002040);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_51 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_52 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_53);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_54 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_55,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_57,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_60}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_62 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_63) == 32'h00000020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_64 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_65,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_67,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_68}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_77 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_78,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_79});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_90 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_91);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_104 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_105,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_110,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_114}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_45 = 32'h00000034;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_47 = 32'h00000064;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_50 = 32'h00002040;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_52 = (decode_INSTRUCTION & 32'h00001040);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_53 = 32'h00001040;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_55 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_56) == 32'h00000040);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_57 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_58 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_59);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_60 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_5;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_63 = 32'h00000020;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_65 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_66) == 32'h00000040);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_67 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_6;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_68 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_69,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_71,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_74}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_78 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_6;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_79 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_80,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_82,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_85}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_91 = {_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_7,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_92,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_95}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_105 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_106,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_107});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_110 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_111);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_114 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_115,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_123,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_127}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_56 = 32'h00000050;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_58 = (decode_INSTRUCTION & 32'h00400040);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_59 = 32'h00000040;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_66 = 32'h00000040;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_69 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_70) == 32'h00004020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_71 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_72 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_73);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_74 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_75 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_76);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_80 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_81) == 32'h00002010);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_82 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_83 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_84);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_85 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_86,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_88};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_92 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_93 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_94);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_95 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_96,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_98,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_101}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_106 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_6;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_107 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_108 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_109);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_111 = {_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_6,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_112};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_115 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_116,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_119});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_123 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_124);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_127 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_128,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_136,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_140}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_70 = 32'h00004020;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_72 = (decode_INSTRUCTION & 32'h00000030);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_73 = 32'h00000010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_75 = (decode_INSTRUCTION & 32'h02000020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_76 = 32'h00000020;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_81 = 32'h00002030;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_83 = (decode_INSTRUCTION & 32'h00001030);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_84 = 32'h00000010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_86 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_87) == 32'h00002020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_88 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_89) == 32'h00000020);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_93 = (decode_INSTRUCTION & 32'h00001010);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_94 = 32'h00001010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_96 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_97) == 32'h00002010);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_98 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_99 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_100);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_101 = {_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_102,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_103};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_108 = (decode_INSTRUCTION & 32'h00000070);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_109 = 32'h00000020;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_112 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_113) == 32'h0);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_116 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_117 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_118);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_119 = {_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_5,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_120,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_121}};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_124 = (_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_125 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_126);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_128 = (|{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_129,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_131});
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_136 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_137);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_140 = (|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_141);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_87 = 32'h02002060;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_89 = 32'h02003020;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_97 = 32'h00002010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_99 = (decode_INSTRUCTION & 32'h00000050);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_100 = 32'h00000010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_102 = ((decode_INSTRUCTION & 32'h0000000c) == 32'h00000004);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_103 = ((decode_INSTRUCTION & 32'h00000024) == 32'h0);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_113 = 32'h00000020;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_117 = (decode_INSTRUCTION & 32'h00000044);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_118 = 32'h0;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_120 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_4;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_121 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_122) == 32'h00001000);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_125 = (decode_INSTRUCTION & 32'h00000058);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_126 = 32'h0;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_129 = ((decode_INSTRUCTION & _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_130) == 32'h00000040);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_131 = {(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_132 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_133),(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_134 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_135)};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_137 = {(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_138 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_139),_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_3};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_141 = {(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_142 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_143),_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_3};
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_122 = 32'h00005004;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_130 = 32'h00000044;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_132 = (decode_INSTRUCTION & 32'h00002014);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_133 = 32'h00002010;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_134 = (decode_INSTRUCTION & 32'h40000034);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_135 = 32'h40000030;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_138 = (decode_INSTRUCTION & 32'h00000014);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_139 = 32'h00000004;
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_142 = (decode_INSTRUCTION & 32'h00000044);
  assign _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_143 = 32'h00000004;
  always @(posedge io_systemClk) begin
    if(_zz_decode_RegFilePlugin_rs1Data) begin
      _zz_RegFilePlugin_regFile_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_decode_RegFilePlugin_rs2Data) begin
      _zz_RegFilePlugin_regFile_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rspJoin_rspBuffer_c (
    .io_push_valid                 (iBus_rsp_valid                                                  ), //i
    .io_push_ready                 (IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready              ), //o
    .io_push_payload_error         (iBus_rsp_payload_error                                          ), //i
    .io_push_payload_inst          (iBus_rsp_payload_inst[31:0]                                     ), //i
    .io_pop_valid                  (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid               ), //o
    .io_pop_ready                  (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready               ), //i
    .io_pop_payload_error          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error       ), //o
    .io_pop_payload_inst           (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst[31:0]  ), //o
    .io_flush                      (1'b0                                                            ), //i
    .io_occupancy                  (IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy[1:0]          ), //o
    .io_systemClk                  (io_systemClk                                                    ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset                                      )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(decode_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : decode_CfuPlugin_CFU_INPUT_2_KIND_string = "RS   ";
      Input2Kind_IMM_I : decode_CfuPlugin_CFU_INPUT_2_KIND_string = "IMM_I";
      default : decode_CfuPlugin_CFU_INPUT_2_KIND_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_string = "RS   ";
      Input2Kind_IMM_I : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_string = "IMM_I";
      default : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "RS   ";
      Input2Kind_IMM_I : _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "IMM_I";
      default : _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1)
      Input2Kind_RS : _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1_string = "RS   ";
      Input2Kind_IMM_I : _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1_string = "IMM_I";
      default : _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_memory_to_writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_memory_to_writeBack_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_1_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_execute_to_memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_execute_to_memory_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_execute_to_memory_ENV_CTRL_1_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : decode_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : decode_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : decode_ENV_CTRL_string = "EBREAK";
      default : decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_decode_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_decode_to_execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_decode_to_execute_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_to_execute_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : execute_CfuPlugin_CFU_INPUT_2_KIND_string = "RS   ";
      Input2Kind_IMM_I : execute_CfuPlugin_CFU_INPUT_2_KIND_string = "IMM_I";
      default : execute_CfuPlugin_CFU_INPUT_2_KIND_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : _zz_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "RS   ";
      Input2Kind_IMM_I : _zz_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "IMM_I";
      default : _zz_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "?????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : memory_ENV_CTRL_string = "EBREAK";
      default : memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : execute_ENV_CTRL_string = "EBREAK";
      default : execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : writeBack_ENV_CTRL_string = "EBREAK";
      default : writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1)
      Input2Kind_RS : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1_string = "RS   ";
      Input2Kind_IMM_I : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1_string = "IMM_I";
      default : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_decode_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_2)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_2_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_2_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_2_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_2_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_2_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_2)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_2_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_2_string = "XRET  ";
      EnvCtrlEnum_ECALL : _zz_decode_ENV_CTRL_2_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_2_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11)
      Input2Kind_RS : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11_string = "RS   ";
      Input2Kind_IMM_I : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11_string = "IMM_I";
      default : _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_to_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : decode_to_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : decode_to_execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_to_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : execute_to_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : execute_to_memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_ECALL : memory_to_writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "RS   ";
      Input2Kind_IMM_I : decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "IMM_I";
      default : decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_string = "?????";
    endcase
  end
  `endif

  assign memory_MUL_LOW = ($signed(_zz_memory_MUL_LOW) + $signed(_zz_memory_MUL_LOW_7));
  assign memory_MEMORY_READ_DATA = dBus_rsp_data;
  assign memory_CfuPlugin_CFU_IN_FLIGHT = execute_to_memory_CfuPlugin_CFU_IN_FLIGHT;
  assign execute_CfuPlugin_CFU_IN_FLIGHT = ((execute_CfuPlugin_schedule || execute_CfuPlugin_hold) || execute_CfuPlugin_fired);
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_DO = _zz_execute_BRANCH_DO_1;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = execute_MulPlugin_withOuputBuffer_mul_hh;
  assign execute_MUL_HL = execute_MulPlugin_withOuputBuffer_mul_hl;
  assign execute_MUL_LH = execute_MulPlugin_withOuputBuffer_mul_lh;
  assign execute_MUL_LL = execute_MulPlugin_withOuputBuffer_mul_ll;
  assign execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = dBus_cmd_payload_address[1 : 0];
  assign decode_DO_EBREAK = (((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0)) && DebugPlugin_allowEBreak);
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20);
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h0)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h0))));
  assign decode_SRC2 = _zz_decode_SRC2_6;
  assign decode_SRC1 = _zz_decode_SRC1_1;
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign decode_CfuPlugin_CFU_INPUT_2_KIND = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND;
  assign _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND = _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1;
  assign decode_CfuPlugin_CFU_ENABLE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[31];
  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
  assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1;
  assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1;
  assign decode_ENV_CTRL = _zz_decode_ENV_CTRL;
  assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1;
  assign decode_IS_CSR = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[25];
  assign decode_IS_RS2_SIGNED = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[24];
  assign decode_IS_RS1_SIGNED = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[23];
  assign decode_IS_DIV = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[22];
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign decode_IS_MUL = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[21];
  assign _zz_execute_to_memory_SHIFT_CTRL = _zz_execute_to_memory_SHIFT_CTRL_1;
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[15];
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
  assign execute_HAS_SIDE_EFFECT = decode_to_execute_HAS_SIDE_EFFECT;
  assign decode_HAS_SIDE_EFFECT = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[11];
  assign decode_MEMORY_STORE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[10];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[9];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[8];
  assign decode_MEMORY_ENABLE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[3];
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = (decode_PC + 32'h00000004);
  assign memory_PC = execute_to_memory_PC;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[28];
  always @(*) begin
    _zz_memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT = memory_CfuPlugin_CFU_IN_FLIGHT;
    if(memory_arbitration_isStuck) begin
      _zz_memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT = 1'b0;
    end
  end

  always @(*) begin
    _zz_execute_to_memory_CfuPlugin_CFU_IN_FLIGHT = execute_CfuPlugin_CFU_IN_FLIGHT;
    if(execute_arbitration_isStuck) begin
      _zz_execute_to_memory_CfuPlugin_CFU_IN_FLIGHT = 1'b0;
    end
  end

  assign writeBack_CfuPlugin_CFU_IN_FLIGHT = memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT;
  assign execute_CfuPlugin_CFU_INPUT_2_KIND = _zz_execute_CfuPlugin_CFU_INPUT_2_KIND;
  assign execute_CfuPlugin_CFU_ENABLE = decode_to_execute_CfuPlugin_CFU_ENABLE;
  assign writeBack_HAS_SIDE_EFFECT = memory_to_writeBack_HAS_SIDE_EFFECT;
  assign memory_HAS_SIDE_EFFECT = execute_to_memory_HAS_SIDE_EFFECT;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_memory_ENV_CTRL;
  assign execute_ENV_CTRL = _zz_execute_ENV_CTRL;
  assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_RS2_USE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[12];
  assign decode_RS1_USE = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[4];
  always @(*) begin
    _zz_decode_RS2 = execute_REGFILE_WRITE_DATA;
    if(when_CsrPlugin_l1176) begin
      _zz_decode_RS2 = CsrPlugin_csrMapping_readDataSignal;
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    decode_RS2 = decode_RegFilePlugin_rs2Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l51) begin
          decode_RS2 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l51_1) begin
          decode_RS2 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l51_2) begin
          decode_RS2 = _zz_decode_RS2;
        end
      end
    end
  end

  always @(*) begin
    decode_RS1 = decode_RegFilePlugin_rs1Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l48) begin
          decode_RS1 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l48_1) begin
          decode_RS1 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l48_2) begin
          decode_RS1 = _zz_decode_RS2;
        end
      end
    end
  end

  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @(*) begin
    _zz_decode_RS2_1 = memory_REGFILE_WRITE_DATA;
    if(memory_arbitration_isValid) begin
      case(memory_SHIFT_CTRL)
        ShiftCtrlEnum_SLL_1 : begin
          _zz_decode_RS2_1 = _zz_decode_RS2_3;
        end
        ShiftCtrlEnum_SRL_1, ShiftCtrlEnum_SRA_1 : begin
          _zz_decode_RS2_1 = memory_SHIFT_RIGHT;
        end
        default : begin
        end
      endcase
    end
    if(when_MulDivIterativePlugin_l128) begin
      _zz_decode_RS2_1 = memory_MulDivIterativePlugin_div_result;
    end
  end

  assign memory_SHIFT_CTRL = _zz_memory_SHIFT_CTRL;
  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_decode_SRC2 = decode_PC;
  assign _zz_decode_SRC2_1 = decode_RS2;
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
  assign _zz_decode_SRC1 = decode_RS1;
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
  assign decode_SRC_USE_SUB_LESS = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[2];
  assign decode_SRC_ADD_ZERO = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[18];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
  assign execute_SRC2 = decode_to_execute_SRC2;
  assign execute_SRC1 = decode_to_execute_SRC1;
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    _zz_1 = 1'b0;
    if(lastStageRegFileWrite_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusSimplePlugin_iBusRsp_output_payload_rsp_inst);
  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[7];
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = (|{((decode_INSTRUCTION & 32'h0000005f) == 32'h00000017),{((decode_INSTRUCTION & 32'h0000007f) == 32'h0000006f),{((decode_INSTRUCTION & 32'h0000007f) == 32'h0000000b),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION) == 32'h00000003),{(_zz_decode_LEGAL_INSTRUCTION_1 == _zz_decode_LEGAL_INSTRUCTION_2),{_zz_decode_LEGAL_INSTRUCTION_3,{_zz_decode_LEGAL_INSTRUCTION_4,_zz_decode_LEGAL_INSTRUCTION_5}}}}}}});
  assign writeBack_MEMORY_STORE = memory_to_writeBack_MEMORY_STORE;
  always @(*) begin
    _zz_decode_RS2_2 = writeBack_REGFILE_WRITE_DATA;
    if(when_DBusSimplePlugin_l560) begin
      _zz_decode_RS2_2 = writeBack_DBusSimplePlugin_rspFormated;
    end
    if(when_MulPlugin_l147) begin
      case(switch_MulPlugin_l148)
        2'b00 : begin
          _zz_decode_RS2_2 = _zz__zz_decode_RS2_2;
        end
        default : begin
          _zz_decode_RS2_2 = _zz__zz_decode_RS2_2_1;
        end
      endcase
    end
    if(writeBack_CfuPlugin_CFU_IN_FLIGHT) begin
      _zz_decode_RS2_2 = CfuPlugin_bus_rsp_rsp_payload_outputs_0;
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_MEMORY_STORE = execute_to_memory_MEMORY_STORE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = 1'b0;
  always @(*) begin
    _zz_memory_to_writeBack_FORMAL_PC_NEXT = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid) begin
      _zz_memory_to_writeBack_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload;
    end
  end

  assign decode_PC = IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign decode_INSTRUCTION = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @(*) begin
    decode_arbitration_haltItself = 1'b0;
    case(switch_Fetcher_l362)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_pipelineLiberator_active) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_CsrPlugin_l1116) begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decodeExceptionPort_valid) begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  always @(*) begin
    decode_arbitration_flushNext = 1'b0;
    if(decodeExceptionPort_valid) begin
      decode_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l428) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_MulPlugin_l65) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_CsrPlugin_l1180) begin
      if(execute_CsrPlugin_blockedBySideEffects) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(when_CfuPlugin_l172) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_CfuPlugin_l179) begin
      execute_arbitration_haltItself = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(when_DebugPlugin_l284) begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_removeIt = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_removeIt = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_flushIt = 1'b0;
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_flushNext = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
  end

  always @(*) begin
    memory_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l481) begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l129) begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @(*) begin
    memory_arbitration_removeIt = 1'b0;
    if(BranchPlugin_branchExceptionPort_valid) begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @(*) begin
    memory_arbitration_flushNext = 1'b0;
    if(BranchPlugin_branchExceptionPort_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
    if(BranchPlugin_jumpInterface_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(writeBack_CfuPlugin_CFU_IN_FLIGHT) begin
      if(when_CfuPlugin_l212) begin
        writeBack_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushIt = 1'b0;
  always @(*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(when_CsrPlugin_l1019) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @(*) begin
    IBusSimplePlugin_fetcherHalt = 1'b0;
    if(when_CsrPlugin_l922) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1019) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        IBusSimplePlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_DebugPlugin_l300) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
  end

  always @(*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if(when_Fetcher_l240) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  assign CsrPlugin_csrMapping_allowCsrSignal = 1'b0;
  assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit;
  assign CsrPlugin_inWfi = 1'b0;
  always @(*) begin
    CsrPlugin_thirdPartyWake = 1'b0;
    if(DebugPlugin_haltIt) begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(when_CsrPlugin_l1019) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_CsrPlugin_l1019) begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00};
    end
    if(when_CsrPlugin_l1064) begin
      case(switch_CsrPlugin_l1068)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    CsrPlugin_forceMachineWire = 1'b0;
    if(DebugPlugin_godmode) begin
      CsrPlugin_forceMachineWire = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_allowInterrupts = 1'b1;
    if(when_DebugPlugin_l316) begin
      CsrPlugin_allowInterrupts = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowException = 1'b1;
    if(DebugPlugin_godmode) begin
      CsrPlugin_allowException = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowEbreakException = 1'b1;
    if(DebugPlugin_allowEBreak) begin
      CsrPlugin_allowEbreakException = 1'b0;
    end
  end

  assign IBusSimplePlugin_externalFlush = ({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != 4'b0000);
  assign IBusSimplePlugin_jump_pcLoad_valid = ({BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid} != 2'b00);
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload = {BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid};
  assign IBusSimplePlugin_jump_pcLoad_payload = (_zz_IBusSimplePlugin_jump_pcLoad_payload_1[0] ? CsrPlugin_jumpInterface_payload : BranchPlugin_jumpInterface_payload);
  always @(*) begin
    IBusSimplePlugin_fetchPc_correction = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_correction = 1'b1;
    end
  end

  assign IBusSimplePlugin_fetchPc_output_fire = (IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready);
  assign IBusSimplePlugin_fetchPc_corrected = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_correctionReg);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready) begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  assign when_Fetcher_l131 = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_pcRegPropagate);
  assign IBusSimplePlugin_fetchPc_output_fire_1 = (IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready);
  assign when_Fetcher_l131_1 = ((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_IBusSimplePlugin_fetchPc_pc);
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
    IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
  end

  always @(*) begin
    IBusSimplePlugin_fetchPc_flushed = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign when_Fetcher_l158 = (IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetchPc_correction) || IBusSimplePlugin_fetchPc_pcRegPropagate));
  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  assign IBusSimplePlugin_iBusRsp_redoFetch = 1'b0;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
    if(when_IBusSimplePlugin_l305) begin
      IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_2_halt = 1'b0;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_2_input_ready = (! IBusSimplePlugin_iBusRsp_stages_2_halt);
  assign IBusSimplePlugin_iBusRsp_stages_2_input_ready = (IBusSimplePlugin_iBusRsp_stages_2_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_2_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_valid = (IBusSimplePlugin_iBusRsp_stages_2_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_2_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_payload = IBusSimplePlugin_iBusRsp_stages_2_input_payload;
  assign IBusSimplePlugin_iBusRsp_flush = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_iBusRsp_redoFetch);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready = ((1'b0 && (! _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1)) || IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1 = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid)) || IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid = _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_payload = _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  assign IBusSimplePlugin_iBusRsp_stages_2_input_valid = IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_ready = IBusSimplePlugin_iBusRsp_stages_2_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_2_input_payload = IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
    if(when_Fetcher_l320) begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign when_Fetcher_l240 = (IBusSimplePlugin_iBusRsp_stages_1_input_valid || IBusSimplePlugin_iBusRsp_stages_2_input_valid);
  assign IBusSimplePlugin_iBusRsp_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_IBusSimplePlugin_injector_decodeInput_valid;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign when_Fetcher_l320 = (! IBusSimplePlugin_pcValids_0);
  assign when_Fetcher_l329 = (! (! IBusSimplePlugin_iBusRsp_stages_1_input_ready));
  assign when_Fetcher_l329_1 = (! (! IBusSimplePlugin_iBusRsp_stages_2_input_ready));
  assign when_Fetcher_l329_2 = (! (! IBusSimplePlugin_injector_decodeInput_ready));
  assign when_Fetcher_l329_3 = (! execute_arbitration_isStuck);
  assign when_Fetcher_l329_4 = (! memory_arbitration_isStuck);
  assign when_Fetcher_l329_5 = (! writeBack_arbitration_isStuck);
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_3;
  assign IBusSimplePlugin_pcValids_2 = IBusSimplePlugin_injector_nextPcCalc_valids_4;
  assign IBusSimplePlugin_pcValids_3 = IBusSimplePlugin_injector_nextPcCalc_valids_5;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @(*) begin
    decode_arbitration_isValid = IBusSimplePlugin_injector_decodeInput_valid;
    case(switch_Fetcher_l362)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign iBus_cmd_valid = IBusSimplePlugin_cmd_valid;
  assign IBusSimplePlugin_cmd_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_payload_pc;
  assign IBusSimplePlugin_pending_next = (_zz_IBusSimplePlugin_pending_next - _zz_IBusSimplePlugin_pending_next_3);
  assign IBusSimplePlugin_cmdFork_canEmit = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && (IBusSimplePlugin_pending_value != 3'b111));
  assign when_IBusSimplePlugin_l305 = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && ((! IBusSimplePlugin_cmdFork_canEmit) || (! IBusSimplePlugin_cmd_ready)));
  assign IBusSimplePlugin_cmd_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && IBusSimplePlugin_cmdFork_canEmit);
  assign IBusSimplePlugin_cmd_fire = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign IBusSimplePlugin_pending_inc = IBusSimplePlugin_cmd_fire;
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_0_input_payload[31 : 2],2'b00};
  assign IBusSimplePlugin_rspJoin_rspBuffer_flush = ((IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000) || IBusSimplePlugin_iBusRsp_flush);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_valid = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter == 3'b000));
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready = (IBusSimplePlugin_rspJoin_rspBuffer_output_ready || IBusSimplePlugin_rspJoin_rspBuffer_flush);
  assign IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_fire = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready);
  assign IBusSimplePlugin_pending_dec = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_fire;
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_2_output_payload;
  always @(*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
    if(when_IBusSimplePlugin_l376) begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  assign when_IBusSimplePlugin_l376 = (! IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_2_output_valid && IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_rspJoin_join_fire = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_ready = (IBusSimplePlugin_iBusRsp_stages_2_output_valid ? IBusSimplePlugin_rspJoin_join_fire : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_join_fire_1 = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_ready = IBusSimplePlugin_rspJoin_join_fire_1;
  assign _zz_IBusSimplePlugin_iBusRsp_output_valid = (! IBusSimplePlugin_rspJoin_exceptionDetected);
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_IBusSimplePlugin_iBusRsp_output_valid);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_IBusSimplePlugin_iBusRsp_output_valid);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  assign _zz_dBus_cmd_valid = 1'b0;
  always @(*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT) begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_dBus_cmd_payload_data = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_dBus_cmd_payload_data = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_dBus_cmd_payload_data = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_dBus_cmd_payload_data;
  assign when_DBusSimplePlugin_l428 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0001;
      end
      2'b01 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0011;
      end
      default : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b1111;
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_execute_DBusSimplePlugin_formalMask <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign when_DBusSimplePlugin_l481 = (((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_MEMORY_STORE)) && ((! dBus_rsp_ready) || 1'b0));
  always @(*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign switch_Misc_l203 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_writeBack_DBusSimplePlugin_rspFormated = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[31] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[30] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[29] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[28] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[27] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[26] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[25] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[24] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[23] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[22] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[21] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[20] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[19] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[18] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[17] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[16] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[15] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[14] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[13] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[12] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[11] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[10] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[9] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[8] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_writeBack_DBusSimplePlugin_rspFormated_2 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[31] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[30] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[29] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[28] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[27] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[26] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[25] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[24] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[23] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[22] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[21] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[20] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[19] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[18] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[17] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[16] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @(*) begin
    case(switch_Misc_l203)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_1;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_3;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign when_DBusSimplePlugin_l560 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_3 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_4 = ((decode_INSTRUCTION & 32'h00006004) == 32'h00002000);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_5 = ((decode_INSTRUCTION & 32'h00000018) == 32'h0);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_6 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_7 = ((decode_INSTRUCTION & 32'h00000048) == 32'h00000048);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_8 = ((decode_INSTRUCTION & 32'h0000000c) == 32'h00000008);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_9 = ((decode_INSTRUCTION & 32'h00001000) == 32'h0);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_10 = ((decode_INSTRUCTION & 32'h10103050) == 32'h00100050);
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2 = {1'b0,{(|_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_8),{(|{_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_7,(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_1)}),{(|(_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_2 == _zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_3)),{(|_zz_decode_CfuPlugin_CFU_INPUT_2_KIND_10),{(|_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_4),{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_5,{_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_8,_zz__zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2_11}}}}}}}};
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[1 : 0];
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[6 : 5];
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[14 : 13];
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[17 : 16];
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
  assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[20 : 19];
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2;
  assign _zz_decode_ENV_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[27 : 26];
  assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_2;
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[30 : 29];
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL_2;
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_2[32 : 32];
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1 = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_11;
  assign decodeExceptionPort_valid = (decode_arbitration_isValid && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = 4'b0010;
  assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION;
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h0);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_RegFilePlugin_regFile_port0;
  assign decode_RegFilePlugin_rs2Data = _zz_RegFilePlugin_regFile_port1;
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
    if(_zz_2) begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
    if(_zz_2) begin
      lastStageRegFileWrite_payload_address = 5'h0;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_decode_RS2_2;
    if(_zz_2) begin
      lastStageRegFileWrite_payload_data = 32'h0;
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      AluBitwiseCtrlEnum_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
      end
      AluCtrlEnum_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz__zz_execute_REGFILE_WRITE_DATA};
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : begin
        _zz_decode_SRC1_1 = _zz_decode_SRC1;
      end
      Src1CtrlEnum_PC_INCREMENT : begin
        _zz_decode_SRC1_1 = {29'd0, _zz__zz_decode_SRC1_1};
      end
      Src1CtrlEnum_IMU : begin
        _zz_decode_SRC1_1 = {decode_INSTRUCTION[31 : 12],12'h0};
      end
      default : begin
        _zz_decode_SRC1_1 = {27'd0, _zz__zz_decode_SRC1_1_1};
      end
    endcase
  end

  assign _zz_decode_SRC2_2 = decode_INSTRUCTION[31];
  always @(*) begin
    _zz_decode_SRC2_3[19] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[18] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[17] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[16] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[15] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[14] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[13] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[12] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[11] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[10] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[9] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[8] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[7] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[6] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[5] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[4] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[3] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[2] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[1] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[0] = _zz_decode_SRC2_2;
  end

  assign _zz_decode_SRC2_4 = _zz__zz_decode_SRC2_4[11];
  always @(*) begin
    _zz_decode_SRC2_5[19] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[18] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[17] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[16] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[15] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[14] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[13] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[12] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[11] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[10] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[9] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[8] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[7] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[6] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[5] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[4] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[3] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[2] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[1] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[0] = _zz_decode_SRC2_4;
  end

  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : begin
        _zz_decode_SRC2_6 = _zz_decode_SRC2_1;
      end
      Src2CtrlEnum_IMI : begin
        _zz_decode_SRC2_6 = {_zz_decode_SRC2_3,decode_INSTRUCTION[31 : 20]};
      end
      Src2CtrlEnum_IMS : begin
        _zz_decode_SRC2_6 = {_zz_decode_SRC2_5,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_decode_SRC2_6 = _zz_decode_SRC2;
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub;
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @(*) begin
    _zz_execute_FullBarrelShifterPlugin_reversed[0] = execute_SRC1[31];
    _zz_execute_FullBarrelShifterPlugin_reversed[1] = execute_SRC1[30];
    _zz_execute_FullBarrelShifterPlugin_reversed[2] = execute_SRC1[29];
    _zz_execute_FullBarrelShifterPlugin_reversed[3] = execute_SRC1[28];
    _zz_execute_FullBarrelShifterPlugin_reversed[4] = execute_SRC1[27];
    _zz_execute_FullBarrelShifterPlugin_reversed[5] = execute_SRC1[26];
    _zz_execute_FullBarrelShifterPlugin_reversed[6] = execute_SRC1[25];
    _zz_execute_FullBarrelShifterPlugin_reversed[7] = execute_SRC1[24];
    _zz_execute_FullBarrelShifterPlugin_reversed[8] = execute_SRC1[23];
    _zz_execute_FullBarrelShifterPlugin_reversed[9] = execute_SRC1[22];
    _zz_execute_FullBarrelShifterPlugin_reversed[10] = execute_SRC1[21];
    _zz_execute_FullBarrelShifterPlugin_reversed[11] = execute_SRC1[20];
    _zz_execute_FullBarrelShifterPlugin_reversed[12] = execute_SRC1[19];
    _zz_execute_FullBarrelShifterPlugin_reversed[13] = execute_SRC1[18];
    _zz_execute_FullBarrelShifterPlugin_reversed[14] = execute_SRC1[17];
    _zz_execute_FullBarrelShifterPlugin_reversed[15] = execute_SRC1[16];
    _zz_execute_FullBarrelShifterPlugin_reversed[16] = execute_SRC1[15];
    _zz_execute_FullBarrelShifterPlugin_reversed[17] = execute_SRC1[14];
    _zz_execute_FullBarrelShifterPlugin_reversed[18] = execute_SRC1[13];
    _zz_execute_FullBarrelShifterPlugin_reversed[19] = execute_SRC1[12];
    _zz_execute_FullBarrelShifterPlugin_reversed[20] = execute_SRC1[11];
    _zz_execute_FullBarrelShifterPlugin_reversed[21] = execute_SRC1[10];
    _zz_execute_FullBarrelShifterPlugin_reversed[22] = execute_SRC1[9];
    _zz_execute_FullBarrelShifterPlugin_reversed[23] = execute_SRC1[8];
    _zz_execute_FullBarrelShifterPlugin_reversed[24] = execute_SRC1[7];
    _zz_execute_FullBarrelShifterPlugin_reversed[25] = execute_SRC1[6];
    _zz_execute_FullBarrelShifterPlugin_reversed[26] = execute_SRC1[5];
    _zz_execute_FullBarrelShifterPlugin_reversed[27] = execute_SRC1[4];
    _zz_execute_FullBarrelShifterPlugin_reversed[28] = execute_SRC1[3];
    _zz_execute_FullBarrelShifterPlugin_reversed[29] = execute_SRC1[2];
    _zz_execute_FullBarrelShifterPlugin_reversed[30] = execute_SRC1[1];
    _zz_execute_FullBarrelShifterPlugin_reversed[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == ShiftCtrlEnum_SLL_1) ? _zz_execute_FullBarrelShifterPlugin_reversed : execute_SRC1);
  always @(*) begin
    _zz_decode_RS2_3[0] = memory_SHIFT_RIGHT[31];
    _zz_decode_RS2_3[1] = memory_SHIFT_RIGHT[30];
    _zz_decode_RS2_3[2] = memory_SHIFT_RIGHT[29];
    _zz_decode_RS2_3[3] = memory_SHIFT_RIGHT[28];
    _zz_decode_RS2_3[4] = memory_SHIFT_RIGHT[27];
    _zz_decode_RS2_3[5] = memory_SHIFT_RIGHT[26];
    _zz_decode_RS2_3[6] = memory_SHIFT_RIGHT[25];
    _zz_decode_RS2_3[7] = memory_SHIFT_RIGHT[24];
    _zz_decode_RS2_3[8] = memory_SHIFT_RIGHT[23];
    _zz_decode_RS2_3[9] = memory_SHIFT_RIGHT[22];
    _zz_decode_RS2_3[10] = memory_SHIFT_RIGHT[21];
    _zz_decode_RS2_3[11] = memory_SHIFT_RIGHT[20];
    _zz_decode_RS2_3[12] = memory_SHIFT_RIGHT[19];
    _zz_decode_RS2_3[13] = memory_SHIFT_RIGHT[18];
    _zz_decode_RS2_3[14] = memory_SHIFT_RIGHT[17];
    _zz_decode_RS2_3[15] = memory_SHIFT_RIGHT[16];
    _zz_decode_RS2_3[16] = memory_SHIFT_RIGHT[15];
    _zz_decode_RS2_3[17] = memory_SHIFT_RIGHT[14];
    _zz_decode_RS2_3[18] = memory_SHIFT_RIGHT[13];
    _zz_decode_RS2_3[19] = memory_SHIFT_RIGHT[12];
    _zz_decode_RS2_3[20] = memory_SHIFT_RIGHT[11];
    _zz_decode_RS2_3[21] = memory_SHIFT_RIGHT[10];
    _zz_decode_RS2_3[22] = memory_SHIFT_RIGHT[9];
    _zz_decode_RS2_3[23] = memory_SHIFT_RIGHT[8];
    _zz_decode_RS2_3[24] = memory_SHIFT_RIGHT[7];
    _zz_decode_RS2_3[25] = memory_SHIFT_RIGHT[6];
    _zz_decode_RS2_3[26] = memory_SHIFT_RIGHT[5];
    _zz_decode_RS2_3[27] = memory_SHIFT_RIGHT[4];
    _zz_decode_RS2_3[28] = memory_SHIFT_RIGHT[3];
    _zz_decode_RS2_3[29] = memory_SHIFT_RIGHT[2];
    _zz_decode_RS2_3[30] = memory_SHIFT_RIGHT[1];
    _zz_decode_RS2_3[31] = memory_SHIFT_RIGHT[0];
  end

  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l48) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l48_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l48_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0;
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l51) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l51_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l51_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0;
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_2;
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]);
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l47 = 1'b1;
  assign when_HazardSimplePlugin_l48 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58 = (1'b0 || (! when_HazardSimplePlugin_l47));
  assign when_HazardSimplePlugin_l48_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_1 = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign when_HazardSimplePlugin_l48_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_2 = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE);
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE);
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard));
  assign when_MulPlugin_l65 = ((execute_arbitration_isValid && execute_IS_MUL) && (execute_MulPlugin_delayLogic_counter != 1'b1));
  assign when_MulPlugin_l70 = ((! execute_arbitration_isStuck) || execute_arbitration_isStuckByOthers);
  assign execute_MulPlugin_a = execute_RS1;
  assign execute_MulPlugin_b = execute_RS2;
  assign switch_MulPlugin_l87 = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(switch_MulPlugin_l87)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(switch_MulPlugin_l87)
      2'b01 : begin
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign writeBack_MulPlugin_result = ($signed(_zz_writeBack_MulPlugin_result) + $signed(_zz_writeBack_MulPlugin_result_1));
  assign when_MulPlugin_l147 = (writeBack_arbitration_isValid && writeBack_IS_MUL);
  assign switch_MulPlugin_l148 = writeBack_INSTRUCTION[13 : 12];
  assign memory_MulDivIterativePlugin_frontendOk = 1'b1;
  always @(*) begin
    memory_MulDivIterativePlugin_div_counter_willIncrement = 1'b0;
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l132) begin
        memory_MulDivIterativePlugin_div_counter_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    memory_MulDivIterativePlugin_div_counter_willClear = 1'b0;
    if(when_MulDivIterativePlugin_l162) begin
      memory_MulDivIterativePlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_MulDivIterativePlugin_div_counter_willOverflowIfInc = (memory_MulDivIterativePlugin_div_counter_value == 6'h21);
  assign memory_MulDivIterativePlugin_div_counter_willOverflow = (memory_MulDivIterativePlugin_div_counter_willOverflowIfInc && memory_MulDivIterativePlugin_div_counter_willIncrement);
  always @(*) begin
    if(memory_MulDivIterativePlugin_div_counter_willOverflow) begin
      memory_MulDivIterativePlugin_div_counter_valueNext = 6'h0;
    end else begin
      memory_MulDivIterativePlugin_div_counter_valueNext = (memory_MulDivIterativePlugin_div_counter_value + _zz_memory_MulDivIterativePlugin_div_counter_valueNext);
    end
    if(memory_MulDivIterativePlugin_div_counter_willClear) begin
      memory_MulDivIterativePlugin_div_counter_valueNext = 6'h0;
    end
  end

  assign when_MulDivIterativePlugin_l126 = (memory_MulDivIterativePlugin_div_counter_value == 6'h20);
  assign when_MulDivIterativePlugin_l126_1 = (! memory_arbitration_isStuck);
  assign when_MulDivIterativePlugin_l128 = (memory_arbitration_isValid && memory_IS_DIV);
  assign when_MulDivIterativePlugin_l129 = ((! memory_MulDivIterativePlugin_frontendOk) || (! memory_MulDivIterativePlugin_div_done));
  assign when_MulDivIterativePlugin_l132 = (memory_MulDivIterativePlugin_frontendOk && (! memory_MulDivIterativePlugin_div_done));
  assign _zz_memory_MulDivIterativePlugin_div_stage_0_remainderShifted = memory_MulDivIterativePlugin_rs1[31 : 0];
  assign memory_MulDivIterativePlugin_div_stage_0_remainderShifted = {memory_MulDivIterativePlugin_accumulator[31 : 0],_zz_memory_MulDivIterativePlugin_div_stage_0_remainderShifted[31]};
  assign memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator = (memory_MulDivIterativePlugin_div_stage_0_remainderShifted - _zz_memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator);
  assign memory_MulDivIterativePlugin_div_stage_0_outRemainder = ((! memory_MulDivIterativePlugin_div_stage_0_remainderMinusDenominator[32]) ? _zz_memory_MulDivIterativePlugin_div_stage_0_outRemainder : _zz_memory_MulDivIterativePlugin_div_stage_0_outRemainder_1);
  assign memory_MulDivIterativePlugin_div_stage_0_outNumerator = _zz_memory_MulDivIterativePlugin_div_stage_0_outNumerator[31:0];
  assign when_MulDivIterativePlugin_l151 = (memory_MulDivIterativePlugin_div_counter_value == 6'h20);
  assign _zz_memory_MulDivIterativePlugin_div_result = (memory_INSTRUCTION[13] ? memory_MulDivIterativePlugin_accumulator[31 : 0] : memory_MulDivIterativePlugin_rs1[31 : 0]);
  assign when_MulDivIterativePlugin_l162 = (! memory_arbitration_isStuck);
  assign _zz_memory_MulDivIterativePlugin_rs2 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_memory_MulDivIterativePlugin_rs1 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @(*) begin
    _zz_memory_MulDivIterativePlugin_rs1_1[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_memory_MulDivIterativePlugin_rs1_1[31 : 0] = execute_RS1;
  end

  always @(*) begin
    CsrPlugin_privilege = 2'b11;
    if(CsrPlugin_forceMachineWire) begin
      CsrPlugin_privilege = 2'b11;
    end
  end

  assign CsrPlugin_misa_base = 2'b01;
  assign CsrPlugin_misa_extensions = 26'h0;
  assign _zz_when_CsrPlugin_l952 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_when_CsrPlugin_l952_1 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_when_CsrPlugin_l952_2 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(decodeExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(BranchPlugin_branchExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign when_CsrPlugin_l909 = (! decode_arbitration_isStuck);
  assign when_CsrPlugin_l909_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l909_2 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l909_3 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l922 = ({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != 4'b0000);
  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign when_CsrPlugin_l946 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11));
  assign when_CsrPlugin_l952 = ((_zz_when_CsrPlugin_l952 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l952_1 = ((_zz_when_CsrPlugin_l952_1 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l952_2 = ((_zz_when_CsrPlugin_l952_2 && 1'b1) && (! 1'b0));
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  assign CsrPlugin_lastStageWasWfi = 1'b0;
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid);
  assign when_CsrPlugin_l980 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l980_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l980_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l985 = ((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt);
  always @(*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
    if(when_CsrPlugin_l991) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign when_CsrPlugin_l991 = ({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != 3'b000);
  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  always @(*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException) begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @(*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException) begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @(*) begin
    CsrPlugin_xtvec_mode = 2'bxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign when_CsrPlugin_l1019 = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign when_CsrPlugin_l1064 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET));
  assign switch_CsrPlugin_l1068 = writeBack_INSTRUCTION[29 : 28];
  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign when_CsrPlugin_l1116 = (|{(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == EnvCtrlEnum_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET))}});
  assign execute_CsrPlugin_blockedBySideEffects = ((|{writeBack_arbitration_isValid,memory_arbitration_isValid}) || 1'b0);
  always @(*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    if(execute_CsrPlugin_csr_3860) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_768) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_772) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_773) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_833) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_834) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_835) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(CsrPlugin_csrMapping_allowCsrSignal) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(when_CsrPlugin_l1302) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if(when_CsrPlugin_l1136) begin
      if(when_CsrPlugin_l1137) begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @(*) begin
    CsrPlugin_selfException_valid = 1'b0;
    if(when_CsrPlugin_l1129) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(when_CsrPlugin_l1144) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(when_CsrPlugin_l1154) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_selfException_payload_code = 4'bxxxx;
    if(when_CsrPlugin_l1129) begin
      CsrPlugin_selfException_payload_code = 4'b0010;
    end
    if(when_CsrPlugin_l1144) begin
      case(CsrPlugin_privilege)
        2'b00 : begin
          CsrPlugin_selfException_payload_code = 4'b1000;
        end
        default : begin
          CsrPlugin_selfException_payload_code = 4'b1011;
        end
      endcase
    end
    if(when_CsrPlugin_l1154) begin
      CsrPlugin_selfException_payload_code = 4'b0011;
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  assign when_CsrPlugin_l1129 = (execute_CsrPlugin_illegalAccess || execute_CsrPlugin_illegalInstruction);
  assign when_CsrPlugin_l1136 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET));
  assign when_CsrPlugin_l1137 = (CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]);
  assign when_CsrPlugin_l1144 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_ECALL));
  assign when_CsrPlugin_l1154 = ((execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_EBREAK)) && CsrPlugin_allowEbreakException);
  always @(*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_writeInstruction = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_readInstruction = 1'b0;
    end
  end

  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck));
  assign CsrPlugin_csrMapping_hazardFree = (! execute_CsrPlugin_blockedBySideEffects);
  assign execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal;
  assign switch_Misc_l203_1 = execute_INSTRUCTION[13];
  always @(*) begin
    case(switch_Misc_l203_1)
      1'b0 : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1;
      end
      default : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal;
  assign when_CsrPlugin_l1176 = (execute_arbitration_isValid && execute_IS_CSR);
  assign when_CsrPlugin_l1180 = (execute_arbitration_isValid && (execute_IS_CSR || 1'b0));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign switch_Misc_l203_2 = execute_INSTRUCTION[14 : 12];
  always @(*) begin
    casez(switch_Misc_l203_2)
      3'b000 : begin
        _zz_execute_BRANCH_DO = execute_BranchPlugin_eq;
      end
      3'b001 : begin
        _zz_execute_BRANCH_DO = (! execute_BranchPlugin_eq);
      end
      3'b1?1 : begin
        _zz_execute_BRANCH_DO = (! execute_SRC_LESS);
      end
      default : begin
        _zz_execute_BRANCH_DO = execute_SRC_LESS;
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : begin
        _zz_execute_BRANCH_DO_1 = 1'b0;
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      default : begin
        _zz_execute_BRANCH_DO_1 = _zz_execute_BRANCH_DO;
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == BranchCtrlEnum_JALR) ? execute_RS1 : execute_PC);
  assign _zz_execute_BranchPlugin_branch_src2 = _zz__zz_execute_BranchPlugin_branch_src2[19];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_3[19] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[18] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[17] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[16] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[15] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[14] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[13] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[12] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[11] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_4 = _zz__zz_execute_BranchPlugin_branch_src2_4[11];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JAL : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {{_zz_execute_BranchPlugin_branch_src2_1,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {_zz_execute_BranchPlugin_branch_src2_3,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {{_zz_execute_BranchPlugin_branch_src2_5,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_execute_BranchPlugin_branch_src2_6;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign BranchPlugin_branchExceptionPort_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && BranchPlugin_jumpInterface_payload[1]);
  assign BranchPlugin_branchExceptionPort_payload_code = 4'b0000;
  assign BranchPlugin_branchExceptionPort_payload_badAddr = BranchPlugin_jumpInterface_payload;
  assign execute_CfuPlugin_hazard = ({(writeBack_arbitration_isValid && writeBack_HAS_SIDE_EFFECT),(memory_arbitration_isValid && memory_HAS_SIDE_EFFECT)} != 2'b00);
  assign execute_CfuPlugin_scheduleWish = (execute_arbitration_isValid && execute_CfuPlugin_CFU_ENABLE);
  assign execute_CfuPlugin_schedule = (execute_CfuPlugin_scheduleWish && (! execute_CfuPlugin_hazard));
  assign when_CfuPlugin_l172 = (execute_CfuPlugin_scheduleWish && execute_CfuPlugin_hazard);
  assign CfuPlugin_bus_cmd_fire = (CfuPlugin_bus_cmd_valid && CfuPlugin_bus_cmd_ready);
  assign when_CfuPlugin_l175 = (! execute_arbitration_isStuckByOthers);
  assign CfuPlugin_bus_cmd_valid = ((execute_CfuPlugin_schedule || execute_CfuPlugin_hold) && (! execute_CfuPlugin_fired));
  assign when_CfuPlugin_l179 = (CfuPlugin_bus_cmd_valid && (! CfuPlugin_bus_cmd_ready));
  assign execute_CfuPlugin_functionsIds_0 = _zz_execute_CfuPlugin_functionsIds_0;
  assign CfuPlugin_bus_cmd_payload_function_id = execute_CfuPlugin_functionsIds_0;
  assign CfuPlugin_bus_cmd_payload_inputs_0 = execute_RS1;
  assign _zz_CfuPlugin_bus_cmd_payload_inputs_1 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[23] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[22] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[21] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[20] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[19] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[18] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[17] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[16] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[15] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[14] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[13] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[12] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[11] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[10] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[9] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[8] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[7] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[6] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[5] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[4] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[3] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[2] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[1] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
    _zz_CfuPlugin_bus_cmd_payload_inputs_1_1[0] = _zz_CfuPlugin_bus_cmd_payload_inputs_1;
  end

  always @(*) begin
    case(execute_CfuPlugin_CFU_INPUT_2_KIND)
      Input2Kind_RS : begin
        _zz_CfuPlugin_bus_cmd_payload_inputs_1_2 = execute_RS2;
      end
      default : begin
        _zz_CfuPlugin_bus_cmd_payload_inputs_1_2 = {_zz_CfuPlugin_bus_cmd_payload_inputs_1_1,execute_INSTRUCTION[31 : 24]};
      end
    endcase
  end

  assign CfuPlugin_bus_cmd_payload_inputs_1 = _zz_CfuPlugin_bus_cmd_payload_inputs_1_2;
  assign CfuPlugin_bus_rsp_ready = (! CfuPlugin_bus_rsp_rValid);
  assign CfuPlugin_bus_rsp_rsp_valid = (CfuPlugin_bus_rsp_valid || CfuPlugin_bus_rsp_rValid);
  assign CfuPlugin_bus_rsp_rsp_payload_outputs_0 = (CfuPlugin_bus_rsp_rValid ? CfuPlugin_bus_rsp_rData_outputs_0 : CfuPlugin_bus_rsp_payload_outputs_0);
  always @(*) begin
    CfuPlugin_bus_rsp_rsp_ready = 1'b0;
    if(writeBack_CfuPlugin_CFU_IN_FLIGHT) begin
      CfuPlugin_bus_rsp_rsp_ready = (! writeBack_arbitration_isStuckByOthers);
    end
  end

  assign when_CfuPlugin_l212 = (! CfuPlugin_bus_rsp_rsp_valid);
  assign when_DebugPlugin_l225 = (DebugPlugin_haltIt && (! DebugPlugin_isPipBusy));
  assign DebugPlugin_allowEBreak = (DebugPlugin_debugUsed && (! DebugPlugin_disableEbreak));
  always @(*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            debug_bus_cmd_ready = IBusSimplePlugin_injectionPort_ready;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if(when_DebugPlugin_l244) begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign when_DebugPlugin_l244 = (! _zz_when_DebugPlugin_l244);
  always @(*) begin
    IBusSimplePlugin_injectionPort_valid = 1'b0;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            IBusSimplePlugin_injectionPort_valid = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusSimplePlugin_injectionPort_payload = debug_bus_cmd_payload_data;
  assign switch_DebugPlugin_l256 = debug_bus_cmd_payload_address[7 : 2];
  assign when_DebugPlugin_l260 = debug_bus_cmd_payload_data[16];
  assign when_DebugPlugin_l260_1 = debug_bus_cmd_payload_data[24];
  assign when_DebugPlugin_l261 = debug_bus_cmd_payload_data[17];
  assign when_DebugPlugin_l261_1 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l262 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l263 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l264 = debug_bus_cmd_payload_data[18];
  assign when_DebugPlugin_l264_1 = debug_bus_cmd_payload_data[26];
  assign when_DebugPlugin_l284 = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign when_DebugPlugin_l287 = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) == 1'b0);
  assign when_DebugPlugin_l300 = (DebugPlugin_stepIt && IBusSimplePlugin_incomingInstruction);
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign when_DebugPlugin_l316 = (DebugPlugin_haltIt || DebugPlugin_stepIt);
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_2 = ((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack));
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_7 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_8 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
  assign when_Pipeline_l124_9 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_11 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_12 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
  assign when_Pipeline_l124_13 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_14 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_15 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_16 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_17 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_18 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_19 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_20 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_21 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_22 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_23 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_24 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
  assign when_Pipeline_l124_25 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
  assign when_Pipeline_l124_26 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
  assign when_Pipeline_l124_27 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
  assign _zz_execute_to_memory_SHIFT_CTRL_1 = execute_SHIFT_CTRL;
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
  assign when_Pipeline_l124_28 = (! execute_arbitration_isStuck);
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
  assign when_Pipeline_l124_29 = (! memory_arbitration_isStuck);
  assign _zz_memory_SHIFT_CTRL = execute_to_memory_SHIFT_CTRL;
  assign when_Pipeline_l124_30 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_31 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_32 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_33 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_34 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_35 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_36 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_37 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL;
  assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL;
  assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL;
  assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1;
  assign when_Pipeline_l124_38 = (! execute_arbitration_isStuck);
  assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL;
  assign when_Pipeline_l124_39 = (! memory_arbitration_isStuck);
  assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL;
  assign when_Pipeline_l124_40 = (! writeBack_arbitration_isStuck);
  assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
  assign when_Pipeline_l124_41 = (! execute_arbitration_isStuck);
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
  assign when_Pipeline_l124_42 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND_1 = decode_CfuPlugin_CFU_INPUT_2_KIND;
  assign _zz_decode_CfuPlugin_CFU_INPUT_2_KIND = _zz_decode_CfuPlugin_CFU_INPUT_2_KIND_1;
  assign when_Pipeline_l124_43 = (! execute_arbitration_isStuck);
  assign _zz_execute_CfuPlugin_CFU_INPUT_2_KIND = decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND;
  assign when_Pipeline_l124_44 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_45 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_46 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_47 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_48 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_49 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_50 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_51 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_52 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_53 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_54 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_55 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_56 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_57 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_58 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_59 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_60 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_61 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_62 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_63 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_64 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_65 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_66 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_67 = (! writeBack_arbitration_isStuck);
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != 3'b000) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != 4'b0000));
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != 2'b00) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != 3'b000));
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != 1'b0) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != 2'b00));
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != 1'b0));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt);
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt);
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  always @(*) begin
    IBusSimplePlugin_injectionPort_ready = 1'b0;
    case(switch_Fetcher_l362)
      3'b100 : begin
        IBusSimplePlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign when_Fetcher_l378 = (! decode_arbitration_isStuck);
  assign when_Fetcher_l398 = (switch_Fetcher_l362 != 3'b000);
  assign when_CsrPlugin_l1264 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_2 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_3 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_4 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_5 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_6 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_7 = (! execute_arbitration_isStuck);
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit = 32'h0;
    if(execute_CsrPlugin_csr_768) begin
      _zz_CsrPlugin_csrMapping_readDataInit[12 : 11] = CsrPlugin_mstatus_MPP;
      _zz_CsrPlugin_csrMapping_readDataInit[7 : 7] = CsrPlugin_mstatus_MPIE;
      _zz_CsrPlugin_csrMapping_readDataInit[3 : 3] = CsrPlugin_mstatus_MIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h0;
    if(execute_CsrPlugin_csr_836) begin
      _zz_CsrPlugin_csrMapping_readDataInit_1[11 : 11] = CsrPlugin_mip_MEIP;
      _zz_CsrPlugin_csrMapping_readDataInit_1[7 : 7] = CsrPlugin_mip_MTIP;
      _zz_CsrPlugin_csrMapping_readDataInit_1[3 : 3] = CsrPlugin_mip_MSIP;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h0;
    if(execute_CsrPlugin_csr_772) begin
      _zz_CsrPlugin_csrMapping_readDataInit_2[11 : 11] = CsrPlugin_mie_MEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_2[7 : 7] = CsrPlugin_mie_MTIE;
      _zz_CsrPlugin_csrMapping_readDataInit_2[3 : 3] = CsrPlugin_mie_MSIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h0;
    if(execute_CsrPlugin_csr_773) begin
      _zz_CsrPlugin_csrMapping_readDataInit_3[31 : 2] = CsrPlugin_mtvec_base;
      _zz_CsrPlugin_csrMapping_readDataInit_3[1 : 0] = CsrPlugin_mtvec_mode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h0;
    if(execute_CsrPlugin_csr_833) begin
      _zz_CsrPlugin_csrMapping_readDataInit_4[31 : 0] = CsrPlugin_mepc;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h0;
    if(execute_CsrPlugin_csr_834) begin
      _zz_CsrPlugin_csrMapping_readDataInit_5[31 : 31] = CsrPlugin_mcause_interrupt;
      _zz_CsrPlugin_csrMapping_readDataInit_5[3 : 0] = CsrPlugin_mcause_exceptionCode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h0;
    if(execute_CsrPlugin_csr_835) begin
      _zz_CsrPlugin_csrMapping_readDataInit_6[31 : 0] = CsrPlugin_mtval;
    end
  end

  assign CsrPlugin_csrMapping_readDataInit = (((32'h0 | _zz_CsrPlugin_csrMapping_readDataInit) | (_zz_CsrPlugin_csrMapping_readDataInit_1 | _zz_CsrPlugin_csrMapping_readDataInit_2)) | ((_zz_CsrPlugin_csrMapping_readDataInit_3 | _zz_CsrPlugin_csrMapping_readDataInit_4) | (_zz_CsrPlugin_csrMapping_readDataInit_5 | _zz_CsrPlugin_csrMapping_readDataInit_6)));
  assign when_CsrPlugin_l1297 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]);
  assign when_CsrPlugin_l1302 = ((! execute_arbitration_isValid) || (! execute_IS_CSR));
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      IBusSimplePlugin_fetchPc_pcReg <= 32'hf9000000;
      IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2 <= 1'b0;
      _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid <= 1'b0;
      _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_5 <= 1'b0;
      IBusSimplePlugin_pending_value <= 3'b000;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= 3'b000;
      _zz_2 <= 1'b1;
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
      memory_MulDivIterativePlugin_div_counter_value <= 6'h0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= 2'b11;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      execute_CfuPlugin_hold <= 1'b0;
      execute_CfuPlugin_fired <= 1'b0;
      CfuPlugin_bus_rsp_rValid <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      switch_Fetcher_l362 <= 3'b000;
      memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT <= 1'b0;
      execute_to_memory_CfuPlugin_CFU_IN_FLIGHT <= 1'b0;
    end else begin
      if(IBusSimplePlugin_fetchPc_correction) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b1;
      end
      if(IBusSimplePlugin_fetchPc_output_fire) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if(when_Fetcher_l131) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_output_fire_1) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(when_Fetcher_l131_1) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l158) begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if(IBusSimplePlugin_iBusRsp_flush) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2 <= 1'b0;
      end
      if(_zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2 <= (IBusSimplePlugin_iBusRsp_stages_0_output_valid && (! 1'b0));
      end
      if(IBusSimplePlugin_iBusRsp_flush) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid <= 1'b0;
      end
      if(IBusSimplePlugin_iBusRsp_stages_1_output_ready) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_valid <= (IBusSimplePlugin_iBusRsp_stages_1_output_valid && (! IBusSimplePlugin_iBusRsp_flush));
      end
      if(decode_arbitration_removeIt) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      end
      if(IBusSimplePlugin_iBusRsp_output_ready) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= (IBusSimplePlugin_iBusRsp_output_valid && (! IBusSimplePlugin_externalFlush));
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if(when_Fetcher_l329) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(when_Fetcher_l329_1) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(when_Fetcher_l329_2) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(when_Fetcher_l329_3) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(when_Fetcher_l329_4) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= IBusSimplePlugin_injector_nextPcCalc_valids_3;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_5 <= 1'b0;
      end
      if(when_Fetcher_l329_5) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_5 <= IBusSimplePlugin_injector_nextPcCalc_valids_4;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_5 <= 1'b0;
      end
      IBusSimplePlugin_pending_value <= IBusSimplePlugin_pending_next;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter - _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter);
      if(IBusSimplePlugin_iBusRsp_flush) begin
        IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_pending_value - _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2);
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck)));
        `else
          if(!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
            $display("FAILURE DBusSimplePlugin doesn't allow memory stage stall when read happend");
            $finish;
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck)));
        `else
          if(!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck))) begin
            $display("FAILURE DBusSimplePlugin doesn't allow writeback stage stall when read happend");
            $finish;
          end
        `endif
      `endif
      _zz_2 <= 1'b0;
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
      memory_MulDivIterativePlugin_div_counter_value <= memory_MulDivIterativePlugin_div_counter_valueNext;
      if(when_CsrPlugin_l909) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if(when_CsrPlugin_l909_1) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if(when_CsrPlugin_l909_2) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if(when_CsrPlugin_l909_3) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(when_CsrPlugin_l946) begin
        if(when_CsrPlugin_l952) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l952_1) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l952_2) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      if(CsrPlugin_pipelineLiberator_active) begin
        if(when_CsrPlugin_l980) begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
        end
        if(when_CsrPlugin_l980_1) begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
        end
        if(when_CsrPlugin_l980_2) begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
        end
      end
      if(when_CsrPlugin_l985) begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      end
      if(CsrPlugin_interruptJump) begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(when_CsrPlugin_l1019) begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(when_CsrPlugin_l1064) begin
        case(switch_CsrPlugin_l1068)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00;
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= (({_zz_when_CsrPlugin_l952_2,{_zz_when_CsrPlugin_l952_1,_zz_when_CsrPlugin_l952}} != 3'b000) || CsrPlugin_thirdPartyWake);
      if(execute_CfuPlugin_schedule) begin
        execute_CfuPlugin_hold <= 1'b1;
      end
      if(CfuPlugin_bus_cmd_ready) begin
        execute_CfuPlugin_hold <= 1'b0;
      end
      if(CfuPlugin_bus_cmd_fire) begin
        execute_CfuPlugin_fired <= 1'b1;
      end
      if(when_CfuPlugin_l175) begin
        execute_CfuPlugin_fired <= 1'b0;
      end
      if(CfuPlugin_bus_rsp_valid) begin
        CfuPlugin_bus_rsp_rValid <= 1'b1;
      end
      if(CfuPlugin_bus_rsp_rsp_ready) begin
        CfuPlugin_bus_rsp_rValid <= 1'b0;
      end
      if(when_Pipeline_l124_64) begin
        execute_to_memory_CfuPlugin_CFU_IN_FLIGHT <= _zz_execute_to_memory_CfuPlugin_CFU_IN_FLIGHT;
      end
      if(when_Pipeline_l124_65) begin
        memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT <= _zz_memory_to_writeBack_CfuPlugin_CFU_IN_FLIGHT;
      end
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(switch_Fetcher_l362)
        3'b000 : begin
          if(IBusSimplePlugin_injectionPort_valid) begin
            switch_Fetcher_l362 <= 3'b001;
          end
        end
        3'b001 : begin
          switch_Fetcher_l362 <= 3'b010;
        end
        3'b010 : begin
          switch_Fetcher_l362 <= 3'b011;
        end
        3'b011 : begin
          if(when_Fetcher_l378) begin
            switch_Fetcher_l362 <= 3'b100;
          end
        end
        3'b100 : begin
          switch_Fetcher_l362 <= 3'b000;
        end
        default : begin
        end
      endcase
      if(execute_CsrPlugin_csr_768) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mstatus_MPP <= CsrPlugin_csrMapping_writeDataSignal[12 : 11];
          CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
      if(execute_CsrPlugin_csr_772) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11];
          CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(IBusSimplePlugin_iBusRsp_stages_1_output_ready) begin
      _zz_IBusSimplePlugin_iBusRsp_stages_1_output_m2sPipe_payload <= IBusSimplePlugin_iBusRsp_stages_1_output_payload;
    end
    if(IBusSimplePlugin_iBusRsp_output_ready) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_pc <= IBusSimplePlugin_iBusRsp_output_payload_pc;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error <= IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc <= IBusSimplePlugin_iBusRsp_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready) begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
    execute_MulPlugin_delayLogic_counter <= (execute_MulPlugin_delayLogic_counter + 1'b1);
    if(when_MulPlugin_l70) begin
      execute_MulPlugin_delayLogic_counter <= 1'b0;
    end
    execute_MulPlugin_withOuputBuffer_mul_ll <= (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
    execute_MulPlugin_withOuputBuffer_mul_lh <= ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
    execute_MulPlugin_withOuputBuffer_mul_hl <= ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
    execute_MulPlugin_withOuputBuffer_mul_hh <= ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
    if(when_MulDivIterativePlugin_l126) begin
      memory_MulDivIterativePlugin_div_done <= 1'b1;
    end
    if(when_MulDivIterativePlugin_l126_1) begin
      memory_MulDivIterativePlugin_div_done <= 1'b0;
    end
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l132) begin
        memory_MulDivIterativePlugin_rs1[31 : 0] <= memory_MulDivIterativePlugin_div_stage_0_outNumerator;
        memory_MulDivIterativePlugin_accumulator[31 : 0] <= memory_MulDivIterativePlugin_div_stage_0_outRemainder;
        if(when_MulDivIterativePlugin_l151) begin
          memory_MulDivIterativePlugin_div_result <= _zz_memory_MulDivIterativePlugin_div_result_1[31:0];
        end
      end
    end
    if(when_MulDivIterativePlugin_l162) begin
      memory_MulDivIterativePlugin_accumulator <= 65'h0;
      memory_MulDivIterativePlugin_rs1 <= ((_zz_memory_MulDivIterativePlugin_rs1 ? (~ _zz_memory_MulDivIterativePlugin_rs1_1) : _zz_memory_MulDivIterativePlugin_rs1_1) + _zz_memory_MulDivIterativePlugin_rs1_2);
      memory_MulDivIterativePlugin_rs2 <= ((_zz_memory_MulDivIterativePlugin_rs2 ? (~ execute_RS2) : execute_RS2) + _zz_memory_MulDivIterativePlugin_rs2_1);
      memory_MulDivIterativePlugin_div_needRevert <= ((_zz_memory_MulDivIterativePlugin_rs1 ^ (_zz_memory_MulDivIterativePlugin_rs2 && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == 32'h0) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + 64'h0000000000000001);
    if(writeBack_arbitration_isFiring) begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001);
    end
    if(decodeExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= decodeExceptionPort_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= decodeExceptionPort_payload_badAddr;
    end
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(BranchPlugin_branchExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= BranchPlugin_branchExceptionPort_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= BranchPlugin_branchExceptionPort_payload_badAddr;
    end
    if(when_CsrPlugin_l946) begin
      if(when_CsrPlugin_l952) begin
        CsrPlugin_interrupt_code <= 4'b0111;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l952_1) begin
        CsrPlugin_interrupt_code <= 4'b0011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l952_2) begin
        CsrPlugin_interrupt_code <= 4'b1011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
    end
    if(when_CsrPlugin_l1019) begin
      case(CsrPlugin_targetPrivilege)
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mepc <= writeBack_PC;
          if(CsrPlugin_hadException) begin
            CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        default : begin
        end
      endcase
    end
    if(CfuPlugin_bus_rsp_ready) begin
      CfuPlugin_bus_rsp_rData_outputs_0 <= CfuPlugin_bus_rsp_payload_outputs_0;
    end
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= _zz_decode_SRC2;
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= execute_PC;
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_7) begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_8) begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_memory_to_writeBack_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_9) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_11) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_12) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_13) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_14) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_15) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_16) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if(when_Pipeline_l124_17) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_18) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_19) begin
      decode_to_execute_MEMORY_STORE <= decode_MEMORY_STORE;
    end
    if(when_Pipeline_l124_20) begin
      execute_to_memory_MEMORY_STORE <= execute_MEMORY_STORE;
    end
    if(when_Pipeline_l124_21) begin
      memory_to_writeBack_MEMORY_STORE <= memory_MEMORY_STORE;
    end
    if(when_Pipeline_l124_22) begin
      decode_to_execute_HAS_SIDE_EFFECT <= decode_HAS_SIDE_EFFECT;
    end
    if(when_Pipeline_l124_23) begin
      execute_to_memory_HAS_SIDE_EFFECT <= execute_HAS_SIDE_EFFECT;
    end
    if(when_Pipeline_l124_24) begin
      memory_to_writeBack_HAS_SIDE_EFFECT <= memory_HAS_SIDE_EFFECT;
    end
    if(when_Pipeline_l124_25) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
    end
    if(when_Pipeline_l124_26) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if(when_Pipeline_l124_27) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
    end
    if(when_Pipeline_l124_28) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_29) begin
      execute_to_memory_SHIFT_CTRL <= _zz_execute_to_memory_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_30) begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if(when_Pipeline_l124_31) begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if(when_Pipeline_l124_32) begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if(when_Pipeline_l124_33) begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if(when_Pipeline_l124_34) begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if(when_Pipeline_l124_35) begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if(when_Pipeline_l124_36) begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if(when_Pipeline_l124_37) begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if(when_Pipeline_l124_38) begin
      decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL;
    end
    if(when_Pipeline_l124_39) begin
      execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL;
    end
    if(when_Pipeline_l124_40) begin
      memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL;
    end
    if(when_Pipeline_l124_41) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
    end
    if(when_Pipeline_l124_42) begin
      decode_to_execute_CfuPlugin_CFU_ENABLE <= decode_CfuPlugin_CFU_ENABLE;
    end
    if(when_Pipeline_l124_43) begin
      decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND <= _zz_decode_to_execute_CfuPlugin_CFU_INPUT_2_KIND;
    end
    if(when_Pipeline_l124_44) begin
      decode_to_execute_RS1 <= _zz_decode_SRC1;
    end
    if(when_Pipeline_l124_45) begin
      decode_to_execute_RS2 <= _zz_decode_SRC2_1;
    end
    if(when_Pipeline_l124_46) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if(when_Pipeline_l124_47) begin
      decode_to_execute_SRC1 <= decode_SRC1;
    end
    if(when_Pipeline_l124_48) begin
      decode_to_execute_SRC2 <= decode_SRC2;
    end
    if(when_Pipeline_l124_49) begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if(when_Pipeline_l124_50) begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if(when_Pipeline_l124_51) begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if(when_Pipeline_l124_52) begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_53) begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_54) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2;
    end
    if(when_Pipeline_l124_55) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2_1;
    end
    if(when_Pipeline_l124_56) begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if(when_Pipeline_l124_57) begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if(when_Pipeline_l124_58) begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if(when_Pipeline_l124_59) begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if(when_Pipeline_l124_60) begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if(when_Pipeline_l124_61) begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if(when_Pipeline_l124_62) begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if(when_Pipeline_l124_63) begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if(when_Pipeline_l124_66) begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if(when_Pipeline_l124_67) begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if(when_Fetcher_l398) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= IBusSimplePlugin_injectionPort_payload;
    end
    if(when_CsrPlugin_l1264) begin
      execute_CsrPlugin_csr_3860 <= (decode_INSTRUCTION[31 : 20] == 12'hf14);
    end
    if(when_CsrPlugin_l1264_1) begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300);
    end
    if(when_CsrPlugin_l1264_2) begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344);
    end
    if(when_CsrPlugin_l1264_3) begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304);
    end
    if(when_CsrPlugin_l1264_4) begin
      execute_CsrPlugin_csr_773 <= (decode_INSTRUCTION[31 : 20] == 12'h305);
    end
    if(when_CsrPlugin_l1264_5) begin
      execute_CsrPlugin_csr_833 <= (decode_INSTRUCTION[31 : 20] == 12'h341);
    end
    if(when_CsrPlugin_l1264_6) begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342);
    end
    if(when_CsrPlugin_l1264_7) begin
      execute_CsrPlugin_csr_835 <= (decode_INSTRUCTION[31 : 20] == 12'h343);
    end
    if(execute_CsrPlugin_csr_836) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3];
      end
    end
    if(execute_CsrPlugin_csr_773) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mtvec_base <= CsrPlugin_csrMapping_writeDataSignal[31 : 2];
        CsrPlugin_mtvec_mode <= CsrPlugin_csrMapping_writeDataSignal[1 : 0];
      end
    end
    if(execute_CsrPlugin_csr_833) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mepc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
  end

  always @(posedge io_systemClk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready) begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= (({writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}} != 4'b0000) || IBusSimplePlugin_incomingInstruction);
    if(writeBack_arbitration_isValid) begin
      DebugPlugin_busReadDataReg <= _zz_decode_RS2_2;
    end
    _zz_when_DebugPlugin_l244 <= debug_bus_cmd_payload_address[2];
    if(when_DebugPlugin_l284) begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
  end

  always @(posedge io_systemClk) begin
    if(debugCd_logic_outputReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_godmode <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
      DebugPlugin_debugUsed <= 1'b0;
      DebugPlugin_disableEbreak <= 1'b0;
    end else begin
      if(when_DebugPlugin_l225) begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        DebugPlugin_debugUsed <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        case(switch_DebugPlugin_l256)
          6'h0 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(when_DebugPlugin_l260) begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(when_DebugPlugin_l260_1) begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(when_DebugPlugin_l261) begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(when_DebugPlugin_l261_1) begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(when_DebugPlugin_l262) begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
              if(when_DebugPlugin_l263) begin
                DebugPlugin_godmode <= 1'b0;
              end
              if(when_DebugPlugin_l264) begin
                DebugPlugin_disableEbreak <= 1'b1;
              end
              if(when_DebugPlugin_l264_1) begin
                DebugPlugin_disableEbreak <= 1'b0;
              end
            end
          end
          default : begin
          end
        endcase
      end
      if(when_DebugPlugin_l284) begin
        if(when_DebugPlugin_l287) begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(when_DebugPlugin_l300) begin
        if(decode_arbitration_isValid) begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
    end
  end


endmodule

module BufferCC_3 (
  input               io_dataIn,
  output              io_dataOut,
  input               io_systemClk,
  input               debugCd_logic_outputReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_systemClk or posedge debugCd_logic_outputReset) begin
    if(debugCd_logic_outputReset) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module SystemDebugger (
  input               io_remote_cmd_valid,
  output              io_remote_cmd_ready,
  input               io_remote_cmd_payload_last,
  input      [0:0]    io_remote_cmd_payload_fragment,
  output              io_remote_rsp_valid,
  input               io_remote_rsp_ready,
  output              io_remote_rsp_payload_error,
  output     [31:0]   io_remote_rsp_payload_data,
  output              io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output     [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output              io_mem_cmd_payload_wr,
  output     [1:0]    io_mem_cmd_payload_size,
  input               io_mem_rsp_valid,
  input      [31:0]   io_mem_rsp_payload,
  input               io_systemClk,
  input               debugCd_logic_outputReset
);

  reg        [66:0]   dispatcher_dataShifter;
  reg                 dispatcher_dataLoaded;
  reg        [7:0]    dispatcher_headerShifter;
  wire       [7:0]    dispatcher_header;
  reg                 dispatcher_headerLoaded;
  reg        [2:0]    dispatcher_counter;
  wire                when_Fragment_l346;
  wire                when_Fragment_l349;
  wire       [66:0]   _zz_io_mem_cmd_payload_address;
  wire                io_mem_cmd_isStall;
  wire                when_Fragment_l372;

  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign when_Fragment_l346 = (dispatcher_headerLoaded == 1'b0);
  assign when_Fragment_l349 = (dispatcher_counter == 3'b111);
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_io_mem_cmd_payload_address = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_io_mem_cmd_payload_address[31 : 0];
  assign io_mem_cmd_payload_data = _zz_io_mem_cmd_payload_address[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_io_mem_cmd_payload_address[64];
  assign io_mem_cmd_payload_size = _zz_io_mem_cmd_payload_address[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == 8'h0));
  assign io_mem_cmd_isStall = (io_mem_cmd_valid && (! io_mem_cmd_ready));
  assign when_Fragment_l372 = ((dispatcher_headerLoaded && dispatcher_dataLoaded) && (! io_mem_cmd_isStall));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @(posedge io_systemClk) begin
    if(debugCd_logic_outputReset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= 3'b000;
    end else begin
      if(io_remote_cmd_valid) begin
        if(when_Fragment_l346) begin
          dispatcher_counter <= (dispatcher_counter + 3'b001);
          if(when_Fragment_l349) begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last) begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= 3'b000;
        end
      end
      if(when_Fragment_l372) begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(io_remote_cmd_valid) begin
      if(when_Fragment_l346) begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end


endmodule

module BufferCC_2 (
  input               io_dataIn,
  output              io_dataOut,
  input               io_systemClk,
  input               io_asyncReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_systemClk or posedge io_asyncReset) begin
    if(io_asyncReset) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module JtagBridgeNoTap (
  input               io_ctrl_tdi,
  input               io_ctrl_enable,
  input               io_ctrl_capture,
  input               io_ctrl_shift,
  input               io_ctrl_update,
  input               io_ctrl_reset,
  output              io_ctrl_tdo,
  output              io_remote_cmd_valid,
  input               io_remote_cmd_ready,
  output              io_remote_cmd_payload_last,
  output     [0:0]    io_remote_cmd_payload_fragment,
  input               io_remote_rsp_valid,
  output              io_remote_rsp_ready,
  input               io_remote_rsp_payload_error,
  input      [31:0]   io_remote_rsp_payload_data,
  input               io_systemClk,
  input               debugCd_logic_outputReset,
  input               jtagCtrl_tck
);

  wire                flowCCByToggle_1_io_output_valid;
  wire                flowCCByToggle_1_io_output_payload_last;
  wire       [0:0]    flowCCByToggle_1_io_output_payload_fragment;
  wire                system_cmd_valid;
  wire                system_cmd_payload_last;
  wire       [0:0]    system_cmd_payload_fragment;
  (* async_reg = "true" *) reg                 system_rsp_valid;
  (* async_reg = "true" *) reg                 system_rsp_payload_error;
  (* async_reg = "true" *) reg        [31:0]   system_rsp_payload_data;
  wire                io_remote_rsp_fire;
  wire                jtag_wrapper_ctrl_tdi;
  wire                jtag_wrapper_ctrl_enable;
  wire                jtag_wrapper_ctrl_capture;
  wire                jtag_wrapper_ctrl_shift;
  wire                jtag_wrapper_ctrl_update;
  wire                jtag_wrapper_ctrl_reset;
  reg                 jtag_wrapper_ctrl_tdo;
  reg        [1:0]    jtag_wrapper_header;
  wire       [1:0]    jtag_wrapper_headerNext;
  reg        [0:0]    jtag_wrapper_counter;
  reg                 jtag_wrapper_done;
  reg                 jtag_wrapper_sendCapture;
  reg                 jtag_wrapper_sendShift;
  reg                 jtag_wrapper_sendUpdate;
  wire                when_JtagTapInstructions_l159;
  wire                when_JtagTapInstructions_l162;
  wire                jtag_writeArea_ctrl_tdi;
  wire                jtag_writeArea_ctrl_enable;
  wire                jtag_writeArea_ctrl_capture;
  wire                jtag_writeArea_ctrl_shift;
  wire                jtag_writeArea_ctrl_update;
  wire                jtag_writeArea_ctrl_reset;
  wire                jtag_writeArea_ctrl_tdo;
  wire                jtag_writeArea_source_valid;
  wire                jtag_writeArea_source_payload_last;
  wire       [0:0]    jtag_writeArea_source_payload_fragment;
  reg                 jtag_writeArea_valid;
  reg                 jtag_writeArea_data;
  wire                when_JtagTapInstructions_l185;
  wire                jtag_readArea_ctrl_tdi;
  wire                jtag_readArea_ctrl_enable;
  wire                jtag_readArea_ctrl_capture;
  wire                jtag_readArea_ctrl_shift;
  wire                jtag_readArea_ctrl_update;
  wire                jtag_readArea_ctrl_reset;
  wire                jtag_readArea_ctrl_tdo;
  reg        [33:0]   jtag_readArea_full_shifter;
  wire                when_JtagTapInstructions_l185_1;

  FlowCCByToggle flowCCByToggle_1 (
    .io_input_valid                (jtag_writeArea_source_valid                  ), //i
    .io_input_payload_last         (jtag_writeArea_source_payload_last           ), //i
    .io_input_payload_fragment     (jtag_writeArea_source_payload_fragment       ), //i
    .io_output_valid               (flowCCByToggle_1_io_output_valid             ), //o
    .io_output_payload_last        (flowCCByToggle_1_io_output_payload_last      ), //o
    .io_output_payload_fragment    (flowCCByToggle_1_io_output_payload_fragment  ), //o
    .jtagCtrl_tck                  (jtagCtrl_tck                                 ), //i
    .io_systemClk                  (io_systemClk                                 ), //i
    .debugCd_logic_outputReset     (debugCd_logic_outputReset                    )  //i
  );
  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_rsp_fire = (io_remote_rsp_valid && io_remote_rsp_ready);
  assign io_remote_rsp_ready = 1'b1;
  assign jtag_wrapper_headerNext = ({jtag_wrapper_ctrl_tdi,jtag_wrapper_header} >>> 1);
  always @(*) begin
    jtag_wrapper_sendCapture = 1'b0;
    if(jtag_wrapper_ctrl_enable) begin
      if(jtag_wrapper_ctrl_shift) begin
        if(when_JtagTapInstructions_l159) begin
          if(when_JtagTapInstructions_l162) begin
            jtag_wrapper_sendCapture = 1'b1;
          end
        end
      end
    end
  end

  always @(*) begin
    jtag_wrapper_sendShift = 1'b0;
    if(jtag_wrapper_ctrl_enable) begin
      if(jtag_wrapper_ctrl_shift) begin
        if(!when_JtagTapInstructions_l159) begin
          jtag_wrapper_sendShift = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    jtag_wrapper_sendUpdate = 1'b0;
    if(jtag_wrapper_ctrl_enable) begin
      if(jtag_wrapper_ctrl_update) begin
        jtag_wrapper_sendUpdate = 1'b1;
      end
    end
  end

  assign when_JtagTapInstructions_l159 = (! jtag_wrapper_done);
  assign when_JtagTapInstructions_l162 = (jtag_wrapper_counter == 1'b1);
  always @(*) begin
    jtag_wrapper_ctrl_tdo = 1'b0;
    if(when_JtagTapInstructions_l185) begin
      jtag_wrapper_ctrl_tdo = jtag_writeArea_ctrl_tdo;
    end
    if(when_JtagTapInstructions_l185_1) begin
      jtag_wrapper_ctrl_tdo = jtag_readArea_ctrl_tdo;
    end
  end

  assign jtag_wrapper_ctrl_tdi = io_ctrl_tdi;
  assign jtag_wrapper_ctrl_enable = io_ctrl_enable;
  assign jtag_wrapper_ctrl_capture = io_ctrl_capture;
  assign jtag_wrapper_ctrl_shift = io_ctrl_shift;
  assign jtag_wrapper_ctrl_update = io_ctrl_update;
  assign jtag_wrapper_ctrl_reset = io_ctrl_reset;
  assign io_ctrl_tdo = jtag_wrapper_ctrl_tdo;
  assign jtag_writeArea_source_valid = jtag_writeArea_valid;
  assign jtag_writeArea_source_payload_last = (! (jtag_writeArea_ctrl_enable && jtag_writeArea_ctrl_shift));
  assign jtag_writeArea_source_payload_fragment[0] = jtag_writeArea_data;
  assign system_cmd_valid = flowCCByToggle_1_io_output_valid;
  assign system_cmd_payload_last = flowCCByToggle_1_io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCByToggle_1_io_output_payload_fragment;
  assign jtag_writeArea_ctrl_tdo = 1'b0;
  assign when_JtagTapInstructions_l185 = (jtag_wrapper_header == 2'b00);
  assign jtag_writeArea_ctrl_tdi = jtag_wrapper_ctrl_tdi;
  assign jtag_writeArea_ctrl_enable = 1'b1;
  assign jtag_writeArea_ctrl_capture = ((jtag_wrapper_headerNext == 2'b00) && jtag_wrapper_sendCapture);
  assign jtag_writeArea_ctrl_shift = (when_JtagTapInstructions_l185 && jtag_wrapper_sendShift);
  assign jtag_writeArea_ctrl_update = (when_JtagTapInstructions_l185 && jtag_wrapper_sendUpdate);
  assign jtag_writeArea_ctrl_reset = jtag_wrapper_ctrl_reset;
  assign jtag_readArea_ctrl_tdo = jtag_readArea_full_shifter[0];
  assign when_JtagTapInstructions_l185_1 = (jtag_wrapper_header == 2'b01);
  assign jtag_readArea_ctrl_tdi = jtag_wrapper_ctrl_tdi;
  assign jtag_readArea_ctrl_enable = 1'b1;
  assign jtag_readArea_ctrl_capture = ((jtag_wrapper_headerNext == 2'b01) && jtag_wrapper_sendCapture);
  assign jtag_readArea_ctrl_shift = (when_JtagTapInstructions_l185_1 && jtag_wrapper_sendShift);
  assign jtag_readArea_ctrl_update = (when_JtagTapInstructions_l185_1 && jtag_wrapper_sendUpdate);
  assign jtag_readArea_ctrl_reset = jtag_wrapper_ctrl_reset;
  always @(posedge io_systemClk) begin
    if(io_remote_cmd_valid) begin
      system_rsp_valid <= 1'b0;
    end
    if(io_remote_rsp_fire) begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @(posedge jtagCtrl_tck) begin
    if(jtag_wrapper_ctrl_enable) begin
      if(jtag_wrapper_ctrl_capture) begin
        jtag_wrapper_done <= 1'b0;
        jtag_wrapper_counter <= 1'b0;
      end
      if(jtag_wrapper_ctrl_shift) begin
        if(when_JtagTapInstructions_l159) begin
          jtag_wrapper_counter <= (jtag_wrapper_counter + 1'b1);
          jtag_wrapper_header <= jtag_wrapper_headerNext;
          if(when_JtagTapInstructions_l162) begin
            jtag_wrapper_done <= 1'b1;
          end
        end
      end
    end
    jtag_writeArea_valid <= (jtag_writeArea_ctrl_enable && jtag_writeArea_ctrl_shift);
    jtag_writeArea_data <= jtag_writeArea_ctrl_tdi;
    if(jtag_readArea_ctrl_enable) begin
      if(jtag_readArea_ctrl_capture) begin
        jtag_readArea_full_shifter <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if(jtag_readArea_ctrl_shift) begin
        jtag_readArea_full_shifter <= ({jtag_readArea_ctrl_tdi,jtag_readArea_full_shifter} >>> 1);
      end
    end
  end


endmodule

module StreamFifo_3 (
  input               io_push_valid,
  output              io_push_ready,
  input      [7:0]    io_push_payload_data,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [7:0]    io_pop_payload_data,
  input               io_flush,
  output     [8:0]    io_occupancy,
  output     [8:0]    io_availability,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  reg        [7:0]    _zz_logic_ram_port0;
  wire       [7:0]    _zz_logic_pushPtr_valueNext;
  wire       [0:0]    _zz_logic_pushPtr_valueNext_1;
  wire       [7:0]    _zz_logic_popPtr_valueNext;
  wire       [0:0]    _zz_logic_popPtr_valueNext_1;
  wire                _zz_logic_ram_port;
  wire                _zz_io_pop_payload_data;
  wire       [7:0]    _zz_io_availability;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [7:0]    logic_pushPtr_valueNext;
  reg        [7:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [7:0]    logic_popPtr_valueNext;
  reg        [7:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_io_pop_valid;
  wire                when_Stream_l935;
  wire       [7:0]    logic_ptrDif;
  reg [7:0] logic_ram [0:255];

  assign _zz_logic_pushPtr_valueNext_1 = logic_pushPtr_willIncrement;
  assign _zz_logic_pushPtr_valueNext = {7'd0, _zz_logic_pushPtr_valueNext_1};
  assign _zz_logic_popPtr_valueNext_1 = logic_popPtr_willIncrement;
  assign _zz_logic_popPtr_valueNext = {7'd0, _zz_logic_popPtr_valueNext_1};
  assign _zz_io_availability = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_io_pop_payload_data = 1'b1;
  always @(posedge io_systemClk) begin
    if(_zz_io_pop_payload_data) begin
      _zz_logic_ram_port0 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload_data;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_pushing) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing) begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 8'hff);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @(*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_logic_pushPtr_valueNext);
    if(logic_pushPtr_willClear) begin
      logic_pushPtr_valueNext = 8'h0;
    end
  end

  always @(*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping) begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 8'hff);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @(*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_logic_popPtr_valueNext);
    if(logic_popPtr_willClear) begin
      logic_popPtr_valueNext = 8'h0;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_io_pop_valid && (! logic_full))));
  assign io_pop_payload_data = _zz_logic_ram_port0[7 : 0];
  assign when_Stream_l935 = (logic_pushing != logic_popping);
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_io_availability};
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      logic_pushPtr_value <= 8'h0;
      logic_popPtr_value <= 8'h0;
      logic_risingOccupancy <= 1'b0;
      _zz_io_pop_valid <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_io_pop_valid <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if(when_Stream_l935) begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush) begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module StreamFifo_2 (
  input               io_push_valid,
  output              io_push_ready,
  input               io_push_payload_kind,
  input               io_push_payload_read,
  input               io_push_payload_write,
  input      [7:0]    io_push_payload_data,
  output              io_pop_valid,
  input               io_pop_ready,
  output              io_pop_payload_kind,
  output              io_pop_payload_read,
  output              io_pop_payload_write,
  output     [7:0]    io_pop_payload_data,
  input               io_flush,
  output     [8:0]    io_occupancy,
  output     [8:0]    io_availability,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  reg        [10:0]   _zz_logic_ram_port0;
  wire       [7:0]    _zz_logic_pushPtr_valueNext;
  wire       [0:0]    _zz_logic_pushPtr_valueNext_1;
  wire       [7:0]    _zz_logic_popPtr_valueNext;
  wire       [0:0]    _zz_logic_popPtr_valueNext_1;
  wire                _zz_logic_ram_port;
  wire                _zz__zz_io_pop_payload_kind;
  wire       [10:0]   _zz_logic_ram_port_1;
  wire       [7:0]    _zz_io_availability;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [7:0]    logic_pushPtr_valueNext;
  reg        [7:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [7:0]    logic_popPtr_valueNext;
  reg        [7:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_io_pop_valid;
  wire       [10:0]   _zz_io_pop_payload_kind;
  wire                when_Stream_l935;
  wire       [7:0]    logic_ptrDif;
  reg [10:0] logic_ram [0:255];

  assign _zz_logic_pushPtr_valueNext_1 = logic_pushPtr_willIncrement;
  assign _zz_logic_pushPtr_valueNext = {7'd0, _zz_logic_pushPtr_valueNext_1};
  assign _zz_logic_popPtr_valueNext_1 = logic_popPtr_willIncrement;
  assign _zz_logic_popPtr_valueNext = {7'd0, _zz_logic_popPtr_valueNext_1};
  assign _zz_io_availability = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz__zz_io_pop_payload_kind = 1'b1;
  assign _zz_logic_ram_port_1 = {io_push_payload_data,{io_push_payload_write,{io_push_payload_read,io_push_payload_kind}}};
  always @(posedge io_systemClk) begin
    if(_zz__zz_io_pop_payload_kind) begin
      _zz_logic_ram_port0 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= _zz_logic_ram_port_1;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_pushing) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing) begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 8'hff);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @(*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_logic_pushPtr_valueNext);
    if(logic_pushPtr_willClear) begin
      logic_pushPtr_valueNext = 8'h0;
    end
  end

  always @(*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping) begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 8'hff);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @(*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_logic_popPtr_valueNext);
    if(logic_popPtr_willClear) begin
      logic_popPtr_valueNext = 8'h0;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_io_pop_valid && (! logic_full))));
  assign _zz_io_pop_payload_kind = _zz_logic_ram_port0;
  assign io_pop_payload_kind = _zz_io_pop_payload_kind[0];
  assign io_pop_payload_read = _zz_io_pop_payload_kind[1];
  assign io_pop_payload_write = _zz_io_pop_payload_kind[2];
  assign io_pop_payload_data = _zz_io_pop_payload_kind[10 : 3];
  assign when_Stream_l935 = (logic_pushing != logic_popping);
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_io_availability};
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      logic_pushPtr_value <= 8'h0;
      logic_popPtr_value <= 8'h0;
      logic_risingOccupancy <= 1'b0;
      _zz_io_pop_valid <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_io_pop_valid <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if(when_Stream_l935) begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush) begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module SpiXdrMasterCtrl (
  input               io_config_kind_cpol,
  input               io_config_kind_cpha,
  input      [11:0]   io_config_sclkToogle,
  input      [1:0]    io_config_mod,
  input      [0:0]    io_config_ss_activeHigh,
  input      [11:0]   io_config_ss_setup,
  input      [11:0]   io_config_ss_hold,
  input      [11:0]   io_config_ss_disable,
  input               io_cmd_valid,
  output reg          io_cmd_ready,
  input               io_cmd_payload_kind,
  input               io_cmd_payload_read,
  input               io_cmd_payload_write,
  input      [7:0]    io_cmd_payload_data,
  output              io_rsp_valid,
  output     [7:0]    io_rsp_payload_data,
  output     [0:0]    io_spi_sclk_write,
  output reg          io_spi_data_0_writeEnable,
  input      [0:0]    io_spi_data_0_read,
  output reg [0:0]    io_spi_data_0_write,
  output reg          io_spi_data_1_writeEnable,
  input      [0:0]    io_spi_data_1_read,
  output reg [0:0]    io_spi_data_1_write,
  output reg          io_spi_data_2_writeEnable,
  input      [0:0]    io_spi_data_2_read,
  output reg [0:0]    io_spi_data_2_write,
  output reg          io_spi_data_3_writeEnable,
  input      [0:0]    io_spi_data_3_read,
  output reg [0:0]    io_spi_data_3_write,
  output     [0:0]    io_spi_ss,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  reg        [0:0]    _zz_outputPhy_dataWrite;
  wire       [2:0]    _zz_outputPhy_dataWrite_1;
  reg        [1:0]    _zz_outputPhy_dataWrite_2;
  wire       [1:0]    _zz_outputPhy_dataWrite_3;
  reg        [3:0]    _zz_outputPhy_dataWrite_4;
  wire       [0:0]    _zz_outputPhy_dataWrite_5;
  wire       [3:0]    _zz_inputPhy_dataRead;
  wire       [3:0]    _zz_inputPhy_dataRead_1;
  wire       [3:0]    _zz_inputPhy_dataRead_2;
  wire       [3:0]    _zz_inputPhy_dataRead_3;
  wire       [3:0]    _zz_inputPhy_dataRead_4;
  wire       [3:0]    _zz_inputPhy_dataRead_5;
  wire       [3:0]    _zz_inputPhy_dataRead_6;
  wire       [8:0]    _zz_inputPhy_bufferNext;
  wire       [10:0]   _zz_inputPhy_bufferNext_1;
  reg        [11:0]   timer_counter;
  reg                 timer_reset;
  wire                timer_ss_setupHit;
  wire                timer_ss_holdHit;
  wire                timer_ss_disableHit;
  wire                timer_sclkToogleHit;
  reg                 fsm_state;
  reg        [2:0]    fsm_counter;
  reg        [2:0]    _zz_fsm_counterPlus;
  wire       [2:0]    fsm_counterPlus;
  reg                 fsm_fastRate;
  reg                 fsm_isDdr;
  reg                 fsm_lateSampling;
  reg                 fsm_readFill;
  reg                 fsm_readDone;
  reg        [0:0]    fsm_ss;
  wire                when_SpiXdrMasterCtrl_l728;
  wire                when_SpiXdrMasterCtrl_l731;
  wire                when_SpiXdrMasterCtrl_l738;
  wire                when_SpiXdrMasterCtrl_l740;
  wire                when_SpiXdrMasterCtrl_l747;
  wire                when_SpiXdrMasterCtrl_l753;
  wire                when_SpiXdrMasterCtrl_l770;
  reg        [0:0]    outputPhy_sclkWrite;
  wire       [0:0]    _zz_io_spi_sclk_write;
  wire                when_SpiXdrMasterCtrl_l785;
  reg        [3:0]    outputPhy_dataWrite;
  reg        [2:0]    outputPhy_widthSel;
  wire                when_SpiXdrMasterCtrl_l827;
  wire                when_SpiXdrMasterCtrl_l827_1;
  reg        [1:0]    io_config_mod_delay_1;
  reg        [1:0]    inputPhy_mod;
  reg                 fsm_readFill_delay_1;
  reg                 inputPhy_readFill;
  reg                 fsm_readDone_delay_1;
  reg                 inputPhy_readDone;
  reg        [6:0]    inputPhy_buffer;
  reg        [7:0]    inputPhy_bufferNext;
  reg        [2:0]    inputPhy_widthSel;
  wire       [3:0]    inputPhy_dataWrite;
  reg        [3:0]    inputPhy_dataRead;
  reg                 fsm_state_delay_1;
  reg                 fsm_state_delay_2;
  wire                when_SpiXdrMasterCtrl_l849;
  reg        [3:0]    inputPhy_dataReadBuffer;

  assign _zz_outputPhy_dataWrite_1 = (fsm_counter >>> 0);
  assign _zz_outputPhy_dataWrite_3 = (fsm_counter >>> 1);
  assign _zz_outputPhy_dataWrite_5 = (fsm_counter >>> 2);
  assign _zz_inputPhy_dataRead = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_dataRead_1 = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_dataRead_2 = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_dataRead_3 = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_dataRead_4 = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_dataRead_5 = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_dataRead_6 = {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
  assign _zz_inputPhy_bufferNext = {inputPhy_buffer,inputPhy_dataRead[1 : 0]};
  assign _zz_inputPhy_bufferNext_1 = {inputPhy_buffer,inputPhy_dataRead[3 : 0]};
  always @(*) begin
    case(_zz_outputPhy_dataWrite_1)
      3'b000 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[7 : 7];
      end
      3'b001 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[6 : 6];
      end
      3'b010 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[5 : 5];
      end
      3'b011 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[4 : 4];
      end
      3'b100 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[3 : 3];
      end
      3'b101 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[2 : 2];
      end
      3'b110 : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[1 : 1];
      end
      default : begin
        _zz_outputPhy_dataWrite = io_cmd_payload_data[0 : 0];
      end
    endcase
  end

  always @(*) begin
    case(_zz_outputPhy_dataWrite_3)
      2'b00 : begin
        _zz_outputPhy_dataWrite_2 = io_cmd_payload_data[7 : 6];
      end
      2'b01 : begin
        _zz_outputPhy_dataWrite_2 = io_cmd_payload_data[5 : 4];
      end
      2'b10 : begin
        _zz_outputPhy_dataWrite_2 = io_cmd_payload_data[3 : 2];
      end
      default : begin
        _zz_outputPhy_dataWrite_2 = io_cmd_payload_data[1 : 0];
      end
    endcase
  end

  always @(*) begin
    case(_zz_outputPhy_dataWrite_5)
      1'b0 : begin
        _zz_outputPhy_dataWrite_4 = io_cmd_payload_data[7 : 4];
      end
      default : begin
        _zz_outputPhy_dataWrite_4 = io_cmd_payload_data[3 : 0];
      end
    endcase
  end

  always @(*) begin
    timer_reset = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiXdrMasterCtrl_l728) begin
        timer_reset = timer_sclkToogleHit;
      end else begin
        if(!when_SpiXdrMasterCtrl_l747) begin
          if(when_SpiXdrMasterCtrl_l753) begin
            if(timer_ss_holdHit) begin
              timer_reset = 1'b1;
            end
          end
        end
      end
    end
    if(when_SpiXdrMasterCtrl_l770) begin
      timer_reset = 1'b1;
    end
  end

  assign timer_ss_setupHit = (timer_counter == io_config_ss_setup);
  assign timer_ss_holdHit = (timer_counter == io_config_ss_hold);
  assign timer_ss_disableHit = (timer_counter == io_config_ss_disable);
  assign timer_sclkToogleHit = (timer_counter == io_config_sclkToogle);
  always @(*) begin
    _zz_fsm_counterPlus = 3'bxxx;
    case(io_config_mod)
      2'b00 : begin
        _zz_fsm_counterPlus = 3'b001;
      end
      2'b01 : begin
        _zz_fsm_counterPlus = 3'b010;
      end
      2'b10 : begin
        _zz_fsm_counterPlus = 3'b100;
      end
      default : begin
      end
    endcase
  end

  assign fsm_counterPlus = (fsm_counter + _zz_fsm_counterPlus);
  always @(*) begin
    fsm_fastRate = 1'bx;
    case(io_config_mod)
      2'b00 : begin
        fsm_fastRate = 1'b0;
      end
      2'b01 : begin
        fsm_fastRate = 1'b0;
      end
      2'b10 : begin
        fsm_fastRate = 1'b0;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_isDdr = 1'bx;
    case(io_config_mod)
      2'b00 : begin
        fsm_isDdr = 1'b0;
      end
      2'b01 : begin
        fsm_isDdr = 1'b0;
      end
      2'b10 : begin
        fsm_isDdr = 1'b0;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_lateSampling = 1'bx;
    case(io_config_mod)
      2'b00 : begin
        fsm_lateSampling = 1'b1;
      end
      2'b01 : begin
        fsm_lateSampling = 1'b1;
      end
      2'b10 : begin
        fsm_lateSampling = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_readFill = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiXdrMasterCtrl_l728) begin
        if(when_SpiXdrMasterCtrl_l731) begin
          fsm_readFill = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    fsm_readDone = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiXdrMasterCtrl_l728) begin
        if(when_SpiXdrMasterCtrl_l731) begin
          fsm_readDone = (io_cmd_payload_read && (fsm_counterPlus == 3'b000));
        end
      end
    end
  end

  assign io_spi_ss = (~ (fsm_ss ^ io_config_ss_activeHigh));
  always @(*) begin
    io_cmd_ready = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiXdrMasterCtrl_l728) begin
        if(when_SpiXdrMasterCtrl_l738) begin
          if(when_SpiXdrMasterCtrl_l740) begin
            io_cmd_ready = 1'b1;
          end
        end
      end else begin
        if(when_SpiXdrMasterCtrl_l747) begin
          if(timer_ss_setupHit) begin
            io_cmd_ready = 1'b1;
          end
        end else begin
          if(!when_SpiXdrMasterCtrl_l753) begin
            if(timer_ss_disableHit) begin
              io_cmd_ready = 1'b1;
            end
          end
        end
      end
    end
  end

  assign when_SpiXdrMasterCtrl_l728 = (! io_cmd_payload_kind);
  assign when_SpiXdrMasterCtrl_l731 = ((timer_sclkToogleHit && (((! fsm_state) ^ fsm_lateSampling) || fsm_isDdr)) || fsm_fastRate);
  assign when_SpiXdrMasterCtrl_l738 = ((timer_sclkToogleHit && (fsm_state || fsm_isDdr)) || fsm_fastRate);
  assign when_SpiXdrMasterCtrl_l740 = (fsm_counterPlus == 3'b000);
  assign when_SpiXdrMasterCtrl_l747 = io_cmd_payload_data[7];
  assign when_SpiXdrMasterCtrl_l753 = (! fsm_state);
  assign when_SpiXdrMasterCtrl_l770 = ((! io_cmd_valid) || io_cmd_ready);
  always @(*) begin
    outputPhy_sclkWrite = 1'b0;
    if(when_SpiXdrMasterCtrl_l785) begin
      case(io_config_mod)
        2'b00 : begin
          outputPhy_sclkWrite = ((fsm_state ^ io_config_kind_cpha) ? 1'b1 : 1'b0);
        end
        2'b01 : begin
          outputPhy_sclkWrite = ((fsm_state ^ io_config_kind_cpha) ? 1'b1 : 1'b0);
        end
        2'b10 : begin
          outputPhy_sclkWrite = ((fsm_state ^ io_config_kind_cpha) ? 1'b1 : 1'b0);
        end
        default : begin
        end
      endcase
    end
  end

  assign _zz_io_spi_sclk_write[0] = io_config_kind_cpol;
  assign io_spi_sclk_write = (outputPhy_sclkWrite ^ _zz_io_spi_sclk_write);
  assign when_SpiXdrMasterCtrl_l785 = (io_cmd_valid && (! io_cmd_payload_kind));
  always @(*) begin
    outputPhy_widthSel = 3'bxxx;
    case(io_config_mod)
      2'b00 : begin
        outputPhy_widthSel = 3'b000;
      end
      2'b01 : begin
        outputPhy_widthSel = 3'b001;
      end
      2'b10 : begin
        outputPhy_widthSel = 3'b010;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    outputPhy_dataWrite = 4'bxxxx;
    case(outputPhy_widthSel)
      3'b000 : begin
        outputPhy_dataWrite[0 : 0] = _zz_outputPhy_dataWrite;
      end
      3'b001 : begin
        outputPhy_dataWrite[1 : 0] = _zz_outputPhy_dataWrite_2;
      end
      3'b010 : begin
        outputPhy_dataWrite[3 : 0] = _zz_outputPhy_dataWrite_4;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_0_writeEnable = 1'b0;
    case(io_config_mod)
      2'b00 : begin
        io_spi_data_0_writeEnable = 1'b1;
      end
      2'b01 : begin
        if(when_SpiXdrMasterCtrl_l827) begin
          io_spi_data_0_writeEnable = 1'b1;
        end
      end
      2'b10 : begin
        if(when_SpiXdrMasterCtrl_l827_1) begin
          io_spi_data_0_writeEnable = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_1_writeEnable = 1'b0;
    case(io_config_mod)
      2'b01 : begin
        if(when_SpiXdrMasterCtrl_l827) begin
          io_spi_data_1_writeEnable = 1'b1;
        end
      end
      2'b10 : begin
        if(when_SpiXdrMasterCtrl_l827_1) begin
          io_spi_data_1_writeEnable = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_2_writeEnable = 1'b0;
    case(io_config_mod)
      2'b10 : begin
        if(when_SpiXdrMasterCtrl_l827_1) begin
          io_spi_data_2_writeEnable = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_3_writeEnable = 1'b0;
    case(io_config_mod)
      2'b10 : begin
        if(when_SpiXdrMasterCtrl_l827_1) begin
          io_spi_data_3_writeEnable = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_0_write = 1'bx;
    case(io_config_mod)
      2'b00 : begin
        io_spi_data_0_write[0] = (outputPhy_dataWrite[0] || (! (io_cmd_valid && io_cmd_payload_write)));
      end
      2'b01 : begin
        io_spi_data_0_write[0] = outputPhy_dataWrite[0];
      end
      2'b10 : begin
        io_spi_data_0_write[0] = outputPhy_dataWrite[0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_1_write = 1'bx;
    case(io_config_mod)
      2'b01 : begin
        io_spi_data_1_write[0] = outputPhy_dataWrite[1];
      end
      2'b10 : begin
        io_spi_data_1_write[0] = outputPhy_dataWrite[1];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_2_write = 1'bx;
    case(io_config_mod)
      2'b10 : begin
        io_spi_data_2_write[0] = outputPhy_dataWrite[2];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_spi_data_3_write = 1'bx;
    case(io_config_mod)
      2'b10 : begin
        io_spi_data_3_write[0] = outputPhy_dataWrite[3];
      end
      default : begin
      end
    endcase
  end

  assign when_SpiXdrMasterCtrl_l827 = (io_cmd_valid && io_cmd_payload_write);
  assign when_SpiXdrMasterCtrl_l827_1 = (io_cmd_valid && io_cmd_payload_write);
  always @(*) begin
    inputPhy_bufferNext = 8'bxxxxxxxx;
    case(inputPhy_widthSel)
      3'b000 : begin
        inputPhy_bufferNext = {inputPhy_buffer,inputPhy_dataRead[0 : 0]};
      end
      3'b001 : begin
        inputPhy_bufferNext = _zz_inputPhy_bufferNext[7:0];
      end
      3'b010 : begin
        inputPhy_bufferNext = _zz_inputPhy_bufferNext_1[7:0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    inputPhy_widthSel = 3'bxxx;
    case(inputPhy_mod)
      2'b00 : begin
        inputPhy_widthSel = 3'b000;
      end
      2'b01 : begin
        inputPhy_widthSel = 3'b001;
      end
      2'b10 : begin
        inputPhy_widthSel = 3'b010;
      end
      default : begin
      end
    endcase
  end

  assign when_SpiXdrMasterCtrl_l849 = (! fsm_state_delay_2);
  always @(*) begin
    inputPhy_dataRead = 4'bxxxx;
    case(inputPhy_mod)
      2'b00 : begin
        inputPhy_dataRead[0] = _zz_inputPhy_dataRead[1];
      end
      2'b01 : begin
        inputPhy_dataRead[0] = _zz_inputPhy_dataRead_1[0];
        inputPhy_dataRead[1] = _zz_inputPhy_dataRead_2[1];
      end
      2'b10 : begin
        inputPhy_dataRead[0] = _zz_inputPhy_dataRead_3[0];
        inputPhy_dataRead[1] = _zz_inputPhy_dataRead_4[1];
        inputPhy_dataRead[2] = _zz_inputPhy_dataRead_5[2];
        inputPhy_dataRead[3] = _zz_inputPhy_dataRead_6[3];
      end
      default : begin
      end
    endcase
  end

  assign io_rsp_valid = inputPhy_readDone;
  assign io_rsp_payload_data = inputPhy_bufferNext;
  always @(posedge io_systemClk) begin
    timer_counter <= (timer_counter + 12'h001);
    if(timer_reset) begin
      timer_counter <= 12'h0;
    end
    io_config_mod_delay_1 <= io_config_mod;
    inputPhy_mod <= io_config_mod_delay_1;
    fsm_state_delay_1 <= fsm_state;
    fsm_state_delay_2 <= fsm_state_delay_1;
    if(when_SpiXdrMasterCtrl_l849) begin
      inputPhy_dataReadBuffer <= {io_spi_data_3_read[0],{io_spi_data_2_read[0],{io_spi_data_1_read[0],io_spi_data_0_read[0]}}};
    end
    case(inputPhy_widthSel)
      3'b000 : begin
        if(inputPhy_readFill) begin
          inputPhy_buffer <= inputPhy_bufferNext[6:0];
        end
      end
      3'b001 : begin
        if(inputPhy_readFill) begin
          inputPhy_buffer <= inputPhy_bufferNext[6:0];
        end
      end
      3'b010 : begin
        if(inputPhy_readFill) begin
          inputPhy_buffer <= inputPhy_bufferNext[6:0];
        end
      end
      default : begin
      end
    endcase
  end

  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      fsm_state <= 1'b0;
      fsm_counter <= 3'b000;
      fsm_ss <= 1'b0;
      fsm_readFill_delay_1 <= 1'b0;
      inputPhy_readFill <= 1'b0;
      fsm_readDone_delay_1 <= 1'b0;
      inputPhy_readDone <= 1'b0;
    end else begin
      if(io_cmd_valid) begin
        if(when_SpiXdrMasterCtrl_l728) begin
          if(timer_sclkToogleHit) begin
            fsm_state <= (! fsm_state);
          end
          if(when_SpiXdrMasterCtrl_l738) begin
            fsm_counter <= fsm_counterPlus;
            if(when_SpiXdrMasterCtrl_l740) begin
              fsm_state <= 1'b0;
            end
          end
        end else begin
          if(when_SpiXdrMasterCtrl_l747) begin
            fsm_ss[0] <= 1'b1;
          end else begin
            if(when_SpiXdrMasterCtrl_l753) begin
              if(timer_ss_holdHit) begin
                fsm_state <= 1'b1;
              end
            end else begin
              fsm_ss[0] <= 1'b0;
            end
          end
        end
      end
      if(when_SpiXdrMasterCtrl_l770) begin
        fsm_state <= 1'b0;
        fsm_counter <= 3'b000;
      end
      fsm_readFill_delay_1 <= fsm_readFill;
      inputPhy_readFill <= fsm_readFill_delay_1;
      fsm_readDone_delay_1 <= fsm_readDone;
      inputPhy_readDone <= fsm_readDone_delay_1;
    end
  end


endmodule

//StreamFifo replaced by StreamFifo

module StreamFifo (
  input               io_push_valid,
  output              io_push_ready,
  input      [7:0]    io_push_payload,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [7:0]    io_pop_payload,
  input               io_flush,
  output     [7:0]    io_occupancy,
  output     [7:0]    io_availability,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  reg        [7:0]    _zz_logic_ram_port0;
  wire       [6:0]    _zz_logic_pushPtr_valueNext;
  wire       [0:0]    _zz_logic_pushPtr_valueNext_1;
  wire       [6:0]    _zz_logic_popPtr_valueNext;
  wire       [0:0]    _zz_logic_popPtr_valueNext_1;
  wire                _zz_logic_ram_port;
  wire                _zz_io_pop_payload;
  wire       [6:0]    _zz_io_availability;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [6:0]    logic_pushPtr_valueNext;
  reg        [6:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [6:0]    logic_popPtr_valueNext;
  reg        [6:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_io_pop_valid;
  wire                when_Stream_l935;
  wire       [6:0]    logic_ptrDif;
  reg [7:0] logic_ram [0:127];

  assign _zz_logic_pushPtr_valueNext_1 = logic_pushPtr_willIncrement;
  assign _zz_logic_pushPtr_valueNext = {6'd0, _zz_logic_pushPtr_valueNext_1};
  assign _zz_logic_popPtr_valueNext_1 = logic_popPtr_willIncrement;
  assign _zz_logic_popPtr_valueNext = {6'd0, _zz_logic_popPtr_valueNext_1};
  assign _zz_io_availability = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_io_pop_payload = 1'b1;
  always @(posedge io_systemClk) begin
    if(_zz_io_pop_payload) begin
      _zz_logic_ram_port0 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @(posedge io_systemClk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_pushing) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing) begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 7'h7f);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @(*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_logic_pushPtr_valueNext);
    if(logic_pushPtr_willClear) begin
      logic_pushPtr_valueNext = 7'h0;
    end
  end

  always @(*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping) begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 7'h7f);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @(*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_logic_popPtr_valueNext);
    if(logic_popPtr_willClear) begin
      logic_popPtr_valueNext = 7'h0;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_io_pop_valid && (! logic_full))));
  assign io_pop_payload = _zz_logic_ram_port0;
  assign when_Stream_l935 = (logic_pushing != logic_popping);
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_io_availability};
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      logic_pushPtr_value <= 7'h0;
      logic_popPtr_value <= 7'h0;
      logic_risingOccupancy <= 1'b0;
      _zz_io_pop_valid <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_io_pop_valid <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if(when_Stream_l935) begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush) begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module UartCtrl (
  input      [2:0]    io_config_frame_dataLength,
  input      [0:0]    io_config_frame_stop,
  input      [1:0]    io_config_frame_parity,
  input      [19:0]   io_config_clockDivider,
  input               io_write_valid,
  output reg          io_write_ready,
  input      [7:0]    io_write_payload,
  output              io_read_valid,
  input               io_read_ready,
  output     [7:0]    io_read_payload,
  output              io_uart_txd,
  input               io_uart_rxd,
  output              io_readError,
  input               io_writeBreak,
  output              io_readBreak,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;

  wire                tx_io_write_ready;
  wire                tx_io_txd;
  wire                rx_io_read_valid;
  wire       [7:0]    rx_io_read_payload;
  wire                rx_io_rts;
  wire                rx_io_error;
  wire                rx_io_break;
  reg        [19:0]   clockDivider_counter;
  wire                clockDivider_tick;
  reg                 clockDivider_tickReg;
  reg                 io_write_thrown_valid;
  wire                io_write_thrown_ready;
  wire       [7:0]    io_write_thrown_payload;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif


  UartCtrlTx tx (
    .io_configFrame_dataLength     (io_config_frame_dataLength[2:0]  ), //i
    .io_configFrame_stop           (io_config_frame_stop             ), //i
    .io_configFrame_parity         (io_config_frame_parity[1:0]      ), //i
    .io_samplingTick               (clockDivider_tickReg             ), //i
    .io_write_valid                (io_write_thrown_valid            ), //i
    .io_write_ready                (tx_io_write_ready                ), //o
    .io_write_payload              (io_write_thrown_payload[7:0]     ), //i
    .io_cts                        (1'b0                             ), //i
    .io_txd                        (tx_io_txd                        ), //o
    .io_break                      (io_writeBreak                    ), //i
    .io_systemClk                  (io_systemClk                     ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset       )  //i
  );
  UartCtrlRx rx (
    .io_configFrame_dataLength     (io_config_frame_dataLength[2:0]  ), //i
    .io_configFrame_stop           (io_config_frame_stop             ), //i
    .io_configFrame_parity         (io_config_frame_parity[1:0]      ), //i
    .io_samplingTick               (clockDivider_tickReg             ), //i
    .io_read_valid                 (rx_io_read_valid                 ), //o
    .io_read_ready                 (io_read_ready                    ), //i
    .io_read_payload               (rx_io_read_payload[7:0]          ), //o
    .io_rxd                        (io_uart_rxd                      ), //i
    .io_rts                        (rx_io_rts                        ), //o
    .io_error                      (rx_io_error                      ), //o
    .io_break                      (rx_io_break                      ), //o
    .io_systemClk                  (io_systemClk                     ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset       )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      UartStopType_ONE : io_config_frame_stop_string = "ONE";
      UartStopType_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      UartParityType_NONE : io_config_frame_parity_string = "NONE";
      UartParityType_EVEN : io_config_frame_parity_string = "EVEN";
      UartParityType_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == 20'h0);
  always @(*) begin
    io_write_thrown_valid = io_write_valid;
    if(rx_io_break) begin
      io_write_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    io_write_ready = io_write_thrown_ready;
    if(rx_io_break) begin
      io_write_ready = 1'b1;
    end
  end

  assign io_write_thrown_payload = io_write_payload;
  assign io_write_thrown_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  assign io_readError = rx_io_error;
  assign io_readBreak = rx_io_break;
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      clockDivider_counter <= 20'h0;
      clockDivider_tickReg <= 1'b0;
    end else begin
      clockDivider_tickReg <= clockDivider_tick;
      clockDivider_counter <= (clockDivider_counter - 20'h00001);
      if(clockDivider_tick) begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end


endmodule

module StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input               io_inputs_0_payload_last,
  input      [0:0]    io_inputs_0_payload_fragment_source,
  input      [0:0]    io_inputs_0_payload_fragment_opcode,
  input      [31:0]   io_inputs_0_payload_fragment_address,
  input      [1:0]    io_inputs_0_payload_fragment_length,
  input      [31:0]   io_inputs_0_payload_fragment_data,
  input      [3:0]    io_inputs_0_payload_fragment_mask,
  input      [0:0]    io_inputs_0_payload_fragment_context,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input               io_inputs_1_payload_last,
  input      [0:0]    io_inputs_1_payload_fragment_source,
  input      [0:0]    io_inputs_1_payload_fragment_opcode,
  input      [31:0]   io_inputs_1_payload_fragment_address,
  input      [1:0]    io_inputs_1_payload_fragment_length,
  input      [31:0]   io_inputs_1_payload_fragment_data,
  input      [3:0]    io_inputs_1_payload_fragment_mask,
  input      [0:0]    io_inputs_1_payload_fragment_context,
  output              io_output_valid,
  input               io_output_ready,
  output              io_output_payload_last,
  output     [0:0]    io_output_payload_fragment_source,
  output     [0:0]    io_output_payload_fragment_opcode,
  output     [31:0]   io_output_payload_fragment_address,
  output     [1:0]    io_output_payload_fragment_length,
  output     [31:0]   io_output_payload_fragment_data,
  output     [3:0]    io_output_payload_fragment_mask,
  output     [0:0]    io_output_payload_fragment_context,
  output     [0:0]    io_chosen,
  output     [1:0]    io_chosenOH,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  wire       [1:0]    _zz_maskProposal_1_1;
  wire       [1:0]    _zz_maskProposal_1_2;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire       [1:0]    _zz_maskProposal_1;
  wire                io_output_fire;
  wire                when_Stream_l523;
  wire                _zz_io_chosen;

  assign _zz_maskProposal_1_1 = (_zz_maskProposal_1 & (~ _zz_maskProposal_1_2));
  assign _zz_maskProposal_1_2 = (_zz_maskProposal_1 - 2'b01);
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign _zz_maskProposal_1 = {io_inputs_1_valid,io_inputs_0_valid};
  assign maskProposal_0 = io_inputs_0_valid;
  assign maskProposal_1 = _zz_maskProposal_1_1[1];
  assign io_output_fire = (io_output_valid && io_output_ready);
  assign when_Stream_l523 = (io_output_fire && io_output_payload_last);
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1));
  assign io_output_payload_last = (maskRouted_0 ? io_inputs_0_payload_last : io_inputs_1_payload_last);
  assign io_output_payload_fragment_source = (maskRouted_0 ? io_inputs_0_payload_fragment_source : io_inputs_1_payload_fragment_source);
  assign io_output_payload_fragment_opcode = (maskRouted_0 ? io_inputs_0_payload_fragment_opcode : io_inputs_1_payload_fragment_opcode);
  assign io_output_payload_fragment_address = (maskRouted_0 ? io_inputs_0_payload_fragment_address : io_inputs_1_payload_fragment_address);
  assign io_output_payload_fragment_length = (maskRouted_0 ? io_inputs_0_payload_fragment_length : io_inputs_1_payload_fragment_length);
  assign io_output_payload_fragment_data = (maskRouted_0 ? io_inputs_0_payload_fragment_data : io_inputs_1_payload_fragment_data);
  assign io_output_payload_fragment_mask = (maskRouted_0 ? io_inputs_0_payload_fragment_mask : io_inputs_1_payload_fragment_mask);
  assign io_output_payload_fragment_context = (maskRouted_0 ? io_inputs_0_payload_fragment_context : io_inputs_1_payload_fragment_context);
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_chosenOH = {maskRouted_1,maskRouted_0};
  assign _zz_io_chosen = io_chosenOH[1];
  assign io_chosen = _zz_io_chosen;
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      locked <= 1'b0;
    end else begin
      if(io_output_valid) begin
        locked <= 1'b1;
      end
      if(when_Stream_l523) begin
        locked <= 1'b0;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(io_output_valid) begin
      maskLocked_0 <= maskRouted_0;
      maskLocked_1 <= maskRouted_1;
    end
  end


endmodule

module StreamFifoLowLatency (
  input               io_push_valid,
  output              io_push_ready,
  input               io_push_payload_error,
  input      [31:0]   io_push_payload_inst,
  output reg          io_pop_valid,
  input               io_pop_ready,
  output reg          io_pop_payload_error,
  output reg [31:0]   io_pop_payload_inst,
  input               io_flush,
  output     [1:0]    io_occupancy,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  reg                 _zz_readed_error;
  reg        [31:0]   _zz_readed_inst;
  reg                 vec_0_error;
  reg        [31:0]   vec_0_inst;
  reg                 vec_1_error;
  reg        [31:0]   vec_1_inst;
  reg                 pushPtr_willIncrement;
  reg                 pushPtr_willClear;
  reg        [0:0]    pushPtr_valueNext;
  reg        [0:0]    pushPtr_value;
  wire                pushPtr_willOverflowIfInc;
  wire                pushPtr_willOverflow;
  reg                 popPtr_willIncrement;
  reg                 popPtr_willClear;
  reg        [0:0]    popPtr_valueNext;
  reg        [0:0]    popPtr_value;
  wire                popPtr_willOverflowIfInc;
  wire                popPtr_willOverflow;
  wire                ptrMatch;
  reg                 risingOccupancy;
  wire                empty;
  wire                full;
  wire                pushing;
  wire                popping;
  wire                readed_error;
  wire       [31:0]   readed_inst;
  wire                when_Stream_l1000;
  wire                when_Stream_l1013;
  wire       [1:0]    _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire       [0:0]    ptrDif;

  always @(*) begin
    case(popPtr_value)
      1'b0 : begin
        _zz_readed_error = vec_0_error;
        _zz_readed_inst = vec_0_inst;
      end
      default : begin
        _zz_readed_error = vec_1_error;
        _zz_readed_inst = vec_1_inst;
      end
    endcase
  end

  always @(*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing) begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush) begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = (pushPtr_value == 1'b1);
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @(*) begin
    pushPtr_valueNext = (pushPtr_value + pushPtr_willIncrement);
    if(pushPtr_willClear) begin
      pushPtr_valueNext = 1'b0;
    end
  end

  always @(*) begin
    popPtr_willIncrement = 1'b0;
    if(popping) begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    popPtr_willClear = 1'b0;
    if(io_flush) begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = (popPtr_value == 1'b1);
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  always @(*) begin
    popPtr_valueNext = (popPtr_value + popPtr_willIncrement);
    if(popPtr_willClear) begin
      popPtr_valueNext = 1'b0;
    end
  end

  assign ptrMatch = (pushPtr_value == popPtr_value);
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  assign readed_error = _zz_readed_error;
  assign readed_inst = _zz_readed_inst;
  assign when_Stream_l1000 = (! empty);
  always @(*) begin
    if(when_Stream_l1000) begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  always @(*) begin
    if(when_Stream_l1000) begin
      io_pop_payload_error = readed_error;
    end else begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @(*) begin
    if(when_Stream_l1000) begin
      io_pop_payload_inst = readed_inst;
    end else begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign when_Stream_l1013 = (pushing != popping);
  assign _zz_1 = ({1'd0,1'b1} <<< pushPtr_value);
  assign _zz_2 = _zz_1[0];
  assign _zz_3 = _zz_1[1];
  assign ptrDif = (pushPtr_value - popPtr_value);
  assign io_occupancy = {(risingOccupancy && ptrMatch),ptrDif};
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      pushPtr_value <= 1'b0;
      popPtr_value <= 1'b0;
      risingOccupancy <= 1'b0;
    end else begin
      pushPtr_value <= pushPtr_valueNext;
      popPtr_value <= popPtr_valueNext;
      if(when_Stream_l1013) begin
        risingOccupancy <= pushing;
      end
      if(io_flush) begin
        risingOccupancy <= 1'b0;
      end
    end
  end

  always @(posedge io_systemClk) begin
    if(pushing) begin
      if(_zz_2) begin
        vec_0_error <= io_push_payload_error;
      end
      if(_zz_3) begin
        vec_1_error <= io_push_payload_error;
      end
      if(_zz_2) begin
        vec_0_inst <= io_push_payload_inst;
      end
      if(_zz_3) begin
        vec_1_inst <= io_push_payload_inst;
      end
    end
  end


endmodule

module FlowCCByToggle (
  input               io_input_valid,
  input               io_input_payload_last,
  input      [0:0]    io_input_payload_fragment,
  output              io_output_valid,
  output              io_output_payload_last,
  output     [0:0]    io_output_payload_fragment,
  input               jtagCtrl_tck,
  input               io_systemClk,
  input               debugCd_logic_outputReset
);

  wire                inputArea_target_buffercc_io_dataOut;
  wire                outHitSignal;
  reg                 inputArea_target = 0;
  reg                 inputArea_data_last;
  reg        [0:0]    inputArea_data_fragment;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_last;
  wire       [0:0]    outputArea_flow_payload_fragment;
  reg                 outputArea_flow_m2sPipe_valid;
  reg                 outputArea_flow_m2sPipe_payload_last;
  reg        [0:0]    outputArea_flow_m2sPipe_payload_fragment;

  BufferCC_1 inputArea_target_buffercc (
    .io_dataIn                    (inputArea_target                      ), //i
    .io_dataOut                   (inputArea_target_buffercc_io_dataOut  ), //o
    .io_systemClk                 (io_systemClk                          ), //i
    .debugCd_logic_outputReset    (debugCd_logic_outputReset             )  //i
  );
  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_last = outputArea_flow_m2sPipe_payload_last;
  assign io_output_payload_fragment = outputArea_flow_m2sPipe_payload_fragment;
  always @(posedge jtagCtrl_tck) begin
    if(io_input_valid) begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @(posedge io_systemClk) begin
    outputArea_hit <= outputArea_target;
    if(outputArea_flow_valid) begin
      outputArea_flow_m2sPipe_payload_last <= outputArea_flow_payload_last;
      outputArea_flow_m2sPipe_payload_fragment <= outputArea_flow_payload_fragment;
    end
  end

  always @(posedge io_systemClk) begin
    if(debugCd_logic_outputReset) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
    end else begin
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end


endmodule

module UartCtrlRx (
  input      [2:0]    io_configFrame_dataLength,
  input      [0:0]    io_configFrame_stop,
  input      [1:0]    io_configFrame_parity,
  input               io_samplingTick,
  output              io_read_valid,
  input               io_read_ready,
  output     [7:0]    io_read_payload,
  input               io_rxd,
  output              io_rts,
  output reg          io_error,
  output              io_break,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlRxState_IDLE = 3'd0;
  localparam UartCtrlRxState_START = 3'd1;
  localparam UartCtrlRxState_DATA = 3'd2;
  localparam UartCtrlRxState_PARITY = 3'd3;
  localparam UartCtrlRxState_STOP = 3'd4;

  wire                io_rxd_buffercc_io_dataOut;
  wire                _zz_sampler_value;
  wire                _zz_sampler_value_1;
  wire                _zz_sampler_value_2;
  wire                _zz_sampler_value_3;
  wire                _zz_sampler_value_4;
  wire                _zz_sampler_value_5;
  wire                _zz_sampler_value_6;
  wire       [2:0]    _zz_when_UartCtrlRx_l139;
  wire       [0:0]    _zz_when_UartCtrlRx_l139_1;
  reg                 _zz_io_rts;
  wire                sampler_synchroniser;
  wire                sampler_samples_0;
  reg                 sampler_samples_1;
  reg                 sampler_samples_2;
  reg                 sampler_samples_3;
  reg                 sampler_samples_4;
  reg                 sampler_value;
  reg                 sampler_tick;
  reg        [2:0]    bitTimer_counter;
  reg                 bitTimer_tick;
  wire                when_UartCtrlRx_l43;
  reg        [2:0]    bitCounter_value;
  reg        [6:0]    break_counter;
  wire                break_valid;
  wire                when_UartCtrlRx_l69;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg        [7:0]    stateMachine_shifter;
  reg                 stateMachine_validReg;
  wire                when_UartCtrlRx_l93;
  wire                when_UartCtrlRx_l103;
  wire                when_UartCtrlRx_l111;
  wire                when_UartCtrlRx_l113;
  wire                when_UartCtrlRx_l125;
  wire                when_UartCtrlRx_l136;
  wire                when_UartCtrlRx_l139;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_when_UartCtrlRx_l139_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlRx_l139 = {2'd0, _zz_when_UartCtrlRx_l139_1};
  assign _zz_sampler_value = ((((1'b0 || ((_zz_sampler_value_1 && sampler_samples_1) && sampler_samples_2)) || (((_zz_sampler_value_2 && sampler_samples_0) && sampler_samples_1) && sampler_samples_3)) || (((1'b1 && sampler_samples_0) && sampler_samples_2) && sampler_samples_3)) || (((1'b1 && sampler_samples_1) && sampler_samples_2) && sampler_samples_3));
  assign _zz_sampler_value_3 = (((1'b1 && sampler_samples_0) && sampler_samples_1) && sampler_samples_4);
  assign _zz_sampler_value_4 = ((1'b1 && sampler_samples_0) && sampler_samples_2);
  assign _zz_sampler_value_5 = (1'b1 && sampler_samples_1);
  assign _zz_sampler_value_6 = 1'b1;
  assign _zz_sampler_value_1 = (1'b1 && sampler_samples_0);
  assign _zz_sampler_value_2 = 1'b1;
  BufferCC io_rxd_buffercc (
    .io_dataIn                     (io_rxd                      ), //i
    .io_dataOut                    (io_rxd_buffercc_io_dataOut  ), //o
    .io_systemClk                  (io_systemClk                ), //i
    .systemCd_logic_outputReset    (systemCd_logic_outputReset  )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlRxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlRxState_START : stateMachine_state_string = "START ";
      UartCtrlRxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlRxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlRxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    io_error = 1'b0;
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
      end
      UartCtrlRxState_START : begin
      end
      UartCtrlRxState_DATA : begin
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          if(!when_UartCtrlRx_l125) begin
            io_error = 1'b1;
          end
        end
      end
      default : begin
        if(bitTimer_tick) begin
          if(when_UartCtrlRx_l136) begin
            io_error = 1'b1;
          end
        end
      end
    endcase
  end

  assign io_rts = _zz_io_rts;
  assign sampler_synchroniser = io_rxd_buffercc_io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @(*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick) begin
      if(when_UartCtrlRx_l43) begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign when_UartCtrlRx_l43 = (bitTimer_counter == 3'b000);
  assign break_valid = (break_counter == 7'h68);
  assign when_UartCtrlRx_l69 = (io_samplingTick && (! break_valid));
  assign io_break = break_valid;
  assign io_read_valid = stateMachine_validReg;
  assign when_UartCtrlRx_l93 = ((sampler_tick && (! sampler_value)) && (! break_valid));
  assign when_UartCtrlRx_l103 = (sampler_value == 1'b1);
  assign when_UartCtrlRx_l111 = (bitCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlRx_l113 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlRx_l125 = (stateMachine_parity == sampler_value);
  assign when_UartCtrlRx_l136 = (! sampler_value);
  assign when_UartCtrlRx_l139 = (bitCounter_value == _zz_when_UartCtrlRx_l139);
  assign io_read_payload = stateMachine_shifter;
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      _zz_io_rts <= 1'b0;
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_samples_3 <= 1'b1;
      sampler_samples_4 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      break_counter <= 7'h0;
      stateMachine_state <= UartCtrlRxState_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      _zz_io_rts <= (! io_read_ready);
      if(io_samplingTick) begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick) begin
        sampler_samples_2 <= sampler_samples_1;
      end
      if(io_samplingTick) begin
        sampler_samples_3 <= sampler_samples_2;
      end
      if(io_samplingTick) begin
        sampler_samples_4 <= sampler_samples_3;
      end
      sampler_value <= ((((((_zz_sampler_value || _zz_sampler_value_3) || (_zz_sampler_value_4 && sampler_samples_4)) || ((_zz_sampler_value_5 && sampler_samples_2) && sampler_samples_4)) || (((_zz_sampler_value_6 && sampler_samples_0) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_1) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_2) && sampler_samples_3) && sampler_samples_4));
      sampler_tick <= io_samplingTick;
      if(sampler_value) begin
        break_counter <= 7'h0;
      end else begin
        if(when_UartCtrlRx_l69) begin
          break_counter <= (break_counter + 7'h01);
        end
      end
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        UartCtrlRxState_IDLE : begin
          if(when_UartCtrlRx_l93) begin
            stateMachine_state <= UartCtrlRxState_START;
          end
        end
        UartCtrlRxState_START : begin
          if(bitTimer_tick) begin
            stateMachine_state <= UartCtrlRxState_DATA;
            if(when_UartCtrlRx_l103) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        UartCtrlRxState_DATA : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l111) begin
              if(when_UartCtrlRx_l113) begin
                stateMachine_state <= UartCtrlRxState_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= UartCtrlRxState_PARITY;
              end
            end
          end
        end
        UartCtrlRxState_PARITY : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l125) begin
              stateMachine_state <= UartCtrlRxState_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l136) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end else begin
              if(when_UartCtrlRx_l139) begin
                stateMachine_state <= UartCtrlRxState_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @(posedge io_systemClk) begin
    if(sampler_tick) begin
      bitTimer_counter <= (bitTimer_counter - 3'b001);
    end
    if(bitTimer_tick) begin
      bitCounter_value <= (bitCounter_value + 3'b001);
    end
    if(bitTimer_tick) begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
        if(when_UartCtrlRx_l93) begin
          bitTimer_counter <= 3'b010;
        end
      end
      UartCtrlRxState_START : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
        end
      end
      UartCtrlRxState_DATA : begin
        if(bitTimer_tick) begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(when_UartCtrlRx_l111) begin
            bitCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module UartCtrlTx (
  input      [2:0]    io_configFrame_dataLength,
  input      [0:0]    io_configFrame_stop,
  input      [1:0]    io_configFrame_parity,
  input               io_samplingTick,
  input               io_write_valid,
  output reg          io_write_ready,
  input      [7:0]    io_write_payload,
  input               io_cts,
  output              io_txd,
  input               io_break,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlTxState_IDLE = 3'd0;
  localparam UartCtrlTxState_START = 3'd1;
  localparam UartCtrlTxState_DATA = 3'd2;
  localparam UartCtrlTxState_PARITY = 3'd3;
  localparam UartCtrlTxState_STOP = 3'd4;

  wire       [2:0]    _zz_clockDivider_counter_valueNext;
  wire       [0:0]    _zz_clockDivider_counter_valueNext_1;
  wire       [2:0]    _zz_when_UartCtrlTx_l93;
  wire       [0:0]    _zz_when_UartCtrlTx_l93_1;
  reg                 clockDivider_counter_willIncrement;
  wire                clockDivider_counter_willClear;
  reg        [2:0]    clockDivider_counter_valueNext;
  reg        [2:0]    clockDivider_counter_value;
  wire                clockDivider_counter_willOverflowIfInc;
  wire                clockDivider_counter_willOverflow;
  reg        [2:0]    tickCounter_value;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg                 stateMachine_txd;
  wire                when_UartCtrlTx_l58;
  wire                when_UartCtrlTx_l73;
  wire                when_UartCtrlTx_l76;
  wire                when_UartCtrlTx_l93;
  reg                 _zz_io_txd;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_clockDivider_counter_valueNext_1 = clockDivider_counter_willIncrement;
  assign _zz_clockDivider_counter_valueNext = {2'd0, _zz_clockDivider_counter_valueNext_1};
  assign _zz_when_UartCtrlTx_l93_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlTx_l93 = {2'd0, _zz_when_UartCtrlTx_l93_1};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlTxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick) begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == 3'b111);
  assign clockDivider_counter_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @(*) begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_clockDivider_counter_valueNext);
    if(clockDivider_counter_willClear) begin
      clockDivider_counter_valueNext = 3'b000;
    end
  end

  always @(*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        stateMachine_txd = 1'b0;
      end
      UartCtrlTxState_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      UartCtrlTxState_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_write_ready = io_break;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            io_write_ready = 1'b1;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign when_UartCtrlTx_l58 = ((io_write_valid && (! io_cts)) && clockDivider_counter_willOverflow);
  assign when_UartCtrlTx_l73 = (tickCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlTx_l76 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlTx_l93 = (tickCounter_value == _zz_when_UartCtrlTx_l93);
  assign io_txd = _zz_io_txd;
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      clockDivider_counter_value <= 3'b000;
      stateMachine_state <= UartCtrlTxState_IDLE;
      _zz_io_txd <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        UartCtrlTxState_IDLE : begin
          if(when_UartCtrlTx_l58) begin
            stateMachine_state <= UartCtrlTxState_START;
          end
        end
        UartCtrlTxState_START : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_DATA;
          end
        end
        UartCtrlTxState_DATA : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l73) begin
              if(when_UartCtrlTx_l76) begin
                stateMachine_state <= UartCtrlTxState_STOP;
              end else begin
                stateMachine_state <= UartCtrlTxState_PARITY;
              end
            end
          end
        end
        UartCtrlTxState_PARITY : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_STOP;
          end
        end
        default : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l93) begin
              stateMachine_state <= (io_write_valid ? UartCtrlTxState_START : UartCtrlTxState_IDLE);
            end
          end
        end
      endcase
      _zz_io_txd <= (stateMachine_txd && (! io_break));
    end
  end

  always @(posedge io_systemClk) begin
    if(clockDivider_counter_willOverflow) begin
      tickCounter_value <= (tickCounter_value + 3'b001);
    end
    if(clockDivider_counter_willOverflow) begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        if(clockDivider_counter_willOverflow) begin
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
          tickCounter_value <= 3'b000;
        end
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            tickCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
        if(clockDivider_counter_willOverflow) begin
          tickCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC_1 (
  input               io_dataIn,
  output              io_dataOut,
  input               io_systemClk,
  input               debugCd_logic_outputReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_systemClk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               io_systemClk,
  input               systemCd_logic_outputReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_systemClk) begin
    if(systemCd_logic_outputReset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
