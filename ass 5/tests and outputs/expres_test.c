

// testing the file for expressions


int main()
{
	int a=10;

	int i1,i2,i3;

	//unary operators
	i1=a++*++a;

	i1=-i1;


	//binary
	i2=i1%a*a+456+'c';
	i3= i1<<3 + 2>>3;

	double d1,d2,d3;

	d3=d2=d1=i2+i3; //here conversion from int to double takes place

	d2=i2*(34.56+'c')/i2;

	char c1=5;
	c1=d2;//double2char

	//testing relational expressions
	//every relational expression has a value true(1) or false(0)

	int r1,r2,r3,r4;
	r1=i1&&i2; //the value of r1 is 1 if the boolean expression is true else r2=0
	r2= i3<=75&&i3>=6; //there will a goto which is unreachable and not backpatched when
						//evaluating this expression

	r3= 1&&3||1&&2;

	r2=(r1==r3)||(1!=2);

	//teranary operator
	r1=(r2==r3)?i1*2938:i2*34+98.67;

	r1= (1)?2:3;


	//if statement

	

	return 0;
}