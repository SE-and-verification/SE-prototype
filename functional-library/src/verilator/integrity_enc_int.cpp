#include "integrity_enc_int.h"
#include <cstdlib>
#include <ctime>
#include "Instruction.h"
#include "crc.h"

using namespace std;
// #include "../interface/interface.h"
integrity_enc_int::integrity_enc_int(){
		ciphertext.upper = 0;
		ciphertext.lower = 0;
		plaintext.upper = 0;
		plaintext.lower = 0;
}
integrity_enc_int::integrity_enc_int(uint64_t secret, uint64_t salt, uint64_t dataflow_hash, uint64_t version){
		plaintext.upper = secret << 64 | salt;
		plaintext.lower = dataflow_hash << 64 | version;
		swizzle_n_encrypt();
}

void integrity_enc_int::swizzle_n_encrypt(){
		uint64_t upper_odd_bits = 0,  
						upper_even_bits = 0, 
						lower_odd_bits =  0, 
						lower_even_bits = 0;
		
		for (int i = 0; i < 64; i++){
			upper_odd_bits |= ((plaintext.upper >> (2*i+1)) & 1) << i;
			upper_even_bits |= ((plaintext.upper >> (2*i)) & 1) << i;
			lower_odd_bits |= ((plaintext.lower >> (2*i + 1)) & 1) << i;
			lower_even_bits |= ((plaintext.lower >> (2*i)) & 1) << i;
		}

	uint64_t upper_left = upper_odd_bits ^ lower_odd_bits;
	uint64_t lower_right = upper_even_bits ^ lower_even_bits;
	uint64_t upper_right = lower_right ^ lower_odd_bits;
	uint64_t lower_left = upper_left ^ upper_even_bits;

	ciphertext.upper = aes128_encrypt_128(bit128_t(upper_left, upper_right)).convert_to_128();
	ciphertext.lower = aes128_encrypt_128(bit128_t(lower_left, lower_right)).convert_to_128();
}

void integrity_enc_int::decrypt_and_unswizzle(){
	plaintext.upper = aes128_decrypt_128(ciphertext.upper).convert_to_128();
	plaintext.lower = aes128_decrypt_128(ciphertext.lower).convert_to_128();

	uint64_t upper_left = static_cast<uint64_t>(plaintext.upper >> 64);
	uint64_t upper_right = static_cast<uint64_t>(plaintext.upper);
	uint64_t lower_left = static_cast<uint64_t>(plaintext.lower >> 64);
	uint64_t lower_right = static_cast<uint64_t>(plaintext.lower);

	uint64_t upper_even_bits = upper_left ^ lower_left;
	uint64_t lower_even_bits = upper_right ^ lower_right;
	uint64_t upper_odd_bits = upper_right ^ lower_even_bits;
	uint64_t lower_odd_bits = lower_right ^ upper_even_bits;

	upper_left = 0, upper_right = 0, lower_left = 0,lower_right = 0;
	for (int i = 0; i < 32; i++){
		upper_left |= ((upper_odd_bits >> (32+i)) & 1) << (2* (32+i)+1);
		upper_left |= ((upper_even_bits >>  (32+i)) & 1) << (2* (32+i));
		upper_right |= ((upper_odd_bits >> i) & 1) << (2*i+1);
		upper_right |= ((upper_even_bits >> i) & 1) << (2*i);
		lower_left |= ((lower_odd_bits >> (32+i)) & 1) << (2* (32+i)+1);
		lower_left |= ((lower_even_bits >>  (32+i)) & 1) << (2* (32+i));
		lower_right |= ((lower_odd_bits >> i) & 1) << (2*i+1);
		lower_right |= ((lower_even_bits >> i) & 1) << (2*i);
	}

	plaintext.upper = bit128_t(upper_left, upper_right).convert_to_128();
	plaintext.lower = bit128_t(lower_left, lower_right).convert_to_128();
}

uint64_t integrity_enc_int::getSecret(){
	return static_cast<uint64_t>(plaintext.upper >> 64);
}

uint64_t integrity_enc_int::getSalt(){
	return static_cast<uint64_t>(plaintext.upper);
}

uint64_t integrity_enc_int::getDataflowhash(){
	return static_cast<uint64_t>(plaintext.lower >> 64);
}

uint64_t integrity_enc_int::getVersion(){
	return static_cast<uint64_t>(plaintext.lower);
}

void integrity_enc_int::operator=(const integrity_enc_int& C){
	ciphertext.upper = C.ciphertext.upper;
	ciphertext.lower = C.ciphertext.lower;
	plaintext.upper = C.plaintext.upper;
	plaintext.lower = C.plaintext.lower;
}

bool version_check(uint64_t op1, uint64_t op2){
	if(op1 == 0 || op2 == 0)
		return true;
	else
		return op1 == op2;
}

bool version_compute(uint64_t op1, uint64_t op2){
	if(op1 == 0 || op2 == 0 || op1!=op2)
		return 0;
	else
		return op1;
}

bool version_check_with_cond(uint64_t op1, uint64_t op2, uint64_t cond){
	if (op1 == 0){
		return version_check(op2, cond);
	}else if(op2 ==0){
		return version_check(op1, cond);
	}else if(cond == 0){
		return version_check(op1, op2);
	}else{
		return (op1 == op2) && (op1 == cond);
	}
}
	


integrity_enc_int operator+(integrity_enc_int lhs, 
		integrity_enc_int rhs){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::ADD()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		uint64_t secret = version_check(lhs.getVersion(), rhs.getVersion())? lhs.getSecret() + rhs.getSecret(): 0;
		uint64_t version = version_compute(lhs.getVersion(), rhs.getVersion());
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
	}

integrity_enc_int operator-(integrity_enc_int lhs, 
		integrity_enc_int rhs){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::SUB()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		uint64_t secret = version_check(lhs.getVersion(), rhs.getVersion())? lhs.getSecret() - rhs.getSecret(): 0;
		uint64_t version = version_compute(lhs.getVersion(), rhs.getVersion());
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
}

integrity_enc_int operator*(integrity_enc_int lhs, 
	integrity_enc_int rhs){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::MULT()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		uint64_t secret = version_check(lhs.getVersion(), rhs.getVersion())? lhs.getSecret() * rhs.getSecret(): 0;
		uint64_t version = version_compute(lhs.getVersion(), rhs.getVersion());
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
}

integrity_enc_int CMOV(integrity_enc_int lhs, integrity_enc_int rhs, integrity_enc_int cond){
		uint64_t dataflow = crc(static_cast<uint64_t>(Instruction::CMOV()), lhs.getDataflowhash());
		dataflow = crc(dataflow, rhs.getDataflowhash());
		dataflow = crc(dataflow, cond.getDataflowhash());
		uint64_t secret = version_check_with_cond(lhs.getVersion(), rhs.getVersion(), cond.getVersion())? (cond.getSecret()?lhs.getSecret():rhs.getSecret()): 0;
		uint64_t version = cond.getSecret()?lhs.getVersion(): rhs.getVersion();
		srand(time(NULL));
		uint64_t salt = rand();
		return integrity_enc_int(secret, salt, dataflow, version);
}