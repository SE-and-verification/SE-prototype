#include <stddef.h>
//#include <string.h>
#include <limits.h>
#include "../../../encrypted-datatype-library/src/datatypes/include/enc_fpga_lib.h"
#include "../../../encrypted-datatype-library/src/datatypes/enc_string.h"
#include "../../../encrypted-datatype-library/src/datatypes/enc_array.h"



static enc_int table[UCHAR_MAX + 1];
static enc_int len;
static enc_string findme;

/*
**  Call this with the string to locate to initialize the table
*/

void init_search(enc_string string)
{
      size_t i;

      len = string.size();
      for (i = 0; i <= UCHAR_MAX; i++)                      /* rdg 10/93 */
            table[i] = len;
      for (i = 0; i < len.value; i++)
            table[(unsigned char)string[i].value] = len.value - i - 1;
      findme = string;
}

/*
**  Call this with a buffer to search
*/

enc_char* strsearch(enc_string string){

      register enc_int shift;
      register enc_int pos = {len.value - 1, 0} ;
      enc_char* here = '\0';
      enc_int limit = string.size();
      enc_int zero = {0, 0};
      enc_int one = {1, 0};

      while ((pos < limit).value)
      {
            while( pos < limit &&
                  (shift = table[(unsigned char)string[pos.value].value]) > zero)
            {
                  pos = pos + shift;
            }
            if ((zero == shift).value)
            {
                  here = string.getPart(pos - len + one);
                  if ((zero == enc_strncmp(findme.getPart(zero), here, len)).value)
                  {
                        return(here);
                  }
                  else  pos = pos + one;
            }
      }
      return NULL;
}

int main(){
      enc_char* here;
      enc_string find = enc_string("Vong");
      enc_string search = enc_string("Kurt Vonneguts Commencement Address at");
      init_search(find);

      here = strsearch(search);
      find.print();
      printf("%s", here ? " is in " : " is not in ");
      search.print();
      
      
      putchar('\n');
}
