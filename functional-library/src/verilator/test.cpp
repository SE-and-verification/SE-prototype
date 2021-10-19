#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <iostream>
#include "SEVerilator.h"
#include "VSE.h"
#include "verilated.h"
#include "Instruction.h"
#include "enc_lib.h"

int print128(__uint128_t print_item){
	uint64_t lower = (uint64_t)print_item;
	uint64_t upper = (uint64_t)(print_item>>64);
	std::cout << std::hex << upper<<lower<<std::endl;
	return 0;
}

int main(){
	setParameters();
	SE se_simulator;
	enc_lib::enc_int l1 = 1;
	enc_lib::enc_int l2 = 2;
	enc_lib::enc_int l3 = l1+l2;
	enc_lib::enc_int l6 = l2*l3;

	// __uint128_t l3_veri = SE::SECompute(l1.ciphertext.convert_to_128(), l2.ciphertext.convert_to_128(), 0, Instruction::ADD())

	// printf("%d\n",decrypt_128_64( l3_veri));
	printf("%d:\n",1);
	print128(l1.ciphertext.convert_to_128());
	printf("%d:\n",2);
	print128(l2.ciphertext.convert_to_128());
	print128(l3.ciphertext.convert_to_128());
	printf("ticks: %d\n", SE::real_tickcount);
	print128(SE::SECompute(l2.ciphertext.convert_to_128(), l1.ciphertext.convert_to_128(), 0, Instruction::ADD()));
	print128(l6.ciphertext.convert_to_128());
	printf("ticks: %d\n", SE::real_tickcount);
	print128(SE::SECompute(l2.ciphertext.convert_to_128(), l3.ciphertext.convert_to_128(), 0, Instruction::MULT()));
	printf("ticks: %d\n", SE::real_tickcount);
	return 0;
}