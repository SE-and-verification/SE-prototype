#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <iomanip>
#include <iostream>
#include "SEVerilator.h"
#include "VSE.h"
#include "verilated.h"
#include "Instruction.h"
#include "enc_lib.h"
 
int print128(__uint128_t print_item){
	uint64_t lower = (uint64_t)print_item;
	uint64_t upper = (uint64_t)(print_item>>64);
	std::cout<< std::setw(16) << std::setfill('0') << std::hex << upper<<"|"<<lower<<std::endl;
	return 0;
}
int print128dec(__uint128_t dec){
	__uint128_t print_item = aes128_decrypt_128(bit128_t(dec)).convert_to_128();
	uint64_t lower = (uint64_t)print_item;
	uint64_t upper = (uint64_t)(print_item>>64);
	std::cout <<"decrypted: " << std::setw(16) << std::setfill('0') <<std::hex << upper<<"|"<<lower<<std::endl;
	return 0;
}

// int changeKey(uint8_t* key){
// 	SECRET_KEY = bit128_t(key);
// 	aes128_set_key(SECRET_KEY);
// 	SE::changeKey(s_g.words);
// 	return 0;
// }

int main(){
	setParameters();
	SE se_simulator;

	uint64_t firstTicks, thisTicks, b = 0;
	__uint128_t ctxt, squared;

	{
		firstTicks = SE::real_tickcount;
		enc_lib::enc_int b_e = b;
		ctxt = b_e.ciphertext.convert_to_128();
		squared = SE::SECompute(ctxt, ctxt, ctxt, Instruction::MULT());
		thisTicks = firstTicks = SE::real_tickcount - firstTicks;
	}

	print128(ctxt);
	print128(squared);
	std::cout << "ticks: " << thisTicks << std::endl;

	do {
		thisTicks = SE::real_tickcount;
		enc_lib::enc_int b_e = b++;
		ctxt = b_e.ciphertext.convert_to_128();
		squared = SE::SECompute(ctxt, ctxt, ctxt, Instruction::MULT());
		thisTicks = SE::real_tickcount - thisTicks;
	} while (thisTicks == firstTicks);

	print128(ctxt);
	print128(squared);
	std::cout << "ticks: " << thisTicks << std::endl;

	return 0;
}
