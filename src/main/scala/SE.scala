package se

import chisel3._
import chisel3.util._
import aes._
import se.seoperation._
import chisel3.util.random._

class SEInput(val canChangeKey: Boolean) extends Bundle{
	val inst = Input(UInt(8.W)) // Instruction encoding is defined in SEOperation/Instructions.scala

	val op1 = Input(UInt(128.W))

	val op2 = Input(UInt(128.W))

	// The condition for CMOV. Should always be encrypted. Can be anything if not used
	val cond = Input(UInt(128.W)) 
	val valid = Input(Bool())
	val ready = Output(Bool())

	val changeKey_en = if(canChangeKey) Some(Input(Bool())) else None
	val newKey = if(canChangeKey) Some(Input(Vec(11, Vec(16, UInt(8.W))))) else None
}


class SEOutput extends Bundle{
	val result = Output(UInt(128.W))
	val valid = Output(Bool())
	val ready = Input(Bool())
	val cntr = Output(UInt(8.W))
}

class SEIO(val canChangeKey: Boolean) extends Bundle{
	val in = new SEInput(canChangeKey)
	val out = new SEOutput
}


class SE(val debug:Boolean, val canChangeKey: Boolean) extends Module{
	// Define the input, output ports and the control bits
	val io = IO(new SEIO(canChangeKey))
	val counterOn = RegInit(false.B)
	val cnter = new Counter(100)
	val rolled = false
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
	val seoperation = Module(new SEOperation(debug))
	val aes_invcipher = Module(new RSADecrypt)
	val aes_cipher = Module(new RSAEncrypt)
	val key = Reg(Vec(11, Vec(16,UInt(8.W))))

	val ciphers = Reg(Vec(32, UInt(128.W)))
	val cache_valid = Reg(Vec(32, Bool()))
	val plaintexts = Reg(Vec(32, UInt(64.W)))
	val ptr = RegInit(0.U(8.W))

	val d_lit:BigInt = BigInt("60166926585411592733303690086208913473")
	val e_lit:BigInt = BigInt("65537")
	val n_lit:BigInt = BigInt("193862333708363793192320956212389408663")


	val d = RegInit(0.U(128.W))
	val e = RegInit(0.U(128.W))
	val n = RegInit(0.U(128.W))
	d := d_lit.U(128.W)
	e := e_lit.U(128.W)
	n := n_lit.U(128.W)

	// val expandedKey128 =VecInit(
    // VecInit(0x00.U(8.W), 0x01.U(8.W), 0x02.U(8.W), 0x03.U(8.W), 0x04.U(8.W), 0x05.U(8.W), 0x06.U(8.W), 0x07.U(8.W), 0x08.U(8.W), 0x09.U(8.W), 0x0a.U(8.W), 0x0b.U(8.W), 0x0c.U(8.W), 0x0d.U(8.W), 0x0e.U(8.W), 0x0f.U(8.W)),
    // VecInit(0xd6.U(8.W), 0xaa.U(8.W), 0x74.U(8.W), 0xfd.U(8.W), 0xd2.U(8.W), 0xaf.U(8.W), 0x72.U(8.W), 0xfa.U(8.W), 0xda.U(8.W), 0xa6.U(8.W), 0x78.U(8.W), 0xf1.U(8.W), 0xd6.U(8.W), 0xab.U(8.W), 0x76.U(8.W), 0xfe.U(8.W)),
    // VecInit(0xb6.U(8.W), 0x92.U(8.W), 0xcf.U(8.W), 0x0b.U(8.W), 0x64.U(8.W), 0x3d.U(8.W), 0xbd.U(8.W), 0xf1.U(8.W), 0xbe.U(8.W), 0x9b.U(8.W), 0xc5.U(8.W), 0x00.U(8.W), 0x68.U(8.W), 0x30.U(8.W), 0xb3.U(8.W), 0xfe.U(8.W)),
    // VecInit(0xb6.U(8.W), 0xff.U(8.W), 0x74.U(8.W), 0x4e.U(8.W), 0xd2.U(8.W), 0xc2.U(8.W), 0xc9.U(8.W), 0xbf.U(8.W), 0x6c.U(8.W), 0x59.U(8.W), 0x0c.U(8.W), 0xbf.U(8.W), 0x04.U(8.W), 0x69.U(8.W), 0xbf.U(8.W), 0x41.U(8.W)),
    // VecInit(0x47.U(8.W), 0xf7.U(8.W), 0xf7.U(8.W), 0xbc.U(8.W), 0x95.U(8.W), 0x35.U(8.W), 0x3e.U(8.W), 0x03.U(8.W), 0xf9.U(8.W), 0x6c.U(8.W), 0x32.U(8.W), 0xbc.U(8.W), 0xfd.U(8.W), 0x05.U(8.W), 0x8d.U(8.W), 0xfd.U(8.W)),
    // VecInit(0x3c.U(8.W), 0xaa.U(8.W), 0xa3.U(8.W), 0xe8.U(8.W), 0xa9.U(8.W), 0x9f.U(8.W), 0x9d.U(8.W), 0xeb.U(8.W), 0x50.U(8.W), 0xf3.U(8.W), 0xaf.U(8.W), 0x57.U(8.W), 0xad.U(8.W), 0xf6.U(8.W), 0x22.U(8.W), 0xaa.U(8.W)),
    // VecInit(0x5e.U(8.W), 0x39.U(8.W), 0x0f.U(8.W), 0x7d.U(8.W), 0xf7.U(8.W), 0xa6.U(8.W), 0x92.U(8.W), 0x96.U(8.W), 0xa7.U(8.W), 0x55.U(8.W), 0x3d.U(8.W), 0xc1.U(8.W), 0x0a.U(8.W), 0xa3.U(8.W), 0x1f.U(8.W), 0x6b.U(8.W)),
    // VecInit(0x14.U(8.W), 0xf9.U(8.W), 0x70.U(8.W), 0x1a.U(8.W), 0xe3.U(8.W), 0x5f.U(8.W), 0xe2.U(8.W), 0x8c.U(8.W), 0x44.U(8.W), 0x0a.U(8.W), 0xdf.U(8.W), 0x4d.U(8.W), 0x4e.U(8.W), 0xa9.U(8.W), 0xc0.U(8.W), 0x26.U(8.W)),
    // VecInit(0x47.U(8.W), 0x43.U(8.W), 0x87.U(8.W), 0x35.U(8.W), 0xa4.U(8.W), 0x1c.U(8.W), 0x65.U(8.W), 0xb9.U(8.W), 0xe0.U(8.W), 0x16.U(8.W), 0xba.U(8.W), 0xf4.U(8.W), 0xae.U(8.W), 0xbf.U(8.W), 0x7a.U(8.W), 0xd2.U(8.W)),
    // VecInit(0x54.U(8.W), 0x99.U(8.W), 0x32.U(8.W), 0xd1.U(8.W), 0xf0.U(8.W), 0x85.U(8.W), 0x57.U(8.W), 0x68.U(8.W), 0x10.U(8.W), 0x93.U(8.W), 0xed.U(8.W), 0x9c.U(8.W), 0xbe.U(8.W), 0x2c.U(8.W), 0x97.U(8.W), 0x4e.U(8.W)),
    // VecInit(0x13.U(8.W), 0x11.U(8.W), 0x1d.U(8.W), 0x7f.U(8.W), 0xe3.U(8.W), 0x94.U(8.W), 0x4a.U(8.W), 0x17.U(8.W), 0xf3.U(8.W), 0x07.U(8.W), 0xa7.U(8.W), 0x8b.U(8.W), 0x4d.U(8.W), 0x2b.U(8.W), 0x30.U(8.W), 0xc5.U(8.W)))
	
