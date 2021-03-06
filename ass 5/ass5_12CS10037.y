%{
	#include <bits/stdc++.h>
	#include <string.h>
	#include <iostream>
	#include "stdio.h"
	#include "ass5_12CS10037_translator.h"
	struct Fields;
	extern int yylex();
	extern void yyerror(char *s);
	/*	
		All the quads will be stored and pushed to this vector.
		All of them will be printed at once in the end
	*/
	std::vector<quad::Quad> quadArray;
	/*
		It is the temporary symbol table to which names go into when scope is unknown
	*/
	SymbolTable* _TEMPST=new SymbolTable();
	/*	
		st points to the current symbol table we're adding to
	*/
	SymbolTable* st=_TEMPST;
	/*	
	pointer to the global symbol table that has all the function names
	*/
	extern SymbolTable* _GLOBST;
	
	extern char* yytext;
	using namespace quad;
	/*
		generates a tempory variable in symboltable
	*/
	inline void GENTEMP(Fields* &f){ f=SymbolTable::gentemp(*st);}

	/*
		Update functions has all overloads 
		update does the following
			with the type specified, get the size of the symbol and initailize its offset
	*/

	inline void UPDATE(Fields* f){
		st->update(f,f->type);
	} 
	inline void UPDATE(Fields* f,Type& t){
		st->update(f,t);
	} 
	inline void UPDATE(Fields* f1,Fields* f2){
		st->update(f1,f2);
	} 

	/*	
		It provides the index of next emmited quad
	*/
	inline int nextInst(){
		return quadArray.size();
	}
	/*	
	Emit the last added quad
	*/
	inline void EMIT(){
		Quad::emit(quadArray[(int)quadArray.size()-1]);
	}
	/*
	explained at definition
	*/
	Fields* checkTypesNAssign(Fields* f1,Fields* f2);
	/*
	explained at definition
	*/
	inline void getValueNBackpatch(Fields* f);
	/*
		It stores the type so that all idenitifiers declared using , operator
		will be assigned with this type at the end
	*/
	int _GLOBALTYPE;
	/*
	explained at definition
	*/
	Fields* changeTypeNEmit(Fields* f1,Fields* f2,int op);
	/*
	explained at definition
	*/
	pair<Fields*,Fields*> changeTypeNReturn(Fields* f1,Fields* f2);
	/*
	explained at definition
	*/
	void int2Bool(Fields* f);
	/*
		If function return value is found then it is set to 1
	*/
	int funcRetSet=0;
	/*
		stores the return type of current function
	*/
	Type funcRetType;
%}

%union{
	Fields* sentry;
	Type *type;
	int intval;
	struct Int_pair{
		int first,second;
	}int_pair;
	ListType* listType;
	vector<Fields*>* sentryList;
}

%token IDENTIFIER STRING_LITERAL SIZEOF INTEGER_CONSTANT FLOATING_CONSTANT CHARACTER_CONSTANT
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID BOOL COMPLEX IMAGINARY RESTRICT
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit




/*
	sentry--> pointer to a field in ST
*/
%type <sentry> id_parser CONSTANT STRING_LITERAL 
%type <sentry> primary_expression postfix_expression unary_expression cast_expression multiplicative_expression additive_expression shift_expression
%type <sentry> relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression
%type <sentry> expression  initializer init_declarator direct_declarator declarator logical_or_expression
	logical_and_expression conditional_expression assignment_expression constant_expression changeBoolTemp  boolExpression
	boolExpressionStatement function_definition array_expression

%type <intval> type_specifier declaration_specifiers unary_operator
%type <int_pair> pointer
/*
	sentryList-->list of pointers to  fields in ST
*/
%type <sentryList> identifier_list  parameter_list argument_expression_list
%type <intval> MIndex relop

/*
	This is the type to store indices of dangling gotos in quads
*/
%type <listType> NList statement compound_statement expression_statement 
			selection_statement iteration_statement block_item block_item_list
			
%nonassoc HIGH_PREC

%%



declaration
	: declaration_specifiers ';' 
	| declaration_specifiers init_declarator_list ';'
	{
	}
	;

declaration_specifiers
	: type_specifier {$$=$1;}
	;

init_declarator_list
	: init_declarator
	{
		
	}
	| init_declarator_list ',' init_declarator
	{
		
	}
	;

