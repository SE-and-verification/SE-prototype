#include "Test.h"
#include <stdio.h>
#include <string>

int main(){

    string fileName ("test.out");
    Test t(200,fileName);
    t.start();

    return 0;
}

