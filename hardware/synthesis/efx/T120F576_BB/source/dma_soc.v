// Generator : SpinalHDL v1.4.2    git head : 68df843068cb6532edf7bbe2830c394f1791233d
// Component : dma_soc
// Git hash  : 8664b5cbfddf2389b670722bd5cf79a30de82039



module dma_soc (
  input      [13:0]   ctrl_PADDR,
  input      [0:0]    ctrl_PSEL,
  input               ctrl_PENABLE,
  output              ctrl_PREADY,
  input               ctrl_PWRITE,
  input      [31:0]   ctrl_PWDATA,
  output     [31:0]   ctrl_PRDATA,
  output              ctrl_PSLVERROR,
  output     [0:0]    ctrl_interrupts,
  output              axi_arwvalid,
  input               axi_arwready,
  output     [31:0]   axi_arwaddr,
  output     [3:0]    axi_arwregion,
  output     [7:0]    axi_arwlen,
  output     [2:0]    axi_arwsize,
  output     [1:0]    axi_arwburst,
  output     [0:0]    axi_arwlock,
  output     [3:0]    axi_arwcache,
  output     [3:0]    axi_arwqos,
  output     [2:0]    axi_arwprot,
  output              axi_arwwrite,
  output              axi_wvalid,
  input               axi_wready,
  output     [255:0]  axi_wdata,
  output     [31:0]   axi_wstrb,
  output              axi_wlast,
  input               axi_bvalid,
  output              axi_bready,
  input      [1:0]    axi_bresp,
  input               axi_rvalid,
  output              axi_rready,
  input      [255:0]  axi_rdata,
  input      [1:0]    axi_rresp,
  input               axi_rlast,
  output              hdmi_0_tvalid,
  input               hdmi_0_tready,
  output     [31:0]   hdmi_0_tdata,
  output     [3:0]    hdmi_0_tkeep,
  output              hdmi_0_tlast,
  input               clk,
  input               reset,
  input               ctrl_clk,
  input               ctrl_reset,
  input               hdmi_0_clk,
  input               hdmi_0_reset
);
  wire                _zz_2;
  wire       [31:0]   _zz_3;
  wire       [3:0]    _zz_4;
  wire       [7:0]    _zz_5;
  wire       [2:0]    _zz_6;
  wire       [1:0]    _zz_7;
  wire       [0:0]    _zz_8;
  wire       [3:0]    _zz_9;
  wire       [3:0]    _zz_10;
  wire       [2:0]    _zz_11;
  wire                _zz_12;
  wire                _zz_13;
  wire                _zz_14;
  wire                streamArbiter_io_inputs_0_ready;
  wire                streamArbiter_io_inputs_1_ready;
  wire                streamArbiter_io_output_valid;
  wire       [31:0]   streamArbiter_io_output_payload_addr;
  wire       [3:0]    streamArbiter_io_output_payload_region;
  wire       [7:0]    streamArbiter_io_output_payload_len;
  wire       [2:0]    streamArbiter_io_output_payload_size;
  wire       [1:0]    streamArbiter_io_output_payload_burst;
  wire       [0:0]    streamArbiter_io_output_payload_lock;
  wire       [3:0]    streamArbiter_io_output_payload_cache;
  wire       [3:0]    streamArbiter_io_output_payload_qos;
  wire       [2:0]    streamArbiter_io_output_payload_prot;
  wire       [0:0]    streamArbiter_io_chosen;
  wire       [1:0]    streamArbiter_io_chosenOH;
  wire                core_io_read_cmd_valid;
  wire                core_io_read_cmd_payload_last;
  wire       [0:0]    core_io_read_cmd_payload_fragment_opcode;
  wire       [31:0]   core_io_read_cmd_payload_fragment_address;
  wire       [10:0]   core_io_read_cmd_payload_fragment_length;
  wire       [17:0]   core_io_read_cmd_payload_fragment_context;
  wire                core_io_read_rsp_ready;
  wire                core_io_outputs_0_valid;
  wire       [63:0]   core_io_outputs_0_payload_data;
  wire       [7:0]    core_io_outputs_0_payload_mask;
  wire                core_io_outputs_0_payload_last;
  wire       [0:0]    core_io_interrupts;
  wire                core_io_ctrl_PREADY;
  wire       [31:0]   core_io_ctrl_PRDATA;
  wire                core_io_ctrl_PSLVERROR;
  wire                withCtrlCc_apbCc_io_input_PREADY;
  wire       [31:0]   withCtrlCc_apbCc_io_input_PRDATA;
  wire                withCtrlCc_apbCc_io_input_PSLVERROR;
  wire       [13:0]   withCtrlCc_apbCc_io_output_PADDR;
  wire       [0:0]    withCtrlCc_apbCc_io_output_PSEL;
  wire                withCtrlCc_apbCc_io_output_PENABLE;
  wire                withCtrlCc_apbCc_io_output_PWRITE;
  wire       [31:0]   withCtrlCc_apbCc_io_output_PWDATA;
  wire       [0:0]    core_io_interrupts_buffercc_io_dataOut;
  wire                bmbUpSizerBridge_io_input_cmd_ready;
  wire                bmbUpSizerBridge_io_input_rsp_valid;
  wire                bmbUpSizerBridge_io_input_rsp_payload_last;
  wire       [0:0]    bmbUpSizerBridge_io_input_rsp_payload_fragment_opcode;
  wire       [63:0]   bmbUpSizerBridge_io_input_rsp_payload_fragment_data;
  wire       [17:0]   bmbUpSizerBridge_io_input_rsp_payload_fragment_context;
  wire                bmbUpSizerBridge_io_output_cmd_valid;
  wire                bmbUpSizerBridge_io_output_cmd_payload_last;
  wire       [0:0]    bmbUpSizerBridge_io_output_cmd_payload_fragment_opcode;
  wire       [31:0]   bmbUpSizerBridge_io_output_cmd_payload_fragment_address;
  wire       [10:0]   bmbUpSizerBridge_io_output_cmd_payload_fragment_length;
  wire       [21:0]   bmbUpSizerBridge_io_output_cmd_payload_fragment_context;
  wire                bmbUpSizerBridge_io_output_rsp_ready;
  wire                readLogic_sourceRemover_io_input_cmd_ready;
  wire                readLogic_sourceRemover_io_input_rsp_valid;
  wire                readLogic_sourceRemover_io_input_rsp_payload_last;
  wire       [0:0]    readLogic_sourceRemover_io_input_rsp_payload_fragment_opcode;
  wire       [255:0]  readLogic_sourceRemover_io_input_rsp_payload_fragment_data;
  wire       [21:0]   readLogic_sourceRemover_io_input_rsp_payload_fragment_context;
  wire                readLogic_sourceRemover_io_output_cmd_valid;
  wire                readLogic_sourceRemover_io_output_cmd_payload_last;
  wire       [0:0]    readLogic_sourceRemover_io_output_cmd_payload_fragment_opcode;
  wire       [31:0]   readLogic_sourceRemover_io_output_cmd_payload_fragment_address;
  wire       [10:0]   readLogic_sourceRemover_io_output_cmd_payload_fragment_length;
  wire       [21:0]   readLogic_sourceRemover_io_output_cmd_payload_fragment_context;
  wire                readLogic_sourceRemover_io_output_rsp_ready;
  wire                readLogic_bridge_io_input_cmd_ready;
  wire                readLogic_bridge_io_input_rsp_valid;
  wire                readLogic_bridge_io_input_rsp_payload_last;
  wire       [0:0]    readLogic_bridge_io_input_rsp_payload_fragment_opcode;
  wire       [255:0]  readLogic_bridge_io_input_rsp_payload_fragment_data;
  wire       [21:0]   readLogic_bridge_io_input_rsp_payload_fragment_context;
  wire                readLogic_bridge_io_output_ar_valid;
  wire       [31:0]   readLogic_bridge_io_output_ar_payload_addr;
  wire       [7:0]    readLogic_bridge_io_output_ar_payload_len;
  wire       [2:0]    readLogic_bridge_io_output_ar_payload_size;
  wire       [3:0]    readLogic_bridge_io_output_ar_payload_cache;
  wire       [2:0]    readLogic_bridge_io_output_ar_payload_prot;
  wire                readLogic_bridge_io_output_r_ready;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_push_ready;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_valid;
  wire       [255:0]  read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_data;
  wire       [1:0]    read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_resp;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_last;
  wire       [8:0]    read_r_s2mPipe_m2sPipe_fifo_io_occupancy;
  wire       [8:0]    read_r_s2mPipe_m2sPipe_fifo_io_availability;
  wire                outputsAdapter_0_crossclock_fifo_io_push_ready;
  wire                outputsAdapter_0_crossclock_fifo_io_pop_valid;
  wire       [63:0]   outputsAdapter_0_crossclock_fifo_io_pop_payload_data;
  wire       [7:0]    outputsAdapter_0_crossclock_fifo_io_pop_payload_mask;
  wire                outputsAdapter_0_crossclock_fifo_io_pop_payload_last;
  wire       [10:0]   outputsAdapter_0_crossclock_fifo_io_pushOccupancy;
  wire       [10:0]   outputsAdapter_0_crossclock_fifo_io_popOccupancy;
  wire                outputsAdapter_0_sparseDownsizer_logic_io_input_ready;
  wire                outputsAdapter_0_sparseDownsizer_logic_io_output_valid;
  wire       [31:0]   outputsAdapter_0_sparseDownsizer_logic_io_output_payload_data;
  wire       [3:0]    outputsAdapter_0_sparseDownsizer_logic_io_output_payload_mask;
  wire                outputsAdapter_0_sparseDownsizer_logic_io_output_payload_last;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire                _zz_18;
  wire                _zz_19;
  wire                read_arvalid;
  wire                read_arready;
  wire       [31:0]   read_araddr;
  wire       [3:0]    read_arregion;
  wire       [7:0]    read_arlen;
  wire       [2:0]    read_arsize;
  wire       [1:0]    read_arburst;
  wire       [0:0]    read_arlock;
  wire       [3:0]    read_arcache;
  wire       [3:0]    read_arqos;
  wire       [2:0]    read_arprot;
  wire                read_rvalid;
  wire                read_rready;
  wire       [255:0]  read_rdata;
  wire       [1:0]    read_rresp;
  wire                read_rlast;
  wire                connectionModel_decoder_cmd_valid;
  wire                connectionModel_decoder_cmd_ready;
  wire                connectionModel_decoder_cmd_payload_last;
  wire       [0:0]    connectionModel_decoder_cmd_payload_fragment_opcode;
  wire       [31:0]   connectionModel_decoder_cmd_payload_fragment_address;
  wire       [10:0]   connectionModel_decoder_cmd_payload_fragment_length;
  wire       [17:0]   connectionModel_decoder_cmd_payload_fragment_context;
  wire                connectionModel_decoder_rsp_valid;
  wire                connectionModel_decoder_rsp_ready;
  wire                connectionModel_decoder_rsp_payload_last;
  wire       [0:0]    connectionModel_decoder_rsp_payload_fragment_opcode;
  wire       [63:0]   connectionModel_decoder_rsp_payload_fragment_data;
  wire       [17:0]   connectionModel_decoder_rsp_payload_fragment_context;
  wire                interconnect_read_aggregated_cmd_valid;
  wire                interconnect_read_aggregated_cmd_ready;
  wire                interconnect_read_aggregated_cmd_payload_last;
  wire       [0:0]    interconnect_read_aggregated_cmd_payload_fragment_opcode;
  wire       [31:0]   interconnect_read_aggregated_cmd_payload_fragment_address;
  wire       [10:0]   interconnect_read_aggregated_cmd_payload_fragment_length;
  wire       [17:0]   interconnect_read_aggregated_cmd_payload_fragment_context;
  wire                interconnect_read_aggregated_rsp_valid;
  wire                interconnect_read_aggregated_rsp_ready;
  wire                interconnect_read_aggregated_rsp_payload_last;
  wire       [0:0]    interconnect_read_aggregated_rsp_payload_fragment_opcode;
  wire       [63:0]   interconnect_read_aggregated_rsp_payload_fragment_data;
  wire       [17:0]   interconnect_read_aggregated_rsp_payload_fragment_context;
  wire                interconnect_read_aggregated_cmd_halfPipe_valid;
  wire                interconnect_read_aggregated_cmd_halfPipe_ready;
  wire                interconnect_read_aggregated_cmd_halfPipe_payload_last;
  wire       [0:0]    interconnect_read_aggregated_cmd_halfPipe_payload_fragment_opcode;
  wire       [31:0]   interconnect_read_aggregated_cmd_halfPipe_payload_fragment_address;
  wire       [10:0]   interconnect_read_aggregated_cmd_halfPipe_payload_fragment_length;
  wire       [17:0]   interconnect_read_aggregated_cmd_halfPipe_payload_fragment_context;
  reg                 interconnect_read_aggregated_cmd_halfPipe_regs_valid;
  reg                 interconnect_read_aggregated_cmd_halfPipe_regs_ready;
  reg                 interconnect_read_aggregated_cmd_halfPipe_regs_payload_last;
  reg        [0:0]    interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_opcode;
  reg        [31:0]   interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_address;
  reg        [10:0]   interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_length;
  reg        [17:0]   interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_context;
  wire                readLogic_adapter_ar_valid;
  wire                readLogic_adapter_ar_ready;
  wire       [31:0]   readLogic_adapter_ar_payload_addr;
  wire       [3:0]    readLogic_adapter_ar_payload_region;
  wire       [7:0]    readLogic_adapter_ar_payload_len;
  wire       [2:0]    readLogic_adapter_ar_payload_size;
  wire       [1:0]    readLogic_adapter_ar_payload_burst;
  wire       [0:0]    readLogic_adapter_ar_payload_lock;
  wire       [3:0]    readLogic_adapter_ar_payload_cache;
  wire       [3:0]    readLogic_adapter_ar_payload_qos;
  wire       [2:0]    readLogic_adapter_ar_payload_prot;
  wire                readLogic_adapter_r_valid;
  wire                readLogic_adapter_r_ready;
  wire       [255:0]  readLogic_adapter_r_payload_data;
  wire       [1:0]    readLogic_adapter_r_payload_resp;
  wire                readLogic_adapter_r_payload_last;
  wire       [3:0]    _zz_1;
  wire                readLogic_adapter_ar_halfPipe_valid;
  wire                readLogic_adapter_ar_halfPipe_ready;
  wire       [31:0]   readLogic_adapter_ar_halfPipe_payload_addr;
  wire       [3:0]    readLogic_adapter_ar_halfPipe_payload_region;
  wire       [7:0]    readLogic_adapter_ar_halfPipe_payload_len;
  wire       [2:0]    readLogic_adapter_ar_halfPipe_payload_size;
  wire       [1:0]    readLogic_adapter_ar_halfPipe_payload_burst;
  wire       [0:0]    readLogic_adapter_ar_halfPipe_payload_lock;
  wire       [3:0]    readLogic_adapter_ar_halfPipe_payload_cache;
  wire       [3:0]    readLogic_adapter_ar_halfPipe_payload_qos;
  wire       [2:0]    readLogic_adapter_ar_halfPipe_payload_prot;
  reg                 readLogic_adapter_ar_halfPipe_regs_valid;
  reg                 readLogic_adapter_ar_halfPipe_regs_ready;
  reg        [31:0]   readLogic_adapter_ar_halfPipe_regs_payload_addr;
  reg        [3:0]    readLogic_adapter_ar_halfPipe_regs_payload_region;
  reg        [7:0]    readLogic_adapter_ar_halfPipe_regs_payload_len;
  reg        [2:0]    readLogic_adapter_ar_halfPipe_regs_payload_size;
  reg        [1:0]    readLogic_adapter_ar_halfPipe_regs_payload_burst;
  reg        [0:0]    readLogic_adapter_ar_halfPipe_regs_payload_lock;
  reg        [3:0]    readLogic_adapter_ar_halfPipe_regs_payload_cache;
  reg        [3:0]    readLogic_adapter_ar_halfPipe_regs_payload_qos;
  reg        [2:0]    readLogic_adapter_ar_halfPipe_regs_payload_prot;
  wire                read_r_s2mPipe_valid;
  wire                read_r_s2mPipe_ready;
  wire       [255:0]  read_r_s2mPipe_payload_data;
  wire       [1:0]    read_r_s2mPipe_payload_resp;
  wire                read_r_s2mPipe_payload_last;
  reg                 read_r_s2mPipe_rValid;
  reg        [255:0]  read_r_s2mPipe_rData_data;
  reg        [1:0]    read_r_s2mPipe_rData_resp;
  reg                 read_r_s2mPipe_rData_last;
  wire                read_r_s2mPipe_m2sPipe_valid;
  wire                read_r_s2mPipe_m2sPipe_ready;
  wire       [255:0]  read_r_s2mPipe_m2sPipe_payload_data;
  wire       [1:0]    read_r_s2mPipe_m2sPipe_payload_resp;
  wire                read_r_s2mPipe_m2sPipe_payload_last;
  reg                 read_r_s2mPipe_m2sPipe_rValid;
  reg        [255:0]  read_r_s2mPipe_m2sPipe_rData_data;
  reg        [1:0]    read_r_s2mPipe_m2sPipe_rData_resp;
  reg                 read_r_s2mPipe_m2sPipe_rData_last;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_valid;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_ready;
  wire       [255:0]  read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_data;
  wire       [1:0]    read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_resp;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_last;
  reg                 read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid;
  reg        [255:0]  read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_data;
  reg        [1:0]    read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_resp;
  reg                 read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_last;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_valid;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_ready;
  wire       [255:0]  read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_data;
  wire       [1:0]    read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_resp;
  wire                read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_last;
  reg                 read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rValid;
  reg        [255:0]  read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_data;
  reg        [1:0]    read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_resp;
  reg                 read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_last;
  wire                core_io_outputs_0_s2mPipe_valid;
  wire                core_io_outputs_0_s2mPipe_ready;
  wire       [63:0]   core_io_outputs_0_s2mPipe_payload_data;
  wire       [7:0]    core_io_outputs_0_s2mPipe_payload_mask;
  wire                core_io_outputs_0_s2mPipe_payload_last;
  reg                 core_io_outputs_0_s2mPipe_rValid;
  reg        [63:0]   core_io_outputs_0_s2mPipe_rData_data;
  reg        [7:0]    core_io_outputs_0_s2mPipe_rData_mask;
  reg                 core_io_outputs_0_s2mPipe_rData_last;
  wire                outputsAdapter_0_ptr_valid;
  wire                outputsAdapter_0_ptr_ready;
  wire       [63:0]   outputsAdapter_0_ptr_payload_data;
  wire       [7:0]    outputsAdapter_0_ptr_payload_mask;
  wire                outputsAdapter_0_ptr_payload_last;
  reg                 core_io_outputs_0_s2mPipe_m2sPipe_rValid;
  reg        [63:0]   core_io_outputs_0_s2mPipe_m2sPipe_rData_data;
  reg        [7:0]    core_io_outputs_0_s2mPipe_m2sPipe_rData_mask;
  reg                 core_io_outputs_0_s2mPipe_m2sPipe_rData_last;

  assign _zz_15 = (! interconnect_read_aggregated_cmd_halfPipe_regs_valid);
  assign _zz_16 = (! readLogic_adapter_ar_halfPipe_regs_valid);
  assign _zz_17 = (read_rready && (! read_r_s2mPipe_ready));
  assign _zz_18 = (_zz_13 && (! read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_ready));
  assign _zz_19 = (_zz_12 && (! core_io_outputs_0_s2mPipe_ready));
  dma_soc_StreamArbiter streamArbiter (
    .io_inputs_0_valid             (read_arvalid                                 ), //i
    .io_inputs_0_ready             (streamArbiter_io_inputs_0_ready              ), //o
    .io_inputs_0_payload_addr      (read_araddr[31:0]                            ), //i
    .io_inputs_0_payload_region    (read_arregion[3:0]                           ), //i
    .io_inputs_0_payload_len       (read_arlen[7:0]                              ), //i
    .io_inputs_0_payload_size      (read_arsize[2:0]                             ), //i
    .io_inputs_0_payload_burst     (read_arburst[1:0]                            ), //i
    .io_inputs_0_payload_lock      (read_arlock                                  ), //i
    .io_inputs_0_payload_cache     (read_arcache[3:0]                            ), //i
    .io_inputs_0_payload_qos       (read_arqos[3:0]                              ), //i
    .io_inputs_0_payload_prot      (read_arprot[2:0]                             ), //i
    .io_inputs_1_valid             (_zz_2                                        ), //i
    .io_inputs_1_ready             (streamArbiter_io_inputs_1_ready              ), //o
    .io_inputs_1_payload_addr      (_zz_3[31:0]                                  ), //i
    .io_inputs_1_payload_region    (_zz_4[3:0]                                   ), //i
    .io_inputs_1_payload_len       (_zz_5[7:0]                                   ), //i
    .io_inputs_1_payload_size      (_zz_6[2:0]                                   ), //i
    .io_inputs_1_payload_burst     (_zz_7[1:0]                                   ), //i
    .io_inputs_1_payload_lock      (_zz_8                                        ), //i
    .io_inputs_1_payload_cache     (_zz_9[3:0]                                   ), //i
    .io_inputs_1_payload_qos       (_zz_10[3:0]                                  ), //i
    .io_inputs_1_payload_prot      (_zz_11[2:0]                                  ), //i
    .io_output_valid               (streamArbiter_io_output_valid                ), //o
    .io_output_ready               (axi_arwready                                 ), //i
    .io_output_payload_addr        (streamArbiter_io_output_payload_addr[31:0]   ), //o
    .io_output_payload_region      (streamArbiter_io_output_payload_region[3:0]  ), //o
    .io_output_payload_len         (streamArbiter_io_output_payload_len[7:0]     ), //o
    .io_output_payload_size        (streamArbiter_io_output_payload_size[2:0]    ), //o
    .io_output_payload_burst       (streamArbiter_io_output_payload_burst[1:0]   ), //o
    .io_output_payload_lock        (streamArbiter_io_output_payload_lock         ), //o
    .io_output_payload_cache       (streamArbiter_io_output_payload_cache[3:0]   ), //o
    .io_output_payload_qos         (streamArbiter_io_output_payload_qos[3:0]     ), //o
    .io_output_payload_prot        (streamArbiter_io_output_payload_prot[2:0]    ), //o
    .io_chosen                     (streamArbiter_io_chosen                      ), //o
    .io_chosenOH                   (streamArbiter_io_chosenOH[1:0]               ), //o
    .clk                           (clk                                          ), //i
    .reset                         (reset                                        )  //i
  );
  dma_soc_Core core (
    .io_read_cmd_valid                       (core_io_read_cmd_valid                                      ), //o
    .io_read_cmd_ready                       (connectionModel_decoder_cmd_ready                           ), //i
    .io_read_cmd_payload_last                (core_io_read_cmd_payload_last                               ), //o
    .io_read_cmd_payload_fragment_opcode     (core_io_read_cmd_payload_fragment_opcode                    ), //o
    .io_read_cmd_payload_fragment_address    (core_io_read_cmd_payload_fragment_address[31:0]             ), //o
    .io_read_cmd_payload_fragment_length     (core_io_read_cmd_payload_fragment_length[10:0]              ), //o
    .io_read_cmd_payload_fragment_context    (core_io_read_cmd_payload_fragment_context[17:0]             ), //o
    .io_read_rsp_valid                       (connectionModel_decoder_rsp_valid                           ), //i
    .io_read_rsp_ready                       (core_io_read_rsp_ready                                      ), //o
    .io_read_rsp_payload_last                (connectionModel_decoder_rsp_payload_last                    ), //i
    .io_read_rsp_payload_fragment_opcode     (connectionModel_decoder_rsp_payload_fragment_opcode         ), //i
    .io_read_rsp_payload_fragment_data       (connectionModel_decoder_rsp_payload_fragment_data[63:0]     ), //i
    .io_read_rsp_payload_fragment_context    (connectionModel_decoder_rsp_payload_fragment_context[17:0]  ), //i
    .io_outputs_0_valid                      (core_io_outputs_0_valid                                     ), //o
    .io_outputs_0_ready                      (_zz_12                                                      ), //i
    .io_outputs_0_payload_data               (core_io_outputs_0_payload_data[63:0]                        ), //o
    .io_outputs_0_payload_mask               (core_io_outputs_0_payload_mask[7:0]                         ), //o
    .io_outputs_0_payload_last               (core_io_outputs_0_payload_last                              ), //o
    .io_interrupts                           (core_io_interrupts                                          ), //o
    .io_ctrl_PADDR                           (withCtrlCc_apbCc_io_output_PADDR[13:0]                      ), //i
    .io_ctrl_PSEL                            (withCtrlCc_apbCc_io_output_PSEL                             ), //i
    .io_ctrl_PENABLE                         (withCtrlCc_apbCc_io_output_PENABLE                          ), //i
    .io_ctrl_PREADY                          (core_io_ctrl_PREADY                                         ), //o
    .io_ctrl_PWRITE                          (withCtrlCc_apbCc_io_output_PWRITE                           ), //i
    .io_ctrl_PWDATA                          (withCtrlCc_apbCc_io_output_PWDATA[31:0]                     ), //i
    .io_ctrl_PRDATA                          (core_io_ctrl_PRDATA[31:0]                                   ), //o
    .io_ctrl_PSLVERROR                       (core_io_ctrl_PSLVERROR                                      ), //o
    .clk                                     (clk                                                         ), //i
    .reset                                   (reset                                                       )  //i
  );
  dma_soc_Apb3CC withCtrlCc_apbCc (
    .io_input_PADDR         (ctrl_PADDR[13:0]                         ), //i
    .io_input_PSEL          (ctrl_PSEL                                ), //i
    .io_input_PENABLE       (ctrl_PENABLE                             ), //i
    .io_input_PREADY        (withCtrlCc_apbCc_io_input_PREADY         ), //o
    .io_input_PWRITE        (ctrl_PWRITE                              ), //i
    .io_input_PWDATA        (ctrl_PWDATA[31:0]                        ), //i
    .io_input_PRDATA        (withCtrlCc_apbCc_io_input_PRDATA[31:0]   ), //o
    .io_input_PSLVERROR     (withCtrlCc_apbCc_io_input_PSLVERROR      ), //o
    .io_output_PADDR        (withCtrlCc_apbCc_io_output_PADDR[13:0]   ), //o
    .io_output_PSEL         (withCtrlCc_apbCc_io_output_PSEL          ), //o
    .io_output_PENABLE      (withCtrlCc_apbCc_io_output_PENABLE       ), //o
    .io_output_PREADY       (core_io_ctrl_PREADY                      ), //i
    .io_output_PWRITE       (withCtrlCc_apbCc_io_output_PWRITE        ), //o
    .io_output_PWDATA       (withCtrlCc_apbCc_io_output_PWDATA[31:0]  ), //o
    .io_output_PRDATA       (core_io_ctrl_PRDATA[31:0]                ), //i
    .io_output_PSLVERROR    (core_io_ctrl_PSLVERROR                   ), //i
    .ctrl_clk               (ctrl_clk                                 ), //i
    .ctrl_reset             (ctrl_reset                               ), //i
    .clk                    (clk                                      ), //i
    .reset                  (reset                                    )  //i
  );
  dma_soc_BufferCC_5 core_io_interrupts_buffercc (
    .io_dataIn     (core_io_interrupts                      ), //i
    .io_dataOut    (core_io_interrupts_buffercc_io_dataOut  ), //o
    .ctrl_clk      (ctrl_clk                                ), //i
    .ctrl_reset    (ctrl_reset                              )  //i
  );
  dma_soc_BmbUpSizerBridge bmbUpSizerBridge (
    .io_input_cmd_valid                        (interconnect_read_aggregated_cmd_halfPipe_valid                           ), //i
    .io_input_cmd_ready                        (bmbUpSizerBridge_io_input_cmd_ready                                       ), //o
    .io_input_cmd_payload_last                 (interconnect_read_aggregated_cmd_halfPipe_payload_last                    ), //i
    .io_input_cmd_payload_fragment_opcode      (interconnect_read_aggregated_cmd_halfPipe_payload_fragment_opcode         ), //i
    .io_input_cmd_payload_fragment_address     (interconnect_read_aggregated_cmd_halfPipe_payload_fragment_address[31:0]  ), //i
    .io_input_cmd_payload_fragment_length      (interconnect_read_aggregated_cmd_halfPipe_payload_fragment_length[10:0]   ), //i
    .io_input_cmd_payload_fragment_context     (interconnect_read_aggregated_cmd_halfPipe_payload_fragment_context[17:0]  ), //i
    .io_input_rsp_valid                        (bmbUpSizerBridge_io_input_rsp_valid                                       ), //o
    .io_input_rsp_ready                        (interconnect_read_aggregated_rsp_ready                                    ), //i
    .io_input_rsp_payload_last                 (bmbUpSizerBridge_io_input_rsp_payload_last                                ), //o
    .io_input_rsp_payload_fragment_opcode      (bmbUpSizerBridge_io_input_rsp_payload_fragment_opcode                     ), //o
    .io_input_rsp_payload_fragment_data        (bmbUpSizerBridge_io_input_rsp_payload_fragment_data[63:0]                 ), //o
    .io_input_rsp_payload_fragment_context     (bmbUpSizerBridge_io_input_rsp_payload_fragment_context[17:0]              ), //o
    .io_output_cmd_valid                       (bmbUpSizerBridge_io_output_cmd_valid                                      ), //o
    .io_output_cmd_ready                       (readLogic_sourceRemover_io_input_cmd_ready                                ), //i
    .io_output_cmd_payload_last                (bmbUpSizerBridge_io_output_cmd_payload_last                               ), //o
    .io_output_cmd_payload_fragment_opcode     (bmbUpSizerBridge_io_output_cmd_payload_fragment_opcode                    ), //o
    .io_output_cmd_payload_fragment_address    (bmbUpSizerBridge_io_output_cmd_payload_fragment_address[31:0]             ), //o
    .io_output_cmd_payload_fragment_length     (bmbUpSizerBridge_io_output_cmd_payload_fragment_length[10:0]              ), //o
    .io_output_cmd_payload_fragment_context    (bmbUpSizerBridge_io_output_cmd_payload_fragment_context[21:0]             ), //o
    .io_output_rsp_valid                       (readLogic_sourceRemover_io_input_rsp_valid                                ), //i
    .io_output_rsp_ready                       (bmbUpSizerBridge_io_output_rsp_ready                                      ), //o
    .io_output_rsp_payload_last                (readLogic_sourceRemover_io_input_rsp_payload_last                         ), //i
    .io_output_rsp_payload_fragment_opcode     (readLogic_sourceRemover_io_input_rsp_payload_fragment_opcode              ), //i
    .io_output_rsp_payload_fragment_data       (readLogic_sourceRemover_io_input_rsp_payload_fragment_data[255:0]         ), //i
    .io_output_rsp_payload_fragment_context    (readLogic_sourceRemover_io_input_rsp_payload_fragment_context[21:0]       ), //i
    .clk                                       (clk                                                                       ), //i
    .reset                                     (reset                                                                     )  //i
  );
  dma_soc_BmbSourceRemover readLogic_sourceRemover (
    .io_input_cmd_valid                        (bmbUpSizerBridge_io_output_cmd_valid                                  ), //i
    .io_input_cmd_ready                        (readLogic_sourceRemover_io_input_cmd_ready                            ), //o
    .io_input_cmd_payload_last                 (bmbUpSizerBridge_io_output_cmd_payload_last                           ), //i
    .io_input_cmd_payload_fragment_opcode      (bmbUpSizerBridge_io_output_cmd_payload_fragment_opcode                ), //i
    .io_input_cmd_payload_fragment_address     (bmbUpSizerBridge_io_output_cmd_payload_fragment_address[31:0]         ), //i
    .io_input_cmd_payload_fragment_length      (bmbUpSizerBridge_io_output_cmd_payload_fragment_length[10:0]          ), //i
    .io_input_cmd_payload_fragment_context     (bmbUpSizerBridge_io_output_cmd_payload_fragment_context[21:0]         ), //i
    .io_input_rsp_valid                        (readLogic_sourceRemover_io_input_rsp_valid                            ), //o
    .io_input_rsp_ready                        (bmbUpSizerBridge_io_output_rsp_ready                                  ), //i
    .io_input_rsp_payload_last                 (readLogic_sourceRemover_io_input_rsp_payload_last                     ), //o
    .io_input_rsp_payload_fragment_opcode      (readLogic_sourceRemover_io_input_rsp_payload_fragment_opcode          ), //o
    .io_input_rsp_payload_fragment_data        (readLogic_sourceRemover_io_input_rsp_payload_fragment_data[255:0]     ), //o
    .io_input_rsp_payload_fragment_context     (readLogic_sourceRemover_io_input_rsp_payload_fragment_context[21:0]   ), //o
    .io_output_cmd_valid                       (readLogic_sourceRemover_io_output_cmd_valid                           ), //o
    .io_output_cmd_ready                       (readLogic_bridge_io_input_cmd_ready                                   ), //i
    .io_output_cmd_payload_last                (readLogic_sourceRemover_io_output_cmd_payload_last                    ), //o
    .io_output_cmd_payload_fragment_opcode     (readLogic_sourceRemover_io_output_cmd_payload_fragment_opcode         ), //o
    .io_output_cmd_payload_fragment_address    (readLogic_sourceRemover_io_output_cmd_payload_fragment_address[31:0]  ), //o
    .io_output_cmd_payload_fragment_length     (readLogic_sourceRemover_io_output_cmd_payload_fragment_length[10:0]   ), //o
    .io_output_cmd_payload_fragment_context    (readLogic_sourceRemover_io_output_cmd_payload_fragment_context[21:0]  ), //o
    .io_output_rsp_valid                       (readLogic_bridge_io_input_rsp_valid                                   ), //i
    .io_output_rsp_ready                       (readLogic_sourceRemover_io_output_rsp_ready                           ), //o
    .io_output_rsp_payload_last                (readLogic_bridge_io_input_rsp_payload_last                            ), //i
    .io_output_rsp_payload_fragment_opcode     (readLogic_bridge_io_input_rsp_payload_fragment_opcode                 ), //i
    .io_output_rsp_payload_fragment_data       (readLogic_bridge_io_input_rsp_payload_fragment_data[255:0]            ), //i
    .io_output_rsp_payload_fragment_context    (readLogic_bridge_io_input_rsp_payload_fragment_context[21:0]          )  //i
  );
  dma_soc_BmbToAxi4ReadOnlyBridge readLogic_bridge (
    .io_input_cmd_valid                       (readLogic_sourceRemover_io_output_cmd_valid                           ), //i
    .io_input_cmd_ready                       (readLogic_bridge_io_input_cmd_ready                                   ), //o
    .io_input_cmd_payload_last                (readLogic_sourceRemover_io_output_cmd_payload_last                    ), //i
    .io_input_cmd_payload_fragment_opcode     (readLogic_sourceRemover_io_output_cmd_payload_fragment_opcode         ), //i
    .io_input_cmd_payload_fragment_address    (readLogic_sourceRemover_io_output_cmd_payload_fragment_address[31:0]  ), //i
    .io_input_cmd_payload_fragment_length     (readLogic_sourceRemover_io_output_cmd_payload_fragment_length[10:0]   ), //i
    .io_input_cmd_payload_fragment_context    (readLogic_sourceRemover_io_output_cmd_payload_fragment_context[21:0]  ), //i
    .io_input_rsp_valid                       (readLogic_bridge_io_input_rsp_valid                                   ), //o
    .io_input_rsp_ready                       (readLogic_sourceRemover_io_output_rsp_ready                           ), //i
    .io_input_rsp_payload_last                (readLogic_bridge_io_input_rsp_payload_last                            ), //o
    .io_input_rsp_payload_fragment_opcode     (readLogic_bridge_io_input_rsp_payload_fragment_opcode                 ), //o
    .io_input_rsp_payload_fragment_data       (readLogic_bridge_io_input_rsp_payload_fragment_data[255:0]            ), //o
    .io_input_rsp_payload_fragment_context    (readLogic_bridge_io_input_rsp_payload_fragment_context[21:0]          ), //o
    .io_output_ar_valid                       (readLogic_bridge_io_output_ar_valid                                   ), //o
    .io_output_ar_ready                       (readLogic_adapter_ar_ready                                            ), //i
    .io_output_ar_payload_addr                (readLogic_bridge_io_output_ar_payload_addr[31:0]                      ), //o
    .io_output_ar_payload_len                 (readLogic_bridge_io_output_ar_payload_len[7:0]                        ), //o
    .io_output_ar_payload_size                (readLogic_bridge_io_output_ar_payload_size[2:0]                       ), //o
    .io_output_ar_payload_cache               (readLogic_bridge_io_output_ar_payload_cache[3:0]                      ), //o
    .io_output_ar_payload_prot                (readLogic_bridge_io_output_ar_payload_prot[2:0]                       ), //o
    .io_output_r_valid                        (readLogic_adapter_r_valid                                             ), //i
    .io_output_r_ready                        (readLogic_bridge_io_output_r_ready                                    ), //o
    .io_output_r_payload_data                 (readLogic_adapter_r_payload_data[255:0]                               ), //i
    .io_output_r_payload_resp                 (readLogic_adapter_r_payload_resp[1:0]                                 ), //i
    .io_output_r_payload_last                 (readLogic_adapter_r_payload_last                                      ), //i
    .clk                                      (clk                                                                   ), //i
    .reset                                    (reset                                                                 )  //i
  );
  dma_soc_StreamFifo_1 read_r_s2mPipe_m2sPipe_fifo (
    .io_push_valid           (read_r_s2mPipe_m2sPipe_valid                            ), //i
    .io_push_ready           (read_r_s2mPipe_m2sPipe_fifo_io_push_ready               ), //o
    .io_push_payload_data    (read_r_s2mPipe_m2sPipe_payload_data[255:0]              ), //i
    .io_push_payload_resp    (read_r_s2mPipe_m2sPipe_payload_resp[1:0]                ), //i
    .io_push_payload_last    (read_r_s2mPipe_m2sPipe_payload_last                     ), //i
    .io_pop_valid            (read_r_s2mPipe_m2sPipe_fifo_io_pop_valid                ), //o
    .io_pop_ready            (_zz_13                                                  ), //i
    .io_pop_payload_data     (read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_data[255:0]  ), //o
    .io_pop_payload_resp     (read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_resp[1:0]    ), //o
    .io_pop_payload_last     (read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_last         ), //o
    .io_flush                (_zz_14                                                  ), //i
    .io_occupancy            (read_r_s2mPipe_m2sPipe_fifo_io_occupancy[8:0]           ), //o
    .io_availability         (read_r_s2mPipe_m2sPipe_fifo_io_availability[8:0]        ), //o
    .clk                     (clk                                                     ), //i
    .reset                   (reset                                                   )  //i
  );
  dma_soc_StreamFifoCC outputsAdapter_0_crossclock_fifo (
    .io_push_valid           (outputsAdapter_0_ptr_valid                                  ), //i
    .io_push_ready           (outputsAdapter_0_crossclock_fifo_io_push_ready              ), //o
    .io_push_payload_data    (outputsAdapter_0_ptr_payload_data[63:0]                     ), //i
    .io_push_payload_mask    (outputsAdapter_0_ptr_payload_mask[7:0]                      ), //i
    .io_push_payload_last    (outputsAdapter_0_ptr_payload_last                           ), //i
    .io_pop_valid            (outputsAdapter_0_crossclock_fifo_io_pop_valid               ), //o
    .io_pop_ready            (outputsAdapter_0_sparseDownsizer_logic_io_input_ready       ), //i
    .io_pop_payload_data     (outputsAdapter_0_crossclock_fifo_io_pop_payload_data[63:0]  ), //o
    .io_pop_payload_mask     (outputsAdapter_0_crossclock_fifo_io_pop_payload_mask[7:0]   ), //o
    .io_pop_payload_last     (outputsAdapter_0_crossclock_fifo_io_pop_payload_last        ), //o
    .io_pushOccupancy        (outputsAdapter_0_crossclock_fifo_io_pushOccupancy[10:0]     ), //o
    .io_popOccupancy         (outputsAdapter_0_crossclock_fifo_io_popOccupancy[10:0]      ), //o
    .clk                     (clk                                                         ), //i
    .reset                   (reset                                                       ), //i
    .hdmi_0_clk              (hdmi_0_clk                                                  ), //i
    .hdmi_0_reset            (hdmi_0_reset                                                )  //i
  );
  dma_soc_BsbDownSizerSparse outputsAdapter_0_sparseDownsizer_logic (
    .io_input_valid            (outputsAdapter_0_crossclock_fifo_io_pop_valid                        ), //i
    .io_input_ready            (outputsAdapter_0_sparseDownsizer_logic_io_input_ready                ), //o
    .io_input_payload_data     (outputsAdapter_0_crossclock_fifo_io_pop_payload_data[63:0]           ), //i
    .io_input_payload_mask     (outputsAdapter_0_crossclock_fifo_io_pop_payload_mask[7:0]            ), //i
    .io_input_payload_last     (outputsAdapter_0_crossclock_fifo_io_pop_payload_last                 ), //i
    .io_output_valid           (outputsAdapter_0_sparseDownsizer_logic_io_output_valid               ), //o
    .io_output_ready           (hdmi_0_tready                                                        ), //i
    .io_output_payload_data    (outputsAdapter_0_sparseDownsizer_logic_io_output_payload_data[31:0]  ), //o
    .io_output_payload_mask    (outputsAdapter_0_sparseDownsizer_logic_io_output_payload_mask[3:0]   ), //o
    .io_output_payload_last    (outputsAdapter_0_sparseDownsizer_logic_io_output_payload_last        ), //o
    .hdmi_0_clk                (hdmi_0_clk                                                           ), //i
    .hdmi_0_reset              (hdmi_0_reset                                                         )  //i
  );
  assign read_arready = streamArbiter_io_inputs_0_ready;
  assign read_rvalid = axi_rvalid;
  assign read_rdata = axi_rdata;
  assign read_rlast = axi_rlast;
  assign read_rresp = axi_rresp;
  assign _zz_2 = 1'b0;
  assign _zz_3 = 32'h0;
  assign _zz_4 = 4'bxxxx;
  assign _zz_5 = 8'h0;
  assign _zz_6 = 3'bxxx;
  assign _zz_7 = 2'bxx;
  assign _zz_8 = 1'bx;
  assign _zz_9 = 4'bxxxx;
  assign _zz_10 = 4'bxxxx;
  assign _zz_11 = 3'bxxx;
  assign axi_arwvalid = streamArbiter_io_output_valid;
  assign axi_arwaddr = streamArbiter_io_output_payload_addr;
  assign axi_arwregion = streamArbiter_io_output_payload_region;
  assign axi_arwlen = streamArbiter_io_output_payload_len;
  assign axi_arwsize = streamArbiter_io_output_payload_size;
  assign axi_arwburst = streamArbiter_io_output_payload_burst;
  assign axi_arwlock = streamArbiter_io_output_payload_lock;
  assign axi_arwcache = streamArbiter_io_output_payload_cache;
  assign axi_arwqos = streamArbiter_io_output_payload_qos;
  assign axi_arwprot = streamArbiter_io_output_payload_prot;
  assign axi_arwwrite = streamArbiter_io_chosenOH[1];
  assign axi_wvalid = 1'b0;
  assign axi_wdata = 256'h0;
  assign axi_wstrb = 32'h0;
  assign axi_wlast = 1'bx;
  assign axi_bready = 1'b1;
  assign axi_rready = read_rready;
  assign ctrl_PREADY = withCtrlCc_apbCc_io_input_PREADY;
  assign ctrl_PRDATA = withCtrlCc_apbCc_io_input_PRDATA;
  assign ctrl_PSLVERROR = withCtrlCc_apbCc_io_input_PSLVERROR;
  assign ctrl_interrupts = core_io_interrupts_buffercc_io_dataOut;
  assign connectionModel_decoder_cmd_valid = core_io_read_cmd_valid;
  assign connectionModel_decoder_rsp_ready = core_io_read_rsp_ready;
  assign connectionModel_decoder_cmd_payload_last = core_io_read_cmd_payload_last;
  assign connectionModel_decoder_cmd_payload_fragment_opcode = core_io_read_cmd_payload_fragment_opcode;
  assign connectionModel_decoder_cmd_payload_fragment_address = core_io_read_cmd_payload_fragment_address;
  assign connectionModel_decoder_cmd_payload_fragment_length = core_io_read_cmd_payload_fragment_length;
  assign connectionModel_decoder_cmd_payload_fragment_context = core_io_read_cmd_payload_fragment_context;
  assign interconnect_read_aggregated_cmd_valid = connectionModel_decoder_cmd_valid;
  assign interconnect_read_aggregated_rsp_ready = connectionModel_decoder_rsp_ready;
  assign interconnect_read_aggregated_cmd_payload_last = connectionModel_decoder_cmd_payload_last;
  assign interconnect_read_aggregated_cmd_payload_fragment_opcode = connectionModel_decoder_cmd_payload_fragment_opcode;
  assign interconnect_read_aggregated_cmd_payload_fragment_address = connectionModel_decoder_cmd_payload_fragment_address;
  assign interconnect_read_aggregated_cmd_payload_fragment_length = connectionModel_decoder_cmd_payload_fragment_length;
  assign interconnect_read_aggregated_cmd_payload_fragment_context = connectionModel_decoder_cmd_payload_fragment_context;
  assign connectionModel_decoder_cmd_ready = interconnect_read_aggregated_cmd_ready;
  assign connectionModel_decoder_rsp_valid = interconnect_read_aggregated_rsp_valid;
  assign connectionModel_decoder_rsp_payload_last = interconnect_read_aggregated_rsp_payload_last;
  assign connectionModel_decoder_rsp_payload_fragment_opcode = interconnect_read_aggregated_rsp_payload_fragment_opcode;
  assign connectionModel_decoder_rsp_payload_fragment_data = interconnect_read_aggregated_rsp_payload_fragment_data;
  assign connectionModel_decoder_rsp_payload_fragment_context = interconnect_read_aggregated_rsp_payload_fragment_context;
  assign interconnect_read_aggregated_cmd_halfPipe_valid = interconnect_read_aggregated_cmd_halfPipe_regs_valid;
  assign interconnect_read_aggregated_cmd_halfPipe_payload_last = interconnect_read_aggregated_cmd_halfPipe_regs_payload_last;
  assign interconnect_read_aggregated_cmd_halfPipe_payload_fragment_opcode = interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_opcode;
  assign interconnect_read_aggregated_cmd_halfPipe_payload_fragment_address = interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_address;
  assign interconnect_read_aggregated_cmd_halfPipe_payload_fragment_length = interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_length;
  assign interconnect_read_aggregated_cmd_halfPipe_payload_fragment_context = interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_context;
  assign interconnect_read_aggregated_cmd_ready = interconnect_read_aggregated_cmd_halfPipe_regs_ready;
  assign interconnect_read_aggregated_cmd_halfPipe_ready = bmbUpSizerBridge_io_input_cmd_ready;
  assign interconnect_read_aggregated_rsp_valid = bmbUpSizerBridge_io_input_rsp_valid;
  assign interconnect_read_aggregated_rsp_payload_last = bmbUpSizerBridge_io_input_rsp_payload_last;
  assign interconnect_read_aggregated_rsp_payload_fragment_opcode = bmbUpSizerBridge_io_input_rsp_payload_fragment_opcode;
  assign interconnect_read_aggregated_rsp_payload_fragment_data = bmbUpSizerBridge_io_input_rsp_payload_fragment_data;
  assign interconnect_read_aggregated_rsp_payload_fragment_context = bmbUpSizerBridge_io_input_rsp_payload_fragment_context;
  assign readLogic_adapter_ar_valid = readLogic_bridge_io_output_ar_valid;
  assign readLogic_adapter_ar_payload_addr = readLogic_bridge_io_output_ar_payload_addr;
  assign _zz_1[3 : 0] = 4'b0000;
  assign readLogic_adapter_ar_payload_region = _zz_1;
  assign readLogic_adapter_ar_payload_len = readLogic_bridge_io_output_ar_payload_len;
  assign readLogic_adapter_ar_payload_size = readLogic_bridge_io_output_ar_payload_size;
  assign readLogic_adapter_ar_payload_burst = 2'b01;
  assign readLogic_adapter_ar_payload_lock = 1'b0;
  assign readLogic_adapter_ar_payload_cache = readLogic_bridge_io_output_ar_payload_cache;
  assign readLogic_adapter_ar_payload_qos = 4'b0000;
  assign readLogic_adapter_ar_payload_prot = readLogic_bridge_io_output_ar_payload_prot;
  assign readLogic_adapter_r_ready = readLogic_bridge_io_output_r_ready;
  assign readLogic_adapter_ar_halfPipe_valid = readLogic_adapter_ar_halfPipe_regs_valid;
  assign readLogic_adapter_ar_halfPipe_payload_addr = readLogic_adapter_ar_halfPipe_regs_payload_addr;
  assign readLogic_adapter_ar_halfPipe_payload_region = readLogic_adapter_ar_halfPipe_regs_payload_region;
  assign readLogic_adapter_ar_halfPipe_payload_len = readLogic_adapter_ar_halfPipe_regs_payload_len;
  assign readLogic_adapter_ar_halfPipe_payload_size = readLogic_adapter_ar_halfPipe_regs_payload_size;
  assign readLogic_adapter_ar_halfPipe_payload_burst = readLogic_adapter_ar_halfPipe_regs_payload_burst;
  assign readLogic_adapter_ar_halfPipe_payload_lock = readLogic_adapter_ar_halfPipe_regs_payload_lock;
  assign readLogic_adapter_ar_halfPipe_payload_cache = readLogic_adapter_ar_halfPipe_regs_payload_cache;
  assign readLogic_adapter_ar_halfPipe_payload_qos = readLogic_adapter_ar_halfPipe_regs_payload_qos;
  assign readLogic_adapter_ar_halfPipe_payload_prot = readLogic_adapter_ar_halfPipe_regs_payload_prot;
  assign readLogic_adapter_ar_ready = readLogic_adapter_ar_halfPipe_regs_ready;
  assign read_arvalid = readLogic_adapter_ar_halfPipe_valid;
  assign readLogic_adapter_ar_halfPipe_ready = read_arready;
  assign read_araddr = readLogic_adapter_ar_halfPipe_payload_addr;
  assign read_arregion = readLogic_adapter_ar_halfPipe_payload_region;
  assign read_arlen = readLogic_adapter_ar_halfPipe_payload_len;
  assign read_arsize = readLogic_adapter_ar_halfPipe_payload_size;
  assign read_arburst = readLogic_adapter_ar_halfPipe_payload_burst;
  assign read_arlock = readLogic_adapter_ar_halfPipe_payload_lock;
  assign read_arcache = readLogic_adapter_ar_halfPipe_payload_cache;
  assign read_arqos = readLogic_adapter_ar_halfPipe_payload_qos;
  assign read_arprot = readLogic_adapter_ar_halfPipe_payload_prot;
  assign read_r_s2mPipe_valid = (read_rvalid || read_r_s2mPipe_rValid);
  assign read_rready = (! read_r_s2mPipe_rValid);
  assign read_r_s2mPipe_payload_data = (read_r_s2mPipe_rValid ? read_r_s2mPipe_rData_data : read_rdata);
  assign read_r_s2mPipe_payload_resp = (read_r_s2mPipe_rValid ? read_r_s2mPipe_rData_resp : read_rresp);
  assign read_r_s2mPipe_payload_last = (read_r_s2mPipe_rValid ? read_r_s2mPipe_rData_last : read_rlast);
  assign read_r_s2mPipe_ready = ((1'b1 && (! read_r_s2mPipe_m2sPipe_valid)) || read_r_s2mPipe_m2sPipe_ready);
  assign read_r_s2mPipe_m2sPipe_valid = read_r_s2mPipe_m2sPipe_rValid;
  assign read_r_s2mPipe_m2sPipe_payload_data = read_r_s2mPipe_m2sPipe_rData_data;
  assign read_r_s2mPipe_m2sPipe_payload_resp = read_r_s2mPipe_m2sPipe_rData_resp;
  assign read_r_s2mPipe_m2sPipe_payload_last = read_r_s2mPipe_m2sPipe_rData_last;
  assign read_r_s2mPipe_m2sPipe_ready = read_r_s2mPipe_m2sPipe_fifo_io_push_ready;
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_valid = (read_r_s2mPipe_m2sPipe_fifo_io_pop_valid || read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid);
  assign _zz_13 = (! read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid);
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_data = (read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid ? read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_data : read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_data);
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_resp = (read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid ? read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_resp : read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_resp);
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_last = (read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid ? read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_last : read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_last);
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_ready = ((1'b1 && (! read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_valid)) || read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_ready);
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_valid = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rValid;
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_data = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_data;
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_resp = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_resp;
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_last = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_last;
  assign readLogic_adapter_r_valid = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_valid;
  assign read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_ready = readLogic_adapter_r_ready;
  assign readLogic_adapter_r_payload_data = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_data;
  assign readLogic_adapter_r_payload_resp = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_resp;
  assign readLogic_adapter_r_payload_last = read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_payload_last;
  assign core_io_outputs_0_s2mPipe_valid = (core_io_outputs_0_valid || core_io_outputs_0_s2mPipe_rValid);
  assign _zz_12 = (! core_io_outputs_0_s2mPipe_rValid);
  assign core_io_outputs_0_s2mPipe_payload_data = (core_io_outputs_0_s2mPipe_rValid ? core_io_outputs_0_s2mPipe_rData_data : core_io_outputs_0_payload_data);
  assign core_io_outputs_0_s2mPipe_payload_mask = (core_io_outputs_0_s2mPipe_rValid ? core_io_outputs_0_s2mPipe_rData_mask : core_io_outputs_0_payload_mask);
  assign core_io_outputs_0_s2mPipe_payload_last = (core_io_outputs_0_s2mPipe_rValid ? core_io_outputs_0_s2mPipe_rData_last : core_io_outputs_0_payload_last);
  assign core_io_outputs_0_s2mPipe_ready = ((1'b1 && (! outputsAdapter_0_ptr_valid)) || outputsAdapter_0_ptr_ready);
  assign outputsAdapter_0_ptr_valid = core_io_outputs_0_s2mPipe_m2sPipe_rValid;
  assign outputsAdapter_0_ptr_payload_data = core_io_outputs_0_s2mPipe_m2sPipe_rData_data;
  assign outputsAdapter_0_ptr_payload_mask = core_io_outputs_0_s2mPipe_m2sPipe_rData_mask;
  assign outputsAdapter_0_ptr_payload_last = core_io_outputs_0_s2mPipe_m2sPipe_rData_last;
  assign outputsAdapter_0_ptr_ready = outputsAdapter_0_crossclock_fifo_io_push_ready;
  assign hdmi_0_tvalid = outputsAdapter_0_sparseDownsizer_logic_io_output_valid;
  assign hdmi_0_tdata = outputsAdapter_0_sparseDownsizer_logic_io_output_payload_data;
  assign hdmi_0_tkeep = outputsAdapter_0_sparseDownsizer_logic_io_output_payload_mask;
  assign hdmi_0_tlast = outputsAdapter_0_sparseDownsizer_logic_io_output_payload_last;
  assign _zz_14 = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      interconnect_read_aggregated_cmd_halfPipe_regs_valid <= 1'b0;
      interconnect_read_aggregated_cmd_halfPipe_regs_ready <= 1'b1;
      readLogic_adapter_ar_halfPipe_regs_valid <= 1'b0;
      readLogic_adapter_ar_halfPipe_regs_ready <= 1'b1;
      read_r_s2mPipe_rValid <= 1'b0;
      read_r_s2mPipe_m2sPipe_rValid <= 1'b0;
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid <= 1'b0;
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rValid <= 1'b0;
      core_io_outputs_0_s2mPipe_rValid <= 1'b0;
      core_io_outputs_0_s2mPipe_m2sPipe_rValid <= 1'b0;
    end else begin
      if(_zz_15)begin
        interconnect_read_aggregated_cmd_halfPipe_regs_valid <= interconnect_read_aggregated_cmd_valid;
        interconnect_read_aggregated_cmd_halfPipe_regs_ready <= (! interconnect_read_aggregated_cmd_valid);
      end else begin
        interconnect_read_aggregated_cmd_halfPipe_regs_valid <= (! interconnect_read_aggregated_cmd_halfPipe_ready);
        interconnect_read_aggregated_cmd_halfPipe_regs_ready <= interconnect_read_aggregated_cmd_halfPipe_ready;
      end
      if(_zz_16)begin
        readLogic_adapter_ar_halfPipe_regs_valid <= readLogic_adapter_ar_valid;
        readLogic_adapter_ar_halfPipe_regs_ready <= (! readLogic_adapter_ar_valid);
      end else begin
        readLogic_adapter_ar_halfPipe_regs_valid <= (! readLogic_adapter_ar_halfPipe_ready);
        readLogic_adapter_ar_halfPipe_regs_ready <= readLogic_adapter_ar_halfPipe_ready;
      end
      if(read_r_s2mPipe_ready)begin
        read_r_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_17)begin
        read_r_s2mPipe_rValid <= read_rvalid;
      end
      if(read_r_s2mPipe_ready)begin
        read_r_s2mPipe_m2sPipe_rValid <= read_r_s2mPipe_valid;
      end
      if(read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_ready)begin
        read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_18)begin
        read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rValid <= read_r_s2mPipe_m2sPipe_fifo_io_pop_valid;
      end
      if(read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_ready)begin
        read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rValid <= read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_valid;
      end
      if(core_io_outputs_0_s2mPipe_ready)begin
        core_io_outputs_0_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_19)begin
        core_io_outputs_0_s2mPipe_rValid <= core_io_outputs_0_valid;
      end
      if(core_io_outputs_0_s2mPipe_ready)begin
        core_io_outputs_0_s2mPipe_m2sPipe_rValid <= core_io_outputs_0_s2mPipe_valid;
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_15)begin
      interconnect_read_aggregated_cmd_halfPipe_regs_payload_last <= interconnect_read_aggregated_cmd_payload_last;
      interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_opcode <= interconnect_read_aggregated_cmd_payload_fragment_opcode;
      interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_address <= interconnect_read_aggregated_cmd_payload_fragment_address;
      interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_length <= interconnect_read_aggregated_cmd_payload_fragment_length;
      interconnect_read_aggregated_cmd_halfPipe_regs_payload_fragment_context <= interconnect_read_aggregated_cmd_payload_fragment_context;
    end
    if(_zz_16)begin
      readLogic_adapter_ar_halfPipe_regs_payload_addr <= readLogic_adapter_ar_payload_addr;
      readLogic_adapter_ar_halfPipe_regs_payload_region <= readLogic_adapter_ar_payload_region;
      readLogic_adapter_ar_halfPipe_regs_payload_len <= readLogic_adapter_ar_payload_len;
      readLogic_adapter_ar_halfPipe_regs_payload_size <= readLogic_adapter_ar_payload_size;
      readLogic_adapter_ar_halfPipe_regs_payload_burst <= readLogic_adapter_ar_payload_burst;
      readLogic_adapter_ar_halfPipe_regs_payload_lock <= readLogic_adapter_ar_payload_lock;
      readLogic_adapter_ar_halfPipe_regs_payload_cache <= readLogic_adapter_ar_payload_cache;
      readLogic_adapter_ar_halfPipe_regs_payload_qos <= readLogic_adapter_ar_payload_qos;
      readLogic_adapter_ar_halfPipe_regs_payload_prot <= readLogic_adapter_ar_payload_prot;
    end
    if(_zz_17)begin
      read_r_s2mPipe_rData_data <= read_rdata;
      read_r_s2mPipe_rData_resp <= read_rresp;
      read_r_s2mPipe_rData_last <= read_rlast;
    end
    if(read_r_s2mPipe_ready)begin
      read_r_s2mPipe_m2sPipe_rData_data <= read_r_s2mPipe_payload_data;
      read_r_s2mPipe_m2sPipe_rData_resp <= read_r_s2mPipe_payload_resp;
      read_r_s2mPipe_m2sPipe_rData_last <= read_r_s2mPipe_payload_last;
    end
    if(_zz_18)begin
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_data <= read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_data;
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_resp <= read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_resp;
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_rData_last <= read_r_s2mPipe_m2sPipe_fifo_io_pop_payload_last;
    end
    if(read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_ready)begin
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_data <= read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_data;
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_resp <= read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_resp;
      read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_m2sPipe_rData_last <= read_r_s2mPipe_m2sPipe_fifo_io_pop_s2mPipe_payload_last;
    end
    if(_zz_19)begin
      core_io_outputs_0_s2mPipe_rData_data <= core_io_outputs_0_payload_data;
      core_io_outputs_0_s2mPipe_rData_mask <= core_io_outputs_0_payload_mask;
      core_io_outputs_0_s2mPipe_rData_last <= core_io_outputs_0_payload_last;
    end
    if(core_io_outputs_0_s2mPipe_ready)begin
      core_io_outputs_0_s2mPipe_m2sPipe_rData_data <= core_io_outputs_0_s2mPipe_payload_data;
      core_io_outputs_0_s2mPipe_m2sPipe_rData_mask <= core_io_outputs_0_s2mPipe_payload_mask;
      core_io_outputs_0_s2mPipe_m2sPipe_rData_last <= core_io_outputs_0_s2mPipe_payload_last;
    end
  end


endmodule

module dma_soc_BsbDownSizerSparse (
  input               io_input_valid,
  output              io_input_ready,
  input      [63:0]   io_input_payload_data,
  input      [7:0]    io_input_payload_mask,
  input               io_input_payload_last,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload_data,
  output     [3:0]    io_output_payload_mask,
  output              io_output_payload_last,
  input               hdmi_0_clk,
  input               hdmi_0_reset
);
  reg        [31:0]   _zz_1;
  reg        [3:0]    _zz_2;
  reg        [0:0]    counter;
  wire                end_1;

  always @(*) begin
    case(counter)
      1'b0 : begin
        _zz_1 = io_input_payload_data[31 : 0];
        _zz_2 = io_input_payload_mask[3 : 0];
      end
      default : begin
        _zz_1 = io_input_payload_data[63 : 32];
        _zz_2 = io_input_payload_mask[7 : 4];
      end
    endcase
  end

  assign end_1 = (counter == 1'b1);
  assign io_input_ready = (io_output_ready && end_1);
  assign io_output_valid = io_input_valid;
  assign io_output_payload_data = _zz_1;
  assign io_output_payload_mask = _zz_2;
  assign io_output_payload_last = (io_input_payload_last && end_1);
  always @ (posedge hdmi_0_clk) begin
    if(hdmi_0_reset) begin
      counter <= 1'b0;
    end else begin
      if((io_output_valid && io_output_ready))begin
        counter <= (counter + 1'b1);
      end
    end
  end


endmodule

module dma_soc_StreamFifoCC (
  input               io_push_valid,
  output              io_push_ready,
  input      [63:0]   io_push_payload_data,
  input      [7:0]    io_push_payload_mask,
  input               io_push_payload_last,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [63:0]   io_pop_payload_data,
  output     [7:0]    io_pop_payload_mask,
  output              io_pop_payload_last,
  output     [10:0]   io_pushOccupancy,
  output     [10:0]   io_popOccupancy,
  input               clk,
  input               reset,
  input               hdmi_0_clk,
  input               hdmi_0_reset
);
  reg        [72:0]   _zz_24;
  wire       [10:0]   popToPushGray_buffercc_io_dataOut;
  wire       [10:0]   pushToPopGray_buffercc_io_dataOut;
  wire                _zz_25;
  wire       [10:0]   _zz_26;
  wire       [9:0]    _zz_27;
  wire       [10:0]   _zz_28;
  wire       [9:0]    _zz_29;
  wire       [0:0]    _zz_30;
  wire       [72:0]   _zz_31;
  wire                _zz_32;
  wire       [0:0]    _zz_33;
  wire       [0:0]    _zz_34;
  wire       [0:0]    _zz_35;
  wire       [0:0]    _zz_36;
  reg                 _zz_1;
  wire       [10:0]   popToPushGray;
  wire       [10:0]   pushToPopGray;
  reg        [10:0]   pushCC_pushPtr;
  wire       [10:0]   pushCC_pushPtrPlus;
  reg        [10:0]   pushCC_pushPtrGray;
  wire       [10:0]   pushCC_popPtrGray;
  wire                pushCC_full;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire                _zz_10;
  wire                _zz_11;
  reg        [10:0]   popCC_popPtr;
  wire       [10:0]   popCC_popPtrPlus;
  reg        [10:0]   popCC_popPtrGray;
  wire       [10:0]   popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [10:0]   _zz_12;
  wire       [72:0]   _zz_13;
  wire                _zz_14;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire                _zz_18;
  wire                _zz_19;
  wire                _zz_20;
  wire                _zz_21;
  wire                _zz_22;
  wire                _zz_23;
  reg [72:0] ram [0:1023];

  assign _zz_25 = (io_push_valid && io_push_ready);
  assign _zz_26 = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_27 = pushCC_pushPtr[9:0];
  assign _zz_28 = (popCC_popPtrPlus >>> 1'b1);
  assign _zz_29 = _zz_12[9:0];
  assign _zz_30 = _zz_13[72 : 72];
  assign _zz_31 = {io_push_payload_last,{io_push_payload_mask,io_push_payload_data}};
  assign _zz_32 = 1'b1;
  assign _zz_33 = _zz_2;
  assign _zz_34 = (pushCC_popPtrGray[0] ^ _zz_2);
  assign _zz_35 = _zz_14;
  assign _zz_36 = (popCC_pushPtrGray[0] ^ _zz_14);
  always @ (posedge clk) begin
    if(_zz_1) begin
      ram[_zz_27] <= _zz_31;
    end
  end

  always @ (posedge hdmi_0_clk) begin
    if(_zz_32) begin
      _zz_24 <= ram[_zz_29];
    end
  end

  dma_soc_BufferCC_3 popToPushGray_buffercc (
    .io_dataIn     (popToPushGray[10:0]                      ), //i
    .io_dataOut    (popToPushGray_buffercc_io_dataOut[10:0]  ), //o
    .clk           (clk                                      ), //i
    .reset         (reset                                    )  //i
  );
  dma_soc_BufferCC_4 pushToPopGray_buffercc (
    .io_dataIn       (pushToPopGray[10:0]                      ), //i
    .io_dataOut      (pushToPopGray_buffercc_io_dataOut[10:0]  ), //o
    .hdmi_0_clk      (hdmi_0_clk                               ), //i
    .hdmi_0_reset    (hdmi_0_reset                             )  //i
  );
  always @ (*) begin
    _zz_1 = 1'b0;
    if(_zz_25)begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 11'h001);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[10 : 9] == (~ pushCC_popPtrGray[10 : 9])) && (pushCC_pushPtrGray[8 : 0] == pushCC_popPtrGray[8 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign _zz_2 = (pushCC_popPtrGray[1] ^ _zz_3);
  assign _zz_3 = (pushCC_popPtrGray[2] ^ _zz_4);
  assign _zz_4 = (pushCC_popPtrGray[3] ^ _zz_5);
  assign _zz_5 = (pushCC_popPtrGray[4] ^ _zz_6);
  assign _zz_6 = (pushCC_popPtrGray[5] ^ _zz_7);
  assign _zz_7 = (pushCC_popPtrGray[6] ^ _zz_8);
  assign _zz_8 = (pushCC_popPtrGray[7] ^ _zz_9);
  assign _zz_9 = (pushCC_popPtrGray[8] ^ _zz_10);
  assign _zz_10 = (pushCC_popPtrGray[9] ^ _zz_11);
  assign _zz_11 = pushCC_popPtrGray[10];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_11,{_zz_10,{_zz_9,{_zz_8,{_zz_7,{_zz_6,{_zz_5,{_zz_4,{_zz_3,{_zz_33,_zz_34}}}}}}}}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 11'h001);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_12 = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_13 = _zz_24;
  assign io_pop_payload_data = _zz_13[63 : 0];
  assign io_pop_payload_mask = _zz_13[71 : 64];
  assign io_pop_payload_last = _zz_30[0];
  assign _zz_14 = (popCC_pushPtrGray[1] ^ _zz_15);
  assign _zz_15 = (popCC_pushPtrGray[2] ^ _zz_16);
  assign _zz_16 = (popCC_pushPtrGray[3] ^ _zz_17);
  assign _zz_17 = (popCC_pushPtrGray[4] ^ _zz_18);
  assign _zz_18 = (popCC_pushPtrGray[5] ^ _zz_19);
  assign _zz_19 = (popCC_pushPtrGray[6] ^ _zz_20);
  assign _zz_20 = (popCC_pushPtrGray[7] ^ _zz_21);
  assign _zz_21 = (popCC_pushPtrGray[8] ^ _zz_22);
  assign _zz_22 = (popCC_pushPtrGray[9] ^ _zz_23);
  assign _zz_23 = popCC_pushPtrGray[10];
  assign io_popOccupancy = ({_zz_23,{_zz_22,{_zz_21,{_zz_20,{_zz_19,{_zz_18,{_zz_17,{_zz_16,{_zz_15,{_zz_35,_zz_36}}}}}}}}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @ (posedge clk) begin
    if(reset) begin
      pushCC_pushPtr <= 11'h0;
      pushCC_pushPtrGray <= 11'h0;
    end else begin
      if((io_push_valid && io_push_ready))begin
        pushCC_pushPtrGray <= (_zz_26 ^ pushCC_pushPtrPlus);
      end
      if(_zz_25)begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @ (posedge hdmi_0_clk) begin
    if(hdmi_0_reset) begin
      popCC_popPtr <= 11'h0;
      popCC_popPtrGray <= 11'h0;
    end else begin
      if((io_pop_valid && io_pop_ready))begin
        popCC_popPtrGray <= (_zz_28 ^ popCC_popPtrPlus);
      end
      if((io_pop_valid && io_pop_ready))begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule

module dma_soc_StreamFifo_1 (
  input               io_push_valid,
  output              io_push_ready,
  input      [255:0]  io_push_payload_data,
  input      [1:0]    io_push_payload_resp,
  input               io_push_payload_last,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [255:0]  io_pop_payload_data,
  output     [1:0]    io_pop_payload_resp,
  output              io_pop_payload_last,
  input               io_flush,
  output     [8:0]    io_occupancy,
  output     [8:0]    io_availability,
  input               clk,
  input               reset
);
  reg        [258:0]  _zz_4;
  wire       [0:0]    _zz_5;
  wire       [7:0]    _zz_6;
  wire       [0:0]    _zz_7;
  wire       [7:0]    _zz_8;
  wire       [0:0]    _zz_9;
  wire       [7:0]    _zz_10;
  wire                _zz_11;
  wire       [258:0]  _zz_12;
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
  reg                 _zz_2;
  wire       [258:0]  _zz_3;
  wire       [7:0]    logic_ptrDif;
  reg [258:0] logic_ram [0:255];

  assign _zz_5 = logic_pushPtr_willIncrement;
  assign _zz_6 = {7'd0, _zz_5};
  assign _zz_7 = logic_popPtr_willIncrement;
  assign _zz_8 = {7'd0, _zz_7};
  assign _zz_9 = _zz_3[258 : 258];
  assign _zz_10 = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_11 = 1'b1;
  assign _zz_12 = {io_push_payload_last,{io_push_payload_resp,io_push_payload_data}};
  always @ (posedge clk) begin
    if(_zz_11) begin
      _zz_4 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= _zz_12;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(logic_pushing)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 8'hff);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_6);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = 8'h0;
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 8'hff);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_8);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = 8'h0;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2 && (! logic_full))));
  assign _zz_3 = _zz_4;
  assign io_pop_payload_data = _zz_3[255 : 0];
  assign io_pop_payload_resp = _zz_3[257 : 256];
  assign io_pop_payload_last = _zz_9[0];
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_10};
  always @ (posedge clk) begin
    if(reset) begin
      logic_pushPtr_value <= 8'h0;
      logic_popPtr_value <= 8'h0;
      logic_risingOccupancy <= 1'b0;
      _zz_2 <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2 <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module dma_soc_BmbToAxi4ReadOnlyBridge (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [10:0]   io_input_cmd_payload_fragment_length,
  input      [21:0]   io_input_cmd_payload_fragment_context,
  output              io_input_rsp_valid,
  input               io_input_rsp_ready,
  output              io_input_rsp_payload_last,
  output     [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [255:0]  io_input_rsp_payload_fragment_data,
  output     [21:0]   io_input_rsp_payload_fragment_context,
  output              io_output_ar_valid,
  input               io_output_ar_ready,
  output     [31:0]   io_output_ar_payload_addr,
  output     [7:0]    io_output_ar_payload_len,
  output     [2:0]    io_output_ar_payload_size,
  output     [3:0]    io_output_ar_payload_cache,
  output     [2:0]    io_output_ar_payload_prot,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [255:0]  io_output_r_payload_data,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  input               clk,
  input               reset
);
  reg        [0:0]    _zz_1;
  wire                contextRemover_io_input_cmd_ready;
  wire                contextRemover_io_input_rsp_valid;
  wire                contextRemover_io_input_rsp_payload_last;
  wire       [0:0]    contextRemover_io_input_rsp_payload_fragment_opcode;
  wire       [255:0]  contextRemover_io_input_rsp_payload_fragment_data;
  wire       [21:0]   contextRemover_io_input_rsp_payload_fragment_context;
  wire                contextRemover_io_output_cmd_valid;
  wire                contextRemover_io_output_cmd_payload_last;
  wire       [0:0]    contextRemover_io_output_cmd_payload_fragment_opcode;
  wire       [31:0]   contextRemover_io_output_cmd_payload_fragment_address;
  wire       [10:0]   contextRemover_io_output_cmd_payload_fragment_length;
  wire                contextRemover_io_output_rsp_ready;
  wire       [6:0]    _zz_2;
  wire       [11:0]   _zz_3;
  wire       [4:0]    _zz_4;
  wire       [11:0]   _zz_5;

  assign _zz_2 = _zz_3[11 : 5];
  assign _zz_3 = ({1'b0,contextRemover_io_output_cmd_payload_fragment_length} + _zz_5);
  assign _zz_4 = contextRemover_io_output_cmd_payload_fragment_address[4 : 0];
  assign _zz_5 = {7'd0, _zz_4};
  dma_soc_BmbContextRemover contextRemover (
    .io_input_cmd_valid                        (io_input_cmd_valid                                           ), //i
    .io_input_cmd_ready                        (contextRemover_io_input_cmd_ready                            ), //o
    .io_input_cmd_payload_last                 (io_input_cmd_payload_last                                    ), //i
    .io_input_cmd_payload_fragment_opcode      (io_input_cmd_payload_fragment_opcode                         ), //i
    .io_input_cmd_payload_fragment_address     (io_input_cmd_payload_fragment_address[31:0]                  ), //i
    .io_input_cmd_payload_fragment_length      (io_input_cmd_payload_fragment_length[10:0]                   ), //i
    .io_input_cmd_payload_fragment_context     (io_input_cmd_payload_fragment_context[21:0]                  ), //i
    .io_input_rsp_valid                        (contextRemover_io_input_rsp_valid                            ), //o
    .io_input_rsp_ready                        (io_input_rsp_ready                                           ), //i
    .io_input_rsp_payload_last                 (contextRemover_io_input_rsp_payload_last                     ), //o
    .io_input_rsp_payload_fragment_opcode      (contextRemover_io_input_rsp_payload_fragment_opcode          ), //o
    .io_input_rsp_payload_fragment_data        (contextRemover_io_input_rsp_payload_fragment_data[255:0]     ), //o
    .io_input_rsp_payload_fragment_context     (contextRemover_io_input_rsp_payload_fragment_context[21:0]   ), //o
    .io_output_cmd_valid                       (contextRemover_io_output_cmd_valid                           ), //o
    .io_output_cmd_ready                       (io_output_ar_ready                                           ), //i
    .io_output_cmd_payload_last                (contextRemover_io_output_cmd_payload_last                    ), //o
    .io_output_cmd_payload_fragment_opcode     (contextRemover_io_output_cmd_payload_fragment_opcode         ), //o
    .io_output_cmd_payload_fragment_address    (contextRemover_io_output_cmd_payload_fragment_address[31:0]  ), //o
    .io_output_cmd_payload_fragment_length     (contextRemover_io_output_cmd_payload_fragment_length[10:0]   ), //o
    .io_output_rsp_valid                       (io_output_r_valid                                            ), //i
    .io_output_rsp_ready                       (contextRemover_io_output_rsp_ready                           ), //o
    .io_output_rsp_payload_last                (io_output_r_payload_last                                     ), //i
    .io_output_rsp_payload_fragment_opcode     (_zz_1                                                        ), //i
    .io_output_rsp_payload_fragment_data       (io_output_r_payload_data[255:0]                              ), //i
    .clk                                       (clk                                                          ), //i
    .reset                                     (reset                                                        )  //i
  );
  assign io_input_cmd_ready = contextRemover_io_input_cmd_ready;
  assign io_input_rsp_valid = contextRemover_io_input_rsp_valid;
  assign io_input_rsp_payload_last = contextRemover_io_input_rsp_payload_last;
  assign io_input_rsp_payload_fragment_opcode = contextRemover_io_input_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = contextRemover_io_input_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = contextRemover_io_input_rsp_payload_fragment_context;
  assign io_output_ar_valid = contextRemover_io_output_cmd_valid;
  assign io_output_ar_payload_addr = contextRemover_io_output_cmd_payload_fragment_address;
  assign io_output_ar_payload_len = {1'd0, _zz_2};
  assign io_output_ar_payload_size = 3'b101;
  assign io_output_ar_payload_prot = 3'b010;
  assign io_output_ar_payload_cache = 4'b1111;
  assign io_output_r_ready = contextRemover_io_output_rsp_ready;
  always @ (*) begin
    if((io_output_r_payload_resp == 2'b00))begin
      _zz_1 = 1'b0;
    end else begin
      _zz_1 = 1'b1;
    end
  end


endmodule

module dma_soc_BmbSourceRemover (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [10:0]   io_input_cmd_payload_fragment_length,
  input      [21:0]   io_input_cmd_payload_fragment_context,
  output              io_input_rsp_valid,
  input               io_input_rsp_ready,
  output              io_input_rsp_payload_last,
  output     [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [255:0]  io_input_rsp_payload_fragment_data,
  output     [21:0]   io_input_rsp_payload_fragment_context,
  output              io_output_cmd_valid,
  input               io_output_cmd_ready,
  output              io_output_cmd_payload_last,
  output     [0:0]    io_output_cmd_payload_fragment_opcode,
  output     [31:0]   io_output_cmd_payload_fragment_address,
  output     [10:0]   io_output_cmd_payload_fragment_length,
  output     [21:0]   io_output_cmd_payload_fragment_context,
  input               io_output_rsp_valid,
  output              io_output_rsp_ready,
  input               io_output_rsp_payload_last,
  input      [0:0]    io_output_rsp_payload_fragment_opcode,
  input      [255:0]  io_output_rsp_payload_fragment_data,
  input      [21:0]   io_output_rsp_payload_fragment_context
);
  wire       [21:0]   cmdContext_context;
  wire       [21:0]   rspContext_context;

  assign cmdContext_context = io_input_cmd_payload_fragment_context;
  assign io_output_cmd_valid = io_input_cmd_valid;
  assign io_input_cmd_ready = io_output_cmd_ready;
  assign io_output_cmd_payload_last = io_input_cmd_payload_last;
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_output_cmd_payload_fragment_context = cmdContext_context;
  assign rspContext_context = io_output_rsp_payload_fragment_context[21 : 0];
  assign io_input_rsp_valid = io_output_rsp_valid;
  assign io_output_rsp_ready = io_input_rsp_ready;
  assign io_input_rsp_payload_last = io_output_rsp_payload_last;
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = rspContext_context;

endmodule

module dma_soc_BmbUpSizerBridge (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [10:0]   io_input_cmd_payload_fragment_length,
  input      [17:0]   io_input_cmd_payload_fragment_context,
  output              io_input_rsp_valid,
  input               io_input_rsp_ready,
  output reg          io_input_rsp_payload_last,
  output     [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [63:0]   io_input_rsp_payload_fragment_data,
  output     [17:0]   io_input_rsp_payload_fragment_context,
  output              io_output_cmd_valid,
  input               io_output_cmd_ready,
  output              io_output_cmd_payload_last,
  output     [0:0]    io_output_cmd_payload_fragment_opcode,
  output     [31:0]   io_output_cmd_payload_fragment_address,
  output     [10:0]   io_output_cmd_payload_fragment_length,
  output     [21:0]   io_output_cmd_payload_fragment_context,
  input               io_output_rsp_valid,
  output              io_output_rsp_ready,
  input               io_output_rsp_payload_last,
  input      [0:0]    io_output_rsp_payload_fragment_opcode,
  input      [255:0]  io_output_rsp_payload_fragment_data,
  input      [21:0]   io_output_rsp_payload_fragment_context,
  input               clk,
  input               reset
);
  reg        [63:0]   _zz_2;
  wire       [8:0]    _zz_3;
  wire       [1:0]    _zz_4;
  wire       [8:0]    _zz_5;
  wire       [11:0]   _zz_6;
  wire       [2:0]    _zz_7;
  wire       [11:0]   _zz_8;
  wire       [1:0]    cmdArea_selStart;
  wire       [1:0]    cmdArea_context_selStart;
  wire       [1:0]    cmdArea_context_selEnd;
  wire       [17:0]   cmdArea_context_context;
  wire       [1:0]    rspArea_context_selStart;
  wire       [1:0]    rspArea_context_selEnd;
  wire       [17:0]   rspArea_context_context;
  wire       [21:0]   _zz_1;
  reg        [1:0]    rspArea_readLogic_selReg;
  reg                 io_input_rsp_payload_first;
  wire       [1:0]    rspArea_readLogic_sel;

  assign _zz_3 = (_zz_5 + _zz_6[11 : 3]);
  assign _zz_4 = io_input_cmd_payload_fragment_address[4 : 3];
  assign _zz_5 = {7'd0, _zz_4};
  assign _zz_6 = ({1'b0,io_input_cmd_payload_fragment_length} + _zz_8);
  assign _zz_7 = io_input_cmd_payload_fragment_address[2 : 0];
  assign _zz_8 = {9'd0, _zz_7};
  always @(*) begin
    case(rspArea_readLogic_sel)
      2'b00 : begin
        _zz_2 = io_output_rsp_payload_fragment_data[63 : 0];
      end
      2'b01 : begin
        _zz_2 = io_output_rsp_payload_fragment_data[127 : 64];
      end
      2'b10 : begin
        _zz_2 = io_output_rsp_payload_fragment_data[191 : 128];
      end
      default : begin
        _zz_2 = io_output_rsp_payload_fragment_data[255 : 192];
      end
    endcase
  end

  assign cmdArea_selStart = io_input_cmd_payload_fragment_address[4 : 3];
  assign cmdArea_context_context = io_input_cmd_payload_fragment_context;
  assign cmdArea_context_selStart = cmdArea_selStart;
  assign cmdArea_context_selEnd = _zz_3[1:0];
  assign io_output_cmd_payload_last = io_input_cmd_payload_last;
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_output_cmd_payload_fragment_context = {cmdArea_context_context,{cmdArea_context_selEnd,cmdArea_context_selStart}};
  assign io_output_cmd_valid = io_input_cmd_valid;
  assign io_input_cmd_ready = io_output_cmd_ready;
  assign _zz_1 = io_output_rsp_payload_fragment_context;
  assign rspArea_context_selStart = _zz_1[1 : 0];
  assign rspArea_context_selEnd = _zz_1[3 : 2];
  assign rspArea_context_context = _zz_1[21 : 4];
  assign io_input_rsp_valid = io_output_rsp_valid;
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_context = rspArea_context_context;
  assign rspArea_readLogic_sel = (io_input_rsp_payload_first ? rspArea_context_selStart : rspArea_readLogic_selReg);
  always @ (*) begin
    io_input_rsp_payload_last = (io_output_rsp_payload_last && (rspArea_readLogic_sel == rspArea_context_selEnd));
    if((rspArea_context_selEnd != rspArea_readLogic_sel))begin
      io_input_rsp_payload_last = 1'b0;
    end
  end

  assign io_output_rsp_ready = (io_input_rsp_ready && (io_input_rsp_payload_last || (rspArea_readLogic_sel == 2'b11)));
  assign io_input_rsp_payload_fragment_data = _zz_2;
  always @ (posedge clk) begin
    if(reset) begin
      io_input_rsp_payload_first <= 1'b1;
    end else begin
      if((io_input_rsp_valid && io_input_rsp_ready))begin
        io_input_rsp_payload_first <= io_input_rsp_payload_last;
      end
    end
  end

  always @ (posedge clk) begin
    rspArea_readLogic_selReg <= rspArea_readLogic_sel;
    if((io_input_rsp_valid && io_input_rsp_ready))begin
      rspArea_readLogic_selReg <= (rspArea_readLogic_sel + 2'b01);
    end
  end


endmodule

module dma_soc_BufferCC_5 (
  input      [0:0]    io_dataIn,
  output     [0:0]    io_dataOut,
  input               ctrl_clk,
  input               ctrl_reset
);
  reg        [0:0]    buffers_0;
  reg        [0:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge ctrl_clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module dma_soc_Apb3CC (
  input      [13:0]   io_input_PADDR,
  input      [0:0]    io_input_PSEL,
  input               io_input_PENABLE,
  output              io_input_PREADY,
  input               io_input_PWRITE,
  input      [31:0]   io_input_PWDATA,
  output     [31:0]   io_input_PRDATA,
  output              io_input_PSLVERROR,
  output     [13:0]   io_output_PADDR,
  output reg [0:0]    io_output_PSEL,
  output reg          io_output_PENABLE,
  input               io_output_PREADY,
  output              io_output_PWRITE,
  output     [31:0]   io_output_PWDATA,
  input      [31:0]   io_output_PRDATA,
  input               io_output_PSLVERROR,
  input               ctrl_clk,
  input               ctrl_reset,
  input               clk,
  input               reset
);
  reg                 _zz_1;
  wire                streamCCByToggle_io_input_ready;
  wire                streamCCByToggle_io_output_valid;
  wire       [13:0]   streamCCByToggle_io_output_payload_PADDR;
  wire                streamCCByToggle_io_output_payload_PWRITE;
  wire       [31:0]   streamCCByToggle_io_output_payload_PWDATA;
  wire                flowCCByToggle_io_output_valid;
  wire       [31:0]   flowCCByToggle_io_output_payload_PRDATA;
  wire                flowCCByToggle_io_output_payload_PSLVERROR;
  wire                _zz_2;
  wire                inputLogic_inputCmd_valid;
  wire                inputLogic_inputCmd_ready;
  wire       [13:0]   inputLogic_inputCmd_payload_PADDR;
  wire                inputLogic_inputCmd_payload_PWRITE;
  wire       [31:0]   inputLogic_inputCmd_payload_PWDATA;
  wire                inputLogic_inputRsp_valid;
  wire       [31:0]   inputLogic_inputRsp_payload_PRDATA;
  wire                inputLogic_inputRsp_payload_PSLVERROR;
  reg                 inputLogic_state;
  reg                 outputLogic_state;
  wire                outputLogic_outputRsp_valid;
  wire       [31:0]   outputLogic_outputRsp_payload_PRDATA;
  wire                outputLogic_outputRsp_payload_PSLVERROR;

  assign _zz_2 = (! outputLogic_state);
  dma_soc_StreamCCByToggle streamCCByToggle (
    .io_input_valid              (inputLogic_inputCmd_valid                        ), //i
    .io_input_ready              (streamCCByToggle_io_input_ready                  ), //o
    .io_input_payload_PADDR      (inputLogic_inputCmd_payload_PADDR[13:0]          ), //i
    .io_input_payload_PWRITE     (inputLogic_inputCmd_payload_PWRITE               ), //i
    .io_input_payload_PWDATA     (inputLogic_inputCmd_payload_PWDATA[31:0]         ), //i
    .io_output_valid             (streamCCByToggle_io_output_valid                 ), //o
    .io_output_ready             (_zz_1                                            ), //i
    .io_output_payload_PADDR     (streamCCByToggle_io_output_payload_PADDR[13:0]   ), //o
    .io_output_payload_PWRITE    (streamCCByToggle_io_output_payload_PWRITE        ), //o
    .io_output_payload_PWDATA    (streamCCByToggle_io_output_payload_PWDATA[31:0]  ), //o
    .ctrl_clk                    (ctrl_clk                                         ), //i
    .ctrl_reset                  (ctrl_reset                                       ), //i
    .clk                         (clk                                              ), //i
    .reset                       (reset                                            )  //i
  );
  dma_soc_FlowCCByToggle flowCCByToggle (
    .io_input_valid                 (outputLogic_outputRsp_valid                    ), //i
    .io_input_payload_PRDATA        (outputLogic_outputRsp_payload_PRDATA[31:0]     ), //i
    .io_input_payload_PSLVERROR     (outputLogic_outputRsp_payload_PSLVERROR        ), //i
    .io_output_valid                (flowCCByToggle_io_output_valid                 ), //o
    .io_output_payload_PRDATA       (flowCCByToggle_io_output_payload_PRDATA[31:0]  ), //o
    .io_output_payload_PSLVERROR    (flowCCByToggle_io_output_payload_PSLVERROR     ), //o
    .clk                            (clk                                            ), //i
    .reset                          (reset                                          ), //i
    .ctrl_clk                       (ctrl_clk                                       ), //i
    .ctrl_reset                     (ctrl_reset                                     )  //i
  );
  assign inputLogic_inputCmd_valid = ((io_input_PSEL[0] && io_input_PENABLE) && (! inputLogic_state));
  assign inputLogic_inputCmd_payload_PADDR = io_input_PADDR;
  assign inputLogic_inputCmd_payload_PWRITE = io_input_PWRITE;
  assign inputLogic_inputCmd_payload_PWDATA = io_input_PWDATA;
  assign io_input_PREADY = inputLogic_inputRsp_valid;
  assign io_input_PRDATA = inputLogic_inputRsp_payload_PRDATA;
  assign io_input_PSLVERROR = inputLogic_inputRsp_payload_PSLVERROR;
  assign inputLogic_inputCmd_ready = streamCCByToggle_io_input_ready;
  always @ (*) begin
    io_output_PENABLE = 1'b0;
    if(streamCCByToggle_io_output_valid)begin
      if(_zz_2)begin
        io_output_PENABLE = 1'b0;
      end else begin
        io_output_PENABLE = 1'b1;
      end
    end
  end

  always @ (*) begin
    io_output_PSEL = 1'b0;
    if(streamCCByToggle_io_output_valid)begin
      io_output_PSEL = 1'b1;
    end
  end

  assign io_output_PADDR = streamCCByToggle_io_output_payload_PADDR;
  assign io_output_PWDATA = streamCCByToggle_io_output_payload_PWDATA;
  assign io_output_PWRITE = streamCCByToggle_io_output_payload_PWRITE;
  always @ (*) begin
    _zz_1 = 1'b0;
    if(streamCCByToggle_io_output_valid)begin
      if(! _zz_2) begin
        if(io_output_PREADY)begin
          _zz_1 = 1'b1;
        end
      end
    end
  end

  assign outputLogic_outputRsp_valid = (streamCCByToggle_io_output_valid && _zz_1);
  assign outputLogic_outputRsp_payload_PRDATA = io_output_PRDATA;
  assign outputLogic_outputRsp_payload_PSLVERROR = io_output_PSLVERROR;
  assign inputLogic_inputRsp_valid = flowCCByToggle_io_output_valid;
  assign inputLogic_inputRsp_payload_PRDATA = flowCCByToggle_io_output_payload_PRDATA;
  assign inputLogic_inputRsp_payload_PSLVERROR = flowCCByToggle_io_output_payload_PSLVERROR;
  always @ (posedge ctrl_clk) begin
    if(ctrl_reset) begin
      inputLogic_state <= 1'b0;
    end else begin
      if((inputLogic_inputCmd_valid && inputLogic_inputCmd_ready))begin
        inputLogic_state <= 1'b1;
      end
      if(inputLogic_inputRsp_valid)begin
        inputLogic_state <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      outputLogic_state <= 1'b0;
    end else begin
      if(streamCCByToggle_io_output_valid)begin
        if(_zz_2)begin
          outputLogic_state <= 1'b1;
        end else begin
          if(io_output_PREADY)begin
            outputLogic_state <= 1'b0;
          end
        end
      end
    end
  end


endmodule

module dma_soc_Core (
  output reg          io_read_cmd_valid,
  input               io_read_cmd_ready,
  output              io_read_cmd_payload_last,
  output     [0:0]    io_read_cmd_payload_fragment_opcode,
  output     [31:0]   io_read_cmd_payload_fragment_address,
  output     [10:0]   io_read_cmd_payload_fragment_length,
  output     [17:0]   io_read_cmd_payload_fragment_context,
  input               io_read_rsp_valid,
  output              io_read_rsp_ready,
  input               io_read_rsp_payload_last,
  input      [0:0]    io_read_rsp_payload_fragment_opcode,
  input      [63:0]   io_read_rsp_payload_fragment_data,
  input      [17:0]   io_read_rsp_payload_fragment_context,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output     [63:0]   io_outputs_0_payload_data,
  output     [7:0]    io_outputs_0_payload_mask,
  output              io_outputs_0_payload_last,
  output reg [0:0]    io_interrupts,
  input      [13:0]   io_ctrl_PADDR,
  input      [0:0]    io_ctrl_PSEL,
  input               io_ctrl_PENABLE,
  output              io_ctrl_PREADY,
  input               io_ctrl_PWRITE,
  input      [31:0]   io_ctrl_PWDATA,
  output reg [31:0]   io_ctrl_PRDATA,
  output              io_ctrl_PSLVERROR,
  input               clk,
  input               reset
);
  wire       [7:0]    _zz_14;
  reg        [7:0]    _zz_15;
  wire       [5:0]    _zz_16;
  wire                _zz_17;
  wire       [7:0]    _zz_18;
  wire       [2:0]    _zz_19;
  reg        [0:0]    _zz_20;
  wire                memory_core_io_writes_0_cmd_ready;
  wire                memory_core_io_writes_0_rsp_valid;
  wire       [5:0]    memory_core_io_writes_0_rsp_payload_context;
  wire                memory_core_io_reads_0_cmd_ready;
  wire                memory_core_io_reads_0_rsp_valid;
  wire       [63:0]   memory_core_io_reads_0_rsp_payload_data;
  wire       [7:0]    memory_core_io_reads_0_rsp_payload_mask;
  wire       [2:0]    memory_core_io_reads_0_rsp_payload_context;
  wire                _zz_21;
  wire                _zz_22;
  wire                _zz_23;
  wire                _zz_24;
  wire       [11:0]   _zz_25;
  wire       [3:0]    _zz_26;
  wire       [0:0]    _zz_27;
  wire       [3:0]    _zz_28;
  wire       [0:0]    _zz_29;
  wire       [3:0]    _zz_30;
  wire       [7:0]    _zz_31;
  wire       [8:0]    _zz_32;
  wire       [25:0]   _zz_33;
  wire       [31:0]   _zz_34;
  wire       [31:0]   _zz_35;
  wire       [8:0]    _zz_36;
  wire       [0:0]    _zz_37;
  wire       [0:0]    _zz_38;
  wire       [1:0]    _zz_39;
  wire       [0:0]    _zz_40;
  wire       [1:0]    _zz_41;
  wire       [25:0]   _zz_42;
  wire       [25:0]   _zz_43;
  wire       [25:0]   _zz_44;
  wire       [25:0]   _zz_45;
  wire       [31:0]   _zz_46;
  wire       [31:0]   _zz_47;
  wire       [31:0]   _zz_48;
  wire       [31:0]   _zz_49;
  wire       [25:0]   _zz_50;
  wire       [25:0]   _zz_51;
  wire       [11:0]   _zz_52;
  wire       [10:0]   _zz_53;
  wire       [2:0]    _zz_54;
  wire       [10:0]   _zz_55;
  wire       [1:0]    _zz_56;
  wire       [11:0]   _zz_57;
  wire       [0:0]    _zz_58;
  wire       [0:0]    _zz_59;
  wire       [0:0]    _zz_60;
  wire       [0:0]    _zz_61;
  wire       [0:0]    _zz_62;
  wire       [0:0]    _zz_63;
  wire       [0:0]    _zz_64;
  wire       [0:0]    _zz_65;
  wire       [0:0]    _zz_66;
  wire       [0:0]    _zz_67;
  wire       [0:0]    _zz_68;
  wire       [31:0]   _zz_69;
  wire       [31:0]   _zz_70;
  wire       [0:0]    _zz_71;
  wire       [0:0]    _zz_72;
  wire       [0:0]    _zz_73;
  wire       [0:0]    _zz_74;
  wire       [0:0]    _zz_75;
  wire       [0:0]    _zz_76;
  wire       [0:0]    _zz_77;
  wire       [0:0]    _zz_78;
  wire       [8:0]    _zz_79;
  wire       [3:0]    _zz_80;
  wire       [11:0]   _zz_81;
  wire       [3:0]    _zz_82;
  wire       [0:0]    _zz_83;
  wire       [8:0]    _zz_84;
  wire                ctrl_askWrite;
  wire                ctrl_askRead;
  wire                ctrl_doWrite;
  wire                ctrl_doRead;
  reg                 channels_0_channelStart;
  reg                 channels_0_channelStop;
  reg                 channels_0_channelCompletion;
  reg                 channels_0_channelValid;
  reg                 channels_0_descriptorStart;
  reg                 channels_0_descriptorCompletion;
  reg                 channels_0_descriptorValid;
  reg        [25:0]   channels_0_bytes;
  reg        [1:0]    channels_0_priority;
  reg        [1:0]    channels_0_weight;
  reg                 channels_0_selfRestart;
  reg                 channels_0_readyToStop;
  reg                 channels_0_ctrl_kick;
  wire       [8:0]    channels_0_fifo_base;
  wire       [8:0]    channels_0_fifo_words;
  reg        [8:0]    channels_0_fifo_push_available;
  reg        [8:0]    channels_0_fifo_push_availableDecr;
  reg        [8:0]    channels_0_fifo_push_ptr;
  wire       [8:0]    channels_0_fifo_push_ptrWithBase;
  wire       [8:0]    channels_0_fifo_push_ptrIncr_value;
  reg        [8:0]    channels_0_fifo_pop_ptr;
  wire       [11:0]   channels_0_fifo_pop_bytes;
  wire       [8:0]    channels_0_fifo_pop_ptrWithBase;
  wire       [11:0]   channels_0_fifo_pop_bytesIncr_value;
  wire       [11:0]   channels_0_fifo_pop_bytesDecr_value;
  wire                channels_0_fifo_pop_empty;
  wire       [8:0]    channels_0_fifo_pop_ptrIncr_value;
  reg        [11:0]   channels_0_fifo_pop_withoutOverride_exposed;
  wire                channels_0_fifo_empty;
  reg                 channels_0_push_memory;
  reg        [31:0]   channels_0_push_m2b_address;
  wire       [10:0]   channels_0_push_m2b_bytePerBurst;
  reg                 channels_0_push_m2b_loadDone;
  reg        [25:0]   channels_0_push_m2b_bytesLeft;
  reg        [3:0]    channels_0_push_m2b_memPending;
  reg                 channels_0_push_m2b_memPendingIncr;
  reg                 channels_0_push_m2b_memPendingDecr;
  reg                 channels_0_push_m2b_loadRequest;
  reg                 channels_0_pop_memory;
  reg                 channels_0_pop_b2s_last;
  reg                 channels_0_pop_b2s_veryLastTrigger;
  reg                 channels_0_pop_b2s_veryLastValid;
  reg        [8:0]    channels_0_pop_b2s_veryLastPtr;
  reg                 channels_0_pop_b2s_veryLastEndPacket;
  reg                 channels_0_readyForChannelCompletion;
  reg                 _zz_1;
  wire                channels_0_s2b_full;
  reg        [8:0]    channels_0_fifo_pop_ptrIncr_value_regNext;
  reg                 channels_0_interrupts_completion_enable;
  reg                 channels_0_interrupts_completion_valid;
  reg                 channels_0_interrupts_onChannelCompletion_enable;
  reg                 channels_0_interrupts_onChannelCompletion_valid;
  wire       [0:0]    b2s_0_cmd_channelsOh;
  wire       [0:0]    b2s_0_cmd_context_channel;
  wire                b2s_0_cmd_context_veryLast;
  wire                b2s_0_cmd_context_endPacket;
  wire       [8:0]    b2s_0_cmd_veryLastPtr;
  wire       [8:0]    b2s_0_cmd_address;
  wire       [0:0]    b2s_0_rsp_context_channel;
  wire                b2s_0_rsp_context_veryLast;
  wire                b2s_0_rsp_context_endPacket;
  wire       [2:0]    _zz_2;
  reg                 m2b_cmd_s0_valid;
  wire       [1:0]    _zz_3;
  wire       [0:0]    m2b_cmd_s0_priority_masked;
  reg        [0:0]    m2b_cmd_s0_priority_roundRobins_0;
  reg        [0:0]    m2b_cmd_s0_priority_roundRobins_1;
  reg        [0:0]    m2b_cmd_s0_priority_roundRobins_2;
  reg        [0:0]    m2b_cmd_s0_priority_roundRobins_3;
  reg        [1:0]    m2b_cmd_s0_priority_counter;
  wire       [0:0]    _zz_4;
  wire       [1:0]    _zz_5;
  wire       [1:0]    _zz_6;
  wire       [0:0]    m2b_cmd_s0_priority_chosenOh;
  wire                m2b_cmd_s0_priority_weightLast;
  wire       [0:0]    m2b_cmd_s0_priority_contextNext;
  wire       [31:0]   m2b_cmd_s0_address;
  wire       [25:0]   m2b_cmd_s0_bytesLeft;
  wire       [10:0]   m2b_cmd_s0_readAddressBurstRange;
  wire       [10:0]   m2b_cmd_s0_lengthHead;
  wire       [10:0]   m2b_cmd_s0_length;
  wire                m2b_cmd_s0_lastBurst;
  reg                 m2b_cmd_s1_valid;
  reg        [31:0]   m2b_cmd_s1_address;
  reg        [10:0]   m2b_cmd_s1_length;
  reg                 m2b_cmd_s1_lastBurst;
  reg        [25:0]   m2b_cmd_s1_bytesLeft;
  wire       [2:0]    m2b_cmd_s1_context_start;
  wire       [2:0]    m2b_cmd_s1_context_stop;
  wire       [10:0]   m2b_cmd_s1_context_length;
  wire                m2b_cmd_s1_context_last;
  wire       [31:0]   m2b_cmd_s1_addressNext;
  wire       [25:0]   m2b_cmd_s1_byteLeftNext;
  wire       [8:0]    m2b_cmd_s1_fifoPushDecr;
  wire       [2:0]    m2b_rsp_context_start;
  wire       [2:0]    m2b_rsp_context_stop;
  wire       [10:0]   m2b_rsp_context_length;
  wire                m2b_rsp_context_last;
  wire       [17:0]   _zz_7;
  wire                m2b_rsp_veryLast;
  reg                 m2b_rsp_first;
  wire                m2b_rsp_writeContext_last;
  wire                m2b_rsp_writeContext_lastOfBurst;
  wire       [3:0]    m2b_rsp_writeContext_loadByteInNextBeat;
  wire                m2b_writeRsp_context_last;
  wire                m2b_writeRsp_context_lastOfBurst;
  wire       [3:0]    m2b_writeRsp_context_loadByteInNextBeat;
  wire       [5:0]    _zz_8;
  wire                _zz_9;
  reg                 _zz_10;
  reg                 _zz_11;
  reg                 _zz_12;
  reg                 _zz_13;

  assign _zz_21 = (! channels_0_descriptorValid);
  assign _zz_22 = (channels_0_selfRestart && (! channels_0_ctrl_kick));
  assign _zz_23 = 1'b1;
  assign _zz_24 = (! m2b_cmd_s0_valid);
  assign _zz_25 = (channels_0_fifo_pop_withoutOverride_exposed + channels_0_fifo_pop_bytesIncr_value);
  assign _zz_26 = (channels_0_push_m2b_memPending + _zz_28);
  assign _zz_27 = channels_0_push_m2b_memPendingIncr;
  assign _zz_28 = {3'd0, _zz_27};
  assign _zz_29 = channels_0_push_m2b_memPendingDecr;
  assign _zz_30 = {3'd0, _zz_29};
  assign _zz_31 = (channels_0_push_m2b_bytePerBurst >>> 3);
  assign _zz_32 = {1'd0, _zz_31};
  assign _zz_33 = {15'd0, channels_0_push_m2b_bytePerBurst};
  assign _zz_34 = (channels_0_push_m2b_address - _zz_35);
  assign _zz_35 = {6'd0, channels_0_bytes};
  assign _zz_36 = (channels_0_fifo_push_available + channels_0_fifo_pop_ptrIncr_value_regNext);
  assign _zz_37 = _zz_2[1 : 1];
  assign _zz_38 = _zz_2[2 : 2];
  assign _zz_39 = (_zz_5 - _zz_41);
  assign _zz_40 = _zz_20;
  assign _zz_41 = {1'd0, _zz_40};
  assign _zz_42 = ((_zz_43 < m2b_cmd_s0_bytesLeft) ? _zz_44 : m2b_cmd_s0_bytesLeft);
  assign _zz_43 = {15'd0, m2b_cmd_s0_lengthHead};
  assign _zz_44 = {15'd0, m2b_cmd_s0_lengthHead};
  assign _zz_45 = {15'd0, m2b_cmd_s0_length};
  assign _zz_46 = (m2b_cmd_s1_address + _zz_47);
  assign _zz_47 = {21'd0, m2b_cmd_s1_length};
  assign _zz_48 = (m2b_cmd_s1_address + _zz_49);
  assign _zz_49 = {21'd0, m2b_cmd_s1_length};
  assign _zz_50 = (m2b_cmd_s1_bytesLeft - _zz_51);
  assign _zz_51 = {15'd0, m2b_cmd_s1_length};
  assign _zz_52 = ({1'b0,(_zz_53 | 11'h007)} + _zz_57);
  assign _zz_53 = (_zz_55 + io_read_cmd_payload_fragment_length);
  assign _zz_54 = m2b_cmd_s1_address[2 : 0];
  assign _zz_55 = {8'd0, _zz_54};
  assign _zz_56 = {1'b0,1'b1};
  assign _zz_57 = {10'd0, _zz_56};
  assign _zz_58 = _zz_7[17 : 17];
  assign _zz_59 = _zz_8[0 : 0];
  assign _zz_60 = _zz_8[1 : 1];
  assign _zz_61 = io_ctrl_PWDATA[0 : 0];
  assign _zz_62 = 1'b1;
  assign _zz_63 = io_ctrl_PWDATA[0 : 0];
  assign _zz_64 = 1'b1;
  assign _zz_65 = io_ctrl_PWDATA[0 : 0];
  assign _zz_66 = 1'b0;
  assign _zz_67 = io_ctrl_PWDATA[2 : 2];
  assign _zz_68 = 1'b0;
  assign _zz_69 = io_ctrl_PWDATA[31 : 0];
  assign _zz_70 = _zz_69;
  assign _zz_71 = io_ctrl_PWDATA[12 : 12];
  assign _zz_72 = io_ctrl_PWDATA[12 : 12];
  assign _zz_73 = io_ctrl_PWDATA[13 : 13];
  assign _zz_74 = io_ctrl_PWDATA[2 : 2];
  assign _zz_75 = io_ctrl_PWDATA[1 : 1];
  assign _zz_76 = io_ctrl_PWDATA[0 : 0];
  assign _zz_77 = io_ctrl_PWDATA[2 : 2];
  assign _zz_78 = (((io_read_rsp_valid && memory_core_io_writes_0_cmd_ready) && 1'b1) ? 1'b1 : 1'b0);
  assign _zz_79 = {8'd0, _zz_78};
  assign _zz_80 = (_zz_9 ? _zz_82 : 4'b0000);
  assign _zz_81 = {8'd0, _zz_80};
  assign _zz_82 = (m2b_writeRsp_context_loadByteInNextBeat + 4'b0001);
  assign _zz_83 = ((b2s_0_cmd_channelsOh[0] && memory_core_io_reads_0_cmd_ready) ? 1'b1 : 1'b0);
  assign _zz_84 = {8'd0, _zz_83};
  dma_soc_DmaMemoryCore memory_core (
    .io_writes_0_cmd_valid              (io_read_rsp_valid                                 ), //i
    .io_writes_0_cmd_ready              (memory_core_io_writes_0_cmd_ready                 ), //o
    .io_writes_0_cmd_payload_address    (_zz_14[7:0]                                       ), //i
    .io_writes_0_cmd_payload_data       (io_read_rsp_payload_fragment_data[63:0]           ), //i
    .io_writes_0_cmd_payload_mask       (_zz_15[7:0]                                       ), //i
    .io_writes_0_cmd_payload_context    (_zz_16[5:0]                                       ), //i
    .io_writes_0_rsp_valid              (memory_core_io_writes_0_rsp_valid                 ), //o
    .io_writes_0_rsp_payload_context    (memory_core_io_writes_0_rsp_payload_context[5:0]  ), //o
    .io_reads_0_cmd_valid               (_zz_17                                            ), //i
    .io_reads_0_cmd_ready               (memory_core_io_reads_0_cmd_ready                  ), //o
    .io_reads_0_cmd_payload_address     (_zz_18[7:0]                                       ), //i
    .io_reads_0_cmd_payload_priority    (channels_0_priority[1:0]                          ), //i
    .io_reads_0_cmd_payload_context     (_zz_19[2:0]                                       ), //i
    .io_reads_0_rsp_valid               (memory_core_io_reads_0_rsp_valid                  ), //o
    .io_reads_0_rsp_ready               (io_outputs_0_ready                                ), //i
    .io_reads_0_rsp_payload_data        (memory_core_io_reads_0_rsp_payload_data[63:0]     ), //o
    .io_reads_0_rsp_payload_mask        (memory_core_io_reads_0_rsp_payload_mask[7:0]      ), //o
    .io_reads_0_rsp_payload_context     (memory_core_io_reads_0_rsp_payload_context[2:0]   ), //o
    .clk                                (clk                                               ), //i
    .reset                              (reset                                             )  //i
  );
  always @(*) begin
    case(_zz_3)
      2'b00 : begin
        _zz_20 = m2b_cmd_s0_priority_roundRobins_0;
      end
      2'b01 : begin
        _zz_20 = m2b_cmd_s0_priority_roundRobins_1;
      end
      2'b10 : begin
        _zz_20 = m2b_cmd_s0_priority_roundRobins_2;
      end
      default : begin
        _zz_20 = m2b_cmd_s0_priority_roundRobins_3;
      end
    endcase
  end

  assign io_ctrl_PREADY = 1'b1;
  always @ (*) begin
    io_ctrl_PRDATA = 32'h0;
    case(io_ctrl_PADDR)
      14'h002c : begin
        io_ctrl_PRDATA[0 : 0] = channels_0_channelValid;
      end
      14'h0054 : begin
        io_ctrl_PRDATA[0 : 0] = channels_0_interrupts_completion_valid;
        io_ctrl_PRDATA[2 : 2] = channels_0_interrupts_onChannelCompletion_valid;
      end
      default : begin
      end
    endcase
  end

  assign io_ctrl_PSLVERROR = 1'b0;
  assign ctrl_askWrite = ((io_ctrl_PSEL[0] && io_ctrl_PENABLE) && io_ctrl_PWRITE);
  assign ctrl_askRead = ((io_ctrl_PSEL[0] && io_ctrl_PENABLE) && (! io_ctrl_PWRITE));
  assign ctrl_doWrite = (((io_ctrl_PSEL[0] && io_ctrl_PENABLE) && io_ctrl_PREADY) && io_ctrl_PWRITE);
  assign ctrl_doRead = (((io_ctrl_PSEL[0] && io_ctrl_PENABLE) && io_ctrl_PREADY) && (! io_ctrl_PWRITE));
  always @ (*) begin
    channels_0_channelStart = 1'b0;
    if(_zz_10)begin
      if(_zz_61[0])begin
        channels_0_channelStart = _zz_62[0];
      end
    end
  end

  always @ (*) begin
    channels_0_channelCompletion = 1'b0;
    if(channels_0_channelValid)begin
      if(channels_0_channelStop)begin
        if(channels_0_readyToStop)begin
          channels_0_channelCompletion = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    channels_0_descriptorStart = 1'b0;
    if(channels_0_ctrl_kick)begin
      channels_0_descriptorStart = 1'b1;
    end
    if(channels_0_channelValid)begin
      if(! channels_0_channelStop) begin
        if(_zz_21)begin
          if(_zz_22)begin
            channels_0_descriptorStart = 1'b1;
          end
        end
      end
    end
  end

  always @ (*) begin
    channels_0_descriptorCompletion = 1'b0;
    if(((((channels_0_descriptorValid && (! channels_0_pop_memory)) && channels_0_push_memory) && channels_0_push_m2b_loadDone) && (channels_0_push_m2b_memPending == 4'b0000)))begin
      channels_0_descriptorCompletion = 1'b1;
    end
    if(channels_0_channelValid)begin
      if(channels_0_channelStop)begin
        if(channels_0_readyToStop)begin
          channels_0_descriptorCompletion = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    channels_0_readyToStop = 1'b1;
    if((channels_0_push_m2b_memPending != 4'b0000))begin
      channels_0_readyToStop = 1'b0;
    end
  end

  assign channels_0_fifo_base = 9'h0;
  assign channels_0_fifo_words = 9'h0ff;
  always @ (*) begin
    channels_0_fifo_push_availableDecr = 9'h0;
    if(m2b_cmd_s1_valid)begin
      if(io_read_cmd_ready)begin
        if(_zz_23)begin
          channels_0_fifo_push_availableDecr = m2b_cmd_s1_fifoPushDecr;
        end
      end
    end
  end

  assign channels_0_fifo_push_ptrWithBase = ((channels_0_fifo_base & (~ channels_0_fifo_words)) | (channels_0_fifo_push_ptr & channels_0_fifo_words));
  assign channels_0_fifo_pop_ptrWithBase = ((channels_0_fifo_base & (~ channels_0_fifo_words)) | (channels_0_fifo_pop_ptr & channels_0_fifo_words));
  assign channels_0_fifo_pop_empty = (channels_0_fifo_pop_ptr == channels_0_fifo_push_ptr);
  assign channels_0_fifo_pop_bytes = channels_0_fifo_pop_withoutOverride_exposed;
  assign channels_0_fifo_empty = (channels_0_fifo_push_ptr == channels_0_fifo_pop_ptr);
  assign channels_0_push_m2b_bytePerBurst = 11'h1ff;
  always @ (*) begin
    channels_0_push_m2b_memPendingIncr = 1'b0;
    if(_zz_24)begin
      if((channels_0_push_m2b_loadRequest && m2b_cmd_s0_priority_chosenOh[0]))begin
        channels_0_push_m2b_memPendingIncr = 1'b1;
      end
    end
  end

  always @ (*) begin
    channels_0_push_m2b_memPendingDecr = 1'b0;
    if((_zz_9 && m2b_writeRsp_context_lastOfBurst))begin
      channels_0_push_m2b_memPendingDecr = 1'b1;
    end
  end

  always @ (*) begin
    channels_0_push_m2b_loadRequest = (((((channels_0_descriptorValid && (! channels_0_channelStop)) && (! channels_0_push_m2b_loadDone)) && channels_0_push_memory) && (_zz_32 < channels_0_fifo_push_available)) && (channels_0_push_m2b_memPending != 4'b1111));
    if((((! channels_0_pop_memory) && channels_0_pop_b2s_veryLastValid) && (channels_0_push_m2b_bytesLeft <= _zz_33)))begin
      channels_0_push_m2b_loadRequest = 1'b0;
    end
  end

  always @ (*) begin
    channels_0_pop_b2s_veryLastTrigger = 1'b0;
    if(((io_read_rsp_valid && io_read_rsp_ready) && m2b_rsp_veryLast))begin
      if(1'b1)begin
        channels_0_pop_b2s_veryLastTrigger = 1'b1;
      end
    end
  end

  always @ (*) begin
    channels_0_readyForChannelCompletion = 1'b1;
    if(((! channels_0_pop_memory) && (! channels_0_fifo_pop_empty)))begin
      channels_0_readyForChannelCompletion = 1'b0;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b1;
    if(_zz_22)begin
      _zz_1 = 1'b0;
    end
    if(channels_0_ctrl_kick)begin
      _zz_1 = 1'b0;
    end
  end

  assign channels_0_s2b_full = (channels_0_fifo_push_available < 9'h001);
  assign b2s_0_cmd_channelsOh = (((channels_0_channelValid && (! channels_0_pop_memory)) && 1'b1) && (! channels_0_fifo_pop_empty));
  assign b2s_0_cmd_veryLastPtr = channels_0_pop_b2s_veryLastPtr;
  assign b2s_0_cmd_address = channels_0_fifo_pop_ptrWithBase;
  assign b2s_0_cmd_context_channel = b2s_0_cmd_channelsOh;
  assign b2s_0_cmd_context_veryLast = ((channels_0_pop_b2s_veryLastValid && (b2s_0_cmd_address[8 : 0] == b2s_0_cmd_veryLastPtr[8 : 0])) && 1'b1);
  assign b2s_0_cmd_context_endPacket = channels_0_pop_b2s_veryLastEndPacket;
  assign _zz_17 = (b2s_0_cmd_channelsOh != 1'b0);
  assign _zz_18 = b2s_0_cmd_address[7:0];
  assign _zz_19 = {b2s_0_cmd_context_endPacket,{b2s_0_cmd_context_veryLast,b2s_0_cmd_context_channel}};
  assign _zz_2 = memory_core_io_reads_0_rsp_payload_context;
  assign b2s_0_rsp_context_channel = _zz_2[0 : 0];
  assign b2s_0_rsp_context_veryLast = _zz_37[0];
  assign b2s_0_rsp_context_endPacket = _zz_38[0];
  assign io_outputs_0_valid = memory_core_io_reads_0_rsp_valid;
  assign io_outputs_0_payload_data = memory_core_io_reads_0_rsp_payload_data;
  assign io_outputs_0_payload_mask = memory_core_io_reads_0_rsp_payload_mask;
  assign io_outputs_0_payload_last = (b2s_0_rsp_context_veryLast && b2s_0_rsp_context_endPacket);
  assign _zz_3 = channels_0_priority;
  assign m2b_cmd_s0_priority_masked[0] = (channels_0_push_m2b_loadRequest && (channels_0_priority == _zz_3));
  assign _zz_4 = m2b_cmd_s0_priority_masked;
  assign _zz_5 = {_zz_4,_zz_4};
  assign _zz_6 = (_zz_5 & (~ _zz_39));
  assign m2b_cmd_s0_priority_chosenOh = (_zz_6[1 : 1] | _zz_6[0 : 0]);
  assign m2b_cmd_s0_priority_weightLast = (channels_0_weight == m2b_cmd_s0_priority_counter);
  assign m2b_cmd_s0_priority_contextNext = (m2b_cmd_s0_priority_weightLast ? m2b_cmd_s0_priority_chosenOh[0 : 0] : m2b_cmd_s0_priority_chosenOh);
  assign m2b_cmd_s0_address = channels_0_push_m2b_address;
  assign m2b_cmd_s0_bytesLeft = channels_0_push_m2b_bytesLeft;
  assign m2b_cmd_s0_readAddressBurstRange = m2b_cmd_s0_address[10 : 0];
  assign m2b_cmd_s0_lengthHead = ((~ m2b_cmd_s0_readAddressBurstRange) & channels_0_push_m2b_bytePerBurst);
  assign m2b_cmd_s0_length = _zz_42[10:0];
  assign m2b_cmd_s0_lastBurst = (m2b_cmd_s0_bytesLeft == _zz_45);
  assign m2b_cmd_s1_context_start = m2b_cmd_s1_address[2:0];
  assign m2b_cmd_s1_context_stop = _zz_46[2:0];
  assign m2b_cmd_s1_context_last = m2b_cmd_s1_lastBurst;
  assign m2b_cmd_s1_context_length = m2b_cmd_s1_length;
  always @ (*) begin
    io_read_cmd_valid = 1'b0;
    if(m2b_cmd_s1_valid)begin
      io_read_cmd_valid = 1'b1;
    end
  end

  assign io_read_cmd_payload_last = 1'b1;
  assign io_read_cmd_payload_fragment_opcode = 1'b0;
  assign io_read_cmd_payload_fragment_address = m2b_cmd_s1_address;
  assign io_read_cmd_payload_fragment_length = m2b_cmd_s1_length;
  assign io_read_cmd_payload_fragment_context = {m2b_cmd_s1_context_last,{m2b_cmd_s1_context_length,{m2b_cmd_s1_context_stop,m2b_cmd_s1_context_start}}};
  assign m2b_cmd_s1_addressNext = (_zz_48 + 32'h00000001);
  assign m2b_cmd_s1_byteLeftNext = (_zz_50 - 26'h0000001);
  assign m2b_cmd_s1_fifoPushDecr = (_zz_52 >>> 3);
  assign _zz_7 = io_read_rsp_payload_fragment_context;
  assign m2b_rsp_context_start = _zz_7[2 : 0];
  assign m2b_rsp_context_stop = _zz_7[5 : 3];
  assign m2b_rsp_context_length = _zz_7[16 : 6];
  assign m2b_rsp_context_last = _zz_58[0];
  assign m2b_rsp_veryLast = (m2b_rsp_context_last && io_read_rsp_payload_last);
  always @ (*) begin
    _zz_15[0] = ((! (m2b_rsp_first && (3'b000 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b000))));
    _zz_15[1] = ((! (m2b_rsp_first && (3'b001 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b001))));
    _zz_15[2] = ((! (m2b_rsp_first && (3'b010 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b010))));
    _zz_15[3] = ((! (m2b_rsp_first && (3'b011 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b011))));
    _zz_15[4] = ((! (m2b_rsp_first && (3'b100 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b100))));
    _zz_15[5] = ((! (m2b_rsp_first && (3'b101 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b101))));
    _zz_15[6] = ((! (m2b_rsp_first && (3'b110 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b110))));
    _zz_15[7] = ((! (m2b_rsp_first && (3'b111 < m2b_rsp_context_start))) && (! (io_read_rsp_payload_last && (m2b_rsp_context_stop < 3'b111))));
  end

  assign m2b_rsp_writeContext_last = m2b_rsp_veryLast;
  assign m2b_rsp_writeContext_lastOfBurst = io_read_rsp_payload_last;
  assign m2b_rsp_writeContext_loadByteInNextBeat = ({1'b0,(io_read_rsp_payload_last ? m2b_rsp_context_stop : 3'b111)} - {1'b0,(m2b_rsp_first ? m2b_rsp_context_start : 3'b000)});
  assign _zz_14 = channels_0_fifo_push_ptrWithBase[7:0];
  assign io_read_rsp_ready = memory_core_io_writes_0_cmd_ready;
  assign _zz_16 = {m2b_rsp_writeContext_loadByteInNextBeat,{m2b_rsp_writeContext_lastOfBurst,m2b_rsp_writeContext_last}};
  assign _zz_8 = memory_core_io_writes_0_rsp_payload_context;
  assign m2b_writeRsp_context_last = _zz_59[0];
  assign m2b_writeRsp_context_lastOfBurst = _zz_60[0];
  assign m2b_writeRsp_context_loadByteInNextBeat = _zz_8[5 : 2];
  assign _zz_9 = (memory_core_io_writes_0_rsp_valid && 1'b1);
  always @ (*) begin
    io_interrupts = 1'b0;
    if(channels_0_interrupts_completion_valid)begin
      io_interrupts[0] = 1'b1;
    end
    if(channels_0_interrupts_onChannelCompletion_valid)begin
      io_interrupts[0] = 1'b1;
    end
  end

  always @ (*) begin
    _zz_10 = 1'b0;
    case(io_ctrl_PADDR)
      14'h002c : begin
        if(ctrl_doWrite)begin
          _zz_10 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_11 = 1'b0;
    case(io_ctrl_PADDR)
      14'h002c : begin
        if(ctrl_doWrite)begin
          _zz_11 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_12 = 1'b0;
    case(io_ctrl_PADDR)
      14'h0054 : begin
        if(ctrl_doWrite)begin
          _zz_12 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_13 = 1'b0;
    case(io_ctrl_PADDR)
      14'h0054 : begin
        if(ctrl_doWrite)begin
          _zz_13 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign channels_0_fifo_push_ptrIncr_value = _zz_79;
  assign channels_0_fifo_pop_bytesIncr_value = _zz_81;
  assign channels_0_fifo_pop_bytesDecr_value = 12'h0;
  assign channels_0_fifo_pop_ptrIncr_value = _zz_84;
  always @ (posedge clk) begin
    if(reset) begin
      channels_0_channelValid <= 1'b0;
      channels_0_descriptorValid <= 1'b0;
      channels_0_priority <= 2'b00;
      channels_0_weight <= 2'b00;
      channels_0_ctrl_kick <= 1'b0;
      channels_0_push_m2b_loadDone <= 1'b1;
      channels_0_push_m2b_memPending <= 4'b0000;
      channels_0_interrupts_completion_enable <= 1'b0;
      channels_0_interrupts_completion_valid <= 1'b0;
      channels_0_interrupts_onChannelCompletion_enable <= 1'b0;
      channels_0_interrupts_onChannelCompletion_valid <= 1'b0;
      m2b_cmd_s0_valid <= 1'b0;
      m2b_cmd_s0_priority_roundRobins_0 <= 1'b1;
      m2b_cmd_s0_priority_roundRobins_1 <= 1'b1;
      m2b_cmd_s0_priority_roundRobins_2 <= 1'b1;
      m2b_cmd_s0_priority_roundRobins_3 <= 1'b1;
      m2b_cmd_s0_priority_counter <= 2'b00;
      m2b_cmd_s1_valid <= 1'b0;
      m2b_rsp_first <= 1'b1;
    end else begin
      if(channels_0_channelStart)begin
        channels_0_channelValid <= 1'b1;
      end
      if(channels_0_channelCompletion)begin
        channels_0_channelValid <= 1'b0;
      end
      if(channels_0_descriptorStart)begin
        channels_0_descriptorValid <= 1'b1;
      end
      if(channels_0_descriptorCompletion)begin
        channels_0_descriptorValid <= 1'b0;
      end
      channels_0_ctrl_kick <= 1'b0;
      if(channels_0_channelCompletion)begin
        channels_0_ctrl_kick <= 1'b0;
      end
      channels_0_push_m2b_memPending <= (_zz_26 - _zz_30);
      if(channels_0_descriptorStart)begin
        channels_0_push_m2b_loadDone <= 1'b0;
      end
      if((channels_0_descriptorValid && channels_0_descriptorCompletion))begin
        channels_0_interrupts_completion_valid <= 1'b1;
      end
      if((! channels_0_interrupts_completion_enable))begin
        channels_0_interrupts_completion_valid <= 1'b0;
      end
      if((channels_0_channelValid && channels_0_channelCompletion))begin
        channels_0_interrupts_onChannelCompletion_valid <= 1'b1;
      end
      if((! channels_0_interrupts_onChannelCompletion_enable))begin
        channels_0_interrupts_onChannelCompletion_valid <= 1'b0;
      end
      if(_zz_24)begin
        if((channels_0_push_m2b_loadRequest != 1'b0))begin
          m2b_cmd_s0_valid <= 1'b1;
          if((2'b00 == _zz_3))begin
            m2b_cmd_s0_priority_roundRobins_0 <= m2b_cmd_s0_priority_contextNext;
          end
          if((2'b01 == _zz_3))begin
            m2b_cmd_s0_priority_roundRobins_1 <= m2b_cmd_s0_priority_contextNext;
          end
          if((2'b10 == _zz_3))begin
            m2b_cmd_s0_priority_roundRobins_2 <= m2b_cmd_s0_priority_contextNext;
          end
          if((2'b11 == _zz_3))begin
            m2b_cmd_s0_priority_roundRobins_3 <= m2b_cmd_s0_priority_contextNext;
          end
          m2b_cmd_s0_priority_counter <= (m2b_cmd_s0_priority_counter + 2'b01);
          if(m2b_cmd_s0_priority_weightLast)begin
            m2b_cmd_s0_priority_counter <= 2'b00;
          end
        end
      end
      if(m2b_cmd_s0_valid)begin
        m2b_cmd_s1_valid <= 1'b1;
      end
      if(m2b_cmd_s1_valid)begin
        if(io_read_cmd_ready)begin
          m2b_cmd_s0_valid <= 1'b0;
          m2b_cmd_s1_valid <= 1'b0;
          if(_zz_23)begin
            if(m2b_cmd_s1_lastBurst)begin
              channels_0_push_m2b_loadDone <= 1'b1;
            end
          end
        end
      end
      if((io_read_rsp_valid && io_read_rsp_ready))begin
        m2b_rsp_first <= io_read_rsp_payload_last;
      end
      if(_zz_11)begin
        if(_zz_63[0])begin
          channels_0_ctrl_kick <= _zz_64[0];
        end
      end
      if(_zz_12)begin
        if(_zz_65[0])begin
          channels_0_interrupts_completion_valid <= _zz_66[0];
        end
      end
      if(_zz_13)begin
        if(_zz_67[0])begin
          channels_0_interrupts_onChannelCompletion_valid <= _zz_68[0];
        end
      end
      case(io_ctrl_PADDR)
        14'h0044 : begin
          if(ctrl_doWrite)begin
            channels_0_priority <= io_ctrl_PWDATA[1 : 0];
            channels_0_weight <= io_ctrl_PWDATA[9 : 8];
          end
        end
        14'h0050 : begin
          if(ctrl_doWrite)begin
            channels_0_interrupts_completion_enable <= _zz_76[0];
            channels_0_interrupts_onChannelCompletion_enable <= _zz_77[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge clk) begin
    channels_0_fifo_push_ptr <= (channels_0_fifo_push_ptr + channels_0_fifo_push_ptrIncr_value);
    if(channels_0_channelStart)begin
      channels_0_fifo_push_ptr <= 9'h0;
    end
    channels_0_fifo_pop_ptr <= (channels_0_fifo_pop_ptr + channels_0_fifo_pop_ptrIncr_value);
    channels_0_fifo_pop_withoutOverride_exposed <= (_zz_25 - channels_0_fifo_pop_bytesDecr_value);
    if(channels_0_channelStart)begin
      channels_0_fifo_pop_withoutOverride_exposed <= 12'h0;
    end
    if(channels_0_descriptorStart)begin
      channels_0_push_m2b_bytesLeft <= channels_0_bytes;
    end
    if(channels_0_pop_b2s_veryLastTrigger)begin
      channels_0_pop_b2s_veryLastValid <= 1'b1;
    end
    if(channels_0_pop_b2s_veryLastTrigger)begin
      channels_0_pop_b2s_veryLastPtr <= channels_0_fifo_push_ptrWithBase;
      channels_0_pop_b2s_veryLastEndPacket <= channels_0_pop_b2s_last;
    end
    if(channels_0_channelStart)begin
      channels_0_pop_b2s_veryLastValid <= 1'b0;
    end
    if(channels_0_channelValid)begin
      if(! channels_0_channelStop) begin
        if(_zz_21)begin
          if(_zz_22)begin
            channels_0_push_m2b_address <= (_zz_34 - 32'h00000001);
          end
          if((_zz_1 && channels_0_readyForChannelCompletion))begin
            channels_0_channelStop <= 1'b1;
          end
        end
      end
    end
    channels_0_fifo_pop_ptrIncr_value_regNext <= channels_0_fifo_pop_ptrIncr_value;
    channels_0_fifo_push_available <= (_zz_36 - (channels_0_push_memory ? channels_0_fifo_push_availableDecr : channels_0_fifo_push_ptrIncr_value));
    if(channels_0_channelStart)begin
      channels_0_fifo_push_ptr <= 9'h0;
      channels_0_fifo_push_available <= (channels_0_fifo_words + 9'h001);
      channels_0_fifo_pop_ptr <= 9'h0;
    end
    if(((io_outputs_0_valid && io_outputs_0_ready) && b2s_0_rsp_context_veryLast))begin
      if(b2s_0_rsp_context_channel[0])begin
        channels_0_pop_b2s_veryLastValid <= 1'b0;
      end
    end
    m2b_cmd_s1_address <= m2b_cmd_s0_address;
    m2b_cmd_s1_length <= m2b_cmd_s0_length;
    m2b_cmd_s1_lastBurst <= m2b_cmd_s0_lastBurst;
    m2b_cmd_s1_bytesLeft <= m2b_cmd_s0_bytesLeft;
    if(m2b_cmd_s1_valid)begin
      if(io_read_cmd_ready)begin
        if(_zz_23)begin
          channels_0_push_m2b_address <= m2b_cmd_s1_addressNext;
          channels_0_push_m2b_bytesLeft <= m2b_cmd_s1_byteLeftNext;
        end
      end
    end
    case(io_ctrl_PADDR)
      14'h0 : begin
        if(ctrl_doWrite)begin
          channels_0_push_m2b_address[31 : 0] <= _zz_70;
        end
      end
      14'h000c : begin
        if(ctrl_doWrite)begin
          channels_0_push_memory <= _zz_71[0];
        end
      end
      14'h001c : begin
        if(ctrl_doWrite)begin
          channels_0_pop_memory <= _zz_72[0];
          channels_0_pop_b2s_last <= _zz_73[0];
        end
      end
      14'h002c : begin
        if(ctrl_doWrite)begin
          channels_0_channelStop <= _zz_74[0];
          channels_0_selfRestart <= _zz_75[0];
        end
      end
      14'h0020 : begin
        if(ctrl_doWrite)begin
          channels_0_bytes <= io_ctrl_PWDATA[25 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module dma_soc_StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [31:0]   io_inputs_0_payload_addr,
  input      [3:0]    io_inputs_0_payload_region,
  input      [7:0]    io_inputs_0_payload_len,
  input      [2:0]    io_inputs_0_payload_size,
  input      [1:0]    io_inputs_0_payload_burst,
  input      [0:0]    io_inputs_0_payload_lock,
  input      [3:0]    io_inputs_0_payload_cache,
  input      [3:0]    io_inputs_0_payload_qos,
  input      [2:0]    io_inputs_0_payload_prot,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [31:0]   io_inputs_1_payload_addr,
  input      [3:0]    io_inputs_1_payload_region,
  input      [7:0]    io_inputs_1_payload_len,
  input      [2:0]    io_inputs_1_payload_size,
  input      [1:0]    io_inputs_1_payload_burst,
  input      [0:0]    io_inputs_1_payload_lock,
  input      [3:0]    io_inputs_1_payload_cache,
  input      [3:0]    io_inputs_1_payload_qos,
  input      [2:0]    io_inputs_1_payload_prot,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload_addr,
  output     [3:0]    io_output_payload_region,
  output     [7:0]    io_output_payload_len,
  output     [2:0]    io_output_payload_size,
  output     [1:0]    io_output_payload_burst,
  output     [0:0]    io_output_payload_lock,
  output     [3:0]    io_output_payload_cache,
  output     [3:0]    io_output_payload_qos,
  output     [2:0]    io_output_payload_prot,
  output     [0:0]    io_chosen,
  output     [1:0]    io_chosenOH,
  input               clk,
  input               reset
);
  wire       [3:0]    _zz_6;
  wire       [1:0]    _zz_7;
  wire       [3:0]    _zz_8;
  wire       [0:0]    _zz_9;
  wire       [0:0]    _zz_10;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire       [1:0]    _zz_1;
  wire       [3:0]    _zz_2;
  wire       [3:0]    _zz_3;
  wire       [1:0]    _zz_4;
  wire                _zz_5;

  assign _zz_6 = (_zz_2 - _zz_8);
  assign _zz_7 = {maskLocked_0,maskLocked_1};
  assign _zz_8 = {2'd0, _zz_7};
  assign _zz_9 = _zz_4[0 : 0];
  assign _zz_10 = _zz_4[1 : 1];
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign _zz_1 = {io_inputs_1_valid,io_inputs_0_valid};
  assign _zz_2 = {_zz_1,_zz_1};
  assign _zz_3 = (_zz_2 & (~ _zz_6));
  assign _zz_4 = (_zz_3[3 : 2] | _zz_3[1 : 0]);
  assign maskProposal_0 = _zz_9[0];
  assign maskProposal_1 = _zz_10[0];
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1));
  assign io_output_payload_addr = (maskRouted_0 ? io_inputs_0_payload_addr : io_inputs_1_payload_addr);
  assign io_output_payload_region = (maskRouted_0 ? io_inputs_0_payload_region : io_inputs_1_payload_region);
  assign io_output_payload_len = (maskRouted_0 ? io_inputs_0_payload_len : io_inputs_1_payload_len);
  assign io_output_payload_size = (maskRouted_0 ? io_inputs_0_payload_size : io_inputs_1_payload_size);
  assign io_output_payload_burst = (maskRouted_0 ? io_inputs_0_payload_burst : io_inputs_1_payload_burst);
  assign io_output_payload_lock = (maskRouted_0 ? io_inputs_0_payload_lock : io_inputs_1_payload_lock);
  assign io_output_payload_cache = (maskRouted_0 ? io_inputs_0_payload_cache : io_inputs_1_payload_cache);
  assign io_output_payload_qos = (maskRouted_0 ? io_inputs_0_payload_qos : io_inputs_1_payload_qos);
  assign io_output_payload_prot = (maskRouted_0 ? io_inputs_0_payload_prot : io_inputs_1_payload_prot);
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_chosenOH = {maskRouted_1,maskRouted_0};
  assign _zz_5 = io_chosenOH[1];
  assign io_chosen = _zz_5;
  always @ (posedge clk) begin
    if(reset) begin
      locked <= 1'b0;
      maskLocked_0 <= 1'b0;
      maskLocked_1 <= 1'b1;
    end else begin
      if(io_output_valid)begin
        maskLocked_0 <= maskRouted_0;
        maskLocked_1 <= maskRouted_1;
      end
      if(io_output_valid)begin
        locked <= 1'b1;
      end
      if((io_output_valid && io_output_ready))begin
        locked <= 1'b0;
      end
    end
  end


endmodule

module dma_soc_BufferCC_4 (
  input      [10:0]   io_dataIn,
  output     [10:0]   io_dataOut,
  input               hdmi_0_clk,
  input               hdmi_0_reset
);
  reg        [10:0]   buffers_0;
  reg        [10:0]   buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge hdmi_0_clk) begin
    if(hdmi_0_reset) begin
      buffers_0 <= 11'h0;
      buffers_1 <= 11'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module dma_soc_BufferCC_3 (
  input      [10:0]   io_dataIn,
  output     [10:0]   io_dataOut,
  input               clk,
  input               reset
);
  reg        [10:0]   buffers_0;
  reg        [10:0]   buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge clk) begin
    if(reset) begin
      buffers_0 <= 11'h0;
      buffers_1 <= 11'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module dma_soc_BmbContextRemover (
  input               io_input_cmd_valid,
  output              io_input_cmd_ready,
  input               io_input_cmd_payload_last,
  input      [0:0]    io_input_cmd_payload_fragment_opcode,
  input      [31:0]   io_input_cmd_payload_fragment_address,
  input      [10:0]   io_input_cmd_payload_fragment_length,
  input      [21:0]   io_input_cmd_payload_fragment_context,
  output              io_input_rsp_valid,
  input               io_input_rsp_ready,
  output              io_input_rsp_payload_last,
  output     [0:0]    io_input_rsp_payload_fragment_opcode,
  output     [255:0]  io_input_rsp_payload_fragment_data,
  output     [21:0]   io_input_rsp_payload_fragment_context,
  output              io_output_cmd_valid,
  input               io_output_cmd_ready,
  output              io_output_cmd_payload_last,
  output     [0:0]    io_output_cmd_payload_fragment_opcode,
  output     [31:0]   io_output_cmd_payload_fragment_address,
  output     [10:0]   io_output_cmd_payload_fragment_length,
  input               io_output_rsp_valid,
  output              io_output_rsp_ready,
  input               io_output_rsp_payload_last,
  input      [0:0]    io_output_rsp_payload_fragment_opcode,
  input      [255:0]  io_output_rsp_payload_fragment_data,
  input               clk,
  input               reset
);
  reg                 _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                io_input_cmd_fork_io_input_ready;
  wire                io_input_cmd_fork_io_outputs_0_valid;
  wire                io_input_cmd_fork_io_outputs_0_payload_last;
  wire       [0:0]    io_input_cmd_fork_io_outputs_0_payload_fragment_opcode;
  wire       [31:0]   io_input_cmd_fork_io_outputs_0_payload_fragment_address;
  wire       [10:0]   io_input_cmd_fork_io_outputs_0_payload_fragment_length;
  wire       [21:0]   io_input_cmd_fork_io_outputs_0_payload_fragment_context;
  wire                io_input_cmd_fork_io_outputs_1_valid;
  wire                io_input_cmd_fork_io_outputs_1_payload_last;
  wire       [0:0]    io_input_cmd_fork_io_outputs_1_payload_fragment_opcode;
  wire       [31:0]   io_input_cmd_fork_io_outputs_1_payload_fragment_address;
  wire       [10:0]   io_input_cmd_fork_io_outputs_1_payload_fragment_length;
  wire       [21:0]   io_input_cmd_fork_io_outputs_1_payload_fragment_context;
  wire                io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_push_ready;
  wire                io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_pop_valid;
  wire       [21:0]   io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_pop_payload;
  wire       [2:0]    io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_occupancy;
  wire       [2:0]    io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_availability;
  wire                _zz_5;
  reg                 io_input_cmd_fork_io_outputs_0_payload_first;
  reg                 io_input_cmd_fork_io_outputs_0_thrown_valid;
  wire                io_input_cmd_fork_io_outputs_0_thrown_ready;
  wire                io_input_cmd_fork_io_outputs_0_thrown_payload_last;
  wire       [0:0]    io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_opcode;
  wire       [31:0]   io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_address;
  wire       [10:0]   io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_length;
  wire       [21:0]   io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_context;
  wire                io_input_cmd_fork_io_outputs_0_thrown_translated_valid;
  wire                io_input_cmd_fork_io_outputs_0_thrown_translated_ready;
  wire       [21:0]   io_input_cmd_fork_io_outputs_0_thrown_translated_payload;
  wire                _zz_1;

  assign _zz_5 = (! io_input_cmd_fork_io_outputs_0_payload_first);
  dma_soc_StreamFork io_input_cmd_fork (
    .io_input_valid                           (io_input_cmd_valid                                             ), //i
    .io_input_ready                           (io_input_cmd_fork_io_input_ready                               ), //o
    .io_input_payload_last                    (io_input_cmd_payload_last                                      ), //i
    .io_input_payload_fragment_opcode         (io_input_cmd_payload_fragment_opcode                           ), //i
    .io_input_payload_fragment_address        (io_input_cmd_payload_fragment_address[31:0]                    ), //i
    .io_input_payload_fragment_length         (io_input_cmd_payload_fragment_length[10:0]                     ), //i
    .io_input_payload_fragment_context        (io_input_cmd_payload_fragment_context[21:0]                    ), //i
    .io_outputs_0_valid                       (io_input_cmd_fork_io_outputs_0_valid                           ), //o
    .io_outputs_0_ready                       (_zz_2                                                          ), //i
    .io_outputs_0_payload_last                (io_input_cmd_fork_io_outputs_0_payload_last                    ), //o
    .io_outputs_0_payload_fragment_opcode     (io_input_cmd_fork_io_outputs_0_payload_fragment_opcode         ), //o
    .io_outputs_0_payload_fragment_address    (io_input_cmd_fork_io_outputs_0_payload_fragment_address[31:0]  ), //o
    .io_outputs_0_payload_fragment_length     (io_input_cmd_fork_io_outputs_0_payload_fragment_length[10:0]   ), //o
    .io_outputs_0_payload_fragment_context    (io_input_cmd_fork_io_outputs_0_payload_fragment_context[21:0]  ), //o
    .io_outputs_1_valid                       (io_input_cmd_fork_io_outputs_1_valid                           ), //o
    .io_outputs_1_ready                       (io_output_cmd_ready                                            ), //i
    .io_outputs_1_payload_last                (io_input_cmd_fork_io_outputs_1_payload_last                    ), //o
    .io_outputs_1_payload_fragment_opcode     (io_input_cmd_fork_io_outputs_1_payload_fragment_opcode         ), //o
    .io_outputs_1_payload_fragment_address    (io_input_cmd_fork_io_outputs_1_payload_fragment_address[31:0]  ), //o
    .io_outputs_1_payload_fragment_length     (io_input_cmd_fork_io_outputs_1_payload_fragment_length[10:0]   ), //o
    .io_outputs_1_payload_fragment_context    (io_input_cmd_fork_io_outputs_1_payload_fragment_context[21:0]  ), //o
    .clk                                      (clk                                                            ), //i
    .reset                                    (reset                                                          )  //i
  );
  dma_soc_StreamFifo io_input_cmd_fork_io_outputs_0_thrown_translated_fifo (
    .io_push_valid      (io_input_cmd_fork_io_outputs_0_thrown_translated_valid                      ), //i
    .io_push_ready      (io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_push_ready         ), //o
    .io_push_payload    (io_input_cmd_fork_io_outputs_0_thrown_translated_payload[21:0]              ), //i
    .io_pop_valid       (io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_pop_valid          ), //o
    .io_pop_ready       (_zz_3                                                                       ), //i
    .io_pop_payload     (io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_pop_payload[21:0]  ), //o
    .io_flush           (_zz_4                                                                       ), //i
    .io_occupancy       (io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_occupancy[2:0]     ), //o
    .io_availability    (io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_availability[2:0]  ), //o
    .clk                (clk                                                                         ), //i
    .reset              (reset                                                                       )  //i
  );
  assign io_input_cmd_ready = io_input_cmd_fork_io_input_ready;
  assign io_output_cmd_valid = io_input_cmd_fork_io_outputs_1_valid;
  assign io_output_cmd_payload_last = io_input_cmd_fork_io_outputs_1_payload_last;
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_fork_io_outputs_1_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_input_cmd_fork_io_outputs_1_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_input_cmd_fork_io_outputs_1_payload_fragment_length;
  always @ (*) begin
    io_input_cmd_fork_io_outputs_0_thrown_valid = io_input_cmd_fork_io_outputs_0_valid;
    if(_zz_5)begin
      io_input_cmd_fork_io_outputs_0_thrown_valid = 1'b0;
    end
  end

  always @ (*) begin
    _zz_2 = io_input_cmd_fork_io_outputs_0_thrown_ready;
    if(_zz_5)begin
      _zz_2 = 1'b1;
    end
  end

  assign io_input_cmd_fork_io_outputs_0_thrown_payload_last = io_input_cmd_fork_io_outputs_0_payload_last;
  assign io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_opcode = io_input_cmd_fork_io_outputs_0_payload_fragment_opcode;
  assign io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_address = io_input_cmd_fork_io_outputs_0_payload_fragment_address;
  assign io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_length = io_input_cmd_fork_io_outputs_0_payload_fragment_length;
  assign io_input_cmd_fork_io_outputs_0_thrown_payload_fragment_context = io_input_cmd_fork_io_outputs_0_payload_fragment_context;
  assign io_input_cmd_fork_io_outputs_0_thrown_translated_valid = io_input_cmd_fork_io_outputs_0_thrown_valid;
  assign io_input_cmd_fork_io_outputs_0_thrown_ready = io_input_cmd_fork_io_outputs_0_thrown_translated_ready;
  assign io_input_cmd_fork_io_outputs_0_thrown_translated_payload = io_input_cmd_fork_io_outputs_0_payload_fragment_context;
  assign io_input_cmd_fork_io_outputs_0_thrown_translated_ready = io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_push_ready;
  assign _zz_3 = ((io_output_rsp_valid && io_output_rsp_payload_last) && io_input_rsp_ready);
  assign _zz_1 = (! (! io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_pop_valid));
  assign io_output_rsp_ready = (io_input_rsp_ready && _zz_1);
  assign io_input_rsp_valid = (io_output_rsp_valid && _zz_1);
  assign io_input_rsp_payload_last = io_output_rsp_payload_last;
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = io_input_cmd_fork_io_outputs_0_thrown_translated_fifo_io_pop_payload;
  assign _zz_4 = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      io_input_cmd_fork_io_outputs_0_payload_first <= 1'b1;
    end else begin
      if((io_input_cmd_fork_io_outputs_0_valid && _zz_2))begin
        io_input_cmd_fork_io_outputs_0_payload_first <= io_input_cmd_fork_io_outputs_0_payload_last;
      end
    end
  end


endmodule

module dma_soc_FlowCCByToggle (
  input               io_input_valid,
  input      [31:0]   io_input_payload_PRDATA,
  input               io_input_payload_PSLVERROR,
  output              io_output_valid,
  output     [31:0]   io_output_payload_PRDATA,
  output              io_output_payload_PSLVERROR,
  input               clk,
  input               reset,
  input               ctrl_clk,
  input               ctrl_reset
);
  wire                inputArea_target_buffercc_io_dataOut;
  wire                outHitSignal;
  reg                 inputArea_target;
  reg        [31:0]   inputArea_data_PRDATA;
  reg                 inputArea_data_PSLVERROR;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire       [31:0]   outputArea_flow_payload_PRDATA;
  wire                outputArea_flow_payload_PSLVERROR;
  reg                 outputArea_flow_regNext_valid;
  reg        [31:0]   outputArea_flow_regNext_payload_PRDATA;
  reg                 outputArea_flow_regNext_payload_PSLVERROR;

  dma_soc_BufferCC inputArea_target_buffercc (
    .io_dataIn     (inputArea_target                      ), //i
    .io_dataOut    (inputArea_target_buffercc_io_dataOut  ), //o
    .ctrl_clk      (ctrl_clk                              ), //i
    .ctrl_reset    (ctrl_reset                            )  //i
  );
  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_PRDATA = inputArea_data_PRDATA;
  assign outputArea_flow_payload_PSLVERROR = inputArea_data_PSLVERROR;
  assign io_output_valid = outputArea_flow_regNext_valid;
  assign io_output_payload_PRDATA = outputArea_flow_regNext_payload_PRDATA;
  assign io_output_payload_PSLVERROR = outputArea_flow_regNext_payload_PSLVERROR;
  always @ (posedge clk) begin
    if(reset) begin
      inputArea_target <= 1'b0;
    end else begin
      if(io_input_valid)begin
        inputArea_target <= (! inputArea_target);
      end
    end
  end

  always @ (posedge clk) begin
    if(io_input_valid)begin
      inputArea_data_PRDATA <= io_input_payload_PRDATA;
      inputArea_data_PSLVERROR <= io_input_payload_PSLVERROR;
    end
  end

  always @ (posedge ctrl_clk) begin
    if(ctrl_reset) begin
      outputArea_flow_regNext_valid <= 1'b0;
      outputArea_hit <= 1'b0;
    end else begin
      outputArea_hit <= outputArea_target;
      outputArea_flow_regNext_valid <= outputArea_flow_valid;
    end
  end

  always @ (posedge ctrl_clk) begin
    outputArea_flow_regNext_payload_PRDATA <= outputArea_flow_payload_PRDATA;
    outputArea_flow_regNext_payload_PSLVERROR <= outputArea_flow_payload_PSLVERROR;
  end


endmodule

module dma_soc_StreamCCByToggle (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [13:0]   io_input_payload_PADDR,
  input               io_input_payload_PWRITE,
  input      [31:0]   io_input_payload_PWDATA,
  output              io_output_valid,
  input               io_output_ready,
  output     [13:0]   io_output_payload_PADDR,
  output              io_output_payload_PWRITE,
  output     [31:0]   io_output_payload_PWDATA,
  input               ctrl_clk,
  input               ctrl_reset,
  input               clk,
  input               reset
);
  wire                outHitSignal_buffercc_io_dataOut;
  wire                pushArea_target_buffercc_io_dataOut;
  wire                _zz_1;
  wire                outHitSignal;
  wire                pushArea_hit;
  reg                 pushArea_target;
  reg        [13:0]   pushArea_data_PADDR;
  reg                 pushArea_data_PWRITE;
  reg        [31:0]   pushArea_data_PWDATA;
  wire                popArea_target;
  reg                 popArea_hit;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [13:0]   popArea_stream_payload_PADDR;
  wire                popArea_stream_payload_PWRITE;
  wire       [31:0]   popArea_stream_payload_PWDATA;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [13:0]   popArea_stream_m2sPipe_payload_PADDR;
  wire                popArea_stream_m2sPipe_payload_PWRITE;
  wire       [31:0]   popArea_stream_m2sPipe_payload_PWDATA;
  reg                 popArea_stream_m2sPipe_rValid;
  reg        [13:0]   popArea_stream_m2sPipe_rData_PADDR;
  reg                 popArea_stream_m2sPipe_rData_PWRITE;
  reg        [31:0]   popArea_stream_m2sPipe_rData_PWDATA;

  assign _zz_1 = (io_input_valid && (pushArea_hit == pushArea_target));
  dma_soc_BufferCC outHitSignal_buffercc (
    .io_dataIn     (outHitSignal                      ), //i
    .io_dataOut    (outHitSignal_buffercc_io_dataOut  ), //o
    .ctrl_clk      (ctrl_clk                          ), //i
    .ctrl_reset    (ctrl_reset                        )  //i
  );
  dma_soc_BufferCC_1 pushArea_target_buffercc (
    .io_dataIn     (pushArea_target                      ), //i
    .io_dataOut    (pushArea_target_buffercc_io_dataOut  ), //o
    .clk           (clk                                  ), //i
    .reset         (reset                                )  //i
  );
  assign pushArea_hit = outHitSignal_buffercc_io_dataOut;
  always @ (*) begin
    io_input_ready = 1'b0;
    if(_zz_1)begin
      io_input_ready = 1'b1;
    end
  end

  assign popArea_target = pushArea_target_buffercc_io_dataOut;
  assign outHitSignal = popArea_hit;
  assign popArea_stream_valid = (popArea_target != popArea_hit);
  assign popArea_stream_payload_PADDR = pushArea_data_PADDR;
  assign popArea_stream_payload_PWRITE = pushArea_data_PWRITE;
  assign popArea_stream_payload_PWDATA = pushArea_data_PWDATA;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_m2sPipe_rValid;
  assign popArea_stream_m2sPipe_payload_PADDR = popArea_stream_m2sPipe_rData_PADDR;
  assign popArea_stream_m2sPipe_payload_PWRITE = popArea_stream_m2sPipe_rData_PWRITE;
  assign popArea_stream_m2sPipe_payload_PWDATA = popArea_stream_m2sPipe_rData_PWDATA;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_PADDR = popArea_stream_m2sPipe_payload_PADDR;
  assign io_output_payload_PWRITE = popArea_stream_m2sPipe_payload_PWRITE;
  assign io_output_payload_PWDATA = popArea_stream_m2sPipe_payload_PWDATA;
  always @ (posedge ctrl_clk) begin
    if(ctrl_reset) begin
      pushArea_target <= 1'b0;
    end else begin
      if(_zz_1)begin
        pushArea_target <= (! pushArea_target);
      end
    end
  end

  always @ (posedge ctrl_clk) begin
    if(_zz_1)begin
      pushArea_data_PADDR <= io_input_payload_PADDR;
      pushArea_data_PWRITE <= io_input_payload_PWRITE;
      pushArea_data_PWDATA <= io_input_payload_PWDATA;
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      popArea_hit <= 1'b0;
      popArea_stream_m2sPipe_rValid <= 1'b0;
    end else begin
      if((popArea_stream_valid && popArea_stream_ready))begin
        popArea_hit <= (! popArea_hit);
      end
      if(popArea_stream_ready)begin
        popArea_stream_m2sPipe_rValid <= popArea_stream_valid;
      end
    end
  end

  always @ (posedge clk) begin
    if(popArea_stream_ready)begin
      popArea_stream_m2sPipe_rData_PADDR <= popArea_stream_payload_PADDR;
      popArea_stream_m2sPipe_rData_PWRITE <= popArea_stream_payload_PWRITE;
      popArea_stream_m2sPipe_rData_PWDATA <= popArea_stream_payload_PWDATA;
    end
  end


endmodule

module dma_soc_DmaMemoryCore (
  input               io_writes_0_cmd_valid,
  output              io_writes_0_cmd_ready,
  input      [7:0]    io_writes_0_cmd_payload_address,
  input      [63:0]   io_writes_0_cmd_payload_data,
  input      [7:0]    io_writes_0_cmd_payload_mask,
  input      [5:0]    io_writes_0_cmd_payload_context,
  output              io_writes_0_rsp_valid,
  output     [5:0]    io_writes_0_rsp_payload_context,
  input               io_reads_0_cmd_valid,
  output              io_reads_0_cmd_ready,
  input      [7:0]    io_reads_0_cmd_payload_address,
  input      [1:0]    io_reads_0_cmd_payload_priority,
  input      [2:0]    io_reads_0_cmd_payload_context,
  output              io_reads_0_rsp_valid,
  input               io_reads_0_rsp_ready,
  output     [63:0]   io_reads_0_rsp_payload_data,
  output     [7:0]    io_reads_0_rsp_payload_mask,
  output     [2:0]    io_reads_0_rsp_payload_context,
  input               clk,
  input               reset
);
  reg        [71:0]   _zz_14;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire       [0:0]    _zz_18;
  wire       [0:0]    _zz_19;
  wire       [71:0]   _zz_20;
  reg                 _zz_1;
  wire                banks_0_write_valid;
  wire       [7:0]    banks_0_write_payload_address;
  wire       [63:0]   banks_0_write_payload_data_data;
  wire       [7:0]    banks_0_write_payload_data_mask;
  wire                banks_0_read_cmd_valid;
  wire       [7:0]    banks_0_read_cmd_payload;
  wire       [63:0]   banks_0_read_rsp_data;
  wire       [7:0]    banks_0_read_rsp_mask;
  wire       [71:0]   _zz_2;
  wire                banks_0_writeOr_value_valid;
  wire       [7:0]    banks_0_writeOr_value_payload_address;
  wire       [63:0]   banks_0_writeOr_value_payload_data_data;
  wire       [7:0]    banks_0_writeOr_value_payload_data_mask;
  wire                banks_0_readOr_value_valid;
  wire       [7:0]    banks_0_readOr_value_payload;
  wire                write_nodes_0_0_priority;
  wire                write_nodes_0_0_conflict;
  wire                write_arbiter_0_doIt;
  reg                 _zz_3;
  reg        [7:0]    _zz_4;
  reg        [63:0]   _zz_5;
  reg        [7:0]    _zz_6;
  reg                 write_arbiter_0_doIt_regNext;
  reg        [5:0]    io_writes_0_cmd_payload_context_regNext;
  wire                read_ports_0_buffer_s0_valid;
  wire       [2:0]    read_ports_0_buffer_s0_payload_context;
  wire       [7:0]    read_ports_0_buffer_s0_payload_address;
  reg                 read_ports_0_buffer_s1_valid;
  reg        [2:0]    read_ports_0_buffer_s1_payload_context;
  reg        [7:0]    read_ports_0_buffer_s1_payload_address;
  wire                read_ports_0_buffer_bufferIn_valid;
  wire                read_ports_0_buffer_bufferIn_ready;
  wire       [63:0]   read_ports_0_buffer_bufferIn_payload_data;
  wire       [7:0]    read_ports_0_buffer_bufferIn_payload_mask;
  wire       [2:0]    read_ports_0_buffer_bufferIn_payload_context;
  wire                read_ports_0_buffer_bufferOut_valid;
  wire                read_ports_0_buffer_bufferOut_ready;
  wire       [63:0]   read_ports_0_buffer_bufferOut_payload_data;
  wire       [7:0]    read_ports_0_buffer_bufferOut_payload_mask;
  wire       [2:0]    read_ports_0_buffer_bufferOut_payload_context;
  reg                 read_ports_0_buffer_bufferIn_s2mPipe_rValid;
  reg        [63:0]   read_ports_0_buffer_bufferIn_s2mPipe_rData_data;
  reg        [7:0]    read_ports_0_buffer_bufferIn_s2mPipe_rData_mask;
  reg        [2:0]    read_ports_0_buffer_bufferIn_s2mPipe_rData_context;
  wire                read_ports_0_buffer_full;
  wire                _zz_7;
  wire                read_ports_0_cmd_valid;
  wire                read_ports_0_cmd_ready;
  wire       [7:0]    read_ports_0_cmd_payload_address;
  wire       [1:0]    read_ports_0_cmd_payload_priority;
  wire       [2:0]    read_ports_0_cmd_payload_context;
  reg        [1:0]    read_ports_0_priority_value = 2'b00;
  wire                read_nodes_0_0_priority;
  wire                read_nodes_0_0_conflict;
  wire                read_arbiter_0_doIt;
  reg                 _zz_8;
  reg        [7:0]    _zz_9;
  wire       [80:0]   _zz_10;
  wire       [79:0]   _zz_11;
  wire       [71:0]   _zz_12;
  wire       [8:0]    _zz_13;
  (* ram_style = "block" *) reg [71:0] banks_0_ram [0:255];

  assign _zz_15 = (write_arbiter_0_doIt && 1'b1);
  assign _zz_16 = (read_arbiter_0_doIt && 1'b1);
  assign _zz_17 = (read_ports_0_buffer_bufferIn_ready && (! read_ports_0_buffer_bufferOut_ready));
  assign _zz_18 = _zz_10[0 : 0];
  assign _zz_19 = _zz_13[0 : 0];
  assign _zz_20 = {banks_0_write_payload_data_mask,banks_0_write_payload_data_data};
  always @ (posedge clk) begin
    if(_zz_1) begin
      banks_0_ram[banks_0_write_payload_address] <= _zz_20;
    end
  end

  always @ (posedge clk) begin
    if(banks_0_read_cmd_valid) begin
      _zz_14 <= banks_0_ram[banks_0_read_cmd_payload];
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(banks_0_write_valid)begin
      _zz_1 = 1'b1;
    end
  end

  assign _zz_2 = _zz_14;
  assign banks_0_read_rsp_data = _zz_2[63 : 0];
  assign banks_0_read_rsp_mask = _zz_2[71 : 64];
  assign banks_0_write_valid = banks_0_writeOr_value_valid;
  assign banks_0_write_payload_address = banks_0_writeOr_value_payload_address;
  assign banks_0_write_payload_data_data = banks_0_writeOr_value_payload_data_data;
  assign banks_0_write_payload_data_mask = banks_0_writeOr_value_payload_data_mask;
  assign banks_0_read_cmd_valid = banks_0_readOr_value_valid;
  assign banks_0_read_cmd_payload = banks_0_readOr_value_payload;
  assign write_arbiter_0_doIt = (io_writes_0_cmd_valid && 1'b1);
  always @ (*) begin
    if(_zz_15)begin
      _zz_3 = 1'b1;
    end else begin
      _zz_3 = 1'b0;
    end
  end

  always @ (*) begin
    if(_zz_15)begin
      _zz_4 = (io_writes_0_cmd_payload_address >>> 0);
    end else begin
      _zz_4 = 8'h0;
    end
  end

  always @ (*) begin
    if(_zz_15)begin
      _zz_5 = io_writes_0_cmd_payload_data[63 : 0];
    end else begin
      _zz_5 = 64'h0;
    end
  end

  always @ (*) begin
    if(_zz_15)begin
      _zz_6 = io_writes_0_cmd_payload_mask[7 : 0];
    end else begin
      _zz_6 = 8'h0;
    end
  end

  assign io_writes_0_cmd_ready = write_arbiter_0_doIt;
  assign io_writes_0_rsp_valid = write_arbiter_0_doIt_regNext;
  assign io_writes_0_rsp_payload_context = io_writes_0_cmd_payload_context_regNext;
  assign read_ports_0_buffer_bufferIn_valid = read_ports_0_buffer_s1_valid;
  assign read_ports_0_buffer_bufferIn_payload_context = read_ports_0_buffer_s1_payload_context;
  assign read_ports_0_buffer_bufferIn_payload_data = banks_0_read_rsp_data;
  assign read_ports_0_buffer_bufferIn_payload_mask = banks_0_read_rsp_mask;
  assign read_ports_0_buffer_bufferOut_valid = (read_ports_0_buffer_bufferIn_valid || read_ports_0_buffer_bufferIn_s2mPipe_rValid);
  assign read_ports_0_buffer_bufferIn_ready = (! read_ports_0_buffer_bufferIn_s2mPipe_rValid);
  assign read_ports_0_buffer_bufferOut_payload_data = (read_ports_0_buffer_bufferIn_s2mPipe_rValid ? read_ports_0_buffer_bufferIn_s2mPipe_rData_data : read_ports_0_buffer_bufferIn_payload_data);
  assign read_ports_0_buffer_bufferOut_payload_mask = (read_ports_0_buffer_bufferIn_s2mPipe_rValid ? read_ports_0_buffer_bufferIn_s2mPipe_rData_mask : read_ports_0_buffer_bufferIn_payload_mask);
  assign read_ports_0_buffer_bufferOut_payload_context = (read_ports_0_buffer_bufferIn_s2mPipe_rValid ? read_ports_0_buffer_bufferIn_s2mPipe_rData_context : read_ports_0_buffer_bufferIn_payload_context);
  assign io_reads_0_rsp_valid = read_ports_0_buffer_bufferOut_valid;
  assign read_ports_0_buffer_bufferOut_ready = io_reads_0_rsp_ready;
  assign io_reads_0_rsp_payload_data = read_ports_0_buffer_bufferOut_payload_data;
  assign io_reads_0_rsp_payload_mask = read_ports_0_buffer_bufferOut_payload_mask;
  assign io_reads_0_rsp_payload_context = read_ports_0_buffer_bufferOut_payload_context;
  assign read_ports_0_buffer_full = (read_ports_0_buffer_bufferOut_valid && (! read_ports_0_buffer_bufferOut_ready));
  assign _zz_7 = (! read_ports_0_buffer_full);
  assign read_ports_0_cmd_valid = (io_reads_0_cmd_valid && _zz_7);
  assign io_reads_0_cmd_ready = (read_ports_0_cmd_ready && _zz_7);
  assign read_ports_0_cmd_payload_address = io_reads_0_cmd_payload_address;
  assign read_ports_0_cmd_payload_priority = io_reads_0_cmd_payload_priority;
  assign read_ports_0_cmd_payload_context = io_reads_0_cmd_payload_context;
  assign read_arbiter_0_doIt = (read_ports_0_cmd_valid && 1'b1);
  always @ (*) begin
    if(_zz_16)begin
      _zz_8 = 1'b1;
    end else begin
      _zz_8 = 1'b0;
    end
  end

  always @ (*) begin
    if(_zz_16)begin
      _zz_9 = (read_ports_0_cmd_payload_address >>> 0);
    end else begin
      _zz_9 = 8'h0;
    end
  end

  assign read_ports_0_cmd_ready = read_arbiter_0_doIt;
  assign read_ports_0_buffer_s0_valid = read_arbiter_0_doIt;
  assign read_ports_0_buffer_s0_payload_context = read_ports_0_cmd_payload_context;
  assign read_ports_0_buffer_s0_payload_address = read_ports_0_cmd_payload_address;
  assign _zz_10 = {{{_zz_6,_zz_5},_zz_4},_zz_3};
  assign banks_0_writeOr_value_valid = _zz_18[0];
  assign _zz_11 = _zz_10[80 : 1];
  assign banks_0_writeOr_value_payload_address = _zz_11[7 : 0];
  assign _zz_12 = _zz_11[79 : 8];
  assign banks_0_writeOr_value_payload_data_data = _zz_12[63 : 0];
  assign banks_0_writeOr_value_payload_data_mask = _zz_12[71 : 64];
  assign _zz_13 = {_zz_9,_zz_8};
  assign banks_0_readOr_value_valid = _zz_19[0];
  assign banks_0_readOr_value_payload = _zz_13[8 : 1];
  always @ (posedge clk) begin
    if(reset) begin
      write_arbiter_0_doIt_regNext <= 1'b0;
      read_ports_0_buffer_s1_valid <= 1'b0;
      read_ports_0_buffer_bufferIn_s2mPipe_rValid <= 1'b0;
    end else begin
      write_arbiter_0_doIt_regNext <= write_arbiter_0_doIt;
      read_ports_0_buffer_s1_valid <= read_ports_0_buffer_s0_valid;
      if(read_ports_0_buffer_bufferOut_ready)begin
        read_ports_0_buffer_bufferIn_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_17)begin
        read_ports_0_buffer_bufferIn_s2mPipe_rValid <= read_ports_0_buffer_bufferIn_valid;
      end
    end
  end

  always @ (posedge clk) begin
    io_writes_0_cmd_payload_context_regNext <= io_writes_0_cmd_payload_context;
    read_ports_0_buffer_s1_payload_context <= read_ports_0_buffer_s0_payload_context;
    read_ports_0_buffer_s1_payload_address <= read_ports_0_buffer_s0_payload_address;
    if(_zz_17)begin
      read_ports_0_buffer_bufferIn_s2mPipe_rData_data <= read_ports_0_buffer_bufferIn_payload_data;
      read_ports_0_buffer_bufferIn_s2mPipe_rData_mask <= read_ports_0_buffer_bufferIn_payload_mask;
      read_ports_0_buffer_bufferIn_s2mPipe_rData_context <= read_ports_0_buffer_bufferIn_payload_context;
    end
    if(read_ports_0_cmd_valid)begin
      read_ports_0_priority_value <= (read_ports_0_priority_value + read_ports_0_cmd_payload_priority);
      if(read_ports_0_cmd_ready)begin
        read_ports_0_priority_value <= 2'b00;
      end
    end
  end


endmodule

module dma_soc_StreamFifo (
  input               io_push_valid,
  output              io_push_ready,
  input      [21:0]   io_push_payload,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [21:0]   io_pop_payload,
  input               io_flush,
  output reg [2:0]    io_occupancy,
  output reg [2:0]    io_availability,
  input               clk,
  input               reset
);
  reg        [21:0]   _zz_3;
  wire       [0:0]    _zz_4;
  wire       [2:0]    _zz_5;
  wire       [0:0]    _zz_6;
  wire       [2:0]    _zz_7;
  wire       [2:0]    _zz_8;
  wire       [2:0]    _zz_9;
  wire       [2:0]    _zz_10;
  wire       [2:0]    _zz_11;
  wire                _zz_12;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [2:0]    logic_pushPtr_valueNext;
  reg        [2:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [2:0]    logic_popPtr_valueNext;
  reg        [2:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_2;
  wire       [2:0]    logic_ptrDif;
  reg [21:0] logic_ram [0:6];

  assign _zz_4 = logic_pushPtr_willIncrement;
  assign _zz_5 = {2'd0, _zz_4};
  assign _zz_6 = logic_popPtr_willIncrement;
  assign _zz_7 = {2'd0, _zz_6};
  assign _zz_8 = (3'b111 + logic_ptrDif);
  assign _zz_9 = (3'b111 + _zz_10);
  assign _zz_10 = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_11 = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_12 = 1'b1;
  always @ (posedge clk) begin
    if(_zz_12) begin
      _zz_3 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(logic_pushing)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 3'b110);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    if(logic_pushPtr_willOverflow)begin
      logic_pushPtr_valueNext = 3'b000;
    end else begin
      logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_5);
    end
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = 3'b000;
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 3'b110);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    if(logic_popPtr_willOverflow)begin
      logic_popPtr_valueNext = 3'b000;
    end else begin
      logic_popPtr_valueNext = (logic_popPtr_value + _zz_7);
    end
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = 3'b000;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2 && (! logic_full))));
  assign io_pop_payload = _zz_3;
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  always @ (*) begin
    if(logic_ptrMatch)begin
      io_occupancy = (logic_risingOccupancy ? 3'b111 : 3'b000);
    end else begin
      io_occupancy = ((logic_popPtr_value < logic_pushPtr_value) ? logic_ptrDif : _zz_8);
    end
  end

  always @ (*) begin
    if(logic_ptrMatch)begin
      io_availability = (logic_risingOccupancy ? 3'b000 : 3'b111);
    end else begin
      io_availability = ((logic_popPtr_value < logic_pushPtr_value) ? _zz_9 : _zz_11);
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      logic_pushPtr_value <= 3'b000;
      logic_popPtr_value <= 3'b000;
      logic_risingOccupancy <= 1'b0;
      _zz_2 <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2 <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module dma_soc_StreamFork (
  input               io_input_valid,
  output reg          io_input_ready,
  input               io_input_payload_last,
  input      [0:0]    io_input_payload_fragment_opcode,
  input      [31:0]   io_input_payload_fragment_address,
  input      [10:0]   io_input_payload_fragment_length,
  input      [21:0]   io_input_payload_fragment_context,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output              io_outputs_0_payload_last,
  output     [0:0]    io_outputs_0_payload_fragment_opcode,
  output     [31:0]   io_outputs_0_payload_fragment_address,
  output     [10:0]   io_outputs_0_payload_fragment_length,
  output     [21:0]   io_outputs_0_payload_fragment_context,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output              io_outputs_1_payload_last,
  output     [0:0]    io_outputs_1_payload_fragment_opcode,
  output     [31:0]   io_outputs_1_payload_fragment_address,
  output     [10:0]   io_outputs_1_payload_fragment_length,
  output     [21:0]   io_outputs_1_payload_fragment_context,
  input               clk,
  input               reset
);
  reg                 _zz_1;
  reg                 _zz_2;

  always @ (*) begin
    io_input_ready = 1'b1;
    if(((! io_outputs_0_ready) && _zz_1))begin
      io_input_ready = 1'b0;
    end
    if(((! io_outputs_1_ready) && _zz_2))begin
      io_input_ready = 1'b0;
    end
  end

  assign io_outputs_0_valid = (io_input_valid && _zz_1);
  assign io_outputs_0_payload_last = io_input_payload_last;
  assign io_outputs_0_payload_fragment_opcode = io_input_payload_fragment_opcode;
  assign io_outputs_0_payload_fragment_address = io_input_payload_fragment_address;
  assign io_outputs_0_payload_fragment_length = io_input_payload_fragment_length;
  assign io_outputs_0_payload_fragment_context = io_input_payload_fragment_context;
  assign io_outputs_1_valid = (io_input_valid && _zz_2);
  assign io_outputs_1_payload_last = io_input_payload_last;
  assign io_outputs_1_payload_fragment_opcode = io_input_payload_fragment_opcode;
  assign io_outputs_1_payload_fragment_address = io_input_payload_fragment_address;
  assign io_outputs_1_payload_fragment_length = io_input_payload_fragment_length;
  assign io_outputs_1_payload_fragment_context = io_input_payload_fragment_context;
  always @ (posedge clk) begin
    if(reset) begin
      _zz_1 <= 1'b1;
      _zz_2 <= 1'b1;
    end else begin
      if((io_outputs_0_valid && io_outputs_0_ready))begin
        _zz_1 <= 1'b0;
      end
      if((io_outputs_1_valid && io_outputs_1_ready))begin
        _zz_2 <= 1'b0;
      end
      if(io_input_ready)begin
        _zz_1 <= 1'b1;
        _zz_2 <= 1'b1;
      end
    end
  end


endmodule

//dma_soc_BufferCC replaced by dma_soc_BufferCC

module dma_soc_BufferCC_1 (
  input               io_dataIn,
  output              io_dataOut,
  input               clk,
  input               reset
);
  reg                 buffers_0;
  reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge clk) begin
    if(reset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module dma_soc_BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               ctrl_clk,
  input               ctrl_reset
);
  reg                 buffers_0;
  reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge ctrl_clk) begin
    if(ctrl_reset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