init_declarator
	: declarator
	{
		$$=$1;
		$$->type.push_back(ii(_GLOBALTYPE,0));
		UPDATE($$);

	}
	| declarator '=' initializer
	{
		$$=$1;
		$$->type.push_back(ii(_GLOBALTYPE,0));
		UPDATE($$);
		Fields* f=checkTypesNAssign($$,$3);

		if($3->isBoolExp){
			backpatch($3->tl,nextInst());
			quadArray.push_back(Quad($1->name,"1"));
			quadArray.push_back(Quad(QGOTO,nextInst()+2));
			backpatch($3->fl,nextInst());
			quadArray.push_back(Quad($1->name,"0"));
		}
		else 
			quadArray.push_back(Quad($1->name,f->name));
		$$=$1;
	}
	;



type_specifier
	: VOID {_GLOBALTYPE=voidT;$$=voidT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| CHAR {_GLOBALTYPE=charT;$$=charT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| INT {_GLOBALTYPE=intT;$$=intT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| DOUBLE {_GLOBALTYPE=doubleT;$$=doubleT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| SIGNED {_GLOBALTYPE=intT;$$=intT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| UNSIGNED {_GLOBALTYPE=intT;$$=intT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| COMPLEX {_GLOBALTYPE=intT;$$=intT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	| IMAGINARY {_GLOBALTYPE=intT;$$=intT;funcRetSet=(funcRetSet==0)?$$:funcRetSet;}
	;



specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	;





declarator
	: pointer direct_declarator
	{
		$$=$2;
		for(int i=0;i<$1.second;i++)
			$$->type.push_back(ii(pointerT,0));
	}
	| direct_declarator
	{
		$$=$1;
	}
	;

direct_declarator
	: id_parser {
		$$=$1;
	}
	| '(' declarator ')' 
	{
		$$=$2;
	}
	| direct_declarator '[' assignment_expression ']'
	{
		$$=$1;
		int x=$3->val.intVal;
		$$->type.push_back(ii(arrayT,x));
	}
	| direct_declarator '(' parameter_type_list ')' 
	{
		funcRetType=$1->type;
		funcRetType.push_back(ii(funcRetSet,0));
		Fields* f=_GLOBST->lookup($1->name);
		UPDATE(f,funcRetType);
		f->nestedTable=st;
	}
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	{
		st=new SymbolTable();
		funcRetType=$1->type;
		funcRetType.push_back(ii(funcRetSet,0));
		Fields* f=_GLOBST->lookup($1->name);
		UPDATE(f,funcRetType);
		f->nestedTable=st;
	}
	;



pointer
	: '*' 
	{
		$$.first=pointerT;
		$$.second=1;
	}
	| '*' pointer 
	{
		$$=$2;
		$$.second++;
	}
	;



parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;

parameter_list
	: declaration_specifiers declarator
	{
		SFields f1=*$2;
		st=new SymbolTable();
		Fields *f=st->lookup(f1.name);
		int s=f1.type.size();
		f->type=f1.type;
		f->type.push_back(ii($1,0));
		f->parNum=st->paramNum;
		UPDATE(f);
		st->paramNum++;
	}
	| parameter_list ',' declaration_specifiers declarator
	{
		$4->type.push_back(ii($3,0));
		UPDATE($4);
		$4->parNum=st->paramNum;
		st->paramNum++;
	}
	;


identifier_list
	: id_parser
	{
		$$=new vector<Fields*>();
		$$->push_back($1);
	}
	| identifier_list ',' id_parser 
	{
		$$=$1;
		$$->push_back($3);
	}
	;

type_name
	: specifier_qualifier_list
	;




initializer
	: assignment_expression
	{
		$$=$1;
	}
	;














/*
	this is to emit a goto while reducing and maintiain the index of
	that quad in the list it has as attribute
*/
NList
	: %prec HIGH_PREC
	{	
		$$=new vi();
		$$->push_back(nextInst());
		quadArray.push_back(Quad(QGOTO,"...",0));
	 }
	;

/*
Index of the quad generated at MIndex will be stored when reducing this.
this is used for backpatching
*/
MIndex
	:{$$=nextInst();}
	;





statement
	: compound_statement {$$=$1;}
	| expression_statement{$$=$1;}
	| selection_statement {$$=$1;}
	| iteration_statement 
	{
		$$=$1;
		
	}
	| jump_statement {$$=new vi();}
	;


compound_statement
	: '{' '}' {$$=new vi();}
	| '{' block_item_list '}' {$$=$2;}
	;

block_item_list
	: block_item 
	{
		*$$=merge(*$$,*$1);
	}
	| block_item_list MIndex block_item
	{
		backpatch(*$1,$2);
		$$=$3;
	}
	;

block_item
	: declaration {$$=new vi();}
	| statement{
		$$=$1;
	}
	;


expression_statement
	: ';' {$$=new vi();}
	| expression ';' 
	{
		if($1->isBoolExp){
			$$=&($1->fl);
		}
		else
			$$=new vi();
	}
	;

selection_statement
	:IF '(' boolExpression ')' MIndex statement  %prec "then"
	{
		backpatch($3->tl,$5);
		$$=$6;
   	 	*$$=merge($3->fl,*$$);
   	}
	| IF '(' boolExpression ')' MIndex statement NList ELSE MIndex statement 
	{
		$$=$10;
		backpatch($3->tl,$5);
		backpatch($3->fl,$9);
		vi temp=merge(*$6,*$7);
		*$$=merge(temp,*$10);
	}
	;

iteration_statement
	: WHILE '(' MIndex boolExpression ')' MIndex statement 
	{
		$$=new vi();
		backpatch(*$7,$3);
		backpatch($4->tl,$6);
		*$$=$4->fl;
		quadArray.push_back((Quad(QGOTO,$3)));
	}
	| DO MIndex statement WHILE '('MIndex boolExpression ')' ';' 
	{
		$$=new vi();
		*$$=$7->fl;
		backpatch($7->tl,$2);
		backpatch(*$3,$6);
	}
	
	| FOR '(' expression_statement MIndex boolExpressionStatement
		MIndex expression NList ')' MIndex	statement
	{
		backpatch($5->tl,$10);
		$$=new vi();
		backpatch(*$11,nextInst());
		quadArray.push_back(Quad(QGOTO,$6));
		backpatch(*$8,$4);
		*$$=$5->fl;
	}
	| FOR '(' expression_statement MIndex boolExpressionStatement ')'
			 MIndex statement
	{
		backpatch(*$8,$4);
		quadArray.push_back(Quad(QGOTO,$4));
		backpatch($5->tl,$7);
		$$=new vi();
		*$$=$5->fl;
	}

	;

jump_statement
	: RETURN ';' 
	{
		if(funcRetType.size()>0&&funcRetType[0].first==voidT)
			quadArray.push_back(Quad(QRETURN_NULL,0));
		else
			throw "return type not same";
	}
	| RETURN expression ';' 
	{
		Fields*f;GENTEMP(f);f->type=funcRetType;UPDATE(f);
		f= checkTypesNAssign(f,$2);
		quadArray.push_back(Quad(QRETURN,f->name,""));
	}
	;



boolExpressionStatement
	: ';' 
	{
		GENTEMP($$);
		$$->isBoolExp=true;
		$$->tl=makelist(nextInst());
		quadArray.push_back((Quad(QGOTO,"...",0)));
		$$->fl=makelist(nextInst());
		quadArray.push_back((Quad(QGOTO,"...",0)));
	}
	| boolExpression ';' {$$=$1;}
	;
boolExpression
	:expression
	{
		if($1->isBoolExp==false)
			int2Bool($1);
		$$->isBoolExp=true;
		$$=$1;
	}
	;
translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition {}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	{
		$$=_GLOBST->lookup($2->name);
		$$->type=$2->type;
		$$->type.push_back(ii($1,0));
		_GLOBST->update($$,$$->type);
		$$->nestedTable=st;
		printf("\n\n\tSymbolTable of function %s",$2->name.c_str());
		st->print();
		_TEMPST->clearTable();
		st=_TEMPST;
		backpatch(*$4,nextInst());
		//adds a default return at the end of every function
		quadArray.push_back(Quad(QRETURN_NULL,0));
		funcRetType.clear();
		funcRetSet=0;
		
	}
	| declaration_specifiers declarator compound_statement
	{
		$$=_GLOBST->lookup($2->name);
		$$->type=$2->type;
		$$->type.push_back(ii($1,0));
		_GLOBST->update($$,$$->type);
		$$->nestedTable=st;
		printf("\n\n\tSymbolTable of function %s",$2->name.c_str());
		st->print();
		_TEMPST->clearTable();
		st=_TEMPST;
		backpatch(*$3,nextInst());
		//adds a default return at the end of every function
		quadArray.push_back(Quad(QRETURN_NULL,0)); 
		funcRetType.clear();
		funcRetSet=0;
	}
	;

declaration_list
	: declaration
	| declaration_list declaration
	;








































primary_expression
	: id_parser { $$=$1;}
	| CONSTANT {$$=$1;}
	| STRING_LITERAL
		{

		}
	| '(' expression ')'
		{
			$$=$2;
		}
	;


	array_expression
		:primary_expression '[' expression ']'
		{
			if($$->type[0].first!=arrayT&&$$->type[0].first!=pointerT)
				throw "not an arrayT and pointerT";
			GENTEMP($$);
			$$->isArray=true;
			vii temp($1->type.begin()+1,$1->type.end());
			int s=getSize(temp);
			$$->type=temp;
			UPDATE($$);

			char word[50];
			sprintf(word,"%d",s);
			Fields *&f1=$$->arrSize;
			GENTEMP(f1);
			f1->type.push_back(ii(intT,0));
			UPDATE(f1);

			quadArray.push_back(Quad('*',f1->name,$3->name,word));
			$$->arrayBase=$1;
		}
		| array_expression '[' expression ']'
		{
			if($$->type[0].first!=arrayT&&$$->type[0].first!=pointerT)
				throw "not an arrayT and pointerT";
			GENTEMP($$);
			$$->isArray=true;
			vii temp($1->type.begin()+1,$1->type.end());
			int s=getSize(temp);
			$$->type=temp;
			UPDATE($$);

			char word[50];sprintf(word,"%d",s);
			Fields *f1;
			GENTEMP(f1);
			GENTEMP($$->arrSize);
			$$->arrSize->type=$1->arrSize->type;
			UPDATE($$->arrSize);

			f1->type.push_back(ii(intT,0));
			UPDATE(f1);

			quadArray.push_back(Quad('*',f1->name,$3->name,word));
			$$->arrayBase=$1->arrayBase;

			quadArray.push_back(Quad('+',$$->arrSize->name,
						$1->arrSize->name,f1->name));
		}	
		;

postfix_expression
	: primary_expression {$$=$1;}
	|array_expression
	{
		GENTEMP($$);
		$$->type=$1->type;
		$$->isArray=true;
		$$->arrayBase=$1->arrayBase;
		$$->arrSize=$1->arrSize;
		UPDATE($$);
		quadArray.push_back(Quad(QARRVAL,$$->name,$1->arrayBase->name,
								$1->arrSize->name));
	}
	| postfix_expression '(' ')' 
	{
		Fields* f=_GLOBST->search($1->name);
		if(f==NULL)
			throw "no function found with that name";
		vector<Fields> v=f->nestedTable->getParamList();
		if(v.size()!=0)
			throw "no arguments given";
		GENTEMP($$);
		$$->type=f->type;
		UPDATE($$);
		quadArray.push_back(Quad(QCALL,$$->name,$1->name,"0"));
	}
	| postfix_expression '(' argument_expression_list ')'
	{
		Fields* f=_GLOBST->search($1->name);
		if(f==NULL)
			throw "no function found with that name";
		vector<Fields> v=f->nestedTable->getParamList();
		if(v.size()!=$3->size())
			throw "number of arguments not matching";

		vector<Quad> quadTemp;
		For(i,0,v.size())
		{
			//int check=typeCheck(v[i].type,$3->at(i)->type);
			//if(check==0)
			//	throw "argument type not matching to call";

			Fields*f= checkTypesNAssign(&v[i],($3->at(i)));
			quadTemp.push_back(Quad(QPARAM,f->name,""));
		}
		quadArray.insert(quadArray.end(),quadTemp.begin(),quadTemp.end());
		GENTEMP($$);
		$$->type=f->type;
		UPDATE($$);
		char word[20];
		sprintf(word,"%ld",v.size());
		quadArray.push_back(Quad(QCALL,$$->name,$1->name,word));
	}
	| postfix_expression INC_OP
	{
		GENTEMP($$);
		$$->type=$1->type;
		UPDATE($$);
		quadArray.push_back(Quad($$->name,$1->name));
		quadArray.push_back(Quad('+',$1->name,$1->name,"1"));
	}
	| postfix_expression DEC_OP
	{
		GENTEMP($$);
		$$->type=$1->type;
		UPDATE($$);
		quadArray.push_back(Quad($$->name,$1->name));
		quadArray.push_back(Quad('-',$1->name,$1->name,"1"));
	}
	;

argument_expression_list
	: assignment_expression 
	{
		$$=new vector<Fields*>();
		$$->push_back($1);
	}
	| argument_expression_list ',' assignment_expression
	{
		$$=$1;
		$$->push_back($3);
	}
	;

unary_expression
	: postfix_expression {$$=$1;}
	| INC_OP unary_expression 
		{
			GENTEMP($$);
			UPDATE($$,$2);
			quadArray.push_back(Quad('+',$2->name,$2->name,"1"));
			quadArray.push_back((Quad($$->name,$2->name)));


		}
	| DEC_OP unary_expression
		{
			GENTEMP($$);UPDATE($$,$2);
			quadArray.push_back(Quad('-',$2->name,$2->name,"1"));
			quadArray.push_back((Quad($$->name,$2->name)));
		}
	| unary_operator cast_expression
	{
		GENTEMP($$);
		switch($1)
		{
			case '+':
			case '-':
			case '~':
				UPDATE($$,$2);
				quadArray.push_back(Quad($1,$$->name,
											$2->name));
				break;
			case '*':
			{
				if($2->type[0].first!=pointerT&&$2->type[0].first!=arrayT)
					throw "not a pointer";
				vii temp($2->type.begin()+1,$2->type.end());
				$$->type=temp;
				UPDATE($$);
				$$->isPointer=true;
				$$->arrayBase=$2;
				quadArray.push_back(Quad(QPOINTER,$$->name,$2->name));
				break;
			}
			case '&':
				if($2->type.size()>0&&$2->type[0].first==pointerT){
					$$->type=$2->type;
					$$->type.push_back(ii(pointerT,0));
				}
				else {
					$$->type.push_back(ii(pointerT,0));
					$$->type.insert($$->type.end(),$2->type.begin(),
									$2->type.end());
				}
					
				UPDATE($$);
				quadArray.push_back(Quad(QADDR,$$->name,$2->name));
				break;
			default:
				throw "error in processing unary operators";
		}
	}
	| '!' changeBoolTemp
	{
		GENTEMP($$);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		$$->isBoolExp=true;
		$$->tl=$2->fl;
		$$->fl=$2->tl;
		getValueNBackpatch($$);
	}

	;

unary_operator
	: '&' %prec UAND {$$=yytext[0];}
	| '*' %prec USTAR  {$$=yytext[0];}	
	| '+' %prec UPLUS {$$=yytext[0];}
	| '-' %prec UMINUS {$$=yytext[0];}
	| '~'  {$$=yytext[0];}
	;

cast_expression
	: unary_expression{$$=$1;}
	| '(' type_name ')' cast_expression {$$=$4;}
	;

multiplicative_expression
	: cast_expression %prec LEAST_PREC
	{
		$$=$1;
	}
	| multiplicative_expression '*' cast_expression 
	{
		$$=changeTypeNEmit($1,$3,'*');
	}
	| multiplicative_expression '/' cast_expression
	{
		$$=changeTypeNEmit($1,$3,'/');
	}
	| multiplicative_expression '%' cast_expression
	{
		$$=changeTypeNEmit($1,$3,'%');
	}
	;

additive_expression
	: multiplicative_expression
	{
		$$=$1;
	}
	| additive_expression '+' multiplicative_expression
	{
		$$=changeTypeNEmit($1,$3,'+');
	}
	| additive_expression '-' multiplicative_expression
	{
		$$=changeTypeNEmit($1,$3,'-');
	}
	;

shift_expression
	: additive_expression
	{
		$$=$1;
	}
	| shift_expression LEFT_OP additive_expression
	{
		$$=changeTypeNEmit($1,$3,LEFT_OP);
	}
	| shift_expression RIGHT_OP additive_expression
	{
		$$=changeTypeNEmit($1,$3,RIGHT_OP);
	}
	;

relational_expression
	: shift_expression
	{
		$$=$1;
	}
	| relational_expression relop shift_expression
	{
		GENTEMP($$);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		pair<Fields*,Fields*> p=changeTypeNReturn($1,$3);
		$$->tl=makelist(nextInst());
		switch($2)
		{
			case '<':
				quadArray.push_back(Quad(QRELIFLT,"...",
						p.first->name,p.second->name));
				break;
			case '>':
				quadArray.push_back(Quad(QRELIFGT,"...",
						p.first->name,p.second->name));
				break;
			case LE_OP:
				quadArray.push_back(Quad(QRELIFLTE,"...",
						p.first->name,p.second->name));
				break;
			case GE_OP:
				quadArray.push_back(Quad(QRELIFGTE,"...",
						p.first->name,p.second->name));
				break;
		}
		$$->fl=makelist(nextInst());
		quadArray.push_back(Quad(QGOTO,"...",0));
		$$->isBoolExp=true;

		getValueNBackpatch($$);

	}
	;
relop
	:'<' {$$='<';}
	| '>' {$$='>';}
	| LE_OP {$$=LE_OP;}
	| GE_OP {$$=GE_OP;}
	;
equality_expression
	: relational_expression
	{
		$$=$1;
	}
	| equality_expression EQ_OP relational_expression
	{
		GENTEMP($$);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		pair<Fields*,Fields*> p=changeTypeNReturn($1,$3);
		$$->tl=makelist(nextInst());

		quadArray.push_back(Quad(QRELIFEQ,"...",
						p.first->name,p.second->name));

		$$->fl=makelist(nextInst());
		quadArray.push_back(Quad(QGOTO,"...",0));
		$$->isBoolExp=true;
		getValueNBackpatch($$);
	}
	| equality_expression NE_OP relational_expression
	{
		GENTEMP($$);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		pair<Fields*,Fields*> p=changeTypeNReturn($1,$3);
		$$->tl=makelist(nextInst());

		quadArray.push_back(Quad(QRENOTE,"...",
						p.first->name,p.second->name));

		$$->fl=makelist(nextInst());
		quadArray.push_back(Quad(QGOTO,"...",0));
		$$->isBoolExp=true;
		getValueNBackpatch($$);
	}
	;

and_expression
	: equality_expression
	{
		$$=$1;
	}
	| and_expression '&' equality_expression
	{
		$$=changeTypeNEmit($1,$3,'&');
	}
	;

exclusive_or_expression
	: and_expression
	{
		$$=$1;
	}
	| exclusive_or_expression '^' and_expression
	{
		$$=changeTypeNEmit($1,$3,'^');
	}
	;

inclusive_or_expression
	: exclusive_or_expression
	{
		$$=$1;
	}
	| inclusive_or_expression '|' exclusive_or_expression
	{
		$$=changeTypeNEmit($1,$3,'|');
	}
	;

logical_and_expression
	: inclusive_or_expression{$$=$1;}
	| logical_and_expression NList AND_OP MIndex inclusive_or_expression 
	{
		if(!$5->isBoolExp)
			int2Bool($5);

		if(!$1->isBoolExp){
			backpatch(*$2,nextInst());
			int2Bool($1);
		}
		backpatch($1->tl,$4);
		$$->isBoolExp=true;
		$$->tl=$5->tl;
		$$->fl=merge($1->fl,$5->fl);
	}
	;



changeBoolTemp
	:inclusive_or_expression
	{
		if($1->isBoolExp==false)
			int2Bool($1);
		$$=$1;
	}
	;

logical_or_expression
	: logical_and_expression{$$=$1;}
	| logical_or_expression NList OR_OP MIndex logical_and_expression
	{
		if(!$5->isBoolExp)
			int2Bool($5);

		if(!$1->isBoolExp){
			backpatch(*$2,nextInst());
			int2Bool($1);
		}
		backpatch($1->fl,$4);
		$$->isBoolExp=true;
		$$->tl=merge($1->tl,$5->tl);
		$$->fl=$5->fl;
	}
	;

conditional_expression
	: logical_or_expression{$$=$1;}
	| logical_or_expression NList '?' MIndex expression NList ':' 
		MIndex conditional_expression
	{
		GENTEMP($$);
		UPDATE($$,$5->type);

		quadArray.push_back(Quad($$->name,$9->name));
		vi I=makelist(nextInst());
		quadArray.push_back(Quad(QGOTO,"...",0));
		
		backpatch(*$6,nextInst());
		quadArray.push_back(Quad($$->name,$5->name));
		I=merge(I,makelist(nextInst()));
		quadArray.push_back(Quad(QGOTO,"...",0));

		if(!$1->isBoolExp)
		{
			backpatch(*$2,nextInst());
			int2Bool($1);
		}
			
		backpatch($1->tl,$4);
		backpatch($1->fl,$8);
		backpatch(I,nextInst());
	}	
	;

assignment_expression
	: conditional_expression{$$=$1;}
	| unary_expression assignment_operator assignment_expression
	{
		//quadArray.push_back(Quad($$))
		//$$=changeTypeNEmit($1,$3,'=');
	//	int check=typeCheck($$->type,$1->type)&&typeCheck($1->type,$3->type);
		//if(check==0)
		//	throw "type mismatch";
		//quadArray.push_back(Quad($1->name,$3->name));

		Fields* f=checkTypesNAssign($1,$3);

		if($1->isArray)
		{
			quadArray.push_back(Quad(QARRDEREF,$1->arrayBase->name,
								$1->arrSize->name,f->name));
		}
		else if($1->isPointer)
		{
			quadArray.push_back(Quad(QPOINTERDER,$1->arrayBase->name,
								f->name));
		}
		else if($3->isBoolExp){
			backpatch($3->tl,nextInst());
			quadArray.push_back(Quad($1->name,"1"));
			quadArray.push_back(Quad(QGOTO,nextInst()+2));
			backpatch($3->fl,nextInst());
			quadArray.push_back(Quad($1->name,"0"));
		}
		else 
			quadArray.push_back(Quad($1->name,f->name));
		$$=$1;
	}
	;

assignment_operator
	: '='
	;

expression
	: assignment_expression{$$=$1;}
	| expression ',' assignment_expression
	;

constant_expression
	: conditional_expression{$$=$1;}
	;


































id_parser
	:IDENTIFIER
	{
		$$=st->lookup(yytext);
	}
CONSTANT
	: INTEGER_CONSTANT
	{
		$$=SymbolTable::gentemp(*st);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		$$->isConst=true;
		$$->val.intVal=atoi(yytext);
		quadArray.push_back(Quad($$->name,yytext));

	}
	| CHARACTER_CONSTANT
	{
		$$=SymbolTable::gentemp(*st);
		$$->type.push_back(ii(charT,0));
		UPDATE($$);
		char *temp=strdup(yytext);
		temp++;
		//temp[strlen(temp)-1]='\0';
		sprintf(temp,"%d",temp[0]);
		quadArray.push_back(Quad($$->name,temp));
	
	}
	| FLOATING_CONSTANT
	{
		$$=SymbolTable::gentemp(*st);
		$$->type.push_back(ii(doubleT,0));
		UPDATE($$);
		$$->isConst=true;
		$$->val.doubleVal=atof(yytext);
		quadArray.push_back(Quad($$->name,yytext));		
	}



%%




Fields* char2int(Fields* f)
{
	Fields* res;
	GENTEMP(res);
	res->type.push_back(ii(intT,0));
	UPDATE(res);
	string val="char2int( ";
	string end=" )";
	quadArray.push_back(Quad(res->name,val+string(f->name)+end));
	return res;
}

Fields* int2double(Fields* f)
{
	Fields* res;
	GENTEMP(res);
	res->type.push_back(ii(doubleT,0));
	UPDATE(res);
	string val="int2double( ";
	string end=" )";
	quadArray.push_back(Quad(res->name,val+string(f->name)+end));
	return res;
}
Fields* char2double(Fields* f)
{
	Fields* res;
	GENTEMP(res);
	res->type.push_back(ii(doubleT,0));
	UPDATE(res);
	string val="char2double( ";
	string end=" )";
	quadArray.push_back(Quad(res->name,val+string(f->name)+end));
	return res;
}


Fields* double2char(Fields* f)
{
	Fields* res;
	GENTEMP(res);
	res->type.push_back(ii(doubleT,0));
	UPDATE(res);
	string val="double2char( ";
	string end=" )";
	quadArray.push_back(Quad(res->name,val+string(f->name)+end));
	return res;
}

Fields* double2int(Fields* f)
{
	Fields* res;
	GENTEMP(res);
	res->type.push_back(ii(doubleT,0));
	UPDATE(res);
	string val="double2int( ";
	string end=" )";
	quadArray.push_back(Quad(res->name,val+string(f->name)+end));
	return res;
}
Fields* int2char(Fields* f)
{
	Fields* res;
	GENTEMP(res);
	res->type.push_back(ii(doubleT,0));
	UPDATE(res);
	string val="int2char( ";
	string end=" )";
	quadArray.push_back(Quad(res->name,val+string(f->name)+end));
	return res;
}


/*
	This is for binary operations. checks the types and converts
	one of them to other suitable type.
	int,double ==> double,dpuble
	int,char 	==> int,int
	char,double -->double,double
	and so on
	It returns the temporary of t=f1 op f2
	after chnaging f2 or f1 to suitable types
*/
Fields* changeTypeNEmit(Fields* f1,Fields* f2,int op)
{
	if(f1->type.size()==0||f2->type.size()==0)
		throw "non initialized types";
	if(f1->type.size()>1||f2->type.size()>1)
		throw "invalid type Changing";
	int check=typeCheck(f1->type,f2->type);
	
	//f1->print();f2->print();
	Fields* arg1=f1,*arg2=f2,*res;
	GENTEMP(res);

	int t1=f1->type[0].first;
	int t2=f2->type[0].first;

	int greaterT=min(t1,t2),lesserT=max(t1,t2);

	//by def arg1 holds the greater type
	if(greaterT!=t1)
		swap(arg1,arg2);


	if(greaterT==lesserT){
		//both are char
		if(greaterT==charT){
			arg1=char2int(arg1);
			arg2=char2int(arg2);
			res->type.push_back(ii(intT,0));
			UPDATE(res);
		}
		else{
			res->type.push_back(ii(greaterT,0));
			UPDATE(res);
		}
	}
	else if(greaterT==intT){
		arg2=char2int(arg2);
		res->type.push_back(ii(intT,0));
		UPDATE(res);
	}
	else if(greaterT==doubleT)
	{
		if(lesserT==intT)
			arg2=int2double(arg2);
		else
			arg2=char2double(arg2);
		res->type.push_back(ii(doubleT,0));
		UPDATE(res);
	}
	quadArray.push_back(Quad(op,res->name,arg1->name
						,arg2->name));
	
	return res;

}


/*
	same as above but returns both of them 
*/
pair<Fields*,Fields*> changeTypeNReturn(Fields* f1,Fields* f2)
{
	if(f1->type.size()>1||f2->type.size()>1)
		throw "invalid type Changing";

	Fields* arg1=f1,*arg2=f2;

	int t1=f1->type[0].first;
	int t2=f2->type[0].first;

	int greaterT=min(t1,t2),lesserT=max(t1,t2);

	//by def arg1 holds the greater type
	if(greaterT!=t1)
		swap(arg1,arg2);


	if(greaterT==lesserT){
		//both are char
		if(greaterT==charT){
			arg1=char2int(arg1);
			arg2=char2int(arg2);
		}
	}
	else if(greaterT==intT){
		arg2=char2int(arg2);
	}
	else if(greaterT==doubleT)
	{
		if(lesserT==intT)
			arg2=int2double(arg2);
		else
			arg2=char2double(arg2);
	}
	return make_pair(arg1,arg2);
}

/*
	converts an integer expression to a boolExp with true and false lists
*/
void int2Bool(Fields* f)
{
	Fields* arg=f;
	if(f->type[0].first==charT)
		arg=char2int(f);
	if(f->type[0].first==doubleT)
		arg=double2int(f);

	f->isBoolExp=true;
	
	f->fl.push_back(nextInst());
	quadArray.push_back(Quad(QRELIFEQ,"...",arg->name,"0"));

	f->tl.push_back(nextInst());
	quadArray.push_back(Quad(QGOTO,"...",0));

}

inline void getValueNBackpatch(Fields* f)
{
	//backpatch(f->tl,nextInst());
	//quadArray.push_back(Quad(f->name,"1"));
	//f->tl=makelist(nextInst());
	//quadArray.push_back(Quad(QGOTO,"...",0));

	//backpatch(f->fl,nextInst());
	//quadArray.push_back(Quad(f->name,"0"));
	//f->fl=makelist(nextInst());
	//quadArray.push_back(Quad(QGOTO,"...",0));
}


/*
	This is for assigning types i.e f1=f2;
	it converts f2 to suitable type and then assigns the value
	to f1
*/
Fields* checkTypesNAssign(Fields* f1,Fields* f2)
{
	bool res=typeCheck(f1->type,f2->type);


	if(!res){
		if(f1->type.size()>1||f2->type.size()>1)
			throw "assigning types dont match";
		int t1=f1->type[0].first,t2=f2->type[0].first;

		Fields *temp;

		if(t1==intT&&t2==doubleT)
			temp=double2int(f2);
		else if(t1==intT&&t2==charT)
			temp=char2int(f2);
		else if(t1==charT&&t2==intT)
			temp=int2char(f2);
		else if(t1==charT&&t2==doubleT)
			temp=double2char(f2);
		else if(t1==doubleT&&t2==intT)
			temp=int2double(f2);
		else if(t1==doubleT&&t2==charT)
			temp=char2double(f2);
		return temp;
	}
	return f2;
}


