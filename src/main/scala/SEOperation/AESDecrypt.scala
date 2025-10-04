package aes

import chisel3._
import chisel3.util._

class Decrypt384IO extends Bundle{
	val input_valid = Input(Bool())
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
  val input_text = Input(UInt(384.W))

  val output_text = Output(UInt(384.W))

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESDecrypt384(val rolled: Boolean, val index:Int = 0) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key


  val io = IO(new DecryptIO)

	val op1_vec 	= Wire(Vec(16, UInt(8.W)))
	val op2_vec 	= Wire(Vec(16, UInt(8.W)))
  val op3_vec 	= Wire(Vec(16, UInt(8.W)))
	for (i <- 0 until 16) {
		// Solve type mismatch (as type of aes_invcipher_XXXhlf.io.input_opX)
		op1_vec(i) := io.input_text((15 - i) * 8 + 7, (15 - i) * 8)
		op2_vec(i) := io.input_text((31 - i) * 8 + 7, (31 - i) * 8)
		op3_vec(i) := io.input_text((47 - i) * 8 + 7, (47 - i) * 8)
	}


  if(!rolled){
    // val InvCipherRoundARK = Array.fill(3){
    val InvCipherRoundARK = Array.fill(2){
      InvCipherRound("AddRoundKeyOnly", true)
      }
    // val InvCipherRounds = Array.fill(3){
    val InvCipherRounds = Array.fill(2){ 
      Array.fill(Nr - 1) {
        InvCipherRound("CompleteRound", true)
      }
    }
    val InvCipherRoundNMC = Array.fill(3){ 
      InvCipherRound("NoInvMixColumns", true)
    }

    InvCipherRoundARK(0).io.input_valid := io.input_valid
    InvCipherRoundARK(0).io.state_in := op1_vec
    InvCipherRoundARK(0).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(1).io.input_valid := io.input_valid
    InvCipherRoundARK(1).io.state_in := op2_vec
    InvCipherRoundARK(1).io.roundKey := io.input_roundKeys(Nr)

    InvCipherRoundARK(2).io.input_valid := io.input_valid
    InvCipherRoundARK(2).io.state_in := op3_vec
    InvCipherRoundARK(2).io.roundKey := io.input_roundKeys(Nr)

    // Cipher Nr-1 rounds
    // for(j <- 0 to 2){
    for(j <- 0 to 2){
      for (i <- 0 until (Nr - 1)){
        if (i == 0) {
          InvCipherRounds(j)(i).io.input_valid := InvCipherRoundARK(j).io.output_valid
          InvCipherRounds(j)(i).io.state_in := InvCipherRoundARK(j).io.state_out
        }
        else {
          InvCipherRounds(j)(i).io.input_valid := InvCipherRounds(j)(i - 1).io.output_valid
          InvCipherRounds(j)(i).io.state_in := InvCipherRounds(j)(i - 1).io.state_out
        }
        InvCipherRounds(j)(i).io.roundKey := io.input_roundKeys(Nr - i - 1)
      }
        // last round
      InvCipherRoundNMC(j).io.input_valid := InvCipherRounds(j)(Nr - 1 - 1).io.output_valid
      InvCipherRoundNMC(j).io.state_in := InvCipherRounds(j)(Nr - 1 - 1).io.state_out
      InvCipherRoundNMC(j).io.roundKey := io.input_roundKeys(0)
  }


    io.output_text := Cat( Cat(InvCipherRoundNMC(0).io.state_out), Cat(InvCipherRoundNMC(1).io.state_out), Cat(InvCipherRoundNMC(2).io.state_out))
    io.output_valid := InvCipherRoundNMC(0).io.output_valid && InvCipherRoundNMC(1).io.output_valid && InvCipherRoundNMC(2).io.output_valid
  }
  else{
    val invcipher_A = InvCipher(4, true, index )
    val invcipher_B = InvCipher(4, true, index+1 )
    val invcipher_C = InvCipher(4, true, index+2 )
    val address = RegInit(0.U(log2Ceil(EKDepth).W))
    
    val tmp = RegInit(false.B)
    when(io.input_valid && ~tmp) {
      address := Nr.U
      tmp     := true.B
    }.elsewhen(address =/= 0.U){
      address := address - 1.U
    }
    invcipher_A.io.start := io.input_valid
    invcipher_A.io.ciphertext := op1_vec
    invcipher_A.io.roundKey := io.input_roundKeys(address)

    invcipher_B.io.start := io.input_valid
    invcipher_B.io.ciphertext := op2_vec
    invcipher_B.io.roundKey := io.input_roundKeys(address)

    invcipher_C.io.start := io.input_valid
    invcipher_C.io.ciphertext := op3_vec
    invcipher_C.io.roundKey := io.input_roundKeys(address)

    io.output_text := Cat( Cat(invcipher_A.io.state_out), Cat(invcipher_B.io.state_out), Cat(invcipher_C.io.state_out))
    io.output_valid := invcipher_A.io.state_out_valid && invcipher_B.io.state_out_valid && invcipher_C.io.state_out_valid
  }
}


