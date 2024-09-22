// See LICENSE for license details.

package se.seoperation
import chisel3._
import chisel3.util.BitPat

/*
Encoding schemes:
bits       7-5           4-2          1            0
      [func class]  [func type]    [unused]    [signed]

func class:
      name      in hex    in binary
      shifts    0x0          000 
      alu.      0x1          001
      comp.     0x2          010
      cmov.     0x3          011
      logical   0x4          100
      enc       0x5          101


signed:
  1 - signed type
  0 - unsigned type

for comparisons, if both are unsigned or signed, the instruction ends with 0
                and no special treatment is required.
if it is comparison between signed and unsigned integers, the signed number will come first, followed by the unsigned operand.
              the instruction ends with 1
*/
object Instructions {
  // Shifts
  def SLL    = BitPat("b00000000")
  def SRL    = BitPat("b00000100")
  def SRA    = BitPat("b00001000")


  // Arithmetic
  def ADD    = BitPat("b00100000")
  def SUB    = BitPat("b00100100")
  def MULT   = BitPat("b00101000")
  def MULTS  = BitPat("b00101001")

  // Compare
  def LT     = BitPat("b01000000")
  def LTS    = BitPat("b01000001")

  // Conditional
  def CMOV   = BitPat("b01100000")

  // Logical
  def XOR    = BitPat("b10000000")
  def OR     = BitPat("b10000100")
  def AND    = BitPat("b10001000")

  // ENC
  def ENC_VAR    = BitPat("b10100000")
  def ENC_CONST   = BitPat("b10110000")
  def READ_PUB_VAR_HASH   = BitPat("b10111000")

  def ENC_NON_INTEGRITY = BitPat("b10111100")
}



object COMP {
  // comp type 
  val COMP_LT  = 0.U(2.W)
  val COMP_XXX = 2.U(2.W)
}

object ARITH {
  val ARITH_ADD = 0.U(2.W)
  val ARITH_SUB = 1.U(2.W)
  val ARITH_MULT = 2.U(2.W)
  val ARITH_XXX = 3.U(2.W)
}

object SHIFT{
  val SHIFT_SLL = 0.U(2.W)
  val SHIFT_SRL = 1.U(2.W)
  val SHIFT_SRA = 2.U(2.W)
  val SHIFT_XXX = 3.U(2.W)
}

object LOGICAL{
  val LOGICAL_XOR = 0.U(2.W)
  val LOGICAL_OR = 1.U(2.W)
  val LOGICAL_AND = 2.U(2.W)
  val LOGICAL_XXX = 3.U(2.W)
}

object COND{
  val COND_COND = 0.U(2.W)
  val COND_XXX = 3.U(2.W)
}

object CRYPTO{
  val CRYPTO_ENC_VAR = 0.U(2.W)
  val CRYPTO_ENC_CONST = 1.U(2.W)
  val CRYPTO_READ_PUB_VAR_HASH = 2.U(2.W)
  val CRYPTO_XXX = 3.U(2.W)
}