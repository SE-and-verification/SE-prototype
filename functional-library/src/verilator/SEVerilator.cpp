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
unsigned int SE::real_tickcount = 0;


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
	SE::tickcount = 0;
	SE::real_tickcount = 0;
	SE::tick();
	SE::module->reset = 0;
}


// void SE::changeKey(unsigned int* key){
// 	SE::module->io_in_changeKey_en = 1;
// 	uint8_t i = 0;
// 	SE::module->io_in_newKey_0_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_0_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_0_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_0_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_0_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_0_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_0_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_0_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_0_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_0_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_0_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_0_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_0_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_0_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_0_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_0_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_1_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_1_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_1_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_1_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_1_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_1_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_1_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_1_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_1_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_1_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_1_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_1_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_1_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_1_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_1_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_1_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_2_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_2_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_2_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_2_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_2_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_2_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_2_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_2_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_2_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_2_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_2_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_2_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_2_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_2_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_2_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_2_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_3_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_3_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_3_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_3_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_3_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_3_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_3_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_3_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_3_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_3_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_3_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_3_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_3_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_3_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_3_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_3_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_4_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_4_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_4_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_4_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_4_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_4_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_4_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_4_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_4_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_4_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_4_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_4_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_4_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_4_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_4_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_4_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_5_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_5_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_5_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_5_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_5_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_5_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_5_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_5_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_5_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_5_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_5_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_5_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_5_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_5_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_5_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_5_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_6_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_6_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_6_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_6_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_6_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_6_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_6_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_6_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_6_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_6_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_6_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_6_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_6_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_6_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_6_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_6_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_7_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_7_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_7_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_7_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_7_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_7_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_7_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_7_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_7_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_7_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_7_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_7_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_7_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_7_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_7_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_7_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_8_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_8_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_8_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_8_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_8_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_8_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_8_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_8_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_8_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_8_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_8_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_8_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_8_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_8_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_8_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_8_15 = (uint8_t)(key[3+i]);

// 	i+=4;
// 	SE::module->io_in_newKey_9_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_9_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_9_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_9_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_9_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_9_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_9_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_9_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_9_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_9_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_9_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_9_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_9_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_9_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_9_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_9_15 = (uint8_t)(key[3+i]);


// 	i+=4;
// 	SE::module->io_in_newKey_10_0 = (uint8_t)(key[0+i]>>24);
// 	SE::module->io_in_newKey_10_1 = (uint8_t)(key[0+i]>>16);
// 	SE::module->io_in_newKey_10_2 = (uint8_t)(key[0+i]>>8);
// 	SE::module->io_in_newKey_10_3 = (uint8_t)(key[0+i]);
// 	SE::module->io_in_newKey_10_4 = (uint8_t)(key[1+i]>>24);
// 	SE::module->io_in_newKey_10_5 = (uint8_t)(key[1+i]>>16);
// 	SE::module->io_in_newKey_10_6 = (uint8_t)(key[1+i]>>8);
// 	SE::module->io_in_newKey_10_7 = (uint8_t)(key[1+i]);
// 	SE::module->io_in_newKey_10_8 = (uint8_t)(key[2+i]>>24);
// 	SE::module->io_in_newKey_10_9 = (uint8_t)(key[2+i]>>16);
// 	SE::module->io_in_newKey_10_10 = (uint8_t)(key[2+i]>>8);
// 	SE::module->io_in_newKey_10_11 = (uint8_t)(key[2+i]);
// 	SE::module->io_in_newKey_10_12 = (uint8_t)(key[3+i]>>24);
// 	SE::module->io_in_newKey_10_13 = (uint8_t)(key[3+i]>>16);
// 	SE::module->io_in_newKey_10_14 = (uint8_t)(key[3+i]>>8);
// 	SE::module->io_in_newKey_10_15 = (uint8_t)(key[3+i]);
	
// 	tick();
// 	SE::module->io_in_changeKey_en = 0;
// 	tick();
// }

// bit316_t op1;
// bit316_t op2;

