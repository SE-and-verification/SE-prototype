#include "Test.h"
#include <stdio.h>
#include <string>

int main(){

    string fileName ("test.out");
    Test t(4,fileName);
    t.start();

    return 0;
}

