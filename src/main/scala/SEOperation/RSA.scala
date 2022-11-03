package se

import chisel3._
import chisel3.util._
import chisel3.experimental._

class control extends BlackBox{
  val io = IO(new Bundle {
    val p = Input(UInt(64.W))
    val q = Input(UInt(64.W))
    val clk = Input(Bool())
    val reset = Input(Bool())
    val reset1 = Input(Bool())
    val encrypt_decrypt = Input(Bool())
    val msg_in = Input(UInt(128.W))
    val msg_out = Input(UInt(128.W))
    val mod_exp_finish = Output(Bool())
  })
}
