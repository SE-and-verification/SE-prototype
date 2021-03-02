#!/bin/bash

PRIV_LIB_DIR=~/privacy/encrypted-datatype-library

g++ -g -O2 -std=c++11 -o pbmsrch-enc pbmsrch-enc.cpp
objdump -dS pbmsrch-enc > pbmsrch-enc.dump

g++ -g -O2 -std=c++11 -o pbmsrch-native pbmsrch-native.cpp
objdump -dS pbmsrch-native > pbmsrch-native.dump

g++ -g -O2 -std=c++11 -o pbmsrch-enc-do pbmsrch-enc-do.cpp
objdump -dS pbmsrch-enc-do > pbmsrch-enc-do.dump