bit316_t SE::SECompute(bit316_t &op1, bit316_t &op2, __uint128_t cond, uint8_t inst) {
	printf("[[[[----------Enter SE::SECompute()----------]]]]\n");
	// Waiting io_in_ready signal
	while(!SE::module->io_in_ready) {
		SE::tick();
	}
	SE::module->io_in_valid = true;
	SE::module->io_out_ready = true;
	SE::module->io_in_inst = inst;

	// Copy the "vectorized" input.
	// uint8_t op1[40]
	// uint8_t op2[40]
	// 316 bits -> 39.5 bytes -> 40 bytes
	// The bit316_t class stores vectorized values according to the following structure:
    // value[0]              : 4 dummy bits, should be 0       <- MSB
    // value[1]  - value[7]  : 60-bit hash 
    // value[8]  - value[23] : 128-bit upper half cypher_text
    // value[24] - value[39] : 128-bit lower half cypher_text  <- LSB
	constexpr size_t op_n_size = 40;
	uint8_t* check_op1_input 		= op1.get_value();
	uint8_t* check_op2_input 		= op2.get_value();
	unsigned int op1_uint_temp[10] 	= {0};
	unsigned int op2_uint_temp[10] 	= {0};
	for(int i = 0; i < 10; i++) {
		unsigned int temp_1 = 0U;
		unsigned int temp_2 = 0U;
		for(int j = 0; j < 3; j++) {
			temp_1 = (temp_1 + check_op1_input[i * 4 + j]) << 8;
			temp_2 = (temp_2 + check_op2_input[i * 4 + j]) << 8;
		}
		temp_1 = temp_1 + check_op1_input[i * 4 + 3];
		temp_2 = temp_2 + check_op2_input[i * 4 + 3];
        op1_uint_temp[9 - i] = temp_1;
		op2_uint_temp[9 - i] = temp_2;
    }
	for(int i = 0; i < 10; ++i) {
		SE::module->io_in_op1[i] = op1_uint_temp[i];
		SE::module->io_in_op2[i] = op2_uint_temp[i];
	}
	// Check input
	printf("\top1.get_value() is: ");
	for(int i = 0; i < 40; i++) {
        printf("%02x", check_op1_input[i]);
    }
    printf("\n");
	printf("\top2.get_value() is: ");
	for(int i = 0; i < 40; i++) {
        printf("%02x", check_op2_input[i]);
    }
    printf("\n");
	// memcpy(&SE::module->io_in_cond, &cond, sizeof(cond));
	printf("memcpy done\n");

	// Simulate and calculate the time
	SE::tick();
	SE::real_tickcount++;
	SE::module->io_in_valid = false;
	SE::tick();
	SE::real_tickcount++;
	
	// Waiting for output
	printf("Waiting for output...\n");
	while(!SE::module->io_out_valid) {
		SE::tick();
		SE::real_tickcount++;
	}
	// SE::tick();
	// SE::tick();
	printf("io_out_valid\n");
	unsigned int result_value[10] = {0};
	for(int i = 0; i < 10; ++i) {
		result_value[i] = SE::module->io_out_result[9 - i];
	}
	// Check output
	unsigned int* check_output = SE::module->io_out_result;
	printf("\tSE::module->io_out_result is: ");
	for(int i = 0; i < 10; i++) {
        printf("%08x", check_output[i]);
    }
    printf("\n");
	printf("\tresult_value is: ");
	for(int i = 0; i < 10; i++) {
        printf("%08x", result_value[i]);
    }
    printf("\n");
	printf("result_value assigned\n");
	bit316_t result(result_value);
	printf("[[[[----------Leave SE::SECompute()----------]]]]\n");
	// uint8_t num_cycle = 0;
	// memcpy(&num_cycle, &SE::module->io_out_cntr, sizeof(SE::module->io_out_cntr));
	// std::vector<uint8_t> result_vector;
	// result_vector.assign(result, result + (sizeof(result) / sizeof(result[0])));

	// Output the simulation result and return the vector
	// std::cout << "number cycles: "<< std::dec << (int) num_cycle << std::endl;
	// return result_vector;
	return result;
}
