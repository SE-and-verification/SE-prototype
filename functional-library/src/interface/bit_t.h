#ifndef _UINT128_T_H
#define _UINT128_T_H
#include <stdlib.h> 
#include <bitset>
#include <cstdint>
#include <vector>
#include <string.h>
#include <iostream>

typedef struct bit128_t{

public: //SHOULD BE PRIVATE
    uint8_t value[16]; 
    /* THE bit128_t class stores values according to the following structure: 
    *
    * value[16] = [MSB] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [xxx] [LSB]
    *               0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15                                                                                                                   
    *             [------------------UPPER 64b------------------] [------------------LOWER 64b-------------------] 
    * 
    * FOR 64-bit values, like INT
    * value[16] = [INT] [INT] [INT] [INT] [INT] [INT] [INT] [INT] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad]
    *               0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15                                                                                                                   
    *             [------------------UPPER 64b------------------] [------------------LOWER 64b-------------------] 
    * 
    * FOR 8-bit values, like BOOL/CHAR
    * value[16] = [B/C] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad] [pad]
    *               0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15                                                                                                                   
    *             [------------------UPPER 64b------------------] [------------------LOWER 64b-------------------] 
    *             [---]
    *               ^ UPPER 8b
    */

private:
    char bit_str[129]; //128 bit-characters, followed by '\0'
    char hex_str[33];  //16  hex-characters, followed by '\0'


public:
    /******** CONSTRUCTORS ********/
    bit128_t(){
        for(int i=0; i<16; i++){
            value[i] = 0x00; //0000 0000
        } 
    }
    bit128_t(uint64_t upper_value, uint64_t lower_pad){
        init(upper_value, lower_pad);
    }
    bit128_t(uint8_t upper_value, uint8_t* lower_pad){
        /* Store upper_value in MSB/Index 0 */
        value[0]= upper_value;
        /* Store lower_pad in 8-bit segments */
        for(int i=15; i>=1 ; i--){
            value[i] = lower_pad[i-1];
        } 
    }
    bit128_t(uint8_t* full_value){
        /* Store full_value in 8-bit segments */
        for(int i=0; i<16; i++){
            value[i] = full_value[i];
        } 
    }
    bit128_t(__uint128_t full_value){
        /* Store full_value in 8-bit segments */
        memcpy(this->value, &full_value, sizeof(this->value));
    }
    __uint128_t convert_to_128() {
        // Warning: convert_to_128() will inverse the order of array elements.
        // value: [11][22][33][44][55][66][77][88][99][00][aa][bb][cc][dd][ee][ff]
        // result: ffeeddccbbaa00998877665544332211
        __uint128_t result = 0;
        memcpy(&result, this->value, sizeof(this->value));
        return result;
    }

    void init(uint64_t upper_value, uint64_t lower_pad) {
        // Break and store upper_value and lower_pad in 8-bit segments
        // Byte Order:
        // upper_value: 0x1122334455667788
        // lower_pad: 0x9900aabbccddeeff
        // result: [11][22][33][44][55][66][77][88][99][00][aa][bb][cc][dd][ee][ff]
        //      MSB *                                                        LSB *
        // value[0][XX]                                               value[15][XX]

        for(int i = 7; i >= 0; i--) {
            value[i] = upper_value & 0xFF;
            value[i + 8] = lower_pad & 0xFF; 
            upper_value = upper_value >> 8;
            lower_pad = lower_pad >> 8;
        }
    }

    /******** VALUE ACCESS FUNCTIONS ********/
    uint64_t getUpperValue_64b(){
        uint64_t ret = 0;
        for(int i=7; i>=0; i--){
            ret = ret + ((uint64_t)value[8-i-1]);
            if(i != 0){ret = ret << 8;} 
        }
        return ret;        
    }


    uint64_t getUpperValue_8b(){
        return value[0];
    }


    uint64_t getLowerValue_64b(){
        uint64_t ret = 0;
        for(int i=15; i>=8; i--){
            ret = ret + ((uint64_t)value[16-(i-7)]);
            if(i != 8){ret = ret << 8;} 
        }
        return ret;      
    }


    /******** PRINT UTILITIES ********/
    char* get_bit_cstr(){
        char* dest = bit_str; 
        for(int i=0; i<16; i++){
            // Convert uint8_t to bits
            std::bitset<8> x(value[i]); 
            const char* mystr = x.to_string().c_str();
            // Copy bits into destination
            strncpy(dest, mystr, 8);
            dest += 8;
        }
        bit_str[128] = '\0';
        return bit_str;
    }

    char* get_hex_cstr(){
        uint8_t* values = value; 
        int val_len = 16;
        char* dest = hex_str; 
        while(val_len--){
            // Convert uint8_t into hex and copy into destination
            sprintf(dest, "%02x", *values);
            dest += 2;
            ++values;
        }
        hex_str[32] = '\0';
        return hex_str;
    }

    void print_hex(){
        char* to_print = get_hex_cstr();
        // printf("\t0x");
        for(int i=0; i<32; i+=2){
            printf("%c%c ", to_print[i], to_print[i+1]);
        }
        printf("\n");
    }

    void print_hex_parted_32(){
        char* to_print = get_hex_cstr();
        printf("0x");
        for(int i=0; i<8; i+=2){
            printf(" %c%c", to_print[i], to_print[i+1]);
        }
        printf("\n");
        printf("0x");
        for(int i=8; i<16; i+=2){
            printf(" %c%c", to_print[i], to_print[i+1]);
        }
        printf("\n");
        printf("0x");
        for(int i=16; i<24; i+=2){
            printf(" %c%c", to_print[i], to_print[i+1]);
        }
        printf("\n");
        printf("0x");
        for(int i=24; i<32; i+=2){
            printf(" %c%c", to_print[i], to_print[i+1]);
        }
        printf("\n");

    }


    void print_bin(){
        char* to_print = get_bit_cstr();
        printf("\t  ");
        for(int i=0; i<16; i++){
            printf(" ");
            for(int j=0; j<8; j++){
                // Lazy about typing, so doing a double loop here :) 
                printf("%c", to_print[(8*i) + j]);
            }
        }
        printf("\n");
    }

    void print_bin_parted_32(){
        char* to_print = get_bit_cstr();
        for(int i=0; i<4; i++){
            for(int j=0; j<8; j++){
                // Lazy about typing, so doing a double loop here :) 
                printf("%c", to_print[(8*i) + j]);
            }
        }
        printf("\n");
        for(int i=4; i<8; i++){
            for(int j=0; j<8; j++){
                // Lazy about typing, so doing a double loop here :) 
                printf("%c", to_print[(8*i) + j]);
            }
        }
        printf("\n");
        for(int i=8; i<12; i++){
            for(int j=0; j<8; j++){
                // Lazy about typing, so doing a double loop here :) 
                printf("%c", to_print[(8*i) + j]);
            }
        }
        printf("\n");
        for(int i=12; i<16; i++){
            for(int j=0; j<8; j++){
                // Lazy about typing, so doing a double loop here :) 
                printf("%c", to_print[(8*i) + j]);
            }
        }
        printf("\n");
    }

    void print_parted_32(bool last){
        for(int i=0; i<4; i++){
            printf("%d", value[i]);
            
        }
        printf("\n");
        for(int i=4; i<8; i++){
            printf("%d", value[i]);
        }
        printf("\n");
        for(int i=8; i<12; i++){
            printf("%d", value[i]);
        }
        printf("\n");
        for(int i=12; i<16; i++){
            printf("%d", value[i]);
        }
        if(!last){
            printf("\n");
        }
    }



} bit128_t;

