#ifndef _AES_INTERFACE_H
#define _AES_INTERFACE_H

#include "../../interface/interface.h"
#include "../../interface/parameters.h"
#include "tinyCrypt_without_Git/lib/include/tinycrypt/aes.h"


#define NUM_OF_NIST_KEYS 16
#define NUM_OF_FIXED_KEYS 128

struct tc_aes_key_sched_struct s_g;


void aes128_set_key(bit128_t key){
	printf("Setting AES keys\n");
 	tc_aes128_set_encrypt_key(&s_g, SECRET_KEY.value);
}


bit128_t aes128_encrypt_128(bit128_t plaintext){
	
	uint8_t temp_ciphertext[NUM_OF_NIST_KEYS];
	tc_aes_encrypt(temp_ciphertext, plaintext.value, &s_g);

    return bit128_t(temp_ciphertext);
}


bit128_t aes128_decrypt_128(bit128_t ciphertext){

	uint8_t temp_plaintext[NUM_OF_NIST_KEYS];
	tc_aes_decrypt(temp_plaintext, ciphertext.value, &s_g);
	
    return bit128_t(temp_plaintext);
}


#endif