circuit SEOperation :
  module SEControl :
    input clock : Clock
    input reset : UInt<1>
    input io_inst_in : UInt<8>
    output io_inst_out : UInt<8>
    output io_fu_op : UInt<3>
    output io_fu_type : UInt<2>
    output io_legal : UInt<1>
    output io_signed : UInt<1>

    node _ctrlSignals_T = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_1 = eq(UInt<1>("h0"), _ctrlSignals_T) @[Lookup.scala 31:38]
    node _ctrlSignals_T_2 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_3 = eq(UInt<3>("h4"), _ctrlSignals_T_2) @[Lookup.scala 31:38]
    node _ctrlSignals_T_4 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_5 = eq(UInt<4>("h8"), _ctrlSignals_T_4) @[Lookup.scala 31:38]
    node _ctrlSignals_T_6 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_7 = eq(UInt<6>("h20"), _ctrlSignals_T_6) @[Lookup.scala 31:38]
    node _ctrlSignals_T_8 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_9 = eq(UInt<6>("h24"), _ctrlSignals_T_8) @[Lookup.scala 31:38]
    node _ctrlSignals_T_10 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_11 = eq(UInt<6>("h28"), _ctrlSignals_T_10) @[Lookup.scala 31:38]
    node _ctrlSignals_T_12 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_13 = eq(UInt<6>("h29"), _ctrlSignals_T_12) @[Lookup.scala 31:38]
    node _ctrlSignals_T_14 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_15 = eq(UInt<8>("h80"), _ctrlSignals_T_14) @[Lookup.scala 31:38]
    node _ctrlSignals_T_16 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_17 = eq(UInt<8>("h84"), _ctrlSignals_T_16) @[Lookup.scala 31:38]
    node _ctrlSignals_T_18 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_19 = eq(UInt<8>("h88"), _ctrlSignals_T_18) @[Lookup.scala 31:38]
    node _ctrlSignals_T_20 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_21 = eq(UInt<7>("h40"), _ctrlSignals_T_20) @[Lookup.scala 31:38]
    node _ctrlSignals_T_22 = and(io_inst_in, UInt<8>("hff")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_23 = eq(UInt<7>("h41"), _ctrlSignals_T_22) @[Lookup.scala 31:38]
    node _ctrlSignals_T_24 = and(io_inst_in, UInt<8>("he0")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_25 = eq(UInt<7>("h60"), _ctrlSignals_T_24) @[Lookup.scala 31:38]
    node _ctrlSignals_T_26 = and(io_inst_in, UInt<8>("he0")) @[Lookup.scala 31:38]
    node _ctrlSignals_T_27 = eq(UInt<8>("ha0"), _ctrlSignals_T_26) @[Lookup.scala 31:38]
    node _ctrlSignals_T_28 = mux(_ctrlSignals_T_27, UInt<3>("h5"), UInt<3>("h6")) @[Lookup.scala 34:39]
    node _ctrlSignals_T_29 = mux(_ctrlSignals_T_25, UInt<3>("h3"), _ctrlSignals_T_28) @[Lookup.scala 34:39]
    node _ctrlSignals_T_30 = mux(_ctrlSignals_T_23, UInt<3>("h2"), _ctrlSignals_T_29) @[Lookup.scala 34:39]
    node _ctrlSignals_T_31 = mux(_ctrlSignals_T_21, UInt<3>("h2"), _ctrlSignals_T_30) @[Lookup.scala 34:39]
    node _ctrlSignals_T_32 = mux(_ctrlSignals_T_19, UInt<3>("h4"), _ctrlSignals_T_31) @[Lookup.scala 34:39]
    node _ctrlSignals_T_33 = mux(_ctrlSignals_T_17, UInt<3>("h4"), _ctrlSignals_T_32) @[Lookup.scala 34:39]
    node _ctrlSignals_T_34 = mux(_ctrlSignals_T_15, UInt<3>("h4"), _ctrlSignals_T_33) @[Lookup.scala 34:39]
    node _ctrlSignals_T_35 = mux(_ctrlSignals_T_13, UInt<3>("h1"), _ctrlSignals_T_34) @[Lookup.scala 34:39]
    node _ctrlSignals_T_36 = mux(_ctrlSignals_T_11, UInt<3>("h1"), _ctrlSignals_T_35) @[Lookup.scala 34:39]
    node _ctrlSignals_T_37 = mux(_ctrlSignals_T_9, UInt<3>("h1"), _ctrlSignals_T_36) @[Lookup.scala 34:39]
    node _ctrlSignals_T_38 = mux(_ctrlSignals_T_7, UInt<3>("h1"), _ctrlSignals_T_37) @[Lookup.scala 34:39]
    node _ctrlSignals_T_39 = mux(_ctrlSignals_T_5, UInt<3>("h0"), _ctrlSignals_T_38) @[Lookup.scala 34:39]
    node _ctrlSignals_T_40 = mux(_ctrlSignals_T_3, UInt<3>("h0"), _ctrlSignals_T_39) @[Lookup.scala 34:39]
    node ctrlSignals_0 = mux(_ctrlSignals_T_1, UInt<3>("h0"), _ctrlSignals_T_40) @[Lookup.scala 34:39]
    node _ctrlSignals_T_41 = mux(_ctrlSignals_T_27, UInt<2>("h0"), UInt<2>("h2")) @[Lookup.scala 34:39]
    node _ctrlSignals_T_42 = mux(_ctrlSignals_T_25, UInt<2>("h0"), _ctrlSignals_T_41) @[Lookup.scala 34:39]
    node _ctrlSignals_T_43 = mux(_ctrlSignals_T_23, UInt<2>("h0"), _ctrlSignals_T_42) @[Lookup.scala 34:39]
    node _ctrlSignals_T_44 = mux(_ctrlSignals_T_21, UInt<2>("h0"), _ctrlSignals_T_43) @[Lookup.scala 34:39]
    node _ctrlSignals_T_45 = mux(_ctrlSignals_T_19, UInt<2>("h2"), _ctrlSignals_T_44) @[Lookup.scala 34:39]
    node _ctrlSignals_T_46 = mux(_ctrlSignals_T_17, UInt<2>("h1"), _ctrlSignals_T_45) @[Lookup.scala 34:39]
    node _ctrlSignals_T_47 = mux(_ctrlSignals_T_15, UInt<2>("h0"), _ctrlSignals_T_46) @[Lookup.scala 34:39]
    node _ctrlSignals_T_48 = mux(_ctrlSignals_T_13, UInt<2>("h2"), _ctrlSignals_T_47) @[Lookup.scala 34:39]
    node _ctrlSignals_T_49 = mux(_ctrlSignals_T_11, UInt<2>("h2"), _ctrlSignals_T_48) @[Lookup.scala 34:39]
    node _ctrlSignals_T_50 = mux(_ctrlSignals_T_9, UInt<2>("h1"), _ctrlSignals_T_49) @[Lookup.scala 34:39]
    node _ctrlSignals_T_51 = mux(_ctrlSignals_T_7, UInt<2>("h0"), _ctrlSignals_T_50) @[Lookup.scala 34:39]
    node _ctrlSignals_T_52 = mux(_ctrlSignals_T_5, UInt<2>("h2"), _ctrlSignals_T_51) @[Lookup.scala 34:39]
    node _ctrlSignals_T_53 = mux(_ctrlSignals_T_3, UInt<2>("h1"), _ctrlSignals_T_52) @[Lookup.scala 34:39]
    node ctrlSignals_1 = mux(_ctrlSignals_T_1, UInt<2>("h0"), _ctrlSignals_T_53) @[Lookup.scala 34:39]
    node _ctrlSignals_T_54 = mux(_ctrlSignals_T_27, UInt<1>("h1"), UInt<1>("h1")) @[Lookup.scala 34:39]
    node _ctrlSignals_T_55 = mux(_ctrlSignals_T_25, UInt<1>("h1"), _ctrlSignals_T_54) @[Lookup.scala 34:39]
    node _ctrlSignals_T_56 = mux(_ctrlSignals_T_23, UInt<1>("h1"), _ctrlSignals_T_55) @[Lookup.scala 34:39]
    node _ctrlSignals_T_57 = mux(_ctrlSignals_T_21, UInt<1>("h1"), _ctrlSignals_T_56) @[Lookup.scala 34:39]
    node _ctrlSignals_T_58 = mux(_ctrlSignals_T_19, UInt<1>("h1"), _ctrlSignals_T_57) @[Lookup.scala 34:39]
    node _ctrlSignals_T_59 = mux(_ctrlSignals_T_17, UInt<1>("h1"), _ctrlSignals_T_58) @[Lookup.scala 34:39]
    node _ctrlSignals_T_60 = mux(_ctrlSignals_T_15, UInt<1>("h1"), _ctrlSignals_T_59) @[Lookup.scala 34:39]
    node _ctrlSignals_T_61 = mux(_ctrlSignals_T_13, UInt<1>("h1"), _ctrlSignals_T_60) @[Lookup.scala 34:39]
    node _ctrlSignals_T_62 = mux(_ctrlSignals_T_11, UInt<1>("h1"), _ctrlSignals_T_61) @[Lookup.scala 34:39]
    node _ctrlSignals_T_63 = mux(_ctrlSignals_T_9, UInt<1>("h1"), _ctrlSignals_T_62) @[Lookup.scala 34:39]
    node _ctrlSignals_T_64 = mux(_ctrlSignals_T_7, UInt<1>("h1"), _ctrlSignals_T_63) @[Lookup.scala 34:39]
    node _ctrlSignals_T_65 = mux(_ctrlSignals_T_5, UInt<1>("h1"), _ctrlSignals_T_64) @[Lookup.scala 34:39]
    node _ctrlSignals_T_66 = mux(_ctrlSignals_T_3, UInt<1>("h1"), _ctrlSignals_T_65) @[Lookup.scala 34:39]
    node ctrlSignals_2 = mux(_ctrlSignals_T_1, UInt<1>("h1"), _ctrlSignals_T_66) @[Lookup.scala 34:39]
    node _ctrlSignals_T_67 = mux(_ctrlSignals_T_27, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _ctrlSignals_T_68 = mux(_ctrlSignals_T_25, UInt<1>("h0"), _ctrlSignals_T_67) @[Lookup.scala 34:39]
    node _ctrlSignals_T_69 = mux(_ctrlSignals_T_23, UInt<1>("h1"), _ctrlSignals_T_68) @[Lookup.scala 34:39]
    node _ctrlSignals_T_70 = mux(_ctrlSignals_T_21, UInt<1>("h0"), _ctrlSignals_T_69) @[Lookup.scala 34:39]
    node _ctrlSignals_T_71 = mux(_ctrlSignals_T_19, UInt<1>("h0"), _ctrlSignals_T_70) @[Lookup.scala 34:39]
    node _ctrlSignals_T_72 = mux(_ctrlSignals_T_17, UInt<1>("h0"), _ctrlSignals_T_71) @[Lookup.scala 34:39]
    node _ctrlSignals_T_73 = mux(_ctrlSignals_T_15, UInt<1>("h0"), _ctrlSignals_T_72) @[Lookup.scala 34:39]
    node _ctrlSignals_T_74 = mux(_ctrlSignals_T_13, UInt<1>("h1"), _ctrlSignals_T_73) @[Lookup.scala 34:39]
    node _ctrlSignals_T_75 = mux(_ctrlSignals_T_11, UInt<1>("h0"), _ctrlSignals_T_74) @[Lookup.scala 34:39]
    node _ctrlSignals_T_76 = mux(_ctrlSignals_T_9, UInt<1>("h0"), _ctrlSignals_T_75) @[Lookup.scala 34:39]
    node _ctrlSignals_T_77 = mux(_ctrlSignals_T_7, UInt<1>("h0"), _ctrlSignals_T_76) @[Lookup.scala 34:39]
    node _ctrlSignals_T_78 = mux(_ctrlSignals_T_5, UInt<1>("h0"), _ctrlSignals_T_77) @[Lookup.scala 34:39]
    node _ctrlSignals_T_79 = mux(_ctrlSignals_T_3, UInt<1>("h0"), _ctrlSignals_T_78) @[Lookup.scala 34:39]
    node ctrlSignals_3 = mux(_ctrlSignals_T_1, UInt<1>("h0"), _ctrlSignals_T_79) @[Lookup.scala 34:39]
    io_inst_out <= io_inst_in @[Decode.scala 71:15]
    io_fu_op <= ctrlSignals_0 @[Decode.scala 72:12]
    io_fu_type <= ctrlSignals_1 @[Decode.scala 73:14]
    io_legal <= ctrlSignals_2 @[Decode.scala 74:12]
    io_signed <= ctrlSignals_3 @[Decode.scala 75:13]

  module FU :
    input clock : Clock
    input reset : UInt<1>
    input io_A : UInt<64>
    input io_B : UInt<64>
    input io_cond : UInt<64>
    input io_fu_op : UInt<3>
    input io_fu_type : UInt<2>
    input io_signed : UInt<1>
    input io_ready : UInt<1>
    output io_valid : UInt<1>
    output io_out : UInt<64>

    node _T = neq(io_fu_op, UInt<3>("h1")) @[FU.scala 47:17]
    node _T_1 = neq(io_fu_type, UInt<2>("h2")) @[FU.scala 49:25]
    node _GEN_0 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[FU.scala 49:40 50:14 52:14]
    node _GEN_1 = mux(_T, UInt<1>("h1"), _GEN_0) @[FU.scala 47:30 48:14]
    node _T_2 = eq(io_fu_op, UInt<3>("h0")) @[FU.scala 55:17]
    node _T_3 = eq(io_fu_type, UInt<2>("h0")) @[FU.scala 56:21]
    node _output_T = bits(io_B, 5, 0) @[FU.scala 58:29]
    node _output_T_1 = dshl(io_A, _output_T) @[FU.scala 58:22]
    node _T_4 = eq(io_fu_type, UInt<2>("h1")) @[FU.scala 59:27]
    node _output_T_2 = bits(io_B, 5, 0) @[FU.scala 61:29]
    node _output_T_3 = dshr(io_A, _output_T_2) @[FU.scala 61:22]
    node _output_T_4 = bits(io_A, 63, 63) @[FU.scala 64:25]
    node _output_T_5 = asSInt(io_A) @[FU.scala 64:36]
    node _output_T_6 = bits(io_B, 5, 0) @[FU.scala 64:50]
    node _output_T_7 = dshr(_output_T_5, _output_T_6) @[FU.scala 64:43]
    node _output_T_8 = bits(_output_T_7, 62, 0) @[FU.scala 64:56]
    node _output_T_9 = cat(_output_T_4, _output_T_8) @[Cat.scala 31:58]
    node _GEN_2 = mux(_T_4, _output_T_3, _output_T_9) @[FU.scala 59:41 61:14 64:14]
    node _GEN_3 = mux(_T_3, _output_T_1, _GEN_2) @[FU.scala 56:35 58:14]
    node _T_5 = eq(io_fu_op, UInt<3>("h1")) @[FU.scala 66:23]
    node _output_T_10 = asSInt(io_A) @[FU.scala 69:25]
    node _output_T_11 = asSInt(io_B) @[FU.scala 69:39]
    node _output_T_12 = mul(_output_T_10, _output_T_11) @[FU.scala 69:32]
    node _output_T_13 = asUInt(_output_T_12) @[FU.scala 69:47]
    node _T_6 = eq(io_fu_type, UInt<2>("h0")) @[FU.scala 71:23]
    node _T_7 = eq(io_A, UInt<1>("h0")) @[FU.scala 74:20]
    node _T_8 = eq(io_B, UInt<1>("h0")) @[FU.scala 75:26]
    node _output_T_14 = add(io_A, io_B) @[FU.scala 77:26]
    node _output_T_15 = tail(_output_T_14, 1) @[FU.scala 77:26]
    node _GEN_4 = mux(_T_8, io_A, _output_T_15) @[FU.scala 75:{34,43} 77:18]
    node _GEN_5 = mux(_T_7, io_B, _GEN_4) @[FU.scala 74:{29,38}]
    node _T_9 = eq(io_fu_type, UInt<2>("h1")) @[FU.scala 79:29]
    node _output_T_16 = sub(io_A, io_B) @[FU.scala 81:24]
    node _output_T_17 = tail(_output_T_16, 1) @[FU.scala 81:24]
    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[FU.scala 88:28]
    reg regA : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regA) @[FU.scala 95:23]
    reg regB : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regB) @[FU.scala 96:23]
    reg tempSum : UInt<64>, clock with :
      reset => (UInt<1>("h0"), tempSum) @[FU.scala 97:26]
    reg actual : UInt<64>, clock with :
      reset => (UInt<1>("h0"), actual) @[FU.scala 99:25]
    node _T_10 = asUInt(reset) @[FU.scala 102:15]
    node _T_11 = eq(_T_10, UInt<1>("h0")) @[FU.scala 102:15]
    node _actual_T = mul(io_A, io_B) @[FU.scala 111:38]
    reg actual_REG : UInt<128>, clock with :
      reset => (UInt<1>("h0"), actual_REG) @[FU.scala 111:33]
    node _GEN_6 = mux(io_ready, io_A, regA) @[FU.scala 103:22 105:21 95:23]
    node _GEN_7 = mux(io_ready, io_B, regB) @[FU.scala 103:22 106:21 96:23]
    node _GEN_8 = mux(io_ready, UInt<1>("h0"), _GEN_1) @[FU.scala 103:22 108:25]
    node _GEN_9 = mux(io_ready, UInt<1>("h1"), state) @[FU.scala 103:22 109:22 88:28]
    node _GEN_10 = mux(io_ready, UInt<1>("h0"), tempSum) @[FU.scala 103:22 110:24 97:26]
    node _GEN_11 = mux(io_ready, actual_REG, actual) @[FU.scala 103:22 111:23 99:25]
    node _T_12 = eq(state, UInt<1>("h1")) @[FU.scala 115:21]
    node _T_13 = eq(actual, tempSum) @[FU.scala 117:23]
    node _T_14 = asUInt(reset) @[FU.scala 118:23]
    node _T_15 = eq(_T_14, UInt<1>("h0")) @[FU.scala 118:23]
    node _T_16 = neq(regB, UInt<1>("h0")) @[FU.scala 120:22]
    node _T_17 = bits(regB, 0, 0) @[FU.scala 122:23]
    node _T_18 = eq(_T_17, UInt<1>("h1")) @[FU.scala 122:27]
    node _tempSum_T = add(regA, tempSum) @[FU.scala 123:31]
    node _tempSum_T_1 = tail(_tempSum_T, 1) @[FU.scala 123:31]
    node _GEN_12 = mux(_T_18, _tempSum_T_1, _GEN_10) @[FU.scala 122:35 123:23]
    node _regA_T = dshl(regA, UInt<1>("h1")) @[FU.scala 126:26]
    node _regB_T = dshr(regB, UInt<1>("h1")) @[FU.scala 128:26]
    node _GEN_13 = mux(_T_16, _GEN_12, _GEN_10) @[FU.scala 120:31]
    node _GEN_14 = mux(_T_16, _regA_T, _GEN_6) @[FU.scala 120:31 126:18]
    node _GEN_15 = mux(_T_16, _regB_T, _GEN_7) @[FU.scala 120:31 128:18]
    node _GEN_16 = mux(_T_16, _GEN_8, UInt<1>("h1")) @[FU.scala 120:31 130:24]
    node _GEN_17 = mux(_T_16, _GEN_9, UInt<2>("h2")) @[FU.scala 120:31 131:21]
    node _T_19 = eq(state, UInt<2>("h2")) @[FU.scala 133:27]
    node _GEN_18 = mux(_T_19, UInt<1>("h0"), _GEN_9) @[FU.scala 133:36 136:19]
    node _GEN_19 = mux(_T_19, UInt<1>("h0"), _GEN_8) @[FU.scala 133:36 137:21]
    node _GEN_20 = mux(_T_12, _GEN_13, _GEN_10) @[FU.scala 115:30]
    node _GEN_21 = mux(_T_12, _GEN_14, _GEN_6) @[FU.scala 115:30]
    node _GEN_22 = mux(_T_12, _GEN_15, _GEN_7) @[FU.scala 115:30]
    node _GEN_23 = mux(_T_12, _GEN_16, _GEN_19) @[FU.scala 115:30]
    node _GEN_24 = mux(_T_12, _GEN_17, _GEN_18) @[FU.scala 115:30]
    node _GEN_25 = mux(_T_9, _output_T_17, tempSum) @[FU.scala 140:16 79:43 81:16]
    node _GEN_26 = mux(_T_9, _GEN_1, _GEN_23) @[FU.scala 79:43]
    node _GEN_27 = mux(_T_6, _GEN_5, _GEN_25) @[FU.scala 71:37]
    node _GEN_28 = mux(_T_6, _GEN_1, _GEN_26) @[FU.scala 71:37]
    node _GEN_29 = mux(io_signed, _output_T_13, _GEN_27) @[FU.scala 67:20 69:16]
    node _GEN_30 = mux(io_signed, _GEN_1, _GEN_28) @[FU.scala 67:20]
    node _T_20 = eq(io_fu_op, UInt<3>("h4")) @[FU.scala 149:23]
    node _T_21 = eq(io_fu_type, UInt<2>("h0")) @[FU.scala 150:23]
    node _output_T_18 = xor(io_A, io_B) @[FU.scala 152:24]
    node _T_22 = eq(io_fu_type, UInt<2>("h1")) @[FU.scala 153:29]
    node _output_T_19 = or(io_A, io_B) @[FU.scala 155:24]
    node _output_T_20 = and(io_A, io_B) @[FU.scala 158:24]
    node _GEN_31 = mux(_T_22, _output_T_19, _output_T_20) @[FU.scala 153:44 155:16 158:16]
    node _GEN_32 = mux(_T_21, _output_T_18, _GEN_31) @[FU.scala 150:39 152:16]
    node _T_23 = eq(io_fu_op, UInt<3>("h2")) @[FU.scala 160:23]
    node _output_T_21 = asSInt(io_A) @[FU.scala 163:22]
    node _output_T_22 = asSInt(io_B) @[FU.scala 163:36]
    node _output_T_23 = lt(_output_T_21, _output_T_22) @[FU.scala 163:29]
    node _output_T_24 = lt(io_A, io_B) @[FU.scala 166:22]
    node _GEN_33 = mux(io_signed, _output_T_23, _output_T_24) @[FU.scala 161:20 163:14 166:14]
    node _T_24 = eq(io_fu_type, UInt<3>("h3")) @[FU.scala 168:25]
    node _T_25 = neq(io_cond, UInt<1>("h0")) @[FU.scala 169:18]
    node _GEN_34 = mux(_T_25, io_A, io_B) @[FU.scala 169:26 171:14 174:14]
    node _GEN_35 = mux(_T_24, _GEN_34, io_A) @[FU.scala 168:37 178:14]
    node _GEN_36 = mux(_T_23, _GEN_33, _GEN_35) @[FU.scala 160:35]
    node _GEN_37 = mux(_T_20, _GEN_32, _GEN_36) @[FU.scala 149:38]
    node _GEN_38 = mux(_T_5, _GEN_29, _GEN_37) @[FU.scala 66:36]
    node _GEN_39 = mux(_T_5, _GEN_30, _GEN_1) @[FU.scala 66:36]
    node _GEN_40 = mux(_T_2, _GEN_3, _GEN_38) @[FU.scala 55:30]
    node _GEN_41 = mux(_T_2, _GEN_1, _GEN_39) @[FU.scala 55:30]
    node output = bits(_GEN_40, 63, 0) @[FU.scala 45:20]
    io_valid <= _GEN_41
    io_out <= output @[FU.scala 181:10]
    state <= mux(reset, UInt<1>("h0"), _GEN_24) @[FU.scala 88:{28,28}]
    regA <= bits(_GEN_21, 63, 0)
    regB <= _GEN_22
    tempSum <= _GEN_20
    actual <= bits(_GEN_11, 63, 0)
    actual_REG <= _actual_T @[FU.scala 111:33]
    printf(clock, and(and(and(and(and(and(and(UInt<1>("h1"), eq(_T_2, UInt<1>("h0"))), _T_5), eq(io_signed, UInt<1>("h0"))), eq(_T_6, UInt<1>("h0"))), eq(_T_9, UInt<1>("h0"))), _T_11), UInt<1>("h1")), "inA: %d\n", io_A) : printf @[FU.scala 102:15]
    printf(clock, and(and(and(and(and(and(and(and(and(UInt<1>("h1"), eq(_T_2, UInt<1>("h0"))), _T_5), eq(io_signed, UInt<1>("h0"))), eq(_T_6, UInt<1>("h0"))), eq(_T_9, UInt<1>("h0"))), _T_12), _T_13), _T_15), UInt<1>("h1")), "EQUAL: %d\n", io_valid) : printf_1 @[FU.scala 118:23]

  module SEOperation :
    input clock : Clock
    input reset : UInt<1>
    input io_inst : UInt<8>
    input io_valid : UInt<1>
    input io_op1_input : UInt<64>
    input io_op2_input : UInt<64>
    input io_cond_input : UInt<64>
    output io_validOutput : UInt<1>
    output io_result : UInt<64>

    inst decode of SEControl @[SEOperation.scala 32:28]
    inst fu of FU @[SEOperation.scala 33:24]
    io_validOutput <= fu.io_valid @[SEOperation.scala 53:24]
    io_result <= fu.io_out @[SEOperation.scala 51:19]
    decode.clock <= clock
    decode.reset <= reset
    decode.io_inst_in <= io_inst @[SEOperation.scala 39:27]
    fu.clock <= clock
    fu.reset <= reset
    fu.io_A <= io_op1_input @[SEOperation.scala 42:11]
    fu.io_B <= io_op2_input @[SEOperation.scala 43:11]
    fu.io_cond <= io_cond_input @[SEOperation.scala 44:20]
    fu.io_fu_op <= decode.io_fu_op @[SEOperation.scala 45:15]
    fu.io_fu_type <= decode.io_fu_type @[SEOperation.scala 46:23]
    fu.io_signed <= decode.io_signed @[SEOperation.scala 47:22]
    fu.io_ready <= io_valid @[SEOperation.scala 49:21]
