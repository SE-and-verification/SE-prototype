#include "../src/interface/interface.h"
#include "../src/interface/parameters.h"
#include <string>
#include <iostream>
#include <bitset>
#include "../src/datatypes/enc_lib.h"
#include "./include/test_utils.h"

using namespace enc_lib;


// COMPILED WITH:: g++ -std=c++11 -O0 test_interface.cpp ../src/interface/parameters.cpp -o test_interface
// Toggle setParameters to turn on/off XOR encryption 

// COMPILE USING MAKE
// > make test_interface

int main(){
/*
    // *********************************
    // TEST ENCRYPTION OF 64-bit Enc_Int
    // *********************************
    // Initialize test value and encryption scheme
    // setParameters(SymmCipher::XOR, 0x0505050505050505, 0x0505050505050505, 0); // XOR With 0x050505...
    setParameters(SymmCipher::XOR, 0x0000000000000000, 0x0000000000000000, 0); // XOR With ZERO (e.g., no encryption)
    enc_int value1 = 0xFF00FF00FF00FF07;
    // Print binary representation of ciphertext
    std::cout<< "ENC:" << value1.ciphertext.c_str() << std::endl;
    // Decrypt ciphertext and print binary representation of value
    uint64_t plaintext1 = decrypt_128_64(value1.ciphertext);
    std::cout << "RET:" << std::bitset<64>(plaintext1) << std::endl;




    // *********************************
    // TEST ENCRYPTION OF 8-bit Enc_Bool
    // *********************************
    // Initialize test value and encryption scheme
    // setParameters(SymmCipher::XOR, 0x0505050505050505, 0x0505050505050505, 0); // XOR With 0x050505...
    setParameters(SymmCipher::XOR, 0x0000000000000000, 0x0000000000000000, 0); // XOR With ZERO (e.g., no encryption)
    enc_bool value2 = false;
    // Print binary representation of ciphertext
    std::cout<< "ENC:" << value2.ciphertext.c_str() << std::endl;
    // Decrypt ciphertext and print binary representation of value
    uint8_t plaintext2 = decrypt_128_8(value2.ciphertext);
    std::cout << "RET:" << std::bitset<8>(plaintext2) << std::endl;
*/
   // setParameters(SymmCipher::AES128, 0x2b7e151628aed2a6, 0xabf7158809cf4f3c, 0);
/*   setParameters(SymmCipher::AES128, 0x2b7e151628aed2a6, 0xabf7158809cf4f3c, 0);
    enc_int value3 = 0x3243f6a8885a308d;
       // Print binary representation of ciphertext
    std::cout<<"\n\nFrom test interface:"<<std::endl;   
    std::cout<< "ENC:" << value3.ciphertext.c_str() << std::endl;
    print_ciphertext(value3);
    std::cout<<"\n";
    // Decrypt ciphertext and print binary representation of value

    uint64_t plaintext3 = decrypt_128_64(value3.ciphertext);
    std::cout<<"\n\nFrom test interface:"<<std::endl;*/
  //std::cout << "RET:" <<std::hex<<plaintext3 /*std::bitset<64>(plaintext3)*/ << std::endl;
/*    print_plaintext(plaintext3);
    std::cout<<endl;
*/
    
    setParameters(SymmCipher::SimonXX, 0x000102030405067, 0x08090A0B0C0D0E0F, 0);
    enc_int value4=0x2074726176656c6c;

    std::cout<<"\n\nFrom test interface:"<<std::endl;   
    std::cout<< "ENC:" << value4.ciphertext.c_str() << std::endl;
    print_ciphertext(value4);
    std::cout<<"\n";
}