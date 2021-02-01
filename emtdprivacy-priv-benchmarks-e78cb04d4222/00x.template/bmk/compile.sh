#!/bin/bash

PRIV_LIB_DIR=~/privacy/encrypted-datatype-library

g++ -g -O2 -std=c++11 -o filename-enc filename-enc.cpp
objdump -dS filename-enc > filename-enc.dump

g++ -g -O2 -std=c++11 -o filename-native filename-native.cpp
objdump -dS filename-native > filename-native.dump

