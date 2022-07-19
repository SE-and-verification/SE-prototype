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

  when(io.fu_op =/= FU_ARITH){
    io.valid := true.B
  }.elsewhen(io.fu_type =/= ARITH_MULT){
    io.valid := true.B
  }.otherwise {
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

        // changes: 
        if(debug) printf("Inst: mult\n")
  
  
        val state = RegInit(0.U) // starting state, inputs not ready
        /*when (io.ready) {
          state := 400.U
        }*/
        printf("state: %d\n",state)

        val valid = RegInit(false.B); // output not ready yet
        val ready = io.ready // input;
        val inA = io.A // combinational
        val inB = io.B // combinational

        val regA = Reg(UInt(64.W))
        val regB = Reg(UInt(64.W))
        val tempSum = Reg(UInt(64.W))
        
       // printf("ready: %d\n",ready)
        //printf("valid: %d\n",valid)

        //printf("REAL VAL: %d\n",inA * inB)

          // got to ready!
          /*
           when (ready) {
                // initializing all values!
                 printf("WOO: %d\n",ready)
                  regA := inA
                  regB := inB
                  valid := false.B
                  state := 1.U
                  tempSum := 0.U
           }
          
           when (state === 1.U) {
            // there are still 1s left in reg b
            when (regB =/= 0.U) {
              printf("mutliplying: %d\n",ready)
                // do multiplication stuff
              
              when (regB(0) === 1.B){
                tempSum := regA + tempSum
              }
              
              // left shift A by 1 for next round of multiplcation
              regA := regA << 1.U 
              // right shift B by 1 to get next bit
              regB := regB >> 1.U

            } .otherwise { // when no more 1s left in b, done w multiplying
                printf("DONE: %d\n",ready)
                valid := true.B
                state := 2.U
                printf("tempSum: %d\n", tempSum)
            }
              

        }.elsewhen (state === 2.U) {
          // does nothing until new values come in and ready goes to 0 while decrypying
            when (!ready) {
                state := 0.U
                valid:= false.B
            }
        }
        
        output := tempSum
        */
        
        
        output := io.A * io.B
        io.valid := true.B 
        
        
        /*
        when (io.A === 0.U | io.B === 0.U) { output := 0.U(64.W) // if any operand is 0, output a 64 bit 0
        }.elsewhen (io.A === 2.U) { output := io.B << 2.U // left shift by 1 to be faster
        }.elsewhen (io.B === 2.U) { output := io.A << 2.U // left shift is faster
        }.otherwise {output := io.A * io.B} */

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