class bit316_t {

private:
    uint8_t value[40]; 
    // The bit316_t class stores values according to the following structure:
    // value[0]              : 4 dummy bits, should be 0       <- MSB
    // value[1]  - value[7]  : 60-bit hash 
    // value[8]  - value[23] : 128-bit upper half cypher_text
    // value[24] - value[39] : 128-bit lower half cypher_text  <- LSB
    
    char bit_str[321]; // 4 dummy bits and 316 bit-characters, followed by '\0'
    char hex_str[81]; // 4 dummy bits and 79 hex-characters, followed by '\0'

public:
    // ***Constructors***
    bit316_t() {
        for(int i = 0; i < 40; i++) {
            value[i] = 0x00;
        } 
    }

    bit316_t(__uint128_t ciphtext_lower, __uint128_t ciphtext_upper, uint64_t hash) {
        // Store lower half into lower 128 bits
        for(int i = 39; i >= 24; i--) {
            value[i] = (ciphtext_lower) & 0xFF;
            ciphtext_lower = ciphtext_lower >> 8;
        }
        // Store upper half into upper 128 bits 
        for(int i = 23; i >= 8; i--) {
            value[i] = (ciphtext_upper) & 0xFF;
            ciphtext_upper = ciphtext_upper >> 8;
        }
        // Store hash into MS 60 (64) bits
        for(int i = 7; i >= 0; i--) {
            value[i] = (hash) & 0xFF;
            hash = hash >> 8;
        }
    }

    bit316_t(uint8_t* ciphtext_lower, __uint128_t ciphtext_upper, uint64_t hash) {
        // Store lower half into lower 128 bits
        for(int i = 0; i < 16; ++i) {
            value[i + 24] = ciphtext_lower[i];
        }
        // Store upper half into upper 128 bits 
        for(int i = 23; i >= 8; i--) {
            value[i] = (ciphtext_upper) & 0xFF;
            ciphtext_upper = ciphtext_upper >> 8;
        }
        // Store hash into MS 60 (64) bits
        for(int i = 7; i >= 0; i--) {
            value[i] = (hash) & 0xFF;
            hash = hash >> 8;
        }
    }

    bit316_t(const uint8_t* full_value) {
        // Convert from uint8_t array 
        for(int i = 0; i < 40; i++) {
            value[i] = full_value[i];
        } 
    }

    bit316_t(const std::vector<uint8_t> &full_value) {
        // Convert from vector
        for(int i = 0; i < 40; i++) {
            value[i] = full_value[i];
        } 
    }
    
