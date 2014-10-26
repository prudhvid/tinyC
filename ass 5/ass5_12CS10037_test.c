


void mergeI(int *arr,int min,int mid,int max)
{
  int tmp[30];
  int i,j,k,m; 
  j=min;
  m=mid+1;
  for(i=min; j<=mid && m<=max ; i++)
  {
     if(arr[j]<=arr[m])
     {
         tmp[i]=arr[j];
         j++;
     }
     else
     {
         tmp[i]=arr[m];
         m++;
     }
  }
  if(j>mid)
  {
     for(k=m; k<=max; k++)
     {
         tmp[i]=arr[k];
         i++;
     }
  }
  else
  {
     for(k=j; k<=mid; k++)
     {
        tmp[i]=arr[k];
        i++;
     }
  }
  for(k=min; k<=max; k++)
     arr[k]=tmp[k];
}

void part(int *arr,int min,int max)
{
 int mid;
 if(min<max)
 {
   mid=(min+max)/2;
   part(arr,min,mid);
   part(arr,mid+1,max);
   mergeI(arr,min,mid,max);
 }
}
int main()
{
	// int i=0,a[10][10],j;

	// for(i=0;i<10;i++)
	// {
	// 	for(j=0;j<10;j++)
	// 		a[i][j]=a[i][j]*200;
	// 	j=0;
	// 	if(j==1)
	// 		while(i<j)
	// 		{
	// 			j++;
	// 			do
	// 			{
	// 				j=j*29;
	// 			}while(j&&i);
	// 		}
	// }
	// a[1][2]=a[3][4]=a[5][6]=0;
	// int x,*y;

	// y=&x;
	// int i=9;
	//  i=(i)?i*10:i*100;
	// while(i==9&&j!=0&&i<0&&i>0)
	// {
	// 	i++;
	// }
	int i=1,j=0;
	for(;i||j;)
		i++;
	int x[40];
	int (*y)=x;
	y[20]=4;
	
	return 0;
}





//ternary support
//arrays
//relops