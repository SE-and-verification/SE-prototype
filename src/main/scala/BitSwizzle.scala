package se

import chisel3._
import chisel3.util._

class BitSwizzleIO extends Bundle{
	val in = Input(UInt(256.W))
	val out = Output(UInt(256.W))
}

class BitSwizzle extends Module {
	val io = IO(new BitSwizzleIO)

	val upper_odd_bits = Wire(Vec(64, Bits(1.W)))
	val upper_even_bits = Wire(Vec(64, Bits(1.W)))
	val lower_odd_bits = Wire(Vec(64, Bits(1.W)))
	val lower_even_bits = Wire(Vec(64, Bits(1.W)))

	for(i <- 0 until 64){
		upper_odd_bits(i) := io.in(2*i+129)
		upper_even_bits(i) := io.in(2*i+128)
		lower_odd_bits(i) := io.in(2*i+1)
		lower_even_bits(i) := io.in(2*i)
	}

	val out_upper_left = upper_odd_bits.asUInt ^ lower_odd_bits.asUInt
	val out_lower_right = upper_even_bits.asUInt ^ lower_even_bits.asUInt
	val out_upper_right = out_lower_right ^ lower_odd_bits.asUInt
	val out_lower_left = out_upper_left ^ upper_even_bits.asUInt

	io.out := Cat(out_upper_left, out_upper_right, out_lower_left, out_lower_right)
}

class BitUnswizzle extends Module{
	val io = IO(new BitSwizzleIO)

	val in_upper_left = Wire(Vec(64, Bits(1.W)))
	val in_upper_right = Wire(Vec(64, Bits(1.W)))
	val in_lower_left = Wire(Vec(64, Bits(1.W)))
	val in_lower_right = Wire(Vec(64, Bits(1.W)))

	for(i <- 0 until 64){
		in_upper_left(i) := io.in(i+192)
		in_upper_right(i) := io.in(i+128)
		in_lower_left(i) := io.in(i+64)
		in_lower_right(i) := io.in(i)
	}

	val upper_even_bits = in_upper_left.asUInt ^ in_lower_left.asUInt
	val lower_even_bits = in_upper_right.asUInt ^ in_lower_right.asUInt
	val upper_odd_bits = in_upper_right.asUInt ^ lower_even_bits
	val lower_odd_bits = in_lower_right.asUInt ^ upper_even_bits

	val out_bits = Wire(Vec(256, Bits(1.W)))

	for(i <- 0 until 64){
		out_bits(2*i) := lower_even_bits(i)
		out_bits(2*i+1) := lower_odd_bits(i)
		out_bits(2*i+128) := upper_even_bits(i)
		out_bits(2*i+129) := upper_odd_bits(i)
	}

	io.out := out_bits.asUInt
}