#include "../src/datatypes/enc_lib.h"
#include "../src/datatypes/enc_array.h"
#include "../src/datatypes/enc_string.h"
#include "../src/datatypes/elements.h"
#include <stdio.h>
//#include <stdint.h>

using namespace enc_lib;


// Preprocessor directives to place hard-coded values in custom ELF section "ciphertexts"
// This section is encrypted by the user after the program is compiled. 
enc_int i0x  __attribute__((__section__("ciphertexts"))) = {0, 0};
enc_int i1x  __attribute__((__section__("ciphertexts"))) = {1, 0};
enc_int i2x  __attribute__((__section__("ciphertexts"))) = {2, 0};
enc_int i3x  __attribute__((__section__("ciphertexts"))) = {3, 0};
enc_array<enc_int> a1 __attribute__((__section__("ciphertexts"))) = {i0x, i1x}; 
enc_array<enc_int> a2 __attribute__((__section__("ciphertexts")))(i2x, 4); 


void test1(){
       
    printf("TEST 1:: Result should be 1\n");

    enc_int sum = i0x;
    int size = a1.size().value;
    for(int i=0; i < size; i++){
        sum.value += a1[i].value.value;
    }
    printf("RESULT: %d\n", sum.value);
}

void test2(){
        
    printf("TEST 2-1:: Result should be 1\n");
    printf("Operator[] with enc_int: %d\n", a1[i1x]->value);
    printf("TEST 2-2:: Result should be 0\n");
    printf("Operator[] with int: %d\n", a1[0].value);
}

void test3(){
    printf("TEST 3:: Result should be 1\n");
    printf("find(): %d\n", a1.find(i1x).value);
}

void test4(){
       
    printf("TEST 4-1:: Result should be 1\n");
    printf("at() with enc_int: %d\n", a1.at(i1x).value);
    printf("TEST 4-2:: Result should be 0\n");
    printf("at() with int: %d\n", a1.at(0).value);
}

void test5(){
    printf("TEST 5-1 Result should be the front element\n");
    printf("The front element in the array is: %d\n", a1.front().value);

    printf("TEST 5-2 Result should be the back element\n");
    printf("The back element in the array is: %d\n", a1.back().value);
}

void test6(){
        
    printf("TEST 6 Results show true size, maximum size and whether the array is empty\n");
    printf("The maximum size of the array is: %d\n" , a1.max_size().value);
    printf("The size of the array is: %d\n" , a1.size().value);
    printf("Is the array empty?: %d\n" , a1.empty().value);
}

void test7(){
    
    printf("TEST 7 Result will insert an element with the value of 2 in the array\n");
    printf("Value of the elements in the array befor insertion is\n");
    for(int i=0; i< MAX_ARRAY_LEN; i++)
    {
        printf(" %d", a1[i].value);
    }
    printf("\n");
    printf("The value of the elements after insertion of 2 is\n");
    a1.insert(i2x);
    for(int i=0; i< MAX_ARRAY_LEN; i++)
    {
        printf(" %d", a1[i].value);
    }
    *a1[i3x] = i1x;

}
void test8(){
    printf("TEST 8:: Result should be 8\n");
    enc_int sum = i0x;
    int size = a2.size().value;
    for(int i=0; i < size; i++){
        sum.value += a2[i].value.value;
    }
    printf("RESULT: %d\n\n", sum.value);
}


int main()
{
    a1.print_array();
    test1();
    a1.print_array();
    test2();
    a1.print_array();
    test3();
    a1.print_array();
    test4();
    a1.print_array();
    test5();
    a1.print_array();
    test6();
    a1.print_array();
    test7();
    a1.print_array();
    test6();
    a2.print_array();
    test8();
    return 0;
}

