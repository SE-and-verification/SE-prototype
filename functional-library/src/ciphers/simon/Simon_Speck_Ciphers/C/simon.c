/*
 * Simon.c
 * Implementation of NSA Simon Block Cipher
 * Copyright 2017 Michael Calvin McCoy
 * calvin.mccoy@gmail.com
 *  # The MIT License (MIT) - see LICENSE.md
*/

#include <stdint.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>
#include "simon.h"


// Cipher Operation Macros
#define shift_one(x_word) (((x_word) << 1) | ((x_word) >> (word_size - 1)))
#define shift_eight(x_word) (((x_word) << 8) | ((x_word) >> (word_size - 8)))
#define shift_two(x_word) (((x_word) << 2) | ((x_word) >> (word_size - 2)))

#define rshift_three(x) (((x) >> 3) | (((x) & 0x7) << (word_size - 3)))
#define rshift_one(x)   (((x) >> 1) | (((x) & 0x1) << (word_size - 1)))

uint64_t z_arrays[5] = {0b0001100111000011010100100010111110110011100001101010010001011111,
                        0b0001011010000110010011111011100010101101000011001001111101110001,
                        0b0011001101101001111110001000010100011001001011000000111011110101,
                        0b0011110000101100111001010001001000000111101001100011010111011011,
                        0b0011110111001001010011000011101000000100011011010110011110001011};

// Valid Cipher Parameters
const uint8_t simon_rounds[] = {32, 36, 36, 42, 44, 52, 54, 68, 69, 72};
const uint8_t  z_assign[] = {0, 0, 1, 2, 3, 2, 3, 2, 3, 4};

uint8_t Simon_Init(SimSpk_Cipher *cipher_object, enum cipher_config_t cipher_cfg, enum mod_t c_mode, uint8_t *key, uint8_t *iv, uint8_t *counter) {

    if (cipher_cfg > cfg_256_128 || cipher_cfg < cfg_64_32){
        return 1;
    }
    
    cipher_object->block_size = block_sizes[cipher_cfg];
    cipher_object->key_size = key_sizes[cipher_cfg];
    cipher_object->round_limit = simon_rounds[cipher_cfg];
    cipher_object->cipher_cfg = cipher_cfg;
    cipher_object->z_seq = z_assign[cipher_cfg];
    uint8_t word_size = block_sizes[cipher_cfg] >> 1;
    uint8_t word_bytes = word_size >> 3;
    uint16_t key_words =  key_sizes[cipher_cfg] / word_size;
    uint64_t sub_keys[4] = {};
    uint64_t mod_mask = ULLONG_MAX >> (64 - word_size);

    // Setup
    for(int i = 0; i < key_words; i++) {
        memcpy(&sub_keys[i], key + (word_bytes * i), word_bytes);
    }
    
    uint64_t tmp1,tmp2;
    uint64_t c = 0xFFFFFFFFFFFFFFFC; 
    
    // Store First Key Schedule Entry
    memcpy(cipher_object->key_schedule, &sub_keys[0], word_bytes);

    for (int i = 0; i < simon_rounds[cipher_cfg] - 1; i++) {
        tmp1 = rshift_three(sub_keys[key_words - 1]);

        if (key_words == 4) {
            tmp1 ^= sub_keys[1];
        }

        tmp2 = rshift_one(tmp1);
        tmp1 ^= sub_keys[0];
        tmp1 ^= tmp2;

        tmp2 = c ^ ((z_arrays[cipher_object->z_seq] >> (i % 62)) & 1);

        tmp1 ^= tmp2;

        // Shift Sub Words
        for (int j = 0; j < (key_words - 1); j++) {
            sub_keys[j] = sub_keys[j + 1];
        }
        sub_keys[key_words - 1] = tmp1 & mod_mask;

        // Append sub key to key schedule
        memcpy(cipher_object->key_schedule + (word_bytes * (i + 1)), &sub_keys[0], word_bytes);

    }

    if (cipher_cfg == cfg_64_32){
        cipher_object->encryptPtr = &Simon_Encrypt_32;
        cipher_object->decryptPtr = &Simon_Decrypt_32;
    }
    else if(cipher_cfg <= cfg_96_48){
        cipher_object->encryptPtr = Simon_Encrypt_48;
        cipher_object->decryptPtr = Simon_Decrypt_48;
    }
    else if(cipher_cfg <= cfg_128_64) {
        cipher_object->encryptPtr = Simon_Encrypt_64;
        cipher_object->decryptPtr = Simon_Decrypt_64;

    }

    else if(cipher_cfg <= cfg_144_96) {
        cipher_object->encryptPtr = Simon_Encrypt_96;
        cipher_object->decryptPtr = Simon_Decrypt_96;
    }

    else if(cipher_cfg <= cfg_256_128) {
        cipher_object->encryptPtr = Simon_Encrypt_128;
        cipher_object->decryptPtr = Simon_Decrypt_128;
    }

    else return 1;

    return 0;
}


