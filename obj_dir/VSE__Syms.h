// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VSE__SYMS_H_
#define _VSE__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "VSE.h"
#include "VSE_InvCipher.h"

// SYMS CLASS
class VSE__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    VSE*                           TOPp;
    VSE_InvCipher                  TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule1;
    VSE_InvCipher                  TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule2;
    VSE_InvCipher                  TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule3;
    
    // CREATORS
    VSE__Syms(VSE* topp, const char* namep);
    ~VSE__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
