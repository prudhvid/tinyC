#ifndef _TRANSLATOR_H
#define _TRANSLATOR_H 
#include "quad.h"
#include "SymbolTable.h"
#include <bits/stdc++.h>











extern std::vector<quad::Quad> quadArray;
using namespace std;

class SymbolTable;



typedef std::vector<int> ListType;

inline ListType makelist(int index){
	 ListType v;
	 v.push_back(index);
	 return v;
}

inline ListType merge(const vector<int>& v1,const ListType& v2){
	ListType v(v1);
	v.insert(v.begin(), v2.begin(), v2.end());
	return v;
}

void backpatch(const ListType &v,int index);

int typeCheck(Type &E1,Type &E2);
inline int typeCheck(Fields* f1,Fields* f2){
	return typeCheck(f1->type,f2->type);
}



void convInt2Bool();
#endif