	// if(canChangeKey){
	// 	when(reset.asBool){
	// 		key := expandedKey128
	// 	}.elsewhen(io.in.changeKey_en.get){
	// 		key := io.in.newKey.get
	// 	}
	// }else{
	// 	when(reset.asBool){
	// 		key := expandedKey128
	// 	}
	// }

	// Once we receive the data, first latch them into buffers. 
	val inst_buffer = RegEnable(io.in.inst, io.in.valid)

	val op1_buffer = RegEnable(io.in.op1, io.in.valid)

	val op2_buffer = RegEnable( io.in.op2, io.in.valid)

	val cond_buffer = RegEnable( io.in.cond, io.in.valid)

	val valid_buffer = Reg(Bool())

	val n_result_valid_buffer = Wire(Bool())
	val ready_for_input = RegInit(true.B)
	val n_stage_valid = Wire(Bool())
	io.in.ready := ready_for_input

	valid_buffer := Mux(io.in.valid && io.in.ready, true.B, Mux(n_stage_valid, false.B, valid_buffer))
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

	val op1_found = ciphers.contains(op1_buffer)
	val op2_found = ciphers.contains(op2_buffer)
	val cond_found = Wire(Bool())
	when(inst_buffer === Instructions.CMOV){
		cond_found := ciphers.contains(cond_buffer)
	}.otherwise{
		cond_found := true.B
	}
	val op1_idx = ciphers.indexWhere(e => (e===op1_buffer))
	val op2_idx = ciphers.indexWhere(e => (e===op2_buffer))
	val cond_idx = ciphers.indexWhere(e => (e===cond_buffer))

	val op1_val = plaintexts(op1_idx)
	val op2_val = plaintexts(op2_idx)
	val cond_val = plaintexts(cond_idx)

	val all_match = op1_found && op2_found && cond_found && cache_valid(op1_idx) && cache_valid(op2_idx) && cache_valid(cond_idx)


