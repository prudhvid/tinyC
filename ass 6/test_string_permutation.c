
// This is the test file to test various compilers.You can add expressions here
// at check the output after doing make

//By default it has KMP algorithm implemented and by running this function shows
// the 3-address quads for KMP algorithm


//I've implemented almost all the things given except "function declarations"



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


 

void swap (char *x, char *y)
{
    char temp;
    temp = *x;
    *x = *y;
    *y = temp;
}
  
 // Function to print permutations of string
 //   This function takes three parameters:
 //   1. String
 //   2. Starting index of the string
 //   3. Ending index of the string. 
void permute(char *a, int i, int n) 
{
   int j; 
   if (i == n-1)
     {prints(a);prints("\n");}
   else
   {
        for (j = i; j < n; j++)
       {
          swap((a+i), (a+j));
          permute(a, i+1, n);
          swap((a+i), (a+j)); //backtrack
       }
   }
} 
 

int main()
{
    
    
    
    char X[1000];
    
    reads(X);
   
    permute(X, 0, strlen(X));
   
   
 
    return 0;
}