class DecryptIO extends Bundle{
	val input_valid = Input(Bool())
  val input_roundKeys = Input(Vec(11,Vec(Params.StateLength, UInt(8.W))))
  val input_text = Input(UInt(128.W))

  val output_text = Output(UInt(128.W))

	val output_valid = Output(Bool())
}
// implements wrapper for AES cipher and inverse cipher
// change Nk=4 for AES128, NK=6 for AES192, Nk=8 for AES256
// change expandedKeyMemType= ROM, Mem, SyncReadMem
class AESDecrypt(val rolled: Boolean, val index:Int = 0) extends Module {
  val KeyLength: Int = 4 * Params.rows
  val Nr: Int = 10 // 10, 12, 14 rounds
  val Nrplus1: Int = Nr + 1 // 10+1, 12+1, 14+1
  val EKDepth: Int = 16 // enough memory for any expanded key


  val io = IO(new DecryptIO)

	val op1_vec 	= Wire(Vec(16, UInt(8.W)))

	for (i <- 0 until 16) {
		// Solve type mismatch (as type of aes_invcipher_XXXhlf.io.input_opX)
		op1_vec(i) := io.input_text((15 - i) * 8 + 7, (15 - i) * 8)
	}


  if(!rolled){
    // val InvCipherRoundARK = Array.fill(3){
    val InvCipherRoundARK = InvCipherRound("AddRoundKeyOnly", true)

    // val InvCipherRounds = Array.fill(3){
    val InvCipherRounds = Array.fill(Nr - 1) {
        InvCipherRound("CompleteRound", true)
      }

    val InvCipherRoundNMC =  InvCipherRound("NoInvMixColumns", true)


    InvCipherRoundARK.io.input_valid := io.input_valid
    InvCipherRoundARK.io.state_in := op1_vec
    InvCipherRoundARK.io.roundKey := io.input_roundKeys(Nr)


    // Cipher Nr-1 rounds
    // for(j <- 0 to 2){
      for (i <- 0 until (Nr - 1)){
        if (i == 0) {
          InvCipherRounds(i).io.input_valid := InvCipherRoundARK.io.output_valid
          InvCipherRounds(i).io.state_in := InvCipherRoundARK.io.state_out
        }
        else {
          InvCipherRounds(i).io.input_valid := InvCipherRounds(i - 1).io.output_valid
          InvCipherRounds(i).io.state_in := InvCipherRounds(i - 1).io.state_out
        }
        InvCipherRounds(i).io.roundKey := io.input_roundKeys(Nr - i - 1)
      }
        // last round
      InvCipherRoundNMC.io.input_valid := InvCipherRounds(Nr - 1 - 1).io.output_valid
      InvCipherRoundNMC.io.state_in := InvCipherRounds(Nr - 1 - 1).io.state_out
      InvCipherRoundNMC.io.roundKey := io.input_roundKeys(0)


    io.output_text := Cat(InvCipherRoundNMC.io.state_out)
    io.output_valid := InvCipherRoundNMC.io.output_valid
  }
  else{
    val invcipher_A = InvCipher(4, true, index )
    val address = RegInit(0.U(log2Ceil(EKDepth).W))
    
    val tmp = RegInit(false.B)
    when(io.input_valid && ~tmp) {
      address := Nr.U
      tmp     := true.B
    }.elsewhen(address =/= 0.U){
      address := address - 1.U
    }
    invcipher_A.io.start := io.input_valid
    invcipher_A.io.ciphertext := op1_vec
    invcipher_A.io.roundKey := io.input_roundKeys(address)

    io.output_text := Cat(invcipher_A.io.state_out)
    io.output_valid := invcipher_A.io.state_out_valid 
  }
}
