
int main()
{

	int i=0,a[10][10],j;

	for(i=0;i<10;i++)
	{
		for(j=0;j<10;j++)
			a[i][j]=0;
		j=0;
		if(j==1)
			while(i<j)
			{
				j++;
				do
				{
					j=j*29;
				}while(j--);
			}
	}

}
