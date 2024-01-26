#include <stdlib.h>
#include <stdint.h>
#include "../../../obj_dir/VSE.h"
#include "verilated.h"
#include "integrity_enc_int.h"
#include <math.h>
#ifndef __SE_H
#define __SE_H
class SE{
	public:
		SE(void);
		static integrity_enc_int SECompute(integrity_enc_int lhs, integrity_enc_int rhs, integrity_enc_int cond,
			uint8_t inst);
		static unsigned int tickcount;
		static unsigned int real_tickcount;
		static VSE *module;
		static void tick();
		static void reset();
		// static void changeKey(unsigned int* key);
};
#endif