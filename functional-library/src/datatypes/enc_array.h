#include "enc_lib.h"
#include "elements.h"
#include <limits.h>


#define MAX_ARRAY_LEN UCHAR_MAX + 1

namespace enc_lib
{


// ENCRYPTED Derived C++ Data Types
/************************************************************************************/  
/*  · Encrypted Array
        Keyword: enc_array
        An ordered collection of items stored at adjacent memory locations. 
        All array elements have the same data type. Array elements are accessed
        by their index, however C/C++ does not support out of bounds checking.

        Inspired by libstdc++ implementation here:
        https://gcc.gnu.org/onlinedocs/gcc-4.6.3/libstdc++/api/a00752_source.html 

/************************************************************************************/

    template <typename _Tp> 
    class enc_array
    {
        
        typedef _Tp                     value_type;
        typedef _Tp*                    pointer;
        typedef const _Tp*              const_pointer;
        typedef value_type&             reference;
        typedef const value_type&       const_reference;
        typedef value_type*             iterator;
        typedef const value_type*       const_iterator;

    private:
        elements<value_type> arr[MAX_ARRAY_LEN];
        

        elements<value_type>* getElement(enc_int n){
            elements<value_type>* result;
            for(int i = 0; i < MAX_ARRAY_LEN; i++){
                elements<value_type>* temp = &arr[i];
                result = (n.value == i) ? temp : result;
            }
            return result;
        }

    


    public:
    // Public Constructors 
    /********************************************************************************/ 

        enc_array(){}

        enc_array(std::initializer_list<value_type> c){
            const_iterator i = c.begin();
            enc_bool end = {false, 0};
            for(int j = 0; j < MAX_ARRAY_LEN; j++){
		        end.value = (i == c.end());
                arr[j] = !end.value ? *i : arr[j];
	            i = !end.value ? i+1 : i;
            }    
        }
        
        enc_array(value_type value, unsigned int amount){
            for(int i = 0; i < MAX_ARRAY_LEN; i++){
	            enc_bool end =  {i >= amount, 0};
                arr[i] = !end.value ? value : arr[i];
            }
        }



    // Element Access 
    /********************************************************************************/ 
        
        /*  enc_array::operator[]
                Author: Meron Z. Demissie
                Functionality: Locates the nth element within the array
                Return Value: The nth element of the array
        */
        // http://www.cplusplus.com/reference/array/array/operator[]/ 

 

        elements<value_type>& operator[](const int n){
            return arr[n];

        }
        // Data Oblivious Version
        elements<value_type>* operator[](const enc_int n){
            return (getElement(n));
        }


        /*  enc_array::at()
                Author: Meron Z. Demissie
                Functionality: Locates the nth element within the array
                Return Value: The nth element of the array
        */
        // http://www.cplusplus.com/reference/array/array/at/
        reference at(const int n){
             return arr[n].value;
        }
        // Data Oblivious version
        reference at(const enc_int n){
            static value_type result;
            result = getElement(n)->value;
            return result;
        }
        
        /*  enc_array::front()
                Author: Kidus B. Workneh
                Functionality: Uses the getElement function to locate the first element 
                            the array.
                Return Value: The front element in the array
        */
        // http://www.cplusplus.com/reference/array/array/front/ 
        reference front(){
            enc_int n = {0,0};
            static value_type front = getElement(n)->value;
            return front;
        }

        /*  enc_array::back()
                Author: Kidus B. Workneh
                Functionality: Uses the getElement function to locate the last element 
                            the array.
                Return Value: The last element in the array
        */
        // http://www.cplusplus.com/reference/array/array/back/ 
        reference back(){
            // TODO
            enc_int n=  {(MAX_ARRAY_LEN-1),0};
            static value_type front= getElement(n)->value;
            return front;
        }

        enc_bool isElementSet(const int n){
            return {arr[n].isSet(), 0};

        }

    
    // Iterators
    /********************************************************************************/ 
     
