%{
	#include <bits/stdc++.h>
	#include <string.h>
	#include <iostream>
	#include "stdio.h"
	#include "ass5_12CS10037_translator.h"
	struct Fields;
	extern int yylex();
	extern void yyerror(char *s);
	std::vector<quad::Quad> quadArray;
	extern SymbolTable* st;
	extern char* yytext;
	using namespace quad;
	//int offset=0;
	inline void GENTEMP(Fields* &f){ f=SymbolTable::gentemp(*st);}
	inline void UPDATE(Fields* f){
		st->update(f,f->type);
	} 
	inline void UPDATE(Fields* f,Type& t){
		st->update(f,t);
	} 
	inline void UPDATE(Fields* f1,Fields* f2){
		st->update(f1,f2);
	} 
	inline int nextInst(){
		return quadArray.size();
	}
	inline void EMIT(){
		Quad::emit(quadArray[(int)quadArray.size()-1]);
	}
	inline void getValueNBackpatch(Fields* f);
	int _GLOBALTYPE;
	Fields* changeTypeNEmit(Fields* f1,Fields* f2,int op);
	pair<Fields*,Fields*> changeTypeNReturn(Fields* f1,Fields* f2);
	void int2Bool(Fields* f);
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






%type <sentry> id_parser CONSTANT STRING_LITERAL 
%type <sentry> primary_expression postfix_expression unary_expression cast_expression multiplicative_expression additive_expression shift_expression
%type <sentry> relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression
%type <sentry> expression  initializer init_declarator direct_declarator declarator parameter_declaration logical_or_expression
	logical_and_expression conditional_expression assignment_expression constant_expression changeBoolTemp logicalTempRule boolExpression
	boolExpressionStatement
%type <intval> type_specifier declaration_specifiers unary_operator
%type <int_pair> pointer
%type <sentryList> identifier_list  parameter_list 
%type <intval> '&' '*' '+' '-' '~' '!' MIndex relop
%type <listType> NList statement compound_statement expression_statement 
			selection_statement iteration_statement block_item block_item_list


%%



declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
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
		//bool res=typeCheck($1,$3);
		//if(!res)
		//	throw "type mismatch";
		UPDATE($1,$3);


		//quadArray.push_back(Quad($$->loc,$3->loc));
	}
	;



type_specifier
	: VOID {_GLOBALTYPE=voidT;$$=voidT;}
	| CHAR {_GLOBALTYPE=charT;$$=charT;}
	| INT {_GLOBALTYPE=intT;$$=intT;}
	| DOUBLE {_GLOBALTYPE=doubleT;$$=doubleT;}
	| SIGNED {_GLOBALTYPE=intT;$$=intT;}
	| UNSIGNED {_GLOBALTYPE=intT;$$=intT;}
	| COMPLEX {_GLOBALTYPE=intT;$$=intT;}
	| IMAGINARY {_GLOBALTYPE=intT;$$=intT;}
	;



specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	;





declarator
	: pointer direct_declarator
	{
		$$=$2;
		$$->type.push_back(ii(pointerT,$1.second));
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

	}
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
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
	: parameter_declaration
	{
		$$=new vector<Fields*>();
		$$->push_back($1);
	}
	| parameter_list ',' parameter_declaration
	{
		$$=$1;
		$$->push_back($3);
	}
	;

