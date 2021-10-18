#include "enc_lib_verilator.h"
#include <stdio.h>



namespace enc_lib
{

    enc_char null_char  __attribute__((__section__("ciphertexts"))) = enc_char('\0');

// ENCRYPTED Derived C++ Data Types
/************************************************************************************/ 
/*  + String: NEW!

        http://www.cplusplus.com/reference/string/basic_string/ 
        http://www.cplusplus.com/reference/string/
        https://code.woboq.org/userspace/glibc/string/


/************************************************************************************/

    // Basically an array of characters 
    // Not null-terminated since there is a fixed length
    // Null terminator is the void char! 
    template <int N> 
    class enc_string
    {

        typedef enc_char                _Tp;
        typedef _Tp                     value_type;
        typedef _Tp*                    pointer;
        typedef const _Tp*              const_pointer;
        typedef value_type&             reference;
        typedef const value_type&       const_reference;
        typedef value_type*             iterator;
        typedef const value_type*       const_iterator;

    private:
        static const int MAX_STR_LEN = N; 
        enc_char str[MAX_STR_LEN+1];
        int len = 0;
        bool check_len = false;


        enc_char getElement(enc_int n){
            enc_char result;
            for(int i = 0; i < MAX_STR_LEN; i++){
                enc_char temp = str[i];
                result = CMOV(n == i, temp, result);
            }
            return result;
        }
       
    public:
    // Public Constructors 
    /********************************************************************************/ 
        enc_string(){}

        enc_string(const char* c){
            int i = 0;
            enc_bool isDone = enc_bool(false);
            while(i < MAX_STR_LEN){
                enc_bool end = enc_bool(c[i] == '\0');
                str[i] = CMOV(isDone || end, null_char, enc_char(c[i]));
                isDone = CMOV(end, enc_bool(true), isDone);
                i++;
            }
	        str[MAX_STR_LEN] = null_char;
            check_len = true;
        }

        enc_string(const enc_char* c){
            int i = 0;
            enc_bool isDone = enc_bool(false);
            while(i < MAX_STR_LEN){
                enc_bool end = enc_bool(c[i] == '\0');
                str[i] = CMOV(isDone || end, null_char, c[i]);
                isDone = CMOV(end, true, isDone);
                i++;
            }
	        str[MAX_STR_LEN] = null_char;
            check_len = true;
        }

        enc_string(std::initializer_list<enc_char> c){
            const_iterator i = c.begin();
            bool end = false;
            for(int j = 0; j < MAX_STR_LEN; j++){
                end = (i == c.end());
                str[j] = end ? null_char: *i;
                i = !end ? i+1 : i; //WHAT IS THIS 
            }
            str[MAX_STR_LEN] = null_char; 
            check_len = true;
        }

       


    // Element Access 
    /********************************************************************************/ 
        
        /*  enc_string::operator[]
                Author: Meron Z. Demissie
                Functionality: Locates the nth element within the string
                Return Value: The nth element of the string
        */
        reference operator[](const int n){
            return str[n];
        }
        value_type operator[](const int n) const{
            return str[n];
        }
        // Data Oblivious Version
        reference operator[](const enc_int n){
            static enc_char result;
            result = getElement(n);
            return result;
        }

        /*  enc_string::at()
                Author: Meron Z. Demissie
                Functionality: Locates the nth element within the string
                Return Value: The nth element of the string
        */
        // http://www.cplusplus.com/reference/string/basic_string/at/
        reference at(const int n){
            return str[n];
        }
        //Data Oblivious Version
        reference at(const enc_int n){
            static enc_char result;
            result = getElement(n);
            return result;
        }
        
        /*  enc_string::front()
                Author: Kidus B. Workneh
                Functionality: Uses the get element function to locate the first enc_char int
                            the string
                Return Value: The first encrypted charachter in the string
        */
        // http://www.cplusplus.com/reference/string/basic_string/front/
        reference front(){
            // TODO
            static enc_char x = str[0];
            return x;
        }

