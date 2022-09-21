package se

import chisel3._
import chisel3.util._
import scala.collection.mutable.ArrayBuffer

class Locality(coalesce: Boolean) extends Module {
	import se.Params._
	implicit val debug = true
  val io = IO(new LocalityTopInterface)

	// This part is assumed as a perfectly wrapped blackbox
	val pe = Module(new SE)


	// declare data structure
	val rb = RegInit(new ReorderBuffer, 0.U.asTypeOf(new ReorderBuffer))

 // increment counter every clock cycle if there is input
	val new_input_log = Wire(Bool())
	val entry_idx = io.request.bits.wr_addr
	new_input_log := io.request.valid && (rb.entries(entry_idx).written || !rb.entries(entry_idx).valid)
	
	// When new input comes in
	io.request.ready := rb.entries(entry_idx).written || (!rb.entries(entry_idx).valid)
	when(new_input_log){
		printf("written new entry\n")
		rb.entries(entry_idx).completed := false.B
		rb.entries(entry_idx).valid := true.B
		rb.entries(entry_idx).written := false.B
		rb.entries(entry_idx).wr_addr := io.request.bits.wr_addr
		rb.entries(entry_idx).request.inst := io.request.bits.inst

		for(i <- 0 until NumOperand){
			printf("op%d: mode: %d value: %d\n",i.asUInt,io.request.bits.operands(i).mode,io.request.bits.operands(i).value)
			rb.entries(entry_idx).request.operands(i).value := io.request.bits.operands(i).value
			rb.entries(entry_idx).request.operands(i).mode := io.request.bits.operands(i).mode
		}
		rb.entries(entry_idx).result := 0.U.asTypeOf(new LocalityTopResult)
	}


	// wb logic
	val wbCountOn = Wire(Bool())
	val (wbCntrVal, _) = Counter(wbCountOn, NumFPGAEntries)
	when(io.mem_write.ready && rb.entries(wbCntrVal).completed && (~rb.entries(wbCntrVal).written)){
		wbCountOn := true.B
		rb.entries(wbCntrVal).written := true.B
	}.otherwise{
		wbCountOn := false.B
	}

	// Connect the output
	io.mem_write.valid := rb.entries(wbCntrVal).completed && (~rb.entries(wbCntrVal).written)
	io.mem_write.bits.wr_addr := rb.entries(wbCntrVal).wr_addr
	io.mem_write.bits.result <> rb.entries(wbCntrVal).result



	val dispatchArb = Module(new DispatchArbiter(NumFPGAEntries))
	
	// determine the dispatch logic: every mode is 0

	// validity of ops
	val opsValidVec = Wire(Vec(NumFPGAEntries, Bool()))
	val singleOpValidVec = Wire(Vec(NumFPGAEntries* NumOperand, Bool()))

	for(i <- 0 until NumFPGAEntries){
		singleOpValidVec(i*NumOperand)  := !rb.entries(i).request.operands(0).mode
		for(j <- 1 until NumOperand){
			singleOpValidVec(i*NumOperand+j) := singleOpValidVec(i*NumOperand+j-1) && (rb.entries(i).request.operands(j).mode === 0.U)
		}
		opsValidVec(i) := singleOpValidVec(i*NumOperand+NumOperand-1) 
	}
	val waitingForDispatchVec = Wire(Vec(NumFPGAEntries, Bool()))
	for(i <- 0 until NumFPGAEntries){
		waitingForDispatchVec(i) := opsValidVec(i) & rb.entries(i).valid & (!rb.entries(i).dispatched)
	}

	// connect to the dispatch arbiter
	dispatchArb.io.validity := waitingForDispatchVec.asUInt
	dispatchArb.io.priority := wbCountOn
	val chosen = dispatchArb.io.chosen

	for(i <- 0 until NumFPGAEntries){
		when(entry_idx === i.U && new_input_log){
			rb.entries(i).dispatched := false.B
		}.otherwise{
			rb.entries(i).dispatched := rb.entries(i).dispatched || (chosen === i.asUInt && dispatchArb.io.hasChosen && pe.io.request.ready)
		}
	}
	// connect the input to pe
	when(dispatchArb.io.hasChosen & pe.io.request.ready){
		pe.io.request.valid := true.B
	}.otherwise{
		pe.io.request.valid := false.B
	}
	pe.io.in_idx := chosen

