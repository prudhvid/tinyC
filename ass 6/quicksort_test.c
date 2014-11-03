
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

// int strlen(char* s)
// {
// 	int i=0;
// 	while(s[i]!='\0')i++;
// 	return i;
// }

void swap(int* a, int* b)
{
    int t = *a;
    *a = *b;
    *b = t;
}
 
/* This function takes last element as pivot, places the pivot element at its
   correct position in sorted array, and places all smaller (smaller than pivot)
   to left of pivot and all greater elements to right of pivot */
int partition (int *arr, int l, int h)
{
    int x = arr[h];    // pivot
    int i = (l - 1),j;  // Index of smaller element
 
    for ( j = l; j <= h- 1; j++)
    {
        // If current element is smaller than or equal to pivot 
        if (arr[j] <= x)
        {
            i++;    // increment index of smaller element
            swap(arr+i, arr+j);  // Swap current element with index
        }
    }
    swap(arr+i + 1, arr+h);  
    return (i + 1);
}
 
/* *arr --> Array to be sorted, l  --> Starting index, h  --> Ending index */
void quickSort(int *arr, int l, int h)
{
    if (l < h)
    {
        int p = partition(arr, l, h); /* Partitioning index */
        // printi2(p, l);
        quickSort(arr, l, p - 1);
        // printi2(p, h);
        quickSort(arr, p + 1, h);
        // prints("here12\n");
    }
    // prints("here1\n");
    return;
}
 
/* Function to print an array */
void printArray(int *arr, int size)
{
    int i;
    for (i=0; i < size; i++)
        printf(" ", arr[i]);
    prints("\n");
}
 
// Driver program to test above functions
int main()
{
    int arr[10];
    int n,i;
    readi(&n);
    for (i = 0; i < n; ++i){
      readi(&arr[i]);
    }
    // swap(&n, &i);
    prints("array before sorting");
     printArray(arr, n);
    quickSort(arr, 0, n-1);
    prints("Sorted array: \n");
    printArray(arr, n);
    return 0;
}