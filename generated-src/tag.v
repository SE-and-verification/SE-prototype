module CipherRound_10(
  output  io_state_out_0,
  output  io_state_out_1,
  output  io_state_out_2,
  output  io_state_out_3,
  output  io_state_out_4,
  output  io_state_out_5,
  output  io_state_out_6,
  output  io_state_out_7,
  output  io_state_out_8,
  output  io_state_out_9,
  output  io_state_out_10,
  output  io_state_out_11,
  output  io_state_out_12,
  output  io_state_out_13,
  output  io_state_out_14,
  output  io_state_out_15,
  output  io_output_valid
);
  assign io_state_out_0 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_1 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_2 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_3 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_4 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_5 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_6 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_7 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_8 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_9 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_10 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_11 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_12 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_13 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_14 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_state_out_15 = 1'h1; // @[CipherRound.scala 61:18]
  assign io_output_valid = 1'h1; // @[CipherRound.scala 62:21]
endmodule
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
  wire  CipherRoundNMC_io_state_out_0; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_1; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_2; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_3; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_4; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_5; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_6; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_7; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_8; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_9; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_10; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_11; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_12; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_13; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_14; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_state_out_15; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_output_valid; // @[CipherRound.scala 95:84]
  CipherRound_10 CipherRoundNMC ( // @[CipherRound.scala 95:84]
    .io_state_out_0(CipherRoundNMC_io_state_out_0),
    .io_state_out_1(CipherRoundNMC_io_state_out_1),
    .io_state_out_2(CipherRoundNMC_io_state_out_2),
    .io_state_out_3(CipherRoundNMC_io_state_out_3),
    .io_state_out_4(CipherRoundNMC_io_state_out_4),
    .io_state_out_5(CipherRoundNMC_io_state_out_5),
    .io_state_out_6(CipherRoundNMC_io_state_out_6),
    .io_state_out_7(CipherRoundNMC_io_state_out_7),
    .io_state_out_8(CipherRoundNMC_io_state_out_8),
    .io_state_out_9(CipherRoundNMC_io_state_out_9),
    .io_state_out_10(CipherRoundNMC_io_state_out_10),
    .io_state_out_11(CipherRoundNMC_io_state_out_11),
    .io_state_out_12(CipherRoundNMC_io_state_out_12),
    .io_state_out_13(CipherRoundNMC_io_state_out_13),
    .io_state_out_14(CipherRoundNMC_io_state_out_14),
    .io_state_out_15(CipherRoundNMC_io_state_out_15),
    .io_output_valid(CipherRoundNMC_io_output_valid)
  );
  assign io_output_text_0 = CipherRoundNMC_io_state_out_0; // @[AESEncrypt.scala 54:18]
  assign io_output_text_1 = CipherRoundNMC_io_state_out_1; // @[AESEncrypt.scala 54:18]
  assign io_output_text_2 = CipherRoundNMC_io_state_out_2; // @[AESEncrypt.scala 54:18]
  assign io_output_text_3 = CipherRoundNMC_io_state_out_3; // @[AESEncrypt.scala 54:18]
  assign io_output_text_4 = CipherRoundNMC_io_state_out_4; // @[AESEncrypt.scala 54:18]
  assign io_output_text_5 = CipherRoundNMC_io_state_out_5; // @[AESEncrypt.scala 54:18]
  assign io_output_text_6 = CipherRoundNMC_io_state_out_6; // @[AESEncrypt.scala 54:18]
  assign io_output_text_7 = CipherRoundNMC_io_state_out_7; // @[AESEncrypt.scala 54:18]
  assign io_output_text_8 = CipherRoundNMC_io_state_out_8; // @[AESEncrypt.scala 54:18]
  assign io_output_text_9 = CipherRoundNMC_io_state_out_9; // @[AESEncrypt.scala 54:18]
  assign io_output_text_10 = CipherRoundNMC_io_state_out_10; // @[AESEncrypt.scala 54:18]
  assign io_output_text_11 = CipherRoundNMC_io_state_out_11; // @[AESEncrypt.scala 54:18]
  assign io_output_text_12 = CipherRoundNMC_io_state_out_12; // @[AESEncrypt.scala 54:18]
  assign io_output_text_13 = CipherRoundNMC_io_state_out_13; // @[AESEncrypt.scala 54:18]
  assign io_output_text_14 = CipherRoundNMC_io_state_out_14; // @[AESEncrypt.scala 54:18]
  assign io_output_text_15 = CipherRoundNMC_io_state_out_15; // @[AESEncrypt.scala 54:18]
  assign io_output_valid = CipherRoundNMC_io_output_valid; // @[AESEncrypt.scala 53:19]
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
  output  io_out_cntr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  aes_cipher_io_output_text_0; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_1; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_2; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_3; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_4; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_5; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_6; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_7; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_8; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_9; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_10; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_11; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_12; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_13; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_14; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_text_15; // @[SE.scala 78:32]
  wire  aes_cipher_io_output_valid; // @[SE.scala 78:32]
  reg  value; // @[Counter.scala 60:40]
  wire  _GEN_0 = 1'h1 & (value & 1'h1); // @[Counter.scala 76:15 86:{20,28}]
  wire  _GEN_1 = _GEN_0 & value; // @[SE.scala 60:24 Counter.scala 60:40]
  wire  _T_1 = io_out_valid & io_out_ready; // @[SE.scala 65:33]
  wire  _GEN_4 = 1'h1 & _GEN_1; // @[SE.scala 68:43 Counter.scala 97:11]
  reg  ready_for_input; // @[SE.scala 109:38]
  wire  _GEN_185 = _T_1 & ready_for_input; // @[SE.scala 115:49 116:33 109:38]
  wire  _GEN_186 = 1'h1 & _GEN_185; // @[SE.scala 113:41 114:33]
  wire  lo_lo_lo_4 = aes_cipher_io_output_text_1 & aes_cipher_io_output_text_0; // @[SE.scala 205:65]
  wire  lo_lo_hi_4 = aes_cipher_io_output_text_3 & aes_cipher_io_output_text_2; // @[SE.scala 205:65]
  wire  lo_lo_4 = lo_lo_hi_4 & lo_lo_lo_4; // @[SE.scala 205:65]
  wire  lo_hi_lo_4 = aes_cipher_io_output_text_5 & aes_cipher_io_output_text_4; // @[SE.scala 205:65]
  wire  lo_hi_hi_4 = aes_cipher_io_output_text_7 & aes_cipher_io_output_text_6; // @[SE.scala 205:65]
  wire  lo_hi_4 = lo_hi_hi_4 & lo_hi_lo_4; // @[SE.scala 205:65]
  wire  lo_4 = lo_hi_4 & lo_lo_4; // @[SE.scala 205:65]
  wire  hi_lo_lo_4 = aes_cipher_io_output_text_9 & aes_cipher_io_output_text_8; // @[SE.scala 205:65]
  wire  hi_lo_hi_4 = aes_cipher_io_output_text_11 & aes_cipher_io_output_text_10; // @[SE.scala 205:65]
  wire  hi_lo_4 = hi_lo_hi_4 & hi_lo_lo_4; // @[SE.scala 205:65]
  wire  hi_hi_lo_4 = aes_cipher_io_output_text_13 & aes_cipher_io_output_text_12; // @[SE.scala 205:65]
  wire  hi_hi_hi_4 = aes_cipher_io_output_text_15 & aes_cipher_io_output_text_14; // @[SE.scala 205:65]
  wire  hi_hi_4 = hi_hi_hi_4 & hi_hi_lo_4; // @[SE.scala 205:65]
  wire  hi_4 = hi_hi_4 & hi_lo_4; // @[SE.scala 205:65]
  wire  _T_82 = hi_4 & lo_4; // @[SE.scala 205:65]
  reg  output_buffer; // @[Reg.scala 15:16]
  reg  output_valid; // @[SE.scala 206:35]
  wire  _GEN_191 = 1'h1 & output_valid; // @[SE.scala 210:49 211:30 206:35]
  wire  _GEN_192 = aes_cipher_io_output_valid & _GEN_191; // @[SE.scala 208:41 209:30]
  AESEncrypt aes_cipher ( // @[SE.scala 78:32]
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
  assign io_in_ready = ready_for_input; // @[SE.scala 110:21]
  assign io_out_result = output_buffer; // @[SE.scala 214:23]
  assign io_out_valid = output_valid; // @[SE.scala 213:22]
  assign io_out_cntr = value; // @[SE.scala 71:21]
  always @(posedge clock) begin
    value <= 1'h1 & _GEN_4; // @[Counter.scala 60:{40,40}]
    ready_for_input <= reset & _GEN_186; // @[SE.scala 109:{38,38}]
    output_buffer <= _T_82 & output_buffer; // @[Reg.scala 15:16 16:{19,23}]
    output_valid <= 1'h1 & _GEN_192; // @[SE.scala 206:{35,35}]
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
