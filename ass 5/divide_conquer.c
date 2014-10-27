
 
 // This function returns median of ar1[] and ar2[].
 //   Assumptions in this function:
 //   Both ar1[] and ar2[] are sorted arrays
 //   Both have n elements 
int getMedian(int *ar1, int *ar2, int n)
{
    int i = 0; 
    int j = 0; 
    int count;
    int m1 = -1, m2 = -1;
 
    
    for (count = 0; count <= n; count++)
    {
        // Below is to handle case where all elements of ar1[] are
        //   smaller than smallest(or first) element of ar2[]
        if (i == n)
        {
            m1 = m2;
            m2 = ar2[0];
            //break; removed break statemnet to avoid syntax error
        }
 
        // Below is to handle case where all elements of ar2[] are
        //   smaller than smallest(or first) element of ar1[]
        else if (j == n)
        {
            m1 = m2;
            m2 = ar1[0];
            // break;removed break statemnet to avoid syntax error
        }
 
        if (ar1[i] < ar2[j])
        {
            m1 = m2;   //Store the prev median 
            m2 = ar1[i];
            i++;
        }
        else
        {
            m1 = m2;  // Store the prev median 
            m2 = ar2[j];
            j++;
        }
    }
 
    return (m1 + m2)/2;
}
 
 // Driver program to test above function 
int main()
{
    int ar1[100];
    int ar2[100];
    int i;
    for ( i = 0; i < 100; ++i){
        ar1[i]=i*7/34;
    }
    
    getMedian(ar1, ar2, 100);
    
    return 0;
}