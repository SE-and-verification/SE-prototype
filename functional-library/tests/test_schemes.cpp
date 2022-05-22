#include "../src/interface/interface.h"
#include <string>
#include <iostream>
#include <bitset>
#include "../src/datatypes/enc_lib.h"
#include <map>

using namespace enc_lib;

std::map<SymmCipher, const char*> CipherStrings = {{AES128, "AES128"}, {QARMA64, "QARMA64"}, {SimonXX, "Simon"}, {XOR, "XOR"}};



// COMPILE USING MAKE
// > make test_schemes


void run_test(){

    const char* enc_scheme = CipherStrings[CIPHER];

    /*** TEST INT ENCRYPTION ***/
    printf("Testing %s ENC of INT(0x0000FF07)\n", enc_scheme);
    printf("KEY:"); SECRET_KEY.print_hex();
    // Get + Print encrypted value
    enc_int int_enc = 0x0000FF07;
    printf("ENC:"); int_enc.ciphertext.print_hex(); 
    // Get + Print decrypted value
    int64_t int_decypt = decrypt_128_64(int_enc.ciphertext);
    printf("DEC:\t0x%02llx, %lld\n", int_decypt, int_decypt); 
    printf("\n");

    /*** TEST CHAR ENCRYPTION ***/
    printf("Testing %s ENC of CHAR(0x41)\n", enc_scheme);
    printf("KEY:"); SECRET_KEY.print_hex();
    // Get + Print encrypted value
    enc_char char_enc = 0x41; 
    printf("ENC:"); char_enc.ciphertext.print_hex(); 
    // Get + Print decrypted value
    char char_decypt = decrypt_128_8(char_enc.ciphertext);
    printf("DEC:\t0x%02x, %c\n", char_decypt, char_decypt); 
    printf("\n");

    /*** TEST BOOL ENCRYPTION ***/
    printf("Testing %s ENC of BOOL(0x00)\n", enc_scheme);
    printf("KEY:"); SECRET_KEY.print_hex();
    // Get + Print encrypted value
    enc_bool bool_enc = 0x00; 
    printf("ENC:"); bool_enc.ciphertext.print_hex(); 
    // Get + Print decrypted value
    char bool_decypt = decrypt_128_8(bool_enc.ciphertext);
    printf("DEC:\t0x%02x\n", bool_decypt, bool_decypt); 
    printf("\n");
}


void test_aes_expected(){
    
    printf("Testing AES NIST INPUT\n");

    uint8_t nist_input[NUM_OF_NIST_KEYS] = {
		0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d,
		0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34
	};
	uint8_t expected[NUM_OF_NIST_KEYS] = {
		0x39, 0x25, 0x84, 0x1d, 0x02, 0xdc, 0x09, 0xfb,
		0xdc, 0x11, 0x85, 0x97, 0x19, 0x6a, 0x0b, 0x32
	};

    setParameters(SymmCipher::AES128, 0x2b7e151628aed2a6, 0xabf7158809cf4f3c, 0); 
    printf("KEY:"); SECRET_KEY.print_hex();

    bit128_t cipher = test_encrypt_128_128(nist_input);
    printf("ENC:"); cipher.print_hex(); 
    printf("EXP:"); (bit128_t(expected)).print_hex(); 
    printf("----\n");
    bit128_t plain = test_decrypt_128_128(cipher);
    printf("DEC:"); plain.print_hex(); 
    printf("EXP:"); (bit128_t(nist_input)).print_hex(); 
    printf("\n");
}

void test_simon_expected(){
    
    printf("Testing SIMON NIST INPUT\n");

    uint8_t simon128_128_key[] = {0x00, 0x01, 0x02, 0x03,0x04, 0x05, 0x06,0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F};
    uint8_t simon128_128_plain[] = {0x20, 0x74, 0x72, 0x61, 0x76, 0x65, 0x6c, 0x6c, 0x65, 0x72, 0x73, 0x20, 0x64, 0x65, 0x73, 0x63};
    uint8_t simon128_128_cipher[] = {0xbc, 0x0b, 0x4e, 0xf8, 0x2a, 0x83, 0xaa, 0x65, 0x3f, 0xfe, 0x54, 0x1e, 0x1e, 0x1b, 0x68, 0x49};

    setParameters(SymmCipher::SimonXX, 0x0001020304050607,  0x08090A0B0C0D0E0F, 0); 
    printf("KEY:"); SECRET_KEY.print_hex();

    bit128_t cipher = test_encrypt_128_128(simon128_128_plain);
    printf("ENC:"); cipher.print_hex(); 
    printf("EXP:"); (bit128_t(simon128_128_cipher)).print_hex(); 
    printf("----\n");
    bit128_t plain = test_decrypt_128_128(cipher);
    printf("DEC:"); plain.print_hex(); 
    printf("EXP:"); (bit128_t(simon128_128_plain)).print_hex(); 
    printf("\n");
}


void test_qarma_expected(){
    
    printf("Testing QARMA\n");

    uint64_t value = 0xfb623599da6e8127;
    uint64_t expected = 0xc003b93999b33765;
    uint64_t* val= &value;

    setParameters(SymmCipher::QARMA64, 0x84be85ce9804e94b, 0xec2802d4e0a488e9, 0); 
    uint64_t w_key=SECRET_KEY.getUpperValue_64b();
    uint64_t c_key=SECRET_KEY.getLowerValue_64b();
    printf("W_KEY: %02llx ",w_key);
    printf("\n");
    printf("C_KEY: %02llx ",c_key); 
    printf("\n\n");

    bit128_t cipher = encrypt_64_128(val);
    uint64_t ciphertext=cipher.getUpperValue_64b();
    printf("ENC: %02llx ",ciphertext); 
    printf("EXP: -------------- ");  
    printf("\n");
    bit128_t plain = test_decrypt_128_128(cipher);
    uint64_t plaintext=plain.getUpperValue_64b();
    printf("DEC: %02llx ",plaintext); 
    printf("EXP: %02llx ", value); ; 
    printf("\n");
}


int main(){
    printf("Running tests...\n\n");

    printf("**************************\nTESTING XOR SCHEME\n**************************\n");
    setParameters(SymmCipher::XOR, 0x0000000000000000, 0x0000000000000000, 14); // XOR With ZERO (e.g., no encryption)
    run_test();

    
    printf("**************************\nTESTING XOR SCHEME\n**************************\n");
    setParameters(SymmCipher::XOR, 0x0505050505050505, 0x0505050505050505, 0); // XOR With 0x050505... 
    run_test();

    printf("**************************\nTESTING AES SCHEME\n**************************\n");
    setParameters(SymmCipher::AES128, 0x0505050505050505, 0x0505050505050505, 0); 
    run_test();

    test_aes_expected(); 
    test_simon_expected();
    test_qarma_expected();

}