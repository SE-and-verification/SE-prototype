#include <stdlib.h>
#include <stdint.h>
#include "../../../obj_dir/VSE.h"
#include "verilated.h"
#include <math.h>
#include <vector>
#include "../interface/bit_t.h"
#ifndef __SE_H
#define __SE_H
class SE{
	public:
		SE(void);
		static bit316_t SECompute(bit316_t op1, bit316_t op2, __uint128_t cond = 0, uint8_t inst = 0);
		static unsigned int tickcount;
		static unsigned int real_tickcount;
		static VSE* module;
		static void tick();
		static void reset();
		// static void changeKey(unsigned int* key);
};
#endif
