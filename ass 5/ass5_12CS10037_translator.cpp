#include "ass5_12CS10037_translator.h"


void backpatch(const ListType &v,int index)
{
	for (int i = 0; i < v.size(); ++i){
		char word[20];
		sprintf(word, "%d",index);
		quadArray[v[i]].setArg1(word);
	}
}




	

	