    bit316_t(const unsigned int* full_value) {
        // Convert from unsigned int array 
        for(int i = 0; i < 10; i++) {
            value[i * 4] = (uint8_t)((full_value[i] >> 24) & 0xFF);
            value[i * 4 + 1] = (uint8_t)(full_value[i] >> 16) & 0xFF;
            value[i * 4 + 2] = (uint8_t)(full_value[i] >> 8) & 0xFF;
            value[i * 4 + 3] = (uint8_t)full_value[i] & 0xFF;
        }
    }

    // ***Value Access***
    __uint128_t getLowerCiph_128b() {
        __uint128_t lower_128_bits = 0;
        for (int i = 0; i < 16; i++) {
            lower_128_bits = (lower_128_bits << 8) | value[24 + i];
        }
        return lower_128_bits;        
    }

    __uint128_t getUpperCiph_128b() {
        __uint128_t upper_128_bits = 0;
        for (int i = 0; i < 16; i++) {
            upper_128_bits = (upper_128_bits << 8) | value[8 + i];
        }
        return upper_128_bits;        
    }

    uint64_t getHashValue_64b() {
        __uint128_t hash_value = 0;
        for (int i = 0; i < 8; i++) {
            hash_value = (hash_value << 8) | value[i];
        }
        return hash_value; 
    }

    uint8_t* get_value() {
        return this->value;
    }

    // ***Print Utilities*** 
    char* get_bit_cstr() {
        // Update and return bit_str
        for (int i = 0; i < 40; ++i) {
            for (int j = 0; j < 8; ++j) {
                bit_str[i * 8 + j] = (value[i] & (1 << (7 - j))) ? '1' : '0';
            }
        }
        bit_str[320] = '\0';
        return bit_str;
    }

    char* get_hex_cstr() {
        // Update and return hex_str
        for (int i = 0; i < 40; ++i) {
            sprintf(hex_str + i * 2, "%02x", value[i]);
        }
        hex_str[80] = '\0';
        return hex_str;
    }

    void print_hex() {
        // Output hex_str
        char* to_print = get_hex_cstr();
        printf("\t0x");
        puts(to_print);
    }

    // void print_hex_parted_32(){
    //     char* to_print = get_hex_cstr();
    //     printf("0x");
    //     for(int i=0; i<8; i+=2){
    //         printf(" %c%c", to_print[i], to_print[i+1]);
    //     }
    //     printf("\n");
    //     printf("0x");
    //     for(int i=8; i<16; i+=2){
    //         printf(" %c%c", to_print[i], to_print[i+1]);
    //     }
    //     printf("\n");
    //     printf("0x");
    //     for(int i=16; i<24; i+=2){
    //         printf(" %c%c", to_print[i], to_print[i+1]);
    //     }
    //     printf("\n");
    //     printf("0x");
    //     for(int i=24; i<32; i+=2){
    //         printf(" %c%c", to_print[i], to_print[i+1]);
    //     }
    //     printf("\n");

    // }


    void print_bin(){
        // Output bit_str
        char* to_print = get_bit_cstr();
        printf("\t0b");
        for(int i = 0; i < 40; i++) {
            printf(" ");
            for(int j = 0; j < 8; j++) {
                printf("%c", to_print[8 * i + j]);
            }
        }
        printf("\n");
    }

    // void print_bin_parted_32(){
    //     char* to_print = get_bit_cstr();
    //     for(int i=0; i<4; i++){
    //         for(int j=0; j<8; j++){
    //             // Lazy about typing, so doing a double loop here :) 
    //             printf("%c", to_print[(8*i) + j]);
    //         }
    //     }
    //     printf("\n");
    //     for(int i=4; i<8; i++){
    //         for(int j=0; j<8; j++){
    //             // Lazy about typing, so doing a double loop here :) 
    //             printf("%c", to_print[(8*i) + j]);
    //         }
    //     }
    //     printf("\n");
    //     for(int i=8; i<12; i++){
    //         for(int j=0; j<8; j++){
    //             // Lazy about typing, so doing a double loop here :) 
    //             printf("%c", to_print[(8*i) + j]);
    //         }
    //     }
    //     printf("\n");
    //     for(int i=12; i<16; i++){
    //         for(int j=0; j<8; j++){
    //             // Lazy about typing, so doing a double loop here :) 
    //             printf("%c", to_print[(8*i) + j]);
    //         }
    //     }
    //     printf("\n");
    // }

    // void print_parted_32(bool last){
    //     for(int i=0; i<4; i++){
    //         printf("%d", value[i]);
            
    //     }
    //     printf("\n");
    //     for(int i=4; i<8; i++){
    //         printf("%d", value[i]);
    //     }
    //     printf("\n");
    //     for(int i=8; i<12; i++){
    //         printf("%d", value[i]);
    //     }
    //     printf("\n");
    //     for(int i=12; i<16; i++){
    //         printf("%d", value[i]);
    //     }
    //     if(!last){
    //         printf("\n");
    //     }
    // }

};

#endif