uint8_t Simon_Encrypt(SimSpk_Cipher cipher_object, uint8_t *plaintext, uint8_t *ciphertext) {
    (*cipher_object.encryptPtr)(cipher_object.round_limit, cipher_object.key_schedule, plaintext, ciphertext);
    return 0;
}

void Simon_Encrypt_32(const uint8_t round_limit, const uint8_t *key_schedule, uint8_t *plaintext, uint8_t *ciphertext) {
    
    const uint8_t word_size = 16;
    uint16_t *y_word = (uint16_t *)ciphertext;
    uint16_t *x_word = (((uint16_t *)ciphertext) + 1);

    *y_word = *(uint16_t *)plaintext;
    *x_word = *(((uint16_t *)plaintext) + 1);

    uint16_t *round_key_ptr = (uint16_t *)key_schedule;

    for(uint8_t i = 0; i < round_limit; i++) {

        // Shift, AND , XOR ops
        uint16_t temp = (shift_one(*x_word) & shift_eight(*x_word)) ^ *y_word ^ shift_two(*x_word);
        
        // Feistel Cross
        *y_word = *x_word;
        
        // XOR with Round Key
        *x_word = temp ^ *(round_key_ptr + i);
    }
}

void Simon_Encrypt_48(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *plaintext,
                      uint8_t *ciphertext) {
    
    const uint8_t word_size = 24;

    bword_24 intrd = *(bword_24 *)plaintext;
    uint32_t y_word = intrd.data;
    intrd = *((bword_24 *)(plaintext+3));
    uint32_t x_word = intrd.data;

    for(uint8_t i = 0; i < round_limit; i++) {

        // Shift, AND , XOR ops
        uint32_t temp = (shift_one(x_word) & shift_eight(x_word)) ^ y_word ^ shift_two(x_word);

        // Feistel Cross
        y_word = x_word;
        
        // XOR with Round Key
        x_word = (temp ^ (*((bword_24 *)(key_schedule + (i*3)))).data) & 0xFFFFFF;
    }
    // Assemble Ciphertext Output Array
    intrd.data = y_word;
    bword_24 * intrd_ptr = (bword_24 *)ciphertext; 
    *intrd_ptr = intrd;
    
    intrd.data = x_word;
    intrd_ptr = (bword_24 *)(ciphertext + 3);
    *intrd_ptr = intrd;
}

void Simon_Encrypt_64(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *plaintext,
                      uint8_t *ciphertext) {
    
    const uint8_t word_size = 32;
    uint32_t *y_word = (uint32_t *)ciphertext;
    uint32_t *x_word = (((uint32_t *)ciphertext) + 1);
    *y_word = *(uint32_t *)plaintext;
    *x_word = *(((uint32_t *)plaintext) + 1);
    uint32_t *round_key_ptr = (uint32_t *)key_schedule;

    for(uint8_t i = 0; i < round_limit; i++) {

        // Shift, AND , XOR ops
        uint32_t temp = (shift_one(*x_word) & shift_eight(*x_word)) ^ *y_word ^ shift_two(*x_word);
        
        // Feistel Cross
        *y_word = *x_word;
        
        // XOR with Round Key
        *x_word = temp ^ *(round_key_ptr + i);
    }
}

