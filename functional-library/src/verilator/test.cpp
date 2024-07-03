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

int print316(bit316_t &dec) {
	// Get the original value to print
	__uint128_t print_item_upper 	= aes128_decrypt_128(bit128_t(dec.getUpperCiph_128b())).convert_to_128();
	__uint128_t print_item_lower 	= aes128_encrypt_128(aes128_decrypt_128(bit128_t(dec.getLowerCiph_128b()))).convert_to_128();
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

int print316dec(bit316_t &dec) {
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
	printf("----------TESTING----------\n\n");

	// setting parameters
	printf("Begin setting parameters.\n");
	setParameters();
	printf("Finish setting parameters.\n---\n");
	
	// Test Zone
	printf("Testing Output Zone Begins.\n\n");
	// uint8_t test_array[16] = {0x2c, 0x1c, 0xa7, 0x76, 0xab, 0x19, 0x4b, 0x70, 0x3e, 0xee, 0xf2, 0x9a, 0x45, 0xfa, 0x99, 0x99};
	// bit128_t test_12345(test_array);
	// __uint128_t num_12345 = test_12345.convert_to_128();
	// printf("%x\n", (unsigned int) (num_12345 & 0xFF));
	printf("Testing Output Zone Ends.\n---\n");
	
	// generate SE simulator
	printf("Begin generating SE simulator.\n");
	SE se_simulator;
	printf("Finish generating SE simulator.\n---\n");
	
	// generate l1, l2 (opA and opB)
	printf("Begin generating enc_int for ALU computation part (lower 128 bits).\n\n");
	enc_lib::enc_int l1 = 1;
	enc_lib::enc_int l2 = 2;
	printf("\t(l1) Ciphertext_A (lower 128 bits): ");
	l1.ciphertext.print_hex(); // result: 13 18 9a 6a e4 ab 07 ae 70 a3 aa bd 30 be 99 de
	printf("\t(l1) Plaintext_A (lower 128 bits): ");
	printf("%x\n", l1.GET_DECRYPTED_VALUE());
	printf("\t(l2) Ciphertext_B (lower 128 bits): ");
	l2.ciphertext.print_hex(); // result: c7 6e 8f cf 7a d0 fe 9b 39 e0 83 73 9c be 26 c2
	printf("\t(l2) Plaintext_B (lower 128 bits): ");
	printf("%x\n\n", l2.GET_DECRYPTED_VALUE());
	printf("Finish generating enc_int.\n---\n");
	
	// generate upper 128 bits
	printf("Begin generating initial cyphertext for comparison part (upper 128 bits).\n\n");
	// Generating plaintext array
	// Structure: [rtsni'][Y_hsh][X_hsh] (old)
	uint8_t plaintext_A[16] = {0x2c, 0x1c, 0xa7, 0x76, 0xab, 0x19, 0x4b, 0x70, 0x3e, 0xee, 0xf2, 0x9a, 0x45, 0xfa, 0x99, 0x99};
	uint8_t plaintext_B[16] = {0x3a, 0x9b, 0xcb, 0xda, 0x01, 0xa9, 0xd7, 0x3e, 0xdd, 0x95, 0x02, 0x90, 0x1c, 0x5f, 0xdb, 0x25};
	// Convert to bit128_t
	bit128_t plaintext_A_bit128t(plaintext_A);
	bit128_t plaintext_B_bit128t(plaintext_B);
	// software ENCrypt
	bit128_t init_A = aes128_encrypt_128(plaintext_A_bit128t);
	bit128_t init_B = aes128_encrypt_128(plaintext_B_bit128t);
	printf("\t(l1) plaintext_A (upper 128 bits): ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", plaintext_A_bit128t.value[i]);
    }
	printf("\n");
	printf("\t(l1) ciphtext_A (upper 128 bits): ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", init_A.value[i]);
    }
	printf("\n");
	printf("\t(l2) plaintext_B (upper 128 bits): ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", plaintext_B_bit128t.value[i]);
    }
	printf("\n");
	printf("\t(l2) ciphtext_B (upper 128 bits): ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", init_B.value[i]);
    }
	printf("\n\n");
	printf("Finish generating initial cyphertext for comparison part (upper 128 bits).\n---\n");
	
	printf("Begin generating bit316_t opA and opB.\n\n");
	__uint128_t init_A_uint128 = 0;
	__uint128_t init_B_uint128 = 0;
    for(int i = 0; i < 16; ++i) {
        init_A_uint128 = (init_A_uint128 << 8) | init_A.value[i];
		init_B_uint128 = (init_B_uint128 << 8) | init_B.value[i];
    }
	uint8_t temp_trans_l1[16] = {0};
	uint8_t temp_trans_l2[16] = {0};
	for(int i = 0; i < 16; ++i) {
		temp_trans_l1[i] = l1.ciphertext.value[15 - i];
		temp_trans_l2[i] = l2.ciphertext.value[15 - i];
	}
	bit128_t trans_l1_temp(temp_trans_l1);
	bit128_t trans_l2_temp(temp_trans_l2);
	bit316_t opA(trans_l1_temp.convert_to_128(), init_A_uint128, (uint64_t) (init_A_uint128 >> 68));
	bit316_t opB(trans_l2_temp.convert_to_128(), init_B_uint128, (uint64_t) (init_B_uint128 >> 68));
	uint8_t* ptr_A = opA.get_value();
	uint8_t* ptr_B = opB.get_value();
	printf("\t(l1) opA input:\n");
	printf("\thash: ");
	for(int i = 0; i < 8; ++i) {
        printf("%02x ", ptr_A[i]);
    }
	printf("\n\tupper 128 bits: ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_A[i + 8]);
    }
	printf("\n\tlower 128 bits: ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_A[i + 24]);
    }
	printf("\n");
	printf("\t(l2) opB input:\n");
	printf("\thash: ");
	for(int i = 0; i < 8; ++i) {
        printf("%02x ", ptr_B[i]);
    }
	printf("\n\tupper 128 bits: ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_B[i + 8]);
    }
	printf("\n\tlower 128 bits: ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_B[i + 24]);
    }
	printf("\n\n");
	printf("Finish generating bit316_t opA and opB.\n---\n");
	
	printf("Begin SECompute.\n\n");
	bit316_t l3_SE = SE::SECompute(opA, opB, 0, Instruction::ADD());
	uint8_t* ptr_C = l3_SE.get_value();
	printf("\n\t(l3 computation) output (Ciphertext):\n");
	printf("\thash: ");
	for(int i = 0; i < 8; ++i) {
        printf("%02x ", ptr_C[i]);
    }
	printf("\n\tupper 128 bits: ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_C[i + 8]);
    }
	printf("\n\tlower 128 bits: ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_C[i + 24]);
    }
	printf("\n");
	printf("\nFinish SECompute.\n---\n");

	printf("Begin Hash comparison part (upper 128 bits) check.\n\n");
	// Print software-generated value
	printf("> Software-generated value:\n\n");
	// TODO:

	// Print hardware-generated value
	printf("> Hardware-generated value:\n\n");
	// TODO:

	printf("Finish Hash comparison part (upper 128 bits) check.\n---\n");
	
	printf("Begin ALU computation part (lower 128 bits) check.\n\n");
	enc_lib::enc_int l3 = l1 + l2;
	// Print software-generated value
	printf("> Software-generated value:\n\n");
	printf("\t(l3) Ciphertext of result (lower 128 bits): ");
	l3.ciphertext.print_hex();
	printf("\t(l3) Plaintext of result (lower 128 bits): ");
	printf("%d\n\n", l3.GET_DECRYPTED_VALUE());

	// Print hardware-generated value
	printf("> Hardware-generated value:\n\n");
	printf("\t(l3_SE) Ciphertext of result (lower 128 bits): ");
	for(int i = 0; i < 16; ++i) {
        printf("%02x ", ptr_C[i + 24]);
    }
	printf("\n");
	printf("\t(l3_SE) Plaintext of result (lower 128 bits): ");
	uint8_t l_128_arr[16] = {0};
	for(int i = 0; i < 16; ++i) {
        l_128_arr[i] = ptr_C[i + 24];
    }
	// uint8_t l_128_arr[16] = {0x90, 0xcb, 0x45, 0x61, 0x1c, 0x31, 0x05, 0xc8, 0x46, 0x24, 0xb2, 0xac, 0x12, 0xcb, 0x5b, 0x74};
	bit128_t l_128_temp(l_128_arr);
	int l3_SE_l128_plaintext = (int) decrypt_128_64(l_128_temp);
	printf("%d\n\n", l3_SE_l128_plaintext);
	printf("> Result:\n\n");
	if(l3.GET_DECRYPTED_VALUE() == l3_SE_l128_plaintext) {
		printf("\tThe ALU computation part is correct!\n\n");
	} else {
		printf("\tThe ALU computation part is incorrect!\n\n");
	}
	printf("Finish ALU computation part (lower 128 bits) check.\n\n");

	printf("------------END------------\n");

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
