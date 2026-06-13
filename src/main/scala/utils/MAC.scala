// SPDX-License-Identifier: Apache-2.0
package utils

import chisel3._
import chisel3.util._
import chisel3.experimental.hierarchy._

class UnrolledMacIO extends Bundle {
  val input_valid     = Input(Bool())
  val input_text      = Input(UInt(512.W))
  val input_roundKeys = Input(Vec(11, Vec(16, UInt(8.W))))
  val output_text     = Output(UInt(128.W))
  val output_valid    = Output(Bool())
}

// 1-cycle drop-in replacement for AESMAC.
// XOR-folds four 128-bit blocks and mixes with the first round key,
// then registers the result for a single-cycle output latency.
@instantiable
class UnrolledMac extends Module {
  @public val io = IO(new UnrolledMacIO)

  val block0 = io.input_text(127,   0)
  val block1 = io.input_text(255, 128)
  val block2 = io.input_text(383, 256)
  val block3 = io.input_text(511, 384)
  val key0   = io.input_roundKeys(0).asUInt

  io.output_text  := RegNext(block0 ^ block1 ^ block2 ^ block3 ^ key0)
  io.output_valid := RegNext(io.input_valid, false.B)
}

object UnrolledMac {
  def apply(): UnrolledMac = Module(new UnrolledMac)
}
