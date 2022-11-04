module SEControl(
  input  [7:0] io_inst_in,
  output [2:0] io_fu_op,
  output [1:0] io_fu_type,
  output       io_signed
);
  wire  _ctrlSignals_T_1 = 8'h0 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_3 = 8'h4 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_5 = 8'h8 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_7 = 8'h20 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_9 = 8'h24 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_11 = 8'h28 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_13 = 8'h29 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_15 = 8'h80 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_17 = 8'h84 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_19 = 8'h88 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_21 = 8'h40 == io_inst_in; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_23 = 8'h41 == io_inst_in; // @[Lookup.scala 31:38]
  wire [7:0] _ctrlSignals_T_24 = io_inst_in & 8'he0; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_25 = 8'h60 == _ctrlSignals_T_24; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_27 = 8'ha0 == _ctrlSignals_T_24; // @[Lookup.scala 31:38]
  wire [2:0] _ctrlSignals_T_28 = _ctrlSignals_T_27 ? 3'h5 : 3'h6; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_29 = _ctrlSignals_T_25 ? 3'h3 : _ctrlSignals_T_28; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_30 = _ctrlSignals_T_23 ? 3'h2 : _ctrlSignals_T_29; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_31 = _ctrlSignals_T_21 ? 3'h2 : _ctrlSignals_T_30; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_32 = _ctrlSignals_T_19 ? 3'h4 : _ctrlSignals_T_31; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_33 = _ctrlSignals_T_17 ? 3'h4 : _ctrlSignals_T_32; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_34 = _ctrlSignals_T_15 ? 3'h4 : _ctrlSignals_T_33; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_35 = _ctrlSignals_T_13 ? 3'h1 : _ctrlSignals_T_34; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_36 = _ctrlSignals_T_11 ? 3'h1 : _ctrlSignals_T_35; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_37 = _ctrlSignals_T_9 ? 3'h1 : _ctrlSignals_T_36; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_38 = _ctrlSignals_T_7 ? 3'h1 : _ctrlSignals_T_37; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_39 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_38; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_40 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_39; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_41 = _ctrlSignals_T_27 ? 2'h0 : 2'h2; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_42 = _ctrlSignals_T_25 ? 2'h0 : _ctrlSignals_T_41; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_43 = _ctrlSignals_T_23 ? 2'h0 : _ctrlSignals_T_42; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_44 = _ctrlSignals_T_21 ? 2'h0 : _ctrlSignals_T_43; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_45 = _ctrlSignals_T_19 ? 2'h2 : _ctrlSignals_T_44; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_46 = _ctrlSignals_T_17 ? 2'h1 : _ctrlSignals_T_45; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_47 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_46; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_48 = _ctrlSignals_T_13 ? 2'h2 : _ctrlSignals_T_47; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_49 = _ctrlSignals_T_11 ? 2'h2 : _ctrlSignals_T_48; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_50 = _ctrlSignals_T_9 ? 2'h1 : _ctrlSignals_T_49; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_51 = _ctrlSignals_T_7 ? 2'h0 : _ctrlSignals_T_50; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_52 = _ctrlSignals_T_5 ? 2'h2 : _ctrlSignals_T_51; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_53 = _ctrlSignals_T_3 ? 2'h1 : _ctrlSignals_T_52; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_70 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_23; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_71 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_70; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_72 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_71; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_73 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_72; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_75 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_13 | _ctrlSignals_T_73; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_76 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_75; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_77 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_76; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_78 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_77; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_79 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_78; // @[Lookup.scala 34:39]
  assign io_fu_op = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_40; // @[Lookup.scala 34:39]
  assign io_fu_type = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_53; // @[Lookup.scala 34:39]
  assign io_signed = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_79; // @[Lookup.scala 34:39]
endmodule
module FU(
  input  [63:0] io_A,
  input  [63:0] io_B,
  input  [63:0] io_cond,
  input  [2:0]  io_fu_op,
  input  [1:0]  io_fu_type,
  input         io_signed,
  output [63:0] io_out
);
  wire  _T_1 = io_fu_type == 2'h0; // @[FU.scala 46:21]
  wire [126:0] _GEN_15 = {{63'd0}, io_A}; // @[FU.scala 48:22]
  wire [126:0] _output_T_1 = _GEN_15 << io_B[5:0]; // @[FU.scala 48:22]
  wire  _T_2 = io_fu_type == 2'h1; // @[FU.scala 49:27]
  wire [63:0] _output_T_3 = io_A >> io_B[5:0]; // @[FU.scala 51:22]
  wire [63:0] _output_T_7 = $signed(io_A) >>> io_B[5:0]; // @[FU.scala 54:43]
  wire [63:0] _output_T_9 = {io_A[63],_output_T_7[62:0]}; // @[Cat.scala 31:58]
  wire [63:0] _GEN_0 = io_fu_type == 2'h1 ? _output_T_3 : _output_T_9; // @[FU.scala 49:41 51:14 54:14]
  wire [126:0] _GEN_1 = io_fu_type == 2'h0 ? _output_T_1 : {{63'd0}, _GEN_0}; // @[FU.scala 46:35 48:14]
  wire [127:0] _output_T_13 = $signed(io_A) * $signed(io_B); // @[FU.scala 59:47]
  wire [63:0] _output_T_15 = io_A + io_B; // @[FU.scala 63:24]
  wire [63:0] _output_T_17 = io_A - io_B; // @[FU.scala 66:24]
  wire [127:0] _output_T_18 = io_A * io_B; // @[FU.scala 69:24]
  wire [127:0] _GEN_2 = _T_2 ? {{64'd0}, _output_T_17} : _output_T_18; // @[FU.scala 64:43 66:16 69:16]
  wire [127:0] _GEN_3 = _T_1 ? {{64'd0}, _output_T_15} : _GEN_2; // @[FU.scala 61:37 63:16]
  wire [127:0] _GEN_4 = io_signed ? _output_T_13 : _GEN_3; // @[FU.scala 57:20 59:16]
  wire [63:0] _output_T_19 = io_A ^ io_B; // @[FU.scala 75:24]
  wire [63:0] _output_T_20 = io_A | io_B; // @[FU.scala 78:24]
  wire [63:0] _output_T_21 = io_A & io_B; // @[FU.scala 81:24]
  wire [63:0] _GEN_5 = _T_2 ? _output_T_20 : _output_T_21; // @[FU.scala 76:44 78:16 81:16]
  wire [63:0] _GEN_6 = _T_1 ? _output_T_19 : _GEN_5; // @[FU.scala 73:39 75:16]
  wire  _GEN_7 = io_signed ? $signed(io_A) < $signed(io_B) : io_A < io_B; // @[FU.scala 84:20 86:14 89:14]
  wire [2:0] _GEN_14 = {{1'd0}, io_fu_type}; // @[FU.scala 91:25]
  wire [63:0] _GEN_8 = io_cond != 64'h0 ? io_A : io_B; // @[FU.scala 92:26 94:14 97:14]
  wire [63:0] _GEN_9 = _GEN_14 == 3'h3 ? _GEN_8 : io_A; // @[FU.scala 101:14 91:37]
  wire [63:0] _GEN_10 = io_fu_op == 3'h2 ? {{63'd0}, _GEN_7} : _GEN_9; // @[FU.scala 83:35]
  wire [63:0] _GEN_11 = io_fu_op == 3'h4 ? _GEN_6 : _GEN_10; // @[FU.scala 72:38]
  wire [127:0] _GEN_12 = io_fu_op == 3'h1 ? _GEN_4 : {{64'd0}, _GEN_11}; // @[FU.scala 56:36]
  wire [127:0] _GEN_13 = io_fu_op == 3'h0 ? {{1'd0}, _GEN_1} : _GEN_12; // @[FU.scala 45:30]
  assign io_out = _GEN_13[63:0]; // @[FU.scala 43:20]
endmodule
module SEOperation(
  input  [7:0]  io_inst,
  input  [63:0] io_op1_input,
  input  [63:0] io_op2_input,
  input  [63:0] io_cond_input,
  output [63:0] io_result
);
  wire [7:0] decode_io_inst_in; // @[SEOperation.scala 31:28]
  wire [2:0] decode_io_fu_op; // @[SEOperation.scala 31:28]
  wire [1:0] decode_io_fu_type; // @[SEOperation.scala 31:28]
  wire  decode_io_signed; // @[SEOperation.scala 31:28]
  wire [63:0] fu_io_A; // @[SEOperation.scala 32:24]
  wire [63:0] fu_io_B; // @[SEOperation.scala 32:24]
  wire [63:0] fu_io_cond; // @[SEOperation.scala 32:24]
  wire [2:0] fu_io_fu_op; // @[SEOperation.scala 32:24]
  wire [1:0] fu_io_fu_type; // @[SEOperation.scala 32:24]
  wire  fu_io_signed; // @[SEOperation.scala 32:24]
  wire [63:0] fu_io_out; // @[SEOperation.scala 32:24]
  SEControl decode ( // @[SEOperation.scala 31:28]
    .io_inst_in(decode_io_inst_in),
    .io_fu_op(decode_io_fu_op),
    .io_fu_type(decode_io_fu_type),
    .io_signed(decode_io_signed)
  );
  FU fu ( // @[SEOperation.scala 32:24]
    .io_A(fu_io_A),
    .io_B(fu_io_B),
    .io_cond(fu_io_cond),
    .io_fu_op(fu_io_fu_op),
    .io_fu_type(fu_io_fu_type),
    .io_signed(fu_io_signed),
    .io_out(fu_io_out)
  );
  assign io_result = fu_io_out; // @[SEOperation.scala 47:19]
  assign decode_io_inst_in = io_inst; // @[SEOperation.scala 38:27]
  assign fu_io_A = io_op1_input; // @[SEOperation.scala 41:11]
  assign fu_io_B = io_op2_input; // @[SEOperation.scala 42:11]
  assign fu_io_cond = io_cond_input; // @[SEOperation.scala 43:20]
  assign fu_io_fu_op = decode_io_fu_op; // @[SEOperation.scala 44:15]
  assign fu_io_fu_type = decode_io_fu_type; // @[SEOperation.scala 45:23]
  assign fu_io_signed = decode_io_signed; // @[SEOperation.scala 46:22]
endmodule
module RSADecrypt(
  input         clock,
  input         reset,
  input         io_input_valid,
  input  [63:0] io_p,
  input  [63:0] io_q,
  input  [7:0]  io_input_op1_0,
  input  [7:0]  io_input_op1_1,
  input  [7:0]  io_input_op1_2,
  input  [7:0]  io_input_op1_3,
  input  [7:0]  io_input_op1_4,
  input  [7:0]  io_input_op1_5,
  input  [7:0]  io_input_op1_6,
  input  [7:0]  io_input_op1_7,
  input  [7:0]  io_input_op1_8,
  input  [7:0]  io_input_op1_9,
  input  [7:0]  io_input_op1_10,
  input  [7:0]  io_input_op1_11,
  input  [7:0]  io_input_op1_12,
  input  [7:0]  io_input_op1_13,
  input  [7:0]  io_input_op1_14,
  input  [7:0]  io_input_op1_15,
  input  [7:0]  io_input_op2_0,
  input  [7:0]  io_input_op2_1,
  input  [7:0]  io_input_op2_2,
  input  [7:0]  io_input_op2_3,
  input  [7:0]  io_input_op2_4,
  input  [7:0]  io_input_op2_5,
  input  [7:0]  io_input_op2_6,
  input  [7:0]  io_input_op2_7,
  input  [7:0]  io_input_op2_8,
  input  [7:0]  io_input_op2_9,
  input  [7:0]  io_input_op2_10,
  input  [7:0]  io_input_op2_11,
  input  [7:0]  io_input_op2_12,
  input  [7:0]  io_input_op2_13,
  input  [7:0]  io_input_op2_14,
  input  [7:0]  io_input_op2_15,
  input  [7:0]  io_input_cond_0,
  input  [7:0]  io_input_cond_1,
  input  [7:0]  io_input_cond_2,
  input  [7:0]  io_input_cond_3,
  input  [7:0]  io_input_cond_4,
  input  [7:0]  io_input_cond_5,
  input  [7:0]  io_input_cond_6,
  input  [7:0]  io_input_cond_7,
  input  [7:0]  io_input_cond_8,
  input  [7:0]  io_input_cond_9,
  input  [7:0]  io_input_cond_10,
  input  [7:0]  io_input_cond_11,
  input  [7:0]  io_input_cond_12,
  input  [7:0]  io_input_cond_13,
  input  [7:0]  io_input_cond_14,
  input  [7:0]  io_input_cond_15,
  output [7:0]  io_output_op1_0,
  output [7:0]  io_output_op1_1,
  output [7:0]  io_output_op1_2,
  output [7:0]  io_output_op1_3,
  output [7:0]  io_output_op1_4,
  output [7:0]  io_output_op1_5,
  output [7:0]  io_output_op1_6,
  output [7:0]  io_output_op1_7,
  output [7:0]  io_output_op1_8,
  output [7:0]  io_output_op1_9,
  output [7:0]  io_output_op1_10,
  output [7:0]  io_output_op1_11,
  output [7:0]  io_output_op1_12,
  output [7:0]  io_output_op1_13,
  output [7:0]  io_output_op1_14,
  output [7:0]  io_output_op1_15,
  output [7:0]  io_output_op2_0,
  output [7:0]  io_output_op2_1,
  output [7:0]  io_output_op2_2,
  output [7:0]  io_output_op2_3,
  output [7:0]  io_output_op2_4,
  output [7:0]  io_output_op2_5,
  output [7:0]  io_output_op2_6,
  output [7:0]  io_output_op2_7,
  output [7:0]  io_output_op2_8,
  output [7:0]  io_output_op2_9,
  output [7:0]  io_output_op2_10,
  output [7:0]  io_output_op2_11,
  output [7:0]  io_output_op2_12,
  output [7:0]  io_output_op2_13,
  output [7:0]  io_output_op2_14,
  output [7:0]  io_output_op2_15,
  output [7:0]  io_output_cond_0,
  output [7:0]  io_output_cond_1,
  output [7:0]  io_output_cond_2,
  output [7:0]  io_output_cond_3,
  output [7:0]  io_output_cond_4,
  output [7:0]  io_output_cond_5,
  output [7:0]  io_output_cond_6,
  output [7:0]  io_output_cond_7,
  output [7:0]  io_output_cond_8,
  output [7:0]  io_output_cond_9,
  output [7:0]  io_output_cond_10,
  output [7:0]  io_output_cond_11,
  output [7:0]  io_output_cond_12,
  output [7:0]  io_output_cond_13,
  output [7:0]  io_output_cond_14,
  output [7:0]  io_output_cond_15,
  output        io_output_valid
);
  wire [63:0] rsa_dec1_p; // @[RSADecrypt.scala 25:26]
  wire [63:0] rsa_dec1_q; // @[RSADecrypt.scala 25:26]
  wire  rsa_dec1_clk; // @[RSADecrypt.scala 25:26]
  wire  rsa_dec1_reset; // @[RSADecrypt.scala 25:26]
  wire  rsa_dec1_reset1; // @[RSADecrypt.scala 25:26]
  wire  rsa_dec1_encrypt_decrypt; // @[RSADecrypt.scala 25:26]
  wire [127:0] rsa_dec1_msg_in; // @[RSADecrypt.scala 25:26]
  wire [127:0] rsa_dec1_msg_out; // @[RSADecrypt.scala 25:26]
  wire  rsa_dec1_mod_exp_finish; // @[RSADecrypt.scala 25:26]
  wire [63:0] rsa_dec2_p; // @[RSADecrypt.scala 26:26]
  wire [63:0] rsa_dec2_q; // @[RSADecrypt.scala 26:26]
  wire  rsa_dec2_clk; // @[RSADecrypt.scala 26:26]
  wire  rsa_dec2_reset; // @[RSADecrypt.scala 26:26]
  wire  rsa_dec2_reset1; // @[RSADecrypt.scala 26:26]
  wire  rsa_dec2_encrypt_decrypt; // @[RSADecrypt.scala 26:26]
  wire [127:0] rsa_dec2_msg_in; // @[RSADecrypt.scala 26:26]
  wire [127:0] rsa_dec2_msg_out; // @[RSADecrypt.scala 26:26]
  wire  rsa_dec2_mod_exp_finish; // @[RSADecrypt.scala 26:26]
  wire [63:0] rsa_dec3_p; // @[RSADecrypt.scala 27:26]
  wire [63:0] rsa_dec3_q; // @[RSADecrypt.scala 27:26]
  wire  rsa_dec3_clk; // @[RSADecrypt.scala 27:26]
  wire  rsa_dec3_reset; // @[RSADecrypt.scala 27:26]
  wire  rsa_dec3_reset1; // @[RSADecrypt.scala 27:26]
  wire  rsa_dec3_encrypt_decrypt; // @[RSADecrypt.scala 27:26]
  wire [127:0] rsa_dec3_msg_in; // @[RSADecrypt.scala 27:26]
  wire [127:0] rsa_dec3_msg_out; // @[RSADecrypt.scala 27:26]
  wire  rsa_dec3_mod_exp_finish; // @[RSADecrypt.scala 27:26]
  wire [63:0] rsa_dec1_io_msg_in_lo = {io_input_op1_7,io_input_op1_6,io_input_op1_5,io_input_op1_4,io_input_op1_3,
    io_input_op1_2,io_input_op1_1,io_input_op1_0}; // @[RSADecrypt.scala 35:48]
  wire [63:0] rsa_dec1_io_msg_in_hi = {io_input_op1_15,io_input_op1_14,io_input_op1_13,io_input_op1_12,io_input_op1_11,
    io_input_op1_10,io_input_op1_9,io_input_op1_8}; // @[RSADecrypt.scala 35:48]
  wire [127:0] _WIRE_1 = rsa_dec1_msg_out;
  wire [63:0] rsa_dec2_io_msg_in_lo = {io_input_op2_7,io_input_op2_6,io_input_op2_5,io_input_op2_4,io_input_op2_3,
    io_input_op2_2,io_input_op2_1,io_input_op2_0}; // @[RSADecrypt.scala 45:48]
  wire [63:0] rsa_dec2_io_msg_in_hi = {io_input_op2_15,io_input_op2_14,io_input_op2_13,io_input_op2_12,io_input_op2_11,
    io_input_op2_10,io_input_op2_9,io_input_op2_8}; // @[RSADecrypt.scala 45:48]
  wire [127:0] _WIRE_3 = rsa_dec2_msg_out;
  wire [63:0] rsa_dec3_io_msg_in_lo = {io_input_cond_7,io_input_cond_6,io_input_cond_5,io_input_cond_4,io_input_cond_3,
    io_input_cond_2,io_input_cond_1,io_input_cond_0}; // @[RSADecrypt.scala 54:49]
  wire [63:0] rsa_dec3_io_msg_in_hi = {io_input_cond_15,io_input_cond_14,io_input_cond_13,io_input_cond_12,
    io_input_cond_11,io_input_cond_10,io_input_cond_9,io_input_cond_8}; // @[RSADecrypt.scala 54:49]
  wire [127:0] _WIRE_5 = rsa_dec3_msg_out;
  control rsa_dec1 ( // @[RSADecrypt.scala 25:26]
    .p(rsa_dec1_p),
    .q(rsa_dec1_q),
    .clk(rsa_dec1_clk),
    .reset(rsa_dec1_reset),
    .reset1(rsa_dec1_reset1),
    .encrypt_decrypt(rsa_dec1_encrypt_decrypt),
    .msg_in(rsa_dec1_msg_in),
    .msg_out(rsa_dec1_msg_out),
    .mod_exp_finish(rsa_dec1_mod_exp_finish)
  );
  control rsa_dec2 ( // @[RSADecrypt.scala 26:26]
    .p(rsa_dec2_p),
    .q(rsa_dec2_q),
    .clk(rsa_dec2_clk),
    .reset(rsa_dec2_reset),
    .reset1(rsa_dec2_reset1),
    .encrypt_decrypt(rsa_dec2_encrypt_decrypt),
    .msg_in(rsa_dec2_msg_in),
    .msg_out(rsa_dec2_msg_out),
    .mod_exp_finish(rsa_dec2_mod_exp_finish)
  );
  control rsa_dec3 ( // @[RSADecrypt.scala 27:26]
    .p(rsa_dec3_p),
    .q(rsa_dec3_q),
    .clk(rsa_dec3_clk),
    .reset(rsa_dec3_reset),
    .reset1(rsa_dec3_reset1),
    .encrypt_decrypt(rsa_dec3_encrypt_decrypt),
    .msg_in(rsa_dec3_msg_in),
    .msg_out(rsa_dec3_msg_out),
    .mod_exp_finish(rsa_dec3_mod_exp_finish)
  );
  assign io_output_op1_0 = _WIRE_1[7:0]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_1 = _WIRE_1[15:8]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_2 = _WIRE_1[23:16]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_3 = _WIRE_1[31:24]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_4 = _WIRE_1[39:32]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_5 = _WIRE_1[47:40]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_6 = _WIRE_1[55:48]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_7 = _WIRE_1[63:56]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_8 = _WIRE_1[71:64]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_9 = _WIRE_1[79:72]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_10 = _WIRE_1[87:80]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_11 = _WIRE_1[95:88]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_12 = _WIRE_1[103:96]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_13 = _WIRE_1[111:104]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_14 = _WIRE_1[119:112]; // @[RSADecrypt.scala 36:50]
  assign io_output_op1_15 = _WIRE_1[127:120]; // @[RSADecrypt.scala 36:50]
  assign io_output_op2_0 = _WIRE_3[7:0]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_1 = _WIRE_3[15:8]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_2 = _WIRE_3[23:16]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_3 = _WIRE_3[31:24]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_4 = _WIRE_3[39:32]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_5 = _WIRE_3[47:40]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_6 = _WIRE_3[55:48]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_7 = _WIRE_3[63:56]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_8 = _WIRE_3[71:64]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_9 = _WIRE_3[79:72]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_10 = _WIRE_3[87:80]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_11 = _WIRE_3[95:88]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_12 = _WIRE_3[103:96]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_13 = _WIRE_3[111:104]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_14 = _WIRE_3[119:112]; // @[RSADecrypt.scala 46:50]
  assign io_output_op2_15 = _WIRE_3[127:120]; // @[RSADecrypt.scala 46:50]
  assign io_output_cond_0 = _WIRE_5[7:0]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_1 = _WIRE_5[15:8]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_2 = _WIRE_5[23:16]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_3 = _WIRE_5[31:24]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_4 = _WIRE_5[39:32]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_5 = _WIRE_5[47:40]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_6 = _WIRE_5[55:48]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_7 = _WIRE_5[63:56]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_8 = _WIRE_5[71:64]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_9 = _WIRE_5[79:72]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_10 = _WIRE_5[87:80]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_11 = _WIRE_5[95:88]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_12 = _WIRE_5[103:96]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_13 = _WIRE_5[111:104]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_14 = _WIRE_5[119:112]; // @[RSADecrypt.scala 55:51]
  assign io_output_cond_15 = _WIRE_5[127:120]; // @[RSADecrypt.scala 55:51]
  assign io_output_valid = rsa_dec1_mod_exp_finish; // @[RSADecrypt.scala 37:21]
  assign rsa_dec1_p = io_p; // @[RSADecrypt.scala 29:19]
  assign rsa_dec1_q = io_q; // @[RSADecrypt.scala 30:19]
  assign rsa_dec1_clk = clock; // @[RSADecrypt.scala 31:37]
  assign rsa_dec1_reset = reset | io_input_valid; // @[RSADecrypt.scala 32:46]
  assign rsa_dec1_reset1 = reset | io_input_valid; // @[RSADecrypt.scala 33:47]
  assign rsa_dec1_encrypt_decrypt = 1'h0; // @[RSADecrypt.scala 34:33]
  assign rsa_dec1_msg_in = {rsa_dec1_io_msg_in_hi,rsa_dec1_io_msg_in_lo}; // @[RSADecrypt.scala 35:48]
  assign rsa_dec1_msg_out = 128'h0;
  assign rsa_dec2_p = io_p; // @[RSADecrypt.scala 39:19]
  assign rsa_dec2_q = io_q; // @[RSADecrypt.scala 40:19]
  assign rsa_dec2_clk = clock; // @[RSADecrypt.scala 41:37]
  assign rsa_dec2_reset = reset | io_input_valid; // @[RSADecrypt.scala 42:46]
  assign rsa_dec2_reset1 = reset | io_input_valid; // @[RSADecrypt.scala 43:47]
  assign rsa_dec2_encrypt_decrypt = 1'h0; // @[RSADecrypt.scala 44:33]
  assign rsa_dec2_msg_in = {rsa_dec2_io_msg_in_hi,rsa_dec2_io_msg_in_lo}; // @[RSADecrypt.scala 45:48]
  assign rsa_dec2_msg_out = 128'h0;
  assign rsa_dec3_p = io_p; // @[RSADecrypt.scala 48:19]
  assign rsa_dec3_q = io_q; // @[RSADecrypt.scala 49:19]
  assign rsa_dec3_clk = clock; // @[RSADecrypt.scala 50:37]
  assign rsa_dec3_reset = reset | io_input_valid; // @[RSADecrypt.scala 51:46]
  assign rsa_dec3_reset1 = reset | io_input_valid; // @[RSADecrypt.scala 52:47]
  assign rsa_dec3_encrypt_decrypt = 1'h0; // @[RSADecrypt.scala 53:33]
  assign rsa_dec3_msg_in = {rsa_dec3_io_msg_in_hi,rsa_dec3_io_msg_in_lo}; // @[RSADecrypt.scala 54:49]
  assign rsa_dec3_msg_out = 128'h0;
