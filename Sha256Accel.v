module MessageScheduleArray(
  input         clock,
  input         reset,
  input         io_first,
  input         io_shiftIn,
  input  [31:0] io_wordIn_0,
  input  [31:0] io_wordIn_1,
  output [31:0] io_wOut_0,
  output [31:0] io_wOut_1
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
`endif // RANDOMIZE_REG_INIT
  reg [6:0] iReg; // @[MessageScheduleArray.scala 30:23]
  wire [1:0] _GEN_0 = io_shiftIn ? 2'h2 : 2'h0; // @[MessageScheduleArray.scala 34:27 35:18 37:18]
  wire [6:0] _iReg_T_1 = iReg + 7'h2; // @[MessageScheduleArray.scala 40:22]
  wire [6:0] pairBase = io_first & io_shiftIn ? 7'h0 : iReg; // @[MessageScheduleArray.scala 44:20]
  reg [31:0] regs_0; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_1; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_2; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_3; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_4; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_5; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_6; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_7; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_8; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_9; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_10; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_11; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_12; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_13; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_14; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] regs_15; // @[MessageScheduleArray.scala 55:19]
  reg [31:0] outPair_0; // @[MessageScheduleArray.scala 59:26]
  reg [31:0] outPair_1; // @[MessageScheduleArray.scala 59:26]
  wire [31:0] _w0Wire_s0_T_2 = {regs_14[6:0],regs_14[31:7]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w0Wire_s0_T_5 = {regs_14[17:0],regs_14[31:18]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w0Wire_s0_T_6 = _w0Wire_s0_T_2 ^ _w0Wire_s0_T_5; // @[MessageScheduleArray.scala 50:42]
  wire [31:0] _GEN_23 = {{3'd0}, regs_14[31:3]}; // @[MessageScheduleArray.scala 50:69]
  wire [31:0] w0Wire_s0 = _w0Wire_s0_T_6 ^ _GEN_23; // @[MessageScheduleArray.scala 50:69]
  wire [31:0] _w0Wire_s1_T_2 = {regs_1[16:0],regs_1[31:17]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w0Wire_s1_T_5 = {regs_1[18:0],regs_1[31:19]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w0Wire_s1_T_6 = _w0Wire_s1_T_2 ^ _w0Wire_s1_T_5; // @[MessageScheduleArray.scala 51:42]
  wire [31:0] _GEN_24 = {{10'd0}, regs_1[31:10]}; // @[MessageScheduleArray.scala 51:68]
  wire [31:0] w0Wire_s1 = _w0Wire_s1_T_6 ^ _GEN_24; // @[MessageScheduleArray.scala 51:68]
  wire [31:0] _w0Wire_T_1 = regs_15 + w0Wire_s0; // @[MessageScheduleArray.scala 52:17]
  wire [31:0] _w0Wire_T_3 = _w0Wire_T_1 + regs_6; // @[MessageScheduleArray.scala 52:22]
  wire [31:0] _w0Wire_T_5 = _w0Wire_T_3 + w0Wire_s1; // @[MessageScheduleArray.scala 52:31]
  wire [6:0] _T_2 = pairBase + 7'h1; // @[MessageScheduleArray.scala 70:24]
  wire [31:0] _w1Wire_s0_T_2 = {regs_13[6:0],regs_13[31:7]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w1Wire_s0_T_5 = {regs_13[17:0],regs_13[31:18]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w1Wire_s0_T_6 = _w1Wire_s0_T_2 ^ _w1Wire_s0_T_5; // @[MessageScheduleArray.scala 50:42]
  wire [31:0] _GEN_25 = {{3'd0}, regs_13[31:3]}; // @[MessageScheduleArray.scala 50:69]
  wire [31:0] w1Wire_s0 = _w1Wire_s0_T_6 ^ _GEN_25; // @[MessageScheduleArray.scala 50:69]
  wire [31:0] _w1Wire_s1_T_2 = {regs_0[16:0],regs_0[31:17]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w1Wire_s1_T_5 = {regs_0[18:0],regs_0[31:19]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _w1Wire_s1_T_6 = _w1Wire_s1_T_2 ^ _w1Wire_s1_T_5; // @[MessageScheduleArray.scala 51:42]
  wire [31:0] _GEN_26 = {{10'd0}, regs_0[31:10]}; // @[MessageScheduleArray.scala 51:68]
  wire [31:0] w1Wire_s1 = _w1Wire_s1_T_6 ^ _GEN_26; // @[MessageScheduleArray.scala 51:68]
  wire [31:0] _w1Wire_T_1 = regs_14 + w1Wire_s0; // @[MessageScheduleArray.scala 52:17]
  wire [31:0] _w1Wire_T_3 = _w1Wire_T_1 + regs_5; // @[MessageScheduleArray.scala 52:22]
  wire [31:0] _w1Wire_T_5 = _w1Wire_T_3 + w1Wire_s1; // @[MessageScheduleArray.scala 52:31]
  assign io_wOut_0 = outPair_0; // @[MessageScheduleArray.scala 60:13]
  assign io_wOut_1 = outPair_1; // @[MessageScheduleArray.scala 60:13]
  always @(posedge clock) begin
    if (reset) begin // @[MessageScheduleArray.scala 30:23]
      iReg <= 7'h0; // @[MessageScheduleArray.scala 30:23]
    end else if (io_first) begin // @[MessageScheduleArray.scala 33:23]
      iReg <= {{5'd0}, _GEN_0};
    end else if (io_shiftIn) begin // @[MessageScheduleArray.scala 39:29]
      iReg <= _iReg_T_1; // @[MessageScheduleArray.scala 40:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
        if (_T_2 < 7'h10) begin // @[MessageScheduleArray.scala 70:38]
          regs_0 <= io_wordIn_1; // @[MessageScheduleArray.scala 71:20]
        end else begin
          regs_0 <= _w1Wire_T_5; // @[MessageScheduleArray.scala 73:20]
        end
      end else begin
        regs_0 <= 32'h0; // @[MessageScheduleArray.scala 78:16]
      end
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
        if (pairBase < 7'h10) begin // @[MessageScheduleArray.scala 64:32]
          regs_1 <= io_wordIn_0; // @[MessageScheduleArray.scala 65:20]
        end else begin
          regs_1 <= _w0Wire_T_5; // @[MessageScheduleArray.scala 67:20]
        end
      end else begin
        regs_1 <= 32'h0; // @[MessageScheduleArray.scala 77:16]
      end
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_2 <= regs_0; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_3 <= regs_1; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_4 <= regs_2; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_5 <= regs_3; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_6 <= regs_4; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_7 <= regs_5; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_8 <= regs_6; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_9 <= regs_7; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_10 <= regs_8; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_11 <= regs_9; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_12 <= regs_10; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_13 <= regs_11; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_14 <= regs_12; // @[MessageScheduleArray.scala 75:14]
    end
    if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      regs_15 <= regs_13; // @[MessageScheduleArray.scala 75:14]
    end
    if (reset) begin // @[MessageScheduleArray.scala 59:26]
      outPair_0 <= 32'h0; // @[MessageScheduleArray.scala 59:26]
    end else if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      if (pairBase < 7'h10) begin // @[MessageScheduleArray.scala 64:32]
        outPair_0 <= io_wordIn_0; // @[MessageScheduleArray.scala 65:20]
      end else begin
        outPair_0 <= _w0Wire_T_5; // @[MessageScheduleArray.scala 67:20]
      end
    end else begin
      outPair_0 <= 32'h0; // @[MessageScheduleArray.scala 77:16]
    end
    if (reset) begin // @[MessageScheduleArray.scala 59:26]
      outPair_1 <= 32'h0; // @[MessageScheduleArray.scala 59:26]
    end else if (io_shiftIn) begin // @[MessageScheduleArray.scala 63:23]
      if (_T_2 < 7'h10) begin // @[MessageScheduleArray.scala 70:38]
        outPair_1 <= io_wordIn_1; // @[MessageScheduleArray.scala 71:20]
      end else begin
        outPair_1 <= _w1Wire_T_5; // @[MessageScheduleArray.scala 73:20]
      end
    end else begin
      outPair_1 <= 32'h0; // @[MessageScheduleArray.scala 78:16]
    end
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
  iReg = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  regs_0 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_3 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_4 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_5 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_6 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_7 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_8 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_9 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_10 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_11 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_12 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_13 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_14 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_15 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  outPair_0 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  outPair_1 = _RAND_18[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CompressionFunction(
  input         clock,
  input         reset,
  input         io_first,
  input         io_newChunk,
  input         io_shiftIn,
  input  [31:0] io_wordIn_0,
  input  [31:0] io_wordIn_1,
  output        io_valid,
  output [31:0] io_out_0,
  output [31:0] io_out_1,
  output [31:0] io_out_2,
  output [31:0] io_out_3,
  output [31:0] io_out_4,
  output [31:0] io_out_5,
  output [31:0] io_out_6,
  output [31:0] io_out_7
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
`endif // RANDOMIZE_REG_INIT
  wire  messageScheduleArray_clock; // @[CompressionFunction.scala 56:38]
  wire  messageScheduleArray_reset; // @[CompressionFunction.scala 56:38]
  wire  messageScheduleArray_io_first; // @[CompressionFunction.scala 56:38]
  wire  messageScheduleArray_io_shiftIn; // @[CompressionFunction.scala 56:38]
  wire [31:0] messageScheduleArray_io_wordIn_0; // @[CompressionFunction.scala 56:38]
  wire [31:0] messageScheduleArray_io_wordIn_1; // @[CompressionFunction.scala 56:38]
  wire [31:0] messageScheduleArray_io_wOut_0; // @[CompressionFunction.scala 56:38]
  wire [31:0] messageScheduleArray_io_wOut_1; // @[CompressionFunction.scala 56:38]
  reg  valid; // @[CompressionFunction.scala 36:24]
  reg [6:0] i; // @[CompressionFunction.scala 39:20]
  reg [31:0] hash_val_0; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_1; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_2; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_3; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_4; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_5; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_6; // @[CompressionFunction.scala 41:27]
  reg [31:0] hash_val_7; // @[CompressionFunction.scala 41:27]
  reg [31:0] a; // @[CompressionFunction.scala 47:20]
  reg [31:0] b; // @[CompressionFunction.scala 48:20]
  reg [31:0] c; // @[CompressionFunction.scala 49:20]
  reg [31:0] d; // @[CompressionFunction.scala 50:20]
  reg [31:0] e; // @[CompressionFunction.scala 51:20]
  reg [31:0] f; // @[CompressionFunction.scala 52:20]
  reg [31:0] g; // @[CompressionFunction.scala 53:20]
  reg [31:0] h; // @[CompressionFunction.scala 54:20]
  wire  _messageScheduleArray_io_first_T = io_first | io_newChunk; // @[CompressionFunction.scala 57:47]
  reg  shiftDelayed; // @[CompressionFunction.scala 63:31]
  wire [31:0] _GEN_18 = io_first ? 32'h6a09e667 : hash_val_0; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_19 = io_first ? 32'hbb67ae85 : hash_val_1; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_20 = io_first ? 32'h3c6ef372 : hash_val_2; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_21 = io_first ? 32'ha54ff53a : hash_val_3; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_22 = io_first ? 32'h510e527f : hash_val_4; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_23 = io_first ? 32'h9b05688c : hash_val_5; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_24 = io_first ? 32'h1f83d9ab : hash_val_6; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _GEN_25 = io_first ? 32'h5be0cd19 : hash_val_7; // @[CompressionFunction.scala 108:18 99:21 41:27]
  wire [31:0] _S1_T_2 = {e[5:0],e[31:6]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S1_T_5 = {e[10:0],e[31:11]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S1_T_6 = _S1_T_2 ^ _S1_T_5; // @[CompressionFunction.scala 77:37]
  wire [31:0] _S1_T_9 = {e[24:0],e[31:25]}; // @[RotateLeft.scala 24:38]
  wire [31:0] S1 = _S1_T_6 ^ _S1_T_9; // @[CompressionFunction.scala 77:59]
  wire [31:0] _ch_T = e & f; // @[CompressionFunction.scala 78:22]
  wire [31:0] _ch_T_1 = ~e; // @[CompressionFunction.scala 78:32]
  wire [31:0] _ch_T_2 = _ch_T_1 & g; // @[CompressionFunction.scala 78:44]
  wire [31:0] ch = _ch_T ^ _ch_T_2; // @[CompressionFunction.scala 78:28]
  wire [31:0] _T1_T_1 = h + S1; // @[CompressionFunction.scala 79:21]
  wire [31:0] _T1_T_3 = _T1_T_1 + ch; // @[CompressionFunction.scala 79:26]
  wire [31:0] _GEN_27 = 6'h1 == i[5:0] ? 32'h71374491 : 32'h428a2f98; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_28 = 6'h2 == i[5:0] ? 32'hb5c0fbcf : _GEN_27; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_29 = 6'h3 == i[5:0] ? 32'he9b5dba5 : _GEN_28; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_30 = 6'h4 == i[5:0] ? 32'h3956c25b : _GEN_29; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_31 = 6'h5 == i[5:0] ? 32'h59f111f1 : _GEN_30; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_32 = 6'h6 == i[5:0] ? 32'h923f82a4 : _GEN_31; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_33 = 6'h7 == i[5:0] ? 32'hab1c5ed5 : _GEN_32; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_34 = 6'h8 == i[5:0] ? 32'hd807aa98 : _GEN_33; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_35 = 6'h9 == i[5:0] ? 32'h12835b01 : _GEN_34; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_36 = 6'ha == i[5:0] ? 32'h243185be : _GEN_35; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_37 = 6'hb == i[5:0] ? 32'h550c7dc3 : _GEN_36; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_38 = 6'hc == i[5:0] ? 32'h72be5d74 : _GEN_37; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_39 = 6'hd == i[5:0] ? 32'h80deb1fe : _GEN_38; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_40 = 6'he == i[5:0] ? 32'h9bdc06a7 : _GEN_39; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_41 = 6'hf == i[5:0] ? 32'hc19bf174 : _GEN_40; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_42 = 6'h10 == i[5:0] ? 32'he49b69c1 : _GEN_41; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_43 = 6'h11 == i[5:0] ? 32'hefbe4786 : _GEN_42; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_44 = 6'h12 == i[5:0] ? 32'hfc19dc6 : _GEN_43; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_45 = 6'h13 == i[5:0] ? 32'h240ca1cc : _GEN_44; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_46 = 6'h14 == i[5:0] ? 32'h2de92c6f : _GEN_45; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_47 = 6'h15 == i[5:0] ? 32'h4a7484aa : _GEN_46; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_48 = 6'h16 == i[5:0] ? 32'h5cb0a9dc : _GEN_47; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_49 = 6'h17 == i[5:0] ? 32'h76f988da : _GEN_48; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_50 = 6'h18 == i[5:0] ? 32'h983e5152 : _GEN_49; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_51 = 6'h19 == i[5:0] ? 32'ha831c66d : _GEN_50; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_52 = 6'h1a == i[5:0] ? 32'hb00327c8 : _GEN_51; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_53 = 6'h1b == i[5:0] ? 32'hbf597fc7 : _GEN_52; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_54 = 6'h1c == i[5:0] ? 32'hc6e00bf3 : _GEN_53; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_55 = 6'h1d == i[5:0] ? 32'hd5a79147 : _GEN_54; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_56 = 6'h1e == i[5:0] ? 32'h6ca6351 : _GEN_55; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_57 = 6'h1f == i[5:0] ? 32'h14292967 : _GEN_56; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_58 = 6'h20 == i[5:0] ? 32'h27b70a85 : _GEN_57; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_59 = 6'h21 == i[5:0] ? 32'h2e1b2138 : _GEN_58; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_60 = 6'h22 == i[5:0] ? 32'h4d2c6dfc : _GEN_59; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_61 = 6'h23 == i[5:0] ? 32'h53380d13 : _GEN_60; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_62 = 6'h24 == i[5:0] ? 32'h650a7354 : _GEN_61; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_63 = 6'h25 == i[5:0] ? 32'h766a0abb : _GEN_62; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_64 = 6'h26 == i[5:0] ? 32'h81c2c92e : _GEN_63; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_65 = 6'h27 == i[5:0] ? 32'h92722c85 : _GEN_64; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_66 = 6'h28 == i[5:0] ? 32'ha2bfe8a1 : _GEN_65; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_67 = 6'h29 == i[5:0] ? 32'ha81a664b : _GEN_66; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_68 = 6'h2a == i[5:0] ? 32'hc24b8b70 : _GEN_67; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_69 = 6'h2b == i[5:0] ? 32'hc76c51a3 : _GEN_68; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_70 = 6'h2c == i[5:0] ? 32'hd192e819 : _GEN_69; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_71 = 6'h2d == i[5:0] ? 32'hd6990624 : _GEN_70; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_72 = 6'h2e == i[5:0] ? 32'hf40e3585 : _GEN_71; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_73 = 6'h2f == i[5:0] ? 32'h106aa070 : _GEN_72; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_74 = 6'h30 == i[5:0] ? 32'h19a4c116 : _GEN_73; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_75 = 6'h31 == i[5:0] ? 32'h1e376c08 : _GEN_74; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_76 = 6'h32 == i[5:0] ? 32'h2748774c : _GEN_75; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_77 = 6'h33 == i[5:0] ? 32'h34b0bcb5 : _GEN_76; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_78 = 6'h34 == i[5:0] ? 32'h391c0cb3 : _GEN_77; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_79 = 6'h35 == i[5:0] ? 32'h4ed8aa4a : _GEN_78; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_80 = 6'h36 == i[5:0] ? 32'h5b9cca4f : _GEN_79; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_81 = 6'h37 == i[5:0] ? 32'h682e6ff3 : _GEN_80; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_82 = 6'h38 == i[5:0] ? 32'h748f82ee : _GEN_81; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_83 = 6'h39 == i[5:0] ? 32'h78a5636f : _GEN_82; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_84 = 6'h3a == i[5:0] ? 32'h84c87814 : _GEN_83; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_85 = 6'h3b == i[5:0] ? 32'h8cc70208 : _GEN_84; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_86 = 6'h3c == i[5:0] ? 32'h90befffa : _GEN_85; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_87 = 6'h3d == i[5:0] ? 32'ha4506ceb : _GEN_86; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_88 = 6'h3e == i[5:0] ? 32'hbef9a3f7 : _GEN_87; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_89 = 6'h3f == i[5:0] ? 32'hc67178f2 : _GEN_88; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _T1_T_5 = _T1_T_3 + _GEN_89; // @[CompressionFunction.scala 79:31]
  wire [31:0] T1 = _T1_T_5 + messageScheduleArray_io_wOut_0; // @[CompressionFunction.scala 79:35]
  wire [31:0] _S0_T_2 = {a[1:0],a[31:2]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S0_T_5 = {a[12:0],a[31:13]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S0_T_6 = _S0_T_2 ^ _S0_T_5; // @[CompressionFunction.scala 80:37]
  wire [31:0] _S0_T_9 = {a[21:0],a[31:22]}; // @[RotateLeft.scala 24:38]
  wire [31:0] S0 = _S0_T_6 ^ _S0_T_9; // @[CompressionFunction.scala 80:59]
  wire [31:0] _maj_T = a & b; // @[CompressionFunction.scala 81:23]
  wire [31:0] _maj_T_1 = a & c; // @[CompressionFunction.scala 81:35]
  wire [31:0] _maj_T_2 = _maj_T ^ _maj_T_1; // @[CompressionFunction.scala 81:29]
  wire [31:0] _maj_T_3 = b & c; // @[CompressionFunction.scala 81:47]
  wire [31:0] maj = _maj_T_2 ^ _maj_T_3; // @[CompressionFunction.scala 81:41]
  wire [31:0] T2 = S0 + maj; // @[CompressionFunction.scala 82:21]
  wire [31:0] a0 = T1 + T2; // @[CompressionFunction.scala 83:21]
  wire [31:0] e0 = d + T1; // @[CompressionFunction.scala 87:21]
  wire [6:0] _T_3 = i + 7'h1; // @[CompressionFunction.scala 129:87]
  wire [31:0] _S1_T_12 = {e0[5:0],e0[31:6]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S1_T_15 = {e0[10:0],e0[31:11]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S1_T_16 = _S1_T_12 ^ _S1_T_15; // @[CompressionFunction.scala 77:37]
  wire [31:0] _S1_T_19 = {e0[24:0],e0[31:25]}; // @[RotateLeft.scala 24:38]
  wire [31:0] S1_1 = _S1_T_16 ^ _S1_T_19; // @[CompressionFunction.scala 77:59]
  wire [31:0] _ch_T_3 = e0 & e; // @[CompressionFunction.scala 78:22]
  wire [31:0] _ch_T_4 = ~e0; // @[CompressionFunction.scala 78:32]
  wire [31:0] _ch_T_5 = _ch_T_4 & f; // @[CompressionFunction.scala 78:44]
  wire [31:0] ch_1 = _ch_T_3 ^ _ch_T_5; // @[CompressionFunction.scala 78:28]
  wire [31:0] _T1_T_8 = g + S1_1; // @[CompressionFunction.scala 79:21]
  wire [31:0] _T1_T_10 = _T1_T_8 + ch_1; // @[CompressionFunction.scala 79:26]
  wire [31:0] _GEN_91 = 6'h1 == _T_3[5:0] ? 32'h71374491 : 32'h428a2f98; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_92 = 6'h2 == _T_3[5:0] ? 32'hb5c0fbcf : _GEN_91; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_93 = 6'h3 == _T_3[5:0] ? 32'he9b5dba5 : _GEN_92; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_94 = 6'h4 == _T_3[5:0] ? 32'h3956c25b : _GEN_93; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_95 = 6'h5 == _T_3[5:0] ? 32'h59f111f1 : _GEN_94; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_96 = 6'h6 == _T_3[5:0] ? 32'h923f82a4 : _GEN_95; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_97 = 6'h7 == _T_3[5:0] ? 32'hab1c5ed5 : _GEN_96; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_98 = 6'h8 == _T_3[5:0] ? 32'hd807aa98 : _GEN_97; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_99 = 6'h9 == _T_3[5:0] ? 32'h12835b01 : _GEN_98; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_100 = 6'ha == _T_3[5:0] ? 32'h243185be : _GEN_99; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_101 = 6'hb == _T_3[5:0] ? 32'h550c7dc3 : _GEN_100; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_102 = 6'hc == _T_3[5:0] ? 32'h72be5d74 : _GEN_101; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_103 = 6'hd == _T_3[5:0] ? 32'h80deb1fe : _GEN_102; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_104 = 6'he == _T_3[5:0] ? 32'h9bdc06a7 : _GEN_103; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_105 = 6'hf == _T_3[5:0] ? 32'hc19bf174 : _GEN_104; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_106 = 6'h10 == _T_3[5:0] ? 32'he49b69c1 : _GEN_105; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_107 = 6'h11 == _T_3[5:0] ? 32'hefbe4786 : _GEN_106; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_108 = 6'h12 == _T_3[5:0] ? 32'hfc19dc6 : _GEN_107; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_109 = 6'h13 == _T_3[5:0] ? 32'h240ca1cc : _GEN_108; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_110 = 6'h14 == _T_3[5:0] ? 32'h2de92c6f : _GEN_109; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_111 = 6'h15 == _T_3[5:0] ? 32'h4a7484aa : _GEN_110; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_112 = 6'h16 == _T_3[5:0] ? 32'h5cb0a9dc : _GEN_111; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_113 = 6'h17 == _T_3[5:0] ? 32'h76f988da : _GEN_112; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_114 = 6'h18 == _T_3[5:0] ? 32'h983e5152 : _GEN_113; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_115 = 6'h19 == _T_3[5:0] ? 32'ha831c66d : _GEN_114; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_116 = 6'h1a == _T_3[5:0] ? 32'hb00327c8 : _GEN_115; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_117 = 6'h1b == _T_3[5:0] ? 32'hbf597fc7 : _GEN_116; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_118 = 6'h1c == _T_3[5:0] ? 32'hc6e00bf3 : _GEN_117; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_119 = 6'h1d == _T_3[5:0] ? 32'hd5a79147 : _GEN_118; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_120 = 6'h1e == _T_3[5:0] ? 32'h6ca6351 : _GEN_119; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_121 = 6'h1f == _T_3[5:0] ? 32'h14292967 : _GEN_120; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_122 = 6'h20 == _T_3[5:0] ? 32'h27b70a85 : _GEN_121; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_123 = 6'h21 == _T_3[5:0] ? 32'h2e1b2138 : _GEN_122; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_124 = 6'h22 == _T_3[5:0] ? 32'h4d2c6dfc : _GEN_123; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_125 = 6'h23 == _T_3[5:0] ? 32'h53380d13 : _GEN_124; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_126 = 6'h24 == _T_3[5:0] ? 32'h650a7354 : _GEN_125; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_127 = 6'h25 == _T_3[5:0] ? 32'h766a0abb : _GEN_126; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_128 = 6'h26 == _T_3[5:0] ? 32'h81c2c92e : _GEN_127; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_129 = 6'h27 == _T_3[5:0] ? 32'h92722c85 : _GEN_128; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_130 = 6'h28 == _T_3[5:0] ? 32'ha2bfe8a1 : _GEN_129; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_131 = 6'h29 == _T_3[5:0] ? 32'ha81a664b : _GEN_130; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_132 = 6'h2a == _T_3[5:0] ? 32'hc24b8b70 : _GEN_131; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_133 = 6'h2b == _T_3[5:0] ? 32'hc76c51a3 : _GEN_132; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_134 = 6'h2c == _T_3[5:0] ? 32'hd192e819 : _GEN_133; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_135 = 6'h2d == _T_3[5:0] ? 32'hd6990624 : _GEN_134; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_136 = 6'h2e == _T_3[5:0] ? 32'hf40e3585 : _GEN_135; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_137 = 6'h2f == _T_3[5:0] ? 32'h106aa070 : _GEN_136; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_138 = 6'h30 == _T_3[5:0] ? 32'h19a4c116 : _GEN_137; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_139 = 6'h31 == _T_3[5:0] ? 32'h1e376c08 : _GEN_138; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_140 = 6'h32 == _T_3[5:0] ? 32'h2748774c : _GEN_139; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_141 = 6'h33 == _T_3[5:0] ? 32'h34b0bcb5 : _GEN_140; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_142 = 6'h34 == _T_3[5:0] ? 32'h391c0cb3 : _GEN_141; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_143 = 6'h35 == _T_3[5:0] ? 32'h4ed8aa4a : _GEN_142; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_144 = 6'h36 == _T_3[5:0] ? 32'h5b9cca4f : _GEN_143; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_145 = 6'h37 == _T_3[5:0] ? 32'h682e6ff3 : _GEN_144; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_146 = 6'h38 == _T_3[5:0] ? 32'h748f82ee : _GEN_145; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_147 = 6'h39 == _T_3[5:0] ? 32'h78a5636f : _GEN_146; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_148 = 6'h3a == _T_3[5:0] ? 32'h84c87814 : _GEN_147; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_149 = 6'h3b == _T_3[5:0] ? 32'h8cc70208 : _GEN_148; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_150 = 6'h3c == _T_3[5:0] ? 32'h90befffa : _GEN_149; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_151 = 6'h3d == _T_3[5:0] ? 32'ha4506ceb : _GEN_150; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_152 = 6'h3e == _T_3[5:0] ? 32'hbef9a3f7 : _GEN_151; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _GEN_153 = 6'h3f == _T_3[5:0] ? 32'hc67178f2 : _GEN_152; // @[CompressionFunction.scala 79:{31,31}]
  wire [31:0] _T1_T_12 = _T1_T_10 + _GEN_153; // @[CompressionFunction.scala 79:31]
  wire [31:0] T1_1 = _T1_T_12 + messageScheduleArray_io_wOut_1; // @[CompressionFunction.scala 79:35]
  wire [31:0] _S0_T_12 = {a0[1:0],a0[31:2]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S0_T_15 = {a0[12:0],a0[31:13]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S0_T_16 = _S0_T_12 ^ _S0_T_15; // @[CompressionFunction.scala 80:37]
  wire [31:0] _S0_T_19 = {a0[21:0],a0[31:22]}; // @[RotateLeft.scala 24:38]
  wire [31:0] S0_1 = _S0_T_16 ^ _S0_T_19; // @[CompressionFunction.scala 80:59]
  wire [31:0] _maj_T_4 = a0 & a; // @[CompressionFunction.scala 81:23]
  wire [31:0] _maj_T_5 = a0 & b; // @[CompressionFunction.scala 81:35]
  wire [31:0] _maj_T_6 = _maj_T_4 ^ _maj_T_5; // @[CompressionFunction.scala 81:29]
  wire [31:0] maj_1 = _maj_T_6 ^ _maj_T; // @[CompressionFunction.scala 81:41]
  wire [31:0] T2_1 = S0_1 + maj_1; // @[CompressionFunction.scala 82:21]
  wire [31:0] a1 = T1_1 + T2_1; // @[CompressionFunction.scala 83:21]
  wire [31:0] e1 = c + T1_1; // @[CompressionFunction.scala 87:21]
  wire [6:0] _i_T_1 = i + 7'h2; // @[CompressionFunction.scala 140:20]
  wire  _T_5 = i == 7'h3e; // @[CompressionFunction.scala 142:21]
  wire [31:0] n0 = hash_val_0 + a1; // @[CompressionFunction.scala 145:34]
  wire [31:0] n1 = hash_val_1 + a0; // @[CompressionFunction.scala 146:34]
  wire [31:0] n2 = hash_val_2 + a; // @[CompressionFunction.scala 147:34]
  wire [31:0] n3 = hash_val_3 + b; // @[CompressionFunction.scala 148:34]
  wire [31:0] n4 = hash_val_4 + e1; // @[CompressionFunction.scala 149:34]
  wire [31:0] n5 = hash_val_5 + e0; // @[CompressionFunction.scala 150:34]
  wire [31:0] n6 = hash_val_6 + e; // @[CompressionFunction.scala 151:34]
  wire [31:0] n7 = hash_val_7 + f; // @[CompressionFunction.scala 152:34]
  MessageScheduleArray messageScheduleArray ( // @[CompressionFunction.scala 56:38]
    .clock(messageScheduleArray_clock),
    .reset(messageScheduleArray_reset),
    .io_first(messageScheduleArray_io_first),
    .io_shiftIn(messageScheduleArray_io_shiftIn),
    .io_wordIn_0(messageScheduleArray_io_wordIn_0),
    .io_wordIn_1(messageScheduleArray_io_wordIn_1),
    .io_wOut_0(messageScheduleArray_io_wOut_0),
    .io_wOut_1(messageScheduleArray_io_wOut_1)
  );
  assign io_valid = valid; // @[CompressionFunction.scala 37:14]
  assign io_out_0 = hash_val_0; // @[CompressionFunction.scala 42:12]
  assign io_out_1 = hash_val_1; // @[CompressionFunction.scala 42:12]
  assign io_out_2 = hash_val_2; // @[CompressionFunction.scala 42:12]
  assign io_out_3 = hash_val_3; // @[CompressionFunction.scala 42:12]
  assign io_out_4 = hash_val_4; // @[CompressionFunction.scala 42:12]
  assign io_out_5 = hash_val_5; // @[CompressionFunction.scala 42:12]
  assign io_out_6 = hash_val_6; // @[CompressionFunction.scala 42:12]
  assign io_out_7 = hash_val_7; // @[CompressionFunction.scala 42:12]
  assign messageScheduleArray_clock = clock;
  assign messageScheduleArray_reset = reset;
  assign messageScheduleArray_io_first = io_first | io_newChunk; // @[CompressionFunction.scala 57:47]
  assign messageScheduleArray_io_shiftIn = io_shiftIn & ~io_first & ~io_newChunk; // @[CompressionFunction.scala 59:51]
  assign messageScheduleArray_io_wordIn_0 = io_wordIn_0; // @[CompressionFunction.scala 61:36]
  assign messageScheduleArray_io_wordIn_1 = io_wordIn_1; // @[CompressionFunction.scala 61:36]
  always @(posedge clock) begin
    if (reset) begin // @[CompressionFunction.scala 36:24]
      valid <= 1'h0; // @[CompressionFunction.scala 36:24]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      valid <= _T_5;
    end else if (_messageScheduleArray_io_first_T) begin // @[CompressionFunction.scala 94:35]
      valid <= 1'h0; // @[CompressionFunction.scala 95:15]
    end
    if (reset) begin // @[CompressionFunction.scala 39:20]
      i <= 7'h0; // @[CompressionFunction.scala 39:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      i <= _i_T_1; // @[CompressionFunction.scala 140:11]
    end else if (_messageScheduleArray_io_first_T) begin // @[CompressionFunction.scala 94:35]
      i <= 7'h0; // @[CompressionFunction.scala 96:11]
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_0 <= 32'h6a09e667; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_0 <= n0; // @[CompressionFunction.scala 163:25]
      end else begin
        hash_val_0 <= _GEN_18;
      end
    end else begin
      hash_val_0 <= _GEN_18;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_1 <= 32'hbb67ae85; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_1 <= n1; // @[CompressionFunction.scala 164:25]
      end else begin
        hash_val_1 <= _GEN_19;
      end
    end else begin
      hash_val_1 <= _GEN_19;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_2 <= 32'h3c6ef372; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_2 <= n2; // @[CompressionFunction.scala 165:25]
      end else begin
        hash_val_2 <= _GEN_20;
      end
    end else begin
      hash_val_2 <= _GEN_20;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_3 <= 32'ha54ff53a; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_3 <= n3; // @[CompressionFunction.scala 166:25]
      end else begin
        hash_val_3 <= _GEN_21;
      end
    end else begin
      hash_val_3 <= _GEN_21;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_4 <= 32'h510e527f; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_4 <= n4; // @[CompressionFunction.scala 167:25]
      end else begin
        hash_val_4 <= _GEN_22;
      end
    end else begin
      hash_val_4 <= _GEN_22;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_5 <= 32'h9b05688c; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_5 <= n5; // @[CompressionFunction.scala 168:25]
      end else begin
        hash_val_5 <= _GEN_23;
      end
    end else begin
      hash_val_5 <= _GEN_23;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_6 <= 32'h1f83d9ab; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_6 <= n6; // @[CompressionFunction.scala 169:25]
      end else begin
        hash_val_6 <= _GEN_24;
      end
    end else begin
      hash_val_6 <= _GEN_24;
    end
    if (reset) begin // @[CompressionFunction.scala 41:27]
      hash_val_7 <= 32'h5be0cd19; // @[CompressionFunction.scala 41:27]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        hash_val_7 <= n7; // @[CompressionFunction.scala 170:25]
      end else begin
        hash_val_7 <= _GEN_25;
      end
    end else begin
      hash_val_7 <= _GEN_25;
    end
    if (reset) begin // @[CompressionFunction.scala 47:20]
      a <= 32'h6a09e667; // @[CompressionFunction.scala 47:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        a <= n0; // @[CompressionFunction.scala 154:15]
      end else begin
        a <= a1; // @[CompressionFunction.scala 131:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      a <= 32'h6a09e667; // @[CompressionFunction.scala 100:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      a <= hash_val_0; // @[CompressionFunction.scala 111:11]
    end
    if (reset) begin // @[CompressionFunction.scala 48:20]
      b <= 32'hbb67ae85; // @[CompressionFunction.scala 48:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        b <= n1; // @[CompressionFunction.scala 155:15]
      end else begin
        b <= a0; // @[CompressionFunction.scala 132:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      b <= 32'hbb67ae85; // @[CompressionFunction.scala 101:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      b <= hash_val_1; // @[CompressionFunction.scala 112:11]
    end
    if (reset) begin // @[CompressionFunction.scala 49:20]
      c <= 32'h3c6ef372; // @[CompressionFunction.scala 49:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        c <= n2; // @[CompressionFunction.scala 156:15]
      end else begin
        c <= a; // @[CompressionFunction.scala 133:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      c <= 32'h3c6ef372; // @[CompressionFunction.scala 102:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      c <= hash_val_2; // @[CompressionFunction.scala 113:11]
    end
    if (reset) begin // @[CompressionFunction.scala 50:20]
      d <= 32'ha54ff53a; // @[CompressionFunction.scala 50:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        d <= n3; // @[CompressionFunction.scala 157:15]
      end else begin
        d <= b; // @[CompressionFunction.scala 134:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      d <= 32'ha54ff53a; // @[CompressionFunction.scala 103:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      d <= hash_val_3; // @[CompressionFunction.scala 114:11]
    end
    if (reset) begin // @[CompressionFunction.scala 51:20]
      e <= 32'h510e527f; // @[CompressionFunction.scala 51:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        e <= n4; // @[CompressionFunction.scala 158:15]
      end else begin
        e <= e1; // @[CompressionFunction.scala 135:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      e <= 32'h510e527f; // @[CompressionFunction.scala 104:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      e <= hash_val_4; // @[CompressionFunction.scala 115:11]
    end
    if (reset) begin // @[CompressionFunction.scala 52:20]
      f <= 32'h9b05688c; // @[CompressionFunction.scala 52:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        f <= n5; // @[CompressionFunction.scala 159:15]
      end else begin
        f <= e0; // @[CompressionFunction.scala 136:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      f <= 32'h9b05688c; // @[CompressionFunction.scala 105:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      f <= hash_val_5; // @[CompressionFunction.scala 116:11]
    end
    if (reset) begin // @[CompressionFunction.scala 53:20]
      g <= 32'h1f83d9ab; // @[CompressionFunction.scala 53:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        g <= n6; // @[CompressionFunction.scala 160:15]
      end else begin
        g <= e; // @[CompressionFunction.scala 137:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      g <= 32'h1f83d9ab; // @[CompressionFunction.scala 106:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      g <= hash_val_6; // @[CompressionFunction.scala 117:11]
    end
    if (reset) begin // @[CompressionFunction.scala 54:20]
      h <= 32'h5be0cd19; // @[CompressionFunction.scala 54:20]
    end else if (shiftDelayed) begin // @[CompressionFunction.scala 121:25]
      if (i == 7'h3e) begin // @[CompressionFunction.scala 142:31]
        h <= n7; // @[CompressionFunction.scala 161:15]
      end else begin
        h <= f; // @[CompressionFunction.scala 138:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 99:21]
      h <= 32'h5be0cd19; // @[CompressionFunction.scala 107:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 110:30]
      h <= hash_val_7; // @[CompressionFunction.scala 118:11]
    end
    shiftDelayed <= io_shiftIn & ~io_first & ~io_newChunk; // @[CompressionFunction.scala 59:51]
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
  valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  i = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  hash_val_0 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  hash_val_1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  hash_val_2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  hash_val_3 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  hash_val_4 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  hash_val_5 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  hash_val_6 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  hash_val_7 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  a = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  b = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  c = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  d = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  e = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  f = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  g = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  h = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  shiftDelayed = _RAND_18[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Sha256Accel(
  input          clock,
  input          reset,
  input  [519:0] io_inputData,
  input          io_inputValid,
  output [31:0]  io_outputData_0,
  output [31:0]  io_outputData_1,
  output [31:0]  io_outputData_2,
  output [31:0]  io_outputData_3,
  output [31:0]  io_outputData_4,
  output [31:0]  io_outputData_5,
  output [31:0]  io_outputData_6,
  output [31:0]  io_outputData_7,
  output         io_outputValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [543:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  accel_clock; // @[Sha256Accel.scala 36:23]
  wire  accel_reset; // @[Sha256Accel.scala 36:23]
  wire  accel_io_first; // @[Sha256Accel.scala 36:23]
  wire  accel_io_newChunk; // @[Sha256Accel.scala 36:23]
  wire  accel_io_shiftIn; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_wordIn_0; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_wordIn_1; // @[Sha256Accel.scala 36:23]
  wire  accel_io_valid; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_0; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_1; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_2; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_3; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_4; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_5; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_6; // @[Sha256Accel.scala 36:23]
  wire [31:0] accel_io_out_7; // @[Sha256Accel.scala 36:23]
  reg [519:0] vec_data; // @[Reg.scala 16:16]
  reg [5:0] ctr; // @[Sha256Accel.scala 38:22]
  reg  first; // @[Sha256Accel.scala 40:24]
  wire  _first_T_2 = accel_io_shiftIn & ctr == 6'h1 ? 1'h0 : first; // @[Sha256Accel.scala 41:44]
  reg  start; // @[Sha256Accel.scala 43:24]
  wire  _GEN_1 = accel_io_valid ? 1'h0 : start; // @[Sha256Accel.scala 46:32 47:15 43:24]
  wire  _GEN_2 = io_inputValid | _GEN_1; // @[Sha256Accel.scala 44:25 45:15]
  wire  _accel_io_newChunk_T = ctr == 6'h0; // @[Sha256Accel.scala 60:40]
  wire [5:0] _schedStep_T_2 = ctr - 6'h1; // @[Sha256Accel.scala 63:52]
  wire [5:0] schedStep = _accel_io_newChunk_T ? 6'h0 : _schedStep_T_2; // @[Sha256Accel.scala 63:24]
  wire [6:0] wIdx0 = {schedStep,1'h0}; // @[Cat.scala 31:58]
  wire [6:0] wIdx1 = {schedStep,1'h1}; // @[Cat.scala 31:58]
  wire  _accel_io_wordIn_0_T = wIdx0 < 7'h10; // @[Sha256Accel.scala 71:22]
  wire [12:0] _accel_io_wordIn_0_T_1 = wIdx0 * 6'h20; // @[Sha256Accel.scala 71:52]
  wire [519:0] _accel_io_wordIn_0_T_2 = vec_data >> _accel_io_wordIn_0_T_1; // @[Sha256Accel.scala 71:44]
  wire  _accel_io_wordIn_0_T_4 = wIdx0 == 7'h10; // @[Sha256Accel.scala 72:22]
  wire [31:0] _accel_io_wordIn_0_T_6 = {vec_data[519:512],24'h0}; // @[Cat.scala 31:58]
  wire  _accel_io_wordIn_0_T_7 = wIdx0 == 7'h3f; // @[Sha256Accel.scala 73:22]
  wire [31:0] _accel_io_wordIn_0_T_8 = _accel_io_wordIn_0_T_7 ? 32'h208 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _accel_io_wordIn_0_T_9 = _accel_io_wordIn_0_T_4 ? _accel_io_wordIn_0_T_6 : _accel_io_wordIn_0_T_8; // @[Mux.scala 101:16]
  wire  _accel_io_wordIn_1_T = wIdx1 < 7'h10; // @[Sha256Accel.scala 71:22]
  wire [12:0] _accel_io_wordIn_1_T_1 = wIdx1 * 6'h20; // @[Sha256Accel.scala 71:52]
  wire [519:0] _accel_io_wordIn_1_T_2 = vec_data >> _accel_io_wordIn_1_T_1; // @[Sha256Accel.scala 71:44]
  wire  _accel_io_wordIn_1_T_4 = wIdx1 == 7'h10; // @[Sha256Accel.scala 72:22]
  wire  _accel_io_wordIn_1_T_7 = wIdx1 == 7'h3f; // @[Sha256Accel.scala 73:22]
  wire [31:0] _accel_io_wordIn_1_T_8 = _accel_io_wordIn_1_T_7 ? 32'h208 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _accel_io_wordIn_1_T_9 = _accel_io_wordIn_1_T_4 ? _accel_io_wordIn_0_T_6 : _accel_io_wordIn_1_T_8; // @[Mux.scala 101:16]
  wire [5:0] _ctr_T_2 = ctr + 6'h1; // @[Sha256Accel.scala 87:47]
  wire [5:0] _ctr_T_3 = ctr == 6'h20 ? 6'h0 : _ctr_T_2; // @[Sha256Accel.scala 87:23]
  wire [5:0] _GEN_4 = accel_io_shiftIn ? _ctr_T_3 : ctr; // @[Sha256Accel.scala 86:38 87:17 38:22]
  CompressionFunction accel ( // @[Sha256Accel.scala 36:23]
    .clock(accel_clock),
    .reset(accel_reset),
    .io_first(accel_io_first),
    .io_newChunk(accel_io_newChunk),
    .io_shiftIn(accel_io_shiftIn),
    .io_wordIn_0(accel_io_wordIn_0),
    .io_wordIn_1(accel_io_wordIn_1),
    .io_valid(accel_io_valid),
    .io_out_0(accel_io_out_0),
    .io_out_1(accel_io_out_1),
    .io_out_2(accel_io_out_2),
    .io_out_3(accel_io_out_3),
    .io_out_4(accel_io_out_4),
    .io_out_5(accel_io_out_5),
    .io_out_6(accel_io_out_6),
    .io_out_7(accel_io_out_7)
  );
  assign io_outputData_0 = accel_io_out_0; // @[Sha256Accel.scala 50:19]
  assign io_outputData_1 = accel_io_out_1; // @[Sha256Accel.scala 50:19]
  assign io_outputData_2 = accel_io_out_2; // @[Sha256Accel.scala 50:19]
  assign io_outputData_3 = accel_io_out_3; // @[Sha256Accel.scala 50:19]
  assign io_outputData_4 = accel_io_out_4; // @[Sha256Accel.scala 50:19]
  assign io_outputData_5 = accel_io_out_5; // @[Sha256Accel.scala 50:19]
  assign io_outputData_6 = accel_io_out_6; // @[Sha256Accel.scala 50:19]
  assign io_outputData_7 = accel_io_out_7; // @[Sha256Accel.scala 50:19]
  assign io_outputValid = accel_io_valid; // @[Sha256Accel.scala 51:20]
  assign accel_clock = clock;
  assign accel_reset = reset;
  assign accel_io_first = first & start & _accel_io_newChunk_T; // @[Sha256Accel.scala 61:38]
  assign accel_io_newChunk = start & ctr == 6'h0; // @[Sha256Accel.scala 60:32]
  assign accel_io_shiftIn = start & ctr != 6'h0; // @[Sha256Accel.scala 54:17 55:26 57:26]
  assign accel_io_wordIn_0 = _accel_io_wordIn_0_T ? _accel_io_wordIn_0_T_2[31:0] : _accel_io_wordIn_0_T_9; // @[Mux.scala 101:16]
  assign accel_io_wordIn_1 = _accel_io_wordIn_1_T ? _accel_io_wordIn_1_T_2[31:0] : _accel_io_wordIn_1_T_9; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    if (io_inputValid) begin // @[Reg.scala 17:18]
      vec_data <= io_inputData; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Sha256Accel.scala 38:22]
      ctr <= 6'h0; // @[Sha256Accel.scala 38:22]
    end else if (io_inputValid) begin // @[Sha256Accel.scala 81:25]
      ctr <= 6'h0; // @[Sha256Accel.scala 82:13]
    end else if (start) begin // @[Sha256Accel.scala 83:23]
      if (_accel_io_newChunk_T) begin // @[Sha256Accel.scala 84:27]
        ctr <= 6'h1; // @[Sha256Accel.scala 85:17]
      end else begin
        ctr <= _GEN_4;
      end
    end
    first <= reset | (io_inputValid | _first_T_2); // @[Sha256Accel.scala 40:{24,24} 41:11]
    if (reset) begin // @[Sha256Accel.scala 43:24]
      start <= 1'h0; // @[Sha256Accel.scala 43:24]
    end else begin
      start <= _GEN_2;
    end
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
  _RAND_0 = {17{`RANDOM}};
  vec_data = _RAND_0[519:0];
  _RAND_1 = {1{`RANDOM}};
  ctr = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  first = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  start = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
