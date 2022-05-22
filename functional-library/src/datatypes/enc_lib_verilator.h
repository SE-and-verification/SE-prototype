#ifndef ENC_LIB_VERI_H
#define ENC_LIB_VERI_H

#include <stdint.h>
#include <iostream>
#include <math.h>
#include "SEVerilator.h"
#include "VSE.h"
#include "verilated.h"
#include "Instruction.h"
#include "enc_lib.h"
namespace enc_lib
{


// Primitive C++ Data Types  
/************************************************************************************
/*  · Boolean
        Keyword: bool
        A logical value representing true or false. 

/*  · Character
        Keyword: char
        Character values in the range [-128, 127] or [0, 255]. Represented by 1 byte
        of memory on an unaltered machine. 

/*  · Integer
        Keyword: int
        Integer values in the range [-2,147,483,648 : 2,147,483,647]. Represented by 
        4 bytes of memory on an unaltered machine.

/*  · Floating Point
        Keyword: float
        Single precision floating point values or decimal values. Represented by 
        4 bytes of memory on an unaltered machine.

/*  · Double Floating Point
        Keyword: double
        Double precision floating point values or decimal values. Represented by
        8 bytes of memory on an unaltered machine.

/*  · Valueless or Void: NOT SUPPORTED 
        Keyword: void
        A valueless entity.

/*  - Wide Character: NOT SUPPORTED 
        Keyword: wchar_t
        A character data type that is larger in size. Represented by 2 or 4 bytes
        on an unaltered machine. 
/************************************************************************************/



// ENCRYPTED Primitive C++ Data Types  
/************************************************************************************/

/*****************************************************************************/
/*  · Encrypted Boolean
        Keyword: enc_bool
        An 8 byte (64-bit) ciphertext containing: 
        A 1 byte boolean value followed by 7 bytes (56 bits) of random salt
*/
    typedef struct enc_bool{
       /*******************************/
        bit128_t ciphertext; // 1B bool, 7B padding = 8B (64-bit value)
                             // 1B bool, 15B padding = 16B (128-bit value)
       /*******************************/
       /*** Constructors & Equality ***/
        enc_bool()                {value = 0; ciphertext = encrypt_64_128((&value)); }
        enc_bool(bool value_in)      {value = value_in; ciphertext = encrypt_64_128((&value)); }
        enc_bool(uint64_t value_in)   {value = value_in; ciphertext = encrypt_64_128((&value)); }
        enc_bool(bit128_t value_in)   { ciphertext = value_in; value = decrypt_128_64(value_in);}
        enc_bool(bit128_t value)   { ciphertext = value; }
        inline enc_bool operator= (int i1) __attribute__((always_inline)) { value = i1; ciphertext = encrypt_64_128(&value); return *this; } 

        private: 
        uint64_t decrypt_bool(){
                // More complex decryption function that implements pointer casts rather than static casts 
                uint64_t value = decrypt_128_64(this->ciphertext);
                return value;
        }
        public:
        uint64_t value = false;
       /****************************/
       /*** One-Input Operations ***/
        inline friend enc_bool operator! (enc_bool b1) __attribute__((always_inline)) { return SE::SECompute(b1.ciphertext, 0, 0, Instruction::NEG()); }        

       /****************************/
       /*** Two-Input Operations ***/
        // // Logic, Enc-Enc Op          
        inline friend enc_bool operator&& (enc_bool b1, enc_bool b2) __attribute__((always_inline)) {return SE::SECompute(b1.ciphertext, b2.ciphertext, 0, Instruction::ADD()); }
        inline friend enc_bool operator|| (enc_bool b1, enc_bool b2) __attribute__((always_inline)) {return SE::SECompute(b1.ciphertext, b2.ciphertext, 0, Instruction::OR());  }
        // // Logic, Enc-Plaintext Op
        // // Logic, Plaintext-Enc Op

       /**************/
       /*** Other ***/
        bool GET_DECRYPTED_VALUE(){ //std::cerr << "ENC_BOOL: EXTERNAL CALL TO UNSAFE DECRYPT FUNCTION\n";
         return this->decrypt_bool(); }
        inline friend enc_bool   CMOV(enc_bool cond, enc_bool v_true, enc_bool v_false) __attribute__((always_inline)) {
          return SE::SECompute(v_true.ciphertext, v_false.ciphertext, cond.ciphertext, Instruction::CMOV());
        }
        inline friend enc_bool   CMOV(enc_bool cond, bool v_true, enc_bool v_false) __attribute__((always_inline)) {
	        bit128_t v_true_128 = v_true? 1<<63:0;		
          return SE::SECompute(v_true_128, v_false.ciphertext, cond.ciphertext, Instruction::CMOV(), false);
        }
    } enc_bool;
/*****************************************************************************/





/*****************************************************************************/
/*  · Encrypted Integer
        Keyword: enc_int
        A 16 byte (128-bit) ciphertext containing: 
        An 8 byte signed integer value (double the size of regular integers) followed 
        by 8 bytes (64 bits) of random salt
*/
    typedef struct enc_int{
       /*******************************/
        bit128_t ciphertext; 
       /*******************************/
       /*** Constructors & Equality ***/
        enc_int()                 { int value = 0; ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_int(int64_t value_in)    { value = value_in; ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_int(bit128_t value)   { ciphertext = value; }
        inline enc_int operator= (int64_t i1) __attribute__((always_inline)) { ciphertext = encrypt_64_128(((uint64_t*) &i1)); return *this; } //trying fix for pointer cast
        private: 
        int decrypt_int(){
                // More complex decryption function that implements pointer casts rather than static casts 
                uint64_t value = decrypt_128_64(this->ciphertext);
                return *((int*) &value);
        }
        public:
       /*****************************/
       /*** Zero-Input Operations ***/
        int64_t value = 0;
        inline enc_int operator++() __attribute__((always_inline))  { 
                this->ciphertext = SE::SECompute(1,this->ciphertext, 0, Instruction::ADD,false);
                return *this; 
        }
        inline enc_int operator++(int) __attribute__((always_inline))  { 
                enc_int temp;
		temp->ciphertext = this->ciphertext;
                this->ciphertext = SE::SECompute(1,this->ciphertext, 0, Instruction::ADD,false);
                return temp; 
        } 
       /****************************/
       /*** One-Input Operations ***/
        inline enc_int operator+=(const int& rhs) __attribute__((always_inline))  
				{ this->ciphertext = SE::SECompute(this->ciphertext, (bit128_t)rhs<<63, 0, Instruction::ADD(), true,false ); return *this }
        inline enc_int operator-=(const int& rhs) __attribute__((always_inline))  
				{ this->ciphertext = SE::SECompute(this->ciphertext, (bit128_t)rhs<<63, 0, Instruction::SUB(), true,false ); return *this }
       /****************************/
       /*** Two-Input Operations ***/
        // Arithmetic, Enc-Enc Op
        inline friend enc_int       operator+   (enc_int lhs, enc_int rhs)       __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::ADD())); }
        inline friend enc_int       operator-   (enc_int lhs, enc_int rhs)       __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SUB())); }
        inline friend enc_int       operator*   (enc_int lhs, enc_int rhs)       __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::MULT())); }   
        inline friend enc_int       operator/   (enc_int lhs, enc_int rhs)       __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::DIV())); }
        // Arithmetic, Enc-Plaintext Op
        inline friend enc_int       operator+   (enc_int lhs, int rhs)           __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, (bit128_t)rhs<<63, 0, Instruction::ADD(), true, false)); }
        inline friend enc_int       operator-   (enc_int lhs, int rhs)           __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, (bit128_t)rhs<<63, 0, Instruction::SUB(), true, false)); }
        inline friend enc_int       operator*   (enc_int lhs, int rhs)           __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::MULT(), true, false )); }
        inline friend enc_int       operator/   (enc_int lhs, int rhs)           __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::DIV(), true, false ));}
        // // Arithmetic, Plaintext-Enc Op
        inline friend enc_int      operator+   (int lhs, enc_int rhs)            __attribute__((always_inline))  { return enc_int(SE::SECompute((bit128_t)lhs<<63, rhs.ciphertext, 0, Instruction::ADD(), false, true)); }
        inline friend enc_int      operator-   (int lhs, enc_int rhs)            __attribute__((always_inline))  { return enc_int(SE::SECompute((bit128_t)lhs<<63, rhs.ciphertext, 0, Instruction::SUB(), false, true)); }
        inline friend enc_int      operator*   (int lhs, enc_int rhs)            __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::MULT(), false)); }
        inline friend enc_int      operator/   (int lhs, enc_int rhs)            __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::DIV(), false));  }
        // // Logic, Enc-Enc Op          
        inline friend enc_bool     operator==  (enc_int lhs, enc_int rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::EQ()));   }
        inline friend enc_bool     operator!=  (enc_int lhs, enc_int rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::NEQ()));   }
        inline friend enc_bool     operator<   (enc_int lhs, enc_int rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SLT())); }
        inline friend enc_bool     operator<=  (enc_int lhs, enc_int rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SLE()));  }
        inline friend enc_bool     operator>   (enc_int lhs, enc_int rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SGT()));     }
        inline friend enc_bool     operator>=  (enc_int lhs, enc_int rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SGE()));  }
        // // Logic, Enc-Plaintext Op
        inline friend enc_bool     operator==  (enc_int lhs, int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::EQ(), true, false));      }
        inline friend enc_bool     operator!=  (enc_int lhs, int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::NEQ(), true, false));   }
        inline friend enc_bool     operator<   (enc_int lhs, int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SLT(), true, false));     }
        inline friend enc_bool     operator<=  (enc_int lhs, int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SLE(), true, false));    }
        inline friend enc_bool     operator>   (enc_int lhs, int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SGT(), true, false));      }
        inline friend enc_bool     operator>=  (enc_int lhs, int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SGE(), true, false));    }
        // // Logic, Plaintext-Enc Op
        inline friend enc_bool     operator==  (int lhs, enc_int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::EQ(), false));     }
        inline friend enc_bool     operator!=  (int lhs, enc_int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::NEQ(), false));   }
        inline friend enc_bool     operator<   (int lhs, enc_int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SLT(), false));     }
        inline friend enc_bool     operator<=  (int lhs, enc_int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SLE(), false));    }
        inline friend enc_bool     operator>   (int lhs, enc_int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SGT(), false));       }
        inline friend enc_bool     operator>=  (int lhs, enc_int rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SGE(), false));   }
       /*************/
       /*** Math ***/
        // inline friend enc_int      sqrt   (enc_int x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_int(sqrt(x.decrypt_int())); }   //TODO Should implement d.o. sqrt function
        // inline friend enc_int      pow    (enc_int x, int y)                     __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_int(pow(x.decrypt_int(), y)); } //TODO Should implement d.o. pow function
        // inline friend enc_int      acos   (enc_int x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_int(acos(x.decrypt_int())); }   //TODO Should implement d.o. acos function
        // inline friend enc_int      cos    (enc_int x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_int(cos(x.decrypt_int())); }    //TODO Should implement d.o. cos function
        // inline friend enc_int      fabs   (enc_int x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_int(fabs(x.decrypt_int())); }   //TODO Should implement d.o. fabs function
       /**************/
       /*** Other ***/
        int GET_DECRYPTED_VALUE(){ //std::cerr << "ENC_INT: EXTERNAL CALL TO UNSAFE DECRYPT FUNCTION\n";
         return this->decrypt_int(); }


        inline friend enc_int       CMOV(enc_bool cond, enc_int v_true, enc_int v_false) __attribute__((always_inline)) {
           return enc_int(SE::SECompute(v_true.ciphertext, v_false.ciphertext, cond.ciphertext, Instruction::CMOV())); 
        }
        inline friend enc_int       CMOV(enc_bool cond, int v_true, enc_int v_false) __attribute__((always_inline)) {
           return enc_int(SE::SECompute(v_true, v_false.ciphertext, cond.ciphertext, Instruction::CMOV(), false)); 
        }      
    } enc_int;
