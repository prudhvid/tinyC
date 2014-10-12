#ifndef _TRANSLATOR_H
#define _TRANSLATOR_H 
#include "quad.h"

#include <bits/stdc++.h>

extern Quad *quadArray;

 
using namespace std;
typedef std::vector<int> ListType;

inline ListType makelist(int index){
	return ListType(index,1);
}

inline ListType merge(const vector<int>& v1,const ListType& v2){
	ListType v(v1);
	v.insert(v.begin(), v2.begin(), v2.end());
	return v;
}

void backpatch(const ListType &v,int index);


#endif