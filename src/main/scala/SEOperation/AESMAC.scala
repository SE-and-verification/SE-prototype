package aes

import chisel3._
import chisel3.util._
import chisel3.experimental.hierarchy._

class AESMACIO extends Bundle{
	val input_valid = Input(Bool())
	val input_text =  Input(UInt(512.W))
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_text = Output(UInt(128.W))

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
@instantiable
class AESMAC(val rolled: Boolean) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  @public val io = IO(new AESMACIO)

  val input_text_vec1 	= Wire(Vec(16, UInt(8.W)))
  val input_text_vec2 	= Reg(Vec(16, UInt(8.W)))
	val input_text_vec3 	= Reg(Vec(16, UInt(8.W)))
  val input_text_vec4 	= Reg(Vec(16, UInt(8.W)))
  for (i <- 0 until 16) {
    input_text_vec1(i) := io.input_text((15 - i) * 8 + 7, (15 - i) * 8)
    when(io.input_valid) {
      input_text_vec2(i) := io.input_text((31 - i) * 8 + 7, (31 - i) * 8)
      input_text_vec3(i) := io.input_text((47 - i) * 8 + 7, (47 - i) * 8)
      input_text_vec4(i) := io.input_text((63 - i) * 8 + 7, (63 - i) * 8)
    }
  }
  // val input_op1_vec = Wire(Vec(Params.StateLength, UInt(8.W)))
  // val input_op2_vec = Wire(Vec(Params.StateLength, UInt(8.W)))

	// // Match the input type
	// for (i <- 0 until 16) {
	// 	// Solve type mismatch (as type of aes_invcipher_XXXhlf.io.input_opX)
	// 	input_op1_vec(i) := io.input_op1((15 - i) * 8 + 7, (15 - i) * 8)
	// 	input_op2_vec(i) := io.input_op2((15 - i) * 8 + 7, (15 - i) * 8)
	// }

  if(!rolled){ // NOT USED!!!
    val CipherRoundARK = Array.fill(2){
      CipherRound("AddRoundKeyOnly", true)
    }
    val CipherRounds = Array.fill(2){Array.fill(Nr - 1) {
      CipherRound("CompleteRound", true)
    }}
    val CipherRoundNMC =Array.fill(2){ CipherRound("NoMixColumns", true)}

    CipherRoundARK(0).io.input_valid := io.input_valid
    CipherRoundARK(0).io.state_in := input_text_vec1
    CipherRoundARK(0).io.roundKey := io.input_roundKeys(0)

    CipherRoundARK(1).io.input_valid := io.input_valid
    CipherRoundARK(1).io.state_in := input_text_vec2
    CipherRoundARK(1).io.roundKey := io.input_roundKeys(0)

    // Cipher Nr-1 rounds
    for(j <- 0 to 1){
      for (i <- 0 until (Nr - 1)) yield {
        if (i == 0) {
          CipherRounds(j)(i).io.input_valid := CipherRoundARK(j).io.output_valid
          CipherRounds(j)(i).io.state_in := CipherRoundARK(j).io.state_out
        }
        else {
          CipherRounds(j)(i).io.input_valid := CipherRounds(j)(i - 1).io.output_valid
          CipherRounds(j)(i).io.state_in := CipherRounds(j)(i - 1).io.state_out
        }
        CipherRounds(j)(i).io.roundKey := io.input_roundKeys(i + 1)
      }
    // last round
      CipherRoundNMC(j).io.input_valid := CipherRounds(j)(Nr - 1 - 1).io.output_valid
      CipherRoundNMC(j).io.state_in := CipherRounds(j)(Nr - 1 - 1).io.state_out
      CipherRoundNMC(j).io.roundKey := io.input_roundKeys(Nr)
    }




    io.output_valid := CipherRoundNMC(1).io.output_valid

    io.output_text := Cat(CipherRoundNMC(1).io.state_out)
  }else{
    val cnter = RegInit(0.U(3.W))
    val address = RegInit(0.U(log2Ceil(EKDepth).W))
		val B_reg = RegEnable(input_text_vec2, io.input_valid)
		val C_reg = RegEnable(input_text_vec3, io.input_valid)
    val D_reg = RegEnable(input_text_vec4, io.input_valid)
		val b_input_vec =   Wire(Vec(16, UInt(8.W)))
		val c_input_vec =   Wire(Vec(16, UInt(8.W)))
    val d_input_vec =   Wire(Vec(16, UInt(8.W)))
    val cipher = Module(new Cipher(4, true))

		for (i <- 0 until 16) {
    	b_input_vec(i) := cipher.io.state_out(i) ^ input_text_vec2(i)
    	c_input_vec(i) := cipher.io.state_out(i) ^ input_text_vec3(i)
    	d_input_vec(i) := cipher.io.state_out(i) ^ input_text_vec4(i)
  	}
    when(io.input_valid || cipher.io.state_out_valid){
      address := 0.U
    }.elsewhen(address =/= Nr.U){
      address := address + 1.U
    }
    when(cipher.io.state_out_valid && cnter < 3.U){
      cnter := cnter + 1.U
    }.elsewhen(io.input_valid){
      cnter := 0.U
    }


    cipher.io.start := io.input_valid || (cipher.io.state_out_valid && cnter < 3.U)

    cipher.io.roundKey := io.input_roundKeys(address)

    when(io.input_valid) {
      cipher.io.plaintext := input_text_vec1
    }.elsewhen(cipher.io.state_out_valid) {
      when(cnter === 0.U) {
        cipher.io.plaintext := b_input_vec
      }.elsewhen(cnter === 1.U) {
        cipher.io.plaintext := c_input_vec
      }.otherwise {
        cipher.io.plaintext := d_input_vec
      }
    }.otherwise {
      cipher.io.plaintext := 0.U.asTypeOf(input_text_vec1)
    }
    io.output_text := Cat(cipher.io.state_out)
    io.output_valid :=  cipher.io.state_out_valid && cnter === 3.U

  }
}
