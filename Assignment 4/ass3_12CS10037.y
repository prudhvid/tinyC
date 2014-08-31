%{
	#include <string.h>
	#include <iostream>
	#include "stdio.h"
	
	extern int yylex();
	extern void yyerror(char *s);
	
%}


%union {
	int intval;
	char name[15];
}




%token STORAGE_CLASS_SPECIFIER
%token TYPE_SPECIFIER
%token TYPE_QUALIFIER
%token FUNCTION_SPECIFIER
%token IDENTIFIER
%token STRING_LITERAL
%token SIZEOF
%token ENUM
%token STATIC
%token CASE
%token DEFAULT
%token IF
%token ELSE
%token SWITCH
%token WHILE
%token DO
%token FOR
%token GOTO
%token CONTINUE
%token BREAK
%token RETURN
%token CONSTANT









%token UNARY_OPERATOR
%token ASSIGNMENT_OPERATOR

%token INTEGER_CONSTANT
%token FLOATING_CONSTANT
%token CHARACTER_CONSTANT

%token PUNCTUATOR
%token COMMENT
%token ENUMERATION_CONSTANT





%token ELLIPSES


%left ','
%right ASSIGNMENT_OPERATOR
%right '?'
%left LOGICAL_OR
%left LOGICAL_AND
%left '|'
%left '^'
%left '&' 
%left EQUAL NOTEQUAL
%left '<' '>' LTEQUAL GTEQUAL
%left RIGHT_SHIFT LEFT_SHIFT
%left '+' '-'
%left '*' '/' '%'
%left UNARY_OPERATOR
%left PLUS_PLUS MINUS_MINUS
%left '('')' '[' ']' '.' POINTER_REFERENCE















%%	
primary: statement
		| declaration_list	
		{printf("accepted\n ");}
		;


primary_expression : IDENTIFIER 
					| CONSTANT
					| STRING_LITERAL
					| '('expression')'
					{printf("primary expression");}
					;

postfix_expression : primary_expression
					| postfix_expression '[' expression ']'
					| postfix_expression '(' argument_expression_list ')'
					| primary_expression '(' ')'
					| postfix_expression '.' IDENTIFIER
					| postfix_expression POINTER_REFERENCE IDENTIFIER
					| postfix_expression PLUS_PLUS
					| postfix_expression MINUS_MINUS
					| '(' type_name ')' '{' initializer_list '}'
					| '(' type_name ')'  '{' initializer_list ',' '}'
					;

argument_expression_list : assignment_expression
						| argument_expression_list ',' assignment_expression
						;

unary_expression : postfix_expression 
				 | PLUS_PLUS unary_expression
				 | MINUS_MINUS unary_expression
				 | UNARY_OPERATOR cast_expression
				 | SIZEOF unary_expression
				 | SIZEOF '(' type_name ')'
					;

cast_expression : unary_expression 
				| '(' type_name ')' cast_expression
					;

multiplicative_expression :   cast_expression
							| multiplicative_expression '*' cast_expression
							| multiplicative_expression '/' cast_expression
							| multiplicative_expression '%' cast_expression
					;

additive_expression : multiplicative_expression 
					| additive_expression '+' multiplicative_expression
					| additive_expression '-' multiplicative_expression
					;


shift_expression : additive_expression
				|  shift_expression LEFT_SHIFT additive_expression
				| shift_expression RIGHT_SHIFT additive_expression
					;

relational_expression : shift_expression
					  | relational_expression '<' shift_expression
					  | relational_expression '>' shift_expression
					  | relational_expression GTEQUAL shift_expression
					  | relational_expression LTEQUAL shift_expression
					;

equality_expression : relational_expression
					| equality_expression EQUAL relational_expression
					| equality_expression NOTEQUAL relational_expression
					;


AND_expression : equality_expression 
			   | AND_expression '&' equality_expression
					;


exclusive_OR_expression : AND_expression
						| exclusive_OR_expression '^' AND_expression
					;


inclusive_OR_expression : exclusive_OR_expression 
						| inclusive_OR_expression '|' exclusive_OR_expression
					;


logical_AND_expression : inclusive_OR_expression
						| logical_AND_expression LOGICAL_AND inclusive_OR_expression
					;

logical_OR_expression : logical_AND_expression 
					| logical_OR_expression LOGICAL_OR logical_AND_expression
					;

conditional_expression : logical_OR_expression
						| logical_OR_expression '?' expression ':' conditional_expression
					;


assignment_expression : conditional_expression
					| unary_expression ASSIGNMENT_OPERATOR assignment_expression
					;

expression : assignment_expression
			| expression ',' assignment_expression
			;


constant_expression : conditional_expression
					;











declaration: declaration_specifiers init_declarator_list ';'
			| declaration_specifiers ';'
			{printf("declaration   found");}
			;


