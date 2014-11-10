
// This is the test file to test various compilers.You can add expressions here
// at check the output after doing make

//By default it has KMP algorithm implemented and by running this function shows
// the 4-address quads for KMP algorithm






int prints(char *x);
int printi(int p);
int readi(int *eP);
int printi2(int a,int b);
int printc(char a);
int reads(char*a);
int printf(char*s,int a)
{
	return prints(s)+printi(a);
}


int strlen(char* s)
{
	int i=0;
	while(s[i]!='\0')i++;
	return i;
}


void primeFactors(int n)
{
    // Print the number of 2s that divide n
    while (n%2 == 0)
    {
        printf("\n", 2);
        n = n/2;
    }
    int i;
    // n must be odd at this point.  So we can skip one element (Note i = i +2)
    for ( i = 3; i <= (n); i = i+2)
    {
        // While i divides n, print i and divide n
        while (n%i == 0)
        {
            printf("\n", i);
            n = n/i;
        }
    }
 
    // This condition is to handle the case whien n is a prime number
    // greater than 2
    if (n > 2)
        printf ("\n", n);
}
 
/* Driver program to test above function */
int main()
{
    int n = 315;
    prints("Enter a number:");
    readi(&n);
    prints("The primefactorization of this number");
    primeFactors(n);
    prints("\n");
    return 0;
}


