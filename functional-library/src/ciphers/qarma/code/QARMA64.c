// Zhejiang University ICSR Phantom0308
#include <stdio.h>
#include <stdint.h>
#include "qarma64.h"
#define MAX_LENGTH 64
#define subcells sbox[sbox_use]
#define subcells_inv sbox_inv[sbox_use]


int main() {
	uint64_t plaintext = 0xfb623599da6e8127;
	uint64_t w0 = 0x84be85ce9804e94b;
	uint64_t k0 = 0xec2802d4e0a488e9;
	uint64_t tweak = 0x477d469dec0b8762;
	uint64_t ciphertext;

	printf("QARMA64  Use Sbox %d\nPlaintext = 0x%016llx\nKey = 0x%016llx || 0x%016llx\nTweak = 0x%016llx\n\n", sbox_use, plaintext, w0, k0, tweak);


	ciphertext = qarma64_enc(plaintext, tweak, w0, k0, 5);
	printf("Round 5: \nCiphertext = 0x%016llx  %s\n", ciphertext, (ciphertext == check_box[0]) ? "√" : "×");
	ciphertext = qarma64_dec(ciphertext, tweak, w0, k0, 5);
	printf("Plaintext  = 0x%016llx  %s\n", ciphertext, (ciphertext == plaintext) ? "√" : "×");


	ciphertext = qarma64_enc(plaintext, tweak, w0, k0, 6);
	printf("Round 6: \nCiphertext = 0x%016llx  %s\n", ciphertext, (ciphertext == check_box[1]) ? "√" : "×");
	ciphertext = qarma64_dec(ciphertext, tweak, w0, k0, 6);
	printf("Plaintext  = 0x%016llx  %s\n", ciphertext, (ciphertext == plaintext) ? "√" : "×");


	ciphertext = qarma64_enc(plaintext, tweak, w0, k0, 7);
	printf("Round 7: \nCiphertext = 0x%016llx  %s\n", ciphertext, (ciphertext == check_box[2]) ? "√" : "×");
	ciphertext = qarma64_dec(ciphertext, tweak, w0, k0, 7);
	printf("Plaintext  = 0x%016llx  %s\n", ciphertext, (ciphertext == plaintext) ? "√" : "×");

}