endmodule
module RSAEncrypt(
  input         clock,
  input         reset,
  input         io_input_valid,
  input  [63:0] io_p,
  input  [63:0] io_q,
  input  [7:0]  io_input_text_0,
  input  [7:0]  io_input_text_1,
  input  [7:0]  io_input_text_2,
  input  [7:0]  io_input_text_3,
  input  [7:0]  io_input_text_4,
  input  [7:0]  io_input_text_5,
  input  [7:0]  io_input_text_6,
  input  [7:0]  io_input_text_7,
  input  [7:0]  io_input_text_8,
  input  [7:0]  io_input_text_9,
  input  [7:0]  io_input_text_10,
  input  [7:0]  io_input_text_11,
  input  [7:0]  io_input_text_12,
  input  [7:0]  io_input_text_13,
  input  [7:0]  io_input_text_14,
  input  [7:0]  io_input_text_15,
  output [7:0]  io_output_text_0,
  output [7:0]  io_output_text_1,
  output [7:0]  io_output_text_2,
  output [7:0]  io_output_text_3,
  output [7:0]  io_output_text_4,
  output [7:0]  io_output_text_5,
  output [7:0]  io_output_text_6,
  output [7:0]  io_output_text_7,
  output [7:0]  io_output_text_8,
  output [7:0]  io_output_text_9,
  output [7:0]  io_output_text_10,
  output [7:0]  io_output_text_11,
  output [7:0]  io_output_text_12,
  output [7:0]  io_output_text_13,
  output [7:0]  io_output_text_14,
  output [7:0]  io_output_text_15,
  output        io_output_valid
);
  wire [63:0] rsa_enc_p; // @[RSAEncrypt.scala 20:25]
  wire [63:0] rsa_enc_q; // @[RSAEncrypt.scala 20:25]
  wire  rsa_enc_clk; // @[RSAEncrypt.scala 20:25]
  wire  rsa_enc_reset; // @[RSAEncrypt.scala 20:25]
  wire  rsa_enc_reset1; // @[RSAEncrypt.scala 20:25]
  wire  rsa_enc_encrypt_decrypt; // @[RSAEncrypt.scala 20:25]
  wire [127:0] rsa_enc_msg_in; // @[RSAEncrypt.scala 20:25]
  wire [127:0] rsa_enc_msg_out; // @[RSAEncrypt.scala 20:25]
  wire  rsa_enc_mod_exp_finish; // @[RSAEncrypt.scala 20:25]
  wire [63:0] rsa_enc_io_msg_in_lo = {io_input_text_7,io_input_text_6,io_input_text_5,io_input_text_4,io_input_text_3,
    io_input_text_2,io_input_text_1,io_input_text_0}; // @[RSAEncrypt.scala 28:48]
  wire [63:0] rsa_enc_io_msg_in_hi = {io_input_text_15,io_input_text_14,io_input_text_13,io_input_text_12,
    io_input_text_11,io_input_text_10,io_input_text_9,io_input_text_8}; // @[RSAEncrypt.scala 28:48]
  wire [127:0] _WIRE_1 = rsa_enc_msg_out;
  control rsa_enc ( // @[RSAEncrypt.scala 20:25]
    .p(rsa_enc_p),
    .q(rsa_enc_q),
    .clk(rsa_enc_clk),
    .reset(rsa_enc_reset),
    .reset1(rsa_enc_reset1),
    .encrypt_decrypt(rsa_enc_encrypt_decrypt),
    .msg_in(rsa_enc_msg_in),
    .msg_out(rsa_enc_msg_out),
    .mod_exp_finish(rsa_enc_mod_exp_finish)
  );
  assign io_output_text_0 = _WIRE_1[7:0]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_1 = _WIRE_1[15:8]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_2 = _WIRE_1[23:16]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_3 = _WIRE_1[31:24]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_4 = _WIRE_1[39:32]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_5 = _WIRE_1[47:40]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_6 = _WIRE_1[55:48]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_7 = _WIRE_1[63:56]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_8 = _WIRE_1[71:64]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_9 = _WIRE_1[79:72]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_10 = _WIRE_1[87:80]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_11 = _WIRE_1[95:88]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_12 = _WIRE_1[103:96]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_13 = _WIRE_1[111:104]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_14 = _WIRE_1[119:112]; // @[RSAEncrypt.scala 29:50]
  assign io_output_text_15 = _WIRE_1[127:120]; // @[RSAEncrypt.scala 29:50]
  assign io_output_valid = rsa_enc_mod_exp_finish; // @[RSAEncrypt.scala 30:21]
  assign rsa_enc_p = io_p; // @[RSAEncrypt.scala 22:18]
  assign rsa_enc_q = io_q; // @[RSAEncrypt.scala 23:18]
  assign rsa_enc_clk = clock; // @[RSAEncrypt.scala 24:36]
  assign rsa_enc_reset = reset | io_input_valid; // @[RSAEncrypt.scala 25:45]
  assign rsa_enc_reset1 = reset | io_input_valid; // @[RSAEncrypt.scala 26:46]
  assign rsa_enc_encrypt_decrypt = 1'h1; // @[RSAEncrypt.scala 27:32]
  assign rsa_enc_msg_in = {rsa_enc_io_msg_in_hi,rsa_enc_io_msg_in_lo}; // @[RSAEncrypt.scala 28:48]
  assign rsa_enc_msg_out = 128'h0;
