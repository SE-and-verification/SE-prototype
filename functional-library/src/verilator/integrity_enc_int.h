#ifndef INTEGRITY_ENC_INT_H
#define INTEGRITY_ENC_INT_H
#include <cstdint>
#include "Instruction.h"



bool version_check(uint64_t op1, uint64_t op2);

bool version_compute(uint64_t op1, uint64_t op2);

bool version_check_with_cond(uint64_t op1, uint64_t op2, uint64_t cond);


struct integrity_data_type{
	__uint128_t upper;
	__uint128_t lower;
};


class integrity_enc_int{

public:
 	integrity_data_type ciphertext;
 	integrity_data_type plaintext;



	void swizzle_n_encrypt();

	void decrypt_and_unswizzle();

	integrity_enc_int(uint64_t secret, uint64_t salt, uint64_t dataflow_hash, uint64_t version);
	integrity_enc_int();
	void operator=(const integrity_enc_int& C);

	uint64_t getSecret();

	uint64_t getSalt();

	uint64_t getDataflowhash();

	uint64_t getVersion();

	friend integrity_enc_int operator+(integrity_enc_int lhs, integrity_enc_int rhs);
	friend integrity_enc_int operator-(integrity_enc_int lhs, integrity_enc_int rhs);
	friend integrity_enc_int operator*(integrity_enc_int lhs, integrity_enc_int rhs);
	friend integrity_enc_int CMOV(integrity_enc_int lhs, integrity_enc_int rhs, integrity_enc_int cond);

};

#endif