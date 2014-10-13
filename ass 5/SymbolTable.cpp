#include "SymbolTable.h"
#include "bits/stdc++.h"
using namespace std;
int SymbolTable::tcount=0;


SymbolTable::SymbolTable()
:n(0)
{
}

Fields* SymbolTable::gentemp(SymbolTable &st)
{
	SFields temp;
	char word[20];
	sprintf(word, "%d",tcount++);
	string tword="__t"+string(word);
	st.nameindex[tword]=st.n++;
	temp.name=tword;
	st.table.push_back(temp);
	return &(st.table[st.n-1]);
}

Fields* SymbolTable::lookup(const string &s)
{
	if(nameindex.find(s)!=nameindex.end())
		return &table[nameindex[s]];
	SFields f;
	nameindex[s]=n++;f.name=s;
	table.push_back(f);
	return &table[n-1];
}

void SymbolTable::update(const string &s,const Fields &f)
{
	Fields* fn=lookup(s);
	fn->type=f.type;
	fn->offset=f.offset;
	fn->nestedTable=f.nestedTable;
	fn->val=f.val;
	fn->size=f.size;
}

void SymbolTable::print()
{
	for (int i = 0; i < table.size(); ++i){
		SFields &sf=table[i];
		printf("%d %s %d %s %u %d \n",i, sf.name.c_str(),sf.type,sf.val,sf.size,sf.offset);
	}
}