endmodule
module MaxPeriodFibonacciLFSR(
  input   clock,
  input   reset,
  output  io_out_0,
  output  io_out_1,
  output  io_out_2,
  output  io_out_3,
  output  io_out_4,
  output  io_out_5,
  output  io_out_6,
  output  io_out_7,
  output  io_out_8,
  output  io_out_9,
  output  io_out_10,
  output  io_out_11,
  output  io_out_12,
  output  io_out_13,
  output  io_out_14,
  output  io_out_15,
  output  io_out_16,
  output  io_out_17,
  output  io_out_18,
  output  io_out_19,
  output  io_out_20,
  output  io_out_21,
  output  io_out_22,
  output  io_out_23,
  output  io_out_24,
  output  io_out_25,
  output  io_out_26,
  output  io_out_27,
  output  io_out_28,
  output  io_out_29,
  output  io_out_30,
  output  io_out_31,
  output  io_out_32,
  output  io_out_33,
  output  io_out_34,
  output  io_out_35,
  output  io_out_36,
  output  io_out_37,
  output  io_out_38,
  output  io_out_39,
  output  io_out_40,
  output  io_out_41,
  output  io_out_42,
  output  io_out_43,
  output  io_out_44,
  output  io_out_45,
  output  io_out_46,
  output  io_out_47,
  output  io_out_48,
  output  io_out_49,
  output  io_out_50,
  output  io_out_51,
  output  io_out_52,
  output  io_out_53,
  output  io_out_54,
  output  io_out_55,
  output  io_out_56,
  output  io_out_57,
  output  io_out_58,
  output  io_out_59,
  output  io_out_60,
  output  io_out_61,
  output  io_out_62,
  output  io_out_63
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
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
`endif // RANDOMIZE_REG_INIT
  reg  state_0; // @[PRNG.scala 55:49]
  reg  state_1; // @[PRNG.scala 55:49]
  reg  state_2; // @[PRNG.scala 55:49]
  reg  state_3; // @[PRNG.scala 55:49]
  reg  state_4; // @[PRNG.scala 55:49]
  reg  state_5; // @[PRNG.scala 55:49]
  reg  state_6; // @[PRNG.scala 55:49]
  reg  state_7; // @[PRNG.scala 55:49]
  reg  state_8; // @[PRNG.scala 55:49]
  reg  state_9; // @[PRNG.scala 55:49]
  reg  state_10; // @[PRNG.scala 55:49]
  reg  state_11; // @[PRNG.scala 55:49]
  reg  state_12; // @[PRNG.scala 55:49]
  reg  state_13; // @[PRNG.scala 55:49]
  reg  state_14; // @[PRNG.scala 55:49]
  reg  state_15; // @[PRNG.scala 55:49]
  reg  state_16; // @[PRNG.scala 55:49]
  reg  state_17; // @[PRNG.scala 55:49]
  reg  state_18; // @[PRNG.scala 55:49]
  reg  state_19; // @[PRNG.scala 55:49]
  reg  state_20; // @[PRNG.scala 55:49]
  reg  state_21; // @[PRNG.scala 55:49]
  reg  state_22; // @[PRNG.scala 55:49]
  reg  state_23; // @[PRNG.scala 55:49]
  reg  state_24; // @[PRNG.scala 55:49]
  reg  state_25; // @[PRNG.scala 55:49]
  reg  state_26; // @[PRNG.scala 55:49]
  reg  state_27; // @[PRNG.scala 55:49]
  reg  state_28; // @[PRNG.scala 55:49]
  reg  state_29; // @[PRNG.scala 55:49]
  reg  state_30; // @[PRNG.scala 55:49]
  reg  state_31; // @[PRNG.scala 55:49]
  reg  state_32; // @[PRNG.scala 55:49]
  reg  state_33; // @[PRNG.scala 55:49]
  reg  state_34; // @[PRNG.scala 55:49]
  reg  state_35; // @[PRNG.scala 55:49]
  reg  state_36; // @[PRNG.scala 55:49]
  reg  state_37; // @[PRNG.scala 55:49]
  reg  state_38; // @[PRNG.scala 55:49]
  reg  state_39; // @[PRNG.scala 55:49]
  reg  state_40; // @[PRNG.scala 55:49]
  reg  state_41; // @[PRNG.scala 55:49]
  reg  state_42; // @[PRNG.scala 55:49]
  reg  state_43; // @[PRNG.scala 55:49]
  reg  state_44; // @[PRNG.scala 55:49]
  reg  state_45; // @[PRNG.scala 55:49]
  reg  state_46; // @[PRNG.scala 55:49]
  reg  state_47; // @[PRNG.scala 55:49]
  reg  state_48; // @[PRNG.scala 55:49]
  reg  state_49; // @[PRNG.scala 55:49]
  reg  state_50; // @[PRNG.scala 55:49]
  reg  state_51; // @[PRNG.scala 55:49]
  reg  state_52; // @[PRNG.scala 55:49]
  reg  state_53; // @[PRNG.scala 55:49]
  reg  state_54; // @[PRNG.scala 55:49]
  reg  state_55; // @[PRNG.scala 55:49]
  reg  state_56; // @[PRNG.scala 55:49]
  reg  state_57; // @[PRNG.scala 55:49]
  reg  state_58; // @[PRNG.scala 55:49]
  reg  state_59; // @[PRNG.scala 55:49]
  reg  state_60; // @[PRNG.scala 55:49]
  reg  state_61; // @[PRNG.scala 55:49]
  reg  state_62; // @[PRNG.scala 55:49]
  reg  state_63; // @[PRNG.scala 55:49]
  wire  _T_2 = state_63 ^ state_62 ^ state_60 ^ state_59; // @[LFSR.scala 15:41]
  assign io_out_0 = state_0; // @[PRNG.scala 78:10]
  assign io_out_1 = state_1; // @[PRNG.scala 78:10]
  assign io_out_2 = state_2; // @[PRNG.scala 78:10]
  assign io_out_3 = state_3; // @[PRNG.scala 78:10]
  assign io_out_4 = state_4; // @[PRNG.scala 78:10]
  assign io_out_5 = state_5; // @[PRNG.scala 78:10]
  assign io_out_6 = state_6; // @[PRNG.scala 78:10]
  assign io_out_7 = state_7; // @[PRNG.scala 78:10]
  assign io_out_8 = state_8; // @[PRNG.scala 78:10]
  assign io_out_9 = state_9; // @[PRNG.scala 78:10]
  assign io_out_10 = state_10; // @[PRNG.scala 78:10]
  assign io_out_11 = state_11; // @[PRNG.scala 78:10]
  assign io_out_12 = state_12; // @[PRNG.scala 78:10]
  assign io_out_13 = state_13; // @[PRNG.scala 78:10]
  assign io_out_14 = state_14; // @[PRNG.scala 78:10]
  assign io_out_15 = state_15; // @[PRNG.scala 78:10]
  assign io_out_16 = state_16; // @[PRNG.scala 78:10]
  assign io_out_17 = state_17; // @[PRNG.scala 78:10]
  assign io_out_18 = state_18; // @[PRNG.scala 78:10]
  assign io_out_19 = state_19; // @[PRNG.scala 78:10]
  assign io_out_20 = state_20; // @[PRNG.scala 78:10]
  assign io_out_21 = state_21; // @[PRNG.scala 78:10]
  assign io_out_22 = state_22; // @[PRNG.scala 78:10]
  assign io_out_23 = state_23; // @[PRNG.scala 78:10]
  assign io_out_24 = state_24; // @[PRNG.scala 78:10]
  assign io_out_25 = state_25; // @[PRNG.scala 78:10]
  assign io_out_26 = state_26; // @[PRNG.scala 78:10]
  assign io_out_27 = state_27; // @[PRNG.scala 78:10]
  assign io_out_28 = state_28; // @[PRNG.scala 78:10]
  assign io_out_29 = state_29; // @[PRNG.scala 78:10]
  assign io_out_30 = state_30; // @[PRNG.scala 78:10]
  assign io_out_31 = state_31; // @[PRNG.scala 78:10]
  assign io_out_32 = state_32; // @[PRNG.scala 78:10]
  assign io_out_33 = state_33; // @[PRNG.scala 78:10]
  assign io_out_34 = state_34; // @[PRNG.scala 78:10]
  assign io_out_35 = state_35; // @[PRNG.scala 78:10]
  assign io_out_36 = state_36; // @[PRNG.scala 78:10]
  assign io_out_37 = state_37; // @[PRNG.scala 78:10]
  assign io_out_38 = state_38; // @[PRNG.scala 78:10]
  assign io_out_39 = state_39; // @[PRNG.scala 78:10]
  assign io_out_40 = state_40; // @[PRNG.scala 78:10]
  assign io_out_41 = state_41; // @[PRNG.scala 78:10]
  assign io_out_42 = state_42; // @[PRNG.scala 78:10]
  assign io_out_43 = state_43; // @[PRNG.scala 78:10]
  assign io_out_44 = state_44; // @[PRNG.scala 78:10]
  assign io_out_45 = state_45; // @[PRNG.scala 78:10]
  assign io_out_46 = state_46; // @[PRNG.scala 78:10]
  assign io_out_47 = state_47; // @[PRNG.scala 78:10]
  assign io_out_48 = state_48; // @[PRNG.scala 78:10]
  assign io_out_49 = state_49; // @[PRNG.scala 78:10]
  assign io_out_50 = state_50; // @[PRNG.scala 78:10]
  assign io_out_51 = state_51; // @[PRNG.scala 78:10]
  assign io_out_52 = state_52; // @[PRNG.scala 78:10]
  assign io_out_53 = state_53; // @[PRNG.scala 78:10]
  assign io_out_54 = state_54; // @[PRNG.scala 78:10]
  assign io_out_55 = state_55; // @[PRNG.scala 78:10]
  assign io_out_56 = state_56; // @[PRNG.scala 78:10]
  assign io_out_57 = state_57; // @[PRNG.scala 78:10]
  assign io_out_58 = state_58; // @[PRNG.scala 78:10]
  assign io_out_59 = state_59; // @[PRNG.scala 78:10]
  assign io_out_60 = state_60; // @[PRNG.scala 78:10]
  assign io_out_61 = state_61; // @[PRNG.scala 78:10]
  assign io_out_62 = state_62; // @[PRNG.scala 78:10]
  assign io_out_63 = state_63; // @[PRNG.scala 78:10]
  always @(posedge clock) begin
    state_0 <= reset | _T_2; // @[PRNG.scala 55:{49,49}]
    state_1 <= reset | state_0; // @[PRNG.scala 55:{49,49}]
    state_2 <= reset | state_1; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_3 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_3 <= state_2;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_4 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_4 <= state_3;
    end
    state_5 <= reset | state_4; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_6 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_6 <= state_5;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_7 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_7 <= state_6;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_8 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_8 <= state_7;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_9 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_9 <= state_8;
    end
    state_10 <= reset | state_9; // @[PRNG.scala 55:{49,49}]
    state_11 <= reset | state_10; // @[PRNG.scala 55:{49,49}]
    state_12 <= reset | state_11; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_13 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_13 <= state_12;
    end
    state_14 <= reset | state_13; // @[PRNG.scala 55:{49,49}]
    state_15 <= reset | state_14; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_16 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_16 <= state_15;
    end
    state_17 <= reset | state_16; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_18 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_18 <= state_17;
    end
    state_19 <= reset | state_18; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_20 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_20 <= state_19;
    end
    state_21 <= reset | state_20; // @[PRNG.scala 55:{49,49}]
    state_22 <= reset | state_21; // @[PRNG.scala 55:{49,49}]
    state_23 <= reset | state_22; // @[PRNG.scala 55:{49,49}]
    state_24 <= reset | state_23; // @[PRNG.scala 55:{49,49}]
    state_25 <= reset | state_24; // @[PRNG.scala 55:{49,49}]
    state_26 <= reset | state_25; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_27 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_27 <= state_26;
    end
    state_28 <= reset | state_27; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_29 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_29 <= state_28;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_30 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_30 <= state_29;
    end
    state_31 <= reset | state_30; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_32 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_32 <= state_31;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_33 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_33 <= state_32;
    end
    state_34 <= reset | state_33; // @[PRNG.scala 55:{49,49}]
    state_35 <= reset | state_34; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_36 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_36 <= state_35;
    end
    state_37 <= reset | state_36; // @[PRNG.scala 55:{49,49}]
    state_38 <= reset | state_37; // @[PRNG.scala 55:{49,49}]
    state_39 <= reset | state_38; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_40 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_40 <= state_39;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_41 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_41 <= state_40;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_42 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_42 <= state_41;
    end
    state_43 <= reset | state_42; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_44 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_44 <= state_43;
    end
    state_45 <= reset | state_44; // @[PRNG.scala 55:{49,49}]
    state_46 <= reset | state_45; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_47 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_47 <= state_46;
    end
    state_48 <= reset | state_47; // @[PRNG.scala 55:{49,49}]
    state_49 <= reset | state_48; // @[PRNG.scala 55:{49,49}]
    state_50 <= reset | state_49; // @[PRNG.scala 55:{49,49}]
    state_51 <= reset | state_50; // @[PRNG.scala 55:{49,49}]
    state_52 <= reset | state_51; // @[PRNG.scala 55:{49,49}]
    state_53 <= reset | state_52; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_54 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_54 <= state_53;
    end
    if (reset) begin // @[PRNG.scala 55:49]
      state_55 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_55 <= state_54;
    end
    state_56 <= reset | state_55; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_57 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_57 <= state_56;
    end
    state_58 <= reset | state_57; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_59 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_59 <= state_58;
    end
    state_60 <= reset | state_59; // @[PRNG.scala 55:{49,49}]
    state_61 <= reset | state_60; // @[PRNG.scala 55:{49,49}]
    if (reset) begin // @[PRNG.scala 55:49]
      state_62 <= 1'h0; // @[PRNG.scala 55:49]
    end else begin
      state_62 <= state_61;
    end
    state_63 <= reset | state_62; // @[PRNG.scala 55:{49,49}]
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
  state_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  state_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  state_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  state_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  state_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  state_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  state_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  state_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  state_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  state_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  state_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  state_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  state_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  state_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  state_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  state_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  state_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  state_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  state_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  state_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  state_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  state_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  state_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  state_23 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  state_24 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  state_25 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  state_26 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  state_27 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  state_28 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  state_29 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  state_30 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  state_31 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  state_32 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  state_33 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  state_34 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  state_35 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  state_36 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  state_37 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  state_38 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  state_39 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  state_40 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  state_41 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  state_42 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  state_43 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  state_44 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  state_45 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  state_46 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  state_47 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  state_48 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  state_49 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  state_50 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  state_51 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  state_52 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  state_53 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  state_54 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  state_55 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  state_56 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  state_57 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  state_58 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  state_59 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  state_60 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  state_61 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  state_62 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  state_63 = _RAND_63[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SE(
  input          clock,
  input          reset,
  input  [7:0]   io_in_inst,
  input  [127:0] io_in_op1,
  input  [127:0] io_in_op2,
  input  [127:0] io_in_cond,
  input          io_in_valid,
  output         io_in_ready,
  output [127:0] io_out_result,
  output         io_out_valid,
  input          io_out_ready,
  output [7:0]   io_out_cntr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [127:0] _RAND_2;
  reg [127:0] _RAND_3;
  reg [127:0] _RAND_4;
  reg [127:0] _RAND_5;
  reg [127:0] _RAND_6;
  reg [127:0] _RAND_7;
  reg [127:0] _RAND_8;
  reg [127:0] _RAND_9;
  reg [127:0] _RAND_10;
  reg [127:0] _RAND_11;
  reg [127:0] _RAND_12;
  reg [127:0] _RAND_13;
  reg [127:0] _RAND_14;
  reg [127:0] _RAND_15;
  reg [127:0] _RAND_16;
  reg [127:0] _RAND_17;
  reg [127:0] _RAND_18;
  reg [127:0] _RAND_19;
  reg [127:0] _RAND_20;
  reg [127:0] _RAND_21;
  reg [127:0] _RAND_22;
  reg [127:0] _RAND_23;
  reg [127:0] _RAND_24;
  reg [127:0] _RAND_25;
  reg [127:0] _RAND_26;
  reg [127:0] _RAND_27;
  reg [127:0] _RAND_28;
  reg [127:0] _RAND_29;
  reg [127:0] _RAND_30;
  reg [127:0] _RAND_31;
  reg [127:0] _RAND_32;
  reg [127:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [63:0] _RAND_66;
  reg [63:0] _RAND_67;
  reg [63:0] _RAND_68;
  reg [63:0] _RAND_69;
  reg [63:0] _RAND_70;
  reg [63:0] _RAND_71;
  reg [63:0] _RAND_72;
  reg [63:0] _RAND_73;
  reg [63:0] _RAND_74;
  reg [63:0] _RAND_75;
  reg [63:0] _RAND_76;
  reg [63:0] _RAND_77;
  reg [63:0] _RAND_78;
  reg [63:0] _RAND_79;
  reg [63:0] _RAND_80;
  reg [63:0] _RAND_81;
  reg [63:0] _RAND_82;
  reg [63:0] _RAND_83;
  reg [63:0] _RAND_84;
  reg [63:0] _RAND_85;
  reg [63:0] _RAND_86;
  reg [63:0] _RAND_87;
  reg [63:0] _RAND_88;
  reg [63:0] _RAND_89;
  reg [63:0] _RAND_90;
  reg [63:0] _RAND_91;
  reg [63:0] _RAND_92;
  reg [63:0] _RAND_93;
  reg [63:0] _RAND_94;
  reg [63:0] _RAND_95;
  reg [63:0] _RAND_96;
  reg [63:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [63:0] _RAND_99;
  reg [63:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [127:0] _RAND_102;
  reg [127:0] _RAND_103;
  reg [127:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [127:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [127:0] _RAND_110;
  reg [63:0] _RAND_111;
  reg [127:0] _RAND_112;
  reg [31:0] _RAND_113;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] seoperation_io_inst; // @[SE.scala 61:33]
  wire [63:0] seoperation_io_op1_input; // @[SE.scala 61:33]
  wire [63:0] seoperation_io_op2_input; // @[SE.scala 61:33]
  wire [63:0] seoperation_io_cond_input; // @[SE.scala 61:33]
  wire [63:0] seoperation_io_result; // @[SE.scala 61:33]
  wire  aes_invcipher_clock; // @[SE.scala 62:35]
  wire  aes_invcipher_reset; // @[SE.scala 62:35]
  wire  aes_invcipher_io_input_valid; // @[SE.scala 62:35]
  wire [63:0] aes_invcipher_io_p; // @[SE.scala 62:35]
  wire [63:0] aes_invcipher_io_q; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_0; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_1; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_2; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_3; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_4; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_5; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_6; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_7; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_8; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_9; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_10; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_11; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_12; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_13; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_14; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op1_15; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_0; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_1; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_2; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_3; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_4; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_5; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_6; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_7; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_8; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_9; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_10; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_11; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_12; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_13; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_14; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_op2_15; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_0; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_1; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_2; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_3; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_4; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_5; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_6; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_7; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_8; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_9; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_10; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_11; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_12; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_13; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_14; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_input_cond_15; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_0; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_1; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_2; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_3; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_4; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_5; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_6; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_7; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_8; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_9; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_10; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_11; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_12; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_13; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_14; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op1_15; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_0; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_1; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_2; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_3; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_4; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_5; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_6; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_7; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_8; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_9; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_10; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_11; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_12; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_13; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_14; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_op2_15; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_0; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_1; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_2; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_3; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_4; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_5; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_6; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_7; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_8; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_9; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_10; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_11; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_12; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_13; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_14; // @[SE.scala 62:35]
  wire [7:0] aes_invcipher_io_output_cond_15; // @[SE.scala 62:35]
  wire  aes_invcipher_io_output_valid; // @[SE.scala 62:35]
  wire  aes_cipher_clock; // @[SE.scala 63:32]
  wire  aes_cipher_reset; // @[SE.scala 63:32]
  wire  aes_cipher_io_input_valid; // @[SE.scala 63:32]
  wire [63:0] aes_cipher_io_p; // @[SE.scala 63:32]
  wire [63:0] aes_cipher_io_q; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_0; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_1; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_2; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_3; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_4; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_5; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_6; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_7; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_8; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_9; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_10; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_11; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_12; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_13; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_14; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_input_text_15; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_0; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_1; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_2; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_3; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_4; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_5; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_6; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_7; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_8; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_9; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_10; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_11; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_12; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_13; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_14; // @[SE.scala 63:32]
  wire [7:0] aes_cipher_io_output_text_15; // @[SE.scala 63:32]
  wire  aes_cipher_io_output_valid; // @[SE.scala 63:32]
  wire  bit64_randnum_prng_clock; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_reset; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_0; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_1; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_2; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_3; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_4; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_5; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_6; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_7; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_8; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_9; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_10; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_11; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_12; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_13; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_14; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_15; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_16; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_17; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_18; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_19; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_20; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_21; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_22; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_23; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_24; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_25; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_26; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_27; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_28; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_29; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_30; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_31; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_32; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_33; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_34; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_35; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_36; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_37; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_38; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_39; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_40; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_41; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_42; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_43; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_44; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_45; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_46; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_47; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_48; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_49; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_50; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_51; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_52; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_53; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_54; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_55; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_56; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_57; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_58; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_59; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_60; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_61; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_62; // @[PRNG.scala 91:22]
  wire  bit64_randnum_prng_io_out_63; // @[PRNG.scala 91:22]
  reg  counterOn; // @[SE.scala 42:32]
  reg [6:0] value; // @[Counter.scala 62:40]
  wire  wrap = value == 7'h63; // @[Counter.scala 74:24]
  wire [6:0] _value_T_1 = value + 7'h1; // @[Counter.scala 78:24]
  wire  _T = io_in_valid & io_in_ready; // @[SE.scala 48:26]
  wire  _T_1 = io_out_valid & io_out_ready; // @[SE.scala 50:33]
  wire  _GEN_2 = io_out_valid & io_out_ready ? 1'h0 : counterOn; // @[SE.scala 50:49 51:27 42:32]
  wire  _GEN_3 = io_in_valid & io_in_ready | _GEN_2; // @[SE.scala 48:41 49:27]
  reg [127:0] ciphers_0; // @[SE.scala 66:26]
  reg [127:0] ciphers_1; // @[SE.scala 66:26]
  reg [127:0] ciphers_2; // @[SE.scala 66:26]
  reg [127:0] ciphers_3; // @[SE.scala 66:26]
  reg [127:0] ciphers_4; // @[SE.scala 66:26]
  reg [127:0] ciphers_5; // @[SE.scala 66:26]
  reg [127:0] ciphers_6; // @[SE.scala 66:26]
  reg [127:0] ciphers_7; // @[SE.scala 66:26]
  reg [127:0] ciphers_8; // @[SE.scala 66:26]
  reg [127:0] ciphers_9; // @[SE.scala 66:26]
  reg [127:0] ciphers_10; // @[SE.scala 66:26]
  reg [127:0] ciphers_11; // @[SE.scala 66:26]
  reg [127:0] ciphers_12; // @[SE.scala 66:26]
  reg [127:0] ciphers_13; // @[SE.scala 66:26]
  reg [127:0] ciphers_14; // @[SE.scala 66:26]
  reg [127:0] ciphers_15; // @[SE.scala 66:26]
  reg [127:0] ciphers_16; // @[SE.scala 66:26]
  reg [127:0] ciphers_17; // @[SE.scala 66:26]
  reg [127:0] ciphers_18; // @[SE.scala 66:26]
  reg [127:0] ciphers_19; // @[SE.scala 66:26]
  reg [127:0] ciphers_20; // @[SE.scala 66:26]
  reg [127:0] ciphers_21; // @[SE.scala 66:26]
  reg [127:0] ciphers_22; // @[SE.scala 66:26]
  reg [127:0] ciphers_23; // @[SE.scala 66:26]
  reg [127:0] ciphers_24; // @[SE.scala 66:26]
  reg [127:0] ciphers_25; // @[SE.scala 66:26]
  reg [127:0] ciphers_26; // @[SE.scala 66:26]
  reg [127:0] ciphers_27; // @[SE.scala 66:26]
  reg [127:0] ciphers_28; // @[SE.scala 66:26]
  reg [127:0] ciphers_29; // @[SE.scala 66:26]
  reg [127:0] ciphers_30; // @[SE.scala 66:26]
  reg [127:0] ciphers_31; // @[SE.scala 66:26]
  reg  cache_valid_0; // @[SE.scala 67:30]
  reg  cache_valid_1; // @[SE.scala 67:30]
  reg  cache_valid_2; // @[SE.scala 67:30]
  reg  cache_valid_3; // @[SE.scala 67:30]
  reg  cache_valid_4; // @[SE.scala 67:30]
  reg  cache_valid_5; // @[SE.scala 67:30]
  reg  cache_valid_6; // @[SE.scala 67:30]
  reg  cache_valid_7; // @[SE.scala 67:30]
  reg  cache_valid_8; // @[SE.scala 67:30]
  reg  cache_valid_9; // @[SE.scala 67:30]
  reg  cache_valid_10; // @[SE.scala 67:30]
  reg  cache_valid_11; // @[SE.scala 67:30]
  reg  cache_valid_12; // @[SE.scala 67:30]
  reg  cache_valid_13; // @[SE.scala 67:30]
  reg  cache_valid_14; // @[SE.scala 67:30]
  reg  cache_valid_15; // @[SE.scala 67:30]
  reg  cache_valid_16; // @[SE.scala 67:30]
  reg  cache_valid_17; // @[SE.scala 67:30]
  reg  cache_valid_18; // @[SE.scala 67:30]
  reg  cache_valid_19; // @[SE.scala 67:30]
  reg  cache_valid_20; // @[SE.scala 67:30]
  reg  cache_valid_21; // @[SE.scala 67:30]
  reg  cache_valid_22; // @[SE.scala 67:30]
  reg  cache_valid_23; // @[SE.scala 67:30]
  reg  cache_valid_24; // @[SE.scala 67:30]
  reg  cache_valid_25; // @[SE.scala 67:30]
  reg  cache_valid_26; // @[SE.scala 67:30]
  reg  cache_valid_27; // @[SE.scala 67:30]
  reg  cache_valid_28; // @[SE.scala 67:30]
  reg  cache_valid_29; // @[SE.scala 67:30]
  reg  cache_valid_30; // @[SE.scala 67:30]
  reg  cache_valid_31; // @[SE.scala 67:30]
  reg [63:0] plaintexts_0; // @[SE.scala 68:29]
  reg [63:0] plaintexts_1; // @[SE.scala 68:29]
  reg [63:0] plaintexts_2; // @[SE.scala 68:29]
  reg [63:0] plaintexts_3; // @[SE.scala 68:29]
  reg [63:0] plaintexts_4; // @[SE.scala 68:29]
  reg [63:0] plaintexts_5; // @[SE.scala 68:29]
  reg [63:0] plaintexts_6; // @[SE.scala 68:29]
  reg [63:0] plaintexts_7; // @[SE.scala 68:29]
  reg [63:0] plaintexts_8; // @[SE.scala 68:29]
  reg [63:0] plaintexts_9; // @[SE.scala 68:29]
  reg [63:0] plaintexts_10; // @[SE.scala 68:29]
  reg [63:0] plaintexts_11; // @[SE.scala 68:29]
  reg [63:0] plaintexts_12; // @[SE.scala 68:29]
  reg [63:0] plaintexts_13; // @[SE.scala 68:29]
  reg [63:0] plaintexts_14; // @[SE.scala 68:29]
  reg [63:0] plaintexts_15; // @[SE.scala 68:29]
  reg [63:0] plaintexts_16; // @[SE.scala 68:29]
  reg [63:0] plaintexts_17; // @[SE.scala 68:29]
  reg [63:0] plaintexts_18; // @[SE.scala 68:29]
  reg [63:0] plaintexts_19; // @[SE.scala 68:29]
  reg [63:0] plaintexts_20; // @[SE.scala 68:29]
  reg [63:0] plaintexts_21; // @[SE.scala 68:29]
  reg [63:0] plaintexts_22; // @[SE.scala 68:29]
  reg [63:0] plaintexts_23; // @[SE.scala 68:29]
  reg [63:0] plaintexts_24; // @[SE.scala 68:29]
  reg [63:0] plaintexts_25; // @[SE.scala 68:29]
  reg [63:0] plaintexts_26; // @[SE.scala 68:29]
  reg [63:0] plaintexts_27; // @[SE.scala 68:29]
  reg [63:0] plaintexts_28; // @[SE.scala 68:29]
  reg [63:0] plaintexts_29; // @[SE.scala 68:29]
  reg [63:0] plaintexts_30; // @[SE.scala 68:29]
  reg [63:0] plaintexts_31; // @[SE.scala 68:29]
  reg [7:0] ptr; // @[SE.scala 69:26]
  reg [63:0] p; // @[SE.scala 75:24]
  reg [63:0] q; // @[SE.scala 76:24]
  reg [7:0] inst_buffer; // @[Reg.scala 16:16]
  reg [127:0] op1_buffer; // @[Reg.scala 16:16]
  reg [127:0] op2_buffer; // @[Reg.scala 16:16]
  reg [127:0] cond_buffer; // @[Reg.scala 16:16]
  reg  valid_buffer; // @[SE.scala 113:31]
  reg  ready_for_input; // @[SE.scala 116:38]
  wire  _op1_found_T = ciphers_0 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_1 = ciphers_1 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_2 = ciphers_2 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_3 = ciphers_3 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_4 = ciphers_4 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_5 = ciphers_5 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_6 = ciphers_6 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_7 = ciphers_7 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_8 = ciphers_8 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_9 = ciphers_9 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_10 = ciphers_10 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_11 = ciphers_11 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_12 = ciphers_12 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_13 = ciphers_13 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_14 = ciphers_14 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_15 = ciphers_15 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_47 = ciphers_0 == op1_buffer | ciphers_1 == op1_buffer | ciphers_2 == op1_buffer | ciphers_3 ==
    op1_buffer | ciphers_4 == op1_buffer | ciphers_5 == op1_buffer | ciphers_6 == op1_buffer | ciphers_7 == op1_buffer
     | ciphers_8 == op1_buffer | ciphers_9 == op1_buffer | ciphers_10 == op1_buffer | ciphers_11 == op1_buffer |
    ciphers_12 == op1_buffer | ciphers_13 == op1_buffer | ciphers_14 == op1_buffer | _op1_found_T_15; // @[SE.scala 147:41]
  wire  _op1_found_T_16 = ciphers_16 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_17 = ciphers_17 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_18 = ciphers_18 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_19 = ciphers_19 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_20 = ciphers_20 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_21 = ciphers_21 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_22 = ciphers_22 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_23 = ciphers_23 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_24 = ciphers_24 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_25 = ciphers_25 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_26 = ciphers_26 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_27 = ciphers_27 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_28 = ciphers_28 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_29 = ciphers_29 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_30 = ciphers_30 == op1_buffer; // @[SE.scala 147:41]
  wire  _op1_found_T_62 = _op1_found_T_47 | ciphers_16 == op1_buffer | ciphers_17 == op1_buffer | ciphers_18 ==
    op1_buffer | ciphers_19 == op1_buffer | ciphers_20 == op1_buffer | ciphers_21 == op1_buffer | ciphers_22 ==
    op1_buffer | ciphers_23 == op1_buffer | ciphers_24 == op1_buffer | ciphers_25 == op1_buffer | ciphers_26 ==
    op1_buffer | ciphers_27 == op1_buffer | ciphers_28 == op1_buffer | ciphers_29 == op1_buffer | ciphers_30 ==
    op1_buffer; // @[SE.scala 147:41]
  wire  op1_found = _op1_found_T_62 | ciphers_31 == op1_buffer; // @[SE.scala 147:41]
  wire  _op2_found_T = ciphers_0 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_1 = ciphers_1 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_2 = ciphers_2 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_3 = ciphers_3 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_4 = ciphers_4 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_5 = ciphers_5 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_6 = ciphers_6 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_7 = ciphers_7 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_8 = ciphers_8 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_9 = ciphers_9 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_10 = ciphers_10 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_11 = ciphers_11 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_12 = ciphers_12 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_13 = ciphers_13 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_14 = ciphers_14 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_15 = ciphers_15 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_47 = ciphers_0 == op2_buffer | ciphers_1 == op2_buffer | ciphers_2 == op2_buffer | ciphers_3 ==
    op2_buffer | ciphers_4 == op2_buffer | ciphers_5 == op2_buffer | ciphers_6 == op2_buffer | ciphers_7 == op2_buffer
     | ciphers_8 == op2_buffer | ciphers_9 == op2_buffer | ciphers_10 == op2_buffer | ciphers_11 == op2_buffer |
    ciphers_12 == op2_buffer | ciphers_13 == op2_buffer | ciphers_14 == op2_buffer | _op2_found_T_15; // @[SE.scala 148:41]
  wire  _op2_found_T_16 = ciphers_16 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_17 = ciphers_17 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_18 = ciphers_18 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_19 = ciphers_19 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_20 = ciphers_20 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_21 = ciphers_21 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_22 = ciphers_22 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_23 = ciphers_23 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_24 = ciphers_24 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_25 = ciphers_25 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_26 = ciphers_26 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_27 = ciphers_27 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_28 = ciphers_28 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_29 = ciphers_29 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_30 = ciphers_30 == op2_buffer; // @[SE.scala 148:41]
  wire  _op2_found_T_62 = _op2_found_T_47 | ciphers_16 == op2_buffer | ciphers_17 == op2_buffer | ciphers_18 ==
    op2_buffer | ciphers_19 == op2_buffer | ciphers_20 == op2_buffer | ciphers_21 == op2_buffer | ciphers_22 ==
    op2_buffer | ciphers_23 == op2_buffer | ciphers_24 == op2_buffer | ciphers_25 == op2_buffer | ciphers_26 ==
    op2_buffer | ciphers_27 == op2_buffer | ciphers_28 == op2_buffer | ciphers_29 == op2_buffer | ciphers_30 ==
    op2_buffer; // @[SE.scala 148:41]
  wire  op2_found = _op2_found_T_62 | ciphers_31 == op2_buffer; // @[SE.scala 148:41]
  wire [7:0] _T_5 = inst_buffer & 8'he0; // @[SE.scala 150:26]
  wire  _cond_found_T = ciphers_0 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_1 = ciphers_1 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_2 = ciphers_2 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_3 = ciphers_3 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_4 = ciphers_4 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_5 = ciphers_5 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_6 = ciphers_6 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_7 = ciphers_7 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_8 = ciphers_8 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_9 = ciphers_9 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_10 = ciphers_10 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_11 = ciphers_11 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_12 = ciphers_12 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_13 = ciphers_13 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_14 = ciphers_14 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_15 = ciphers_15 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_47 = ciphers_0 == cond_buffer | ciphers_1 == cond_buffer | ciphers_2 == cond_buffer | ciphers_3
     == cond_buffer | ciphers_4 == cond_buffer | ciphers_5 == cond_buffer | ciphers_6 == cond_buffer | ciphers_7 ==
    cond_buffer | ciphers_8 == cond_buffer | ciphers_9 == cond_buffer | ciphers_10 == cond_buffer | ciphers_11 ==
    cond_buffer | ciphers_12 == cond_buffer | ciphers_13 == cond_buffer | ciphers_14 == cond_buffer | _cond_found_T_15; // @[SE.scala 151:47]
  wire  _cond_found_T_16 = ciphers_16 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_17 = ciphers_17 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_18 = ciphers_18 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_19 = ciphers_19 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_20 = ciphers_20 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_21 = ciphers_21 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_22 = ciphers_22 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_23 = ciphers_23 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_24 = ciphers_24 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_25 = ciphers_25 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_26 = ciphers_26 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_27 = ciphers_27 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_28 = ciphers_28 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_29 = ciphers_29 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_30 = ciphers_30 == cond_buffer; // @[SE.scala 151:47]
  wire  _cond_found_T_62 = _cond_found_T_47 | ciphers_16 == cond_buffer | ciphers_17 == cond_buffer | ciphers_18 ==
    cond_buffer | ciphers_19 == cond_buffer | ciphers_20 == cond_buffer | ciphers_21 == cond_buffer | ciphers_22 ==
    cond_buffer | ciphers_23 == cond_buffer | ciphers_24 == cond_buffer | ciphers_25 == cond_buffer | ciphers_26 ==
    cond_buffer | ciphers_27 == cond_buffer | ciphers_28 == cond_buffer | ciphers_29 == cond_buffer | ciphers_30 ==
    cond_buffer; // @[SE.scala 151:47]
  wire  cond_found = 8'h60 == _T_5 ? _cond_found_T_62 | ciphers_31 == cond_buffer : 1'h1; // @[SE.scala 150:48 151:28 153:28]
  wire [4:0] _op1_idx_T_32 = _op1_found_T_30 ? 5'h1e : 5'h1f; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_33 = _op1_found_T_29 ? 5'h1d : _op1_idx_T_32; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_34 = _op1_found_T_28 ? 5'h1c : _op1_idx_T_33; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_35 = _op1_found_T_27 ? 5'h1b : _op1_idx_T_34; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_36 = _op1_found_T_26 ? 5'h1a : _op1_idx_T_35; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_37 = _op1_found_T_25 ? 5'h19 : _op1_idx_T_36; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_38 = _op1_found_T_24 ? 5'h18 : _op1_idx_T_37; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_39 = _op1_found_T_23 ? 5'h17 : _op1_idx_T_38; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_40 = _op1_found_T_22 ? 5'h16 : _op1_idx_T_39; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_41 = _op1_found_T_21 ? 5'h15 : _op1_idx_T_40; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_42 = _op1_found_T_20 ? 5'h14 : _op1_idx_T_41; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_43 = _op1_found_T_19 ? 5'h13 : _op1_idx_T_42; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_44 = _op1_found_T_18 ? 5'h12 : _op1_idx_T_43; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_45 = _op1_found_T_17 ? 5'h11 : _op1_idx_T_44; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_46 = _op1_found_T_16 ? 5'h10 : _op1_idx_T_45; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_47 = _op1_found_T_15 ? 5'hf : _op1_idx_T_46; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_48 = _op1_found_T_14 ? 5'he : _op1_idx_T_47; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_49 = _op1_found_T_13 ? 5'hd : _op1_idx_T_48; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_50 = _op1_found_T_12 ? 5'hc : _op1_idx_T_49; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_51 = _op1_found_T_11 ? 5'hb : _op1_idx_T_50; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_52 = _op1_found_T_10 ? 5'ha : _op1_idx_T_51; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_53 = _op1_found_T_9 ? 5'h9 : _op1_idx_T_52; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_54 = _op1_found_T_8 ? 5'h8 : _op1_idx_T_53; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_55 = _op1_found_T_7 ? 5'h7 : _op1_idx_T_54; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_56 = _op1_found_T_6 ? 5'h6 : _op1_idx_T_55; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_57 = _op1_found_T_5 ? 5'h5 : _op1_idx_T_56; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_58 = _op1_found_T_4 ? 5'h4 : _op1_idx_T_57; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_59 = _op1_found_T_3 ? 5'h3 : _op1_idx_T_58; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_60 = _op1_found_T_2 ? 5'h2 : _op1_idx_T_59; // @[SE.scala 155:41]
  wire [4:0] _op1_idx_T_61 = _op1_found_T_1 ? 5'h1 : _op1_idx_T_60; // @[SE.scala 155:41]
  wire [4:0] op1_idx = _op1_found_T ? 5'h0 : _op1_idx_T_61; // @[SE.scala 155:41]
  wire  _GEN_13 = 5'h1 == op1_idx ? cache_valid_1 : cache_valid_0; // @[SE.scala 163:{62,62}]
  wire  _GEN_14 = 5'h2 == op1_idx ? cache_valid_2 : _GEN_13; // @[SE.scala 163:{62,62}]
  wire  _GEN_15 = 5'h3 == op1_idx ? cache_valid_3 : _GEN_14; // @[SE.scala 163:{62,62}]
  wire  _GEN_16 = 5'h4 == op1_idx ? cache_valid_4 : _GEN_15; // @[SE.scala 163:{62,62}]
  wire  _GEN_17 = 5'h5 == op1_idx ? cache_valid_5 : _GEN_16; // @[SE.scala 163:{62,62}]
  wire  _GEN_18 = 5'h6 == op1_idx ? cache_valid_6 : _GEN_17; // @[SE.scala 163:{62,62}]
  wire  _GEN_19 = 5'h7 == op1_idx ? cache_valid_7 : _GEN_18; // @[SE.scala 163:{62,62}]
  wire  _GEN_20 = 5'h8 == op1_idx ? cache_valid_8 : _GEN_19; // @[SE.scala 163:{62,62}]
  wire  _GEN_21 = 5'h9 == op1_idx ? cache_valid_9 : _GEN_20; // @[SE.scala 163:{62,62}]
  wire  _GEN_22 = 5'ha == op1_idx ? cache_valid_10 : _GEN_21; // @[SE.scala 163:{62,62}]
  wire  _GEN_23 = 5'hb == op1_idx ? cache_valid_11 : _GEN_22; // @[SE.scala 163:{62,62}]
  wire  _GEN_24 = 5'hc == op1_idx ? cache_valid_12 : _GEN_23; // @[SE.scala 163:{62,62}]
  wire  _GEN_25 = 5'hd == op1_idx ? cache_valid_13 : _GEN_24; // @[SE.scala 163:{62,62}]
  wire  _GEN_26 = 5'he == op1_idx ? cache_valid_14 : _GEN_25; // @[SE.scala 163:{62,62}]
  wire  _GEN_27 = 5'hf == op1_idx ? cache_valid_15 : _GEN_26; // @[SE.scala 163:{62,62}]
  wire  _GEN_28 = 5'h10 == op1_idx ? cache_valid_16 : _GEN_27; // @[SE.scala 163:{62,62}]
  wire  _GEN_29 = 5'h11 == op1_idx ? cache_valid_17 : _GEN_28; // @[SE.scala 163:{62,62}]
  wire  _GEN_30 = 5'h12 == op1_idx ? cache_valid_18 : _GEN_29; // @[SE.scala 163:{62,62}]
  wire  _GEN_31 = 5'h13 == op1_idx ? cache_valid_19 : _GEN_30; // @[SE.scala 163:{62,62}]
  wire  _GEN_32 = 5'h14 == op1_idx ? cache_valid_20 : _GEN_31; // @[SE.scala 163:{62,62}]
  wire  _GEN_33 = 5'h15 == op1_idx ? cache_valid_21 : _GEN_32; // @[SE.scala 163:{62,62}]
  wire  _GEN_34 = 5'h16 == op1_idx ? cache_valid_22 : _GEN_33; // @[SE.scala 163:{62,62}]
  wire  _GEN_35 = 5'h17 == op1_idx ? cache_valid_23 : _GEN_34; // @[SE.scala 163:{62,62}]
  wire  _GEN_36 = 5'h18 == op1_idx ? cache_valid_24 : _GEN_35; // @[SE.scala 163:{62,62}]
  wire  _GEN_37 = 5'h19 == op1_idx ? cache_valid_25 : _GEN_36; // @[SE.scala 163:{62,62}]
  wire  _GEN_38 = 5'h1a == op1_idx ? cache_valid_26 : _GEN_37; // @[SE.scala 163:{62,62}]
  wire  _GEN_39 = 5'h1b == op1_idx ? cache_valid_27 : _GEN_38; // @[SE.scala 163:{62,62}]
  wire  _GEN_40 = 5'h1c == op1_idx ? cache_valid_28 : _GEN_39; // @[SE.scala 163:{62,62}]
  wire  _GEN_41 = 5'h1d == op1_idx ? cache_valid_29 : _GEN_40; // @[SE.scala 163:{62,62}]
  wire  _GEN_42 = 5'h1e == op1_idx ? cache_valid_30 : _GEN_41; // @[SE.scala 163:{62,62}]
  wire  _GEN_43 = 5'h1f == op1_idx ? cache_valid_31 : _GEN_42; // @[SE.scala 163:{62,62}]
  wire [4:0] _op2_idx_T_32 = _op2_found_T_30 ? 5'h1e : 5'h1f; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_33 = _op2_found_T_29 ? 5'h1d : _op2_idx_T_32; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_34 = _op2_found_T_28 ? 5'h1c : _op2_idx_T_33; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_35 = _op2_found_T_27 ? 5'h1b : _op2_idx_T_34; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_36 = _op2_found_T_26 ? 5'h1a : _op2_idx_T_35; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_37 = _op2_found_T_25 ? 5'h19 : _op2_idx_T_36; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_38 = _op2_found_T_24 ? 5'h18 : _op2_idx_T_37; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_39 = _op2_found_T_23 ? 5'h17 : _op2_idx_T_38; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_40 = _op2_found_T_22 ? 5'h16 : _op2_idx_T_39; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_41 = _op2_found_T_21 ? 5'h15 : _op2_idx_T_40; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_42 = _op2_found_T_20 ? 5'h14 : _op2_idx_T_41; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_43 = _op2_found_T_19 ? 5'h13 : _op2_idx_T_42; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_44 = _op2_found_T_18 ? 5'h12 : _op2_idx_T_43; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_45 = _op2_found_T_17 ? 5'h11 : _op2_idx_T_44; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_46 = _op2_found_T_16 ? 5'h10 : _op2_idx_T_45; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_47 = _op2_found_T_15 ? 5'hf : _op2_idx_T_46; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_48 = _op2_found_T_14 ? 5'he : _op2_idx_T_47; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_49 = _op2_found_T_13 ? 5'hd : _op2_idx_T_48; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_50 = _op2_found_T_12 ? 5'hc : _op2_idx_T_49; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_51 = _op2_found_T_11 ? 5'hb : _op2_idx_T_50; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_52 = _op2_found_T_10 ? 5'ha : _op2_idx_T_51; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_53 = _op2_found_T_9 ? 5'h9 : _op2_idx_T_52; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_54 = _op2_found_T_8 ? 5'h8 : _op2_idx_T_53; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_55 = _op2_found_T_7 ? 5'h7 : _op2_idx_T_54; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_56 = _op2_found_T_6 ? 5'h6 : _op2_idx_T_55; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_57 = _op2_found_T_5 ? 5'h5 : _op2_idx_T_56; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_58 = _op2_found_T_4 ? 5'h4 : _op2_idx_T_57; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_59 = _op2_found_T_3 ? 5'h3 : _op2_idx_T_58; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_60 = _op2_found_T_2 ? 5'h2 : _op2_idx_T_59; // @[SE.scala 156:41]
  wire [4:0] _op2_idx_T_61 = _op2_found_T_1 ? 5'h1 : _op2_idx_T_60; // @[SE.scala 156:41]
  wire [4:0] op2_idx = _op2_found_T ? 5'h0 : _op2_idx_T_61; // @[SE.scala 156:41]
  wire  _GEN_45 = 5'h1 == op2_idx ? cache_valid_1 : cache_valid_0; // @[SE.scala 163:{86,86}]
  wire  _GEN_46 = 5'h2 == op2_idx ? cache_valid_2 : _GEN_45; // @[SE.scala 163:{86,86}]
  wire  _GEN_47 = 5'h3 == op2_idx ? cache_valid_3 : _GEN_46; // @[SE.scala 163:{86,86}]
  wire  _GEN_48 = 5'h4 == op2_idx ? cache_valid_4 : _GEN_47; // @[SE.scala 163:{86,86}]
  wire  _GEN_49 = 5'h5 == op2_idx ? cache_valid_5 : _GEN_48; // @[SE.scala 163:{86,86}]
  wire  _GEN_50 = 5'h6 == op2_idx ? cache_valid_6 : _GEN_49; // @[SE.scala 163:{86,86}]
  wire  _GEN_51 = 5'h7 == op2_idx ? cache_valid_7 : _GEN_50; // @[SE.scala 163:{86,86}]
  wire  _GEN_52 = 5'h8 == op2_idx ? cache_valid_8 : _GEN_51; // @[SE.scala 163:{86,86}]
  wire  _GEN_53 = 5'h9 == op2_idx ? cache_valid_9 : _GEN_52; // @[SE.scala 163:{86,86}]
  wire  _GEN_54 = 5'ha == op2_idx ? cache_valid_10 : _GEN_53; // @[SE.scala 163:{86,86}]
  wire  _GEN_55 = 5'hb == op2_idx ? cache_valid_11 : _GEN_54; // @[SE.scala 163:{86,86}]
  wire  _GEN_56 = 5'hc == op2_idx ? cache_valid_12 : _GEN_55; // @[SE.scala 163:{86,86}]
  wire  _GEN_57 = 5'hd == op2_idx ? cache_valid_13 : _GEN_56; // @[SE.scala 163:{86,86}]
  wire  _GEN_58 = 5'he == op2_idx ? cache_valid_14 : _GEN_57; // @[SE.scala 163:{86,86}]
  wire  _GEN_59 = 5'hf == op2_idx ? cache_valid_15 : _GEN_58; // @[SE.scala 163:{86,86}]
  wire  _GEN_60 = 5'h10 == op2_idx ? cache_valid_16 : _GEN_59; // @[SE.scala 163:{86,86}]
  wire  _GEN_61 = 5'h11 == op2_idx ? cache_valid_17 : _GEN_60; // @[SE.scala 163:{86,86}]
  wire  _GEN_62 = 5'h12 == op2_idx ? cache_valid_18 : _GEN_61; // @[SE.scala 163:{86,86}]
  wire  _GEN_63 = 5'h13 == op2_idx ? cache_valid_19 : _GEN_62; // @[SE.scala 163:{86,86}]
  wire  _GEN_64 = 5'h14 == op2_idx ? cache_valid_20 : _GEN_63; // @[SE.scala 163:{86,86}]
  wire  _GEN_65 = 5'h15 == op2_idx ? cache_valid_21 : _GEN_64; // @[SE.scala 163:{86,86}]
  wire  _GEN_66 = 5'h16 == op2_idx ? cache_valid_22 : _GEN_65; // @[SE.scala 163:{86,86}]
  wire  _GEN_67 = 5'h17 == op2_idx ? cache_valid_23 : _GEN_66; // @[SE.scala 163:{86,86}]
  wire  _GEN_68 = 5'h18 == op2_idx ? cache_valid_24 : _GEN_67; // @[SE.scala 163:{86,86}]
  wire  _GEN_69 = 5'h19 == op2_idx ? cache_valid_25 : _GEN_68; // @[SE.scala 163:{86,86}]
  wire  _GEN_70 = 5'h1a == op2_idx ? cache_valid_26 : _GEN_69; // @[SE.scala 163:{86,86}]
  wire  _GEN_71 = 5'h1b == op2_idx ? cache_valid_27 : _GEN_70; // @[SE.scala 163:{86,86}]
  wire  _GEN_72 = 5'h1c == op2_idx ? cache_valid_28 : _GEN_71; // @[SE.scala 163:{86,86}]
  wire  _GEN_73 = 5'h1d == op2_idx ? cache_valid_29 : _GEN_72; // @[SE.scala 163:{86,86}]
  wire  _GEN_74 = 5'h1e == op2_idx ? cache_valid_30 : _GEN_73; // @[SE.scala 163:{86,86}]
  wire  _GEN_75 = 5'h1f == op2_idx ? cache_valid_31 : _GEN_74; // @[SE.scala 163:{86,86}]
  wire [4:0] _cond_idx_T_32 = _cond_found_T_30 ? 5'h1e : 5'h1f; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_33 = _cond_found_T_29 ? 5'h1d : _cond_idx_T_32; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_34 = _cond_found_T_28 ? 5'h1c : _cond_idx_T_33; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_35 = _cond_found_T_27 ? 5'h1b : _cond_idx_T_34; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_36 = _cond_found_T_26 ? 5'h1a : _cond_idx_T_35; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_37 = _cond_found_T_25 ? 5'h19 : _cond_idx_T_36; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_38 = _cond_found_T_24 ? 5'h18 : _cond_idx_T_37; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_39 = _cond_found_T_23 ? 5'h17 : _cond_idx_T_38; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_40 = _cond_found_T_22 ? 5'h16 : _cond_idx_T_39; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_41 = _cond_found_T_21 ? 5'h15 : _cond_idx_T_40; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_42 = _cond_found_T_20 ? 5'h14 : _cond_idx_T_41; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_43 = _cond_found_T_19 ? 5'h13 : _cond_idx_T_42; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_44 = _cond_found_T_18 ? 5'h12 : _cond_idx_T_43; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_45 = _cond_found_T_17 ? 5'h11 : _cond_idx_T_44; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_46 = _cond_found_T_16 ? 5'h10 : _cond_idx_T_45; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_47 = _cond_found_T_15 ? 5'hf : _cond_idx_T_46; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_48 = _cond_found_T_14 ? 5'he : _cond_idx_T_47; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_49 = _cond_found_T_13 ? 5'hd : _cond_idx_T_48; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_50 = _cond_found_T_12 ? 5'hc : _cond_idx_T_49; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_51 = _cond_found_T_11 ? 5'hb : _cond_idx_T_50; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_52 = _cond_found_T_10 ? 5'ha : _cond_idx_T_51; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_53 = _cond_found_T_9 ? 5'h9 : _cond_idx_T_52; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_54 = _cond_found_T_8 ? 5'h8 : _cond_idx_T_53; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_55 = _cond_found_T_7 ? 5'h7 : _cond_idx_T_54; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_56 = _cond_found_T_6 ? 5'h6 : _cond_idx_T_55; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_57 = _cond_found_T_5 ? 5'h5 : _cond_idx_T_56; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_58 = _cond_found_T_4 ? 5'h4 : _cond_idx_T_57; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_59 = _cond_found_T_3 ? 5'h3 : _cond_idx_T_58; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_60 = _cond_found_T_2 ? 5'h2 : _cond_idx_T_59; // @[SE.scala 157:42]
  wire [4:0] _cond_idx_T_61 = _cond_found_T_1 ? 5'h1 : _cond_idx_T_60; // @[SE.scala 157:42]
  wire [4:0] cond_idx = _cond_found_T ? 5'h0 : _cond_idx_T_61; // @[SE.scala 157:42]
  wire  _GEN_77 = 5'h1 == cond_idx ? cache_valid_1 : cache_valid_0; // @[SE.scala 163:{110,110}]
  wire  _GEN_78 = 5'h2 == cond_idx ? cache_valid_2 : _GEN_77; // @[SE.scala 163:{110,110}]
  wire  _GEN_79 = 5'h3 == cond_idx ? cache_valid_3 : _GEN_78; // @[SE.scala 163:{110,110}]
  wire  _GEN_80 = 5'h4 == cond_idx ? cache_valid_4 : _GEN_79; // @[SE.scala 163:{110,110}]
  wire  _GEN_81 = 5'h5 == cond_idx ? cache_valid_5 : _GEN_80; // @[SE.scala 163:{110,110}]
  wire  _GEN_82 = 5'h6 == cond_idx ? cache_valid_6 : _GEN_81; // @[SE.scala 163:{110,110}]
  wire  _GEN_83 = 5'h7 == cond_idx ? cache_valid_7 : _GEN_82; // @[SE.scala 163:{110,110}]
  wire  _GEN_84 = 5'h8 == cond_idx ? cache_valid_8 : _GEN_83; // @[SE.scala 163:{110,110}]
  wire  _GEN_85 = 5'h9 == cond_idx ? cache_valid_9 : _GEN_84; // @[SE.scala 163:{110,110}]
  wire  _GEN_86 = 5'ha == cond_idx ? cache_valid_10 : _GEN_85; // @[SE.scala 163:{110,110}]
  wire  _GEN_87 = 5'hb == cond_idx ? cache_valid_11 : _GEN_86; // @[SE.scala 163:{110,110}]
  wire  _GEN_88 = 5'hc == cond_idx ? cache_valid_12 : _GEN_87; // @[SE.scala 163:{110,110}]
  wire  _GEN_89 = 5'hd == cond_idx ? cache_valid_13 : _GEN_88; // @[SE.scala 163:{110,110}]
  wire  _GEN_90 = 5'he == cond_idx ? cache_valid_14 : _GEN_89; // @[SE.scala 163:{110,110}]
  wire  _GEN_91 = 5'hf == cond_idx ? cache_valid_15 : _GEN_90; // @[SE.scala 163:{110,110}]
  wire  _GEN_92 = 5'h10 == cond_idx ? cache_valid_16 : _GEN_91; // @[SE.scala 163:{110,110}]
  wire  _GEN_93 = 5'h11 == cond_idx ? cache_valid_17 : _GEN_92; // @[SE.scala 163:{110,110}]
  wire  _GEN_94 = 5'h12 == cond_idx ? cache_valid_18 : _GEN_93; // @[SE.scala 163:{110,110}]
  wire  _GEN_95 = 5'h13 == cond_idx ? cache_valid_19 : _GEN_94; // @[SE.scala 163:{110,110}]
  wire  _GEN_96 = 5'h14 == cond_idx ? cache_valid_20 : _GEN_95; // @[SE.scala 163:{110,110}]
  wire  _GEN_97 = 5'h15 == cond_idx ? cache_valid_21 : _GEN_96; // @[SE.scala 163:{110,110}]
  wire  _GEN_98 = 5'h16 == cond_idx ? cache_valid_22 : _GEN_97; // @[SE.scala 163:{110,110}]
  wire  _GEN_99 = 5'h17 == cond_idx ? cache_valid_23 : _GEN_98; // @[SE.scala 163:{110,110}]
  wire  _GEN_100 = 5'h18 == cond_idx ? cache_valid_24 : _GEN_99; // @[SE.scala 163:{110,110}]
  wire  _GEN_101 = 5'h19 == cond_idx ? cache_valid_25 : _GEN_100; // @[SE.scala 163:{110,110}]
  wire  _GEN_102 = 5'h1a == cond_idx ? cache_valid_26 : _GEN_101; // @[SE.scala 163:{110,110}]
  wire  _GEN_103 = 5'h1b == cond_idx ? cache_valid_27 : _GEN_102; // @[SE.scala 163:{110,110}]
  wire  _GEN_104 = 5'h1c == cond_idx ? cache_valid_28 : _GEN_103; // @[SE.scala 163:{110,110}]
  wire  _GEN_105 = 5'h1d == cond_idx ? cache_valid_29 : _GEN_104; // @[SE.scala 163:{110,110}]
  wire  _GEN_106 = 5'h1e == cond_idx ? cache_valid_30 : _GEN_105; // @[SE.scala 163:{110,110}]
  wire  _GEN_107 = 5'h1f == cond_idx ? cache_valid_31 : _GEN_106; // @[SE.scala 163:{110,110}]
  wire  all_match = op1_found & op2_found & cond_found & _GEN_43 & _GEN_75 & _GEN_107; // @[SE.scala 163:110]
  wire  n_stage_valid = all_match | valid_buffer; // @[SE.scala 177:36]
  wire  _valid_buffer_T_1 = n_stage_valid ? 1'h0 : valid_buffer; // @[SE.scala 120:68]
  wire  _GEN_9 = _T_1 | ready_for_input; // @[SE.scala 123:49 124:33 116:38]
  wire  _GEN_10 = _T ? 1'h0 : _GEN_9; // @[SE.scala 121:41 122:33]
  wire  _T_56 = ~reset; // @[SE.scala 174:23]
  reg [7:0] mid_inst_buffer; // @[Reg.scala 16:16]
  reg [127:0] mid_op1_buffer; // @[Reg.scala 16:16]
  wire  _seoperation_io_inst_T = all_match & valid_buffer; // @[SE.scala 193:45]
  wire  seOpValid = aes_invcipher_io_output_valid | _seoperation_io_inst_T; // @[SE.scala 194:55]
  wire [7:0] op1_reverse_1 = aes_invcipher_io_output_op1_14; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_0 = aes_invcipher_io_output_op1_15; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_3 = aes_invcipher_io_output_op1_12; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_2 = aes_invcipher_io_output_op1_13; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_5 = aes_invcipher_io_output_op1_10; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_4 = aes_invcipher_io_output_op1_11; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_7 = aes_invcipher_io_output_op1_8; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_6 = aes_invcipher_io_output_op1_9; // @[SE.scala 180:31 184:32]
  wire [63:0] op1_asUInt_lo = {op1_reverse_7,op1_reverse_6,op1_reverse_5,op1_reverse_4,op1_reverse_3,op1_reverse_2,
    op1_reverse_1,op1_reverse_0}; // @[SE.scala 196:38]
  wire [7:0] op1_reverse_9 = aes_invcipher_io_output_op1_6; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_8 = aes_invcipher_io_output_op1_7; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_11 = aes_invcipher_io_output_op1_4; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_10 = aes_invcipher_io_output_op1_5; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_13 = aes_invcipher_io_output_op1_2; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_12 = aes_invcipher_io_output_op1_3; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_15 = aes_invcipher_io_output_op1_0; // @[SE.scala 180:31 184:32]
  wire [7:0] op1_reverse_14 = aes_invcipher_io_output_op1_1; // @[SE.scala 180:31 184:32]
  wire [127:0] op1_asUInt = {op1_reverse_15,op1_reverse_14,op1_reverse_13,op1_reverse_12,op1_reverse_11,op1_reverse_10,
    op1_reverse_9,op1_reverse_8,op1_asUInt_lo}; // @[SE.scala 196:38]
  wire [7:0] op2_reverse_1 = aes_invcipher_io_output_op2_14; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_0 = aes_invcipher_io_output_op2_15; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_3 = aes_invcipher_io_output_op2_12; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_2 = aes_invcipher_io_output_op2_13; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_5 = aes_invcipher_io_output_op2_10; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_4 = aes_invcipher_io_output_op2_11; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_7 = aes_invcipher_io_output_op2_8; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_6 = aes_invcipher_io_output_op2_9; // @[SE.scala 181:31 185:32]
  wire [63:0] op2_asUInt_lo = {op2_reverse_7,op2_reverse_6,op2_reverse_5,op2_reverse_4,op2_reverse_3,op2_reverse_2,
    op2_reverse_1,op2_reverse_0}; // @[SE.scala 197:38]
  wire [7:0] op2_reverse_9 = aes_invcipher_io_output_op2_6; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_8 = aes_invcipher_io_output_op2_7; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_11 = aes_invcipher_io_output_op2_4; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_10 = aes_invcipher_io_output_op2_5; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_13 = aes_invcipher_io_output_op2_2; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_12 = aes_invcipher_io_output_op2_3; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_15 = aes_invcipher_io_output_op2_0; // @[SE.scala 181:31 185:32]
  wire [7:0] op2_reverse_14 = aes_invcipher_io_output_op2_1; // @[SE.scala 181:31 185:32]
  wire [127:0] op2_asUInt = {op2_reverse_15,op2_reverse_14,op2_reverse_13,op2_reverse_12,op2_reverse_11,op2_reverse_10,
    op2_reverse_9,op2_reverse_8,op2_asUInt_lo}; // @[SE.scala 197:38]
  wire [7:0] cond_reverse_1 = aes_invcipher_io_output_cond_14; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_0 = aes_invcipher_io_output_cond_15; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_3 = aes_invcipher_io_output_cond_12; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_2 = aes_invcipher_io_output_cond_13; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_5 = aes_invcipher_io_output_cond_10; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_4 = aes_invcipher_io_output_cond_11; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_7 = aes_invcipher_io_output_cond_8; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_6 = aes_invcipher_io_output_cond_9; // @[SE.scala 182:32 186:33]
  wire [63:0] cond_asUInt_lo = {cond_reverse_7,cond_reverse_6,cond_reverse_5,cond_reverse_4,cond_reverse_3,
    cond_reverse_2,cond_reverse_1,cond_reverse_0}; // @[SE.scala 198:40]
  wire [7:0] cond_reverse_9 = aes_invcipher_io_output_cond_6; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_8 = aes_invcipher_io_output_cond_7; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_11 = aes_invcipher_io_output_cond_4; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_10 = aes_invcipher_io_output_cond_5; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_13 = aes_invcipher_io_output_cond_2; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_12 = aes_invcipher_io_output_cond_3; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_15 = aes_invcipher_io_output_cond_0; // @[SE.scala 182:32 186:33]
  wire [7:0] cond_reverse_14 = aes_invcipher_io_output_cond_1; // @[SE.scala 182:32 186:33]
  wire [127:0] cond_asUInt = {cond_reverse_15,cond_reverse_14,cond_reverse_13,cond_reverse_12,cond_reverse_11,
    cond_reverse_10,cond_reverse_9,cond_reverse_8,cond_asUInt_lo}; // @[SE.scala 198:40]
  wire [63:0] _seoperation_io_op1_input_T_5 = mid_inst_buffer[7:5] == 3'h5 ? mid_op1_buffer[127:64] : op1_asUInt[127:64]
    ; // @[SE.scala 218:79]
  wire [63:0] _GEN_111 = 5'h1 == op1_idx ? plaintexts_1 : plaintexts_0; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_112 = 5'h2 == op1_idx ? plaintexts_2 : _GEN_111; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_113 = 5'h3 == op1_idx ? plaintexts_3 : _GEN_112; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_114 = 5'h4 == op1_idx ? plaintexts_4 : _GEN_113; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_115 = 5'h5 == op1_idx ? plaintexts_5 : _GEN_114; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_116 = 5'h6 == op1_idx ? plaintexts_6 : _GEN_115; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_117 = 5'h7 == op1_idx ? plaintexts_7 : _GEN_116; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_118 = 5'h8 == op1_idx ? plaintexts_8 : _GEN_117; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_119 = 5'h9 == op1_idx ? plaintexts_9 : _GEN_118; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_120 = 5'ha == op1_idx ? plaintexts_10 : _GEN_119; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_121 = 5'hb == op1_idx ? plaintexts_11 : _GEN_120; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_122 = 5'hc == op1_idx ? plaintexts_12 : _GEN_121; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_123 = 5'hd == op1_idx ? plaintexts_13 : _GEN_122; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_124 = 5'he == op1_idx ? plaintexts_14 : _GEN_123; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_125 = 5'hf == op1_idx ? plaintexts_15 : _GEN_124; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_126 = 5'h10 == op1_idx ? plaintexts_16 : _GEN_125; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_127 = 5'h11 == op1_idx ? plaintexts_17 : _GEN_126; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_128 = 5'h12 == op1_idx ? plaintexts_18 : _GEN_127; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_129 = 5'h13 == op1_idx ? plaintexts_19 : _GEN_128; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_130 = 5'h14 == op1_idx ? plaintexts_20 : _GEN_129; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_131 = 5'h15 == op1_idx ? plaintexts_21 : _GEN_130; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_132 = 5'h16 == op1_idx ? plaintexts_22 : _GEN_131; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_133 = 5'h17 == op1_idx ? plaintexts_23 : _GEN_132; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_134 = 5'h18 == op1_idx ? plaintexts_24 : _GEN_133; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_135 = 5'h19 == op1_idx ? plaintexts_25 : _GEN_134; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_136 = 5'h1a == op1_idx ? plaintexts_26 : _GEN_135; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_137 = 5'h1b == op1_idx ? plaintexts_27 : _GEN_136; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_138 = 5'h1c == op1_idx ? plaintexts_28 : _GEN_137; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_139 = 5'h1d == op1_idx ? plaintexts_29 : _GEN_138; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_140 = 5'h1e == op1_idx ? plaintexts_30 : _GEN_139; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_141 = 5'h1f == op1_idx ? plaintexts_31 : _GEN_140; // @[SE.scala 218:{40,40}]
  wire [63:0] _GEN_143 = 5'h1 == op2_idx ? plaintexts_1 : plaintexts_0; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_144 = 5'h2 == op2_idx ? plaintexts_2 : _GEN_143; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_145 = 5'h3 == op2_idx ? plaintexts_3 : _GEN_144; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_146 = 5'h4 == op2_idx ? plaintexts_4 : _GEN_145; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_147 = 5'h5 == op2_idx ? plaintexts_5 : _GEN_146; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_148 = 5'h6 == op2_idx ? plaintexts_6 : _GEN_147; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_149 = 5'h7 == op2_idx ? plaintexts_7 : _GEN_148; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_150 = 5'h8 == op2_idx ? plaintexts_8 : _GEN_149; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_151 = 5'h9 == op2_idx ? plaintexts_9 : _GEN_150; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_152 = 5'ha == op2_idx ? plaintexts_10 : _GEN_151; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_153 = 5'hb == op2_idx ? plaintexts_11 : _GEN_152; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_154 = 5'hc == op2_idx ? plaintexts_12 : _GEN_153; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_155 = 5'hd == op2_idx ? plaintexts_13 : _GEN_154; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_156 = 5'he == op2_idx ? plaintexts_14 : _GEN_155; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_157 = 5'hf == op2_idx ? plaintexts_15 : _GEN_156; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_158 = 5'h10 == op2_idx ? plaintexts_16 : _GEN_157; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_159 = 5'h11 == op2_idx ? plaintexts_17 : _GEN_158; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_160 = 5'h12 == op2_idx ? plaintexts_18 : _GEN_159; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_161 = 5'h13 == op2_idx ? plaintexts_19 : _GEN_160; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_162 = 5'h14 == op2_idx ? plaintexts_20 : _GEN_161; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_163 = 5'h15 == op2_idx ? plaintexts_21 : _GEN_162; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_164 = 5'h16 == op2_idx ? plaintexts_22 : _GEN_163; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_165 = 5'h17 == op2_idx ? plaintexts_23 : _GEN_164; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_166 = 5'h18 == op2_idx ? plaintexts_24 : _GEN_165; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_167 = 5'h19 == op2_idx ? plaintexts_25 : _GEN_166; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_168 = 5'h1a == op2_idx ? plaintexts_26 : _GEN_167; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_169 = 5'h1b == op2_idx ? plaintexts_27 : _GEN_168; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_170 = 5'h1c == op2_idx ? plaintexts_28 : _GEN_169; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_171 = 5'h1d == op2_idx ? plaintexts_29 : _GEN_170; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_172 = 5'h1e == op2_idx ? plaintexts_30 : _GEN_171; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_173 = 5'h1f == op2_idx ? plaintexts_31 : _GEN_172; // @[SE.scala 219:{40,40}]
  wire [63:0] _GEN_175 = 5'h1 == cond_idx ? plaintexts_1 : plaintexts_0; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_176 = 5'h2 == cond_idx ? plaintexts_2 : _GEN_175; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_177 = 5'h3 == cond_idx ? plaintexts_3 : _GEN_176; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_178 = 5'h4 == cond_idx ? plaintexts_4 : _GEN_177; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_179 = 5'h5 == cond_idx ? plaintexts_5 : _GEN_178; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_180 = 5'h6 == cond_idx ? plaintexts_6 : _GEN_179; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_181 = 5'h7 == cond_idx ? plaintexts_7 : _GEN_180; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_182 = 5'h8 == cond_idx ? plaintexts_8 : _GEN_181; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_183 = 5'h9 == cond_idx ? plaintexts_9 : _GEN_182; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_184 = 5'ha == cond_idx ? plaintexts_10 : _GEN_183; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_185 = 5'hb == cond_idx ? plaintexts_11 : _GEN_184; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_186 = 5'hc == cond_idx ? plaintexts_12 : _GEN_185; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_187 = 5'hd == cond_idx ? plaintexts_13 : _GEN_186; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_188 = 5'he == cond_idx ? plaintexts_14 : _GEN_187; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_189 = 5'hf == cond_idx ? plaintexts_15 : _GEN_188; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_190 = 5'h10 == cond_idx ? plaintexts_16 : _GEN_189; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_191 = 5'h11 == cond_idx ? plaintexts_17 : _GEN_190; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_192 = 5'h12 == cond_idx ? plaintexts_18 : _GEN_191; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_193 = 5'h13 == cond_idx ? plaintexts_19 : _GEN_192; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_194 = 5'h14 == cond_idx ? plaintexts_20 : _GEN_193; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_195 = 5'h15 == cond_idx ? plaintexts_21 : _GEN_194; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_196 = 5'h16 == cond_idx ? plaintexts_22 : _GEN_195; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_197 = 5'h17 == cond_idx ? plaintexts_23 : _GEN_196; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_198 = 5'h18 == cond_idx ? plaintexts_24 : _GEN_197; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_199 = 5'h19 == cond_idx ? plaintexts_25 : _GEN_198; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_200 = 5'h1a == cond_idx ? plaintexts_26 : _GEN_199; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_201 = 5'h1b == cond_idx ? plaintexts_27 : _GEN_200; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_202 = 5'h1c == cond_idx ? plaintexts_28 : _GEN_201; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_203 = 5'h1d == cond_idx ? plaintexts_29 : _GEN_202; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_204 = 5'h1e == cond_idx ? plaintexts_30 : _GEN_203; // @[SE.scala 220:{41,41}]
  wire [63:0] _GEN_205 = 5'h1f == cond_idx ? plaintexts_31 : _GEN_204; // @[SE.scala 220:{41,41}]
  reg  result_valid_buffer; // @[SE.scala 223:42]
  wire  _n_result_valid_buffer_T = aes_cipher_io_input_valid ? 1'h0 : result_valid_buffer; // @[SE.scala 224:60]
  wire [7:0] bit64_randnum_lo_lo_lo = {bit64_randnum_prng_io_out_7,bit64_randnum_prng_io_out_6,
    bit64_randnum_prng_io_out_5,bit64_randnum_prng_io_out_4,bit64_randnum_prng_io_out_3,bit64_randnum_prng_io_out_2,
    bit64_randnum_prng_io_out_1,bit64_randnum_prng_io_out_0}; // @[PRNG.scala 95:17]
  wire [15:0] bit64_randnum_lo_lo = {bit64_randnum_prng_io_out_15,bit64_randnum_prng_io_out_14,
    bit64_randnum_prng_io_out_13,bit64_randnum_prng_io_out_12,bit64_randnum_prng_io_out_11,bit64_randnum_prng_io_out_10,
    bit64_randnum_prng_io_out_9,bit64_randnum_prng_io_out_8,bit64_randnum_lo_lo_lo}; // @[PRNG.scala 95:17]
  wire [7:0] bit64_randnum_lo_hi_lo = {bit64_randnum_prng_io_out_23,bit64_randnum_prng_io_out_22,
    bit64_randnum_prng_io_out_21,bit64_randnum_prng_io_out_20,bit64_randnum_prng_io_out_19,bit64_randnum_prng_io_out_18,
    bit64_randnum_prng_io_out_17,bit64_randnum_prng_io_out_16}; // @[PRNG.scala 95:17]
  wire [31:0] bit64_randnum_lo = {bit64_randnum_prng_io_out_31,bit64_randnum_prng_io_out_30,bit64_randnum_prng_io_out_29
    ,bit64_randnum_prng_io_out_28,bit64_randnum_prng_io_out_27,bit64_randnum_prng_io_out_26,bit64_randnum_prng_io_out_25
    ,bit64_randnum_prng_io_out_24,bit64_randnum_lo_hi_lo,bit64_randnum_lo_lo}; // @[PRNG.scala 95:17]
  wire [7:0] bit64_randnum_hi_lo_lo = {bit64_randnum_prng_io_out_39,bit64_randnum_prng_io_out_38,
    bit64_randnum_prng_io_out_37,bit64_randnum_prng_io_out_36,bit64_randnum_prng_io_out_35,bit64_randnum_prng_io_out_34,
    bit64_randnum_prng_io_out_33,bit64_randnum_prng_io_out_32}; // @[PRNG.scala 95:17]
  wire [15:0] bit64_randnum_hi_lo = {bit64_randnum_prng_io_out_47,bit64_randnum_prng_io_out_46,
    bit64_randnum_prng_io_out_45,bit64_randnum_prng_io_out_44,bit64_randnum_prng_io_out_43,bit64_randnum_prng_io_out_42,
    bit64_randnum_prng_io_out_41,bit64_randnum_prng_io_out_40,bit64_randnum_hi_lo_lo}; // @[PRNG.scala 95:17]
  wire [7:0] bit64_randnum_hi_hi_lo = {bit64_randnum_prng_io_out_55,bit64_randnum_prng_io_out_54,
    bit64_randnum_prng_io_out_53,bit64_randnum_prng_io_out_52,bit64_randnum_prng_io_out_51,bit64_randnum_prng_io_out_50,
    bit64_randnum_prng_io_out_49,bit64_randnum_prng_io_out_48}; // @[PRNG.scala 95:17]
  wire [31:0] bit64_randnum_hi = {bit64_randnum_prng_io_out_63,bit64_randnum_prng_io_out_62,bit64_randnum_prng_io_out_61
    ,bit64_randnum_prng_io_out_60,bit64_randnum_prng_io_out_59,bit64_randnum_prng_io_out_58,bit64_randnum_prng_io_out_57
    ,bit64_randnum_prng_io_out_56,bit64_randnum_hi_hi_lo,bit64_randnum_hi_lo}; // @[PRNG.scala 95:17]
  wire [127:0] padded_result = {seoperation_io_result,bit64_randnum_hi,bit64_randnum_lo}; // @[Cat.scala 31:58]
  reg [127:0] result_buffer; // @[Reg.scala 16:16]
  reg [63:0] result_plaintext_buffer; // @[SE.scala 237:46]
  wire [63:0] output_buffer_lo = {aes_cipher_io_output_text_7,aes_cipher_io_output_text_6,aes_cipher_io_output_text_5,
    aes_cipher_io_output_text_4,aes_cipher_io_output_text_3,aes_cipher_io_output_text_2,aes_cipher_io_output_text_1,
    aes_cipher_io_output_text_0}; // @[SE.scala 253:65]
  wire [127:0] _output_buffer_T = {aes_cipher_io_output_text_15,aes_cipher_io_output_text_14,
    aes_cipher_io_output_text_13,aes_cipher_io_output_text_12,aes_cipher_io_output_text_11,aes_cipher_io_output_text_10,
    aes_cipher_io_output_text_9,aes_cipher_io_output_text_8,output_buffer_lo}; // @[SE.scala 253:65]
  reg [127:0] output_buffer; // @[Reg.scala 16:16]
  reg  output_valid; // @[SE.scala 254:35]
  wire  _GEN_209 = _T_1 ? 1'h0 : output_valid; // @[SE.scala 258:49 259:30 254:35]
  wire  _GEN_210 = aes_cipher_io_output_valid | _GEN_209; // @[SE.scala 256:41 257:30]
  wire [7:0] _ptr_T_1 = ptr + 8'h1; // @[SE.scala 269:36]
  wire  _GEN_277 = 5'h0 == ptr[4:0] | cache_valid_0; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_278 = 5'h1 == ptr[4:0] | cache_valid_1; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_279 = 5'h2 == ptr[4:0] | cache_valid_2; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_280 = 5'h3 == ptr[4:0] | cache_valid_3; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_281 = 5'h4 == ptr[4:0] | cache_valid_4; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_282 = 5'h5 == ptr[4:0] | cache_valid_5; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_283 = 5'h6 == ptr[4:0] | cache_valid_6; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_284 = 5'h7 == ptr[4:0] | cache_valid_7; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_285 = 5'h8 == ptr[4:0] | cache_valid_8; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_286 = 5'h9 == ptr[4:0] | cache_valid_9; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_287 = 5'ha == ptr[4:0] | cache_valid_10; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_288 = 5'hb == ptr[4:0] | cache_valid_11; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_289 = 5'hc == ptr[4:0] | cache_valid_12; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_290 = 5'hd == ptr[4:0] | cache_valid_13; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_291 = 5'he == ptr[4:0] | cache_valid_14; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_292 = 5'hf == ptr[4:0] | cache_valid_15; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_293 = 5'h10 == ptr[4:0] | cache_valid_16; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_294 = 5'h11 == ptr[4:0] | cache_valid_17; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_295 = 5'h12 == ptr[4:0] | cache_valid_18; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_296 = 5'h13 == ptr[4:0] | cache_valid_19; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_297 = 5'h14 == ptr[4:0] | cache_valid_20; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_298 = 5'h15 == ptr[4:0] | cache_valid_21; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_299 = 5'h16 == ptr[4:0] | cache_valid_22; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_300 = 5'h17 == ptr[4:0] | cache_valid_23; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_301 = 5'h18 == ptr[4:0] | cache_valid_24; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_302 = 5'h19 == ptr[4:0] | cache_valid_25; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_303 = 5'h1a == ptr[4:0] | cache_valid_26; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_304 = 5'h1b == ptr[4:0] | cache_valid_27; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_305 = 5'h1c == ptr[4:0] | cache_valid_28; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_306 = 5'h1d == ptr[4:0] | cache_valid_29; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_307 = 5'h1e == ptr[4:0] | cache_valid_30; // @[SE.scala 283:{42,42} 67:30]
  wire  _GEN_308 = 5'h1f == ptr[4:0] | cache_valid_31; // @[SE.scala 283:{42,42} 67:30]
  SEOperation seoperation ( // @[SE.scala 61:33]
    .io_inst(seoperation_io_inst),
    .io_op1_input(seoperation_io_op1_input),
    .io_op2_input(seoperation_io_op2_input),
    .io_cond_input(seoperation_io_cond_input),
    .io_result(seoperation_io_result)
  );
  RSADecrypt aes_invcipher ( // @[SE.scala 62:35]
    .clock(aes_invcipher_clock),
    .reset(aes_invcipher_reset),
    .io_input_valid(aes_invcipher_io_input_valid),
    .io_p(aes_invcipher_io_p),
    .io_q(aes_invcipher_io_q),
    .io_input_op1_0(aes_invcipher_io_input_op1_0),
    .io_input_op1_1(aes_invcipher_io_input_op1_1),
    .io_input_op1_2(aes_invcipher_io_input_op1_2),
    .io_input_op1_3(aes_invcipher_io_input_op1_3),
    .io_input_op1_4(aes_invcipher_io_input_op1_4),
    .io_input_op1_5(aes_invcipher_io_input_op1_5),
    .io_input_op1_6(aes_invcipher_io_input_op1_6),
    .io_input_op1_7(aes_invcipher_io_input_op1_7),
    .io_input_op1_8(aes_invcipher_io_input_op1_8),
    .io_input_op1_9(aes_invcipher_io_input_op1_9),
    .io_input_op1_10(aes_invcipher_io_input_op1_10),
    .io_input_op1_11(aes_invcipher_io_input_op1_11),
    .io_input_op1_12(aes_invcipher_io_input_op1_12),
    .io_input_op1_13(aes_invcipher_io_input_op1_13),
    .io_input_op1_14(aes_invcipher_io_input_op1_14),
    .io_input_op1_15(aes_invcipher_io_input_op1_15),
    .io_input_op2_0(aes_invcipher_io_input_op2_0),
    .io_input_op2_1(aes_invcipher_io_input_op2_1),
    .io_input_op2_2(aes_invcipher_io_input_op2_2),
    .io_input_op2_3(aes_invcipher_io_input_op2_3),
    .io_input_op2_4(aes_invcipher_io_input_op2_4),
    .io_input_op2_5(aes_invcipher_io_input_op2_5),
    .io_input_op2_6(aes_invcipher_io_input_op2_6),
    .io_input_op2_7(aes_invcipher_io_input_op2_7),
    .io_input_op2_8(aes_invcipher_io_input_op2_8),
    .io_input_op2_9(aes_invcipher_io_input_op2_9),
    .io_input_op2_10(aes_invcipher_io_input_op2_10),
    .io_input_op2_11(aes_invcipher_io_input_op2_11),
    .io_input_op2_12(aes_invcipher_io_input_op2_12),
    .io_input_op2_13(aes_invcipher_io_input_op2_13),
    .io_input_op2_14(aes_invcipher_io_input_op2_14),
    .io_input_op2_15(aes_invcipher_io_input_op2_15),
    .io_input_cond_0(aes_invcipher_io_input_cond_0),
    .io_input_cond_1(aes_invcipher_io_input_cond_1),
    .io_input_cond_2(aes_invcipher_io_input_cond_2),
    .io_input_cond_3(aes_invcipher_io_input_cond_3),
    .io_input_cond_4(aes_invcipher_io_input_cond_4),
    .io_input_cond_5(aes_invcipher_io_input_cond_5),
    .io_input_cond_6(aes_invcipher_io_input_cond_6),
    .io_input_cond_7(aes_invcipher_io_input_cond_7),
    .io_input_cond_8(aes_invcipher_io_input_cond_8),
    .io_input_cond_9(aes_invcipher_io_input_cond_9),
    .io_input_cond_10(aes_invcipher_io_input_cond_10),
    .io_input_cond_11(aes_invcipher_io_input_cond_11),
    .io_input_cond_12(aes_invcipher_io_input_cond_12),
    .io_input_cond_13(aes_invcipher_io_input_cond_13),
    .io_input_cond_14(aes_invcipher_io_input_cond_14),
    .io_input_cond_15(aes_invcipher_io_input_cond_15),
    .io_output_op1_0(aes_invcipher_io_output_op1_0),
    .io_output_op1_1(aes_invcipher_io_output_op1_1),
    .io_output_op1_2(aes_invcipher_io_output_op1_2),
    .io_output_op1_3(aes_invcipher_io_output_op1_3),
    .io_output_op1_4(aes_invcipher_io_output_op1_4),
    .io_output_op1_5(aes_invcipher_io_output_op1_5),
    .io_output_op1_6(aes_invcipher_io_output_op1_6),
    .io_output_op1_7(aes_invcipher_io_output_op1_7),
    .io_output_op1_8(aes_invcipher_io_output_op1_8),
    .io_output_op1_9(aes_invcipher_io_output_op1_9),
    .io_output_op1_10(aes_invcipher_io_output_op1_10),
    .io_output_op1_11(aes_invcipher_io_output_op1_11),
    .io_output_op1_12(aes_invcipher_io_output_op1_12),
    .io_output_op1_13(aes_invcipher_io_output_op1_13),
    .io_output_op1_14(aes_invcipher_io_output_op1_14),
    .io_output_op1_15(aes_invcipher_io_output_op1_15),
    .io_output_op2_0(aes_invcipher_io_output_op2_0),
    .io_output_op2_1(aes_invcipher_io_output_op2_1),
    .io_output_op2_2(aes_invcipher_io_output_op2_2),
    .io_output_op2_3(aes_invcipher_io_output_op2_3),
    .io_output_op2_4(aes_invcipher_io_output_op2_4),
    .io_output_op2_5(aes_invcipher_io_output_op2_5),
    .io_output_op2_6(aes_invcipher_io_output_op2_6),
    .io_output_op2_7(aes_invcipher_io_output_op2_7),
    .io_output_op2_8(aes_invcipher_io_output_op2_8),
    .io_output_op2_9(aes_invcipher_io_output_op2_9),
    .io_output_op2_10(aes_invcipher_io_output_op2_10),
    .io_output_op2_11(aes_invcipher_io_output_op2_11),
    .io_output_op2_12(aes_invcipher_io_output_op2_12),
    .io_output_op2_13(aes_invcipher_io_output_op2_13),
    .io_output_op2_14(aes_invcipher_io_output_op2_14),
    .io_output_op2_15(aes_invcipher_io_output_op2_15),
    .io_output_cond_0(aes_invcipher_io_output_cond_0),
    .io_output_cond_1(aes_invcipher_io_output_cond_1),
    .io_output_cond_2(aes_invcipher_io_output_cond_2),
    .io_output_cond_3(aes_invcipher_io_output_cond_3),
    .io_output_cond_4(aes_invcipher_io_output_cond_4),
    .io_output_cond_5(aes_invcipher_io_output_cond_5),
    .io_output_cond_6(aes_invcipher_io_output_cond_6),
    .io_output_cond_7(aes_invcipher_io_output_cond_7),
    .io_output_cond_8(aes_invcipher_io_output_cond_8),
    .io_output_cond_9(aes_invcipher_io_output_cond_9),
    .io_output_cond_10(aes_invcipher_io_output_cond_10),
    .io_output_cond_11(aes_invcipher_io_output_cond_11),
    .io_output_cond_12(aes_invcipher_io_output_cond_12),
    .io_output_cond_13(aes_invcipher_io_output_cond_13),
    .io_output_cond_14(aes_invcipher_io_output_cond_14),
    .io_output_cond_15(aes_invcipher_io_output_cond_15),
    .io_output_valid(aes_invcipher_io_output_valid)
  );
  RSAEncrypt aes_cipher ( // @[SE.scala 63:32]
    .clock(aes_cipher_clock),
    .reset(aes_cipher_reset),
    .io_input_valid(aes_cipher_io_input_valid),
    .io_p(aes_cipher_io_p),
    .io_q(aes_cipher_io_q),
    .io_input_text_0(aes_cipher_io_input_text_0),
    .io_input_text_1(aes_cipher_io_input_text_1),
    .io_input_text_2(aes_cipher_io_input_text_2),
    .io_input_text_3(aes_cipher_io_input_text_3),
    .io_input_text_4(aes_cipher_io_input_text_4),
    .io_input_text_5(aes_cipher_io_input_text_5),
    .io_input_text_6(aes_cipher_io_input_text_6),
    .io_input_text_7(aes_cipher_io_input_text_7),
    .io_input_text_8(aes_cipher_io_input_text_8),
    .io_input_text_9(aes_cipher_io_input_text_9),
    .io_input_text_10(aes_cipher_io_input_text_10),
    .io_input_text_11(aes_cipher_io_input_text_11),
    .io_input_text_12(aes_cipher_io_input_text_12),
    .io_input_text_13(aes_cipher_io_input_text_13),
    .io_input_text_14(aes_cipher_io_input_text_14),
    .io_input_text_15(aes_cipher_io_input_text_15),
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
  MaxPeriodFibonacciLFSR bit64_randnum_prng ( // @[PRNG.scala 91:22]
    .clock(bit64_randnum_prng_clock),
    .reset(bit64_randnum_prng_reset),
    .io_out_0(bit64_randnum_prng_io_out_0),
    .io_out_1(bit64_randnum_prng_io_out_1),
    .io_out_2(bit64_randnum_prng_io_out_2),
    .io_out_3(bit64_randnum_prng_io_out_3),
    .io_out_4(bit64_randnum_prng_io_out_4),
    .io_out_5(bit64_randnum_prng_io_out_5),
    .io_out_6(bit64_randnum_prng_io_out_6),
    .io_out_7(bit64_randnum_prng_io_out_7),
    .io_out_8(bit64_randnum_prng_io_out_8),
    .io_out_9(bit64_randnum_prng_io_out_9),
    .io_out_10(bit64_randnum_prng_io_out_10),
    .io_out_11(bit64_randnum_prng_io_out_11),
    .io_out_12(bit64_randnum_prng_io_out_12),
    .io_out_13(bit64_randnum_prng_io_out_13),
    .io_out_14(bit64_randnum_prng_io_out_14),
    .io_out_15(bit64_randnum_prng_io_out_15),
    .io_out_16(bit64_randnum_prng_io_out_16),
    .io_out_17(bit64_randnum_prng_io_out_17),
    .io_out_18(bit64_randnum_prng_io_out_18),
    .io_out_19(bit64_randnum_prng_io_out_19),
    .io_out_20(bit64_randnum_prng_io_out_20),
    .io_out_21(bit64_randnum_prng_io_out_21),
    .io_out_22(bit64_randnum_prng_io_out_22),
    .io_out_23(bit64_randnum_prng_io_out_23),
    .io_out_24(bit64_randnum_prng_io_out_24),
    .io_out_25(bit64_randnum_prng_io_out_25),
    .io_out_26(bit64_randnum_prng_io_out_26),
    .io_out_27(bit64_randnum_prng_io_out_27),
    .io_out_28(bit64_randnum_prng_io_out_28),
    .io_out_29(bit64_randnum_prng_io_out_29),
    .io_out_30(bit64_randnum_prng_io_out_30),
    .io_out_31(bit64_randnum_prng_io_out_31),
    .io_out_32(bit64_randnum_prng_io_out_32),
    .io_out_33(bit64_randnum_prng_io_out_33),
    .io_out_34(bit64_randnum_prng_io_out_34),
    .io_out_35(bit64_randnum_prng_io_out_35),
    .io_out_36(bit64_randnum_prng_io_out_36),
    .io_out_37(bit64_randnum_prng_io_out_37),
    .io_out_38(bit64_randnum_prng_io_out_38),
    .io_out_39(bit64_randnum_prng_io_out_39),
    .io_out_40(bit64_randnum_prng_io_out_40),
    .io_out_41(bit64_randnum_prng_io_out_41),
    .io_out_42(bit64_randnum_prng_io_out_42),
    .io_out_43(bit64_randnum_prng_io_out_43),
    .io_out_44(bit64_randnum_prng_io_out_44),
    .io_out_45(bit64_randnum_prng_io_out_45),
    .io_out_46(bit64_randnum_prng_io_out_46),
    .io_out_47(bit64_randnum_prng_io_out_47),
    .io_out_48(bit64_randnum_prng_io_out_48),
    .io_out_49(bit64_randnum_prng_io_out_49),
    .io_out_50(bit64_randnum_prng_io_out_50),
    .io_out_51(bit64_randnum_prng_io_out_51),
    .io_out_52(bit64_randnum_prng_io_out_52),
    .io_out_53(bit64_randnum_prng_io_out_53),
    .io_out_54(bit64_randnum_prng_io_out_54),
    .io_out_55(bit64_randnum_prng_io_out_55),
    .io_out_56(bit64_randnum_prng_io_out_56),
    .io_out_57(bit64_randnum_prng_io_out_57),
    .io_out_58(bit64_randnum_prng_io_out_58),
    .io_out_59(bit64_randnum_prng_io_out_59),
    .io_out_60(bit64_randnum_prng_io_out_60),
    .io_out_61(bit64_randnum_prng_io_out_61),
    .io_out_62(bit64_randnum_prng_io_out_62),
    .io_out_63(bit64_randnum_prng_io_out_63)
  );
  assign io_in_ready = ready_for_input; // @[SE.scala 118:21]
  assign io_out_result = output_buffer; // @[SE.scala 262:23]
  assign io_out_valid = output_valid; // @[SE.scala 261:22]
  assign io_out_cntr = {{1'd0}, value}; // @[SE.scala 56:21]
  assign seoperation_io_inst = all_match & valid_buffer ? inst_buffer : mid_inst_buffer; // @[SE.scala 193:35]
  assign seoperation_io_op1_input = _seoperation_io_inst_T ? _GEN_141 : _seoperation_io_op1_input_T_5; // @[SE.scala 218:40]
  assign seoperation_io_op2_input = _seoperation_io_inst_T ? _GEN_173 : op2_asUInt[127:64]; // @[SE.scala 219:40]
  assign seoperation_io_cond_input = _seoperation_io_inst_T ? _GEN_205 : cond_asUInt[127:64]; // @[SE.scala 220:41]
  assign aes_invcipher_clock = clock;
  assign aes_invcipher_reset = reset;
  assign aes_invcipher_io_input_valid = valid_buffer & ~all_match; // @[SE.scala 172:54]
  assign aes_invcipher_io_p = p; // @[SE.scala 170:28]
  assign aes_invcipher_io_q = q; // @[SE.scala 171:28]
  assign aes_invcipher_io_input_op1_0 = op1_buffer[7:0]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_1 = op1_buffer[15:8]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_2 = op1_buffer[23:16]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_3 = op1_buffer[31:24]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_4 = op1_buffer[39:32]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_5 = op1_buffer[47:40]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_6 = op1_buffer[55:48]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_7 = op1_buffer[63:56]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_8 = op1_buffer[71:64]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_9 = op1_buffer[79:72]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_10 = op1_buffer[87:80]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_11 = op1_buffer[95:88]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_12 = op1_buffer[103:96]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_13 = op1_buffer[111:104]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_14 = op1_buffer[119:112]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op1_15 = op1_buffer[127:120]; // @[SE.scala 167:58]
  assign aes_invcipher_io_input_op2_0 = op2_buffer[7:0]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_1 = op2_buffer[15:8]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_2 = op2_buffer[23:16]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_3 = op2_buffer[31:24]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_4 = op2_buffer[39:32]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_5 = op2_buffer[47:40]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_6 = op2_buffer[55:48]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_7 = op2_buffer[63:56]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_8 = op2_buffer[71:64]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_9 = op2_buffer[79:72]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_10 = op2_buffer[87:80]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_11 = op2_buffer[95:88]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_12 = op2_buffer[103:96]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_13 = op2_buffer[111:104]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_14 = op2_buffer[119:112]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_op2_15 = op2_buffer[127:120]; // @[SE.scala 168:58]
  assign aes_invcipher_io_input_cond_0 = cond_buffer[7:0]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_1 = cond_buffer[15:8]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_2 = cond_buffer[23:16]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_3 = cond_buffer[31:24]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_4 = cond_buffer[39:32]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_5 = cond_buffer[47:40]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_6 = cond_buffer[55:48]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_7 = cond_buffer[63:56]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_8 = cond_buffer[71:64]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_9 = cond_buffer[79:72]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_10 = cond_buffer[87:80]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_11 = cond_buffer[95:88]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_12 = cond_buffer[103:96]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_13 = cond_buffer[111:104]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_14 = cond_buffer[119:112]; // @[SE.scala 169:60]
  assign aes_invcipher_io_input_cond_15 = cond_buffer[127:120]; // @[SE.scala 169:60]
  assign aes_cipher_clock = clock;
  assign aes_cipher_reset = reset;
  assign aes_cipher_io_input_valid = result_valid_buffer; // @[SE.scala 248:35]
  assign aes_cipher_io_p = p; // @[SE.scala 249:25]
  assign aes_cipher_io_q = q; // @[SE.scala 250:25]
  assign aes_cipher_io_input_text_0 = result_buffer[127:120]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_1 = result_buffer[119:112]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_2 = result_buffer[111:104]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_3 = result_buffer[103:96]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_4 = result_buffer[95:88]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_5 = result_buffer[87:80]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_6 = result_buffer[79:72]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_7 = result_buffer[71:64]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_8 = result_buffer[63:56]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_9 = result_buffer[55:48]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_10 = result_buffer[47:40]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_11 = result_buffer[39:32]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_12 = result_buffer[31:24]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_13 = result_buffer[23:16]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_14 = result_buffer[15:8]; // @[SE.scala 242:47]
  assign aes_cipher_io_input_text_15 = result_buffer[7:0]; // @[SE.scala 242:47]
  assign bit64_randnum_prng_clock = clock;
  assign bit64_randnum_prng_reset = reset;
  always @(posedge clock) begin
    if (reset) begin // @[SE.scala 42:32]
      counterOn <= 1'h0; // @[SE.scala 42:32]
    end else begin
      counterOn <= _GEN_3;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value <= 7'h0; // @[Counter.scala 62:40]
    end else if (_T_1) begin // @[SE.scala 53:43]
      value <= 7'h0; // @[Counter.scala 99:11]
    end else if (counterOn) begin // @[SE.scala 45:24]
      if (wrap) begin // @[Counter.scala 88:20]
        value <= 7'h0; // @[Counter.scala 88:28]
      end else begin
        value <= _value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_0 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h0 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_0 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_1 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_1 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_2 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h2 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_2 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_3 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h3 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_3 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_4 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h4 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_4 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_5 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h5 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_5 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_6 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h6 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_6 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_7 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h7 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_7 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_8 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h8 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_8 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_9 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h9 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_9 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_10 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'ha == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_10 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_11 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hb == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_11 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_12 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hc == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_12 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_13 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hd == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_13 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_14 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'he == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_14 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_15 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hf == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_15 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_16 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h10 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_16 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_17 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h11 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_17 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_18 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h12 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_18 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_19 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h13 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_19 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_20 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h14 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_20 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_21 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h15 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_21 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_22 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h16 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_22 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_23 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h17 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_23 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_24 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h18 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_24 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_25 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h19 == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_25 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_26 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1a == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_26 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_27 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1b == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_27 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_28 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1c == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_28 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_29 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1d == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_29 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_30 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1e == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_30 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      ciphers_31 <= 128'h0; // @[SE.scala 275:36]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1f == ptr[4:0]) begin // @[SE.scala 281:38]
        ciphers_31 <= output_buffer; // @[SE.scala 281:38]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_0 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_0 <= _GEN_277;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_1 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_1 <= _GEN_278;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_2 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_2 <= _GEN_279;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_3 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_3 <= _GEN_280;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_4 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_4 <= _GEN_281;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_5 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_5 <= _GEN_282;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_6 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_6 <= _GEN_283;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_7 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_7 <= _GEN_284;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_8 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_8 <= _GEN_285;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_9 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_9 <= _GEN_286;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_10 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_10 <= _GEN_287;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_11 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_11 <= _GEN_288;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_12 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_12 <= _GEN_289;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_13 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_13 <= _GEN_290;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_14 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_14 <= _GEN_291;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_15 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_15 <= _GEN_292;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_16 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_16 <= _GEN_293;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_17 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_17 <= _GEN_294;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_18 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_18 <= _GEN_295;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_19 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_19 <= _GEN_296;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_20 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_20 <= _GEN_297;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_21 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_21 <= _GEN_298;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_22 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_22 <= _GEN_299;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_23 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_23 <= _GEN_300;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_24 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_24 <= _GEN_301;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_25 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_25 <= _GEN_302;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_26 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_26 <= _GEN_303;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_27 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_27 <= _GEN_304;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_28 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_28 <= _GEN_305;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_29 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_29 <= _GEN_306;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_30 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_30 <= _GEN_307;
    end
    if (reset) begin // @[SE.scala 272:27]
      cache_valid_31 <= 1'h0; // @[SE.scala 277:40]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      cache_valid_31 <= _GEN_308;
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_0 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h0 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_0 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_1 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_1 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_2 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h2 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_2 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_3 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h3 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_3 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_4 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h4 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_4 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_5 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h5 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_5 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_6 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h6 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_6 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_7 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h7 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_7 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_8 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h8 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_8 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_9 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h9 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_9 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_10 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'ha == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_10 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_11 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hb == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_11 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_12 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hc == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_12 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_13 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hd == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_13 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_14 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'he == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_14 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_15 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'hf == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_15 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_16 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h10 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_16 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_17 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h11 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_17 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_18 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h12 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_18 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_19 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h13 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_19 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_20 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h14 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_20 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_21 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h15 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_21 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_22 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h16 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_22 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_23 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h17 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_23 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_24 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h18 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_24 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_25 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h19 == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_25 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_26 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1a == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_26 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_27 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1b == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_27 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_28 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1c == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_28 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_29 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1d == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_29 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_30 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1e == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_30 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 272:27]
      plaintexts_31 <= 64'h0; // @[SE.scala 276:39]
    end else if (io_out_valid) begin // @[SE.scala 280:36]
      if (5'h1f == ptr[4:0]) begin // @[SE.scala 282:41]
        plaintexts_31 <= result_plaintext_buffer; // @[SE.scala 282:41]
      end
    end
    if (reset) begin // @[SE.scala 69:26]
      ptr <= 8'h0; // @[SE.scala 69:26]
    end else if (output_valid) begin // @[SE.scala 264:27]
      if (ptr == 8'h1f) begin // @[SE.scala 266:35]
        ptr <= 8'h0; // @[SE.scala 267:29]
      end else begin
        ptr <= _ptr_T_1; // @[SE.scala 269:29]
      end
    end
    if (reset) begin // @[SE.scala 75:24]
      p <= 64'h0; // @[SE.scala 75:24]
    end else begin
      p <= 64'hf77a7946c37a8151; // @[SE.scala 77:11]
    end
    if (reset) begin // @[SE.scala 76:24]
      q <= 64'h0; // @[SE.scala 76:24]
    end else begin
      q <= 64'hbab275fecbbcf705; // @[SE.scala 78:11]
    end
    if (io_in_valid) begin // @[Reg.scala 17:18]
      inst_buffer <= io_in_inst; // @[Reg.scala 17:22]
    end
    if (io_in_valid) begin // @[Reg.scala 17:18]
      op1_buffer <= io_in_op1; // @[Reg.scala 17:22]
    end
    if (io_in_valid) begin // @[Reg.scala 17:18]
      op2_buffer <= io_in_op2; // @[Reg.scala 17:22]
    end
    if (io_in_valid) begin // @[Reg.scala 17:18]
      cond_buffer <= io_in_cond; // @[Reg.scala 17:22]
    end
    valid_buffer <= _T | _valid_buffer_T_1; // @[SE.scala 120:28]
    ready_for_input <= reset | _GEN_10; // @[SE.scala 116:{38,38}]
    if (aes_invcipher_io_input_valid) begin // @[Reg.scala 17:18]
      mid_inst_buffer <= inst_buffer; // @[Reg.scala 17:22]
    end
    if (aes_invcipher_io_input_valid) begin // @[Reg.scala 17:18]
      mid_op1_buffer <= op1_buffer; // @[Reg.scala 17:22]
    end
    result_valid_buffer <= seOpValid | _n_result_valid_buffer_T; // @[SE.scala 224:37]
    if (seOpValid) begin // @[Reg.scala 17:18]
      result_buffer <= padded_result; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[SE.scala 237:46]
      result_plaintext_buffer <= 64'h0; // @[SE.scala 237:46]
    end else if (seOpValid) begin // @[SE.scala 238:24]
      result_plaintext_buffer <= seoperation_io_result; // @[SE.scala 239:41]
    end
    if (aes_cipher_io_output_valid) begin // @[Reg.scala 17:18]
      output_buffer <= _output_buffer_T; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[SE.scala 254:35]
      output_valid <= 1'h0; // @[SE.scala 254:35]
    end else begin
      output_valid <= _GEN_210;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (aes_invcipher_io_input_valid & ~reset) begin
          $fwrite(32'h80000002,"op1_buffer: %x\n",op1_buffer); // @[SE.scala 174:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (aes_invcipher_io_input_valid & _T_56) begin
          $fwrite(32'h80000002,"op2_buffer: %x\n",op2_buffer); // @[SE.scala 175:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (output_valid & _T_56) begin
          $fwrite(32'h80000002,"ptr:%x\n",ptr); // @[SE.scala 265:23]
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
  counterOn = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[6:0];
  _RAND_2 = {4{`RANDOM}};
  ciphers_0 = _RAND_2[127:0];
  _RAND_3 = {4{`RANDOM}};
  ciphers_1 = _RAND_3[127:0];
  _RAND_4 = {4{`RANDOM}};
  ciphers_2 = _RAND_4[127:0];
  _RAND_5 = {4{`RANDOM}};
  ciphers_3 = _RAND_5[127:0];
  _RAND_6 = {4{`RANDOM}};
  ciphers_4 = _RAND_6[127:0];
  _RAND_7 = {4{`RANDOM}};
  ciphers_5 = _RAND_7[127:0];
  _RAND_8 = {4{`RANDOM}};
  ciphers_6 = _RAND_8[127:0];
  _RAND_9 = {4{`RANDOM}};
  ciphers_7 = _RAND_9[127:0];
  _RAND_10 = {4{`RANDOM}};
  ciphers_8 = _RAND_10[127:0];
  _RAND_11 = {4{`RANDOM}};
  ciphers_9 = _RAND_11[127:0];
  _RAND_12 = {4{`RANDOM}};
  ciphers_10 = _RAND_12[127:0];
  _RAND_13 = {4{`RANDOM}};
  ciphers_11 = _RAND_13[127:0];
  _RAND_14 = {4{`RANDOM}};
  ciphers_12 = _RAND_14[127:0];
  _RAND_15 = {4{`RANDOM}};
  ciphers_13 = _RAND_15[127:0];
  _RAND_16 = {4{`RANDOM}};
  ciphers_14 = _RAND_16[127:0];
  _RAND_17 = {4{`RANDOM}};
  ciphers_15 = _RAND_17[127:0];
  _RAND_18 = {4{`RANDOM}};
  ciphers_16 = _RAND_18[127:0];
  _RAND_19 = {4{`RANDOM}};
  ciphers_17 = _RAND_19[127:0];
  _RAND_20 = {4{`RANDOM}};
  ciphers_18 = _RAND_20[127:0];
  _RAND_21 = {4{`RANDOM}};
  ciphers_19 = _RAND_21[127:0];
  _RAND_22 = {4{`RANDOM}};
  ciphers_20 = _RAND_22[127:0];
  _RAND_23 = {4{`RANDOM}};
  ciphers_21 = _RAND_23[127:0];
  _RAND_24 = {4{`RANDOM}};
  ciphers_22 = _RAND_24[127:0];
  _RAND_25 = {4{`RANDOM}};
  ciphers_23 = _RAND_25[127:0];
  _RAND_26 = {4{`RANDOM}};
  ciphers_24 = _RAND_26[127:0];
  _RAND_27 = {4{`RANDOM}};
  ciphers_25 = _RAND_27[127:0];
  _RAND_28 = {4{`RANDOM}};
  ciphers_26 = _RAND_28[127:0];
  _RAND_29 = {4{`RANDOM}};
  ciphers_27 = _RAND_29[127:0];
  _RAND_30 = {4{`RANDOM}};
  ciphers_28 = _RAND_30[127:0];
  _RAND_31 = {4{`RANDOM}};
  ciphers_29 = _RAND_31[127:0];
  _RAND_32 = {4{`RANDOM}};
  ciphers_30 = _RAND_32[127:0];
  _RAND_33 = {4{`RANDOM}};
  ciphers_31 = _RAND_33[127:0];
  _RAND_34 = {1{`RANDOM}};
  cache_valid_0 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  cache_valid_1 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  cache_valid_2 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  cache_valid_3 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  cache_valid_4 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  cache_valid_5 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  cache_valid_6 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  cache_valid_7 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  cache_valid_8 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  cache_valid_9 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  cache_valid_10 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  cache_valid_11 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  cache_valid_12 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  cache_valid_13 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  cache_valid_14 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  cache_valid_15 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  cache_valid_16 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  cache_valid_17 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  cache_valid_18 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  cache_valid_19 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  cache_valid_20 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  cache_valid_21 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  cache_valid_22 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  cache_valid_23 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  cache_valid_24 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  cache_valid_25 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  cache_valid_26 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  cache_valid_27 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  cache_valid_28 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  cache_valid_29 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  cache_valid_30 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  cache_valid_31 = _RAND_65[0:0];
  _RAND_66 = {2{`RANDOM}};
  plaintexts_0 = _RAND_66[63:0];
  _RAND_67 = {2{`RANDOM}};
  plaintexts_1 = _RAND_67[63:0];
  _RAND_68 = {2{`RANDOM}};
  plaintexts_2 = _RAND_68[63:0];
  _RAND_69 = {2{`RANDOM}};
  plaintexts_3 = _RAND_69[63:0];
  _RAND_70 = {2{`RANDOM}};
  plaintexts_4 = _RAND_70[63:0];
  _RAND_71 = {2{`RANDOM}};
  plaintexts_5 = _RAND_71[63:0];
  _RAND_72 = {2{`RANDOM}};
  plaintexts_6 = _RAND_72[63:0];
  _RAND_73 = {2{`RANDOM}};
  plaintexts_7 = _RAND_73[63:0];
  _RAND_74 = {2{`RANDOM}};
  plaintexts_8 = _RAND_74[63:0];
  _RAND_75 = {2{`RANDOM}};
  plaintexts_9 = _RAND_75[63:0];
  _RAND_76 = {2{`RANDOM}};
  plaintexts_10 = _RAND_76[63:0];
  _RAND_77 = {2{`RANDOM}};
  plaintexts_11 = _RAND_77[63:0];
  _RAND_78 = {2{`RANDOM}};
  plaintexts_12 = _RAND_78[63:0];
  _RAND_79 = {2{`RANDOM}};
  plaintexts_13 = _RAND_79[63:0];
  _RAND_80 = {2{`RANDOM}};
  plaintexts_14 = _RAND_80[63:0];
  _RAND_81 = {2{`RANDOM}};
  plaintexts_15 = _RAND_81[63:0];
  _RAND_82 = {2{`RANDOM}};
  plaintexts_16 = _RAND_82[63:0];
  _RAND_83 = {2{`RANDOM}};
  plaintexts_17 = _RAND_83[63:0];
  _RAND_84 = {2{`RANDOM}};
  plaintexts_18 = _RAND_84[63:0];
  _RAND_85 = {2{`RANDOM}};
  plaintexts_19 = _RAND_85[63:0];
  _RAND_86 = {2{`RANDOM}};
  plaintexts_20 = _RAND_86[63:0];
  _RAND_87 = {2{`RANDOM}};
  plaintexts_21 = _RAND_87[63:0];
  _RAND_88 = {2{`RANDOM}};
  plaintexts_22 = _RAND_88[63:0];
  _RAND_89 = {2{`RANDOM}};
  plaintexts_23 = _RAND_89[63:0];
  _RAND_90 = {2{`RANDOM}};
  plaintexts_24 = _RAND_90[63:0];
  _RAND_91 = {2{`RANDOM}};
  plaintexts_25 = _RAND_91[63:0];
  _RAND_92 = {2{`RANDOM}};
  plaintexts_26 = _RAND_92[63:0];
  _RAND_93 = {2{`RANDOM}};
  plaintexts_27 = _RAND_93[63:0];
  _RAND_94 = {2{`RANDOM}};
  plaintexts_28 = _RAND_94[63:0];
  _RAND_95 = {2{`RANDOM}};
  plaintexts_29 = _RAND_95[63:0];
  _RAND_96 = {2{`RANDOM}};
  plaintexts_30 = _RAND_96[63:0];
  _RAND_97 = {2{`RANDOM}};
  plaintexts_31 = _RAND_97[63:0];
  _RAND_98 = {1{`RANDOM}};
  ptr = _RAND_98[7:0];
  _RAND_99 = {2{`RANDOM}};
  p = _RAND_99[63:0];
  _RAND_100 = {2{`RANDOM}};
  q = _RAND_100[63:0];
  _RAND_101 = {1{`RANDOM}};
  inst_buffer = _RAND_101[7:0];
  _RAND_102 = {4{`RANDOM}};
  op1_buffer = _RAND_102[127:0];
  _RAND_103 = {4{`RANDOM}};
  op2_buffer = _RAND_103[127:0];
  _RAND_104 = {4{`RANDOM}};
  cond_buffer = _RAND_104[127:0];
  _RAND_105 = {1{`RANDOM}};
  valid_buffer = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  ready_for_input = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  mid_inst_buffer = _RAND_107[7:0];
  _RAND_108 = {4{`RANDOM}};
  mid_op1_buffer = _RAND_108[127:0];
  _RAND_109 = {1{`RANDOM}};
  result_valid_buffer = _RAND_109[0:0];
  _RAND_110 = {4{`RANDOM}};
  result_buffer = _RAND_110[127:0];
  _RAND_111 = {2{`RANDOM}};
  result_plaintext_buffer = _RAND_111[63:0];
  _RAND_112 = {4{`RANDOM}};
  output_buffer = _RAND_112[127:0];
  _RAND_113 = {1{`RANDOM}};
  output_valid = _RAND_113[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
