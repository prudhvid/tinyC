

int main()
{

	//all basic types
	int i1=5,i2=34,i3=45.67;
	char c1='a';//ASCII value of char is taken in quad
	double d1=3,d2=56.7*9,d3=45.6+9;

	//arrays
	int ia1[100],ia2[100];

	//the shift is represeted as int value in quad
	ia1[0]=i1*i2<<3;

	//pointers I've supported all possible types of pointer and array combination declarations

	// NOTE--> I've not suported pointer arithmetic but using pointers as arrays is supported
	int *x=ia2;

	x[5]=(d1+d3)/i2;

	x=&i2;
	*x=i2;

	//complex types
	int *a[100][200]; //2-D array of int pointers

	a[10][20]=x;

	int (*aa)[100]; //pointer to an integer array of size 100

	int **aa2=aa;


	double da[10][10][10][10];
	double *p1=&da[0][0][0][0],**p2,***p3;

	double (*p4)[10][10][10]=da;
	p3=da[9];
	p2=da[8][8];

	int i,j,k,l;
	for (i = 0; i < 10; ++i){
		for ( j = 0; j < 10; ++j){
			for ( k = 0; k < 10; ++k){
				for ( l = 0; l < 10; ++l){
					da[i][j][k][l]=i1*i2+3;
				}
			}
		}
	}

	return 0;
}