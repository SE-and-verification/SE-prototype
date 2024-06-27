VERILATOR_INCLUDE=-I../../../obj_dir -I/usr/share/verilator/include
VERILATOR_SOURCE=/usr/share/verilator/include/verilated.cpp /usr/share/verilator/include/verilated_vcd_c.cpp
VERILATOR_OBJ=../../../obj_dir/*.o
ENC_LIB_INCLUDE=-I../datatypes
PARAMS_CPP=../interface/parameters.cpp
ENC_LIB_OBJECT=../ciphers/aes/tinyCrypt_without_Git/lib/aes_decrypt.o ../ciphers/aes/tinyCrypt_without_Git/lib/aes_encrypt.o ../ciphers/aes/tinyCrypt_without_Git/lib/utils.o ../rng/mersenne-twister-1/mersenne-twister.o 

all: test.cpp  Instruction.o SEVerilator.o
	g++  -g3 $(VERILATOR_INCLUDE) $(ENC_LIB_INCLUDE) $(VERILATOR_SOURCE)  $(ENC_LIB_OBJECT) $(PARAMS_CPP) $^ $(VERILATOR_OBJ) -o test

Instruction.o: Instruction.cpp
	g++ -g3 $(VERILATOR_INCLUDE) -c $<  -o $@

SEVerilator.o: SEVerilator.cpp 
	g++ -g3 $(VERILATOR_INCLUDE) -c $<  -o $@

# util.o: util.cpp
# 	g++ $(VERILATOR_INCLUDE) $(ENC_LIB_INCLUDE)   -c $<  -o $@


.PHONY: clean

clean:
	rm *.o test
