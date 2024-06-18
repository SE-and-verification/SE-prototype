#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <iomanip>
#include <iostream>
#include <inttypes.h>
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

int print316(bit316_t dec) {
	// Get the original value to print
	__uint128_t print_item_upper 	= dec.getUpperCiph_128b();
	__uint128_t print_item_lower 	= dec.getLowerCiph_128b();
	uint64_t print_hash 			= dec.getHashValue_64b();
	
	// Split them into uint64_t type values
	uint64_t upper_high = (uint64_t) (print_item_upper >> 64);
    uint64_t upper_low  = (uint64_t) (print_item_upper & 0xFFFFFFFFFFFFFFFF);
	uint64_t lower_high = (uint64_t) (print_item_lower >> 64);
    uint64_t lower_low  = (uint64_t) (print_item_lower & 0xFFFFFFFFFFFFFFFF);

	// Print the values
	printf("Ciphertext:\n");
	printf("\tUpper 128 bits: %016" PRIx64 " %016" PRIx64 "\n", upper_high, upper_low);
    printf("\tLower 128 bits: %016" PRIx64 " %016" PRIx64 "\n", lower_high, lower_low);
	printf("\tHash: %016" PRIx64 "\n", print_hash);
	
	return 0;
}

int print316dec(bit316_t dec) {
	// Get the original value to print
	__uint128_t print_item_upper 	= aes128_decrypt_128(bit128_t(dec.getUpperCiph_128b())).convert_to_128();
	__uint128_t print_item_lower 	= aes128_decrypt_128(bit128_t(dec.getLowerCiph_128b())).convert_to_128();
	uint64_t print_hash 			= dec.getHashValue_64b();

	// Split them into uint64_t type values
	uint64_t upper_high = (uint64_t)(print_item_upper >> 64);
    uint64_t upper_low = (uint64_t)(print_item_upper & 0xFFFFFFFFFFFFFFFF);
	uint64_t lower_high = (uint64_t)(print_item_lower >> 64);
    uint64_t lower_low = (uint64_t)(print_item_lower & 0xFFFFFFFFFFFFFFFF);

	// Print the values
	printf("Plaintext:\n");
	printf("\tUpper 128 bits: %016" PRIx64 " %016" PRIx64 "\n", upper_high, upper_low);
    printf("\tLower 128 bits: %016" PRIx64 " %016" PRIx64 "\n", lower_high, lower_low);
	printf("\tHash: %016" PRIx64 "\n", print_hash);

	return 0;
}

// int changeKey(uint8_t* key){
// 	SECRET_KEY = bit128_t(key);
// 	aes128_set_key(SECRET_KEY);
// 	SE::changeKey(s_g.words);
// 	return 0;
// }

int main() {
	printf("[[[[----------TESTING----------]]]]\n");
	setParameters();
	printf("setParameters finished.\n");
	SE se_simulator;
	printf("SE simulator generated.\n");
	enc_lib::enc_int l1 = 1;
	enc_lib::enc_int l2 = 2;
	enc_lib::enc_int l3 = l1 + l2;
	// enc_lib::enc_int l6 = l2 * l3;
	printf("enc_int l1 l2 l3 instatiated.\n");
	uint8_t plaintext_A[16] = {0x2c, 0x1c, 0xa7, 0x76, 0xab, 0x19, 0x4b, 0x70, 0x3e, 0xee, 0xf2, 0x9a, 0x45, 0xfa, 0x99, 0x99};
	uint8_t plaintext_B[16] = {0x3a, 0x9b, 0xcb, 0xda, 0x01, 0xa9, 0xd7, 0x3e, 0xdd, 0x95, 0x02, 0x90, 0x1c, 0x5f, 0xdb, 0x25};
	bit128_t plaintext_A_bit128t(plaintext_A);
	bit128_t plaintext_B_bit128t(plaintext_B);
	bit128_t init_A = aes128_encrypt_128(plaintext_A_bit128t);
	bit128_t init_B = aes128_encrypt_128(plaintext_B_bit128t);
	printf("initial cypher and hash generated.\n");
	__uint128_t init_A_uint128 = 0;
	__uint128_t init_B_uint128 = 0;
    for(int i = 0; i < 16; ++i) {
        init_A_uint128 = (init_A_uint128 << 8) | init_A.value[i];
		init_B_uint128 = (init_B_uint128 << 8) | init_B.value[i];
    }
	bit316_t opA(l1.ciphertext.convert_to_128(), init_A_uint128, (uint64_t) (init_A_uint128 >> 68));
	bit316_t opB(l2.ciphertext.convert_to_128(), init_B_uint128, (uint64_t) (init_B_uint128 >> 68));
	printf("bit316_t opA opB instatiated.\n");
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
	printf("SECompute finished.\n");
	print316(l3_SE);
	print316dec(l3_SE);
	printf("Result printing finished.\n");
	if(l3.ciphertext.convert_to_128() == l3_SE.getLowerCiph_128b()) {
		printf("The computation part is correct!\n");
	} else {
		printf("The computation part is incorrect!\n");
	}

	printf("Comparison finished.\n");

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
