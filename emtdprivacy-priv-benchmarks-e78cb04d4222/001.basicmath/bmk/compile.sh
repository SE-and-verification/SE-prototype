#!/bin/bash

PRIV_LIB_DIR=~/Privacy/functional-library
PARAMS_CPP=~/Privacy/functional-library/src/interface/parameters.cpp 

g++ -g -O2 -std=c++11 -o basicmath-enc $PARAMS_CPP basicmath-enc.cpp
objdump -dS basicmath-enc > basicmath-enc.dump

g++ -g -O2 -std=c++11 -o basicmath-enc-do $PARAMS_CPP basicmath-enc-do.cpp
objdump -dS basicmath-enc-do > basicmath-enc-do.dump

g++ -g -O2 -std=c++11 -o basicmath-native basicmath-native.cpp
objdump -dS basicmath-native > basicmath-native.dump