/*****************************************************************************/




/*****************************************************************************/
/*  · Encrypted Character
        Keyword: enc_char
        An 8 byte (64-bit) ciphertext containing: 
        A 1 byte char value followed by 7 bytes (56 bits) of random salt
*/
    typedef struct enc_char{
       /*******************************/
        bit128_t ciphertext; 
       /*******************************/
       /*** Constructors & Equality ***/
        enc_char()                 { char value = 0; ciphertext = encrypt_8_128(((uint8_t*) &value)); }
        enc_char(char value_in)    { value = value_in; ciphertext = encrypt_8_128(((uint8_t*) &value)); }
        enc_char(bit128_t value)   { ciphertext = value; }
        inline enc_char operator= (int i1) __attribute__((always_inline)) { ciphertext = encrypt_8_128(((uint8_t*) &i1)); return *this; } 

        private: 
        char decrypt_char(){
                // More complex decryption function that implements pointer casts rather than static casts 
                uint8_t value = decrypt_128_8(this->ciphertext);
                return *((char*) &value);
        }
        public:
        char value = 0;
        // Arithmetic
        inline friend enc_int       operator+   (enc_char lhs, enc_char rhs)       __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::ADD())); }
        inline friend enc_int       operator-   (enc_char lhs, enc_char rhs)       __attribute__((always_inline))  { return enc_int(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SUB())); }
        
        // Logical Operators
        inline friend enc_bool     operator==  (enc_char& lhs, enc_char& rhs) __attribute__((always_inline)) {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::EQ())); }
        inline friend enc_bool     operator!=  (enc_char& lhs, enc_char& rhs) __attribute__((always_inline)) {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::NEQ())); }
        inline friend enc_bool     operator<   (enc_char& lhs, enc_char& rhs) __attribute__((always_inline)) {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SLTU())); }
        inline friend enc_bool     operator<=  (enc_char& lhs, enc_char& rhs) __attribute__((always_inline)) {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SLEU())); }
        inline friend enc_bool     operator>   (enc_char& lhs, enc_char& rhs) __attribute__((always_inline)) {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SGTU())); }
        inline friend enc_bool     operator>=  (enc_char& lhs, enc_char& rhs) __attribute__((always_inline)) {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SGTE())); }

        inline friend enc_bool   operator==  (enc_char lhs, char rhs)       __attribute__((always_inline)) {return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::EQ(), true, false)); }

        /**************/
       /*** Other ***/
        char GET_DECRYPTED_VALUE(){ 
                //std::cerr << "EXTERNAL CALL TO UNSAFE DECRYPT FUNCTION\n"; 
                return this->decrypt_char(); }
        inline friend enc_char   CMOV(enc_bool cond, enc_char v_true, enc_char v_false) __attribute__((always_inline)) {
           return enc_char(SE::SECompute(v_true.ciphertext, v_false.ciphertext, cond.ciphertext, Instruction::CMOV())); 
        }
        inline friend enc_char   CMOV(enc_bool cond, enc_char v_true, char v_false) __attribute__((always_inline)) {
           return enc_char(SE::SECompute(v_true.ciphertext, v_false, cond.ciphertext, Instruction::CMOV(), true, false)); 
        }
        inline friend enc_char   CMOV(enc_bool cond, char v_true, enc_char v_false) __attribute__((always_inline)) {
           return enc_char(SE::SECompute(v_true, v_false.ciphertext, cond.ciphertext, Instruction::CMOV(), false)); 
        }
        // inline friend enc_char*   CMOV(enc_bool cond, enc_char* v_true, enc_char* v_false) __attribute__((always_inline)) {
        //         log("WARNING:: USE OF UNVERIFIED FUNCTION\n");
        //         enc_char* result;
        //         __asm__ __volatile__ (
        //             "test   %1, %1;"
        //             "cmovz  %3, %0;" 
        //             "cmovnz %2, %0;" 
        //             : "=r" (result)
        //             : "r" (cond.GET_DECRYPTED_VALUE()), "r" (v_true), "r" (v_false)
        //             : "cc"
        //         );
        //         return result;
        // }        
    } enc_char;
