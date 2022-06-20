package se

import chisel3._
import chisel3.util._
import scala.math._
object Params{
	val debug = true
	val reuse = true
	val coalesce = true
	val outoforder = true
	val EntryWidth = 128
	val NumOperand = 3
	val NumFPGAEntries = if(outoforder) 8 else 1
	val NumOperandEntries  = pow(2,log2Ceil(NumOperand*NumFPGAEntries)).toInt
	val WriteGranularity = 128
	val OperandGranularity = 16
	val SizeOfCacheline = 64
	val ReadGranularity = 32
	val NumOperandPerCacheline =  SizeOfCacheline/ReadGranularity
	val NumCacheline = NumOperandEntries / NumOperandPerCacheline
	val BitsForOffset = log2Ceil(NumOperandPerCacheline)
	val BitsForCacheline = NumCacheline
	val BitsForId = 1
}