        /*  enc_string::back()
                Author: Kidus B. Workneh
                Functionality: Uses the get element function to locate the last enc_char int
                            the string
                Return Value: The last encrypted charachter in the string        */
        // http://www.cplusplus.com/reference/string/basic_string/back/
        reference back(){
            // TODO
            static enc_char x = str[MAX_STR_LEN - 1];
            return x;
        }

        /*  enc_string::getPart()
                Author: Meron Z. Demissie
                Functionality: help get part of the string from the start index to the end of the string
                Return Value: Pointer to the beginning of partial string
        */
        enc_char* getPart(enc_int start){
            return &(str[start.GET_DECRYPTED_VALUE()]);
        }


    
    // Iterators
    /********************************************************************************/ 
     
        /*  enc_string::begin()
                Author: Lauren Biernacki
                Functionality: Gets an iterating pointer to the first element of the string
                Return Value: Iterator to the first character 
        */
        // http://www.cplusplus.com/reference/string/basic_string/begin/
        iterator begin(){
            //TODO
            return iterator(std::__addressof(str[0]));
        }

        /*  enc_string::end()
                Author: Lauren Biernacki
                Functionality: Gets an iterating pointer to the last element of the string
                Return Value: Iterator to the last character
        */
        // http://www.cplusplus.com/reference/string/basic_string/end/
        iterator end(){
            //TODO
            return iterator(std::__addressof(str[MAX_STR_LEN - 1]));
        }


    // Capacity 
    /********************************************************************************/ 

        /*  enc_string::size()
                Author: Meron Z. Demissie
                Functionality: Returns the number of characters within the string
                Return Value: True size of the string
        */
        //http://www.cplusplus.com/reference/string/basic_string/size/
        int size(){
            // TODO
            if(check_len){
                int count = 0;
                for(int i = 0; i < MAX_STR_LEN; i++){
                    enc_bool is_null = (str[i] == null_char);
                    // enc_int one = {1,0};
                    // enc_int inc = CMOV(!is_null, one, global_zero);
                    if(!(is_null.GET_DECRYPTED_VALUE())){count++;}
                    // count += inc; 
                }
                len = count;
                check_len = false;
            }
            return len;
            // return MAX_STR_LEN; 
        }

        /*  enc_string::length()
                Author: Kidus B. Workneh
                Functionality: It gets the true size of the string and multiplies it by 8
                            since our enc_char takes 8 byte of memory 
                Return Value: The size of our string in memory
        */
        //http://www.cplusplus.com/reference/string/basic_string/length/
        enc_int length(){
            // TODO
            enc_int count = enc_int(-1, 0);
            for(int i = 0; i < MAX_STR_LEN; i++){
                count = CMOV((count == -1) && (str[i] == '\0'), i, count);
            }
            count = count * 8;  //Since a enc_char takes one byte of memory with 7 bytes of salt
            return count;  
        }

        /*  enc_array::max_size()
                Author: Kidus B. Workneh
                Functionality: Puts the maximum size of the array in an encrypted format.
                Return Value: The maximum number of elements that the array can hold.
        */
        // http://www.cplusplus.com/reference/array/array/max_size/
        enc_int max_size(){
            // TODO
            enc_int max_size = enc_int(MAX_STR_LEN);
            return max_size;
        }

        /*  enc_array::empty()
                Author: Kidus B. Workneh
                Functionality: Uses the size function to check the size attribute of the elements
                            in the array to see if all of them are false
                Return Value: False if the array is not empty or True if it is 
        */
        enc_bool empty(){
            return enc_bool(size() == 0);
        }



    // Other Helper Functions 
    /********************************************************************************/ 
  
        //INSECURE, USE FOR DEBUG ONLY
        void print(){
            // std::cout<<"Print Call"<<std::endl;
            for (int i = 0; i < MAX_STR_LEN; i++){
                std::cout << str[i].GET_DECRYPTED_VALUE();
            }
        }

    };
       


