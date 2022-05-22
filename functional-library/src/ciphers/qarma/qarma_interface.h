#include "../../interface/parameters.h"
#include "../qarma/code/qarma64.h"
#include <iostream>
#include <bitset>

uint64_t c_key;
uint64_t w_key;
uint64_t tweak = 0x477d469dec0b8762;
int rounds = 7;


void qarma64_set_key(bit128_t key){
    w_key=key.getUpperValue_64b();
    c_key=key.getLowerValue_64b();
}


bit128_t qarma64_encrypt_128(bit128_t plaintext){
    bit128_t ciphertext;
    uint64_t upper64b= plaintext.getUpperValue_64b();
    uint64_t lower64b= plaintext.getLowerValue_64b();

    uint64_t enc_lower64b= qarma64_enc(lower64b, tweak, w_key, c_key, rounds);
    uint64_t randomized_value = enc_lower64b^upper64b;
    uint64_t enc_upper64b= qarma64_enc(randomized_value, tweak, w_key, c_key, rounds);

    
    ciphertext=bit128_t(enc_upper64b,enc_lower64b);

    return ciphertext;
}

bit128_t qarma64_decrypt_128(bit128_t ciphertext){
    bit128_t plaintext;

    uint64_t upper64b= ciphertext.getUpperValue_64b();
    uint64_t lower64b= ciphertext.getLowerValue_64b();

    uint64_t dec_upper64b= qarma64_dec(upper64b, tweak, w_key, c_key, rounds);
    uint64_t randomized_value = dec_upper64b^lower64b; 
    uint64_t dec_lower64b= qarma64_dec(lower64b, tweak, w_key, c_key, rounds);


    plaintext=bit128_t(randomized_value,dec_lower64b);	    
    return plaintext;
}

