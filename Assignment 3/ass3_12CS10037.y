%{
	#include <string.h>
	#include <iostream>
	#include "stdio.h"
	
	extern int yylex();
	void yyerror(char *s);
	
%}


%union {
	int intval;
	char name[15];
}
%token <name> KEYWORD
%token IDENTIFIER
%token INTEGER_CONSTANT
%token FLOATING_CONSTANT
%token CHARACTER_CONSTANT
%token STRING_LITERAL
%token PUNCTUATOR
%token COMMENT
%token ENUMERATION_CONSTANT

%type <name> statement
%%	
statement:KEYWORD;
%%

