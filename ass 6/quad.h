#ifndef _QUAD_H
#define _QUAD_H
#include <bits/stdc++.h>
using namespace std;
namespace quad
{

/*
	These are all macros to be used so that we can know what type of quad it represents

*/
enum{
	QIF=1, //used for simple IF
	QIFFALSE, //used for ifFalse
	QRELIFEQ, // if ==
	QRELIFLT, //if <
	QRELIFGT, // if >
	QRELIFLTE, // if <=
	QRELIFGTE, //if >=
	QRENOTE, //if !=
	QGOTO, //goto


	QARRVAL, //a[x]
	QARRDEREF,//
	QEQ_OP, //==
	QNE_OP, //!=
	QGE_OP, //>=
	QLE_OP, //<=
	QPARAM, //function params
	QCALL, //function call
	QPOINTER,
	QPOINTERDER,
	QADDR,
	QRETURN_NULL,
	QRETURN,
	QFUNC,
	QFUNCEND,
	QCHAR2INT,
	QINT2CHAR,
	QPASS
};

/*
	Quad class to represnt all possible type of quads we wish to emit.
*/
class Quad{
	
public:
	int op; //the operator present in quad
	char* res,*arg1,*arg2; //all of the locations are stored as strings
	int gotoIndex;
	Quad(int op1, char *s1, char *s2, char *s3=0); //for binary operations and unary when s3=0
	Quad(int op1, char *s, int num); //unary operations
	Quad(char* s1,char* s2); //assignment operations
	Quad(int op,int index); //goto labels

	Quad(int op1, const string &s1, const string &s2, const string &s3);
	Quad(int op1,const string &s1,const string &s2);
	Quad(int op1, const string &s, int num);
	Quad(const string & s1,const string & s2);


	inline void setArg1(const string &s){
		this->arg1=strdup(s.c_str());
	}//to set arg1 operand
	inline void setRes(const string &s){
		this->res=strdup(s.c_str());
	}//to set res operand
	static void emit(Quad& q);//prints the current quad accordingly
	
};

}


#endif