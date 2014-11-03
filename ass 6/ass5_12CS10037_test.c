
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
 
// Strings of size m and n are passed.
// Construct the Table for X[0...m, m+1], Y[0...n, n+1]
int EditDistanceDP(char *X, char *Y)
{
    // Cost of alignment
    int cost = 0;
    int leftCell, topCell, cornerCell;
 
    int m = strlen(X)+1;
    int n = strlen(Y)+1;
 
    // T[m][n]
    int arr[10000],i,j;
    int *T=arr;
 
    // Initialize table
    for( i = 0; i < m; i++)
        for( j = 0; j < n; j++)
            {*(T + i * n + j) = -1;

            }
    // Set up base cases
    // T[i][0] = i
    for( i = 0; i < m; i++){
        *(T + i * n) = i;
     
    }
        
 
    // T[0][j] = j
    for( j = 0; j < n; j++)
        *(T + j) = j;

    // Build the T in top-down fashion
    for( i = 1; i < m; i++)
    {
        for( j = 1; j < n; j++)
        {
            // T[i][j-1]
            leftCell = *(T + i*n + j-1);
            leftCell++;
 
            // T[i-1][j]
            topCell = *(T + (i-1)*n + j);
            topCell++;
 
            // Top-left (corner) cell
            // T[i-1][j-1]
            cornerCell = *(T + (i-1)*n + (j-1) );
 
            // edit[(i-1), (j-1)] = 0 if X[i] == Y[j], 1 otherwise
            cornerCell = cornerCell+ ((X[i-1] != Y[j-1])?1:0); // may be replace
 
            // Minimum cost of current cell
            // Fill in the next cell T[i][j]
            *(T + i*n + j) = Minimum(leftCell, topCell, cornerCell);
        }
    }
 
    // Cost is in the cell T[m][n]
    // for(i=0;i<m;i++){
    //     for(j=0;j<n;j++)printi(*(T + i * n+j));
    //     prints("\n")   ;
    // }
    cost = *(T + m*n - 1);
    
    return cost;
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
 
int main()
{
    char *X = "hello";
    char *Y = "world";
 
    printf("Minimum edits required to convert %s into %s is %d\n",
           EditDistanceDP(X, Y) );
    printf("Minimum edits required to convert %s into %s is %d by recursion\n",
            EditDistanceRecursion(X, Y, strlen(X), strlen(Y)));
 
    return 0;
}