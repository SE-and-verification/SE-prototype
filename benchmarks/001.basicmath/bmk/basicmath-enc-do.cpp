#include <stdio.h>
#include <math.h>
#include "../../../functional-library/src/datatypes/include/enc_fpga_lib.h"
#include "../../../functional-library/src/interface/interface.h"
#include "../../../functional-library/src/interface/parameters.h"


/* The printf's may be removed to isolate just the math calculations */

#define PI         (4*atan(1))


enc_double a1  __attribute__((__section__("ciphertexts")))(1.0);
enc_double b1  __attribute__((__section__("ciphertexts")))(-10.5);
enc_double c1  __attribute__((__section__("ciphertexts")))(32.0);
enc_double d1  __attribute__((__section__("ciphertexts")))(-30.0);

enc_double a2  __attribute__((__section__("ciphertexts")))(1.0);
enc_double b2  __attribute__((__section__("ciphertexts")))(-4.5);
enc_double c2  __attribute__((__section__("ciphertexts")))(17.0);
enc_double d2  __attribute__((__section__("ciphertexts")))(-30.0);

enc_double a3  __attribute__((__section__("ciphertexts")))(1.0);
enc_double b3  __attribute__((__section__("ciphertexts")))(-3.5);
enc_double c3  __attribute__((__section__("ciphertexts")))(22.0);
enc_double d3  __attribute__((__section__("ciphertexts")))(-31.0);

enc_double a4  __attribute__((__section__("ciphertexts")))(1.0);
enc_double b4  __attribute__((__section__("ciphertexts")))(-13.7);
enc_double c4  __attribute__((__section__("ciphertexts")))(1.0);
enc_double d4  __attribute__((__section__("ciphertexts")))(-35.0);

enc_double default_value  __attribute__((__section__("ciphertexts")))(0.0);

void SolveCubic(enc_double  a,
                enc_double  b,
                enc_double  c,
                enc_double  d,
                enc_int    *solutions,
                enc_double *x)
{
      enc_double    a1 = b/a, a2 = c/a, a3 = d/a;
      enc_double    Q = (a1*a1 - 3.0*a2)/9.0;
      enc_double    R = (2.0*a1*a1*a1 - 9.0*a1*a2 + 27.0*a3)/54.0;
      enc_double    R2_Q3 = R*R - Q*Q*Q;

      enc_double    theta;

      // Data-Oblivious If/Else Conversion
      enc_bool condition = R2_Q3 <= 0;

      // if (R2_Q3 <= 0)
      // {
      //       *solutions = 3;
      //       theta = acos(R/sqrt(Q*Q*Q));
      //       x[0] = -2.0*sqrt(Q)*cos(theta/3.0) - a1/3.0;
      //       x[1] = -2.0*sqrt(Q)*cos((theta+2.0*PI)/3.0) - a1/3.0;
      //       x[2] = -2.0*sqrt(Q)*cos((theta+4.0*PI)/3.0) - a1/3.0;
      // }
      int solutions_t = 3;
      theta = acos(R/sqrt(Q*Q*Q));
      enc_double x0_t = -2.0*sqrt(Q)*cos(theta/3.0) - a1/3.0;
      enc_double x1_t = -2.0*sqrt(Q)*cos((theta+2.0*PI)/3.0) - a1/3.0;
      enc_double x2_t = -2.0*sqrt(Q)*cos((theta+4.0*PI)/3.0) - a1/3.0;

      // else
      // {
      //       *solutions = 1;
      //       x[0] = pow(sqrt(R2_Q3)+fabs(R), 1/3.0);
      //       x[0] = x[0] + (Q/x[0]);
      //       x[0] = x[0] * ((R < 0.0) ? 1 : -1);
      //       x[0] = x[0] - (a1/3.0);
      // }
      int solutions_f = 1;
      enc_double x0_f = pow(sqrt(R2_Q3)+fabs(R), 1/3.0);
      x0_f = x0_f + (Q/x0_f);
      x0_f = x0_f * ((R < 0.0).GET_DECRYPTED_VALUE() ? 1 : -1);
      x0_f = x0_f - (a1/3.0);
      enc_double x1_f = default_value;
      enc_double x2_f = default_value;

      // Unify If/Else Results
      // TODO :: This must be converted to use a d.o. CMOV operation! 
      *solutions = condition.GET_DECRYPTED_VALUE() ? solutions_t : solutions_f;
      x[0] = condition.GET_DECRYPTED_VALUE() ? x0_t : x0_f;
      x[1] = condition.GET_DECRYPTED_VALUE() ? x1_t : x1_f;
      x[2] = condition.GET_DECRYPTED_VALUE() ? x2_t : x2_f;

}

int main(void)
{
  setParameters(SymmCipher::XOR, 0x0505050505050505, 0x0505050505050505, 0);
  enc_double x[3];
  double X;
  enc_int     solutions;
  int i;
  long n = 0;

  a1 = 1.0, b1 = -10.5, c1 = 32.0, d1 = -30.0;
  a2 = 1.0, b2 = -4.5, c2 = 17.0, d2 = -30.0;
  a3 = 1.0, b3 = -3.5, c3 = 22.0, d3 = -31.0;
  a4 = 1.0, b4 = -13.7, c4 = 1.0, d4 = -35.0;

  /* solve some cubic functions */
  printf("********* CUBIC FUNCTIONS ***********\n");
  /* should get 3 solutions: 2, 6 & 2.5   */
  SolveCubic(a1, b1, c1, d1, &solutions, x);  
  printf("Solutions:");
  for(i=0;i<solutions.GET_DECRYPTED_VALUE();i++)
    printf(" %f",x[i].GET_DECRYPTED_VALUE());
  printf("\n");
  /* should get 1 solution: 2.5           */
  SolveCubic(a2, b2, c2, d2, &solutions, x);  
  printf("Solutions:");
  for(i=0;i<solutions.GET_DECRYPTED_VALUE();i++)
    printf(" %f",x[i].GET_DECRYPTED_VALUE());
  printf("\n");

  SolveCubic(a3, b3, c3, d3, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions.GET_DECRYPTED_VALUE();i++)
    printf(" %f",x[i].GET_DECRYPTED_VALUE());
  printf("\n");
  
  SolveCubic(a4, b4, c4, d4, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions.GET_DECRYPTED_VALUE();i++)
    printf(" %f",x[i].GET_DECRYPTED_VALUE());
  printf("\n");

  /* Now solve some random equations */
  for(a1=1;a1.GET_DECRYPTED_VALUE()<10;a1++) {
    for(b1=10;b1.GET_DECRYPTED_VALUE()>0;b1-=1.0) {
      for(c1=5;c1.GET_DECRYPTED_VALUE()<15;c1+=0.5) {
	      for(d1=-1;d1.GET_DECRYPTED_VALUE()>-11;d1-=1.0) {
	        SolveCubic(a1, b1, c1, d1, &solutions, x);  
	        printf("Solutions:");
	        for(i=0;i<solutions.GET_DECRYPTED_VALUE();i++)
	          printf(" %f",x[i].GET_DECRYPTED_VALUE());
	          printf("\n");
	      }
      }
    }
  }
  return 0;
}
