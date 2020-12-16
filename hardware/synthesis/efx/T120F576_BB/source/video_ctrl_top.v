// Generator : SpinalHDL v1.4.3    git head : 4fd8398d5fba36a98c16bebd901beeff22a7c8d9
// Component : video_ctrl_top
// Git hash  : 7792519b6f8e7c2479ab15ee34c3a9edda4a0a44



module video_ctrl_top (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [31:0]   io_input_payload_data,
  input      [3:0]    io_input_payload_mask,
  input               io_input_payload_last,
  output              io_vga_vSync,
  output              io_vga_hSync,
  output              io_vga_colorEn,
  output     [7:0]    io_vga_color_r,
  output     [7:0]    io_vga_color_g,
  output     [7:0]    io_vga_color_b,
  input               clk,
  input               reset
);
  wire                _zz_4;
  wire       [11:0]   _zz_5;
  wire       [11:0]   _zz_6;
  wire       [11:0]   _zz_7;
  wire       [11:0]   _zz_8;
  wire                _zz_9;
  wire       [11:0]   _zz_10;
  wire       [11:0]   _zz_11;
  wire       [11:0]   _zz_12;
  wire       [11:0]   _zz_13;
  wire                _zz_14;
  wire                _zz_15;
  wire                ctrl_io_frameStart;
  wire                ctrl_io_pixels_ready;
  wire                ctrl_io_vga_vSync;
  wire                ctrl_io_vga_hSync;
  wire                ctrl_io_vga_colorEn;
  wire       [7:0]    ctrl_io_vga_color_r;
  wire       [7:0]    ctrl_io_vga_color_g;
  wire       [7:0]    ctrl_io_vga_color_b;
  wire                ctrl_io_error;
  reg                 run;
  wire                input_valid;
  wire                input_ready;
  wire                input_payload_last;
  wire       [31:0]   input_payload_fragment;
  wire                adapted_valid;
  wire                adapted_ready;
  wire                adapted_payload_last;
  wire       [7:0]    adapted_payload_fragment_r;
  wire       [7:0]    adapted_payload_fragment_g;
  wire       [7:0]    adapted_payload_fragment_b;
  reg                 run_regNext;
  reg                 _zz_1;
  reg                 _zz_2;
  wire                adapted_translated_valid;
  reg                 adapted_translated_ready;
  wire       [7:0]    adapted_translated_payload_r;
  wire       [7:0]    adapted_translated_payload_g;
  wire       [7:0]    adapted_translated_payload_b;
  reg                 adapted_translated_thrown_valid;
  wire                adapted_translated_thrown_ready;
  wire       [7:0]    adapted_translated_thrown_payload_r;
  wire       [7:0]    adapted_translated_thrown_payload_g;
  wire       [7:0]    adapted_translated_thrown_payload_b;
  wire                _zz_3;

  video_ctrl_VgaCtrl ctrl (
    .io_softReset               (_zz_4                                     ), //i
    .io_timings_h_syncStart     (_zz_5[11:0]                               ), //i
    .io_timings_h_syncEnd       (_zz_6[11:0]                               ), //i
    .io_timings_h_colorStart    (_zz_7[11:0]                               ), //i
    .io_timings_h_colorEnd      (_zz_8[11:0]                               ), //i
    .io_timings_h_polarity      (_zz_9                                     ), //i
    .io_timings_v_syncStart     (_zz_10[11:0]                              ), //i
    .io_timings_v_syncEnd       (_zz_11[11:0]                              ), //i
    .io_timings_v_colorStart    (_zz_12[11:0]                              ), //i
    .io_timings_v_colorEnd      (_zz_13[11:0]                              ), //i
    .io_timings_v_polarity      (_zz_14                                    ), //i
    .io_frameStart              (ctrl_io_frameStart                        ), //o
    .io_pixels_valid            (_zz_15                                    ), //i
    .io_pixels_ready            (ctrl_io_pixels_ready                      ), //o
    .io_pixels_payload_r        (adapted_translated_thrown_payload_r[7:0]  ), //i
    .io_pixels_payload_g        (adapted_translated_thrown_payload_g[7:0]  ), //i
    .io_pixels_payload_b        (adapted_translated_thrown_payload_b[7:0]  ), //i
    .io_vga_vSync               (ctrl_io_vga_vSync                         ), //o
    .io_vga_hSync               (ctrl_io_vga_hSync                         ), //o
    .io_vga_colorEn             (ctrl_io_vga_colorEn                       ), //o
    .io_vga_color_r             (ctrl_io_vga_color_r[7:0]                  ), //o
    .io_vga_color_g             (ctrl_io_vga_color_g[7:0]                  ), //o
    .io_vga_color_b             (ctrl_io_vga_color_b[7:0]                  ), //o
    .io_error                   (ctrl_io_error                             ), //o
    .clk                        (clk                                       ), //i
    .reset                      (reset                                     )  //i
  );
  assign input_valid = io_input_valid;
  always @ (*) begin
    io_input_ready = input_ready;
    if((! run))begin
      io_input_ready = 1'b1;
    end
  end

  assign input_payload_fragment = io_input_payload_data;
  assign input_payload_last = io_input_payload_last;
  assign adapted_valid = input_valid;
  assign input_ready = adapted_ready;
  assign adapted_payload_last = input_payload_last;
  assign adapted_payload_fragment_b = input_payload_fragment[23 : 16];
  assign adapted_payload_fragment_g = input_payload_fragment[15 : 8];
  assign adapted_payload_fragment_r = input_payload_fragment[7 : 0];
  assign adapted_translated_valid = adapted_valid;
  assign adapted_ready = adapted_translated_ready;
  assign adapted_translated_payload_r = adapted_payload_fragment_r;
  assign adapted_translated_payload_g = adapted_payload_fragment_g;
  assign adapted_translated_payload_b = adapted_payload_fragment_b;
  always @ (*) begin
    adapted_translated_thrown_valid = adapted_translated_valid;
    if(_zz_1)begin
      adapted_translated_thrown_valid = 1'b0;
    end
  end

  always @ (*) begin
    adapted_translated_ready = adapted_translated_thrown_ready;
    if(_zz_1)begin
      adapted_translated_ready = 1'b1;
    end
  end

  assign adapted_translated_thrown_payload_r = adapted_translated_payload_r;
  assign adapted_translated_thrown_payload_g = adapted_translated_payload_g;
  assign adapted_translated_thrown_payload_b = adapted_translated_payload_b;
  assign _zz_3 = (! _zz_2);
  assign adapted_translated_thrown_ready = (ctrl_io_pixels_ready && _zz_3);
  assign _zz_15 = (adapted_translated_thrown_valid && _zz_3);
  assign _zz_4 = (! run);
  assign io_vga_vSync = ctrl_io_vga_vSync;
  assign io_vga_hSync = ctrl_io_vga_hSync;
  assign io_vga_colorEn = ctrl_io_vga_colorEn;
  assign io_vga_color_r = ctrl_io_vga_color_r;
  assign io_vga_color_g = ctrl_io_vga_color_g;
  assign io_vga_color_b = ctrl_io_vga_color_b;
  assign _zz_5 = 12'h02b;
  assign _zz_7 = 12'h0bf;
  assign _zz_8 = 12'h83f;
  assign _zz_6 = 12'h897;
  assign _zz_10 = 12'h004;
  assign _zz_12 = 12'h028;
  assign _zz_13 = 12'h460;
  assign _zz_11 = 12'h464;
  assign _zz_9 = 1'b1;
  assign _zz_14 = 1'b1;
  always @ (posedge clk) begin
    if(reset) begin
      run <= 1'b0;
      _zz_1 <= 1'b0;
      _zz_2 <= 1'b0;
    end else begin
      run <= 1'b1;
      if(ctrl_io_frameStart)begin
        _zz_2 <= 1'b0;
      end
      if(((adapted_valid && adapted_ready) && adapted_payload_last))begin
        _zz_1 <= 1'b0;
        _zz_2 <= _zz_1;
      end
      if(((! _zz_2) && (! _zz_1)))begin
        if((ctrl_io_error || (run && (! run_regNext))))begin
          _zz_1 <= 1'b1;
        end
      end
    end
  end

  always @ (posedge clk) begin
    run_regNext <= run;
  end