	pe.io.result.ready := io.mem_write.ready
	pe.io.request.bits.op1 := rb.entries(chosen).request.operands(0).value(EntryWidth-1,0)
	pe.io.request.bits.op2 := rb.entries(chosen).request.operands(1).value(EntryWidth-1,0)
	pe.io.request.bits.cond := rb.entries(chosen).request.operands(2).value(EntryWidth-1,0)
	pe.io.request.bits.inst := rb.entries(chosen).request.inst

	val result_idx = Wire(UInt(log2Ceil(NumFPGAEntries).W))
	result_idx := pe.io.out_idx
	when(pe.io.result.ready && pe.io.result.valid){
		rb.entries(result_idx).result <> pe.io.result.bits
		rb.entries(result_idx).completed := true.B
	}

	// update operands
	for(i <- 0 until NumFPGAEntries){
		for(j <- 0 until NumOperand){
			when(rb.entries(i).request.operands(j).mode === 1.U){
				when(rb.entries(rb.entries(i).request.operands(j).value).completed){
					rb.entries(i).request.operands(j).value := 
						rb.entries(rb.entries(i).request.operands(j).value).result.out
					rb.entries(i).request.operands(j).mode := 0.U	
				}
			}
		}
	}

	// mem read logic
	val reg_infetch_cacheline =  RegInit(0.U(13.W))
	when(io.mem_read.resp_valid){
		for(i <- 0 until NumFPGAEntries){
			for(j <- 0 until NumOperand){
				val tag = if(coalesce) rb.entries(i).request.operands(j).value(13, BitsForOffset) else rb.entries(i).request.operands(j).value(13, 0)
				val v_bit = MuxLookup(rb.entries(i).request.operands(j).value(BitsForOffset-1,0), 0.U, 
																(0 until NumOperandPerCacheline).toArray.map(x => (x.U ->  io.mem_read.data(x*ReadGranularity*8+EntryWidth+1))))
				val id_bit = MuxLookup(rb.entries(i).request.operands(j).value(BitsForOffset-1,0), 0.U, 
																(0 until NumOperandPerCacheline).toArray.map(x => (x.U ->  io.mem_read.data(x*ReadGranularity*8+EntryWidth))))
				when(rb.entries(i).request.operands(j).mode(1) === 1.U){
					when(tag === io.mem_read.resp_tag
						&&  v_bit === 1.U
						&& id_bit === rb.entries(i).request.operands(j).mode(0) ){
						rb.entries(i).request.operands(j).value := MuxLookup(rb.entries(i).request.operands(j).value(BitsForOffset-1,0), 0.U, 
																(0 until NumOperandPerCacheline).toArray.map(x => (x.U -> io.mem_read.data(x*ReadGranularity*8+EntryWidth-1, x*ReadGranularity*8 ))))
						rb.entries(i).request.operands(j).mode := 0.U
						printf("inst: %d, op: %d, mode cleared\n", i.U(8.W),j.U(8.W))
					}
				}
				if(debug){
					when(rb.entries(i).request.operands(j).mode(1) === 1.U){
					when(tag === io.mem_read.resp_tag){
						printf("tag: %b, v_bit: %b, id_bit: %b\n", tag, v_bit, id_bit)
						// printf("io.mem_read.resp_tag: %b, rb.entries(i).request.operands(j).value: %b\n", io.mem_read.resp_tag, rb.entries(i).request.operands(j).value)
					}
					}
				}
			}
		}
	}


