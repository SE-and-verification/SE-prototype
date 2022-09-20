package se

import chisel3._
import chisel3.util._

class DispatchArbiter(numBits: Int) extends Module{
	val io = IO(new Bundle{
		val validity = Input(UInt(numBits.W))
		val priority = Input(UInt(log2Ceil(numBits).W))
		val chosen = Output(UInt(log2Ceil(numBits).W))
		val hasChosen = Output(Bool())
	})

	val afterPriority = Wire(Vec(numBits, Bool()))
	val beforePriority = Wire(Vec(numBits, Bool()))

  	for (i <- numBits-1 to 0 by -1) {
		afterPriority(i) := 
			Mux(i.asUInt>= io.priority, io.validity(i) ,false.B)
		beforePriority(i) := 
			Mux(i.asUInt< io.priority, io.validity(i)  , false.B)
  	}

  val afterPriorityChosen = Wire(UInt(log2Ceil(numBits).W))
  afterPriorityChosen := (numBits-1).asUInt
  val beforePriorityChosen = Wire(UInt(log2Ceil(numBits).W))
  beforePriorityChosen := (numBits-1).asUInt

  for (i <- numBits-2 to 0 by -1) {
    when (afterPriority(i)) {
      afterPriorityChosen := i.asUInt
    }
		when(beforePriority(i)){	
			beforePriorityChosen := i.asUInt
		}
  }
	val afterPriorityExist = afterPriority.exists( (x:Bool)=>x)
	val beforePriorityExist = beforePriority.exists((x:Bool)=>x)

	io.hasChosen := afterPriorityExist | beforePriorityExist
	io.chosen := Mux(afterPriorityExist, afterPriorityChosen, beforePriorityChosen)
	// printf("DispatchArbiter Debug:\n")
	// printf("DispatchArbiter valid: %b:\n", io.validity)
	// printf("priority: %b:\n", io.priority)

}

// class CBArbiter(numBits: Int) extends Module{
// 	val io = IO(new Bundle{
// 		val validity = Input(UInt(numBits.W))
// 		val priority = Input(UInt(log2Ceil(numBits).W))
// 		val fetchOffset = Input(Vec(Params.NumOperand* Params.NumRBEntries, UInt(48.W)))
// 		val chosen = Output(UInt(log2Ceil(numBits).W))
// 		val hasChosen = Output(Bool())
// 	})
	
// }