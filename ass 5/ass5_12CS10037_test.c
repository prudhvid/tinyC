

int sum(int *x,int **y)
{

}

int diff(double x,int y)
{

}
int diff2(int x,int y,int z)
{

}
int alla()
{
	int a,b,c;
	a++;b++;
}
int main()
{

	int i=0,a[10][10],j;

	for(i=0;i<10;i++)
	{
		for(j=0;j<10;j++)
			a[i][j]=0;
	}
	int a1=5;
	a1=alla();
	a1=diff2(diff2(1,2,3), diff(4.5, 3), diff(2.34,5));
}
