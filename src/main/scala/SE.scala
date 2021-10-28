package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._

class SEInput extends Bundle{
	val inst = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala

	val op1 = Input(UInt(128.W))

	val op2 = Input(UInt(128.W))

	// The condition for CMOV. Should always be encrypted. Can be anything if not used
	val cond = Input(UInt(128.W)) 
	val valid = Input(Bool())
	val ready = Output(Bool())

	val changeKey_en = Input(Bool())
	val newKey = Input(Vec(11, Vec(16, UInt(8.W))))
}

class SEOutput extends Bundle{
	val result = Output(UInt(128.W))
	val valid = Output(Bool())
	val ready = Input(Bool())
	val cntr = Output(UInt(8.W))
}

class SEIO extends Bundle{
	val in = new SEInput
	val out = new SEOutput
}


class SE(implicit debug:Boolean) extends Module{
	// Define the input, output ports and the control bits
	val io = IO(new SEIO)
	val counterOn = RegInit(false.B)
	val cnter = new Counter(100)
	when(counterOn){
		cnter.inc()
	}
	when(io.in.valid && io.in.ready){
		counterOn := true.B
	}.elsewhen(io.out.valid && io.out.ready){
		counterOn := false.B
	}
	when(io.out.valid && io.out.ready){
		cnter.reset()
	}
	io.out.cntr := cnter.value
	/*
	seoperation: the module to actually compute on decrypted plaintexts
	key: preset expanded AES ROM key
	*/
	val seoperation = Module(new SEOperation)
	val aes_invcipher = Module(new AESDecrypt)
	val aes_cipher = Module(new AESEncrypt)
	val key = Reg(Vec(11, Vec(16,UInt(8.W))))

	when(reset.asBool){
		key := ExpandedKey.expandedKey128
	}.elsewhen(io.in.changeKey_en){
		key := io.in.newKey
	}
	// Once we receive the data, first latch them into buffers. 
	val inst_buffer = RegEnable(io.in.inst, io.in.valid)

	val op1_buffer = RegEnable(io.in.op1, io.in.valid)

	val op2_buffer = RegEnable( io.in.op2, io.in.valid)

	val cond_buffer = RegEnable( io.in.cond, io.in.valid)

	val valid_buffer = Reg(Bool())

	val n_result_valid_buffer = Wire(Bool())
	val ready_for_input = RegInit(true.B)
	io.in.ready := ready_for_input

	valid_buffer := Mux(io.in.valid && io.in.ready, true.B, Mux(aes_invcipher.io.input_valid, false.B, valid_buffer))
	when(io.in.valid && io.in.ready){
		ready_for_input := false.B
	}.elsewhen(io.out.valid && io.out.ready){
		ready_for_input := true.B
	}
	if(debug){
		when(reset.asBool){
			printf("resetting\n")
		}
		when(io.in.valid && io.in.ready){
			printf("changed to false\n")
		}.elsewhen(io.out.valid && io.out.ready){
			printf("changed to true\n")
		}
	}
	if(debug){
		when(valid_buffer){
			printf("\n-----front----\n")
			printf("op1 buffer:%x\n",op1_buffer)
			printf("op2 buffer:%x\n",op2_buffer)
			printf("cond:%x\n",cond_buffer)
			printf("inst:%b\n",inst_buffer)
		}
	}
	// Feed the ciphertexts into the invcipher
	aes_invcipher.io.input_op1 := op1_buffer.asTypeOf(aes_invcipher.io.input_op1)
	aes_invcipher.io.input_op2 := op2_buffer.asTypeOf(aes_invcipher.io.input_op2)
	aes_invcipher.io.input_cond := cond_buffer.asTypeOf(aes_invcipher.io.input_cond)
	aes_invcipher.io.input_roundKeys := key
	aes_invcipher.io.input_valid := valid_buffer


	// Reverse the byte order so we can convert them into uint with Chisel infrastructure.
	val op1_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val op2_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	val cond_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	for(i <- 0 until Params.StateLength){
		op1_reverse(i) := aes_invcipher.io.output_op1(Params.StateLength-i-1)
		op2_reverse(i) := aes_invcipher.io.output_op2(Params.StateLength-i-1)
		cond_reverse(i) := aes_invcipher.io.output_cond(Params.StateLength-i-1)
	}

	val mid_inst_buffer = RegEnable(inst_buffer,aes_invcipher.io.input_valid)
	val mid_op1_buffer = RegEnable(op1_buffer,aes_invcipher.io.input_valid)

	// Feed the decrypted values to the seoperation module. Depends on whether the data is encrypted when it comes in.
	seoperation.io.inst := mid_inst_buffer
	seoperation.io.valid := aes_invcipher.io.output_valid
	val op1_asUInt = op1_reverse.do_asUInt
	val op2_asUInt = op2_reverse.do_asUInt
	val cond_asUInt = cond_reverse.do_asUInt

	if(debug){
		when(aes_invcipher.io.output_valid){
			printf("\n-----mid----\n")
			printf("op1_asUInt:%x\n",seoperation.io.op1_input)
			printf("op2_asUInt:%x\n",seoperation.io.op2_input)
			printf("cond_asUInt:%x\n",seoperation.io.cond_input)
			printf("inst:%b\n",mid_inst_buffer)
		}
	}

	seoperation.io.op1_input := Mux(inst_buffer(7,5) === 5.U(3.W), mid_op1_buffer(127,64),op1_asUInt(127,64))
	seoperation.io.op2_input := op2_asUInt(127,64)
	seoperation.io.cond_input := cond_asUInt(127,64)

  // Once we receive the result form the seoperation, we latech the result first.
	val result_valid_buffer = RegNext(n_result_valid_buffer)
	n_result_valid_buffer := Mux(aes_invcipher.io.output_valid, true.B, Mux(aes_cipher.io.input_valid, false.B, result_valid_buffer))

	// Pad with RNG
	val bit64_randnum = PRNG(new MaxPeriodFibonacciLFSR(64, Some(scala.math.BigInt(64, scala.util.Random))))
	val padded_result = Cat(seoperation.io.result,bit64_randnum)
	val result_buffer = RegEnable( padded_result, aes_invcipher.io.output_valid)
	if(debug){
		when(result_valid_buffer){
			printf("\n-----back----\n")
			printf("padded_result:%x\n",result_buffer )
			printf("seoperation.io.result:%x\n",seoperation.io.result)
		}
	}
	// Connect the cipher
	aes_cipher.io.input_text := result_buffer.asTypeOf(aes_cipher.io.input_text)
	aes_cipher.io.input_valid := result_valid_buffer
	aes_cipher.io.input_roundKeys := key

	// Connect the output side
	val output_buffer = RegEnable(aes_cipher.io.output_text.do_asUInt, aes_cipher.io.output_valid)
	val output_valid = RegInit(false.B)

	when(aes_cipher.io.output_valid){
		output_valid := true.B
	}.elsewhen(io.out.valid && io.out.ready){
		output_valid := false.B
	}
	io.out.valid := output_valid
	io.out.result := output_buffer

	InfoAnnotator.info(io.in.op1, "SensitiveInput")
	InfoAnnotator.info(io.in.op2, "SensitiveInput")
	InfoAnnotator.info(io.in.cond, "SensitiveInput")

	InfoAnnotator.info(aes_invcipher, "Decryption")
	InfoAnnotator.info(aes_cipher, "Encryption")
	InfoAnnotator.info(seoperation, "Private")
	InfoAnnotator.info(io.out.result, "SensitiveOutput")
	InfoAnnotator.info(key, "KeyStore")
	
}