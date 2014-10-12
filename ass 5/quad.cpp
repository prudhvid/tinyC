#include "quad.h"
#include <bits/stdc++.h>
#include "y.tab.h"

Quad::Quad(int op1, char *s1, char *s2, char *s3)
:op(op1), res(s1), arg1(s2), arg2(s3) { }


Quad::Quad(int op1, char *s, int num)
:op(op1), res(s), arg1(0), arg2(0)
{
	arg1 = new char[15];arg2=NULL;
	sprintf(arg1, "%d", num);
}

Quad::Quad(char* s1,char* s2)
:op(0),res(s1),arg1(s2),arg2(NULL){}

Quad::Quad(int op,int index)
:op(op)
{
	arg1 = new char[15];arg2=NULL;
	sprintf(arg1, "%d", index);
}


void Quad::emit(const Quad &q){

	if(q.arg2!=NULL&&q.arg1!=NULL){
		//---arithmetic bit logical shift
		switch(q.op){
			case QARRDEREF:printf("%s[%s] = %s\n", q.res,q.arg1,q.arg2);
				break;
			case QARRVAL:printf("%s = %s[%s]\n",q.res,q.arg1,q.arg2 );
				break;
			case QRELIFEQ:printf("if %s %d %s goto %s\n",q.arg1,EQUAL,q.arg2,q.res );
				break;
			case QRENOTE:printf("if %s %d %s goto %s\n",q.arg1,NOTEQUAL,q.arg2,q.res );
				break;
			case QRELIFGT:printf("if %s %d %s goto %s\n",q.arg1,'>',q.arg2,q.res );
				break;
			case QRELIFGTE:printf("if %s %d %s goto %s\n",q.arg1,GTEQUAL,q.arg2,q.res );
				break;
			case QRELIFLT:printf("if %s %d %s goto %s\n",q.arg1,'<',q.arg2,q.res );
				break;
			case QRELIFLTE:printf("if %s %d %s goto %s\n",q.arg1,LTEQUAL,q.arg2,q.res );
				break;
			default:
			printf("%s = %s %d %s\n",q.res,q.arg1,q.op,q.arg2 );
		}
		
			
	}
	else if(q.arg2==NULL&&q.op!=0){

		switch(q.op)
		{
			case QGOTO:printf("goto %s\n", q.arg1);
				break;
			case QIF:printf("if %s goto %s\n",q.arg1,q.res );
				break;
			case QIFFALSE:printf("ifFalse %s goto %s\n",q.arg1,q.res );
				break;
			default:printf("%s = %d %s\n",q.res,q.op,q.arg1 );

		}
			
				
	}
	else
		printf("%s = %s\n",q.res,q.arg1 );
}