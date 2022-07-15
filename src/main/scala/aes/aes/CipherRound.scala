package aes

import chisel3._
import chisel3.util._

class CipherRoundIO extends Bundle{
  val input_valid = Input(Bool())
  val state_in = Input(Vec(16, UInt(8.W)))
  val roundKey = Input(Vec(16, UInt(8.W)))
  val state_out = Output(Vec(16, UInt(8.W)))
  val output_valid = Output(Bool())
}
// implements AES_Encrypt round transforms
class CipherRound(transform: String) extends Module {
  require(transform == "AddRoundKeyOnly" || transform == "NoMixColumns" || transform == "CompleteRound")
  val io = IO(new CipherRoundIO)

  // A well defined 'DontCare' or Initialization value
  val ZeroInit = VecInit.tabulate(16)((x:Int)=> 0.U(8.W))

  // Transform sequences
  if (transform == "AddRoundKeyOnly") {

    // Instantiate module objects
    val AddRoundKeyModule = AddRoundKey()

    // AddRoundKey
    when(io.input_valid) {
      AddRoundKeyModule.io.state_in := io.state_in
      AddRoundKeyModule.io.roundKey := io.roundKey
    }.otherwise {
      AddRoundKeyModule.io.state_in := ZeroInit
      AddRoundKeyModule.io.roundKey := ZeroInit
    }

    // output
    io.state_out := RegNext(AddRoundKeyModule.io.state_out)
    io.output_valid := RegNext(io.input_valid)

  } else if (transform == "NoMixColumns") {

    // Instantiate module objects
    val AddRoundKeyModule = AddRoundKey()
    val SubBytesModule = SubBytes()
    val ShiftRowsModule = ShiftRows()

    // SubBytes and AddRoundKeyModule roundKey
    when(io.input_valid) {
      SubBytesModule.io.state_in := io.state_in
      AddRoundKeyModule.io.roundKey := io.roundKey
    }.otherwise {
      SubBytesModule.io.state_in := ZeroInit
      AddRoundKeyModule.io.roundKey := ZeroInit
    }
    // ShiftRows
    ShiftRowsModule.io.state_in := SubBytesModule.io.state_out
    // AddRoundKey
    AddRoundKeyModule.io.state_in := ShiftRowsModule.io.state_out

    // output
    io.state_out := RegNext(AddRoundKeyModule.io.state_out)
    io.output_valid := RegNext(io.input_valid)

  } else if (transform == "CompleteRound") {

    // Instantiate module objects
    val AddRoundKeyModule = AddRoundKey()
    val SubBytesModule = SubBytes()
    val ShiftRowsModule = ShiftRows()
    val MixColumnsModule = MixColumns()

    // SubBytes and AddRoundKeyModule roundKey
    when(io.input_valid) {
      SubBytesModule.io.state_in := io.state_in
      AddRoundKeyModule.io.roundKey := io.roundKey
    }.otherwise {
      SubBytesModule.io.state_in := ZeroInit
      AddRoundKeyModule.io.roundKey := ZeroInit
    }
    // ShiftRows
    ShiftRowsModule.io.state_in := SubBytesModule.io.state_out
    // MixColumns
    MixColumnsModule.io.state_in := ShiftRowsModule.io.state_out
    // AddRoundKey
    AddRoundKeyModule.io.state_in := MixColumnsModule.io.state_out

    // output
    io.state_out := RegNext(AddRoundKeyModule.io.state_out)
    io.output_valid := RegNext(io.input_valid)
  }

}

object CipherRound {
  def apply(transform: String): CipherRound = Module(new CipherRound(transform))
}