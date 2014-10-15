#ifndef _SYMBOL_TABLE_H
#define _SYMBOL_TABLE_H

#include <bits/stdc++.h>
using namespace std;


class SymbolTable;
class SFields;
const unsigned int  SIZE_OF_INT=4;
const unsigned int  SIZE_OF_DOUBLE=8;
const unsigned int  SIZE_OF_CHAR=1;



enum {
		intT=1,
		charT,
		doubleT,
		voidT
};



union Type{
	int pre;
	int ARRAY[100];
	int POINTER[100];
};


struct Fields{
	public:
		Type type;
		char* loc;
		unsigned int size;
		int offset;
		SymbolTable* nestedTable;
		string name;
		Fields():type(),loc(NULL),size(4),offset(0),nestedTable(NULL){}

		void update(int type1,unsigned int size1,int offset1)
		{
			type.pre =type1;
			size=size1;
			offset=offset1;
		}

		void update(Type& type1,unsigned int size1,int offset1)
		{
			type=type;
			size=size1;
			offset=offset1;
		}
		void update(const Fields* f)
		{
			type=f->type;
			this->size=f->size;
		}
};



class SFields:public Fields{
	public:
		SFields(const Fields& f){}
		SFields():Fields(){}
};

class SymbolTable{


	// std::map<string, SFields> table;
	map<string,int> nameindex;
	std::vector<SFields> table;
	int n;
public:
	int offset;
	SymbolTable();
	Fields* lookup(const string &s);
	static int tcount;
	static Fields* gentemp(SymbolTable &st);
	void print();
	// inline Type getType(const string& s){return table[s].type;}
	// inline char* getlocue(const string &s){return table[s].loc;}
	// inline unsigned int getSize(const string &s){return table[s].size;}
	// inline int getOffset(const string &s){return table[s].offset;} 
	// inline SymbolTable* getNestedTable(const string &s){return table[s].nestedTable;}
	void update(const string &s,const Fields &f);
};


#endif