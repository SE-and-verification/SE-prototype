#include <stdlib.h>
#include <stdint.h>
#include "../../../obj_dir/VSE.h"
#include "verilated.h"
#include <math.h>
#ifndef __SE_H
#define __SE_H
class SE{
	public:
		SE(void);
		~SE(void);
		static __uint128_t SECompute(__uint128_t op1= 0, __uint128_t op2= 0, __uint128_t cond= 0, 
			uint8_t inst= 0);
		static unsigned int tickcount;
		static unsigned int real_tickcount;
		static VSE *module;
		static void tick();
		static void reset();
		static void changeKey(unsigned int* key);
};
#endif