#ifndef _TRANSLATOR_H
#define _TRANSLATOR_H 
#include "quad.h"
#include "SymbolTable.h"
#include <bits/stdc++.h>











extern std::vector<quad::Quad> quadArray;
using namespace std;

class SymbolTable;



typedef std::vector<int> ListType;
/*
	A global function to create a new list containing only index, an index
	into the array of quad’s, and to returns the newly created list.
*/
inline ListType makelist(int index){
	 ListType v;
	 v.push_back(index);
	 return v;
}

/*
	A global function to concatenate two lists v1 v2 and to
	 return the concatenated list.
*/
inline ListType merge(const vector<int>& v1,const ListType& v2){
	ListType v(v1);
	v.insert(v.begin(), v2.begin(), v2.end());
	return v;
}

/*
	A global function to insert index as the target label for each of the
	quad’s on the list in v

*/
void backpatch(ListType &v,int index);

/*
	A global function to check if E1 & E2 have same types
	(that is, if <type of E1> = <type of E2>(E)). 
*/
int typeCheck(Type &E1,Type &E2);
inline int typeCheck(Fields* f1,Fields* f2){
	return typeCheck(f1->type,f2->type);
}




#endif