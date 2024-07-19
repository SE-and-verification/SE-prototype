package aes

import chisel3._
import chisel3.util._

class Encrypt256IO extends Bundle{
	val input_valid = Input(Bool())
	val input_op1 =  Input(UInt(128.W))
	val input_op2 =  Input(UInt(128.W))

  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_op1 = Output(UInt(128.W))
	val output_op2 = Output(UInt(128.W))

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESEncrypt256(val rolled: Boolean) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  val io = IO(new Encrypt256IO)


  // val input_op1_vec = Wire(Vec(Params.StateLength, UInt(8.W)))
  // val input_op2_vec = Wire(Vec(Params.StateLength, UInt(8.W)))

	// // Match the input type 
	// for (i <- 0 until 16) {
	// 	// Solve type mismatch (as type of aes_invcipher_XXXhlf.io.input_opX)
	// 	input_op1_vec(i) := io.input_op1((15 - i) * 8 + 7, (15 - i) * 8)
	// 	input_op2_vec(i) := io.input_op2((15 - i) * 8 + 7, (15 - i) * 8)
	// }

  if(!rolled){
    val CipherRoundARK = Array.fill(2){
      CipherRound("AddRoundKeyOnly", true)
    }
    val CipherRounds = Array.fill(2){Array.fill(Nr - 1) {
      CipherRound("CompleteRound", true)
    }}
    val CipherRoundNMC =Array.fill(2){ CipherRound("NoMixColumns", true)}

    CipherRoundARK(0).io.input_valid := io.input_valid
    CipherRoundARK(0).io.state_in := io.input_op1.asTypeOf(Vec(Params.StateLength, UInt(8.W)))
    CipherRoundARK(0).io.roundKey := io.input_roundKeys(0)

    CipherRoundARK(1).io.input_valid := io.input_valid
    CipherRoundARK(1).io.state_in := io.input_op2.asTypeOf(Vec(Params.StateLength, UInt(8.W)))
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




    io.output_valid := CipherRoundNMC(0).io.output_valid && CipherRoundNMC(1).io.output_valid

    io.output_op1 := CipherRoundNMC(0).io.state_out.asUInt
    io.output_op2 := CipherRoundNMC(1).io.state_out.asUInt
  }else{
    val address = RegInit(0.U(log2Ceil(EKDepth).W))

    val tmp = RegInit(false.B)
    when(io.input_valid && ~tmp) {
      address := 0.U
      tmp     := true.B
    }.elsewhen(address =/= Nr.U){
      address := address + 1.U
    }
    val cipher_A = Module(new Cipher(4, true))
    val cipher_B = Module(new Cipher(4, true))

    cipher_A.io.start := io.input_valid
    cipher_B.io.start := io.input_valid
    cipher_A.io.plaintext := io.input_op1.asTypeOf(Vec(Params.StateLength, UInt(8.W)))
    cipher_B.io.plaintext := io.input_op2.asTypeOf(Vec(Params.StateLength, UInt(8.W)))
    cipher_A.io.roundKey := io.input_roundKeys(address)
    cipher_B.io.roundKey := io.input_roundKeys(address)


    io.output_op1 := cipher_A.io.state_out.asUInt
    io.output_op2 := cipher_B.io.state_out.asUInt
    io.output_valid := cipher_A.io.state_out_valid && cipher_B.io.state_out_valid
  }
}


class EncryptIO extends Bundle{
	val input_valid = Input(Bool())
	val input_text= Input(UInt(128.W)) // plaintext, ciphertext, roundKey
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
	val output_text = Output(UInt(128.W)) // ciphertext or plaintext

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESEncrypt(val rolled: Boolean) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key

  val io = IO(new EncryptIO)
  if(!rolled){
 val CipherRoundARK = CipherRound("AddRoundKeyOnly", true)
  val CipherRounds = Array.fill(Nr - 1) {
    CipherRound("CompleteRound", true)
  }
  val CipherRoundNMC = CipherRound("NoMixColumns", true)

  CipherRoundARK.io.input_valid := io.input_valid
  CipherRoundARK.io.state_in := io.input_text
  CipherRoundARK.io.roundKey := io.input_roundKeys(0)

  // Cipher Nr-1 rounds
  for (i <- 0 until (Nr - 1)) yield {
    if (i == 0) {
      CipherRounds(i).io.input_valid := CipherRoundARK.io.output_valid
      CipherRounds(i).io.state_in := CipherRoundARK.io.state_out
    }
    else {
      CipherRounds(i).io.input_valid := CipherRounds(i - 1).io.output_valid
      CipherRounds(i).io.state_in := CipherRounds(i - 1).io.state_out
    }
    CipherRounds(i).io.roundKey := io.input_roundKeys(i + 1)
  }

  // Cipher last round
  CipherRoundNMC.io.input_valid := CipherRounds(Nr - 1 - 1).io.output_valid
  CipherRoundNMC.io.state_in := CipherRounds(Nr - 1 - 1).io.state_out
  CipherRoundNMC.io.roundKey := io.input_roundKeys(Nr)

  io.output_valid := CipherRoundNMC.io.output_valid
  io.output_text := CipherRoundNMC.io.state_out
  }else{
    val address = RegInit(0.U(log2Ceil(EKDepth).W))

    val tmp = RegInit(false.B)
    when(io.input_valid && ~tmp) {
      address := 0.U
      tmp     := true.B
    }.elsewhen(address =/= Nr.U){
      address := address + 1.U
    }
    val cipher = Module(new Cipher(4, true))
    cipher.io.start := io.input_valid
    cipher.io.plaintext := io.input_text.asTypeOf(Vec(Params.StateLength, UInt(8.W)))
    cipher.io.roundKey := io.input_roundKeys(address)


    io.output_text := cipher.io.state_out.asUInt
    io.output_valid := cipher.io.state_out_valid
  }
}