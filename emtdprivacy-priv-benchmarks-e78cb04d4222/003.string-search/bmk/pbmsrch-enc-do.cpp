#include <stddef.h>
//#include <string.h>
#include <limits.h>
#include "../../../encrypted-datatype-library/src/datatypes/enc_lib.h"
#include "../../../encrypted-datatype-library/src/datatypes/enc_string.h"
#include "../../../encrypted-datatype-library/src/datatypes/enc_array.h"


using namespace enc_lib;


static enc_int len;
static enc_array<enc_int> table = {len, UCHAR_MAX+1};
static enc_string findme;

/*
**  Call this with the string to locate to initialize the table
*/

void init_search(enc_string string)
{
      size_t i;

      len = string.size();
      enc_int index;
      for (i = 0; i <= len.value; i++){                      /* rdg 10/93 */
            table[(unsigned char)string[i].value] = {len.value - i - 1, 0};
	    
      }
      findme = string;
}

/*
**  Call this with a buffer to search
*/

enc_char* strsearch(enc_string string){
      register enc_int pos = {len.value - 1, 0};
      register enc_int shift;
      enc_char* temp = NULL;
      enc_char* here = NULL;
      enc_int limit = string.size();
      enc_int zero = {0, 0};
      enc_int one = {1, 0};

      while ((pos < limit).value)
      {  
          shift = table[(unsigned char)string[pos.value].value].value;
          pos = (pos < limit  && shift > zero) ? pos + shift : pos;
          temp = string.getPart(pos - len + one);
          here =  here == NULL && ((zero == shift) && (zero == enc_strncmp(findme.getPart(zero), temp, len)))  ? temp : here;
          pos =  (here != NULL) ? limit : ((zero == shift).value ? pos + one : pos);
      }
      return here;
}

int main(){
      enc_char* here = NULL;
      enc_string find = enc_string("mence");
      enc_string search = enc_string("Vonnegu Commencement Addres");
      init_search(find);
      here = strsearch(search);
      find.print();
      printf("%s", here ? " is in " : " is not in ");
      search.print();
      
      
      putchar('\n');
}
