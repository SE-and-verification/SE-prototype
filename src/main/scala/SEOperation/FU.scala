package se.seoperation

import chisel3._
import chisel3.util._

object FU {
  // Shifts
  val FU_SHIFT  = 0.U(3.W)

  val FU_ARITH = 1.U(3.W)

  val FU_COMP = 2.U(3.W)
  
  val FU_COND = 3.U(3.W)

  val FU_LOGICAL = 4.U(3.W)

  val FU_ENC = 5.U(3.W)

  val FU_XXX = 6.U(3.W)
}

import FU._
import COMP._
import ARITH._
import SHIFT._
import LOGICAL._
import COND._
import CRYPTO._

class  FUIO extends Bundle{
    val A = Input(UInt(64.W))
    val B = Input(UInt(64.W))
    val cond = Input(UInt(64.W))
    val fu_op = Input(UInt(3.W))
    val fu_type = Input(UInt(2.W))
    val signed = Input(Bool())
    val ready = Input(Bool())
    val valid = Output(Bool())
    val out = Output(UInt(64.W))
}

class FU(val debug: Boolean) extends Module{
  val io = IO(new FUIO)
  val output = Wire(UInt(64.W))

  val valid = RegInit(true.B) // initia

  when(io.fu_op =/= FU_ARITH){
    io.valid := true.B
  }.elsewhen(io.fu_type =/= ARITH_MULT){
    io.valid := true.B
  } .otherwise {
    io.valid := false.B
  }

  when(io.fu_op === FU_SHIFT){
    when(io.fu_type === SHIFT_SLL){
      if(debug) printf("Inst: sll\n")
      output := io.A << io.B(5,0)
    }.elsewhen(io.fu_type === SHIFT_SRL){
      if(debug) printf("Inst: srl\n")
      output := io.A >> io.B(5,0)
    }.otherwise{
      if(debug) printf("Inst: sra\n")
      output := Cat(io.A(63),(io.A.asSInt >> io.B(5,0))(62,0)).asUInt
    }
  }.elsewhen(io.fu_op === FU_ARITH){
    when(io.signed){
        if(debug) printf("Inst: mults\n")
        output := (io.A.asSInt * io.B.asSInt).asUInt
    }.otherwise{
      when(io.fu_type === ARITH_ADD){
        // change: timing side channels ..?
        if(debug) printf("Inst: add\n")
        when (io.A === 0.U) { output := io.B
        }.elsewhen (io.B === 0.U){ output := io.A
        }.otherwise{
          output := io.A + io.B
        }
      }.elsewhen(io.fu_type === ARITH_SUB){
        if(debug) printf("Inst: sub\n")
        output := io.A - io.B
      }.otherwise{

        if(debug) printf("Inst: mult\n")
        
        val state = RegInit(0.U) // starting state, inputs not ready
        
        val ready = io.ready // input;
        val inA = io.A // combinational
        val inB = io.B // combinational

        val regA = Reg(UInt(64.W))
        val regB = Reg(UInt(64.W))
        val tempSum = Reg(UInt(64.W))


        // waiting for operands state
        when(state === 0.U){
          // Ready is high! Operands done decrypting
          when (ready) {
               // initializing all values
              regA := inA
              regB := inB
              io.valid := false.B
              state := 1.U
              tempSum := 0.U
          }
        }
        // in computation state
        when (state === 1.U) {
         // there are still 1s left in reg b
          when (regB =/= 0.U) {
              // do multiplication stuff
            when (regB(0) === 1.B){
              tempSum := regA + tempSum
            }
            // left shift A by 1 for next round of multiplcation
            regA := regA << 1.U 
            // right shift B by 1 to get next LSB
            regB := regB >> 1.U
          }.otherwise { // when no more 1s left in b, done w multiplying
              io.valid := true.B
              state := 0.U
          }
        }
        
        output := tempSum 
      
      }

    }
  }.elsewhen(io.fu_op === FU_LOGICAL){
      when(io.fu_type === LOGICAL_XOR){
        if(debug) printf("Inst: xor\n")
        output := io.A ^ io.B
      }.elsewhen(io.fu_type === LOGICAL_OR){
        if(debug) printf("Inst: or\n")
        output := io.A | io.B
      }.otherwise{
        if(debug) printf("Inst: and\n")
        output := io.A & io.B
      }
  }.elsewhen(io.fu_op === FU_COMP){
    when(io.signed){
      if(debug) printf("Inst: lts\n")
      output := io.A.asSInt < io.B.asSInt
    }.otherwise{
      if(debug) printf("Inst: lt\n")
      output := io.A < io.B
    }
  }.elsewhen(io.fu_type === FU_COND){
    when(io.cond =/= 0.U){
      if(debug) printf("Inst: cmova\n")
      output := io.A
    }.otherwise{
      if(debug) printf("Inst: cmovb\n")
      output := io.B
    }
  }.otherwise{
      if(debug) printf("Inst: enc\n")
      output := io.A
  }

  io.out := output
  
}
