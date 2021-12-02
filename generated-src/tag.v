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
  output  io_output_intermediate,
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
  assign io_output_intermediate = 0'h1; // @[AESEncrypt.scala 52:26]
  assign io_output_valid = 0'h1; // @[AESEncrypt.scala 53:19]
endmodule
module SE(
  input   clock,
  input   reset,
  input   io_in_inst,
  input   io_in_op1,
  input   io_in_op2,
  input   io_in_cond,
  input   io_in_valid,
  output  io_in_ready,
  output  io_out_result,
  output  io_out_valid,
  input   io_out_ready,
  output  io_out_cntr,
  output  io_out_zero_cntr,
  output  io_out_mult_cntr,
  output  io_out_intermediate
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  aes_cipher_io_output_text_0; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_1; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_2; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_3; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_4; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_5; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_6; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_7; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_8; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_9; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_10; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_11; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_12; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_13; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_14; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_text_15; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_intermediate; // @[SE.scala 85:32]
  wire  aes_cipher_io_output_valid; // @[SE.scala 85:32]
  reg  value; // @[Counter.scala 60:40]
  reg  zero_cntr; // @[SE.scala 63:32]
  reg  mult_cntr; // @[SE.scala 64:32]
  wire  _GEN_0 = 1'h1 & (value & 1'h1); // @[Counter.scala 76:15 86:{20,28}]
  wire  _GEN_1 = _GEN_0 & value; // @[SE.scala 67:24 Counter.scala 60:40]
  wire  _T_1 = io_out_valid & io_out_ready; // @[SE.scala 72:33]
  wire  _GEN_4 = 1'h1 & _GEN_1; // @[SE.scala 75:43 Counter.scala 97:11]
  reg  ready_for_input; // @[SE.scala 117:38]
  wire  _GEN_185 = _T_1 & ready_for_input; // @[SE.scala 123:49 124:33 117:38]
  wire  _GEN_186 = 1'h1 & _GEN_185; // @[SE.scala 121:41 122:33]
  wire  _GEN_190 = zero_cntr & 1'h1 & zero_cntr; // @[SE.scala 211:44 212:27 63:32]
  wire  _GEN_191 = mult_cntr & 1'h1 & mult_cntr; // @[SE.scala 214:56 215:27 64:32]
  wire  lo_lo_lo_4 = aes_cipher_io_output_text_1 & aes_cipher_io_output_text_0; // @[SE.scala 219:65]
  wire  lo_lo_hi_4 = aes_cipher_io_output_text_3 & aes_cipher_io_output_text_2; // @[SE.scala 219:65]
  wire  lo_lo_4 = lo_lo_hi_4 & lo_lo_lo_4; // @[SE.scala 219:65]
  wire  lo_hi_lo_4 = aes_cipher_io_output_text_5 & aes_cipher_io_output_text_4; // @[SE.scala 219:65]
  wire  lo_hi_hi_4 = aes_cipher_io_output_text_7 & aes_cipher_io_output_text_6; // @[SE.scala 219:65]
  wire  lo_hi_4 = lo_hi_hi_4 & lo_hi_lo_4; // @[SE.scala 219:65]
  wire  lo_4 = lo_hi_4 & lo_lo_4; // @[SE.scala 219:65]
  wire  hi_lo_lo_4 = aes_cipher_io_output_text_9 & aes_cipher_io_output_text_8; // @[SE.scala 219:65]
  wire  hi_lo_hi_4 = aes_cipher_io_output_text_11 & aes_cipher_io_output_text_10; // @[SE.scala 219:65]
  wire  hi_lo_4 = hi_lo_hi_4 & hi_lo_lo_4; // @[SE.scala 219:65]
  wire  hi_hi_lo_4 = aes_cipher_io_output_text_13 & aes_cipher_io_output_text_12; // @[SE.scala 219:65]
  wire  hi_hi_hi_4 = aes_cipher_io_output_text_15 & aes_cipher_io_output_text_14; // @[SE.scala 219:65]
  wire  hi_hi_4 = hi_hi_hi_4 & hi_hi_lo_4; // @[SE.scala 219:65]
  wire  hi_4 = hi_hi_4 & hi_lo_4; // @[SE.scala 219:65]
  wire  _T_89 = hi_4 & lo_4; // @[SE.scala 219:65]
  reg  output_buffer; // @[Reg.scala 15:16]
  reg  output_valid; // @[SE.scala 220:35]
  wire  _GEN_193 = 1'h1 & output_valid; // @[SE.scala 224:49 225:30 220:35]
  wire  _GEN_194 = aes_cipher_io_output_valid & _GEN_193; // @[SE.scala 222:41 223:30]
  AESEncrypt aes_cipher ( // @[SE.scala 85:32]
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
    .io_output_intermediate(aes_cipher_io_output_intermediate),
    .io_output_valid(aes_cipher_io_output_valid)
  );
  assign io_in_ready = ready_for_input; // @[SE.scala 118:21]
  assign io_out_result = output_buffer; // @[SE.scala 228:23]
  assign io_out_valid = output_valid; // @[SE.scala 227:22]
  assign io_out_cntr = value; // @[SE.scala 78:21]
  assign io_out_zero_cntr = zero_cntr; // @[SE.scala 65:26]
  assign io_out_mult_cntr = mult_cntr; // @[SE.scala 66:26]
  assign io_out_intermediate = aes_cipher_io_output_intermediate; // @[SE.scala 217:29]
  always @(posedge clock) begin
    value <= 1'h1 & _GEN_4; // @[Counter.scala 60:{40,40}]
    zero_cntr <= 1'h1 & _GEN_190; // @[SE.scala 63:{32,32}]
    mult_cntr <= 1'h1 & _GEN_191; // @[SE.scala 64:{32,32}]
    ready_for_input <= reset & _GEN_186; // @[SE.scala 117:{38,38}]
    output_buffer <= _T_89 & output_buffer; // @[Reg.scala 15:16 16:{19,23}]
    output_valid <= 1'h1 & _GEN_194; // @[SE.scala 220:{35,35}]
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
  zero_cntr = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mult_cntr = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  ready_for_input = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  output_buffer = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  output_valid = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
