
// This is the test file to test various compilers.You can add expressions here
// at check the output after doing make

//By default it has KMP algorithm implemented and by running this function shows
// the 3-address quads for KMP algorithm


//I've implemented almost all the things given except "function declarations"



// int prints(char *x);
int printi(int p);
int readi(int *eP);
int printi2(int a,int b);
// int readf(float *f);
// int printd(float f);
// int prints(char *t);

void add(int *x,int *y)
{
	int t=*x;
	*x=*y;
	*y=t;
}

int main()
{
	
	// int a=10;
	// a=a*a;
	int x1,y1;
	readi(&x1);readi(&y1);
	printi2(x1,y1);
	add(&x1, &y1);
	printi2(x1,y1);
	return 0;
}