endmodule

module video_ctrl_VgaCtrl (
  input               io_softReset,
  input      [11:0]   io_timings_h_syncStart,
  input      [11:0]   io_timings_h_syncEnd,
  input      [11:0]   io_timings_h_colorStart,
  input      [11:0]   io_timings_h_colorEnd,
  input               io_timings_h_polarity,
  input      [11:0]   io_timings_v_syncStart,
  input      [11:0]   io_timings_v_syncEnd,
  input      [11:0]   io_timings_v_colorStart,
  input      [11:0]   io_timings_v_colorEnd,
  input               io_timings_v_polarity,
  output              io_frameStart,
  input               io_pixels_valid,
  output              io_pixels_ready,
  input      [7:0]    io_pixels_payload_r,
  input      [7:0]    io_pixels_payload_g,
  input      [7:0]    io_pixels_payload_b,
  output              io_vga_vSync,
  output              io_vga_hSync,
  output              io_vga_colorEn,
  output     [7:0]    io_vga_color_r,
  output     [7:0]    io_vga_color_g,
  output     [7:0]    io_vga_color_b,
  output              io_error,
  input               clk,
  input               reset
);
  reg        [11:0]   h_counter;
  wire                h_syncStart;
  wire                h_syncEnd;
  wire                h_colorStart;
  wire                h_colorEnd;
  reg                 h_sync;
  reg                 h_colorEn;
  reg        [11:0]   v_counter;
  wire                v_syncStart;
  wire                v_syncEnd;
  wire                v_colorStart;
  wire                v_colorEnd;
  reg                 v_sync;
  reg                 v_colorEn;
  wire                colorEn;

  assign h_syncStart = (h_counter == io_timings_h_syncStart);
  assign h_syncEnd = (h_counter == io_timings_h_syncEnd);
  assign h_colorStart = (h_counter == io_timings_h_colorStart);
  assign h_colorEnd = (h_counter == io_timings_h_colorEnd);
  assign v_syncStart = (v_counter == io_timings_v_syncStart);
  assign v_syncEnd = (v_counter == io_timings_v_syncEnd);
  assign v_colorStart = (v_counter == io_timings_v_colorStart);
  assign v_colorEnd = (v_counter == io_timings_v_colorEnd);
  assign colorEn = (h_colorEn && v_colorEn);
  assign io_pixels_ready = colorEn;
  assign io_error = (colorEn && (! io_pixels_valid));
  assign io_frameStart = (v_syncStart && h_syncStart);
  assign io_vga_hSync = (h_sync ^ io_timings_h_polarity);
  assign io_vga_vSync = (v_sync ^ io_timings_v_polarity);
  assign io_vga_colorEn = colorEn;
  assign io_vga_color_r = io_pixels_payload_r;
  assign io_vga_color_g = io_pixels_payload_g;
  assign io_vga_color_b = io_pixels_payload_b;
  always @ (posedge clk) begin
    if(reset) begin
      h_counter <= 12'h0;
      h_sync <= 1'b0;
      h_colorEn <= 1'b0;
      v_counter <= 12'h0;
      v_sync <= 1'b0;
      v_colorEn <= 1'b0;
    end else begin
      if(1'b1)begin
        h_counter <= (h_counter + 12'h001);
        if(h_syncEnd)begin
          h_counter <= 12'h0;
        end
      end
      if(h_syncStart)begin
        h_sync <= 1'b1;
      end
      if(h_syncEnd)begin
        h_sync <= 1'b0;
      end
      if(h_colorStart)begin
        h_colorEn <= 1'b1;
      end
      if(h_colorEnd)begin
        h_colorEn <= 1'b0;
      end
      if(io_softReset)begin
        h_counter <= 12'h0;
        h_sync <= 1'b0;
        h_colorEn <= 1'b0;
      end
      if(h_syncEnd)begin
        v_counter <= (v_counter + 12'h001);
        if(v_syncEnd)begin
          v_counter <= 12'h0;
        end
      end
      if(v_syncStart)begin
        v_sync <= 1'b1;
      end
      if(v_syncEnd)begin
        v_sync <= 1'b0;
      end
      if(v_colorStart)begin
        v_colorEn <= 1'b1;
      end
      if(v_colorEnd)begin
        v_colorEn <= 1'b0;
      end
      if(io_softReset)begin
        v_counter <= 12'h0;
        v_sync <= 1'b0;
        v_colorEn <= 1'b0;
      end
    end
  end


endmodule
