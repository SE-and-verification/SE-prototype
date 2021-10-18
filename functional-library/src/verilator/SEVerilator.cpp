#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "SEVerilator.h"
#include "VSE.h"
#include "verilated.h"
#include "Instruction.h"
#include <iostream>
VSE* SE::module = new VSE;
unsigned int SE::tickcount = 0;

SE::~SE(void){
	delete SE::module;
}
SE::SE(void){
	if(!SE::module){
		SE::tickcount = 0;
		SE::module = new VSE;
	}
	SE::reset();
}
void SE::tick(){
	// Increment our own internal time reference
	SE::tickcount++;

	// Make sure any combinatorial logic depending upon
	// inputs that may have changed before we called tick()
	// has settled before the rising edge of the clock.
	SE::module->clock = 0;
	SE::module->eval();

	// Toggle the clock

	// Rising edge
	SE::module->clock = 1;
	SE::module->eval();

	// Falling edge
	SE::module->clock = 0;
	SE::module->eval();
}

void SE::reset(){
	SE::module->reset = 1;
	// Make sure any inheritance gets applied

	SE::tick();
	SE::module->reset = 0;
}



__uint128_t SE::SECompute(__uint128_t op1, __uint128_t op2, __uint128_t cond, 
			uint8_t inst){
	while (!SE::module->io_in_ready)
	{
		SE::tick();
	}
	SE::module->io_in_valid = true;
	SE::module->io_out_ready = true;
	SE::module->io_in_inst = inst;

	memcpy(&SE::module->io_in_op1, &op1, sizeof(op1));
	memcpy(&SE::module->io_in_op2, &op2, sizeof(op2));
	memcpy(&SE::module->io_in_cond, &cond, sizeof(cond));
	SE::tick();
	SE::module->io_in_valid = false;
	SE::tick();
	while(!SE::module->io_out_valid){
		SE::tick();
	}
	__uint128_t result = 0;
	memcpy(&result, &SE::module->io_out_result, sizeof(SE::module->io_out_result));

	return result;
}