void Simon_Encrypt_96(const uint8_t round_limit, const uint8_t *key_schedule, uint8_t *plaintext,
                      uint8_t *ciphertext) {
    
    const uint8_t word_size = 48;

    bword_48 intrd = *(bword_48 *)plaintext;
    uint64_t y_word = intrd.data;
    intrd = *((bword_48 *)(plaintext+6));
    uint64_t x_word = intrd.data;

    for(uint8_t i = 0; i < round_limit; i++) {  

        // Shift, AND , XOR ops
        uint64_t temp = (shift_one(x_word) & shift_eight(x_word)) ^ y_word ^ shift_two(x_word);

        // Feistel Cross
        y_word = x_word;
        
        // XOR with Round Key
        x_word = (temp ^ (*((bword_48 *)(key_schedule + (i*6)))).data) & 0xFFFFFFFFFFFF;
    }
    // Assemble Ciphertext Output Array
    intrd.data = y_word;
    bword_48 * intrd_ptr = (bword_48 *)ciphertext; 
    *intrd_ptr = intrd;
    
    intrd.data = x_word;
    intrd_ptr = (bword_48 *)(ciphertext + 6);
    *intrd_ptr = intrd;
    
}

void Simon_Encrypt_128(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *plaintext,
                       uint8_t *ciphertext) {

    const uint8_t word_size = 64;
    uint64_t *y_word = (uint64_t *)ciphertext;
    uint64_t *x_word = (((uint64_t *)ciphertext) + 1);
    *y_word = *(uint64_t *)plaintext;
    *x_word = *(((uint64_t *)plaintext) + 1);
    uint64_t *round_key_ptr = (uint64_t *)key_schedule;


    for(uint8_t i = 0; i < round_limit; i++) {

        // Shift, AND , XOR ops
        uint64_t temp = (shift_one(*x_word) & shift_eight(*x_word)) ^ *y_word ^ shift_two(*x_word);
        
        // Feistel Cross
        *y_word = *x_word;
        
        // XOR with Round Key
        *x_word = temp ^ *(round_key_ptr + i);
    }
}

uint8_t Simon_Decrypt(SimSpk_Cipher cipher_object, uint8_t *ciphertext, uint8_t *plaintext) {
    (*cipher_object.decryptPtr)(cipher_object.round_limit, cipher_object.key_schedule, ciphertext, plaintext);
    return 0;
}

void Simon_Decrypt_32(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *ciphertext,
                      uint8_t *plaintext) {

    const uint8_t word_size = 16;
    uint16_t *x_word = (uint16_t *)plaintext;
    uint16_t *y_word = ((uint16_t *)plaintext) + 1;
    uint16_t *round_key_ptr = (uint16_t *)key_schedule;

    *x_word = *(uint16_t *)ciphertext;
    *y_word = *(((uint16_t *)ciphertext) + 1);

    for(int8_t i = round_limit - 1; i >= 0; i--) {

        // Shift, AND , XOR ops
        uint16_t temp = (shift_one(*x_word) & shift_eight(*x_word)) ^ *y_word ^ shift_two(*x_word);
        
        // Feistel Cross
        *y_word = *x_word;
        
        // XOR with Round Key
        *x_word = temp ^ *(round_key_ptr + i);
    }
}

