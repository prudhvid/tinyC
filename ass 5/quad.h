#ifndef _QUAD_H
#define _QUAD_H
#include <bits/stdc++.h>
using namespace std;
namespace quad
{



enum{
	QIF=1,
	QIFFALSE,
	QRELIFEQ,
	QRELIFLT,
	QRELIFGT,
	QRELIFLTE,
	QRELIFGTE,
	QRENOTE,
	QARRVAL,
	QARRDEREF,
	QGOTO,
	QEQ_OP,
	QNE_OP,
	QGE_OP,
	QLE_OP,
	QPARAM,
	QCALL
};

class Quad{
	int op;
	char* res,*arg1,*arg2;
public:
	Quad(int op1, char *s1, char *s2, char *s3=0);
	Quad(int op1, char *s, int num);
	Quad(char* s1,char* s2);
	Quad(int op,int index);
	void print();
	Quad(int op1, const string &s1, const string &s2, const string &s3);
	Quad(int op1,const string &s1,const string &s2);
	Quad(int op1, const string &s, int num);
	Quad(const string & s1,const string & s2);
	inline void setArg1(const string &s){
		this->arg1=strdup(s.c_str());
	}
	inline void setRes(const string &s){
		this->res=strdup(s.c_str());
	}
	static void emit(const Quad& q);
};

}


#endif