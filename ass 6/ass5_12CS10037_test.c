
// This is the test file to test various compilers.You can add expressions here
// at check the output after doing make

//By default it has KMP algorithm implemented and by running this function shows
// the 4-address quads for KMP algorithm






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
int printf2(char*s,int a,int b)
{
    return prints(s)+printi(a)+printi(b);
}

int strlen(char* s)
{
	int i=0;
	while(s[i]!='\0')i++;
	return i;
}

int determinant(int (*f)[20],int x)
{
  int pr,c[20],d=0,b[20][20],j,p,q,t;
  if(x==2)
  {
    d=0;
    d=(f[1][1]*f[2][2])-(f[1][2]*f[2][1]);
    return(d);
   }
  else
  {
    for(j=1;j<=x;j++)
    {       
      int r=1,s=1;
      for(p=1;p<=x;p++)
        {
          for(q=1;q<=x;q++)
            {
              if(p!=1&&q!=j)
              {
                b[r][s]=f[p][q];
                s++;
                if(s>x-1)
                 {
                   r++;
                   s=1;
                  }
               }
             }
         }
     for(t=1,pr=1;t<=(1+j);t++)
     pr=(-1)*pr;
     c[j]=pr*determinant(b,x-1);
     }
     for(j=1,d=0;j<=x;j++)
     {
       d=d+(f[1][j]*c[j]);
      }
     return(d);
   }
}


int adn(int a,int b)
{

}


int main()
{
  int i,j,m;
  int a[20][20];
  
  prints("\n\nEnter order of matrix : ");
  readi(&m);
  prints("\nEnter the elements of matrix\n");
  for(i=1;i<=m;i++)
  {
  for(j=1;j<=m;j++)
  {
  printf("a[",i); printf("][",j);prints("] ");
  readi(&a[i][j]);
  }
  }
  prints("\n\n---------- Matrix A is --------------\n");   
  for(i=1;i<=m;i++)
     {
          prints("\n");
          for(j=1;j<=m;j++)
          {    
               printf("\t",a[i][j]);prints("\t");
          }
     }
  prints("\n \n");
  int res=determinant(&a[0],m);

  printf("\n Determinant of Matrix A is  ",res);prints("\n");
  
}
 