void Simon_Decrypt_48(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *ciphertext,
                      uint8_t *plaintext){
    const uint8_t word_size = 24;

    bword_24 intrd = *(bword_24 *)ciphertext;
    uint32_t x_word = intrd.data;
    intrd = *((bword_24 *)(ciphertext+3));
    uint32_t y_word = intrd.data;

    for(int8_t i = round_limit - 1 ; i >= 0; i--) {

        // Shift, AND , XOR ops
        uint32_t temp = (shift_one(x_word) & shift_eight(x_word)) ^ y_word ^ shift_two(x_word);

        // Feistel Cross
        y_word = x_word;
        
        // XOR with Round Key
        x_word = (temp ^ (*((bword_24 *)(key_schedule + (i*3)))).data) & 0xFFFFFF;
    }
    // Assemble plaintext Output Array
    intrd.data = x_word;
    bword_24 * intrd_ptr = (bword_24 *)plaintext; 
    *intrd_ptr = intrd;
    
    intrd.data = y_word;
    intrd_ptr = (bword_24 *)(plaintext + 3);
    *intrd_ptr = intrd;
}

void Simon_Decrypt_64(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *ciphertext,
                      uint8_t *plaintext){

    const uint8_t word_size = 32;
    uint32_t *x_word = (uint32_t *)plaintext;
    uint32_t *y_word = ((uint32_t *)plaintext) + 1;
    uint32_t *round_key_ptr = (uint32_t *)key_schedule;

    *x_word = *(uint32_t *)ciphertext;
    *y_word = *(((uint32_t *)ciphertext) + 1);

    for(int8_t i = round_limit -1 ; i >= 0; i--) {

        // Shift, AND , XOR ops
        uint32_t temp = (shift_one(*x_word) & shift_eight(*x_word)) ^ *y_word ^ shift_two(*x_word);
        
        // Feistel Cross
        *y_word = *x_word;
        
        // XOR with Round Key
        *x_word = temp ^ *(round_key_ptr + i);
    }
}

void Simon_Decrypt_96(const uint8_t round_limit, const uint8_t *key_schedule,  uint8_t *ciphertext,
                      uint8_t *plaintext){
    const uint8_t word_size = 48;
    bword_48 intrd = *(bword_48 *)ciphertext;
    uint64_t x_word = intrd.data;
    intrd = *((bword_48 *)(ciphertext+6));
    uint64_t y_word = intrd.data;

    for(int8_t i = round_limit - 1; i >= 0; i--) {

        // Shift, AND , XOR ops
        uint64_t temp = (shift_one(x_word) & shift_eight(x_word)) ^ y_word ^ shift_two(x_word);

        // Feistel Cross
        y_word = x_word;
        
        // XOR with Round Key
        x_word = (temp ^ (*((bword_48 *)(key_schedule + (i*6)))).data) & 0xFFFFFFFFFFFF;
    }
    // Assemble Plaintext Output Array
    intrd.data = x_word;
    bword_48 * intrd_ptr = (bword_48 *)plaintext; 
    *intrd_ptr = intrd;
    
    intrd.data = y_word;
    intrd_ptr = (bword_48 *)(plaintext + 6);
    *intrd_ptr = intrd;
}

void Simon_Decrypt_128(const uint8_t round_limit, const uint8_t *key_schedule, uint8_t *ciphertext,
                       uint8_t *plaintext){

    const uint8_t word_size = 64;
    uint64_t *x_word = (uint64_t *)plaintext;
    uint64_t *y_word = ((uint64_t *)plaintext) + 1;
    uint64_t *round_key_ptr = (uint64_t *)key_schedule;

    *x_word = *(uint64_t *)ciphertext;
    *y_word = *(((uint64_t *)ciphertext) + 1);

    for(int8_t i = round_limit - 1; i >=0; i--) {

        // Shift, AND , XOR ops
        uint64_t temp = (shift_one(*x_word) & shift_eight(*x_word)) ^ *y_word ^ shift_two(*x_word);
        
        // Feistel Cross
        *y_word = *x_word;
        
        // XOR with Round Key
        *x_word = temp ^ *(round_key_ptr + i);
    }
}
