#ifndef _INTERFACE_H
#define _INTERFACE_H
#include "../ciphers/aes/aes_interface.h"
#include "../rng/rng_interface.h"
#include "parameters.h"



bit128_t test_encrypt_128_128(uint8_t* full_value) {
    bit128_t plaintext(full_value);
    switch(CIPHER) {
        case AES128:    
            return aes128_encrypt_128(plaintext);
        default:
            std::cerr << "Invalid CIPHER!\n";
            bit128_t dummy; 
            return dummy;
    }
}

uint64_t test_qarma_encrypt_128_128(uint64_t* value) {
    // uint64_t pad = get_random_pad_64b();
    uint64_t pad = 0;
    // uint64_t pad = 0x313198a2e0370734;    //Pad for AES TEST
    // uint64_t pad = 0x6572732064657363;      //Pad for Simon Test
    bit128_t plaintext(*value, pad);
    // printf("PLA:"); plaintext.print_hex();
    switch(CIPHER) {
        case AES128:    
            return aes128_encrypt_128(plaintext).getUpperValue_64b();
        default:
            std::cerr << "Invalid CIPHER!\n";
            return (uint64_t) 0;
    }

}


bit128_t test_decrypt_128_128(bit128_t ciphertext) {
    switch(CIPHER) {
        case AES128:    
            return aes128_decrypt_128(ciphertext);
        default:
            std::cerr << "Invalid CIPHER!\n";
            bit128_t dummy; 
            return dummy;
    }
}

bit128_t encrypt_64_128(uint64_t* value) {
    // uint64_t pad = get_mersenne_random_pad_64b();
    uint64_t pad = 0;
    // uint64_t pad = 0x313198a2e0370734;    //Pad for AES TEST
    // uint64_t pad = 0x6572732064657363;      //Pad for Simon Test
    bit128_t plaintext(*value, pad);
    // printf("encrypt_64_128_plaintext:"); plaintext.print_hex();

    switch(CIPHER) {
        case AES128:
            return aes128_encrypt_128(plaintext);
        default:
            std::cerr << "Invalid CIPHER!\n";
            bit128_t dummy; 
            return dummy;
    }
}

uint64_t decrypt_128_64(bit128_t ciphertext) {
    switch(CIPHER) {
        case AES128:    
            return aes128_decrypt_128(ciphertext).getUpperValue_64b();
        default:
            std::cerr << "Invalid CIPHER!\n";
            return (uint64_t) 0;
    }
}


bit128_t encrypt_8_128(uint8_t* value) {
    uint8_t pad[15];
    for(int i=0; i<15; i++){
        // pad[i] = get_mersenne_random_pad_8b();
        pad[i] = 0;
    }
    bit128_t plaintext(*value, pad);
    // printf("PLA:"); plaintext.print_hex();

    switch(CIPHER) {
        case AES128:    
            return aes128_encrypt_128(plaintext);
        default:
            std::cerr << "Invalid CIPHER!\n";
            bit128_t dummy; 
            return dummy;
    }
}

uint8_t decrypt_128_8(bit128_t ciphertext) {
    switch(CIPHER) {
        case AES128:    
            return aes128_decrypt_128(ciphertext).getUpperValue_8b();
        default:
            std::cerr << "Invalid CIPHER!\n";
            return (uint8_t) 0;
    }
}


#endif
