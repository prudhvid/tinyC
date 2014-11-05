
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


 

int min(int a, int b) {
   return a < b ? a : b;
}
 
// Returns Minimum among a, b, c
int Minimum(int a, int b, int c)
{
    return min(min(a, b), c);
}
 

// Recursive implementation
int EditDistanceRecursion( char *X, char *Y, int m, int n )
{
    // Base cases
    if( m == 0 && n == 0 )
        return 0;
 
    if( m == 0 )
        return n;
 
    if( n == 0 )
        return m;
 
    // Recurse
    int left = EditDistanceRecursion(X, Y, m-1, n) + 1;
    int right = EditDistanceRecursion(X, Y, m, n-1) + 1;
    int corner = EditDistanceRecursion(X, Y, m-1, n-1) + ((X[m-1] != Y[n-1])?1:0);
 
    return Minimum(left, right, corner);
}
 

int levenshtein(char *s1, char *s2) 
{
    int x, y, s1len, s2len;
    s1len = strlen(s1);
    s2len = strlen(s2);
    int matrix[100][100];
    matrix[0][0] = 0;
    for (x = 1; x <= s2len; x++)
        matrix[x][0] = matrix[x-1][0] + 1;
    for (y = 1; y <= s1len; y++)
        matrix[0][y] = matrix[0][y-1] + 1;
    for (x = 1; x <= s2len; x++)
        for (y = 1; y <= s1len; y++)
            matrix[x][y] = Minimum(matrix[x-1][y] + 1, matrix[x][y-1] + 1, matrix[x-1][y-1] + (s1[y-1] == s2[x-1] ? 0 : 1));
 
    return(matrix[s2len][s1len]);
}
int main()
{
    
    char Y[1000];
    
    char X[1000];
    
    reads(X);reads(&Y[0]);
 
    
    prints("Minimum edits required to convert ");
    prints(X);prints(" to ");prints(Y);
    printf("  is ",levenshtein(X, Y) );
           prints("\n");
   
   
 
    return 0;
}