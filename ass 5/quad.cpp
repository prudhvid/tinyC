#include "quad.h"
#include <bits/stdc++.h>
namespace quad

{

Quad::Quad(int op1, char *s1, char *s2, char *s3)
:op(op1), res(strdup(s1)), arg1(strdup(s2)), arg2(strdup(s3)) { }

Quad::Quad(int op1,const string &s1,const string &s2,const string& s3)
{
	op=op1;
	res=strdup(s1.c_str());
	arg1=strdup(s2.c_str());
	arg2=strdup(s3.c_str());
}

Quad::Quad(int op1,const string &s1,const string &s2)
{
	op=op1;
	res=strdup(s1.c_str());
	arg1=strdup(s2.c_str());
	arg2=NULL;
}


Quad::Quad(int op1, char *s, int num)
:op(op1), res(strdup(s)),arg2(NULL)
{
	arg1 = new char[15];
	sprintf(arg1, "%d", num);
}
Quad::Quad(int op1, const string &s, int num){
	Quad(op1,s.c_str(),num);
}

Quad::Quad(char* s1,char* s2)
:op(0),res(strdup(s1)),arg1(strdup(s2)),arg2(NULL){}

Quad::Quad(const string & s1,const string & s2)
:op(0),res(strdup(s1.c_str())),arg1(strdup(s2.c_str())),arg2(NULL)
{
}


Quad::Quad(int op,int index)
:op(op)
{
	res = new char[15];arg1=arg2=NULL;
	sprintf(res, "%d", index);
}


void Quad::emit(const Quad &q){
	if(q.arg2!=NULL&&q.arg1!=NULL){
		//---arithmetic bit logical shift
		switch(q.op){
			case QARRDEREF:printf("%s[%s] = %s\n", q.res,q.arg1,q.arg2);
				break;
			case QARRVAL:printf("%s = %s[%s]\n",q.res,q.arg1,q.arg2 );
				break;
			case QRELIFEQ:printf("if %s = %s goto %s\n",q.arg1,q.arg2,q.res );
				break;
			case QRENOTE:printf("if %s != %s goto %s\n",q.arg1,q.arg2,q.res );
				break;
			case QRELIFGT:printf("if %s %c %s goto %s\n",q.arg1,'>',q.arg2,q.res );
				break;
			case QRELIFGTE:printf("if %s >= %s goto %s\n",q.arg1,q.arg2,q.res );
				break;
			case QRELIFLT:printf("if %s %c %s goto %s\n",q.arg1,'<',q.arg2,q.res );
				break;
			case QRELIFLTE:printf("if %s <= %s goto %s\n",q.arg1,q.arg2,q.res );
				break;

			case QCALL:printf("%s=call %s,%s\n",q.res,q.arg1,q.arg2 );
				break;
			default:
			if(q.op<=255)
				printf("%s = %s %c %s\n",q.res,q.arg1,q.op,q.arg2 );
			else{
				if(q.op==267)
					printf("%s = %s << %s\n",q.res,q.arg1,q.arg2 );
				else if(q.op==268)
					printf("%s = %s >> %s\n",q.res,q.arg1,q.arg2 );
				else
					printf("%s = %s %d %s\n",q.res,q.arg1,q.op,q.arg2 );
			}
				
		}
		
			
	}
	else if(q.arg2==NULL&&q.op!=0){

		switch(q.op)
		{
			case QGOTO:printf("goto %s\n", q.res);
				break;
			case QIF:printf("if %s goto %s\n",q.arg1,q.res );
				break;
			case QIFFALSE:printf("ifFalse %s goto %s\n",q.arg1,q.res );
				break;
			case QPARAM:printf("param %s\n",q.res );
				break;
			case QPOINTER:printf("%s=*%s\n",q.res,q.arg1 );
				break;
			case QPOINTERDER:printf("*%s=%s\n",q.res,q.arg1);
				break;
			case QADDR:printf("%s=&%s\n",q.res,q.arg1 );
				break;
			case QRETURN:printf("return %s\n",q.res);
				break;
			case QRETURN_NULL:printf("return\n");
				break;

			default:
			if(q.op<=255)
				printf("%s = %c %s\n",q.res,q.op,q.arg1 );
			else
				printf("%s = %d %s\n",q.res,q.op,q.arg1 );

		}
			
				
	}
	else
		printf("%s = %s\n",q.res,q.arg1 );
}

}//end of quad namespace