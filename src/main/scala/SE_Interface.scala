package se

import chisel3._
import chisel3.util._
import se.Params._

class TopMemWrite() extends Bundle{
	val result = new LocalityTopResult
	val wr_addr = UInt(8.W)
}

class RequestOperand extends Bundle{
	val value = UInt(EntryWidth.W)
//0 for immediate, 1 for immediate value, 2 for relative distance
	val mode = UInt(2.W)
}
class RequestOperandEntry extends Bundle{
	val operands = Vec(NumOperand, new RequestOperand)
}

class LocalityTopRequest extends RequestOperandEntry{
	val inst = UInt(8.W)
	val wr_addr = UInt(8.W)
}

class LocalityTopResult extends Bundle{
	val out    = UInt(EntryWidth.W)
}

class MemRead extends Bundle{
	val req_valid = Output(Bool())
	val req_addr = Output(UInt(42.W))
	val req_tag = Output(UInt(16.W))
	val data = Input(UInt(512.W))
	val resp_valid = Input(Bool())
	val resp_tag = Input(UInt(14.W))
}
class LocalityTopInterface extends Bundle{
	val request = Flipped(DecoupledIO(new LocalityTopRequest))
	val mem_write = Decoupled(new TopMemWrite)
	val mem_read = new MemRead
}