/*****************************************************************************/



/*****************************************************************************/
/*  · Encrypted Unsigned Integer
        Keyword: enc_uint
        A 16 byte (128-bit) ciphertext containing: 
        An 8 byte unsigned integer value (double the size of regular integers) followed 
        by 8 bytes (64 bits) of random salt
*/    
    typedef struct enc_uint{
       /*******************************/
        bit128_t ciphertext; 
       /*******************************/
       /*** Constructors & Equality ***/
        enc_uint()                    { uint64_t value = 0; ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_uint(uint64_t value_in)    { value = value_in; ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_uint(bit128_t value)   { ciphertext = value; }
        inline enc_uint operator= (uint64_t i1) __attribute__((always_inline)) { ciphertext = encrypt_64_128(((uint64_t*) &i1)); return *this; } //trying fix for pointer cast
        private: 
        uint64_t decrypt_uint(){
                // More complex decryption function that implements pointer casts rather than static casts 
                // (A static cast from uint to uint64_t drops decimal values, producing an incorrect result)
                uint64_t value = decrypt_128_64(this->ciphertext);
                return *((uint*) &value);
        }
        public:
       /*****************************/
       /*** Zero-Input Operations ***/
        uint64_t value = 0;
        inline enc_uint operator++() __attribute__((always_inline))  { 
                this->ciphertext = SE::SECompute(1,this->ciphertext, 0, Instruction::ADD,false);
                return *this; 
        }
        inline enc_uint operator++(int) __attribute__((always_inline))  { 
                enc_uint temp;
		temp->ciphertext = this->ciphertext;
                this->ciphertext = SE::SECompute(1,this->ciphertext, 0, Instruction::ADD,false);
                return temp; 
        } 
       /****************************/
       /*** One-Input Operations ***/
        inline enc_uint operator+=(const uint64_t& rhs) __attribute__((always_inline))  
				{ this->ciphertext = SE::SECompute(this->ciphertext, (bit128_t)rhs<<63, 0, Instruction::ADD(), true,false ); return *this }
        inline enc_uint operator-=(const uint64_t& rhs) __attribute__((always_inline))  
				{ this->ciphertext = SE::SECompute(this->ciphertext, (bit128_t)rhs<<63, 0, Instruction::SUB(), true,false ); return *this }
       /****************************/
       /*** Two-Input Operations ***/
        // Arithmetic, Enc-Enc Op
        inline friend enc_uint       operator+   (enc_uint lhs, enc_uint rhs)       __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::ADD())); }
        inline friend enc_uint       operator-   (enc_uint lhs, enc_uint rhs)       __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SUB())); }
        inline friend enc_uint       operator*   (enc_uint lhs, enc_uint rhs)       __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::MULT()); }   
        inline friend enc_uint       operator/   (enc_uint lhs, enc_uint rhs)       __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::DIV()); }
        // Arithmetic, Enc-Plaintext Op
        inline friend enc_uint       operator+   (enc_uint lhs, uint64_t rhs)           __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, (bit128_t)rhs<<63, 0, Instruction::ADD(), true, false)); }
        inline friend enc_uint       operator-   (enc_uint lhs, uint64_t rhs)           __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, (bit128_t)rhs<<63, 0, Instruction::SUB(), true, false)); }
        inline friend enc_uint       operator*   (enc_uint lhs, uint64_t rhs)           __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::MULT(), true, false )); }
        inline friend enc_uint       operator/   (enc_uint lhs, uint64_t rhs)           __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::DIV(), true, false ));}
        // // Arithmetic, Plaintext-Enc Op
        inline friend enc_uint      operator+   (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  { return enc_uint(SE::SECompute((bit128_t)lhs<<63, rhs.ciphertext, 0, Instruction::ADD(), false, true)); }
        inline friend enc_uint      operator-   (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  { return enc_uint(SE::SECompute((bit128_t)lhs<<63, rhs.ciphertext, 0, Instruction::SUB(), false, true)); }
        inline friend enc_uint      operator*   (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::MULT(), false)); }
        inline friend enc_uint      operator/   (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  { return enc_uint(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::DIV(), false));  }
        // // Logic, Enc-Enc Op          
        inline friend enc_bool     operator==  (enc_uint lhs, enc_uint rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::EQ()));   }
        inline friend enc_bool     operator!=  (enc_uint lhs, enc_uint rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::NEQ()));   }
        inline friend enc_bool     operator<   (enc_uint lhs, enc_uint rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SLTU())); }
        inline friend enc_bool     operator<=  (enc_uint lhs, enc_uint rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SLEU()));  }
        inline friend enc_bool     operator>   (enc_uint lhs, enc_uint rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SGTU()));     }
        inline friend enc_bool     operator>=  (enc_uint lhs, enc_uint rhs)        __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs.ciphertext, 0, Instruction::SGEU()));  }
        // // Logic, Enc-Plaintext Op
        inline friend enc_bool     operator==  (enc_uint lhs, uint64_t rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::EQ(), true, false));      }
        inline friend enc_bool     operator!=  (enc_uint lhs, uint64_t rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::NEQ(), true, false));   }
        inline friend enc_bool     operator<   (enc_uint lhs, uint64_t rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SLTU(), true, false));     }
        inline friend enc_bool     operator<=  (enc_uint lhs, uint64_t rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SLEU(), true, false));    }
        inline friend enc_bool     operator>   (enc_uint lhs, uint64_t rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SGTU(), true, false));      }
        inline friend enc_bool     operator>=  (enc_uint lhs, uint64_t rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs.ciphertext, rhs, 0, Instruction::SGEU(), true, false));    }
        // // Logic, Plaintext-Enc Op
        inline friend enc_bool     operator==  (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::EQ(), false));     }
        inline friend enc_bool     operator!=  (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::NEQ(), false));   }
        inline friend enc_bool     operator<   (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SLTU(), false));     }
        inline friend enc_bool     operator<=  (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SLEU(), false));    }
        inline friend enc_bool     operator>   (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SGTU(), false));       }
        inline friend enc_bool     operator>=  (uint64_t lhs, enc_uint rhs)            __attribute__((always_inline))  {  return enc_bool(SE::SECompute(lhs, rhs.ciphertext, 0, Instruction::SGEU(), false));   }
       /*************/
       /*** Other ***/
        uint GET_DECRYPTED_VALUE(){ //std::cerr << "EXTERNAL CALL TO UNSAFE DECRYPT FUNCTION\n"; 
        return this->decrypt_uint(); }
    } enc_uint;
