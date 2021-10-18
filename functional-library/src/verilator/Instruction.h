#include <stdint.h>
#ifndef __SE_INSTRUCTION_H

class Instruction{
	public:
		static uint8_t SLL();
		static uint8_t SRL();
		static uint8_t SRA();
		static uint8_t ADD();
		static uint8_t SUB();
		static uint8_t MULT();
		static uint8_t MULTS();
		static uint8_t XOR();
		static uint8_t OR();
		static uint8_t AND();
		static uint8_t LT();
		static uint8_t LTS();
		static uint8_t CMOV(); 
		static uint8_t ENC();

};
#define __SE_INSTRUCTION_H
#endif