	val waitingToBeFetched = Wire(Vec(NumOperand* NumFPGAEntries, Bool()))
	// val notInFetchVec = Wire(Vec(NumOperand* NumFPGAEntries, Bool()))
	val fetchOffSet = Wire(Vec(NumOperand* NumFPGAEntries, UInt(48.W)))
	val crnt_inFetch = Wire(Vec(NumOperand* NumFPGAEntries, Bool()))
	val inFetch = Wire(Vec(NumOperand* NumFPGAEntries, Bool()))
	for(i <- 0 until NumFPGAEntries){
		for(j <- 0 until NumOperand){
			if(coalesce){
				waitingToBeFetched(i*NumOperand+j) := rb.entries(i).valid && (rb.entries(i).request.operands(j).mode(1) === 1.U) && ((rb.entries(i).request.operands(j).value(13, BitsForOffset) & reg_infetch_cacheline ) === 0.U)
				// notInFetchVec(i*NumOperand+j) := (rb.entries(i).request.operands(j).value(13, BitsForOffset) & reg_infetch_cacheline ) === 0.U
			}else{ 
				waitingToBeFetched(i*NumOperand+j) := rb.entries(i).valid && (rb.entries(i).request.operands(j).mode(1) === 1.U) && (!rb.entries(i).request.inFetch(j))
			}
			fetchOffSet(i*NumOperand+j) := rb.entries(i).request.operands(j).value
		}
	}

	val fetchArb = Module(new DispatchArbiter(NumFPGAEntries*NumOperand))
	fetchArb.io.validity := waitingToBeFetched.asUInt
	fetchArb.io.priority := wbCountOn