        /*  enc_array::begin()
                Author: Lauren Biernacki
                Functionality: Gets an iterating pointer to the first element of the array
                Return Value: Iterator to the first element
        */
        // http://www.cplusplus.com/reference/array/array/begin/
        iterator begin(){
            return iterator(std::__addressof(arr[0]));
        }

        /*  enc_array::end()
                Author: Lauren Biernacki
                Functionality: Gets an iterating pointer to the last element of the array
                Return Value: Iterator to the last element
        */
        // http://www.cplusplus.com/reference/array/array/end/
        iterator end(){
            return iterator(std::__addressof(arr[MAX_ARRAY_LEN - 1]));
        }



    // Capacity 
    /********************************************************************************/ 

        /*  enc_array::size()
                Author: Kidus B. Workneh
                Functionality: Loops through the set attribute of the element in an
                            array and increments the count whenever it gets a true value.
                Return Value: The true number of elements in the array
        */
        //http://www.cplusplus.com/reference/array/array/size/
        enc_int size(){
            // TODO
            enc_int count = {0, 0}; //Need to keep track of true size somehow?
            for (int i = 0; i < MAX_ARRAY_LEN; i++){
                count.value = (arr[i].set.value) ? count.value+1 : count.value;
            }
             return count;
        }

        /*  enc_array::max_size()
                Author: Kidus B. Workneh
                Functionality:Puts the maximum size of the array in an encrypted format.
                Return Value: The maximum number of elements that the array can hold.
        */
        // http://www.cplusplus.com/reference/array/array/max_size/
        enc_int max_size(){

            // TODO
            enc_int max_size={0,0};
            max_size.value = MAX_ARRAY_LEN;
            
            return max_size;

        }

        /*  enc_array::empty()
                Author: Kidus B. Workneh
                Functionality: Uses the size function to check the size attribute of the elements
                            in the array to see if all of them are false
                Return Value: False if the array is not empty or True if it is 
        */
        enc_bool empty(){
            // TODO
            return {size().value == 0, 0};
        }



    // Other Helper Functions 
    /********************************************************************************/ 
 
        /*  enc_array::find()
                Author: Lauren Biernacki
                Revised by: Meron Z. Demissie
                Functionality: Searches the array for the provided _item_. Ignores
                values that are the null_value  
                Return Value: The index of the item in array, or MAX_ARRAY_LEN 
                if element is not found

                Source: https://www.geeksforgeeks.org/std-find-in-cpp/ 
        */
        enc_int find(value_type item){
            enc_int index = {MAX_ARRAY_LEN, 0};
            enc_bool isDone = {false, 0};
            
            for (int i = 0; i < MAX_ARRAY_LEN; i++)
            {
                enc_int i_enc = {i, 0};
                elements<value_type> temp = arr[i];
                index = (!isDone && temp.isSet() && (item == temp.value).value) ? i_enc : index;
                isDone.value = (index.value != MAX_ARRAY_LEN) ? (true) : isDone.value;
            }
            return index;
        }

        /*  enc_array::insert()
                Author: Kidus B. Workneh
                Revised by: Meron Z. Demissie
                Functionality: Insert value at the _true_ end of the array
                Return Value: N/A
        */
        void insert(value_type item){
            enc_int size = (*this).size(); 
            for(int i = 0; i < MAX_ARRAY_LEN; i++){
	            arr[i] = (i == size.value) ? item : arr[i];
            }
            
        }

	void print_array(){
	    printf("\n\nVALUE:  ");
	    int size = this->size().value;
	    for(int i=0; i< size; i++){
                printf(" %d", arr[i].value.value);
		
	    }
	    printf("               SET:  ");
	    for(int i=0; i< MAX_ARRAY_LEN; i++){
		printf(" %d", arr[i].set.value);
	    }
	    printf("\n");
        }


    /********************************************************************************/ 
    };
}

