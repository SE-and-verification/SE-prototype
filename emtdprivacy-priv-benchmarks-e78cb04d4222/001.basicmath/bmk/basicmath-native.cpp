#include <stdio.h>
#include <math.h>

/* The printf's may be removed to isolate just the math calculations */

 #define PI         (4*atan(1))
  double  a1 = 1.0, b1 = -10.5, c1 = 32.0, d1 = -30.0;
  double  a2 = 1.0, b2 = -4.5, c2 = 17.0, d2 = -30.0;
  double  a3 = 1.0, b3 = -3.5, c3 = 22.0, d3 = -31.0;
  double  a4 = 1.0, b4 = -13.7, c4 = 1.0, d4 = -35.0;


void SolveCubic(double  a,
                double  b,
                double  c,
                double  d,
                int    *solutions,
                double *x)
{
      double    a1 = b/a, a2 = c/a, a3 = d/a;
      double    Q = (a1*a1 - 3.0*a2)/9.0;
      double R = (2.0*a1*a1*a1 - 9.0*a1*a2 + 27.0*a3)/54.0;
      double    R2_Q3 = R*R - Q*Q*Q;

      double    theta;

      if (R2_Q3 <= 0)
      {
            *solutions = 3;
            theta = acos(R/sqrt(Q*Q*Q));
            x[0] = -2.0*sqrt(Q)*cos(theta/3.0) - a1/3.0;
            x[1] = -2.0*sqrt(Q)*cos((theta+2.0*PI)/3.0) - a1/3.0;
            x[2] = -2.0*sqrt(Q)*cos((theta+4.0*PI)/3.0) - a1/3.0;
      }
      else
      {
            *solutions = 1;
            x[0] = pow(sqrt(R2_Q3)+fabs(R), 1/3.0);
            x[0] += Q/x[0];
            x[0] *= (R < 0.0) ? 1 : -1;
            x[0] -= a1/3.0;
      }
}

int main(void)
{
  double  x[3];
  int     solutions;
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
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");
  /* should get 1 solution: 2.5           */
  SolveCubic(a2, b2, c2, d2, &solutions, x);  
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  SolveCubic(a3, b3, c3, d3, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");
  
  SolveCubic(a4, b4, c4, d4, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  /* Now solve some random equations */
  for(a1=1;a1<10;a1++) {
    for(b1=10;b1>0;b1-=1.0) {
      for(c1=5;c1<15;c1+=0.5) {
	      for(d1=-1;d1>-11;d1-=1.0) {
	        SolveCubic(a1, b1, c1, d1, &solutions, x);  
	        printf("Solutions:");
	        for(i=0;i<solutions;i++)
	          printf(" %f",x[i]);
	          printf("\n");
	      }
      }
    }
  }
  return 0;
}