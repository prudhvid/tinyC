#ifndef _QUAD_H
#define _QUAD_H

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
	QGOTO
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
	void setArg1(char *s);
	static void emit(const Quad& q);
};


#endif