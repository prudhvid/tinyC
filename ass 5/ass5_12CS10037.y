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

	inline void GENTEMP(Fields* f){ f=SymbolTable::gentemp(*st);}
	inline void UPDATE(Fields* A,Fields* B){
		A->update(B);A->offset=A->offset+=B->size;
	} 
	inline void EMIT(){
		Quad::emit(quadArray[(int)quadArray.size()-1]);
	}
%}

%union{
	Fields* sentry;
	Type type;
	int intval;
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
%type <sentry> IDENTIFIER CONSTANT STRING_LITERAL 
%type <sentry> primary_expression postfix_expression unary_expression cast_expression multiplicative_expression additive_expression shift_expression
%type <sentry> relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression
%type <sentry> expression constant_expression
%type <intval> unary_operator;

%%

primary_expression
	: IDENTIFIER { $$=$1;}
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
	| postfix_expression '(' ')' 
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression PTR_OP IDENTIFIER
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	| '(' type_name ')' '{' initializer_list '}'
	|  '(' type_name ')' '{' initializer_list ',' '}'
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
			GENTEMP($$);UPDATE($$,$2);
			quadArray.push_back(Quad($1,$$->name,$2->name));
		}

	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	;

multiplicative_expression
	: cast_expression 
		{
			$$=$1;
		}
	| multiplicative_expression '*' cast_expression 
		{
		}
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	{
		
	}
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	{printf("  expression  ");}
	;

constant_expression
	: conditional_expression
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	{printf("  declaration  ");}
	;

declaration_specifiers
	: type_specifier
	| type_specifier declaration_specifiers
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: declarator
	| declarator '=' initializer
	;



type_specifier
	: VOID
	| CHAR
	| SHORT
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| BOOL
	| COMPLEX
	| IMAGINARY
	;



specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	;





declarator
	: pointer direct_declarator {printf("  pointer  ");}
	| direct_declarator
	;

direct_declarator
	: IDENTIFIER
	| '(' declarator ')'
	| direct_declarator '(' parameter_type_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	;

assignment_expression_opt
	: 
	| assignment_expression
	;

pointer
	: '*' 
	| '*' pointer 
	;



parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;

parameter_list
	: parameter_declaration {printf("  parameter_list ")  ;}
	| parameter_list ',' parameter_declaration {printf("  parameter_list ") ;}
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers
	;

identifier_list
	: IDENTIFIER {printf("  identifier_list  ");}
	| identifier_list ',' IDENTIFIER {printf("  identifier_list  ");}
	;

type_name
	: specifier_qualifier_list
	;




initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| designation initializer
	| initializer_list ',' initializer
	|  initializer_list ',' designation initializer
	;
designation
	: designator_list '='
	;
designator_list
	: designator
	| designator_list designator
	;

designator
	: '[' constant_expression ']'
	| '.' IDENTIFIER
	;

statement
	: compound_statement
	| expression_statement {printf("   expression_statement   ");}
	| selection_statement
	| iteration_statement
	| jump_statement
	;


compound_statement
	: '{' '}' {printf("  compound_statement  ");}
	| '{' block_item_list '}'
	{printf("  compound_statement  ");}
	;

block_item_list
	: block_item
	| block_item_list block_item
	;

block_item
	: declaration
	| statement
	;


expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement {printf("  if_statement  ");}
	| IF '(' expression ')' statement ELSE statement {printf("  if_statement_else  ");}
	;

iteration_statement
	: WHILE '(' expression ')' statement {printf("  while_statement  ");}
	| DO statement WHILE '(' expression ')' ';' {printf("  do_while_statement  ");}
	| FOR '(' expression_statement expression_statement ')' statement {printf("  for_statement  ");}
	| FOR '(' expression_statement expression_statement expression ')' statement {printf("  for_statement  ");}
	
	;

jump_statement
	: RETURN ';' {printf("  jump_statement  ");}
	| RETURN expression ';' {printf("  jump_statement  ");}
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
	: declaration {printf("  declaration_list  ");}
	| declaration_list declaration
	{printf("  declaration_list  ");}
	;


CONSTANT
	: INTEGER_CONSTANT
	{
		$$=SymbolTable::gentemp(*st);
		$$->update(intT,SIZE_OF_INT,st->offset+=SIZE_OF_INT);
		quadArray.push_back(Quad($$->name,yytext));

	}
	| CHARACTER_CONSTANT
	{
		$$=SymbolTable::gentemp(*st);
		$$->update(charT,SIZE_OF_CHAR
					,st->offset+=SIZE_OF_CHAR);
		char *temp=strdup(yytext);
		temp++;
		temp[strlen(temp)-1]='\0';
		quadArray.push_back(Quad($$->name,temp));
	
	}
	| FLOATING_CONSTANT
	{
		$$=SymbolTable::gentemp(*st);
		$$->update(doubleT,SIZE_OF_DOUBLE
					,st->offset+=SIZE_OF_DOUBLE);
		quadArray.push_back(Quad($$->name,yytext));		
	}
%%
