package aes

import chisel3._
import chisel3.util._

class GF256MulIO extends Bundle {
  val in_a = Input(UInt(8.W))
  val in_b = Input(UInt(8.W))
  val out = Output(UInt(8.W))

  val ready = Input(Bool())   // input ready
  // this valid signal stays high as long as ready remains low, unlike the rest
  val valid = Output(Bool())  // output ready
}

class GF256Mul extends Module {
  val io = IO(new GF256MulIO)
  val last_a = Reg(UInt(8.W))
  val last_b = Reg(UInt(8.W))
  val last_accum = Reg(UInt(8.W))

  val a = Mux(io.ready, io.in_a, Cat(last_a(6, 0), 0.U) ^ Mux(last_a(7), 0x1b.U, 0.U))
  val b = Mux(io.ready, io.in_b, Cat(0.U, last_b(7, 1)))
  val accum = Mux(io.ready, 0.U, last_accum) ^ Mux(b(0), a, 0.U)

  last_a := a
  last_b := b
  last_accum := accum

  io.out := accum
  // here is our intentional data-dependent timing bug:
  // the multiplication will take ceil(log2(b)) cycles.
  io.valid := !b(7,1)
}

object GF256Mul {
  def apply(a: UInt, b: UInt, ready: Bool) = {
    val m = Module(new GF256Mul)
    m.io.in_a := a
    m.io.in_b := b
    m.io.ready := ready
    m
  }
}

class GF256ColMulIO extends Bundle {
  val col_in = Input(Vec(4, UInt(8.W)))
  val col_out = Output(Vec(4, UInt(8.W)))

  val ready = Input(Bool())
  // this valid signal stays high as long as ready remains low, unlike the rest
  val valid = Output(Bool())
}

class GF256ColMul(matrix: Seq[Seq[UInt]]) extends Module {
  val io = IO(new GF256ColMulIO)

  val multipliers = matrix.map(coeffs => io.col_in.zip(coeffs).map{
    // the "obvious" thing to do is GF256Mul(x, coeff), but
    // swapping the multiplicands yields more timing variance
    case (x, coeff) => GF256Mul(coeff, x, io.ready)
  }).toList

  io.col_out := multipliers.map(row => row.map(m => m.io.out).reduce((a, b) => a ^ b))
  io.valid := multipliers.flatten.map(m => m.io.valid).reduce((a, b) => a && b)
}

object GF256ColMul {
  def apply(matrix: Seq[Seq[UInt]], col_in: Vec[UInt], ready: Bool) = {
    val m = Module(new GF256ColMul(matrix))
    m.io.col_in := col_in
    m.io.ready := ready
    m
  }
}

class GF256MatMulIO extends Bundle {
  val state_in = Input(Vec(16, UInt(8.W)))
  val state_out = Output(Vec(16, UInt(8.W)))

  val ready = Input(Bool())
  val valid = Output(Bool())
}

class GF256MatMul(matrix: Seq[Seq[UInt]]) extends Module {
  val io = IO(new GF256MatMulIO)

  val cols = io.state_in.grouped(4).map(col => GF256ColMul(matrix, VecInit(col), io.ready)).toList

  io.state_out := cols.flatMap(c => c.io.col_out).toList

  // TODO: is it possible to remove was_ready?
  val was_ready = RegInit(false.B)
  was_ready := io.ready || was_ready

  val is_valid = (io.ready || was_ready) && cols.map(c => c.io.valid).reduce((a, b) => a && b)
  val was_valid = RegInit(false.B)
  was_valid := is_valid

  // TODO
  io.valid := (io.ready || was_ready) && (is_valid && !was_valid)
}

object GF256MatMul {
  def apply(matrix: Seq[Seq[UInt]]): GF256MatMul = Module(new GF256MatMul(matrix))
}

object MixColumns {
  def apply(): GF256MatMul = GF256MatMul(Seq(
    Seq(2.U, 3.U, 1.U, 1.U),
    Seq(1.U, 2.U, 3.U, 1.U),
    Seq(1.U, 1.U, 2.U, 3.U),
    Seq(3.U, 1.U, 1.U, 2.U),
  ))
}

object InvMixColumns {
  def apply(): GF256MatMul = GF256MatMul(Seq(
    Seq(14.U, 11.U, 13.U, 9.U),
    Seq(9.U,  14.U, 11.U, 13.U),
    Seq(13.U, 9.U,  14.U, 11.U),
    Seq(11.U, 13.U, 9.U,  14.U),
  ))
}