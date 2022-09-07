#ifndef _PARAMETERS_CPP
#define _PARAMETERS_CPP

#include "parameters.h"

#include <iostream>
using namespace std;


SymmCipher CIPHER;
bit128_t SECRET_KEY;  

//Forward declaration of INTERFACE functions
void aes128_set_key(bit128_t key); 
void initialize_rng(int seed); 
void initialize_mersenne_rng(int seed);

void setParameters(){
        CIPHER = AES128; 
        uint8_t key[16] = {15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
        // uint8_t key[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};

        SECRET_KEY = bit128_t(key);
        //initialize_rng(0);
        initialize_mersenne_rng(1);
        aes128_set_key(SECRET_KEY);
}

void setParameters(SymmCipher cipher){
        CIPHER = cipher; 
        SECRET_KEY.init(0, 5);
        //initialize_rng(0);
        initialize_mersenne_rng(1);

        switch(CIPHER){
            case AES128:    aes128_set_key(SECRET_KEY); break;
            default:        break;
        }
}

void setParameters(SymmCipher cipher, uint64_t key_upper, uint64_t key_lower, int seed){
        //cout<<"---In set parameters----"<<endl;
        CIPHER = cipher; 
        SECRET_KEY.init(key_upper, key_lower);          
        //initialize_rng(seed);
        initialize_mersenne_rng(seed);

        switch(CIPHER){
            case AES128:    aes128_set_key(SECRET_KEY); break;
            default:        break;
        }
}

#endif