/*****************************************************************************/




/*****************************************************************************/
/*  · Encrypted Floating Point
        Keyword: enc_float
        A 16 byte (128-bit) ciphertext containing: 
        A 4 byte floating point value followed by 12 bytes (96 bits) of random salt
*/
    typedef struct enc_float{
       /*******************************/
        bit128_t ciphertext; 
       /*******************************/
       /*** Constructors & Equality ***/
        enc_float()                  { float value = 0; ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_float(double value)      { ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_float(bit128_t value)    { ciphertext = value; }
        inline enc_float operator= (float i1) __attribute__((always_inline)) { ciphertext = encrypt_64_128(((uint64_t*) &i1)); return *this; } //trying fix for pointer cast
        private: 
        float decrypt_float(){
                // More complex decryption function that implements pointer casts rather than static casts 
                // (A static cast from float to uint64_t drops decimal values, producing an incorrect result)
                uint64_t value = decrypt_128_64(this->ciphertext);
                return *((float*) &value);
        }
        public:
       /*****************************/
       /*** Zero-Input Operations ***/
        inline enc_float operator++() __attribute__((always_inline))  { 
                float value = this->decrypt_float();
                enc_float temp(++value); // Pre-Increment
                this->ciphertext = encrypt_64_128((uint64_t*) &value);
                return temp; 
        }
        inline enc_float operator++(int) __attribute__((always_inline))  { 
                float value = this->decrypt_float();
                enc_float temp(value++); // Post-Increment
                this->ciphertext = encrypt_64_128((uint64_t*) &value);
                return temp; 
        } 
       /****************************/
       /*** One-Input Operations ***/
        inline enc_float operator+=(const float& rhs) __attribute__((always_inline))  { float temp = this->decrypt_float() + rhs; this->ciphertext = encrypt_64_128((uint64_t*) &temp); return *this; }
        inline enc_float operator-=(const float& rhs) __attribute__((always_inline))  { float temp = this->decrypt_float() - rhs; this->ciphertext = encrypt_64_128((uint64_t*) &temp); return *this; }
       /****************************/
       /*** Two-Input Operations ***/
        // Arithmetic, Enc-Enc Op
        inline friend enc_float   operator+   (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() + rhs.decrypt_float()); }
        inline friend enc_float   operator-   (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() - rhs.decrypt_float()); }
        inline friend enc_float   operator*   (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() * rhs.decrypt_float()); }   
        inline friend enc_float   operator/   (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() / rhs.decrypt_float()); }
        // Arithmetic, Enc-Plaintext Op
        inline friend enc_float   operator+   (enc_float lhs, float rhs)            __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() + rhs); }
        inline friend enc_float   operator-   (enc_float lhs, float rhs)            __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() - rhs); }
        inline friend enc_float   operator*   (enc_float lhs, float rhs)            __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() * rhs); }
        inline friend enc_float   operator/   (enc_float lhs, float rhs)            __attribute__((always_inline))  { return enc_float(lhs.decrypt_float() / rhs); }
        // // Arithmetic, Plaintext-Enc Op
        inline friend enc_float   operator+   (float lhs, enc_float rhs)            __attribute__((always_inline))  { return enc_float(lhs + rhs.decrypt_float()); }
        inline friend enc_float   operator-   (float lhs, enc_float rhs)            __attribute__((always_inline))  { return enc_float(lhs - rhs.decrypt_float()); }
        inline friend enc_float   operator*   (float lhs, enc_float rhs)            __attribute__((always_inline))  { return enc_float(lhs * rhs.decrypt_float()); }
        inline friend enc_float   operator/   (float lhs, enc_float rhs)            __attribute__((always_inline))  { return enc_float(lhs / rhs.decrypt_float()); }
        // // Logic, Enc-Enc Op          
        inline friend enc_bool     operator==  (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_float()) == (rhs.decrypt_float())));   }
        inline friend enc_bool     operator!=  (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_float()) != (rhs.decrypt_float())));   }
        inline friend enc_bool     operator<   (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_float()) < (rhs.decrypt_float())));   }
        inline friend enc_bool     operator<=  (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_float()) > (rhs.decrypt_float())));  }
        inline friend enc_bool     operator>   (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  {  return enc_bool((rhs.decrypt_float()) < (lhs.decrypt_float()));     }
        inline friend enc_bool     operator>=  (enc_float lhs, enc_float rhs)        __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_float()) < (rhs.decrypt_float())));  }
        // // Logic, Enc-Plaintext Op
        inline friend enc_bool     operator==  (enc_float lhs, float rhs)            __attribute__((always_inline))  {  return enc_bool((lhs.decrypt_float()) == rhs);      }
        inline friend enc_bool     operator!=  (enc_float lhs, float rhs)            __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_float()) == rhs));   }
        inline friend enc_bool     operator<   (enc_float lhs, float rhs)            __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_float()) < rhs));     }
        inline friend enc_bool     operator<=  (enc_float lhs, float rhs)            __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_float()) > rhs));    }
        inline friend enc_bool     operator>   (enc_float lhs, float rhs)            __attribute__((always_inline))  {  return enc_bool(rhs < (lhs.decrypt_float()));       }
        inline friend enc_bool     operator>=  (enc_float lhs, float rhs)            __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_float()) < rhs));    }
        // // Logic, Plaintext-Enc Op
        inline friend enc_bool     operator==  (float lhs, enc_float rhs)            __attribute__((always_inline))  {  return enc_bool(lhs == (rhs.decrypt_float()));     }
        inline friend enc_bool     operator!=  (float lhs, enc_float rhs)            __attribute__((always_inline))  {  return enc_bool(!(lhs == (rhs.decrypt_float())));  }
        inline friend enc_bool     operator<   (float lhs, enc_float rhs)            __attribute__((always_inline))  {  return enc_bool((lhs < (rhs.decrypt_float())));    }
        inline friend enc_bool     operator<=  (float lhs, enc_float rhs)            __attribute__((always_inline))  {  return enc_bool(!(lhs > (rhs.decrypt_float())));   }
        inline friend enc_bool     operator>   (float lhs, enc_float rhs)            __attribute__((always_inline))  {  return enc_bool((rhs.decrypt_float()) < lhs);      }
        inline friend enc_bool     operator>=  (float lhs, enc_float rhs)            __attribute__((always_inline))  {  return enc_bool(!(lhs < (rhs.decrypt_float())));   }
       /*************/
       /*** Math ***/
        // inline friend enc_float   sqrt   (enc_float x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_float(sqrt(x.decrypt_float())); }   //TODO Should implement d.o. sqrt function
        // inline friend enc_float   pow    (enc_float x, float y)                   __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_float(pow(x.decrypt_float(), y)); } //TODO Should implement d.o. pow function
        // inline friend enc_float   acos   (enc_float x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_float(acos(x.decrypt_float())); }   //TODO Should implement d.o. acos function
        // inline friend enc_float   cos    (enc_float x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_float(cos(x.decrypt_float())); }    //TODO Should implement d.o. cos function
        // inline friend enc_float   fabs   (enc_float x)                            __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_float(fabs(x.decrypt_float())); }   //TODO Should implement d.o. fabs function
       /**************/
       /*** Other ***/
        float GET_DECRYPTED_VALUE(){ std::cerr << "EXTERNAL CALL TO UNSAFE DECRYPT FUNCTION\n"; return this->decrypt_float(); }
    } enc_float;
