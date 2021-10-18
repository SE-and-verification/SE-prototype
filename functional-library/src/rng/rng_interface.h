#include "../interface/parameters.h"
#include "mersenne-twister-1/mersenne-twister.h"
#include <iostream>
using namespace std;


// Random Number Generator for Salts
int RANDOM_SEED; 
std::mt19937 RNG; 


void initialize_rng(int seed){
    RANDOM_SEED = seed;
    RNG.seed(RANDOM_SEED);
    // RNG.discard(100);
}

uint64_t get_random_pad_64b(){
    //Not sure if this random number is in the correct range... 
    uint64_t ret = RNG() % (2^64);
    return ret; 
}

uint8_t get_random_pad_8b(){
    uint8_t ret = (RNG() % 256);
    return ret;
}

// Random number generator using the Mersenne-Twister library
void initialize_mersenne_rng(int seed){
    RANDOM_SEED = seed;
    srand(seed);

}

uint64_t get_mersenne_random_pad_64b(){
    //cout<<"In mersenne 64"<<endl;
    uint64_t ret = rand_u64();
    return ret;
}

uint64_t get_mersenne_random_pad_8b(){
    //cout<<"In mersenne 8"<<endl;
    uint64_t ret = rand_u64() % 256;
    return ret;
}