	for(i <- 0 until NumFPGAEntries){
		for(j <- 0 until NumOperand){
			crnt_inFetch(i*NumOperand+j) := rb.entries(i).request.inFetch(j)
		}
	}
	when(fetchArb.io.hasChosen){
		val filter = if(coalesce) (fetchOffSet(fetchArb.io.chosen)(13, BitsForOffset) & reg_infetch_cacheline) =/= 0.U else false.B
		inFetch := (crnt_inFetch.asUInt ^ Mux(filter, (UIntToOH(fetchArb.io.chosen)(NumFPGAEntries*NumOperand-1,0)), 0.U)).asBools
		io.mem_read.req_valid := true.B ^ filter
		io.mem_read.req_addr := OHToUInt(fetchOffSet(fetchArb.io.chosen)(13, BitsForOffset))
		val read_req_tag = if(coalesce) fetchOffSet(fetchArb.io.chosen)(13, BitsForOffset)  else fetchOffSet(fetchArb.io.chosen)(13, 0);
		io.mem_read.req_tag :=  read_req_tag;
		printf("chosen: %d\n", fetchArb.io.chosen)
		printf("fetchoffset: %b, subfield: %b\n",fetchOffSet(fetchArb.io.chosen), fetchOffSet(fetchArb.io.chosen)(13, BitsForOffset))
		printf("io.mem_read.req_addr: %b\n",io.mem_read.req_addr)
		printf("filter: %b\n", filter)
		printf("infetch: %b\n", inFetch.asUInt)
	}.otherwise{
		inFetch := crnt_inFetch
		io.mem_read.req_valid := false.B
		io.mem_read.req_addr := OHToUInt(fetchOffSet(fetchArb.io.chosen)(13, BitsForOffset))
		io.mem_read.req_tag := 0.U ;
	}
	if(!coalesce){
		for(i <- 0 until NumFPGAEntries){
			when(entry_idx === i.U && new_input_log){
				rb.entries(i.U).request.inFetch := 0.U(NumOperand.W).asBools
			}.otherwise{
				for(j <- 0 until NumOperand){
					rb.entries(i).request.inFetch(j) := inFetch(i*NumOperand+j)
				}
			}
		}
	}
	if(coalesce){
		val unset_tag = (reg_infetch_cacheline | io.mem_read.resp_tag) ^ io.mem_read.resp_tag
		val set_tag = reg_infetch_cacheline | io.mem_read.req_tag
		val unset_then_set_tag = unset_tag | io.mem_read.req_tag
		when(io.mem_read.resp_valid){
			when(io.mem_read.req_valid){
				reg_infetch_cacheline :=  unset_then_set_tag
			}.otherwise{
				reg_infetch_cacheline := unset_tag
			}
		}.otherwise{
			when(io.mem_read.req_valid){
				reg_infetch_cacheline :=  set_tag
			}
		}
	}
	if(debug){
		when(io.mem_read.req_valid | io.mem_read.resp_valid){
			printf("\t-mem_read:\n")
			printf("\t\t-req_valid: %b\n",io.mem_read.req_valid)
			printf("\t\t-req_addr: %x\n",io.mem_read.req_addr)
			printf("\t\t-resp_valid: %b\n",io.mem_read.resp_valid)
			printf("\t\t-data: %x\n",io.mem_read.data)
			printf("\t\t-resp_tag: %x\n",io.mem_read.resp_tag)
		}
		when(io.mem_write.valid){
			printf("\t-mem_write:\n")
			printf("\t\t-valid: %b\n",io.mem_write.valid)
			printf("\t\t-ready: %b\n",io.mem_write.ready)
			printf("\t\t-bits:\n")
			printf("\t\t\t-wr_addr: %x\n", io.mem_write.bits.wr_addr)
			printf("\t\t\t-result: \n")
			printf("\t\t\t\t-out: %b\n", io.mem_write.bits.result.out)
		}
		// when(io.request.valid || waitingForDispatchVec.asUInt > 0.U || io.mem_write.valid){
		when(io.request.valid || io.mem_write.valid || io.mem_read.req_valid || pe.io.result.valid){
			printf("top level io:\n")
			printf("\t-request:\n")
			printf("\t\t-valid: %b\n",io.request.valid)
			printf("\t\t-ready: %b\n",io.request.ready)
			printf("\t\t-bits:\n")
			printf("\t\t\t-inst: %x\n", io.request.bits.inst)
			printf("\t\t\t-wr_addr: %x\n", io.request.bits.wr_addr)
			for(i <- 0 until NumOperand){
				printf(s"\t\t\t-operand${i}:\n")
				printf(s"\t\t\t\t-value: %x\n",io.request.bits.operands(i).value)
				printf(s"\t\t\t\t-mode: %x\n",io.request.bits.operands(i).mode)
			}

			printf("\t-fetchArb:\n")
			printf("\t\t-validity:%b\n", fetchArb.io.validity)
			printf("\t\t-priority:%x\n", fetchArb.io.priority)
			printf("\t\t-chosen:%x\n", fetchArb.io.chosen)
			printf("\t\t-hasChosen:%b\n", fetchArb.io.hasChosen)

			printf("\t-dispatchArb\n")
			printf("\t\t-validity:%b\n", dispatchArb.io.validity)
			printf("\t\t-priority:%x\n", dispatchArb.io.priority)
			printf("\t\t-chosen:%x\n", dispatchArb.io.chosen)
			printf("\t\t-hasChosen:%b\n", dispatchArb.io.hasChosen)

			printf("rb data: \n")
			printf("idx | completed | valid | dispatched | writtern | wr_addr| inst | num0 | mode0 | infetch0 | num1 | mode1 | infetch1 | num2 | mode2 | infetch2 | out \n")
			for(i <- 0 until NumFPGAEntries){
				val crnt_entry = rb.entries(i)
				val fetched = rb.entries(i).request.inFetch
				val request = rb.entries(i).request
				val operands = request.operands
				val result = rb.entries(i).result
				printf("%d | %b | %b | %b | %b | %x | %x | %x | %x | %b | %x | %x | %b | %x | %x | %b | %x\n",
						i.asUInt, crnt_entry.completed, crnt_entry.valid, crnt_entry.dispatched, crnt_entry.written, crnt_entry.wr_addr, request.inst, 
						operands(0).value, operands(0).mode, fetched(0),operands(1).value,operands(1).mode, fetched(1), operands(2).value,operands(2).mode, fetched(2), result.out)
			}
			// printf("waiting to be fetched: %b, notinfetch:%b\n",waitingToBeFetched.asUInt, notInFetchVec.asUInt)
			printf("reg_infetch_cacheline:%b\n", reg_infetch_cacheline)

			printf("pe: \n")
			val request = pe.io.request
			val result = pe.io.result

			printf("request: valid | ready | op 1 | op2 | cond | inst\n")
			printf("\t %b | %b | %b | %b | %b | %x \n", request.valid, request.ready, request.bits.op1, request.bits.op2, request.bits.cond, request.bits.inst)
			printf("result: valid | ready | out | out_idx\n")

			printf("\t %b | %b | %x | %x\n", result.valid, result.ready, result.bits.out, pe.io.out_idx)

		}
	}
}
