
module aes_instruction (
  input              clk,
  input              reset,

  input              cmd_valid,
  output             cmd_ready,
  input     [9:0]    cmd_function_id,
  input     [31:0]   cmd_inputs_0,
  input     [31:0]   cmd_inputs_1,

  output             rsp_valid,
  input              rsp_ready,
  output    [31:0]   rsp_outputs_0
);

  parameter DECRYPT = 3;      // 0/1 =>  encrypt/decrypt
  parameter LAST_ROUND = 4;
  parameter BYTE_SEL = 6;     //Which byte should be used in inputs_1

  reg          s1_valid;
  wire         s1_ready;

  reg          s2_valid;
  wire         s2_ready;
  reg [31 : 0] s2_result;

  // Stages arbitration
  assign cmd_ready =  s1_ready;
  assign s1_ready  = !s1_valid || s2_ready;
  assign s2_ready  = !s2_valid || rsp_ready;
  assign rsp_valid = s2_valid;

  always @ (posedge clk) begin
    if(reset) begin
      s1_valid <= 1'b0;
      s2_valid <= 1'h0;
    end else begin
      if(s1_ready) begin
        s1_valid <= cmd_valid;
      end
      if(s2_ready) begin
        s2_valid <= s1_valid;
      end
    end
  end

  // Stage 1 registers
  reg          s1_decrypt;
  reg          s1_last_round;
  reg [ 1 : 0] s1_byte_sel;
  reg [31 : 0] s1_inputs_0;
  always @ (posedge clk) begin
    if(s1_ready) begin
      s1_decrypt    <= cmd_function_id[DECRYPT];
      s1_last_round <= cmd_function_id[LAST_ROUND];
      s1_byte_sel   <= cmd_function_id[BYTE_SEL +: 2];
      s1_inputs_0    <= cmd_inputs_0;
    end
  end

  // Select which byte from inputs_1 should be used
  wire [1:0]  s0_byte_sel = cmd_function_id[BYTE_SEL +: 2];
  reg  [7:0]  s0_byte_value;
  always @(*) begin
    case(s0_byte_sel)
      2'b00 : s0_byte_value = cmd_inputs_1[ 0 +: 8];
      2'b01 : s0_byte_value = cmd_inputs_1[ 8 +: 8];
      2'b10 : s0_byte_value = cmd_inputs_1[16 +: 8];
      2'b11 : s0_byte_value = cmd_inputs_1[24 +: 8];
    endcase
  end

  // Read the ROM
  wire          s0_bank_sel    = cmd_function_id[DECRYPT] && !cmd_function_id[LAST_ROUND];
  wire [ 8 : 0] s0_rom_address = {s0_bank_sel, s0_byte_value};
  reg  [31 : 0] s1_rom_data;
  reg  [7:0]    s1_rom_bytes [0:3];
  `include "aes_rom.h"

  always @ (posedge clk) begin
    if(s1_ready) begin
      s1_rom_data <= aes_rom[s0_rom_address];
    end
  end

  always @(*) begin
    s1_rom_bytes[0] = s1_rom_data[ 0 +: 8];
    s1_rom_bytes[1] = s1_rom_data[ 8 +: 8];
    s1_rom_bytes[2] = s1_rom_data[16 +: 8];
    s1_rom_bytes[3] = s1_rom_data[24 +: 8];
  end

  // Decode which bytes of the result should be forced to zero
  reg [3:0] s1_zero;
  always @(*) begin
    if(s1_last_round) begin
      s1_zero = 4'b1111;
      s1_zero[s1_byte_sel] = 1'b0;
    end else begin
      s1_zero = 4'b0000;
    end
  end

  // Generate the shuffleing index to read the ROM data depending the encryption mode
  reg [1:0] s1_shuffle_rom_decode [0:3];
  wire [1:0] s1_decode_sel = {s1_decrypt, s1_last_round};
  always @(*) begin
    case(s1_decode_sel)
      2'b00 : begin
        s1_shuffle_rom_decode[0] = 2;
        s1_shuffle_rom_decode[1] = 0;
        s1_shuffle_rom_decode[2] = 0;
        s1_shuffle_rom_decode[3] = 1;
      end
      2'b01 : begin
        s1_shuffle_rom_decode[0] = 0;
        s1_shuffle_rom_decode[1] = 0;
        s1_shuffle_rom_decode[2] = 0;
        s1_shuffle_rom_decode[3] = 0;
      end
      2'b10 : begin
        s1_shuffle_rom_decode[0] = 3;
        s1_shuffle_rom_decode[1] = 2;
        s1_shuffle_rom_decode[2] = 1;
        s1_shuffle_rom_decode[3] = 0;
      end
      2'b11 : begin
        s1_shuffle_rom_decode[0] = 3;
        s1_shuffle_rom_decode[1] = 3;
        s1_shuffle_rom_decode[2] = 3;
        s1_shuffle_rom_decode[3] = 3;
      end
    endcase
  end

  // Generate the shuffleing index to read the ROM data depending which byte was selected
  reg [1:0] s1_shuffle_byte_sel [0:3];
  always @(*) begin
    case(s1_byte_sel)
      2'b00 : begin
        s1_shuffle_byte_sel[0] = s1_shuffle_rom_decode[3];
        s1_shuffle_byte_sel[1] = s1_shuffle_rom_decode[2];
        s1_shuffle_byte_sel[2] = s1_shuffle_rom_decode[1];
        s1_shuffle_byte_sel[3] = s1_shuffle_rom_decode[0];
      end
      2'b01 : begin
        s1_shuffle_byte_sel[0] = s1_shuffle_rom_decode[0];
        s1_shuffle_byte_sel[1] = s1_shuffle_rom_decode[3];
        s1_shuffle_byte_sel[2] = s1_shuffle_rom_decode[2];
        s1_shuffle_byte_sel[3] = s1_shuffle_rom_decode[1];
      end
      2'b10 : begin
        s1_shuffle_byte_sel[0] = s1_shuffle_rom_decode[1];
        s1_shuffle_byte_sel[1] = s1_shuffle_rom_decode[0];
        s1_shuffle_byte_sel[2] = s1_shuffle_rom_decode[3];
        s1_shuffle_byte_sel[3] = s1_shuffle_rom_decode[2];
      end
      2'b11 : begin
        s1_shuffle_byte_sel[0] = s1_shuffle_rom_decode[2];
        s1_shuffle_byte_sel[1] = s1_shuffle_rom_decode[1];
        s1_shuffle_byte_sel[2] = s1_shuffle_rom_decode[0];
        s1_shuffle_byte_sel[3] = s1_shuffle_rom_decode[3];
      end
    endcase
  end

  // Shuffle the data of the ROM
  reg [31:0] s1_shuffle_data;
  integer i;
  always @ (*) begin
    for(i = 0;i < 4;i = i + 1) begin
      s1_shuffle_data[i*8 +: 8] = s1_zero[i] ? 8'b0 : s1_rom_bytes[s1_shuffle_byte_sel[i]];
    end
  end

  wire [31 : 0] s1_xored = s1_shuffle_data ^ s1_inputs_0;

  // Stage 2 (Just carry data around)
  always @ (posedge clk) begin
    if(s2_ready) begin
      s2_result <= s1_xored;
    end
  end

  assign rsp_outputs_0   = s2_result;
endmodule
