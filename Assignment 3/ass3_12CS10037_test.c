#include "stdio.h"
//Test single line comment
/**
Multiline comment test

*/


int main()
{
	//keywords test
	int i1,x, x10, xX20, Xy10Xyz,sdkj_dn_;
	float f4;
	//non keywords test
	double int32x;
	
	//non identifiers 
	char 10x,auto,id_3;


	//integer constant
	12,13, 0, 00, +87, -1712;

	//floating constant
	12e5, 12e+273, 0.00721, .192, 1234., 0.0

	

	//character constants
	'd','e','dkmd','\a','\b','\"','\''//from given defintion this is a character constant

	//not character constants
	'\',''',


	//string literals
	"kfnvkdfvn", "jn\r\tkxjdn\n" ,"\n", 

	//non string literals
	""",",'""',"\kdnks"


	/*punctuators*/
	[],{},...,->,+,;;

	//non punctuators
	....,",',++++


	return 0;
}