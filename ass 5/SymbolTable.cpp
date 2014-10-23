#include "SymbolTable.h"
#include "bits/stdc++.h"
using namespace std;

int SymbolTable::tcount=0;

bool sortCompare(const SFields &s1,const SFields& s2)
{
	if(s1.offset<=s2.offset)
		return true;
	return false;
}

SymbolTable::SymbolTable()
:n(0),offset(0),paramNum(0)
{
	nameindex.clear();
	table.clear();
	table.reserve(100);
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
	{
		Fields *f=&table[nameindex[s]];
		return f;
	}
		
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
	fn->loc=f.loc;
	fn->size=f.size;

	offset+=f.size;
}

void SymbolTable::print()
{
	
	
	printf("\n--------------------SymbolTable---------------------------\n");
	printf("no of params=%d\n",paramNum );
	std::vector<SFields> temp(table.begin(), table.end());
	sort(temp.begin(), temp.end(),sortCompare);
	int c=1;
	tr(temp,it)	{
		printf("%d\t%s\t%d\t%d\t",c, it->name.c_str(),it->size,it->offset);
		For(i, 0, it->type.size()){
			printf("(%s %d)  ",nameSizeArray[it->type[i].first].c_str(),
								 it->type[i].second );
		}
		printf("\n");
		c++;

	}	
	printf("-----------------------------------------------------------\n");

	
}

void SymbolTable::update(Fields* f,const Type& t)
{
	if(f==NULL)
		throw "error in update function";
	f->type=t;
	f->size=getSize(t);
	f->offset=offset;
	offset+=f->size;
}

void SymbolTable::update(Fields* f1,Fields* f2)
{
	if(f1==NULL||f2==NULL)
		throw "error in update function";
	f1->type=f2->type;
	f1->size=f2->size;
	f1->offset=offset;
	offset+=f2->size;
}

void SymbolTable::clearTable()
{
	this->nameindex.clear();
	this->table.clear();
	this->n=0;
	this->offset=0;
}

Fields* SymbolTable::search(const string& s)
{
	if(nameindex.find(s)!=nameindex.end())
	{
		return &table[nameindex[s]];
	}
	return NULL;
}
std::vector<Fields> SymbolTable::getParamList()
{
	std::vector<SFields> temp(table.begin(), table.end());
	sort(temp.begin(), temp.end(),sortCompare);
	if(paramNum>0)
		return std::vector<Fields>(temp.begin(),temp.begin()+paramNum);
	std::vector<Fields> v;
	return v;
}	

int getSize(const Type &t)
{
	int val=0;
	int vsize=t.size();
	if(t[0].first==pointerT)
		return SIZE_OF_POINTER;


	for (int i = vsize-1; i >=0 ; --i){
		int ff=t[i].first,ss=t[i].second;
		switch(ff){
			case intT:
			case charT:
			case doubleT:
				val+=sizeArrayNOD[ff];
				break;
			case arrayT:
				val=val*ss;	
				break;
			case pointerT:
				val=4;
		}			
	}
	return val;
}













// void solve()
// {
    
// }





// int main()
// {
	
//    	freopen("input", "r", stdin);
	
//     SymbolTable st;
//     int tc=10;
//     S(tc);
//     for (int i = 0; i < tc; ++i){
//     	INS(x);
//     	string word;
//     	if(x){
//     		cin>>word;
//     		st.lookup(word);
//     	}
    		
//     	else
//     		SymbolTable::gentemp(st);
//     }
//     st.print();
// 	return 0;
// }