#ifndef _SYMBOL_TABLE_H
#define _SYMBOL_TABLE_H

#include <bits/stdc++.h>
using namespace std;

typedef int Type;
class SymbolTable;
class SFields;

struct Fields{
	public:
		Type type;
		char* val;
		unsigned int size;
		int offset;
		SymbolTable* nestedTable;
		Fields():type(0),val(NULL),size(4),offset(0),nestedTable(NULL){}

};



class SFields:public Fields{
	public:
		SFields(const Fields& f){}
		SFields():Fields(){}
		string name;
};

class SymbolTable{


	// std::map<string, SFields> table;
	map<string,int> nameindex;
	std::vector<SFields> table;
	int n;
public:
	SymbolTable();
	Fields* lookup(const string &s);
	static int tcount;
	static Fields* gentemp(SymbolTable &st);
	void print();
	// inline Type getType(const string& s){return table[s].type;}
	// inline char* getValue(const string &s){return table[s].val;}
	// inline unsigned int getSize(const string &s){return table[s].size;}
	// inline int getOffset(const string &s){return table[s].offset;} 
	// inline SymbolTable* getNestedTable(const string &s){return table[s].nestedTable;}
	void update(const string &s,const Fields &f);
};


#endif