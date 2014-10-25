#include "ass5_12CS10037_translator.h"


void backpatch(ListType &v,int index)
{
	char word[20];
	sprintf(word, "%d",index);
	for (int i = 0; i < v.size(); ++i){	
		quadArray[v[i]].setRes(word);
	}
	v.clear();
}



int typeCheck(Type &t1,Type &t2)
{
	// int x=E1[0].first,y=E2[0].first;
	// if(x==y){
	// 	if(x>=intT&&x<=voidT)
	// 		return true;
	// 	else if(x==arrayT){
	// 		int l1=E1.array.size(),l2=E2.array.size();
	// 		if(l1!=l2)
	// 			return false;
	// 		for (int i = 1; i < l1; ++i){
	// 			if(E1.array[i]!=E2.array[i])
	// 				return false;
	// 		}
	// 	}
	// 	else if(x==pointerT)
	// 	{
	// 		int l1=E1.pointer.size(),l2=E2.pointer.size();
	// 		if(l1!=l2)
	// 			return false;
	// 		for (int i = 1; i < l1; ++i){
	// 			if(E1.pointer[i]!=E2.pointer[i])
	// 				return false;
	// 		}
	// 	}
	// }
	if(t1.size()!=t2.size())
		return false;
	int s=t1.size();
	for (int i = 0; i<s; ++i){
		ii one=t1[i], two=t2[i];
		if(one.first!=two.first)
			return false;
		if(one.first==two.first&&one.first<=charT)
			continue;
		else 
			if(one.second!=two.second)
				return false;
	}

	return true;
}




	
