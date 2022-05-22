CXX=g++
CXXFLAGS= -std=c++11 -O0  -I/home/chshibo/Documents/Projects/SE-prototype/functional-library/src/ciphers/aes/tinyCrypt_without_Git/lib/include


all: test_enc_int test_enc_array 

test_enc_int: test_enc_int.o enc_lib.o 
	$(CXX) $(CXXFLAGS) -o test_enc_int test_enc_int.o

test_enc_int.o: test_enc_int.cpp ../src/datatypes/enc_lib.h 
	$(CXX) $(CXXFLAGS) -c test_enc_int.cpp


test_enc_array: test_enc_array.o enc_lib.o elements.o enc_array.o
	$(CXX) $(CXXFLAGS) -o test_enc_array test_enc_array.o

test_enc_array.o: test_enc_array.cpp ../src/datatypes/enc_lib.h ../src/datatypes/elements.h ../src/datatypes/enc_array.h
	$(CXX) $(CXXFLAGS) -c test_enc_array.cpp


test_enc_string: test_enc_string.o enc_lib.o enc_string.o
	$(CXX) $(CXXFLAGS) -o test_enc_string test_enc_string.o

test_enc_string.o: test_enc_string.cpp ../src/datatypes/enc_lib.h ../src/datatypes/enc_string.h
	$(CXX) $(CXXFLAGS) -c test_enc_string.cpp

test_interface: test_interface.o  
	$(CXX) $(CXXFLAGS) -o  test_interface test_interface.o ../src/interface/parameters.cpp ../src/ciphers/aes/tinyCrypt_without_Git/lib/utils.o ../src/ciphers/aes/tinyCrypt_without_Git/lib/aes_encrypt.o ../src/ciphers/aes/tinyCrypt_without_Git/lib/aes_decrypt.o ../src/ciphers/simon/Simon_Speck_Ciphers/C/simon.c

test_interface.o: test_interface.cpp 
	$(CXX) $(CXXFLAGS) -c test_interface.cpp -I../src/ciphers/aes/tinyCrypt_without_Git/lib/include 

test_schemes: test_schemes.o
	$(CXX) $(CXXFLAGS) -o test_schemes test_schemes.o ../src/interface/parameters.cpp ../src/rng/mersenne-twister-1/mersenne-twister.cpp ../src/ciphers/simon/Simon_Speck_Ciphers/C/simon.c ../src/ciphers/aes/tinyCrypt_without_Git/lib/utils.o ../src/ciphers/aes/tinyCrypt_without_Git/lib/aes_encrypt.o ../src/ciphers/aes/tinyCrypt_without_Git/lib/aes_decrypt.o 
	  
test_schemes.o: test_schemes.cpp
	$(CXX) $(CXXFLAGS) -c test_schemes.cpp -I../src/ciphers/aes/tinyCrypt_without_Git/lib/include 



enc_lib.o: ../src/datatypes/enc_lib.h

elements.o: ../src/datatypes/elements.h

enc_array.o: ../src/datatypes/enc_array.h

enc_string.o: ../src/datatypes/enc_string.h

elements.o: ../src/datatypes/elements.h





clean:
	rm -f $(IDIR)/*.o 
	rm -f *.o $(TARGET)
