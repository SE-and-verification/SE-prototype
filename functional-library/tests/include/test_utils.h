#ifndef TEST_UTILS_H
#define TEST_UTILS_H
#include <stdint.h>
#include <iostream>
#include <iomanip>
#include "../../src/datatypes/enc_lib.h" 
#include "../../src/interface/bit_t.h"
using namespace std;
using namespace enc_lib;

static inline void print_ciphertext(enc_int value){
    for(int i=0;i<16;i++){
        cout<<"0x"<<hex<<setfill('0')<<setw(2)<<right<<value.ciphertext.value[i];
        
    }
}
/*static inline void print_ciphertext(bit128_t ciphertext){
    for(int i=0;i<16;i++){
        printf("%02x",ciphertext.value[i]);
    }
}*/

void print_plaintext(uint64_t value){
         cout<<"0x"<<hex<<setfill('0')<<setw(2)<<right<<value;
}

/*static inline void print_plaintext(bit128_t plaintext){
    for(int i=0;i<16;i++){
        printf("%02x",plaintext.value[i]);
    }
}

static inline void print_secret(bit128_t SECRET_KEY){
    for(int i=0;i<16;i++){
        printf("%02x",SECRET_KEY.value[i]);
        }
}*/


/*
void print_plaintext(enc_int* value){
        for(int i=0;i<16;i++){
        cout<<hex<<value->plaintext.value[i];
    }
}


void print_plaintext(enc_bool* value){
        for(int i=0;i<16;i++){
        cout<<hex<<value->plaintext.value[i];
    }
}

void print_plaintext(enc_char* value){
        for(int i=0;i<16;i++){
        cout<<hex<<value->plaintext.value[i];
    }
}*/



#endif