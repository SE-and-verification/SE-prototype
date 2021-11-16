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
module CipherRound_1(
  input   clock,
  input   io_input_valid,
  output  io_output_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  r_1; // @[Reg.scala 15:16]
  assign io_output_valid = r_1; // @[CipherRound.scala 89:21]
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
module CipherRound_10(
  input   clock,
  input   io_input_valid,
  output  io_output_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  r_1; // @[Reg.scala 15:16]
  assign io_output_valid = r_1; // @[CipherRound.scala 62:21]
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
  wire  CipherRound_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_1_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_1_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_1_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_2_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_2_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_2_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_3_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_3_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_3_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_4_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_4_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_4_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_5_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_5_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_5_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_6_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_6_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_6_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_7_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_7_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_7_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_8_clock; // @[CipherRound.scala 95:84]
  wire  CipherRound_8_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRound_8_io_output_valid; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_clock; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_input_valid; // @[CipherRound.scala 95:84]
  wire  CipherRoundNMC_io_output_valid; // @[CipherRound.scala 95:84]
  InvCipherRound CipherRoundARK ( // @[CipherRound.scala 95:84]
    .clock(CipherRoundARK_clock),
    .io_input_valid(CipherRoundARK_io_input_valid),
    .io_output_valid(CipherRoundARK_io_output_valid)
  );
  CipherRound_1 CipherRound ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_clock),
    .io_input_valid(CipherRound_io_input_valid),
    .io_output_valid(CipherRound_io_output_valid)
  );
  CipherRound_1 CipherRound_1 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_1_clock),
    .io_input_valid(CipherRound_1_io_input_valid),
    .io_output_valid(CipherRound_1_io_output_valid)
  );
  CipherRound_1 CipherRound_2 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_2_clock),
    .io_input_valid(CipherRound_2_io_input_valid),
    .io_output_valid(CipherRound_2_io_output_valid)
  );
  CipherRound_1 CipherRound_3 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_3_clock),
    .io_input_valid(CipherRound_3_io_input_valid),
    .io_output_valid(CipherRound_3_io_output_valid)
  );
  CipherRound_1 CipherRound_4 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_4_clock),
    .io_input_valid(CipherRound_4_io_input_valid),
    .io_output_valid(CipherRound_4_io_output_valid)
  );
  CipherRound_1 CipherRound_5 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_5_clock),
    .io_input_valid(CipherRound_5_io_input_valid),
    .io_output_valid(CipherRound_5_io_output_valid)
  );
  CipherRound_1 CipherRound_6 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_6_clock),
    .io_input_valid(CipherRound_6_io_input_valid),
    .io_output_valid(CipherRound_6_io_output_valid)
  );
  CipherRound_1 CipherRound_7 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_7_clock),
    .io_input_valid(CipherRound_7_io_input_valid),
    .io_output_valid(CipherRound_7_io_output_valid)
  );
  CipherRound_1 CipherRound_8 ( // @[CipherRound.scala 95:84]
    .clock(CipherRound_8_clock),
    .io_input_valid(CipherRound_8_io_input_valid),
    .io_output_valid(CipherRound_8_io_output_valid)
  );
  CipherRound_10 CipherRoundNMC ( // @[CipherRound.scala 95:84]
    .clock(CipherRoundNMC_clock),
    .io_input_valid(CipherRoundNMC_io_input_valid),
    .io_output_valid(CipherRoundNMC_io_output_valid)
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
  assign io_output_valid = CipherRoundNMC_io_output_valid; // @[AESEncrypt.scala 53:19]
  assign CipherRoundARK_clock = clock;
  assign CipherRoundARK_io_input_valid = io_input_valid; // @[AESEncrypt.scala 31:33]
  assign CipherRound_clock = clock;
  assign CipherRound_io_input_valid = CipherRoundARK_io_output_valid; // @[AESEncrypt.scala 38:38]
  assign CipherRound_1_clock = clock;
  assign CipherRound_1_io_input_valid = CipherRound_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_2_clock = clock;
  assign CipherRound_2_io_input_valid = CipherRound_1_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_3_clock = clock;
  assign CipherRound_3_io_input_valid = CipherRound_2_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_4_clock = clock;
  assign CipherRound_4_io_input_valid = CipherRound_3_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_5_clock = clock;
  assign CipherRound_5_io_input_valid = CipherRound_4_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_6_clock = clock;
  assign CipherRound_6_io_input_valid = CipherRound_5_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_7_clock = clock;
  assign CipherRound_7_io_input_valid = CipherRound_6_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRound_8_clock = clock;
  assign CipherRound_8_io_input_valid = CipherRound_7_io_output_valid; // @[AESEncrypt.scala 42:38]
  assign CipherRoundNMC_clock = clock;
  assign CipherRoundNMC_io_input_valid = CipherRound_8_io_output_valid; // @[AESEncrypt.scala 49:33]
  assign io_output_valid = 1'h0;
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
`endif // RANDOMIZE_REG_INIT
  wire  aes_invcipher_clock; // @[SE.scala 77:35]
  wire  aes_invcipher_io_input_valid; // @[SE.scala 77:35]
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
  reg  valid_buffer; // @[SE.scala 103:31]
  reg  ready_for_input; // @[SE.scala 106:38]
  wire  _GEN_9 = _T_1 & ready_for_input; // @[SE.scala 112:49 113:33 106:38]
  wire  _GEN_10 = 1'h1 & _GEN_9; // @[SE.scala 110:41 111:33]
  reg  result_valid_buffer; // @[SE.scala 177:42]
  wire  lo_lo_lo_4 = aes_cipher_io_output_text_1 & aes_cipher_io_output_text_0; // @[SE.scala 202:65]
  wire  lo_lo_hi_4 = aes_cipher_io_output_text_3 & aes_cipher_io_output_text_2; // @[SE.scala 202:65]
  wire  lo_lo_4 = lo_lo_hi_4 & lo_lo_lo_4; // @[SE.scala 202:65]
  wire  lo_hi_lo_4 = aes_cipher_io_output_text_5 & aes_cipher_io_output_text_4; // @[SE.scala 202:65]
  wire  lo_hi_hi_4 = aes_cipher_io_output_text_7 & aes_cipher_io_output_text_6; // @[SE.scala 202:65]
  wire  lo_hi_4 = lo_hi_hi_4 & lo_hi_lo_4; // @[SE.scala 202:65]
  wire  lo_4 = lo_hi_4 & lo_lo_4; // @[SE.scala 202:65]
  wire  hi_lo_lo_4 = aes_cipher_io_output_text_9 & aes_cipher_io_output_text_8; // @[SE.scala 202:65]
  wire  hi_lo_hi_4 = aes_cipher_io_output_text_11 & aes_cipher_io_output_text_10; // @[SE.scala 202:65]
  wire  hi_lo_4 = hi_lo_hi_4 & hi_lo_lo_4; // @[SE.scala 202:65]
  wire  hi_hi_lo_4 = aes_cipher_io_output_text_13 & aes_cipher_io_output_text_12; // @[SE.scala 202:65]
  wire  hi_hi_hi_4 = aes_cipher_io_output_text_15 & aes_cipher_io_output_text_14; // @[SE.scala 202:65]
  wire  hi_hi_4 = hi_hi_hi_4 & hi_hi_lo_4; // @[SE.scala 202:65]
  wire  hi_4 = hi_hi_4 & hi_lo_4; // @[SE.scala 202:65]
  wire  _T_81 = hi_4 & lo_4; // @[SE.scala 202:65]
  reg  output_buffer; // @[Reg.scala 15:16]
  reg  output_valid; // @[SE.scala 203:35]
  wire  _GEN_15 = 1'h1 & output_valid; // @[SE.scala 207:49 208:30 203:35]
  wire  _GEN_16 = aes_cipher_io_output_valid & _GEN_15; // @[SE.scala 205:41 206:30]
  AESDecrypt aes_invcipher ( // @[SE.scala 77:35]
    .clock(aes_invcipher_clock),
    .io_input_valid(aes_invcipher_io_input_valid),
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
  assign io_in_ready = ready_for_input; // @[SE.scala 107:21]
  assign io_out_result = output_buffer; // @[SE.scala 211:23]
  assign io_out_valid = output_valid; // @[SE.scala 210:22]
  assign io_out_cntr = value; // @[SE.scala 71:21]
  assign aes_invcipher_clock = clock;
  assign aes_invcipher_io_input_valid = valid_buffer; // @[SE.scala 139:38]
  assign aes_cipher_clock = clock;
  assign aes_cipher_io_input_valid = result_valid_buffer; // @[SE.scala 198:35]
  always @(posedge clock) begin
    value <= 1'h1 & _GEN_4; // @[Counter.scala 60:{40,40}]
    valid_buffer <= _T & (1'h1 & valid_buffer); // @[SE.scala 109:28]
    ready_for_input <= reset & _GEN_10; // @[SE.scala 106:{38,38}]
    result_valid_buffer <= aes_invcipher_io_output_valid & (1'h1 & result_valid_buffer); // @[SE.scala 178:37]
    output_buffer <= _T_81 & output_buffer; // @[Reg.scala 15:16 16:{19,23}]
    output_valid <= 1'h1 & _GEN_16; // @[SE.scala 203:{35,35}]
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
  valid_buffer = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  ready_for_input = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  result_valid_buffer = _RAND_3[0:0];
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