	// Feed the ciphertexts into the invcipher
	aes_invcipher.io.input_op1 := op1_buffer.asTypeOf(aes_invcipher.io.input_op1)
	aes_invcipher.io.input_op2 := op2_buffer.asTypeOf(aes_invcipher.io.input_op2)
	aes_invcipher.io.input_cond := cond_buffer.asTypeOf(aes_invcipher.io.input_cond)
	aes_invcipher.io.n := n
	aes_invcipher.io.e := d
	aes_invcipher.io.input_valid := valid_buffer && (!all_match)
	when(aes_invcipher.io.input_valid){
		printf("op1_buffer: %x\n",op1_buffer)
		printf("op2_buffer: %x\n",op2_buffer)
	}
	n_stage_valid := all_match || valid_buffer

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
	seoperation.io.inst := Mux(all_match&& valid_buffer,inst_buffer ,mid_inst_buffer)
	val seOpValid = aes_invcipher.io.output_valid || (all_match && valid_buffer)
	seoperation.io.valid := seOpValid
	val op1_asUInt = op1_reverse.do_asUInt
	val op2_asUInt = op2_reverse.do_asUInt
	val cond_asUInt = cond_reverse.do_asUInt
	// printf("op1_found: %d\n",op1_found)
	// printf("op2_found: %d\n",op2_found)
	// printf("cond_found: %d\n",cond_found)
	// printf("seOpValid: %d\n",seOpValid)
	// printf("all_match: %d\n",all_match)
	// printf("aes_invcipher.io.output_valid: %d\n",aes_invcipher.io.output_valid)
	// printf("aes_invcipher.io.input_valid: %d\n",aes_invcipher.io.input_valid)

	// when(seOpValid ){
	// 	printf("\n-----mid----\n")
	// 	printf("op1_asUInt:%x\n",seoperation.io.op1_input)
	// 	printf("op2_asUInt:%x\n",seoperation.io.op2_input)
	// 	printf("cond_asUInt:%x\n",seoperation.io.cond_input)
	// 	printf("op1_asUInt:%x\n",Mux(mid_inst_buffer(7,5) === 5.U(3.W), mid_op1_buffer(127,64),op1_asUInt(127,64)))
	// 	printf("op2_asUInt:%x\n",op2_asUInt(127,64))
	// 	printf("cond_asUInt:%x\n",cond_asUInt(127,64))
	// 	printf("inst:%b\n",mid_inst_buffer)
	// }

	seoperation.io.op1_input := Mux(all_match&& valid_buffer, op1_val ,Mux(mid_inst_buffer(7,5) === 5.U(3.W), mid_op1_buffer(127,64),op1_asUInt(127,64)))
	seoperation.io.op2_input := Mux(all_match&& valid_buffer, op2_val, op2_asUInt(127,64))
	seoperation.io.cond_input := Mux(all_match&& valid_buffer, cond_val, cond_asUInt(127,64))

  // Once we receive the result form the seoperation, we latech the result first.
	val result_valid_buffer = RegNext(n_result_valid_buffer)
	n_result_valid_buffer := Mux(seOpValid, true.B, Mux(aes_cipher.io.input_valid, false.B, result_valid_buffer))

	// Pad with RNG
	val bit64_randnum = PRNG(new MaxPeriodFibonacciLFSR(64, Some(scala.math.BigInt(64, scala.util.Random))))
	val padded_result = Cat(seoperation.io.result,bit64_randnum)
	val result_buffer = RegEnable( padded_result, seOpValid)
	if(debug){
		when(result_valid_buffer){
			printf("\n-----back----\n")
			printf("padded_result:%x\n",result_buffer )
			printf("seoperation.io.result:%x\n",seoperation.io.result)
		}
	}
	val result_plaintext_buffer = RegInit(0.U(64.W))
	when(seOpValid){
		result_plaintext_buffer := seoperation.io.result
	}
	// Connect the cipher
	val aes_input = result_buffer.asTypeOf(aes_cipher.io.input_text)
	val aes_input_reverse = Wire(Vec(Params.StateLength, UInt(8.W)))
	for(i <- 0 until Params.StateLength){
		aes_input_reverse(i) := aes_input(Params.StateLength-i-1)
	}
	aes_cipher.io.input_text := aes_input_reverse
	aes_cipher.io.input_valid := result_valid_buffer
	aes_cipher.io.e := e
	aes_cipher.io.n := n

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

	when(output_valid){
		printf("ptr:%x\n",ptr)
		when(ptr === 31.U){
			ptr := 0.U
		}.otherwise{
			ptr := ptr + 1.U
		}
	}
	when(reset.asBool){
		// key := expandedKey128
		for(i <- 0 until 32){
			ciphers(i) := 0.U
			plaintexts(i) := 0.U
			cache_valid(i) := false.B
		}
	}.otherwise{	
		when(io.out.valid ){
			ciphers(ptr) := output_buffer
			plaintexts(ptr) := result_plaintext_buffer
			cache_valid(ptr) := true.B
		}
	}

	InfoAnnotator.info(io.in.op1, "SensitiveInput")
	InfoAnnotator.info(io.in.op2, "SensitiveInput")
	InfoAnnotator.info(io.in.cond, "SensitiveInput")

	InfoAnnotator.info(aes_invcipher, "Decryption")
	InfoAnnotator.info(aes_cipher, "Encryption")
	InfoAnnotator.info(seoperation, "Private")
	InfoAnnotator.info(io.out.result, "SensitiveOutput")
	InfoAnnotator.info(key, "KeyStore")
	
}