    // Non-Member Functions 
    /********************************************************************************/ 
    /*  enc_lib::enc_strcpy()
            Author: Meron Z. Demissie
            Functionality: Copies the value of one encrypted string to another
            Return Value: N/A
    */
    // https://code.woboq.org/userspace/glibc/string/strcpy.c.html 
    // void enc_strcpy(enc_string& dest, const enc_string& src){
    //     //TODO 
    //     dest = src;
    // }

    // /*  enc_lib::enc_strcat()
    //         Author: Meron Z. Demissie
    //         Functionality: Concatenates the encrypted source string to the encrypted destination string
    //         Return Value: Reference to the encrypted destination string
    // */
    // // https://code.woboq.org/userspace/glibc/string/strcat.c.html
    // enc_string& enc_strcat(enc_string& dest,const enc_string& src){
    //     //TODO
    //     enc_int idx = dest.size();
    //     for(int i = 0; i < MAX_STR_LEN; i++){  
	//         idx = (idx.GET_DECRYPTED_VALUE() + i) < (MAX_STR_LEN - 1) ? (idx.GET_DECRYPTED_VALUE() + i) : idx.GET_DECRYPTED_VALUE();
    //         dest[idx.GET_DECRYPTED_VALUE()] = src[i];
    //     }
    //     return dest;
    // }
    /*  enc_lib::enc_strcmp()
            Author: Meron Z. Demissie
            Functionality: Compares two encrypted strings character by character
            Return Value: Returns an encrypted integer that represents difference between the computed characters 
            (enc_int value: 0 - if both are the same, less than 0 if p1 < p2 and greater than if p1 > p2)
    */
    // https://code.woboq.org/userspace/glibc/string/strcmp.c.html
//     enc_int enc_strcmp(enc_string& p1, enc_string& p2){
//         enc_int result = 0;
//         for(int i = 0; i < MAX_STR_LEN; i++){
//             result = (result.GET_DECRYPTED_VALUE() == 0) && (p1[i].GET_DECRYPTED_VALUE() != p2[i].GET_DECRYPTED_VALUE()) ?  (p1[i] - p2[i]).GET_DECRYPTED_VALUE() : result.GET_DECRYPTED_VALUE();   
//         }
//         return result;
//     }
   
//    /*  enc_lib::enc_strncmp()
//             Author: Meron Z. Demissie
//             Functionality: Compares two encrypted strings character by character within a given range
//             Return Value: Returns an encrypted integer that represents difference between the computed characters 
//             (enc_int value: 0 - if both are the same, less than 0 if p1 < p2 and greater than if p1 > p2)
//     */
//     enc_int enc_strncmp(enc_string& p1, enc_string& p2, enc_int len){
//         enc_int result = 0;
//         for(int i = 0; i < len.GET_DECRYPTED_VALUE(); i++){
//             result = (result.GET_DECRYPTED_VALUE() == 0) && (p1[i].GET_DECRYPTED_VALUE() != p2[i].GET_DECRYPTED_VALUE()) ?  (p1[i] - p2[i]).GET_DECRYPTED_VALUE() : result.GET_DECRYPTED_VALUE();   
//         }
//         return result;
//     }


//     enc_int enc_strncmp(enc_char* p1, enc_char* p2, enc_int len){
//         enc_int result = 0;
//         for(int i = 0; i < len.GET_DECRYPTED_VALUE(); i++){
//             result = (result.GET_DECRYPTED_VALUE() == 0) && (p1[i].GET_DECRYPTED_VALUE() != p2[i].GET_DECRYPTED_VALUE()) ?  (p1[i] - p2[i]).GET_DECRYPTED_VALUE() : result.GET_DECRYPTED_VALUE();   
//         }
//         return result;
//     }

    

}