/*****************************************************************************/




/*****************************************************************************/
/*  · Encrypted Double
        Keyword: enc_double
        A 16 byte (128-bit) ciphertext containing: 
        An 8 byte double precision floating point (aka "double") value followed by 
        8 bytes (64 bits) of random salt
*/
    typedef struct enc_double{
       /*******************************/
        bit128_t ciphertext; 
       /*******************************/
       /*** Constructors & Equality ***/
        enc_double()                    { double value = 0; ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_double(double value)        { ciphertext = encrypt_64_128(((uint64_t*) &value)); }
        enc_double(bit128_t value)      { ciphertext = value; }
        inline enc_double operator= (double i1) __attribute__((always_inline)) { ciphertext = encrypt_64_128(((uint64_t*) &i1)); return *this; } //trying fix for pointer cast
        private: 
        double decrypt_double(){
                // More complex decryption function that implements pointer casts rather than static casts 
                // (A static cast from double to uint64_t drops decimal values, producing an incorrect result)
                uint64_t value = decrypt_128_64(this->ciphertext);
                return *((double*) &value);
        }
        public:
       /*****************************/
       /*** Zero-Input Operations ***/
        inline enc_double operator++() __attribute__((always_inline))  { 
                double value = this->decrypt_double();
                enc_double temp(++value); // Pre-Increment
                this->ciphertext = encrypt_64_128((uint64_t*) &value);
                return temp; 
        }
        inline enc_double operator++(int) __attribute__((always_inline))  { 
                double value = this->decrypt_double();
                enc_double temp(value++); // Post-Increment
                this->ciphertext = encrypt_64_128((uint64_t*) &value);
                return temp; 
        } 
       /****************************/
       /*** One-Input Operations ***/
        inline enc_double operator+=(const double& rhs) __attribute__((always_inline))  { double temp = this->decrypt_double() + rhs; this->ciphertext = encrypt_64_128((uint64_t*) &temp); return *this; }
        inline enc_double operator-=(const double& rhs) __attribute__((always_inline))  { double temp = this->decrypt_double() - rhs; this->ciphertext = encrypt_64_128((uint64_t*) &temp); return *this; }
       /****************************/
       /*** Two-Input Operations ***/
        // Arithmetic, Enc-Enc Op
        inline friend enc_double   operator+   (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() + rhs.decrypt_double()); }
        inline friend enc_double   operator-   (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() - rhs.decrypt_double()); }
        inline friend enc_double   operator*   (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() * rhs.decrypt_double()); }   
        inline friend enc_double   operator/   (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() / rhs.decrypt_double()); }
        // Arithmetic, Enc-Plaintext Op
        inline friend enc_double   operator+   (enc_double lhs, double rhs)            __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() + rhs); }
        inline friend enc_double   operator-   (enc_double lhs, double rhs)            __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() - rhs); }
        inline friend enc_double   operator*   (enc_double lhs, double rhs)            __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() * rhs); }
        inline friend enc_double   operator/   (enc_double lhs, double rhs)            __attribute__((always_inline))  { return enc_double(lhs.decrypt_double() / rhs); }
        // // Arithmetic, Plaintext-Enc Op
        inline friend enc_double   operator+   (double lhs, enc_double rhs)            __attribute__((always_inline))  { return enc_double(lhs + rhs.decrypt_double()); }
        inline friend enc_double   operator-   (double lhs, enc_double rhs)            __attribute__((always_inline))  { return enc_double(lhs - rhs.decrypt_double()); }
        inline friend enc_double   operator*   (double lhs, enc_double rhs)            __attribute__((always_inline))  { return enc_double(lhs * rhs.decrypt_double()); }
        inline friend enc_double   operator/   (double lhs, enc_double rhs)            __attribute__((always_inline))  { return enc_double(lhs / rhs.decrypt_double()); }
        // // Logic, Enc-Enc Op          
        inline friend enc_bool     operator==  (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_double()) == (rhs.decrypt_double())));   }
        inline friend enc_bool     operator!=  (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_double()) != (rhs.decrypt_double())));   }
        inline friend enc_bool     operator<   (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_double()) < (rhs.decrypt_double())));   }
        inline friend enc_bool     operator<=  (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_double()) > (rhs.decrypt_double())));  }
        inline friend enc_bool     operator>   (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  {  return enc_bool((rhs.decrypt_double()) < (lhs.decrypt_double()));     }
        inline friend enc_bool     operator>=  (enc_double lhs, enc_double rhs)        __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_double()) < (rhs.decrypt_double())));  }
        // // Logic, Enc-Plaintext Op
        inline friend enc_bool     operator==  (enc_double lhs, double rhs)            __attribute__((always_inline))  {  return enc_bool((lhs.decrypt_double()) == rhs);      }
        inline friend enc_bool     operator!=  (enc_double lhs, double rhs)            __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_double()) == rhs));   }
        inline friend enc_bool     operator<   (enc_double lhs, double rhs)            __attribute__((always_inline))  {  return enc_bool(((lhs.decrypt_double()) < rhs));     }
        inline friend enc_bool     operator<=  (enc_double lhs, double rhs)            __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_double()) > rhs));    }
        inline friend enc_bool     operator>   (enc_double lhs, double rhs)            __attribute__((always_inline))  {  return enc_bool(rhs < (lhs.decrypt_double()));       }
        inline friend enc_bool     operator>=  (enc_double lhs, double rhs)            __attribute__((always_inline))  {  return enc_bool(!((lhs.decrypt_double()) < rhs));    }
        // // Logic, Plaintext-Enc Op
        inline friend enc_bool     operator==  (double lhs, enc_double rhs)            __attribute__((always_inline))  {  return enc_bool(lhs == (rhs.decrypt_double()));     }
        inline friend enc_bool     operator!=  (double lhs, enc_double rhs)            __attribute__((always_inline))  {  return enc_bool(!(lhs == (rhs.decrypt_double())));  }
        inline friend enc_bool     operator<   (double lhs, enc_double rhs)            __attribute__((always_inline))  {  return enc_bool((lhs < (rhs.decrypt_double())));    }
        inline friend enc_bool     operator<=  (double lhs, enc_double rhs)            __attribute__((always_inline))  {  return enc_bool(!(lhs > (rhs.decrypt_double())));   }
        inline friend enc_bool     operator>   (double lhs, enc_double rhs)            __attribute__((always_inline))  {  return enc_bool((rhs.decrypt_double()) < lhs);      }
        inline friend enc_bool     operator>=  (double lhs, enc_double rhs)            __attribute__((always_inline))  {  return enc_bool(!(lhs < (rhs.decrypt_double())));   }
       /*************/
       /*** Math ***/
        inline friend enc_double   sqrt   (enc_double x)                               __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_double(sqrt(x.decrypt_double())); }   //TODO Should implement d.o. sqrt function
        inline friend enc_double   pow    (enc_double x, double y)                     __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_double(pow(x.decrypt_double(), y)); } //TODO Should implement d.o. pow function
        inline friend enc_double   acos   (enc_double x)                               __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_double(acos(x.decrypt_double())); }   //TODO Should implement d.o. acos function
        inline friend enc_double   cos    (enc_double x)                               __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_double(cos(x.decrypt_double())); }    //TODO Should implement d.o. cos function
        inline friend enc_double   fabs   (enc_double x)                               __attribute__((always_inline)) {std::cerr << "EXTERNAL CALL TO UNSAFE MATH FUNCTION\n"; return enc_double(fabs(x.decrypt_double())); }   //TODO Should implement d.o. fabs function
       /**************/
       /*** Other ***/
        double GET_DECRYPTED_VALUE(){ std::cerr << "EXTERNAL CALL TO UNSAFE DECRYPT FUNCTION\n"; return this->decrypt_double(); }
    } enc_double;
