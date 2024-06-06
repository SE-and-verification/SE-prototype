#ifndef _UINT128_T_H
#define _UINT128_T_H
#include <stdlib.h> 
#include <bitset>
#include <cstdint>
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
    __uint128_t convert_to_128(){
        __uint128_t result = 0;
        memcpy(&result, this->value, sizeof(this->value));
        return result;
    }
    void init(uint64_t upper_value, uint64_t lower_pad){
        /* Break and store upper_value in 8-bit segments */
        for(int i=7; i>=0; i--){
            value[i] = upper_value & 0xFF ; 
            upper_value = upper_value >> 8;
        }
        /* Break and store lower_pad in 8-bit segments */
        for(int i=15; i>=8; i--){
            value[i] = lower_pad & 0xFF;
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
        printf("\t0x");
        for(int i=0; i<32; i+=2){
            printf(" %c%c", to_print[i], to_print[i+1]);
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


// typedef struct bit64_t{
//     uint8_t value[8]; //Index 0 contains LSB
//     char str[65]; //LSB stoerd at index 64

// public:
//     //Constructors
//     bit64_t(){
//         for(int i=0; i<8; i++){
//             value[i] = 0x00;
//         } 
//     }
//     bit64_t(uint64_t upper, uint8_t lower){
//         initByte(upper, lower);
//     }

//     void initByte(uint64_t upper, uint8_t lower){
//         value[0] = lower;
//         for(int i=1; i<7; i++){ //Skip MSB of Upper!
//             value[i] = upper & 0xFF;
//             upper = upper >> 8;
//         } 
//     }

//     void init(uint64_t upper, uint64_t lower){
//         for(int i=0; i<8; i++){
//             value[i] = lower & 0xFF ;
//             lower = lower >> 8;
//         }
//         for(int i=8; i<16; i++){
//             value[i] = upper & 0xFF;
//             upper = upper >> 8;
//         } 
//     }

//     char* c_str(){
//         for(int i=0; i<8; i++){
//             const char* i_str = std::bitset<8>(value[i]).to_string().c_str(); //LSB stored at index 7
//             for (int j=0; j<8; j++){
//                 str[(8*(8-i-1)) +j] = i_str[j];
//             }
//         }  
//         str[64] = '\0';
//         return str;
//     }

//     // uint64_t getLower(){
//     //     uint64_t ret = 0;
//     //     for(int i=0; i<8; i++){
//     //         if(i != 0){ret = ret << 8;} //Shift previous addition
//     //         ret = ret + ((uint64_t)value[8-i-1]); 
//     //     }
//     //     return ret;
//     // }

//     uint8_t getLowerByte(){
//         return value[0];
//     }

//     // uint64_t getUpper(){
//     //     uint64_t ret = 0;
//     //     for(int i=8; i<16; i++){
//     //         ret = ret + value[i];
//     //         ret = ret << 8;
//     //     }
//     //     return ret;
//     // }

// } bit64_t;

typedef struct bit316_t{

public: //SHOULD BE PRIVATE
    uint8_t value[40]; 
    /* THE bit316_t class stores values according to the following structure: 
    *
    * value[40] = [0/bit 0-3] [1-7/bit 4-63] [8-23/bit 64-191] [24-39/bit 192-319]
    *                  0       hash            ciphtext_lower    ciphtext_upper
    */

private:
    // char bit_str[129]; //128 bit-characters, followed by '\0'
    // char hex_str[33];  //16  hex-characters, followed by '\0'


public:
    /******** CONSTRUCTORS ********/
    bit316_t() {
        for(int i = 0; i < 39; i++) {
            value[i] = 0x00; //0000 0000
        } 
    }
    bit316_t(__uint128_t ciphtext_upper, __uint128_t ciphtext_lower, uint64_t hash) {
        init(ciphtext_upper, ciphtext_lower, hash);
    }
    // bit128_t(uint8_t upper_value, uint8_t* lower_pad){
    //     /* Store upper_value in MSB/Index 0 */
    //     value[0]= upper_value;
    //     /* Store lower_pad in 8-bit segments */
    //     for(int i=15; i>=1 ; i--){
    //         value[i] = lower_pad[i-1];
    //     } 
    // }
    // bit128_t(uint8_t* full_value){
    //     /* Store full_value in 8-bit segments */
    //     for(int i=0; i<16; i++){
    //         value[i] = full_value[i];
    //     } 
    // }
    // bit128_t(__uint128_t full_value){
    //     /* Store full_value in 8-bit segments */
    //     memcpy(this->value, &full_value, sizeof(this->value));
    // }
    // __uint128_t convert_to_128(){
    //     __uint128_t result = 0;
    //     memcpy(&result, this->value, sizeof(this->value));
    //     return result;
    // }
    void init(__uint128_t ciphtext_upper, __uint128_t ciphtext_lower, uint64_t hash){
        // Store lower half into LS 128 bits
        for(int i = 39; i >= 24; i--) {
            value[i] = (ciphtext_lower) & 0xFF;
            ciphtext_lower = ciphtext_lower >> 8;
        }
        // Store upper half into middle 128 bits 
        for(int i = 23; i >= 8; i--) {
            value[i] = (ciphtext_upper) & 0xFF;
            ciphtext_upper = ciphtext_upper >> 8;
        }
        // Store hash into MS 60 (64) bits
        for(int i = 7; i >= 1; i--) {
            value[i] = (hash) & 0xFF;
            hash = hash >> 8;
        }
        value[0] = 0;
    }

    /******** VALUE ACCESS FUNCTIONS ********/
    __uint128_t getUpperCiph_128b(){
        __uint128_t upper_128_bits = 0;
        for (int i = 0; i < 16; i++) {
            upper_128_bits = (upper_128_bits << 8) | value[24 + i];
        }
        return upper_128_bits;        
    }

    __uint128_t getLowerCiph_128b(){
        __uint128_t lower_128_bits = 0;
        for (int i = 0; i < 16; i++) {
            lower_128_bits = (lower_128_bits << 8) | value[8 + i];
        }
        return lower_128_bits;        
    }

    uint64_t getHashValue_64b(){
        __uint128_t hash_value = 0;
        for (int i = 0; i < 16; i++) {
            hash_value = (hash_value << 8) | value[1 + i];
        }
        return hash_value; 
    }


    // /******** PRINT UTILITIES ********/
    // char* get_bit_cstr(){
    //     char* dest = bit_str; 
    //     for(int i=0; i<16; i++){
    //         // Convert uint8_t to bits
    //         std::bitset<8> x(value[i]); 
    //         const char* mystr = x.to_string().c_str();
    //         // Copy bits into destination
    //         strncpy(dest, mystr, 8);
    //         dest += 8;
    //     }
    //     bit_str[128] = '\0';
    //     return bit_str;
    // }

    // char* get_hex_cstr(){
    //     uint8_t* values = value; 
    //     int val_len = 16;
    //     char* dest = hex_str; 
    //     while(val_len--){
    //         // Convert uint8_t into hex and copy into destination
    //         sprintf(dest, "%02x", *values);
    //         dest += 2;
    //         ++values;
    //     }
    //     hex_str[32] = '\0';
    //     return hex_str;
    // }

    // void print_hex(){
    //     char* to_print = get_hex_cstr();
    //     printf("\t0x");
    //     for(int i=0; i<32; i+=2){
    //         printf(" %c%c", to_print[i], to_print[i+1]);
    //     }
    //     printf("\n");
    // }

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


    // void print_bin(){
    //     char* to_print = get_bit_cstr();
    //     printf("\t  ");
    //     for(int i=0; i<16; i++){
    //         printf(" ");
    //         for(int j=0; j<8; j++){
    //             // Lazy about typing, so doing a double loop here :) 
    //             printf("%c", to_print[(8*i) + j]);
    //         }
    //     }
    //     printf("\n");
    // }

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

} bit316_t;


#endif