declaration_specifiers: STORAGE_CLASS_SPECIFIER_STATIC declaration_specifiers
					|	STORAGE_CLASS_SPECIFIER_STATIC
					| TYPE_SPECIFIER
					| TYPE_SPECIFIER declaration_specifiers
					| TYPE_QUALIFIER 
					| TYPE_QUALIFIER declaration_specifiers
					| FUNCTION_SPECIFIER
					| FUNCTION_SPECIFIER declaration_specifiers
					{printf(" declaration_specifiers found");}
			;
STORAGE_CLASS_SPECIFIER_STATIC : STORAGE_CLASS_SPECIFIER
								| STATIC
								;

init_declarator_list: init_declarator 
					| init_declarator_list ',' init_declarator
			;


init_declarator: declarator
				| declarator '=' initializer
			;


specifier_qualifier_list: TYPE_SPECIFIER
						| TYPE_SPECIFIER specifier_qualifier_list
						| TYPE_QUALIFIER 
						| TYPE_QUALIFIER specifier_qualifier_list
			;


enum_specifier: ENUM  '{' enumerator_list '}'
			  | ENUM IDENTIFIER '{' enumerator_list '}'
			  | ENUM '{' enumerator_list ',' '}'	
			  | ENUM IDENTIFIER '{' enumerator_list ',' '}'	
			  | ENUM IDENTIFIER
			;


enumerator_list: enumerator
				| enumerator_list ',' enumerator
			;


enumerator: ENUMERATION_CONSTANT 
		  | ENUMERATION_CONSTANT '=' constant_expression
			;


declarator: pointer direct_declarator
			| direct_declarator
			;


direct_declarator: IDENTIFIER
				| '(' declarator ')'
				| direct_declarator '[' type_qualifier_list assignment_expression']'
				| direct_declarator '[' type_qualifier_list ']'
				| direct_declarator '[' assignment_expression']'
				| direct_declarator '[' ']'
				| direct_declarator '[' STATIC type_qualifier_list assignment_expression ']'
				| direct_declarator '[' STATIC  assignment_expression ']'
				| direct_declarator '[' type_qualifier_list STATIC assignment_expression ']'
				| direct_declarator '[' type_qualifier_list '*' ']'
				| | direct_declarator '[' '*' ']'
				| direct_declarator '(' parameter_type_list ')'
				| direct_declarator '(' identifier_list ')'
				| direct_declarator '(' ')'
			;


pointer: '*' type_qualifier_list
		| '*'
		| '*' type_qualifier_list pointer
		| '*' pointer
		;


type_qualifier_list: TYPE_QUALIFIER
					| type_qualifier_list TYPE_QUALIFIER
			;


parameter_type_list: parameter_list
					| parameter_list ',' ELLIPSES
			;


parameter_list: parameter_declaration
			|	parameter_list ',' parameter_declaration
			;


parameter_declaration: declaration_specifiers declarator
					| declaration_specifiers
			;


identifier_list: IDENTIFIER
				identifier_list ',' IDENTIFIER
			;


type_name: specifier_qualifier_list
			;


initializer: assignment_expression
			| '{' initializer_list '}'
			| '{' initializer_list ',' '}'
			;


initializer_list: designation initializer
				| initializer
				| initializer_list ',' designation initializer
				| initializer_list ',' initializer
			;


designation: designator_list '='
			;


designator_list: designator 
				| designator_list designator
			;


designator: '[' constant_expression ']'
			| '.' IDENTIFIER
			;
























statement: labeled_statement
		| compound_statement
		| expression_statement
		| selection_statement
		| jump_statement
		| iteration_statement
		;

labeled_statement: IDENTIFIER ':' statement
		| CASE constant_expression ':' statement
		| DEFAULT ':' statement
		;
compound_statement: '{' block_item_list '}'
		| '{' '}'
		;
block_item_list: block_item
		| block_item_list block_item
		;
block_item: declaration
		|	statement
		;
expression_statement: expression_opt ';'
		;
selection_statement:IF '(' expression ')' statement
					| IF '(' expression ')' statement ELSE  statement
					| SWITCH '(' expression ')' statement
		;
iteration_statement: WHILE '(' expression ')' statement
					| DO statement WHILE '(' expression ')' ';'
					| FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement
					| FOR '(' declaration expression_opt ';' expression_opt ')' statement
		;
jump_statement: GOTO IDENTIFIER ';'
			|   CONTINUE ';'
			| BREAK ';'
			| RETURN expression_opt ';'
		;
expression_opt: 
			| expression
			;













translation_unit: external_declaration
				| translation_unit external_declaration
				;
external_declaration: function_definition 
				| declaration
				;
function_definition: declaration_specifiers declarator declaration_list compound_statement
				| declaration_specifiers declarator  compound_statement
				;
declaration_list: declaration
				| declaration_list declaration
				{printf("declaration_list found\n");}
				;

%%


