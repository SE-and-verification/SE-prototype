// See LICENSE for license details.

package se.seoperation

import chisel3.UInt
import chisel3.util.BitPat

object Instructions {
  // Shifts
  def SLL    = BitPat("b00000001")
  def SRL    = BitPat("b00000010")
  def SRA    = BitPat("b00000011")
  // Arithmetic
  def ADD    = BitPat("b00000100")
  def SUB    = BitPat("b00000101")
  // Logical
  def XOR    = BitPat("b00000110")
  def OR     = BitPat("b00000111")
  def AND    = BitPat("b00001000")
  // Compare
  def SLT    = BitPat("b00001001")
  def SLTU   = BitPat("b00001010")
  def SGT    = BitPat("b00001011")
  def SGTU   = BitPat("b00001100")
  def EQ     = BitPat("b00001101")
  def NEQ    = BitPat("b00001110")
  def SLE    = BitPat("b00001111")
  def SLEU   = BitPat("b00010000")
  def SGE    = BitPat("b00010001")
  def SGEU   = BitPat("b00010010")
  def MULT   = BitPat("b00010011")
  def DIV    = BitPat("b00010100")
  def NEG    = BitPat("b00010101")
  // Conditional
  def CMOV   = BitPat("b1???????")
}
