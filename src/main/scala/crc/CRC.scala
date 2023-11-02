package crc

import chisel3._
import chisel3.util._
import se.seoperation._

class ChiselCRC64 extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle {
    val crcIn = Input(UInt(64.W))
    val data = Input(UInt(64.W))
    val crcOut = Output(UInt(64.W))
  })
  addResource("/crc64.v")
}

class SingleCycleCRC extends Module{
  val io = IO(new Bundle{
    val inst = Input(UInt(8.W))
    val op1_hash = Input(UInt(64.W))
    val op2_hash = Input(UInt(64.W))
    val cond_hash = Input(UInt(64.W))
    val output_hash = Output(UInt(64.W))
  })

  val crc1 = Modeule(ChiselCRC64)
  val crc2 = Modeule(ChiselCRC64)
  val crc3 = Modeule(ChiselCRC64)

  crc1.io.crcIn := io.inst.asUInt(64.W)
  crc1.io.data := io.op1_hash
  crc2.io.crcIn := crc1.io.crcOut
  crc2.io.data := io.op2_hash
  crc3.io.crcIn := crc2.io.crcOut
  crc3.io.data := io.cond_hash

  io.output_hash := Mux(io.inst === Instructions.CMOV, crc3.io.crcOut, crc2.io.crcOut)
}

class MultiCycleCRC extends Module{
  val io = IO(new Bundle{
    val valid = Input(Bool())
    val inst = Input(UInt(8.W))
    val op1_hash = Input(UInt(64.W))
    val op2_hash = Input(UInt(64.W))
    val cond_hash = Input(UInt(64.W))
    val output_hash = Output(UInt(64.W))  
    val output_ready = Output(Bool())
  })

  val crc1 = Modeule(ChiselCRC64)
  val crc2 = Modeule(ChiselCRC64)
  val crc3 = Modeule(ChiselCRC64)

  val inst_buf = RegEnable(io.inst.asUInt(64.W), io.valid)
  val op1_hash_buf = RegEnable(io.op1_hash, io.valid)
  val op2_hash_buf = RegEnable(io.op2_hash, io.valid)
  val cond_hash_buf = RegEnable(io.cond_hash, io.valid)



  crc1.io.crcIn := io.inst.asUInt(64.W)
  crc1.io.data := io.op1_hash

  val stage1_hash = RegEnable(crc1.io.crcOut, io.valid)
  val stage1_valid = RegNext(io.valid)

  crc2.io.crcIn := stage1_hash
  crc2.io.data := op2_hash_buf

  val stage2_hash = RegEnable(crc2.io.crcOut, stage1_valid)
  val stage2_valid = RegNext(stage1_valid)

  crc3.io.crcIn := stage2_hash
  crc3.io.data := cond_hash_buf

  val stage3_hash = RegEnable(crc3.io.crcOut, stage2_valid)
  val stage3_valid = RegNext(stage2_valid)

  io.output_ready := Mux(inst_buf === Instructions.ENC, stage1_valid, Mux(inst_buf === Instructions.CMOV, stage3_valid, stage2_valid))
  io.output_hash := Mux(inst_buf === Instructions.ENC, op1_hash_buf, Mux(inst_buf === Instructions.CMOV, stage3_hash, stage2_hash))
}