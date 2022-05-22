#include "../src/datatypes/enc_lib.h"
#include <stdio.h>
// #include <stdint.h>

using namespace enc_lib;


// Preprocessor directives to place hard-coded values in custom ELF section "ciphertexts"
// The keyword "constexpr" assures that these values are initialized at compile time.
// This section is encrypted by the user after the program is compiled. 
// constexpr enc_int i0x  __attribute__((__section__("ciphertexts"))) = {5, 0};
// constexpr enc_int i1x  __attribute__((__section__("ciphertexts"))) = {17, 0};

enc_int test1(){
    enc_int i0x;
    i0x = 5;
    enc_int i1x;
    i1x = 17;
    printf("TEST 1:: Result should be 22\n");
    enc_int sum = i0x + i1x;
    printf("RESULT: %d\n\n", sum.value);
    return sum;
}

enc_int init_enc_int(int i){
    enc_int ret;
    ret = 7;
    return ret;
}

int main()
{
    enc_int n = test1();
    enc_int m = init_enc_int(7); // Have to init with curly braces
    m = 22; //Can do this tho 
    int x = (n == m).value ? 1 : 2; // THIS DOES NOT SHOW UP AS CMOV
    printf("RESULT: %d\n\n", x);
    return 0;
}

