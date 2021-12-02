module SEOperation(
  input   io_op1_input,
  input   io_op2_input,
  input   io_cond_input
);
endmodule
module InvCipherRound(
  input   clock,
  input   io_input_valid,
  output  io_output_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  r_1; // @[Reg.scala 15:16]
  assign io_output_valid = r_1; // @[InvCipherRound.scala 38:21]
  always @(posedge clock) begin
    r_1 <= io_input_valid; // @[Reg.scala 15:16 16:{19,23}]
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
  r_1 = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InvCipherRound_3(
  input   clock,
  input   io_input_valid,
  output  io_output_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  r_1; // @[Reg.scala 15:16]
  assign io_output_valid = r_1; // @[InvCipherRound.scala 89:21]
  always @(posedge clock) begin
    r_1 <= io_input_valid; // @[Reg.scala 15:16 16:{19,23}]
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
  r_1 = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InvCipherRound_30(
  input   clock,
  input   io_input_valid,
  output  io_output_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  r_1; // @[Reg.scala 15:16]
  assign io_output_valid = r_1; // @[InvCipherRound.scala 62:21]
  always @(posedge clock) begin
    r_1 <= io_input_valid; // @[Reg.scala 15:16 16:{19,23}]
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
  r_1 = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AESDecrypt(
  input   clock,
  input   io_input_valid,
  output  io_output_op1_0,
  output  io_output_op1_1,
  output  io_output_op1_2,
  output  io_output_op1_3,
  output  io_output_op1_4,
  output  io_output_op1_5,
  output  io_output_op1_6,
  output  io_output_op1_7,
  output  io_output_op1_8,
  output  io_output_op1_9,
  output  io_output_op1_10,
  output  io_output_op1_11,
  output  io_output_op1_12,
  output  io_output_op1_13,
  output  io_output_op1_14,
  output  io_output_op1_15,
  output  io_output_op2_0,
  output  io_output_op2_1,
  output  io_output_op2_2,
  output  io_output_op2_3,
  output  io_output_op2_4,
  output  io_output_op2_5,
  output  io_output_op2_6,
  output  io_output_op2_7,
  output  io_output_op2_8,
  output  io_output_op2_9,
  output  io_output_op2_10,
  output  io_output_op2_11,
  output  io_output_op2_12,
  output  io_output_op2_13,
  output  io_output_op2_14,
  output  io_output_op2_15,
  output  io_output_cond_0,
  output  io_output_cond_1,
  output  io_output_cond_2,
  output  io_output_cond_3,
  output  io_output_cond_4,
  output  io_output_cond_5,
  output  io_output_cond_6,
  output  io_output_cond_7,
  output  io_output_cond_8,
  output  io_output_cond_9,
  output  io_output_cond_10,
  output  io_output_cond_11,
  output  io_output_cond_12,
  output  io_output_cond_13,
  output  io_output_cond_14,
  output  io_output_cond_15,
  output  io_output_valid
);
  wire  InvCipherRound_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_1_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_1_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_1_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_2_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_2_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_2_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_3_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_3_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_3_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_4_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_4_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_4_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_5_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_5_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_5_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_6_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_6_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_6_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_7_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_7_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_7_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_8_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_8_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_8_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_9_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_9_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_9_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_10_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_10_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_10_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_11_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_11_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_11_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_12_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_12_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_12_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_13_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_13_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_13_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_14_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_14_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_14_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_15_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_15_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_15_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_16_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_16_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_16_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_17_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_17_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_17_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_18_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_18_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_18_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_19_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_19_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_19_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_20_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_20_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_20_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_21_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_21_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_21_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_22_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_22_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_22_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_23_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_23_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_23_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_24_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_24_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_24_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_25_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_25_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_25_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_26_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_26_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_26_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_27_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_27_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_27_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_28_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_28_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_28_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_29_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_29_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_29_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_30_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_30_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_30_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_31_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_31_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_31_io_output_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_32_clock; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_32_io_input_valid; // @[InvCipherRound.scala 96:79]
  wire  InvCipherRound_32_io_output_valid; // @[InvCipherRound.scala 96:79]
  InvCipherRound InvCipherRound ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_clock),
    .io_input_valid(InvCipherRound_io_input_valid),
    .io_output_valid(InvCipherRound_io_output_valid)
  );
  InvCipherRound InvCipherRound_1 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_1_clock),
    .io_input_valid(InvCipherRound_1_io_input_valid),
    .io_output_valid(InvCipherRound_1_io_output_valid)
  );
  InvCipherRound InvCipherRound_2 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_2_clock),
    .io_input_valid(InvCipherRound_2_io_input_valid),
    .io_output_valid(InvCipherRound_2_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_3 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_3_clock),
    .io_input_valid(InvCipherRound_3_io_input_valid),
    .io_output_valid(InvCipherRound_3_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_4 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_4_clock),
    .io_input_valid(InvCipherRound_4_io_input_valid),
    .io_output_valid(InvCipherRound_4_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_5 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_5_clock),
    .io_input_valid(InvCipherRound_5_io_input_valid),
    .io_output_valid(InvCipherRound_5_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_6 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_6_clock),
    .io_input_valid(InvCipherRound_6_io_input_valid),
    .io_output_valid(InvCipherRound_6_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_7 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_7_clock),
    .io_input_valid(InvCipherRound_7_io_input_valid),
    .io_output_valid(InvCipherRound_7_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_8 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_8_clock),
    .io_input_valid(InvCipherRound_8_io_input_valid),
    .io_output_valid(InvCipherRound_8_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_9 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_9_clock),
    .io_input_valid(InvCipherRound_9_io_input_valid),
    .io_output_valid(InvCipherRound_9_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_10 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_10_clock),
    .io_input_valid(InvCipherRound_10_io_input_valid),
    .io_output_valid(InvCipherRound_10_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_11 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_11_clock),
    .io_input_valid(InvCipherRound_11_io_input_valid),
    .io_output_valid(InvCipherRound_11_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_12 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_12_clock),
    .io_input_valid(InvCipherRound_12_io_input_valid),
    .io_output_valid(InvCipherRound_12_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_13 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_13_clock),
    .io_input_valid(InvCipherRound_13_io_input_valid),
    .io_output_valid(InvCipherRound_13_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_14 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_14_clock),
    .io_input_valid(InvCipherRound_14_io_input_valid),
    .io_output_valid(InvCipherRound_14_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_15 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_15_clock),
    .io_input_valid(InvCipherRound_15_io_input_valid),
    .io_output_valid(InvCipherRound_15_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_16 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_16_clock),
    .io_input_valid(InvCipherRound_16_io_input_valid),
    .io_output_valid(InvCipherRound_16_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_17 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_17_clock),
    .io_input_valid(InvCipherRound_17_io_input_valid),
    .io_output_valid(InvCipherRound_17_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_18 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_18_clock),
    .io_input_valid(InvCipherRound_18_io_input_valid),
    .io_output_valid(InvCipherRound_18_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_19 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_19_clock),
    .io_input_valid(InvCipherRound_19_io_input_valid),
    .io_output_valid(InvCipherRound_19_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_20 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_20_clock),
    .io_input_valid(InvCipherRound_20_io_input_valid),
    .io_output_valid(InvCipherRound_20_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_21 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_21_clock),
    .io_input_valid(InvCipherRound_21_io_input_valid),
    .io_output_valid(InvCipherRound_21_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_22 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_22_clock),
    .io_input_valid(InvCipherRound_22_io_input_valid),
    .io_output_valid(InvCipherRound_22_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_23 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_23_clock),
    .io_input_valid(InvCipherRound_23_io_input_valid),
    .io_output_valid(InvCipherRound_23_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_24 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_24_clock),
    .io_input_valid(InvCipherRound_24_io_input_valid),
    .io_output_valid(InvCipherRound_24_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_25 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_25_clock),
    .io_input_valid(InvCipherRound_25_io_input_valid),
    .io_output_valid(InvCipherRound_25_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_26 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_26_clock),
    .io_input_valid(InvCipherRound_26_io_input_valid),
    .io_output_valid(InvCipherRound_26_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_27 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_27_clock),
    .io_input_valid(InvCipherRound_27_io_input_valid),
    .io_output_valid(InvCipherRound_27_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_28 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_28_clock),
    .io_input_valid(InvCipherRound_28_io_input_valid),
    .io_output_valid(InvCipherRound_28_io_output_valid)
  );
  InvCipherRound_3 InvCipherRound_29 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_29_clock),
    .io_input_valid(InvCipherRound_29_io_input_valid),
    .io_output_valid(InvCipherRound_29_io_output_valid)
  );
  InvCipherRound_30 InvCipherRound_30 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_30_clock),
    .io_input_valid(InvCipherRound_30_io_input_valid),
    .io_output_valid(InvCipherRound_30_io_output_valid)
  );
  InvCipherRound_30 InvCipherRound_31 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_31_clock),
    .io_input_valid(InvCipherRound_31_io_input_valid),
    .io_output_valid(InvCipherRound_31_io_output_valid)
  );
  InvCipherRound_30 InvCipherRound_32 ( // @[InvCipherRound.scala 96:79]
    .clock(InvCipherRound_32_clock),
    .io_input_valid(InvCipherRound_32_io_input_valid),
    .io_output_valid(InvCipherRound_32_io_output_valid)
  );
  assign io_output_op1_0 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_1 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_2 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_3 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_4 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_5 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_6 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_7 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_8 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_9 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_10 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_11 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_12 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_13 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_14 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op1_15 = 1'h1; // @[AESDecrypt.scala 74:17]
  assign io_output_op2_0 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_1 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_2 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_3 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_4 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_5 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_6 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_7 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_8 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_9 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_10 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_11 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_12 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_13 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_14 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_op2_15 = 1'h1; // @[AESDecrypt.scala 75:17]
  assign io_output_cond_0 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_1 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_2 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_3 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_4 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_5 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_6 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_7 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_8 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_9 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_10 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_11 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_12 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_13 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_14 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_cond_15 = 1'h1; // @[AESDecrypt.scala 76:18]
  assign io_output_valid = InvCipherRound_30_io_output_valid & InvCipherRound_31_io_output_valid &
    InvCipherRound_32_io_output_valid; // @[AESDecrypt.scala 77:99]
  assign InvCipherRound_clock = clock;
  assign InvCipherRound_io_input_valid = io_input_valid; // @[AESDecrypt.scala 42:39]
  assign InvCipherRound_1_clock = clock;
  assign InvCipherRound_1_io_input_valid = io_input_valid; // @[AESDecrypt.scala 46:39]
  assign InvCipherRound_2_clock = clock;
  assign InvCipherRound_2_io_input_valid = io_input_valid; // @[AESDecrypt.scala 50:39]
  assign InvCipherRound_3_clock = clock;
  assign InvCipherRound_3_io_input_valid = InvCipherRound_io_output_valid; // @[AESDecrypt.scala 57:46]
  assign InvCipherRound_4_clock = clock;
  assign InvCipherRound_4_io_input_valid = InvCipherRound_3_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_5_clock = clock;
  assign InvCipherRound_5_io_input_valid = InvCipherRound_4_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_6_clock = clock;
  assign InvCipherRound_6_io_input_valid = InvCipherRound_5_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_7_clock = clock;
  assign InvCipherRound_7_io_input_valid = InvCipherRound_6_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_8_clock = clock;
  assign InvCipherRound_8_io_input_valid = InvCipherRound_7_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_9_clock = clock;
  assign InvCipherRound_9_io_input_valid = InvCipherRound_8_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_10_clock = clock;
  assign InvCipherRound_10_io_input_valid = InvCipherRound_9_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_11_clock = clock;
  assign InvCipherRound_11_io_input_valid = InvCipherRound_10_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_12_clock = clock;
  assign InvCipherRound_12_io_input_valid = InvCipherRound_1_io_output_valid; // @[AESDecrypt.scala 57:46]
  assign InvCipherRound_13_clock = clock;
  assign InvCipherRound_13_io_input_valid = InvCipherRound_12_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_14_clock = clock;
  assign InvCipherRound_14_io_input_valid = InvCipherRound_13_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_15_clock = clock;
  assign InvCipherRound_15_io_input_valid = InvCipherRound_14_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_16_clock = clock;
  assign InvCipherRound_16_io_input_valid = InvCipherRound_15_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_17_clock = clock;
  assign InvCipherRound_17_io_input_valid = InvCipherRound_16_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_18_clock = clock;
  assign InvCipherRound_18_io_input_valid = InvCipherRound_17_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_19_clock = clock;
  assign InvCipherRound_19_io_input_valid = InvCipherRound_18_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_20_clock = clock;
  assign InvCipherRound_20_io_input_valid = InvCipherRound_19_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_21_clock = clock;
  assign InvCipherRound_21_io_input_valid = InvCipherRound_2_io_output_valid; // @[AESDecrypt.scala 57:46]
  assign InvCipherRound_22_clock = clock;
  assign InvCipherRound_22_io_input_valid = InvCipherRound_21_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_23_clock = clock;
  assign InvCipherRound_23_io_input_valid = InvCipherRound_22_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_24_clock = clock;
  assign InvCipherRound_24_io_input_valid = InvCipherRound_23_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_25_clock = clock;
  assign InvCipherRound_25_io_input_valid = InvCipherRound_24_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_26_clock = clock;
  assign InvCipherRound_26_io_input_valid = InvCipherRound_25_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_27_clock = clock;
  assign InvCipherRound_27_io_input_valid = InvCipherRound_26_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_28_clock = clock;
  assign InvCipherRound_28_io_input_valid = InvCipherRound_27_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_29_clock = clock;
  assign InvCipherRound_29_io_input_valid = InvCipherRound_28_io_output_valid; // @[AESDecrypt.scala 61:46]
  assign InvCipherRound_30_clock = clock;
  assign InvCipherRound_30_io_input_valid = InvCipherRound_11_io_output_valid; // @[AESDecrypt.scala 69:41]
  assign InvCipherRound_31_clock = clock;
  assign InvCipherRound_31_io_input_valid = InvCipherRound_20_io_output_valid; // @[AESDecrypt.scala 69:41]
  assign InvCipherRound_32_clock = clock;
  assign InvCipherRound_32_io_input_valid = InvCipherRound_29_io_output_valid; // @[AESDecrypt.scala 69:41]
  assign io_output_valid = 1'h1;
