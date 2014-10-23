#ifndef _SYMBOL_TABLE_H
#define _SYMBOL_TABLE_H

#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef unsigned long long ull;
typedef pair<int,int> ii;
typedef vector<int> vi;
typedef vector <ii> vii;
typedef pair<long,long> pll;
typedef vector<ll> vll;
typedef vector <pll> vpll;



#define FI(n) for(int i=0;i<n;i++)
#define FI1(n) for(int i=1;i<=n;i++)
#define FJ(n) for(int j=0;j<n;j++)
#define FJ1(n) for(int j=1;j<=n;j++)
#define For(i,a,b) for(int i=a;i<b;i++)
#define tr(c, it)   for(typeof(c.begin()) it = c.begin(); it != c.end(); it++)





using namespace std;

class SymbolTable;
class SFields;
const unsigned int  SIZE_OF_INT=4;
const unsigned int  SIZE_OF_DOUBLE=8;
const unsigned int  SIZE_OF_CHAR=1;
const unsigned int  SIZE_OF_POINTER=4;



enum {
		doubleT=1,
		intT,
		charT,
		pointerT,
		arrayT,
		voidT,
		funcT
};

const int sizeArrayNOD[]={0,SIZE_OF_DOUBLE,SIZE_OF_INT,SIZE_OF_CHAR,SIZE_OF_POINTER};
const string nameSizeArray[]={"","double","int","char","pointer","array"};
typedef std::vector<pair<int, int> > Type;
typedef std::vector<int> ListType;


int getSize(const Type &t);
struct Fields{
	public:
		Type type;
		char* loc;
		unsigned int size;
		int offset;
		SymbolTable* nestedTable;
		string name;
		union Val{
			int intVal;
			double doubleVal;
			char* stringVal;
			char charVal;
		}val;
		bool isConst;
		bool isBoolExp;
		
		ListType tl,fl;
		Fields():type(),loc(NULL),size(4),offset(0),nestedTable(NULL),
				isConst(false),isBoolExp(false)
				{}

		void update(int type1,unsigned int size1,int offset1)
		{
			type.push_back(make_pair(type1, 0));
			size=size1;
			offset=offset1;
		}

		void update(const Type& type1,unsigned int size1,int offset1)
		{
			// printf("updating %s\n",name.c_str() );
			type=type1;
			size=size1;
			offset=offset1;
		}
		void update(Fields* f)
		{
			type=f->type;
			this->size=f->size;
		}
		void print()
		{	
			printf("%s\t%d\t%d\t",name.c_str(),size,offset);
			tr(type, it){
				printf("(%s %d)   ",nameSizeArray[it->first].c_str(),it->second );
			}
			printf("\n");
		}
};



class SFields:public Fields{
	public:

		SFields(const Fields& f)
			:Fields(f)
			{}
		SFields():Fields(){}
};

class SymbolTable{
	map<string,int> nameindex;
	std::vector<SFields> table;
	int n;
public:
	int offset;
	int paramNum;
	SymbolTable();
	Fields* lookup(const string &s);
	static int tcount;
	static Fields* gentemp(SymbolTable &st);
	void print();
	void update(const string &s,const Fields &f);
	void update(Fields* f,const Type& t);
	void update(Fields* f1,Fields* f2);
	void clearTable();
	Fields* search(const string& s);
	std::vector<Fields> getParamList();
};

#endif