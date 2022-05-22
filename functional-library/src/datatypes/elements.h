#ifndef ELEMENTS_H
#define ELEMENTS_H

#include "enc_lib.h"

// Array elements: Class to implement the elements of the array 

    /*  · Elements of an array
        Keyword: elements
        Specifies the structure of an element within an array which consists of a value_type and a boolean to know if the value is set or not set
    */

namespace enc_lib{

    template <typename _Tp> 
    class elements
    {

        typedef _Tp                     value_type;
        typedef _Tp*                    pointer;
        typedef const _Tp*              const_pointer;
        typedef value_type&             reference;
        typedef const value_type&       const_reference;
        typedef value_type*             iterator;
        typedef const value_type*       const_iterator;

    public:
        value_type value;          
        enc_bool set;    

        elements(): set({false, 0}){}
        elements(value_type x): value(x), set({true, 0}){
        }

        inline enc_bool isSet(){
            return set;
        }
    
    //Operator overloading
    elements operator= (value_type i1) { value = i1; set = {true, 0}; return *this;}

    // Logical Operator
    friend bool     operator==  (const elements<value_type>& lhs, const elements<value_type>& rhs) { return lhs.value == rhs.value; }

    };

   

}
#endif
