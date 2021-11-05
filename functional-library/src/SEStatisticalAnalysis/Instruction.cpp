#include <cstdint>
#include "Instruction.h"

uint8_t Instruction::SLL(){
	return 0b00000000;
}
uint8_t Instruction::SRL(){
	return 0b00000100;
}
uint8_t Instruction::SRA(){
	return 0b00001000;
}
uint8_t Instruction::ADD(){
	return 0b00100000;
}
uint8_t Instruction::SUB(){
	return 0b00100100;
}
uint8_t Instruction::MULT(){
	return 0b00101000;
}
uint8_t Instruction::MULTS(){
	return 0b00101001;
}

uint8_t Instruction::XOR(){
	return 0b10000000;
}

uint8_t Instruction::OR(){
	return 0b10000100;
}

uint8_t Instruction::AND(){
	return 0b10001000;
}
uint8_t Instruction::LT(){
	return 0b101000000;
}
uint8_t Instruction::LTS(){
	return 0b01000001;
}

uint8_t Instruction::CMOV(){
	return 0b01100000;
}
uint8_t Instruction::ENC(){
	return 0b10100000;
}