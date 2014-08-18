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
%token CONSTANT
%token STRING_LITERAL
%token PUNCTUATOR

%type <name> statement
%%	
statement:KEYWORD;
%%

void yyerror(char* s)
{
	printf("%s",s);
}
main()
{
	int s=yyparse();
	printf("%s",yylval.name);
	return 0;
}