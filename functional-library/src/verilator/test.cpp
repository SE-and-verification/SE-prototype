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

int print316(bit316_t dec){
	__uint128_t print_item_upper = dec.getUpperCiph_128b();
	__uint128_t print_item_lower = dec.getLowerCiph_128b();
	uint64_t print_hash = dec.getHashValue_64b();

	uint64_t upper_high = (uint64_t)(print_item_upper >> 64);
    uint64_t upper_low = (uint64_t)(print_item_upper & 0xFFFFFFFFFFFFFFFF);
    printf("0x%016lx%016lx", upper_high, upper_low);

	uint64_t lower_high = (uint64_t)(print_item_lower >> 64);
    uint64_t lower_low = (uint64_t)(print_item_lower & 0xFFFFFFFFFFFFFFFF);
    printf("0x%016lx%016lx", lower_high, lower_low);

	printf("Value3: 0x%016lx\n", print_hash);
	return 0;
}

int print316dec(bit316_t dec){
	__uint128_t print_item_upper = aes128_decrypt_128(bit128_t(dec.getUpperCiph_128b())).convert_to_128();
	__uint128_t print_item_lower = aes128_decrypt_128(bit128_t(dec.getLowerCiph_128b())).convert_to_128();
	uint64_t print_hash = dec.getHashValue_64b();

	uint64_t upper_high = (uint64_t)(print_item_upper >> 64);
    uint64_t upper_low = (uint64_t)(print_item_upper & 0xFFFFFFFFFFFFFFFF);
    printf("0x%016lx%016lx", upper_high, upper_low);

	uint64_t lower_high = (uint64_t)(print_item_lower >> 64);
    uint64_t lower_low = (uint64_t)(print_item_lower & 0xFFFFFFFFFFFFFFFF);
    printf("0x%016lx%016lx", lower_high, lower_low);

	printf("Value3: 0x%016lx\n", print_hash);
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
	printf("setParameters finished\n");
	SE se_simulator;
	printf("SE compiled\n");
	enc_lib::enc_int l1 = 1;
	enc_lib::enc_int l2 = 2;
	enc_lib::enc_int l3 = l1+l2;
	// enc_lib::enc_int l6 = l2*l3;
	printf("enc_int l1 l2 l3 instatiated\n");
	bit316_t opA(l1.ciphertext.convert_to_128(), 0, 0);
	bit316_t opB(l2.ciphertext.convert_to_128(), 0, 0);
	printf("bit316_t opA opB instatiated\n");
	

	// __uint128_t l3_veri = SE::SECompute(l1.ciphertext.convert_to_128(), l2.ciphertext.convert_to_128(), 0, Instruction::ADD())

	// printf("%d\n",decrypt_128_64( l3_veri));
	// printf("%d:\n",1);
	// print128(l1.ciphertext.convert_to_128());
	// printf("%d:\n",2);
	// print128(l2.ciphertext.convert_to_128());
	// print128dec(l2.ciphertext.convert_to_128());
	// print128dec(l1.ciphertext.convert_to_128());
	// print128dec(l3.ciphertext.convert_to_128());
	// print128(l3.ciphertext.convert_to_128());
	// printf("ticks: %d\n", SE::real_tickcount);

	bit316_t l3_SE = SE::SECompute(opA, opB, 0, Instruction::ADD());
	printf("SECompute finished\n");
	// print128(l3_SE);
	// print128dec(l3_SE);
	print316(l3_SE);
	printf("l3_SE printed\n");
	print316dec(l3_SE);
	printf("decrypted l3_SE printed\n");

	// // print128(l6.ciphertext.convert_to_128());
	// printf("ticks: %d\n", SE::real_tickcount);

	// bit316_t l6_SE = SE::SECompute(l2.ciphertext.convert_to_128(), l3.ciphertext.convert_to_128(), 0, Instruction::MULT());
	// print128(l6_SE);
	// print128dec(l6_SE);
	// printf("ticks: %d\n", SE::real_tickcount);

	// // uint8_t newKey[16] = {15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
	// // changeKey(newKey);
	// enc_lib::enc_int l1_new = 1;
	// enc_lib::enc_int l2_new = 2;
	// enc_lib::enc_int l3_new = 3;
	// __uint128_t l3_SE_new = SE::SECompute(l2_new.ciphertext.convert_to_128(), l1_new.ciphertext.convert_to_128(), 0, Instruction::ADD());
	// __uint128_t l6_SE_new = SE::SECompute(l2_new.ciphertext.convert_to_128(), l3_new.ciphertext.convert_to_128(), 0, Instruction::MULT());
	// __uint128_t l9_SE_new = SE::SECompute(l3_SE_new, l6_SE_new, 0, Instruction::ADD());
	// print128(l9_SE_new);
	// print128dec(l9_SE_new);

	// __uint128_t shift_SE_new = SE::SECompute(l3_SE_new, l6_SE_new, 0, Instruction::SLL());

	// print128(shift_SE_new);
	// print128dec(shift_SE_new);
	return 0;
}
