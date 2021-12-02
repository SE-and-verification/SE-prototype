module AESDecrypt(
  input   io_input_valid
);
endmodule
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
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
`endif // RANDOMIZE_REG_INIT
  wire  aes_invcipher_io_input_valid; // @[SE.scala 77:35]
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
  wire  _T = io_in_valid & io_in_ready; // @[SE.scala 63:26]
  wire  _T_1 = io_out_valid & io_out_ready; // @[SE.scala 65:33]
  wire  _GEN_4 = 1'h1 & _GEN_1; // @[SE.scala 68:43 Counter.scala 97:11]
  reg  ciphers_0; // @[SE.scala 81:26]
  reg  ciphers_1; // @[SE.scala 81:26]
  reg  ciphers_2; // @[SE.scala 81:26]
  reg  ciphers_3; // @[SE.scala 81:26]
  reg  ciphers_4; // @[SE.scala 81:26]
  reg  ciphers_5; // @[SE.scala 81:26]
  reg  ciphers_6; // @[SE.scala 81:26]
  reg  ciphers_7; // @[SE.scala 81:26]
  reg  ciphers_8; // @[SE.scala 81:26]
  reg  ciphers_9; // @[SE.scala 81:26]
  reg  ciphers_10; // @[SE.scala 81:26]
  reg  ciphers_11; // @[SE.scala 81:26]
  reg  ciphers_12; // @[SE.scala 81:26]
  reg  ciphers_13; // @[SE.scala 81:26]
  reg  ciphers_14; // @[SE.scala 81:26]
  reg  ciphers_15; // @[SE.scala 81:26]
  reg  ciphers_16; // @[SE.scala 81:26]
  reg  ciphers_17; // @[SE.scala 81:26]
  reg  ciphers_18; // @[SE.scala 81:26]
  reg  ciphers_19; // @[SE.scala 81:26]
  reg  ciphers_20; // @[SE.scala 81:26]
  reg  ciphers_21; // @[SE.scala 81:26]
  reg  ciphers_22; // @[SE.scala 81:26]
  reg  ciphers_23; // @[SE.scala 81:26]
  reg  ciphers_24; // @[SE.scala 81:26]
  reg  ciphers_25; // @[SE.scala 81:26]
  reg  ciphers_26; // @[SE.scala 81:26]
  reg  ciphers_27; // @[SE.scala 81:26]
  reg  ciphers_28; // @[SE.scala 81:26]
  reg  ciphers_29; // @[SE.scala 81:26]
  reg  ciphers_30; // @[SE.scala 81:26]
  reg  ciphers_31; // @[SE.scala 81:26]
  reg  ptr; // @[SE.scala 83:26]
  reg  op1_buffer; // @[Reg.scala 15:16]
  reg  op2_buffer; // @[Reg.scala 15:16]
  reg  cond_buffer; // @[Reg.scala 15:16]
  reg  valid_buffer; // @[SE.scala 106:31]
  reg  ready_for_input; // @[SE.scala 109:38]
  wire  _T_23 = ciphers_15 & op1_buffer; // @[SE.scala 140:41]
  wire  _T_55 = ciphers_0 & op1_buffer & (ciphers_1 & op1_buffer) & (ciphers_2 & op1_buffer) & (ciphers_3 & op1_buffer)
     & (ciphers_4 & op1_buffer) & (ciphers_5 & op1_buffer) & (ciphers_6 & op1_buffer) & (ciphers_7 & op1_buffer) & (
    ciphers_8 & op1_buffer) & (ciphers_9 & op1_buffer) & (ciphers_10 & op1_buffer) & (ciphers_11 & op1_buffer) & (
    ciphers_12 & op1_buffer) & (ciphers_13 & op1_buffer) & (ciphers_14 & op1_buffer) & _T_23; // @[SE.scala 140:41]
  wire  _T_70 = _T_55 & (ciphers_16 & op1_buffer) & (ciphers_17 & op1_buffer) & (ciphers_18 & op1_buffer) & (ciphers_19
     & op1_buffer) & (ciphers_20 & op1_buffer) & (ciphers_21 & op1_buffer) & (ciphers_22 & op1_buffer) & (ciphers_23 &
    op1_buffer) & (ciphers_24 & op1_buffer) & (ciphers_25 & op1_buffer) & (ciphers_26 & op1_buffer) & (ciphers_27 &
    op1_buffer) & (ciphers_28 & op1_buffer) & (ciphers_29 & op1_buffer) & (ciphers_30 & op1_buffer); // @[SE.scala 140:41]
  wire  op1_found = _T_70 & (ciphers_31 & op1_buffer); // @[SE.scala 140:41]
  wire  _T_86 = ciphers_15 & op2_buffer; // @[SE.scala 141:41]
  wire  _T_118 = ciphers_0 & op2_buffer & (ciphers_1 & op2_buffer) & (ciphers_2 & op2_buffer) & (ciphers_3 & op2_buffer)
     & (ciphers_4 & op2_buffer) & (ciphers_5 & op2_buffer) & (ciphers_6 & op2_buffer) & (ciphers_7 & op2_buffer) & (
    ciphers_8 & op2_buffer) & (ciphers_9 & op2_buffer) & (ciphers_10 & op2_buffer) & (ciphers_11 & op2_buffer) & (
    ciphers_12 & op2_buffer) & (ciphers_13 & op2_buffer) & (ciphers_14 & op2_buffer) & _T_86; // @[SE.scala 141:41]
  wire  _T_133 = _T_118 & (ciphers_16 & op2_buffer) & (ciphers_17 & op2_buffer) & (ciphers_18 & op2_buffer) & (
    ciphers_19 & op2_buffer) & (ciphers_20 & op2_buffer) & (ciphers_21 & op2_buffer) & (ciphers_22 & op2_buffer) & (
    ciphers_23 & op2_buffer) & (ciphers_24 & op2_buffer) & (ciphers_25 & op2_buffer) & (ciphers_26 & op2_buffer) & (
    ciphers_27 & op2_buffer) & (ciphers_28 & op2_buffer) & (ciphers_29 & op2_buffer) & (ciphers_30 & op2_buffer); // @[SE.scala 141:41]
  wire  op2_found = _T_133 & (ciphers_31 & op2_buffer); // @[SE.scala 141:41]
  wire  _T_151 = ciphers_15 & cond_buffer; // @[SE.scala 144:47]
  wire  _T_183 = ciphers_0 & cond_buffer & (ciphers_1 & cond_buffer) & (ciphers_2 & cond_buffer) & (ciphers_3 &
    cond_buffer) & (ciphers_4 & cond_buffer) & (ciphers_5 & cond_buffer) & (ciphers_6 & cond_buffer) & (ciphers_7 &
    cond_buffer) & (ciphers_8 & cond_buffer) & (ciphers_9 & cond_buffer) & (ciphers_10 & cond_buffer) & (ciphers_11 &
    cond_buffer) & (ciphers_12 & cond_buffer) & (ciphers_13 & cond_buffer) & (ciphers_14 & cond_buffer) & _T_151; // @[SE.scala 144:47]
  wire  _T_198 = _T_183 & (ciphers_16 & cond_buffer) & (ciphers_17 & cond_buffer) & (ciphers_18 & cond_buffer) & (
    ciphers_19 & cond_buffer) & (ciphers_20 & cond_buffer) & (ciphers_21 & cond_buffer) & (ciphers_22 & cond_buffer) & (
    ciphers_23 & cond_buffer) & (ciphers_24 & cond_buffer) & (ciphers_25 & cond_buffer) & (ciphers_26 & cond_buffer) & (
    ciphers_27 & cond_buffer) & (ciphers_28 & cond_buffer) & (ciphers_29 & cond_buffer) & (ciphers_30 & cond_buffer); // @[SE.scala 144:47]
  wire  cond_found = _T_198 & (ciphers_31 & cond_buffer) & 1'h1; // @[SE.scala 143:48 144:28 146:28]
  wire  all_match = op1_found & op2_found & cond_found; // @[SE.scala 152:48]
  wire  _GEN_9 = _T_1 & ready_for_input; // @[SE.scala 116:49 117:33 109:38]
  wire  _GEN_10 = 1'h1 & _GEN_9; // @[SE.scala 114:41 115:33]
  wire  _T_441 = reset; // @[SE.scala 161:23]
  wire  lo_lo_lo_4 = aes_cipher_io_output_text_1 & aes_cipher_io_output_text_0; // @[SE.scala 239:65]
  wire  lo_lo_hi_4 = aes_cipher_io_output_text_3 & aes_cipher_io_output_text_2; // @[SE.scala 239:65]
  wire  lo_lo_4 = lo_lo_hi_4 & lo_lo_lo_4; // @[SE.scala 239:65]
  wire  lo_hi_lo_4 = aes_cipher_io_output_text_5 & aes_cipher_io_output_text_4; // @[SE.scala 239:65]
  wire  lo_hi_hi_4 = aes_cipher_io_output_text_7 & aes_cipher_io_output_text_6; // @[SE.scala 239:65]
  wire  lo_hi_4 = lo_hi_hi_4 & lo_hi_lo_4; // @[SE.scala 239:65]
  wire  lo_4 = lo_hi_4 & lo_lo_4; // @[SE.scala 239:65]
  wire  hi_lo_lo_4 = aes_cipher_io_output_text_9 & aes_cipher_io_output_text_8; // @[SE.scala 239:65]
  wire  hi_lo_hi_4 = aes_cipher_io_output_text_11 & aes_cipher_io_output_text_10; // @[SE.scala 239:65]
  wire  hi_lo_4 = hi_lo_hi_4 & hi_lo_lo_4; // @[SE.scala 239:65]
  wire  hi_hi_lo_4 = aes_cipher_io_output_text_13 & aes_cipher_io_output_text_12; // @[SE.scala 239:65]
  wire  hi_hi_hi_4 = aes_cipher_io_output_text_15 & aes_cipher_io_output_text_14; // @[SE.scala 239:65]
  wire  hi_hi_4 = hi_hi_hi_4 & hi_hi_lo_4; // @[SE.scala 239:65]
  wire  hi_4 = hi_hi_4 & hi_lo_4; // @[SE.scala 239:65]
  wire  _T_479 = hi_4 & lo_4; // @[SE.scala 239:65]
  reg  output_buffer; // @[Reg.scala 15:16]
  reg  output_valid; // @[SE.scala 240:35]
  wire  _GEN_113 = 1'h1 & output_valid; // @[SE.scala 244:49 245:30 240:35]
  wire  _GEN_114 = aes_cipher_io_output_valid & _GEN_113; // @[SE.scala 242:41 243:30]
  wire  _GEN_115 = 1'h1 & (ptr & 1'h1); // @[SE.scala 252:35 253:29 255:29]
  wire  _GEN_116 = _GEN_115 & ptr; // @[SE.scala 250:27 83:26]
  wire  _GEN_117 = output_buffer & ciphers_0; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_118 = output_buffer & ciphers_1; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_119 = output_buffer & ciphers_2; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_120 = output_buffer & ciphers_3; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_121 = output_buffer & ciphers_4; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_122 = output_buffer & ciphers_5; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_123 = output_buffer & ciphers_6; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_124 = output_buffer & ciphers_7; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_125 = output_buffer & ciphers_8; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_126 = output_buffer & ciphers_9; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_127 = output_buffer & ciphers_10; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_128 = output_buffer & ciphers_11; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_129 = output_buffer & ciphers_12; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_130 = output_buffer & ciphers_13; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_131 = output_buffer & ciphers_14; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_132 = output_buffer & ciphers_15; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_133 = output_buffer & ciphers_16; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_134 = output_buffer & ciphers_17; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_135 = output_buffer & ciphers_18; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_136 = output_buffer & ciphers_19; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_137 = output_buffer & ciphers_20; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_138 = output_buffer & ciphers_21; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_139 = output_buffer & ciphers_22; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_140 = output_buffer & ciphers_23; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_141 = output_buffer & ciphers_24; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_142 = output_buffer & ciphers_25; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_143 = output_buffer & ciphers_26; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_144 = output_buffer & ciphers_27; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_145 = output_buffer & ciphers_28; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_146 = output_buffer & ciphers_29; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_147 = output_buffer & ciphers_30; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_148 = output_buffer & ciphers_31; // @[SE.scala 266:{38,38} 81:26]
  wire  _GEN_181 = _GEN_117 & ciphers_0; // @[SE.scala 265:36 81:26]
  wire  _GEN_182 = _GEN_118 & ciphers_1; // @[SE.scala 265:36 81:26]
  wire  _GEN_183 = _GEN_119 & ciphers_2; // @[SE.scala 265:36 81:26]
  wire  _GEN_184 = _GEN_120 & ciphers_3; // @[SE.scala 265:36 81:26]
  wire  _GEN_185 = _GEN_121 & ciphers_4; // @[SE.scala 265:36 81:26]
  wire  _GEN_186 = _GEN_122 & ciphers_5; // @[SE.scala 265:36 81:26]
  wire  _GEN_187 = _GEN_123 & ciphers_6; // @[SE.scala 265:36 81:26]
  wire  _GEN_188 = _GEN_124 & ciphers_7; // @[SE.scala 265:36 81:26]
  wire  _GEN_189 = _GEN_125 & ciphers_8; // @[SE.scala 265:36 81:26]
  wire  _GEN_190 = _GEN_126 & ciphers_9; // @[SE.scala 265:36 81:26]
  wire  _GEN_191 = _GEN_127 & ciphers_10; // @[SE.scala 265:36 81:26]
  wire  _GEN_192 = _GEN_128 & ciphers_11; // @[SE.scala 265:36 81:26]
  wire  _GEN_193 = _GEN_129 & ciphers_12; // @[SE.scala 265:36 81:26]
  wire  _GEN_194 = _GEN_130 & ciphers_13; // @[SE.scala 265:36 81:26]
  wire  _GEN_195 = _GEN_131 & ciphers_14; // @[SE.scala 265:36 81:26]
  wire  _GEN_196 = _GEN_132 & ciphers_15; // @[SE.scala 265:36 81:26]
  wire  _GEN_197 = _GEN_133 & ciphers_16; // @[SE.scala 265:36 81:26]
  wire  _GEN_198 = _GEN_134 & ciphers_17; // @[SE.scala 265:36 81:26]
  wire  _GEN_199 = _GEN_135 & ciphers_18; // @[SE.scala 265:36 81:26]
  wire  _GEN_200 = _GEN_136 & ciphers_19; // @[SE.scala 265:36 81:26]
  wire  _GEN_201 = _GEN_137 & ciphers_20; // @[SE.scala 265:36 81:26]
  wire  _GEN_202 = _GEN_138 & ciphers_21; // @[SE.scala 265:36 81:26]
  wire  _GEN_203 = _GEN_139 & ciphers_22; // @[SE.scala 265:36 81:26]
  wire  _GEN_204 = _GEN_140 & ciphers_23; // @[SE.scala 265:36 81:26]
  wire  _GEN_205 = _GEN_141 & ciphers_24; // @[SE.scala 265:36 81:26]
  wire  _GEN_206 = _GEN_142 & ciphers_25; // @[SE.scala 265:36 81:26]
  wire  _GEN_207 = _GEN_143 & ciphers_26; // @[SE.scala 265:36 81:26]
  wire  _GEN_208 = _GEN_144 & ciphers_27; // @[SE.scala 265:36 81:26]
  wire  _GEN_209 = _GEN_145 & ciphers_28; // @[SE.scala 265:36 81:26]
  wire  _GEN_210 = _GEN_146 & ciphers_29; // @[SE.scala 265:36 81:26]
  wire  _GEN_211 = _GEN_147 & ciphers_30; // @[SE.scala 265:36 81:26]
  wire  _GEN_212 = _GEN_148 & ciphers_31; // @[SE.scala 265:36 81:26]
  AESDecrypt aes_invcipher ( // @[SE.scala 77:35]
    .io_input_valid(aes_invcipher_io_input_valid)
  );
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
  assign io_in_ready = ready_for_input; // @[SE.scala 111:21]
  assign io_out_result = output_buffer; // @[SE.scala 248:23]
  assign io_out_valid = output_valid; // @[SE.scala 247:22]
  assign io_out_cntr = value; // @[SE.scala 71:21]
  assign aes_invcipher_io_input_valid = valid_buffer & all_match; // @[SE.scala 159:54]
  always @(posedge clock) begin
    value <= 1'h1 & _GEN_4; // @[Counter.scala 60:{40,40}]
    ciphers_0 <= 1'h1 & _GEN_181; // @[SE.scala 258:27 261:36]
    ciphers_1 <= 1'h1 & _GEN_182; // @[SE.scala 258:27 261:36]
    ciphers_2 <= 1'h1 & _GEN_183; // @[SE.scala 258:27 261:36]
    ciphers_3 <= 1'h1 & _GEN_184; // @[SE.scala 258:27 261:36]
    ciphers_4 <= 1'h1 & _GEN_185; // @[SE.scala 258:27 261:36]
    ciphers_5 <= 1'h1 & _GEN_186; // @[SE.scala 258:27 261:36]
    ciphers_6 <= 1'h1 & _GEN_187; // @[SE.scala 258:27 261:36]
    ciphers_7 <= 1'h1 & _GEN_188; // @[SE.scala 258:27 261:36]
    ciphers_8 <= 1'h1 & _GEN_189; // @[SE.scala 258:27 261:36]
    ciphers_9 <= 1'h1 & _GEN_190; // @[SE.scala 258:27 261:36]
    ciphers_10 <= 1'h1 & _GEN_191; // @[SE.scala 258:27 261:36]
    ciphers_11 <= 1'h1 & _GEN_192; // @[SE.scala 258:27 261:36]
    ciphers_12 <= 1'h1 & _GEN_193; // @[SE.scala 258:27 261:36]
    ciphers_13 <= 1'h1 & _GEN_194; // @[SE.scala 258:27 261:36]
    ciphers_14 <= 1'h1 & _GEN_195; // @[SE.scala 258:27 261:36]
    ciphers_15 <= 1'h1 & _GEN_196; // @[SE.scala 258:27 261:36]
    ciphers_16 <= 1'h1 & _GEN_197; // @[SE.scala 258:27 261:36]
    ciphers_17 <= 1'h1 & _GEN_198; // @[SE.scala 258:27 261:36]
    ciphers_18 <= 1'h1 & _GEN_199; // @[SE.scala 258:27 261:36]
    ciphers_19 <= 1'h1 & _GEN_200; // @[SE.scala 258:27 261:36]
    ciphers_20 <= 1'h1 & _GEN_201; // @[SE.scala 258:27 261:36]
    ciphers_21 <= 1'h1 & _GEN_202; // @[SE.scala 258:27 261:36]
    ciphers_22 <= 1'h1 & _GEN_203; // @[SE.scala 258:27 261:36]
    ciphers_23 <= 1'h1 & _GEN_204; // @[SE.scala 258:27 261:36]
    ciphers_24 <= 1'h1 & _GEN_205; // @[SE.scala 258:27 261:36]
    ciphers_25 <= 1'h1 & _GEN_206; // @[SE.scala 258:27 261:36]
    ciphers_26 <= 1'h1 & _GEN_207; // @[SE.scala 258:27 261:36]
    ciphers_27 <= 1'h1 & _GEN_208; // @[SE.scala 258:27 261:36]
    ciphers_28 <= 1'h1 & _GEN_209; // @[SE.scala 258:27 261:36]
    ciphers_29 <= 1'h1 & _GEN_210; // @[SE.scala 258:27 261:36]
    ciphers_30 <= 1'h1 & _GEN_211; // @[SE.scala 258:27 261:36]
    ciphers_31 <= 1'h1 & _GEN_212; // @[SE.scala 258:27 261:36]
    ptr <= 1'h1 & _GEN_116; // @[SE.scala 83:{26,26}]
    op1_buffer <= io_in_op1 & op1_buffer; // @[Reg.scala 15:16 16:{19,23}]
    op2_buffer <= io_in_op2 & op2_buffer; // @[Reg.scala 15:16 16:{19,23}]
    cond_buffer <= io_in_cond & cond_buffer; // @[Reg.scala 15:16 16:{19,23}]
    valid_buffer <= _T & (1'h1 & valid_buffer); // @[SE.scala 113:28]
    ready_for_input <= reset & _GEN_10; // @[SE.scala 109:{38,38}]
    output_buffer <= _T_479 & output_buffer; // @[Reg.scala 15:16 16:{19,23}]
    output_valid <= 1'h1 & _GEN_114; // @[SE.scala 240:{35,35}]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (aes_invcipher_io_input_valid & reset) begin
          $fwrite(32'h80000002,"op1_buffer: %x\n",op1_buffer); // @[SE.scala 161:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (aes_invcipher_io_input_valid & _T_441) begin
          $fwrite(32'h80000002,"op2_buffer: %x\n",op2_buffer); // @[SE.scala 162:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (output_valid & _T_441) begin
          $fwrite(32'h80000002,"ptr:%x\n",ptr); // @[SE.scala 251:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
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
  ciphers_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  ciphers_1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  ciphers_2 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  ciphers_3 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  ciphers_4 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  ciphers_5 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  ciphers_6 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  ciphers_7 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  ciphers_8 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  ciphers_9 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  ciphers_10 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  ciphers_11 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  ciphers_12 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  ciphers_13 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  ciphers_14 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  ciphers_15 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  ciphers_16 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  ciphers_17 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  ciphers_18 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  ciphers_19 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  ciphers_20 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  ciphers_21 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  ciphers_22 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  ciphers_23 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  ciphers_24 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  ciphers_25 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  ciphers_26 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  ciphers_27 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  ciphers_28 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  ciphers_29 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  ciphers_30 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  ciphers_31 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  ptr = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  op1_buffer = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  op2_buffer = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  cond_buffer = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  valid_buffer = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  ready_for_input = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  output_buffer = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  output_valid = _RAND_40[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
