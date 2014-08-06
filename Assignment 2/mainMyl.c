#include "myl.h"
#include "stdio.h"
int main()
{	
	float n;
	prints("enter number    ");
	// scanf("%d",&n );
	readf(&n);
	printf("printing--%f\n",n );
	// prints("integer --");
	// printi(n);
	// prints("\nfloating---  ");
	// printd(n);
	prints("\n number is");
	printd(n);
	return 0;
}