
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

void printArray(int *arr,int n)
{
	int i=0;
	prints("array=");
	for (i = 0; i < n; ++i){
		printi(arr[i]);
		prints(" ");
	}
	prints("\n");
}
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


// int main()
// {
// 	int a=10,r1=5,r2=3,r3=8;

// 	//if statement simple if
// 	if(r1==r2&&r2<=5&&r1+100*a>=56)
// 	{
// 		r3++;
// 	}
	
// 	//if else complex
// 	if(r1>=r2)
// 	{
// 		if(a+98<=908)
// 			a++;
// 		else {
// 			if(a>5)
// 				a--;
// 			else
// 				a=a+283*37;
// 		}
// 	}
// 	else
// 		r1++;



// 	//for while do while all in one
// 	int i,j=29,k=88;
// 	for (i = 0; i < 20; ++i){
// 		for (k=0; j!=9; ){
// 			j++;
// 			do{
// 				while(k<=90)
// 				k++;	
// 			}while(k<20);
			
// 		}

// 	}
	

// 	return 0;
// }

// void mergeSort(int *arr,int low,int mid,int high);
// void partition(int *arr,int low,int high);

// int main(){
   	
// 	int merge[100],i,n;

// 	prints("Enter the total number of elements: ");
// 	// scanf("%d",&n);
// 	readi(&n);

// 	prints("Enter the elements which to be sort: ");
// 	for(i=0;i<n;i++){
// 		 readi(&merge[i]);
// 		 // printi2(merge[i]/10,10);
// 	}
// 	char* x="hello world :D :D :D\n";
// 	prints(x);
// 	// printArray(merge, n);
// 	// partition(merge,0,n-1);

// 	// print("After merge sorting elements are: ");
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
// 		 partition(arr,mid+1,high);
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






 
//  int strlen(char* s)
// {	
// 	int i;
// 	for ( i = 0; s[i]!='\0'; ++i){
		
// 	}
// 	return i;
// }

// void computeLPSArray(char *pat, int M, int *lps)
// {
//     int len = 0;  // lenght of the previous longest prefix suffix
//     int i;
 
//     lps[0] = 0; // lps[0] is always 0
//     i = 1;
 
//     // the loop calculates lps[i] for i = 1 to M-1
//     while(i < M)
//     {
//        if(pat[i] == pat[len])
//        {
//          len++;
//          lps[i] = len;
//          i++;
//        }
//        else // (pat[i] != pat[len])
//        {
//          if( len != 0 )
//          {
//            // This is tricky. Consider the example AAACAAAA and i = 7.
//            len = lps[len-1];
 
//            // Also, note that we do not increment i here
//          }
//          else // if (len == 0)
//          {
//            lps[i] = 0;
//            i++;
//          }
//        }
//     }
// }



// void KMPSearch(char *pat, char *txt)
// {
//     int M = strlen(pat);
//     int N = strlen(txt);
 
//     // create *lps that will hold the longest prefix suffix values for pattern
//     int lps[1000];
//     int j  = 0;  // index for pat[]
 
//     // Preprocess the pattern (calculate lps[] array)
//     computeLPSArray(pat, M, lps);
 
//     int i = 0;  // index for txt[]
//     while(i < N)
//     {
//       if(pat[j] == txt[i])
//       {
//         j++;
//         i++;
//       }
 
//       if (j == M)
//       {
//         printi2(i-j,0);
//         j = lps[j-1];
//       }
 
//       // mismatch after j matches
//       else if(pat[j] != txt[i])
//       {
//         // Do not match lps[0..lps[j-1]] characters,
//         // they will match anyway
//         if(j != 0)
//          j = lps[j-1];
//         else
//          i = i+1;
//       }
//     }
//     // free(lps); // to avoid memory leak
// }
 

// int main()
// {
	
// 	// char a[100],b[100];
// 	// int i=0;
// 	// for ( i = 0; i < 100; ++i){
// 	// 	a[i]=('a'+i)%26+'a';
// 	// }
// 	// b[0]='a';
// 	// b[1]='b';
// 	// b[2]='c';
// 	// b[3]='\0';
// 	// a[i]='\0';
// 	// prints(a);
// 	// prints(b);
// 	// KMPSearch(a, b);
// 	char *x="skjnskjn";
	
// 	return 0;
// }



 
void merge(int *arr, int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;
 
    /* create temp arrays */
    int L[n1], R[n2];
 
    /* Copy data to temp arrays *L and *R */
    for(i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for(j = 0; j < n2; j++)
        R[j] = arr[m + 1+ j];
 
    /* Merge the temp arrays back into arr[l..r]*/
    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2)
    {
        if (L[i] <= R[j])
        {
            arr[k] = L[i];
            i++;
        }
        else
        {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
 
    /* Copy the remaining elements of *L, if there are any */
    while (i < n1)
    {
        arr[k] = L[i];
        i++;
        k++;
    }
 
    /* Copy the remaining elements of *R, if there are any */
    while (j < n2)
    {
        arr[k] = R[j];
        j++;
        k++;
    }
}
 
/* l is for left index and r is right index of the sub-array
  of arr to be sorted */
void mergeSort(int *arr, int l, int r)
{
    if (l < r)
    {
        int m = l+(r-l)/2; //Same as (l+r)/2, but avoids overflow for large l and h
        mergeSort(arr, l, m);
        mergeSort(arr, m+1, r);
        merge(arr, l, m, r);
    }
}
 
 

 
/* Driver program to test above functions */
int main()
{
    int arr[100];
    int arr_size,i;
 	
    prints("Enter the total number of elements: ");
	readi(&arr_size);

	prints("Enter the elements which to be sort: ");
	for(i=0;i<arr_size;i++){
		 readi(&arr[i]);
	}


    prints("Given array is \n");
    printArray(arr, arr_size);
 
    mergeSort(arr, 0, arr_size - 1);
 
    prints("\nSorted array is \n");
    printArray(arr, arr_size);
    return 0;
}