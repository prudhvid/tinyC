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
const int DEFAULT_PAR_NO=10000;

//enum to represnt all types possible
enum {
	doubleT=1,
	intT,
	charT,
	pointerT,
	arrayT,
	voidT,
	funcT
};

//array to store the sizes of types defined in enum above
const int sizeArrayNOD[]={0,SIZE_OF_DOUBLE,SIZE_OF_INT,SIZE_OF_CHAR,SIZE_OF_POINTER};

//array to store the names of types defined in enum above
const string nameSizeArray[]={"","double","int","char","pointer","array"};

/*
	Type is the type that I use to store all possible types that we can have using the above 
	defined enums.

	Each type is represented as an array of two things. 1->the type of type 2->size
	soo 
	int x[30][40] === array(30,array(40,int))
	=== {(arrayT,30),(arrayT,40),(intT,0)}

	int **x[20];

	==={(arrayT,20),(pointerT,2),(intT,0)}
	
*/
typedef std::vector<pair<int, int> > Type;

/*
	ListType is array type to store the indices of quads having dangling gotos
*/
typedef std::vector<int> ListType;

//returns the size of a specific type
int getSize(const Type &t);


/*
	This is the type present in the symbol table as a row.
*/
struct Fields{
	public:
		Type type; //type of symbol present
		char* loc; //loc that it will be stored
		unsigned int size; //size of the element
		int offset; //offset in the symbol table
		SymbolTable* nestedTable; //if it is the global symbolTable then it stores the 
								//symboltable pointer of that function
		string name; //name of the symbol

		//used for constant folding val contains the val of the contant
		union Val{
			int intVal;
			double doubleVal;
			char* stringVal;
			char charVal;
		}val;
		bool isConst; //if the symbol present is actually a constant
		bool isBoolExp; //if it is a boolean expression then t has true list and false lists
		Fields* arrSize; //if type is array, store the size while reducing grammar
		bool isArray;
		bool isPointer;
		Fields* arrayBase;
		int parNum;
		int actOffset;
		ListType tl,fl;//true list and false lists
		Fields():type(),loc(NULL),size(0),offset(0),nestedTable(NULL),
				isConst(false),isBoolExp(false),arrSize(NULL),
				isArray(false),isPointer(false),parNum(DEFAULT_PAR_NO)
				
				{}

		//all posible updates available to change the values in ST using pointers
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
			printf("type=");
			tr(type, it){

				printf("(%s %d)   ",nameSizeArray[it->first].c_str(),it->second );
			}
			printf("\n");
		}
};



class SFields:public Fields{
	public:
		
		SFields():Fields(){}
};


/*
	Class to represetnt the symoltable
*/
class SymbolTable{
	
	/*
		The tabe is stored in form of array where every symbol is mapped to an 
		index in this array
	*/
	public:std::vector<SFields> table;

	/*
		hashmap to store symbolnames to indices in the symboltable
	*/
	map<string,int> nameindex; 
	/*
		number of symbols present 
	*/
	int n; 
	
public:
	/*
		The current offset of ST
	*/
	int offset; 
	int paramNum; //the number of parameters that it has
	int parOff;
	int localOff;
	SymbolTable(); 
	/*
		A method to lookup an id (given its name or lexeme)
		in the Symbol Table. If the id exists, the entry is
		returned, otherwise a new entry is created.
	*/
	Fields* lookup(const string &s); 

	static int tcount;//temporary count
	/*
		A static method to generate a new temporary, insert
		it to the Symbol Table, and return a pointer to the
		entry.
	*/
	static Fields* gentemp(SymbolTable &st);

	/*	
		prints all symbols and their data in tabular form
	*/
	void print();
	/*
		A method to update different fields of an existing
		entry.All are overloaded forms for the same function
	*/
	void update(const string &s,const Fields &f);
	void update(Fields* f,const Type& t);
	void update(Fields* f1,Fields* f2);
	/*
		erase all contents of the current symboltable
	*/
	void clearTable();
	/*
		given a string searches if it is present in symboltable. Unlike 
		lookup it doesnt add the given string to ST if it is not present
	*/
	Fields* search(const string& s);
	/*
		for a ST of function return all the list of params
	*/
	std::vector<Fields> getParamList();


	void activationRecords();
};

#endif