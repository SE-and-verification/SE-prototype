// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "VSE__Syms.h"
#include "VSE.h"
#include "VSE_InvCipher.h"



// FUNCTIONS
VSE__Syms::VSE__Syms(VSE* topp, const char* namep)
    // Setup locals
    : __Vm_namep(namep)
    , __Vm_didInit(false)
    // Setup submodule names
    , TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule1(Verilated::catName(topp->name(), "SE.aes_invcipher.InvCipherModule1"))
    , TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule2(Verilated::catName(topp->name(), "SE.aes_invcipher.InvCipherModule2"))
    , TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule3(Verilated::catName(topp->name(), "SE.aes_invcipher.InvCipherModule3"))
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    TOPp->__PVT__SE__DOT__aes_invcipher__DOT__InvCipherModule1 = &TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule1;
    TOPp->__PVT__SE__DOT__aes_invcipher__DOT__InvCipherModule2 = &TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule2;
    TOPp->__PVT__SE__DOT__aes_invcipher__DOT__InvCipherModule3 = &TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule3;
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
    TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule1.__Vconfigure(this, true);
    TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule2.__Vconfigure(this, false);
    TOP__SE__DOT__aes_invcipher__DOT__InvCipherModule3.__Vconfigure(this, false);
}
