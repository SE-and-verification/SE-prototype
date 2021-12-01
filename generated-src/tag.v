module AESEncrypt(
  output  io_output_text_0,
  output  io_output_text_1,
  output  io_output_text_2,
  output  io_output_text_3,
  output  io_output_text_4,
  output  io_output_text_5,
  output  io_output_text_6,
  output  io_output_text_7,
  output  io_output_text_8,
  output  io_output_text_9,
  output  io_output_text_10,
  output  io_output_text_11,
  output  io_output_text_12,
  output  io_output_text_13,
  output  io_output_text_14,
  output  io_output_text_15,
  output  io_output_valid
);
  assign io_output_text_0 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_1 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_2 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_3 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_4 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_5 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_6 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_7 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_8 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_9 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_10 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_11 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_12 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_13 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_14 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_15 = 0'h1; // @[AESEncrypt.scala 54:18]
  assign io_output_valid = 0'h1; // @[AESEncrypt.scala 53:19]
endmodule
module SEChangeKey(
  input   clock,
  input   reset,
  input   io_in_inst,
  input   io_in_op1,
  input   io_in_op2,
  input   io_in_cond,
  input   io_in_valid,
  output  io_in_ready,
  input   io_in_changeKey_en,
  input   io_in_newKey_0_0,
  input   io_in_newKey_0_1,
  input   io_in_newKey_0_2,
  input   io_in_newKey_0_3,
  input   io_in_newKey_0_4,
  input   io_in_newKey_0_5,
  input   io_in_newKey_0_6,
  input   io_in_newKey_0_7,
  input   io_in_newKey_0_8,
  input   io_in_newKey_0_9,
  input   io_in_newKey_0_10,
  input   io_in_newKey_0_11,
  input   io_in_newKey_0_12,
  input   io_in_newKey_0_13,
  input   io_in_newKey_0_14,
  input   io_in_newKey_0_15,
  input   io_in_newKey_1_0,
  input   io_in_newKey_1_1,
  input   io_in_newKey_1_2,
  input   io_in_newKey_1_3,
  input   io_in_newKey_1_4,
  input   io_in_newKey_1_5,
  input   io_in_newKey_1_6,
  input   io_in_newKey_1_7,
  input   io_in_newKey_1_8,
  input   io_in_newKey_1_9,
  input   io_in_newKey_1_10,
  input   io_in_newKey_1_11,
  input   io_in_newKey_1_12,
  input   io_in_newKey_1_13,
  input   io_in_newKey_1_14,
  input   io_in_newKey_1_15,
  input   io_in_newKey_2_0,
  input   io_in_newKey_2_1,
  input   io_in_newKey_2_2,
  input   io_in_newKey_2_3,
  input   io_in_newKey_2_4,
  input   io_in_newKey_2_5,
  input   io_in_newKey_2_6,
  input   io_in_newKey_2_7,
  input   io_in_newKey_2_8,
  input   io_in_newKey_2_9,
  input   io_in_newKey_2_10,
  input   io_in_newKey_2_11,
  input   io_in_newKey_2_12,
  input   io_in_newKey_2_13,
  input   io_in_newKey_2_14,
  input   io_in_newKey_2_15,
  input   io_in_newKey_3_0,
  input   io_in_newKey_3_1,
  input   io_in_newKey_3_2,
  input   io_in_newKey_3_3,
  input   io_in_newKey_3_4,
  input   io_in_newKey_3_5,
  input   io_in_newKey_3_6,
  input   io_in_newKey_3_7,
  input   io_in_newKey_3_8,
  input   io_in_newKey_3_9,
  input   io_in_newKey_3_10,
  input   io_in_newKey_3_11,
  input   io_in_newKey_3_12,
  input   io_in_newKey_3_13,
  input   io_in_newKey_3_14,
  input   io_in_newKey_3_15,
  input   io_in_newKey_4_0,
  input   io_in_newKey_4_1,
  input   io_in_newKey_4_2,
  input   io_in_newKey_4_3,
  input   io_in_newKey_4_4,
  input   io_in_newKey_4_5,
  input   io_in_newKey_4_6,
  input   io_in_newKey_4_7,
  input   io_in_newKey_4_8,
  input   io_in_newKey_4_9,
  input   io_in_newKey_4_10,
  input   io_in_newKey_4_11,
  input   io_in_newKey_4_12,
  input   io_in_newKey_4_13,
  input   io_in_newKey_4_14,
  input   io_in_newKey_4_15,
  input   io_in_newKey_5_0,
  input   io_in_newKey_5_1,
  input   io_in_newKey_5_2,
  input   io_in_newKey_5_3,
  input   io_in_newKey_5_4,
  input   io_in_newKey_5_5,
  input   io_in_newKey_5_6,
  input   io_in_newKey_5_7,
  input   io_in_newKey_5_8,
  input   io_in_newKey_5_9,
  input   io_in_newKey_5_10,
  input   io_in_newKey_5_11,
  input   io_in_newKey_5_12,
  input   io_in_newKey_5_13,
  input   io_in_newKey_5_14,
  input   io_in_newKey_5_15,
  input   io_in_newKey_6_0,
  input   io_in_newKey_6_1,
  input   io_in_newKey_6_2,
  input   io_in_newKey_6_3,
  input   io_in_newKey_6_4,
  input   io_in_newKey_6_5,
  input   io_in_newKey_6_6,
  input   io_in_newKey_6_7,
  input   io_in_newKey_6_8,
  input   io_in_newKey_6_9,
  input   io_in_newKey_6_10,
  input   io_in_newKey_6_11,
  input   io_in_newKey_6_12,
  input   io_in_newKey_6_13,
  input   io_in_newKey_6_14,
  input   io_in_newKey_6_15,
  input   io_in_newKey_7_0,
  input   io_in_newKey_7_1,
  input   io_in_newKey_7_2,
  input   io_in_newKey_7_3,
  input   io_in_newKey_7_4,
  input   io_in_newKey_7_5,
  input   io_in_newKey_7_6,
  input   io_in_newKey_7_7,
  input   io_in_newKey_7_8,
  input   io_in_newKey_7_9,
  input   io_in_newKey_7_10,
  input   io_in_newKey_7_11,
  input   io_in_newKey_7_12,
  input   io_in_newKey_7_13,
  input   io_in_newKey_7_14,
  input   io_in_newKey_7_15,
  input   io_in_newKey_8_0,
  input   io_in_newKey_8_1,
  input   io_in_newKey_8_2,
  input   io_in_newKey_8_3,
  input   io_in_newKey_8_4,
  input   io_in_newKey_8_5,
  input   io_in_newKey_8_6,
  input   io_in_newKey_8_7,
  input   io_in_newKey_8_8,
  input   io_in_newKey_8_9,
  input   io_in_newKey_8_10,
  input   io_in_newKey_8_11,
  input   io_in_newKey_8_12,
  input   io_in_newKey_8_13,
  input   io_in_newKey_8_14,
  input   io_in_newKey_8_15,
  input   io_in_newKey_9_0,
  input   io_in_newKey_9_1,
  input   io_in_newKey_9_2,
  input   io_in_newKey_9_3,
  input   io_in_newKey_9_4,
  input   io_in_newKey_9_5,
  input   io_in_newKey_9_6,
  input   io_in_newKey_9_7,
  input   io_in_newKey_9_8,
  input   io_in_newKey_9_9,
  input   io_in_newKey_9_10,
  input   io_in_newKey_9_11,
  input   io_in_newKey_9_12,
  input   io_in_newKey_9_13,
  input   io_in_newKey_9_14,
  input   io_in_newKey_9_15,
  input   io_in_newKey_10_0,
  input   io_in_newKey_10_1,
  input   io_in_newKey_10_2,
  input   io_in_newKey_10_3,
  input   io_in_newKey_10_4,
  input   io_in_newKey_10_5,
  input   io_in_newKey_10_6,
  input   io_in_newKey_10_7,
  input   io_in_newKey_10_8,
  input   io_in_newKey_10_9,
  input   io_in_newKey_10_10,
  input   io_in_newKey_10_11,
  input   io_in_newKey_10_12,
  input   io_in_newKey_10_13,
  input   io_in_newKey_10_14,
  input   io_in_newKey_10_15,
  output  io_out_result,
  output  io_out_valid,
  input   io_out_ready,
  output  io_out_cntr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  aes_cipher_io_output_text_0; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_1; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_2; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_3; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_4; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_5; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_6; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_7; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_8; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_9; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_10; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_11; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_12; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_13; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_14; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_text_15; // @[SE.scala 248:32]
  wire  aes_cipher_io_output_valid; // @[SE.scala 248:32]
  reg  value; // @[Counter.scala 60:40]
  wire  _GEN_0 = 1'h1 & (value & 1'h1); // @[Counter.scala 76:15 86:{20,28}]
  wire  _GEN_1 = _GEN_0 & value; // @[SE.scala 230:24 Counter.scala 60:40]
  wire  _T_1 = io_out_valid & io_out_ready; // @[SE.scala 235:33]
  wire  _GEN_4 = 1'h1 & _GEN_1; // @[SE.scala 238:43 Counter.scala 97:11]
  reg  ready_for_input; // @[SE.scala 280:38]
  wire  _GEN_361 = _T_1 & ready_for_input; // @[SE.scala 286:49 287:33 280:38]
  wire  _GEN_362 = 1'h1 & _GEN_361; // @[SE.scala 284:41 285:33]
  wire  lo_lo_lo_4 = aes_cipher_io_output_text_1 & aes_cipher_io_output_text_0; // @[SE.scala 401:65]
  wire  lo_lo_hi_4 = aes_cipher_io_output_text_3 & aes_cipher_io_output_text_2; // @[SE.scala 401:65]
  wire  lo_lo_4 = lo_lo_hi_4 & lo_lo_lo_4; // @[SE.scala 401:65]
  wire  lo_hi_lo_4 = aes_cipher_io_output_text_5 & aes_cipher_io_output_text_4; // @[SE.scala 401:65]
  wire  lo_hi_hi_4 = aes_cipher_io_output_text_7 & aes_cipher_io_output_text_6; // @[SE.scala 401:65]
  wire  lo_hi_4 = lo_hi_hi_4 & lo_hi_lo_4; // @[SE.scala 401:65]
  wire  lo_4 = lo_hi_4 & lo_lo_4; // @[SE.scala 401:65]
  wire  hi_lo_lo_4 = aes_cipher_io_output_text_9 & aes_cipher_io_output_text_8; // @[SE.scala 401:65]
  wire  hi_lo_hi_4 = aes_cipher_io_output_text_11 & aes_cipher_io_output_text_10; // @[SE.scala 401:65]
  wire  hi_lo_4 = hi_lo_hi_4 & hi_lo_lo_4; // @[SE.scala 401:65]
  wire  hi_hi_lo_4 = aes_cipher_io_output_text_13 & aes_cipher_io_output_text_12; // @[SE.scala 401:65]
  wire  hi_hi_hi_4 = aes_cipher_io_output_text_15 & aes_cipher_io_output_text_14; // @[SE.scala 401:65]
  wire  hi_hi_4 = hi_hi_hi_4 & hi_hi_lo_4; // @[SE.scala 401:65]
  wire  hi_4 = hi_hi_4 & hi_lo_4; // @[SE.scala 401:65]
  wire  _T_87 = hi_4 & lo_4; // @[SE.scala 401:65]
  reg  output_buffer; // @[Reg.scala 15:16]
  reg  output_valid; // @[SE.scala 402:35]
  wire  _GEN_373 = 1'h1 & output_valid; // @[SE.scala 406:49 407:30 402:35]
  wire  _GEN_374 = aes_cipher_io_output_valid & _GEN_373; // @[SE.scala 404:41 405:30]
  AESEncrypt aes_cipher ( // @[SE.scala 248:32]
    .io_output_text_0(aes_cipher_io_output_text_0),
    .io_output_text_1(aes_cipher_io_output_text_1),
    .io_output_text_2(aes_cipher_io_output_text_2),
    .io_output_text_3(aes_cipher_io_output_text_3),
    .io_output_text_4(aes_cipher_io_output_text_4),
    .io_output_text_5(aes_cipher_io_output_text_5),
    .io_output_text_6(aes_cipher_io_output_text_6),
    .io_output_text_7(aes_cipher_io_output_text_7),
    .io_output_text_8(aes_cipher_io_output_text_8),
    .io_output_text_9(aes_cipher_io_output_text_9),
    .io_output_text_10(aes_cipher_io_output_text_10),
    .io_output_text_11(aes_cipher_io_output_text_11),
    .io_output_text_12(aes_cipher_io_output_text_12),
    .io_output_text_13(aes_cipher_io_output_text_13),
    .io_output_text_14(aes_cipher_io_output_text_14),
    .io_output_text_15(aes_cipher_io_output_text_15),
    .io_output_valid(aes_cipher_io_output_valid)
  );
  assign io_in_ready = ready_for_input; // @[SE.scala 281:21]
  assign io_out_result = output_buffer; // @[SE.scala 410:23]
  assign io_out_valid = output_valid; // @[SE.scala 409:22]
  assign io_out_cntr = value; // @[SE.scala 241:21]
  always @(posedge clock) begin
    value <= 1'h1 & _GEN_4; // @[Counter.scala 60:{40,40}]
    ready_for_input <= reset & _GEN_362; // @[SE.scala 280:{38,38}]
    output_buffer <= _T_87 & output_buffer; // @[Reg.scala 15:16 16:{19,23}]
    output_valid <= 1'h1 & _GEN_374; // @[SE.scala 402:{35,35}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ready_for_input = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  output_buffer = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  output_valid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
