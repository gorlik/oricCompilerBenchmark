/*
 * Calculate all primes up to a specific number.
 */

#include <conio.h>

/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



#define COUNT           16384           /* Up to what number? */
#define SQRT_COUNT      128             /* Sqrt of COUNT */

static unsigned char Sieve[COUNT];



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/

int main(void)
{
  /* This is an example where register variables make sense */
  register unsigned char* S;
  register unsigned       I;
  register unsigned       J;

  /* Execute the sieve */
  I = 2;
  while(I < SQRT_COUNT)
  {
    if(Sieve[I] == 0)
    {
      /* Prime number - mark multiples */
      J = I*2;
      S = &Sieve[J];
      while(J < COUNT)
      {
        *S = 1;
        S += I;
        J += I;
      }
    }
    ++I;
  }

  return 0;
}



