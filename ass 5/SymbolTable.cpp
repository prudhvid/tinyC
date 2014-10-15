#include "SymbolTable.h"
#include "bits/stdc++.h"
using namespace std;
int SymbolTable::tcount=0;


SymbolTable::SymbolTable()
:n(0),offset(0)
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
	fn->loc=f.loc;
	fn->size=f.size;

	offset+=f.size;
}

void SymbolTable::print()
{
	for (int i = 0; i < table.size(); ++i){
		SFields &sf=table[i];
		printf("%d %s %d %s %u %d \n",i, sf.name.c_str(),sf.type.pre,sf.loc,sf.size,sf.offset);
	}
}


// #include <bits/stdc++.h>
// #define gc getchar
// #define MALLOC(name,type,n) (name=(type*)malloc(sizeof(type)*(n)))
// using namespace std;
// const int INF=123456789;
// #define ESP (1e-9)


// typedef long long ll;
// typedef unsigned long long ull;
// typedef pair<int,int> ii;
// typedef vector<int> vi;
// typedef vector <ii> vii;
// typedef pair<long,long> pll;
// typedef vector<ll> vll;
// typedef vector <pll> vpll;



// #define FI(n) for(int i=0;i<n;i++)
// #define FI1(n) for(int i=1;i<=n;i++)
// #define FJ(n) for(int j=0;j<n;j++)
// #define FJ1(n) for(int j=1;j<=n;j++)
// #define For(i,a,b) for(int i=a;i<b;i++)
// #define tr(c, it)   for(typeof(c.begin()) it = c.begin(); it != c.end(); it++)



// template<class T>
// void scanint(T &x)
// {
//     register int c = gc();
//     x = 0;
//     int m=0;
//     if(c=='-')
//     	m=1;
//     for(;(c<48 || c>57);c = gc());
//     for(;c>47 && c<58;c = gc()) {x = (x<<1) + (x<<3) + c - 48;}
//     if(m==1)
//     	x*=-1;
// }

// //input macros
// #define S(n)        (scanint(n))
// #define S2(a,b)     scanint(a);scanint(b)
// #define Sc(n)       (n=getchar())            
// #define Sf(n)       scanf("%lf",&n)
// #define Sf2(a,b)    scanf("%lf%lf",&a,&b)
// #define INS(n) int n;S(n);
// #define INS2(n,m) int n,m;S2(n,m);


// //output macros
// #define Pr(n)                       printf("%d ",n)
// #define Prn(n)                      printf("%d\n",n)
// #define Prc(n)                      printf("%c",n)
// #define Prcn(n)                     printf("%c\n",n)
// #define Prl(n)                      printf("%I64d ",n)
// #define Prln(n)                     printf("%I64d\n",n)
// #define Prf(n)                      printf("%lf ",n)
// #define Prfn(n)                     printf("%lf\n",n)
// #define Prs(n)                      printf("%s ",n)
// #define Prsn(n)                     printf("%s\n",n)



// //useful functions
















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