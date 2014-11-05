
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


 

int isMatch( char *s,  char *p) 
{
  
  if (p[0] == '\0') return 
    ((s[0] == '\0')?1:0);
 
  // next char is not '*': must match current character
  if ((p[1]) != '*') {
    
    return (((p[0] == s[0]) || (p[0] == '.' && s[0] != '\0')) && isMatch(s+1, p+1))?1:0;
  }
  // next char is '*'
  while ((*p == *s) || (*p == '.' && *s != '\0')) {
    if (isMatch(s, p+2)) return 1;
    s++;
  }
  return isMatch(s, p+2);
}
int main()
{
    
    char Y[1000];
    
    char X[1000];
    
    reads(X);reads(&Y[0]);
 
    
    prints("The string ");
    prints(X);prints(" and ");prints(Y);
    int res=isMatch(X, Y) ;
    if(res)
           prints(" can be matched via regular expressions");
    else
           prints(" cannot be matched via regular expressions");
    prints("\n");
   
 
    return 0;
}