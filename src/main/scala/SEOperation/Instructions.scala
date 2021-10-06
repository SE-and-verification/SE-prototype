// See LICENSE for license details.

package se.seoperation

import chisel3.UInt
import chisel3.util.BitPat

/*
Encoding schemes:
bits       7-5        4          3-1        0
      [func class] unused    [func type] [signed]

func class:
      name      in hex    in binary
      shifts    0x0          000 
      alu.      0x1          001
      comp.     0x2          010
      cmov.     0x3          011
      reserved               1??


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
  def SLA    = BitPat("b00000010")
  def SRL    = BitPat("b00000100")
  def SRA    = BitPat("b00000110")

  // Arithmetic
  def ADD    = BitPat("b00100001")
  def SUB    = BitPat("b00100011")
  def MULT   = BitPat("b00100101")
  def DIV    = BitPat("b00100111")

  def ADDU    = BitPat("b00100000")
  def SUBU    = BitPat("b00100010")
  def MULTU   = BitPat("b00100100")
  def DIVU    = BitPat("b00100110")

  // Logical
  def XOR    = BitPat("b01000010")
  def OR     = BitPat("b01000100")
  def AND    = BitPat("b01000110")
  def NEG    = BitPat("b01001000")

  // Compare
  def LT    = BitPat("b01000000")
  def SLTU  = BitPat("b01000001")
  def GT    = BitPat("b01000010")
  def SGTU  = BitPat("b01000011")
  def EQ    = BitPat("b01000100")
  def SEQU  = BitPat("b01000101")
  def NEQ   = BitPat("b01000110")
  def SNEQU = BitPat("b01000111")
  def LE    = BitPat("b01001000")
  def SLEU  = BitPat("b01001001")
  def GE    = BitPat("b01001010")
  def SGEU  = BitPat("b01001011")

  // Conditional
  def CMOV   = BitPat("b011?????")
}
