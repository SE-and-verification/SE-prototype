#include "../src/datatypes/enc_lib.h"
#include "../src/datatypes/enc_string.h"
#include <stdio.h>

using namespace enc_lib;

const char* c = "hello World ";
const char* c1 = "hey";
enc_char b __attribute__((__section__("ciphertexts")))= {'b', "000000"};
enc_char a __attribute__((__section__("ciphertexts")))= {'a', "000000"};
enc_char l __attribute__((__section__("ciphertexts")))= {'l', "000000"};
enc_string char_list __attribute__((__section__("ciphertexts")))= {b,a,l,l};
enc_string hello_m __attribute__((__section__("ciphertexts"))) = c;
enc_string hello_m2 __attribute__((__section__("ciphertexts"))) = c1;
enc_int i0x  __attribute__((__section__("ciphertexts"))) = {1, 0};

void test1(){
    printf("TEST 1-1:: Result should be l\n");
    printf("Operator function with int: %c\n", hello_m[2].value);
    printf("TEST 1-2:: Result should be e\n");
    printf("Operator function with enc_int: %c\n\n", hello_m[i0x].value);
}

void test2(){
    printf("TEST 2-1:: Result should be l\n");
    printf("at() with int: %c\n", hello_m.at(2).value);
    printf("TEST 2-2:: Result should be e\n");
    printf("at() with enc_int: %c\n\n", hello_m.at(i0x).value);
}

void test3(){
    printf("TEST 3:: Result should be -13\n");
    printf("enc_strcmp(): %d\n\n", enc_strcmp(hello_m, hello_m2).value);
}

void test4(){
    printf("TEST 4:: Result should be 12\n");
    printf("size(): %d\n\n", hello_m.size().value);
}

void test5(){
    printf("TEST 5:: Result should be hello World hey");
    enc_strcat(hello_m, hello_m2);
    printf("\nenc_strcat(): "); 
    hello_m.print();
}

void test6(){
    printf("\n\nTEST 6:: Result should be hey");
    enc_strcpy(hello_m, hello_m2);
    printf("\nenc_strcpy(): ");
    hello_m.print();
}

void test7(){
    printf("\n\nTEST 7:: Result should be ball");
    printf("\nenc_string with initializer list: ");
    char_list.print();
    printf("size(): %d\n\n", char_list.size().value);
}

int main(){
    test1();
    test2();
    test3();
    test4();
    test5();
    test6();
    test7();
    return 0;
}
