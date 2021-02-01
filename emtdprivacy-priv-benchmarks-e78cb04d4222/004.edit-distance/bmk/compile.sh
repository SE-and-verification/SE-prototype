#!/bin/bash

PRIV_LIB_DIR=~/Privacy/functional-library
PARAMS_CPP=~/Privacy/functional-library/src/interface/parameters.cpp 
RAND_GEN_CPP= ~/Privacy/functional-library/src/rng/mersenne-twister-1/mersenne-twister.cpp


g++ -g -O2 -std=c++11 -o editdist_enc $PARAMS_CPP $RAND_GEN_CPP editdist_enc.cpp
objdump -dS editdist_enc > editdist_enc.dump

g++ -g -O2 -std=c++11 -o editdist_enc_do $PARAMS_CPP $RAND_GEN_CPP editdist_enc_do.cpp
objdump -dS editdist_enc_do > editdist_enc_do.dump

g++ -g -O2 -std=c++11 -o editdist_native editdist_native.cpp
objdump -dS editdist_native > editdist_native.dump


