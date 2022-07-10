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
  def SLL    = BitPat("b00000100")
  def SRL    = BitPat("b00001000")


  // Arithmetic
  def ADD    = BitPat("b00100000")
  def SUB    = BitPat("b00100100")
  def MULT   = BitPat("b00101000")
  def NEG    = BitPat("b00110100")

  // Compare
  def LT     = BitPat("b01000100")
  def GT     = BitPat("b01001000")
  def LET    = BitPat("b01001100")
  def GET    = BitPat("b01010000")
  def EQ     = BitPat("b01010100")
  def NEQ    = BitPat("b01011000")

  // Conditional
  def CMOV   = BitPat("b01100000")

  // Logical
  def XOR    = BitPat("b10000000")
  def OR     = BitPat("b10000100")
  def AND    = BitPat("b10001000")
  def NOT    = BitPat("b10001100")

  // ENC
  def ENC    = BitPat("b101?????")
}



object COMP {
  // comp type 
  val COMP_LT  = 0.U(3.W)
  val COMP_GT  = 1.U(3.W)
  val COMP_LET  = 2.U(3.W)
  val COMP_GET  = 3.U(3.W)
  val COMP_EQ  = 4.U(3.W)
  val COMP_NEQ  = 5.U(3.W)
  val COMP_XXX = 7.U(3.W)
}

object ARITH {
  val ARITH_ADD = 0.U(3.W)
  val ARITH_SUB = 1.U(3.W)
  val ARITH_MULT = 2.U(3.W)
  val ARITH_DIV = 3.U(3.W)
  val ARITH_MOD = 4.U(3.W)
  val ARITH_NEG = 5.U(3.W)
  val ARITH_XXX = 7.U(3.W)
}

object SHIFT{
  val SHIFT_SLL = 0.U(3.W)
  val SHIFT_SRL = 1.U(3.W)
  val SHIFT_XXX = 7.U(3.W)
}

object LOGICAL{
  val LOGICAL_XOR = 0.U(3.W)
  val LOGICAL_OR = 1.U(3.W)
  val LOGICAL_AND = 2.U(3.W)
  val LOGICAL_NOT = 3.U(3.W)
  val LOGICAL_XXX = 7.U(3.W)
}

object COND{
  val COND_COND = 0.U(3.W)
  val COND_XXX = 7.U(3.W)
}

object CRYPTO{
  val CRYPTO_ENC = 0.U(3.W)
  val CRYPTO_XXX = 7.U(3.W)
}