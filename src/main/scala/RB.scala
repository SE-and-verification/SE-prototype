package se

import chisel3._
import chisel3.util._

/*
RB Entry
------------------------------------------------------------------------------------------
|completed(bool) | valid(bool) | written(bool) | wr_addr(48nit) |				 operand				|
																																|	addr(nbits/48) | mode |
------------------------------------------------------------------------------------------
*/

class RBRequest extends LocalityTopRequest{
	val inFetch = Vec(Params.NumOperand, Bool())
}
class RBEntry extends RequestOperandEntry{
	val completed = Bool()
	val valid = Bool()
	val dispatched = Bool()
	val written = Bool()
	val wr_addr = UInt(8.W)
	val request = new RBRequest
	val result = new LocalityTopResult
}
class ReorderBuffer extends Bundle{
	val entries = Vec(Params.NumFPGAEntries, new RBEntry)
}