parameter_declaration
	: declaration_specifiers declarator
	{
		$2->type.push_back(ii(_GLOBALTYPE,0));
		$$=$2;
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






















statement
	: compound_statement {$$=$1;}
	| expression_statement{$$=$1;}
	| selection_statement {$$=$1;}
	| iteration_statement 
	{
		$$=$1;
		printf("iteration_statement   ");
		tr((*$$),it)
			printf("%d ",*it);
		printf("\n");
	}
	| jump_statement 
	;


compound_statement
	: '{' '}' {$$=new vi();}
	| '{' block_item_list '}' {$$=$2;}
	;

block_item_list
	: block_item {*$$=merge(*$$,*$1);
		printf("block item   ");
		tr((*$$),it)
			printf("%d ",*it);
		printf("\n");
	}
	| block_item_list MIndex block_item
	{
		printf("block item list   ");
		tr((*$1),it)
			printf("%d ",*it);
		printf("index %d\n",$2);
		backpatch(*$1,$2);
		$$=$3;
	}
	;

block_item
	: declaration {$$=new vi();}
	| statement{
		$$=$1;
		printf("block statement   ");
		tr((*$$),it)
			printf("%d ",*it);
		printf("\n");
	}
	;


expression_statement
	: ';' {$$=new vi();}
	| expression ';' {$$=new vi();}
	;

selection_statement
	: IF '(' boolExpression ')' MIndex statement 
	{
		backpatch($3->tl,$5);
		$$=$6;
		*$$=merge($3->fl,*$$);
	}
	| IF '(' boolExpression ')' MIndex statement NList ELSE MIndex statement 
	{
		backpatch($3->tl,$5);
		backpatch($3->fl,$9);
		vi temp=merge(*$6,*$7);
		*$$=merge($3->fl,*$10);
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
		quadArray.push_back(Quad(QGOTO,$6));
		backpatch(*$8,$4);
		*$$=$5->fl;
	}
	
	;

jump_statement
	: RETURN ';' 
	| RETURN expression ';' 
	;


NList
	:{	
		$$=new vi();
		$$->push_back(nextInst());
		quadArray.push_back(Quad(QGOTO,"...",0));
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
	: function_definition {printf("  function_definition  ");}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement
	| declarator declaration_list compound_statement
	| declarator compound_statement
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



postfix_expression
	: primary_expression {$$=$1;}
	| postfix_expression '[' expression ']'
	{
		if($$->type[0].first!=arrayT)
			throw "not an arrayT";
		GENTEMP($$);
		vii temp($1->type.begin()+1,$1->type.end());
		int s=getSize(temp);
		char word[50];sprintf(word,"%d",s);
		Fields *f1,*f2;
		GENTEMP(f1);GENTEMP(f2);
		f1->type.push_back(ii(intT,0));
		f2->type.push_back(ii(intT,0));
		UPDATE(f1);UPDATE(f2);
		quadArray.push_back(Quad('*',f2->name,$3->name,word));


		quadArray.push_back(Quad('+',f1->name,$1->name,f2->name));
		quadArray.push_back(Quad('*',$$->name,f1->name));
		$$->type=temp;
		UPDATE($$);
	}
	| postfix_expression '(' ')' 
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	;

argument_expression_list
	: assignment_expression 
	| argument_expression_list ',' assignment_expression {printf("  argument_expression_list ") ;}
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
				case '&':
					;
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
	: '&'  {$$=(int)$1;}
	| '*'  {$$=(int)$1;}	
	| '+'  {$$=(int)$1;}
	| '-'  {$$=(int)$1;}
	| '~'  {$$=(int)$1;}
	;

cast_expression
	: unary_expression{$$=$1;}
	| '(' type_name ')' cast_expression {$$=$4;}
	;

multiplicative_expression
	: cast_expression 
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
	| logicalTempRule
	;

logicalTempRule
	: logicalTempRule AND_OP MIndex changeBoolTemp
	{
		GENTEMP($$);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		
		if($1->isBoolExp==false)
			{int2Bool($1);$3++;}
		if($4->isBoolExp==false)
			int2Bool($4);
		$$->isBoolExp=true;
		
		
		backpatch($1->tl,$3);
		$$->fl=merge($1->fl,$4->fl);
		$$->tl=$4->tl;
		getValueNBackpatch($$);
	}
	| changeBoolTemp
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
	| logical_or_expression OR_OP MIndex logical_and_expression
	{

		GENTEMP($$);
		$$->type.push_back(ii(intT,0));
		UPDATE($$);
		$$->isBoolExp=true;

		backpatch($1->fl,$3);
		$$->tl=merge($1->tl,$4->tl);
		$$->fl=$4->fl;


		getValueNBackpatch($$);
	}
	;

conditional_expression
	: logical_or_expression{$$=$1;}
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression{$$=$1;}
	| unary_expression assignment_operator assignment_expression
	{
		//quadArray.push_back(Quad($$))
		//$$=changeTypeNEmit($1,$3,'=');
		int check=typeCheck($$->type,$1->type)&&typeCheck($1->type,$3->type);
		if(check==0)
			throw "type mismatch";
		quadArray.push_back(Quad($1->name,$3->name));
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


MIndex
	:{$$=nextInst();}
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
		temp[strlen(temp)-1]='\0';
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

Fields* changeTypeNEmit(Fields* f1,Fields* f2,int op)
{
	
	if(f1->type.size()>1||f2->type.size()>1)
		throw "invalid type Changing";
	int check=typeCheck(f1->type,f2->type);

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