/*****************************************************************************/
/************************************************************************************/






// Derived C++ Data Types
/************************************************************************************/  
/*  · Array
        An ordered collection of items stored at adjacent memory locations. 
        All array elements have the same data type. Array elements are accessed
        by their index, however C/C++ does not support out of bounds checking.

/*  + String: NEW!

/*  - Function: NOT SUPPORTED
        A block of code that performs some specific task. 

/*  - Pointer: NOT SUPPORTED 
        A symbolic representation of memory addresses that enables programs to
        simulate call-by-reference and manipulate dynamic data structures. 

/*  - Reference: NOT SUPPORTED 
        An alternative name for an existing variable. A variable is is declared
        as a reference by putting '&' in the declaration.       
/************************************************************************************/


// User-Defined C++ Data Types  
/************************************************************************************/
/*  - Class: NOT SUPPORTED
        A user-defined data type that holds its own data members and member functions,
        which are accessed and used via creating an instance of the class.
        (Note: You could make a class with encrypted data members)

/*  - Structure: NOT SUPPORTED
        A structure is used to group items of possibly different types into a single type.
        (Note: You could make a struct with encrypted items)

/*  - Union: NOT SUPPORTED
        A structure where all members share the same memory location.

/*  · Enumeration: 
        A user-defined data type in C that assigns names to integral constants, making 
        program easier to read and maintain.
/************************************************************************************/



}
#endif
