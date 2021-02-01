// See LICENSE for license details.

package se.seoperation

import chisel3.UInt
import chisel3.util.BitPat

object Instructions {
  // Shifts
  def SLL    = BitPat("b000000001")
  def SRL    = BitPat("b000000010")
  def SRA    = BitPat("b000000011")
  // Arithmetic
  def ADD    = BitPat("b000000100")
  def SUB    = BitPat("b000000101")
  // Logical
  def XOR    = BitPat("b000000110")
  def OR     = BitPat("b000000111")
  def AND    = BitPat("b000001000")
  // Compare
  def SLT    = BitPat("b000001001")
  def SLTU   = BitPat("b000001010")
  // Conditional
  def CMOV   = BitPat("b1????????")
}
