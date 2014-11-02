
// This is the test file to test various compilers.You can add expressions here
// at check the output after doing make

//By default it has KMP algorithm implemented and by running this function shows
// the 3-address quads for KMP algorithm


//I've implemented almost all the things given except "function declarations"



int prints(char *x);
int printi(int p);
int readi(int *eP);
int printi2(int a,int b);
// int readf(float *f);
// int printd(float f);
// int prints(char *t);

// void add(int *x,int *y)
// {
// 	int t=*x;
// 	*x=*y;
// 	*y=t;
// }

// void printArray(int *arr,int n)
// {
// 	int i=0;
// 	printi(arr[0]);

// 	for (i = 0; i < n; ++i){
// 		printi(arr[i]);
// 	}
// }
int main()
{
	
	// int a=10;
	// a=a*a;
	// int x1,y1;
	// readi(&x1);readi(&y1);
	// printi2(x1,y1);
	// add(&x1, &y1);
	// printi2(x1,y1);

	int arr[100],i;
	for(i=0;i<100;i++)
		arr[i]=i;
	// printArray(arr, 100);
	int *p=arr;
	for(i=0;i<99;i++)
	{
		printi2(p[i],i);
	}	
	// char a[100];
	// char a2[5];
	// a2[0]=' ';a2[1]='\0';
	// int x=200;
	// x=456;
	// readi(&x);

	// // // a++;++a;++a;

	// int i;
	// for(i='a';i<=x;i++){
	// 	a[i-'a']=i;
	// 	// printi(i);prints(a2);printi(x);prints(a2);
	// 	printi2(i,x);
	// }
	// a[i]='\n';i++;
	// a[i]='\0';
	// prints(a);

	// printi(a);
	return 0;
}





