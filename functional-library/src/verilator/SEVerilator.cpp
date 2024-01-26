#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "SEVerilator.h"
#include "VSE.h"
#include "verilated.h"
#include "Instruction.h"
#include <iostream>
#include "integrity_enc_int.h"
#include <cstdlib>
#include <ctime>
#include "crc.h"
#include "../interface/interface.h"
using namespace std;
VSE* SE::module = new VSE;
unsigned int SE::tickcount = 0;
unsigned int SE::real_tickcount = 0;


SE::SE(void){
	setParameters();
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

	 integrity_enc_int SE::SECompute(integrity_enc_int lhs, integrity_enc_int rhs, integrity_enc_int cond,
			uint8_t inst){
	while (!SE::module->io_in_ready)
	{
			// std::cout<<"looping"<<std::endl;
		SE::tick();
	}
	SE::module->io_in_valid = true;
	SE::module->io_out_ready = true;
	SE::module->io_in_inst = inst;

	memcpy(&SE::module->io_in_op1, &lhs.ciphertext, sizeof(lhs.ciphertext));
	memcpy(&SE::module->io_in_op2, &rhs.ciphertext, sizeof(rhs.ciphertext));
	memcpy(&SE::module->io_in_cond, &cond.ciphertext, sizeof(cond.ciphertext));

	SE::tick();
	SE::real_tickcount ++;
	SE::module->io_in_valid = false;
	SE::tick();
	SE::real_tickcount ++;
	while(!SE::module->io_out_valid){
		SE::tick();
		SE::real_tickcount ++;
	}
	integrity_enc_int result;

	memcpy(&result, &SE::module->io_out_result, sizeof(SE::module->io_out_result));
	result.decrypt_and_unswizzle();
	uint8_t num_cycle = 0;
	memcpy(&num_cycle, &SE::module->io_out_cntr, sizeof(SE::module->io_out_cntr));
	std::cout << "number cycles: "<< std::dec <<(int)num_cycle << std::endl;
	return result;
}


integrity_enc_int::integrity_enc_int(){
		ciphertext.upper = 0;
		ciphertext.lower = 0;
		plaintext.upper = 0;
		plaintext.lower = 0;
}
integrity_enc_int::integrity_enc_int(uint64_t secret, uint64_t salt, uint64_t dataflow_hash, uint64_t version){
		plaintext.upper = static_cast<__uint128_t>(secret) << 64 | salt;
		plaintext.lower = static_cast<__uint128_t>(dataflow_hash) << 64 | version;	
		swizzle_n_encrypt();
}

void integrity_enc_int::swizzle_n_encrypt(){
		uint64_t upper_odd_bits = 0,  
						upper_even_bits = 0, 
						lower_odd_bits =  0, 
						lower_even_bits = 0;
	
		for (int i = 0; i < 64; i++){
			upper_odd_bits |= (static_cast<uint64_t>(plaintext.upper >> (2*i+1)) & 1) << i;
			upper_even_bits |= (static_cast<uint64_t>(plaintext.upper >> (2*i)) & 1) << i;
			lower_odd_bits |= (static_cast<uint64_t>(plaintext.lower >> (2*i + 1)) & 1) << i;
			lower_even_bits |= (static_cast<uint64_t>(plaintext.lower >> (2*i)) & 1) << i;
		}
	uint64_t upper_left = upper_odd_bits ^ lower_odd_bits;
	uint64_t lower_right = upper_even_bits ^ lower_even_bits;
	uint64_t upper_right = lower_right ^ lower_odd_bits;
	uint64_t lower_left = upper_left ^ upper_even_bits;
	__uint128_t upper = upper_left;
	upper = upper << 64 | upper_right;
	__uint128_t lower = lower_left;
	lower = lower << 64 | lower_right;
	ciphertext.upper = aes128_encrypt_128(upper).convert_to_128();
	ciphertext.lower = aes128_encrypt_128(lower).convert_to_128();
}

void integrity_enc_int::decrypt_and_unswizzle(){
	plaintext.upper = aes128_decrypt_128(bit128_t(ciphertext.upper)).convert_to_128();
	plaintext.lower = aes128_decrypt_128(bit128_t(ciphertext.lower)).convert_to_128();
	uint64_t upper_left = static_cast<uint64_t>(plaintext.upper >> 64);
	uint64_t upper_right = static_cast<uint64_t>(plaintext.upper);
	uint64_t lower_left = static_cast<uint64_t>(plaintext.lower >> 64);
	uint64_t lower_right = static_cast<uint64_t>(plaintext.lower);

	uint64_t upper_even_bits = upper_left ^ lower_left;
	uint64_t lower_even_bits = upper_even_bits ^ lower_right;
	uint64_t lower_odd_bits = lower_right ^ upper_right;
	uint64_t upper_odd_bits = upper_left ^ lower_odd_bits;

	upper_left = 0, upper_right = 0, lower_left = 0,lower_right = 0;
	for (int i = 0; i < 32; i++){
		upper_left |= ((upper_odd_bits >> (32+i)) & 1) << (2* (32+i)+1);
		upper_left |= ((upper_even_bits >>  (32+i)) & 1) << (2* (32+i));
		upper_right |= ((upper_odd_bits >> i) & 1) << (2*i+1);
		upper_right |= ((upper_even_bits >> i) & 1) << (2*i);
		lower_left |= ((lower_odd_bits >> (32+i)) & 1) << (2* (32+i)+1);
		lower_left |= ((lower_even_bits >>  (32+i)) & 1) << (2* (32+i));
		lower_right |= ((lower_odd_bits >> i) & 1) << (2*i+1);
		lower_right |= ((lower_even_bits >> i) & 1) << (2*i);
	}
	__uint128_t upper = upper_left;
	upper = upper << 64 | upper_right;
	__uint128_t lower = lower_left;
	lower = lower << 64 | lower_right;
	plaintext.upper = upper;
	plaintext.lower = lower;
}

uint64_t integrity_enc_int::getSecret(){
	return static_cast<uint64_t>(plaintext.upper >> 64);
}

uint64_t integrity_enc_int::getSalt(){
	return static_cast<uint64_t>(plaintext.upper);
}

uint64_t integrity_enc_int::getDataflowhash(){
	return static_cast<uint64_t>(plaintext.lower >> 64);
}

uint64_t integrity_enc_int::getVersion(){
	return static_cast<uint64_t>(plaintext.lower);
}

void integrity_enc_int::operator=(const integrity_enc_int& C){
	ciphertext.upper = C.ciphertext.upper;
	ciphertext.lower = C.ciphertext.lower;
	plaintext.upper = C.plaintext.upper;
	plaintext.lower = C.plaintext.lower;
}

bool version_check(uint64_t op1, uint64_t op2){
	if(op1 == 0 || op2 == 0)
		return true;
	else
		return op1 == op2;
}

bool version_compute(uint64_t op1, uint64_t op2){
	if(op1 == 0 || op2 == 0 || op1!=op2)
		return 0;
	else
		return op1;
}

bool version_check_with_cond(uint64_t op1, uint64_t op2, uint64_t cond){
	if (op1 == 0){
		return version_check(op2, cond);
	}else if(op2 ==0){
		return version_check(op1, cond);
	}else if(cond == 0){
		return version_check(op1, op2);
	}else{
		return (op1 == op2) && (op1 == cond);
	}
}
	


integrity_enc_int operator+(integrity_enc_int lhs, 
		integrity_enc_int rhs){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::ADD()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		uint64_t secret = version_check(lhs.getVersion(), rhs.getVersion())? lhs.getSecret() + rhs.getSecret(): 0;
		uint64_t version = version_compute(lhs.getVersion(), rhs.getVersion());
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
	}

integrity_enc_int operator-(integrity_enc_int lhs, 
		integrity_enc_int rhs){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::SUB()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		uint64_t secret = version_check(lhs.getVersion(), rhs.getVersion())? lhs.getSecret() - rhs.getSecret(): 0;
		uint64_t version = version_compute(lhs.getVersion(), rhs.getVersion());
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
}

integrity_enc_int operator*(integrity_enc_int lhs, 
	integrity_enc_int rhs){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::MULT()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		uint64_t secret = version_check(lhs.getVersion(), rhs.getVersion())? lhs.getSecret() * rhs.getSecret(): 0;
		uint64_t version = version_compute(lhs.getVersion(), rhs.getVersion());
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
}

integrity_enc_int CMOV(integrity_enc_int lhs, integrity_enc_int rhs, integrity_enc_int cond){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::CMOV()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		dataflow = crc(dataflow, cond.getDataflowhash());
		uint64_t secret = version_check_with_cond(lhs.getVersion(), rhs.getVersion(), cond.getVersion())? (cond.getSecret()?lhs.getSecret():rhs.getSecret()): 0;
		uint64_t version = cond.getSecret()?lhs.getVersion(): rhs.getVersion();
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
}