endmodule
module AESEncrypt(
  input   clock,
  input   io_input_valid,
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
  wire  CipherRoundARK_clock; // @[CipherRound.scala 95:84]
  wire  CipherRoundARK_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRoundARK_io_output_valid; // @[CipherRound.scala 95:84]
  InvCipherRound CipherRoundARK ( // @[CipherRound.scala 95:84]
    .clock(CipherRoundARK_clock),
    .io_input_valid(CipherRoundARK_io_input_valid),
    .io_output_valid(CipherRoundARK_io_output_valid)
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
  assign CipherRoundARK_clock = clock;
  assign CipherRoundARK_io_input_valid = io_input_valid; // @[AESEncrypt.scala 31:33]
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
`endif // RANDOMIZE_REG_INIT
  wire  seoperation_io_op1_input; // @[SE.scala 76:33]
  wire  seoperation_io_op2_input; // @[SE.scala 76:33]
  wire  seoperation_io_cond_input; // @[SE.scala 76:33]
  wire  aes_invcipher_clock; // @[SE.scala 77:35]
  wire  aes_invcipher_io_input_valid; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_0; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_1; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_2; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_3; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_4; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_5; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_6; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_7; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_8; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_9; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_10; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_11; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_12; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_13; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_14; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op1_15; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_0; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_1; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_2; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_3; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_4; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_5; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_6; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_7; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_8; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_9; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_10; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_11; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_12; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_13; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_14; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_op2_15; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_0; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_1; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_2; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_3; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_4; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_5; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_6; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_7; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_8; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_9; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_10; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_11; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_12; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_13; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_14; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_cond_15; // @[SE.scala 77:35]
  wire  aes_invcipher_io_output_valid; // @[SE.scala 77:35]
  wire  aes_cipher_clock; // @[SE.scala 78:32]
  wire  aes_cipher_io_input_valid; // @[SE.scala 78:32]
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
  reg  inst_buffer; // @[Reg.scala 15:16]
  reg  op1_buffer; // @[Reg.scala 15:16]
  reg  op2_buffer; // @[Reg.scala 15:16]
  reg  cond_buffer; // @[Reg.scala 15:16]
  reg  valid_buffer; // @[SE.scala 106:31]
  reg  ready_for_input; // @[SE.scala 109:38]
  wire  _T_8 = 1'h1 & op1_buffer; // @[SE.scala 140:41]
  wire  _T_55 = 1'h1 & op1_buffer & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer
    ) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1
     & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & _T_8; // @[SE.scala 140:41]
  wire  _T_70 = _T_55 & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 &
    op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 &
    op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 & op1_buffer) & (1'h1 &
    op1_buffer); // @[SE.scala 140:41]
  wire  op1_found = _T_70 & (1'h1 & op1_buffer); // @[SE.scala 140:41]
  wire  _T_71 = 1'h1 & op2_buffer; // @[SE.scala 141:41]
  wire  _T_118 = 1'h1 & op2_buffer & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 &
    op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 &
    op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 &
    op2_buffer) & _T_71; // @[SE.scala 141:41]
  wire  _T_133 = _T_118 & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1
     & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 &
    op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 & op2_buffer) & (1'h1 &
    op2_buffer); // @[SE.scala 141:41]
  wire  op2_found = _T_133 & (1'h1 & op2_buffer); // @[SE.scala 141:41]
  wire  _T_136 = 1'h1 & cond_buffer; // @[SE.scala 144:47]
  wire  _T_183 = 1'h1 & cond_buffer & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 &
    cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 &
    cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 &
    cond_buffer) & _T_136; // @[SE.scala 144:47]
  wire  _T_198 = _T_183 & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1
     & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1
     & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1 & cond_buffer) & (1'h1
     & cond_buffer); // @[SE.scala 144:47]
  wire  cond_found = _T_198 & (1'h1 & cond_buffer) & 1'h1; // @[SE.scala 143:48 144:28 146:28]
  wire  all_match = op1_found & op2_found & cond_found; // @[SE.scala 152:48]
  wire  _GEN_9 = _T_1 & ready_for_input; // @[SE.scala 116:49 117:33 109:38]
  wire  _GEN_10 = 1'h1 & _GEN_9; // @[SE.scala 114:41 115:33]
  reg  mid_inst_buffer; // @[Reg.scala 15:16]
  reg  mid_op1_buffer; // @[Reg.scala 15:16]
  wire  _T_441 = all_match & valid_buffer; // @[SE.scala 177:45]
  wire  seOpValid = aes_invcipher_io_output_valid & _T_441; // @[SE.scala 178:55]
  wire  op1_reverse_1 = aes_invcipher_io_output_op1_14; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_0 = aes_invcipher_io_output_op1_15; // @[SE.scala 164:31 168:32]
  wire  lo_lo_lo = op1_reverse_1 & op1_reverse_0; // @[SE.scala 180:38]
  wire  op1_reverse_3 = aes_invcipher_io_output_op1_12; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_2 = aes_invcipher_io_output_op1_13; // @[SE.scala 164:31 168:32]
  wire  lo_lo_hi = op1_reverse_3 & op1_reverse_2; // @[SE.scala 180:38]
  wire  lo_lo = lo_lo_hi & lo_lo_lo; // @[SE.scala 180:38]
  wire  op1_reverse_5 = aes_invcipher_io_output_op1_10; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_4 = aes_invcipher_io_output_op1_11; // @[SE.scala 164:31 168:32]
  wire  lo_hi_lo = op1_reverse_5 & op1_reverse_4; // @[SE.scala 180:38]
  wire  op1_reverse_7 = aes_invcipher_io_output_op1_8; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_6 = aes_invcipher_io_output_op1_9; // @[SE.scala 164:31 168:32]
  wire  lo_hi_hi = op1_reverse_7 & op1_reverse_6; // @[SE.scala 180:38]
  wire  lo_hi = lo_hi_hi & lo_hi_lo; // @[SE.scala 180:38]
  wire  lo = lo_hi & lo_lo; // @[SE.scala 180:38]
  wire  op1_reverse_9 = aes_invcipher_io_output_op1_6; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_8 = aes_invcipher_io_output_op1_7; // @[SE.scala 164:31 168:32]
  wire  hi_lo_lo = op1_reverse_9 & op1_reverse_8; // @[SE.scala 180:38]
  wire  op1_reverse_11 = aes_invcipher_io_output_op1_4; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_10 = aes_invcipher_io_output_op1_5; // @[SE.scala 164:31 168:32]
  wire  hi_lo_hi = op1_reverse_11 & op1_reverse_10; // @[SE.scala 180:38]
  wire  hi_lo = hi_lo_hi & hi_lo_lo; // @[SE.scala 180:38]
  wire  op1_reverse_13 = aes_invcipher_io_output_op1_2; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_12 = aes_invcipher_io_output_op1_3; // @[SE.scala 164:31 168:32]
  wire  hi_hi_lo = op1_reverse_13 & op1_reverse_12; // @[SE.scala 180:38]
  wire  op1_reverse_15 = aes_invcipher_io_output_op1_0; // @[SE.scala 164:31 168:32]
  wire  op1_reverse_14 = aes_invcipher_io_output_op1_1; // @[SE.scala 164:31 168:32]
  wire  hi_hi_hi = op1_reverse_15 & op1_reverse_14; // @[SE.scala 180:38]
  wire  hi_hi = hi_hi_hi & hi_hi_lo; // @[SE.scala 180:38]
  wire  hi = hi_hi & hi_lo; // @[SE.scala 180:38]
  wire  op1_asUInt = hi & lo; // @[SE.scala 180:38]
  wire  op2_reverse_1 = aes_invcipher_io_output_op2_14; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_0 = aes_invcipher_io_output_op2_15; // @[SE.scala 165:31 169:32]
  wire  lo_lo_lo_1 = op2_reverse_1 & op2_reverse_0; // @[SE.scala 181:38]
  wire  op2_reverse_3 = aes_invcipher_io_output_op2_12; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_2 = aes_invcipher_io_output_op2_13; // @[SE.scala 165:31 169:32]
  wire  lo_lo_hi_1 = op2_reverse_3 & op2_reverse_2; // @[SE.scala 181:38]
  wire  lo_lo_1 = lo_lo_hi_1 & lo_lo_lo_1; // @[SE.scala 181:38]
  wire  op2_reverse_5 = aes_invcipher_io_output_op2_10; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_4 = aes_invcipher_io_output_op2_11; // @[SE.scala 165:31 169:32]
  wire  lo_hi_lo_1 = op2_reverse_5 & op2_reverse_4; // @[SE.scala 181:38]
  wire  op2_reverse_7 = aes_invcipher_io_output_op2_8; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_6 = aes_invcipher_io_output_op2_9; // @[SE.scala 165:31 169:32]
  wire  lo_hi_hi_1 = op2_reverse_7 & op2_reverse_6; // @[SE.scala 181:38]
  wire  lo_hi_1 = lo_hi_hi_1 & lo_hi_lo_1; // @[SE.scala 181:38]
  wire  lo_1 = lo_hi_1 & lo_lo_1; // @[SE.scala 181:38]
  wire  op2_reverse_9 = aes_invcipher_io_output_op2_6; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_8 = aes_invcipher_io_output_op2_7; // @[SE.scala 165:31 169:32]
  wire  hi_lo_lo_1 = op2_reverse_9 & op2_reverse_8; // @[SE.scala 181:38]
  wire  op2_reverse_11 = aes_invcipher_io_output_op2_4; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_10 = aes_invcipher_io_output_op2_5; // @[SE.scala 165:31 169:32]
  wire  hi_lo_hi_1 = op2_reverse_11 & op2_reverse_10; // @[SE.scala 181:38]
  wire  hi_lo_1 = hi_lo_hi_1 & hi_lo_lo_1; // @[SE.scala 181:38]
  wire  op2_reverse_13 = aes_invcipher_io_output_op2_2; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_12 = aes_invcipher_io_output_op2_3; // @[SE.scala 165:31 169:32]
  wire  hi_hi_lo_1 = op2_reverse_13 & op2_reverse_12; // @[SE.scala 181:38]
  wire  op2_reverse_15 = aes_invcipher_io_output_op2_0; // @[SE.scala 165:31 169:32]
  wire  op2_reverse_14 = aes_invcipher_io_output_op2_1; // @[SE.scala 165:31 169:32]
  wire  hi_hi_hi_1 = op2_reverse_15 & op2_reverse_14; // @[SE.scala 181:38]
  wire  hi_hi_1 = hi_hi_hi_1 & hi_hi_lo_1; // @[SE.scala 181:38]
  wire  hi_1 = hi_hi_1 & hi_lo_1; // @[SE.scala 181:38]
  wire  op2_asUInt = hi_1 & lo_1; // @[SE.scala 181:38]
  wire  cond_reverse_1 = aes_invcipher_io_output_cond_14; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_0 = aes_invcipher_io_output_cond_15; // @[SE.scala 166:32 170:33]
  wire  lo_lo_lo_2 = cond_reverse_1 & cond_reverse_0; // @[SE.scala 182:40]
  wire  cond_reverse_3 = aes_invcipher_io_output_cond_12; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_2 = aes_invcipher_io_output_cond_13; // @[SE.scala 166:32 170:33]
  wire  lo_lo_hi_2 = cond_reverse_3 & cond_reverse_2; // @[SE.scala 182:40]
  wire  lo_lo_2 = lo_lo_hi_2 & lo_lo_lo_2; // @[SE.scala 182:40]
  wire  cond_reverse_5 = aes_invcipher_io_output_cond_10; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_4 = aes_invcipher_io_output_cond_11; // @[SE.scala 166:32 170:33]
  wire  lo_hi_lo_2 = cond_reverse_5 & cond_reverse_4; // @[SE.scala 182:40]
  wire  cond_reverse_7 = aes_invcipher_io_output_cond_8; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_6 = aes_invcipher_io_output_cond_9; // @[SE.scala 166:32 170:33]
  wire  lo_hi_hi_2 = cond_reverse_7 & cond_reverse_6; // @[SE.scala 182:40]
  wire  lo_hi_2 = lo_hi_hi_2 & lo_hi_lo_2; // @[SE.scala 182:40]
  wire  lo_2 = lo_hi_2 & lo_lo_2; // @[SE.scala 182:40]
  wire  cond_reverse_9 = aes_invcipher_io_output_cond_6; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_8 = aes_invcipher_io_output_cond_7; // @[SE.scala 166:32 170:33]
  wire  hi_lo_lo_2 = cond_reverse_9 & cond_reverse_8; // @[SE.scala 182:40]
  wire  cond_reverse_11 = aes_invcipher_io_output_cond_4; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_10 = aes_invcipher_io_output_cond_5; // @[SE.scala 166:32 170:33]
  wire  hi_lo_hi_2 = cond_reverse_11 & cond_reverse_10; // @[SE.scala 182:40]
  wire  hi_lo_2 = hi_lo_hi_2 & hi_lo_lo_2; // @[SE.scala 182:40]
  wire  cond_reverse_13 = aes_invcipher_io_output_cond_2; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_12 = aes_invcipher_io_output_cond_3; // @[SE.scala 166:32 170:33]
  wire  hi_hi_lo_2 = cond_reverse_13 & cond_reverse_12; // @[SE.scala 182:40]
  wire  cond_reverse_15 = aes_invcipher_io_output_cond_0; // @[SE.scala 166:32 170:33]
  wire  cond_reverse_14 = aes_invcipher_io_output_cond_1; // @[SE.scala 166:32 170:33]
  wire  hi_hi_hi_2 = cond_reverse_15 & cond_reverse_14; // @[SE.scala 182:40]
  wire  hi_hi_2 = hi_hi_hi_2 & hi_hi_lo_2; // @[SE.scala 182:40]
  wire  hi_2 = hi_hi_2 & hi_lo_2; // @[SE.scala 182:40]
  wire  cond_asUInt = hi_2 & lo_2; // @[SE.scala 182:40]
  wire  _T_445 = reset; // @[SE.scala 188:15]
  wire  _T_458 = mid_op1_buffer; // @[SE.scala 196:95]
  wire  _T_459 = op1_asUInt; // @[SE.scala 196:114]
  wire  _T_460 = _T_458 & _T_459; // @[SE.scala 196:45]
  wire  _T_463 = op2_asUInt; // @[SE.scala 197:52]
  wire  _T_466 = cond_asUInt; // @[SE.scala 198:54]
  reg  result_valid_buffer; // @[SE.scala 207:42]
  wire  lo_lo_lo_4 = aes_cipher_io_output_text_1 & aes_cipher_io_output_text_0; // @[SE.scala 236:65]
  wire  lo_lo_hi_4 = aes_cipher_io_output_text_3 & aes_cipher_io_output_text_2; // @[SE.scala 236:65]
  wire  lo_lo_4 = lo_lo_hi_4 & lo_lo_lo_4; // @[SE.scala 236:65]
  wire  lo_hi_lo_4 = aes_cipher_io_output_text_5 & aes_cipher_io_output_text_4; // @[SE.scala 236:65]
  wire  lo_hi_hi_4 = aes_cipher_io_output_text_7 & aes_cipher_io_output_text_6; // @[SE.scala 236:65]
  wire  lo_hi_4 = lo_hi_hi_4 & lo_hi_lo_4; // @[SE.scala 236:65]
  wire  lo_4 = lo_hi_4 & lo_lo_4; // @[SE.scala 236:65]
  wire  hi_lo_lo_4 = aes_cipher_io_output_text_9 & aes_cipher_io_output_text_8; // @[SE.scala 236:65]
  wire  hi_lo_hi_4 = aes_cipher_io_output_text_11 & aes_cipher_io_output_text_10; // @[SE.scala 236:65]
  wire  hi_lo_4 = hi_lo_hi_4 & hi_lo_lo_4; // @[SE.scala 236:65]
  wire  hi_hi_lo_4 = aes_cipher_io_output_text_13 & aes_cipher_io_output_text_12; // @[SE.scala 236:65]
  wire  hi_hi_hi_4 = aes_cipher_io_output_text_15 & aes_cipher_io_output_text_14; // @[SE.scala 236:65]
  wire  hi_hi_4 = hi_hi_hi_4 & hi_hi_lo_4; // @[SE.scala 236:65]
  wire  hi_4 = hi_hi_4 & hi_lo_4; // @[SE.scala 236:65]
  wire  _T_502 = hi_4 & lo_4; // @[SE.scala 236:65]
  reg  output_buffer; // @[Reg.scala 15:16]
  reg  output_valid; // @[SE.scala 237:35]
  wire  _GEN_113 = 1'h1 & output_valid; // @[SE.scala 241:49 242:30 237:35]
  wire  _GEN_114 = aes_cipher_io_output_valid & _GEN_113; // @[SE.scala 239:41 240:30]
  SEOperation seoperation ( // @[SE.scala 76:33]
    .io_op1_input(seoperation_io_op1_input),
    .io_op2_input(seoperation_io_op2_input),
    .io_cond_input(seoperation_io_cond_input)
  );
  AESDecrypt aes_invcipher ( // @[SE.scala 77:35]
    .clock(aes_invcipher_clock),
    .io_input_valid(aes_invcipher_io_input_valid),
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
  AESEncrypt aes_cipher ( // @[SE.scala 78:32]
    .clock(aes_cipher_clock),
    .io_input_valid(aes_cipher_io_input_valid),
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
  assign io_out_result = output_buffer; // @[SE.scala 245:23]
  assign io_out_valid = output_valid; // @[SE.scala 244:22]
  assign io_out_cntr = value; // @[SE.scala 71:21]
  assign seoperation_io_op1_input = 1'h1 & _T_460; // @[SE.scala 202:40]
  assign seoperation_io_op2_input = 1'h1 & _T_463; // @[SE.scala 203:40]
  assign seoperation_io_cond_input = 1'h1 & _T_466; // @[SE.scala 204:41]
  assign aes_invcipher_clock = clock;
  assign aes_invcipher_io_input_valid = valid_buffer & all_match; // @[SE.scala 159:54]
  assign aes_cipher_clock = clock;
  assign aes_cipher_io_input_valid = result_valid_buffer; // @[SE.scala 232:35]
  always @(posedge clock) begin
    value <= 1'h1 & _GEN_4; // @[Counter.scala 60:{40,40}]
    inst_buffer <= io_in_inst & inst_buffer; // @[Reg.scala 15:16 16:{19,23}]
    op1_buffer <= io_in_op1 & op1_buffer; // @[Reg.scala 15:16 16:{19,23}]
    op2_buffer <= io_in_op2 & op2_buffer; // @[Reg.scala 15:16 16:{19,23}]
    cond_buffer <= io_in_cond & cond_buffer; // @[Reg.scala 15:16 16:{19,23}]
    valid_buffer <= _T & (1'h1 & valid_buffer); // @[SE.scala 113:28]
    ready_for_input <= reset & _GEN_10; // @[SE.scala 109:{38,38}]
    mid_inst_buffer <= inst_buffer & mid_inst_buffer; // @[Reg.scala 15:16 16:{19,23}]
    mid_op1_buffer <= op1_buffer & mid_op1_buffer; // @[Reg.scala 15:16 16:{19,23}]
    result_valid_buffer <= seOpValid & (1'h1 & result_valid_buffer); // @[SE.scala 208:37]
    output_buffer <= _T_502 & output_buffer; // @[Reg.scala 15:16 16:{19,23}]
    output_valid <= 1'h1 & _GEN_114; // @[SE.scala 237:{35,35}]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (reset) begin
          $fwrite(32'h80000002,"aes_invcipher.io.output_valid: %d\n",aes_invcipher_io_output_valid); // @[SE.scala 188:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_445) begin
          $fwrite(32'h80000002,"aes_invcipher.io.input_valid: %d\n",aes_invcipher_io_input_valid); // @[SE.scala 189:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"\n-----mid----\n"); // @[SE.scala 192:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"op1_asUInt:%x\n",seoperation_io_op1_input); // @[SE.scala 193:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"op2_asUInt:%x\n",seoperation_io_op2_input); // @[SE.scala 194:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"cond_asUInt:%x\n",seoperation_io_cond_input); // @[SE.scala 195:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"op1_asUInt:%x\n",_T_458 & _T_459); // @[SE.scala 196:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"op2_asUInt:%x\n",op2_asUInt); // @[SE.scala 197:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"cond_asUInt:%x\n",cond_asUInt); // @[SE.scala 198:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (seOpValid & _T_445) begin
          $fwrite(32'h80000002,"inst:%b\n",mid_inst_buffer); // @[SE.scala 199:23]
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
  inst_buffer = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  op1_buffer = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  op2_buffer = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cond_buffer = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  valid_buffer = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  ready_for_input = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  mid_inst_buffer = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mid_op1_buffer = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  result_valid_buffer = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  output_buffer = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  output_valid = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
