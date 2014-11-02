
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

// 	for (i = 0; i < n; ++i){
// 		printi2(arr[i],3);
// 	}
// }
// int main()
// {
	
// 	// int a=10;
// 	// a=a*a;
// 	// int x1,y1;
// 	// readi(&x1);readi(&y1);
// 	// printi2(x1,y1);
// 	// add(&x1, &y1);
// 	// printi2(x1,y1);

// 	// int arr[100],i;
// 	// for(i=0;i<100;i++)
// 	// 	arr[i]=i;
// 	// // printArray(arr, 100);
// 	// int *p=arr;
// 	// for(i=0;i<99;i++)
// 	// {
// 	// 	printi2(p[i],i);
// 	// }	
// 	// char a[100];
// 	// char a2[5];
// 	// a2[0]=' ';a2[1]='\0';
// 	// int x=200;
// 	// x=456;
// 	// readi(&x);

// 	// // // a++;++a;++a;

// 	// int i;
// 	// for(i='a';i<=x;i++){
// 	// 	a[i-'a']=i;
// 	// 	// printi(i);prints(a2);printi(x);prints(a2);
// 	// 	printi2(i,x);
// 	// }
// 	// a[i]='\n';i++;
// 	// a[i]='\0';
// 	// prints(a);

// 	// printi(a);

// 	int c,d,swap,n=100;
// 	int arr[100];
// 	int *array=arr;

// 	for(c=0;c<100;c++)
// 	{
// 		array[c]=100-c;
// 		printi2(array[c],1);
// 	}
		

// 	for (c = 0 ; c < ( n - 1 ); c++){
// 		for (d = 0 ; d < n - c - 1; d++){
// 			if (array[d] > array[d+1]) /* For decreasing order use < */
// 			{
// 				swap       = array[d];
// 				array[d]   = array[d+1];
// 				array[d+1] = swap;
// 			}
// 		}
// 	}

// 	printArray(arr, n);
// 	return 0;
// }


int main()
{
	int a=10,r1=5,r2=3,r3=8;

	//if statement simple if
	if(r1==r2&&r2<=5&&r1+100*a>=56)
	{
		r3++;
	}
	
	//if else complex
	if(r1>=r2)
	{
		if(a+98<=908)
			a++;
		else {
			if(a>5)
				a--;
			else
				a=a+283*37;
		}
	}
	else
		r1++;



	//for while do while all in one
	int i,j=29,k=88;
	for (i = 0; i < 20; ++i){
		for (k=0; j!=9; ){
			j++;
			do{
				while(k<=90)
				k++;	
			}while(k>20);
			
		}

	}
	

	return 0;
}

// void mergeSort(int *arr,int low,int mid,int high);
// void partition(int *arr,int low,int high);

// int main(){
   	
// 	int merge[100],i,n;

// 	// printf("Enter the total number of elements: ");
// 	// scanf("%d",&n);
// 	readi(&n);

// 	// printf("Enter the elements which to be sort: ");
// 	for(i=0;i<n;i++){
// 		 readi(merge+i);
// 		 // printi2(merge[i]/10,10);
// 	}
// 	// printArray(merge, n);
// 	partition(merge,0,n-1);

// 	// printf("After merge sorting elements are: ");
// 	// for(i=0;i<n;i++){
// 	// 	add(merge, merge+i);
// 	// }
// 	// printArray(merge, n);
//    return 0;
// }

// void partition(int *arr,int low,int high){

// 	int mid;

// 	if(low<high){
// 		 mid=(low+high)/2;
		 
// 		 partition(arr,low,mid);
// 		 printi2(low ,high);
// 		 printi2(mid,0);
// 		 printArray(arr, high);
// 		 // int x=mid+1;
// 		 // partition(arr,x,high);
// 		 mergeSort(arr,low,mid,high);
// 	}
// }

// void mergeSort(int *arr,int low,int mid,int high){

// 	int i,m,k,l,temp[100];

// 	l=low;
// 	i=low;
// 	m=mid+1;

// 	while((l<=mid)&&(m<=high)){

// 		 if(arr[l]<=arr[m]){
// 			 temp[i]=arr[l];
// 			 l++;
// 		 }
// 		 else{
// 			 temp[i]=arr[m];
// 			 m++;
// 		 }
// 		 i++;
// 	}

// 	if(l>mid){
// 		 for(k=m;k<=high;k++){
// 			 temp[i]=arr[k];
// 			 i++;
// 		 }
// 	}
// 	else{
// 		 for(k=l;k<=mid;k++){
// 			 temp[i]=arr[k];
// 			 i++;
// 		 }
// 	}
   
// 	for(k=low;k<=high;k++){
// 		 arr[k]=temp[k];
// 	}
// }




