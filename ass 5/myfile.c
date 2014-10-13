#include "stdio.h"
#include "y.tab.h"
#include "ass5_12CS10037_translator.h"
#include <iostream>
extern int yylex();
extern int yyparse();
extern char* yytext;
void yyerror(char *s);
SymbolTable *st=new SymbolTable();

void yyerror(char* s)
{
	printf("%s",s);
}
int main()
{
	freopen("ass5_12CS10037_test.c", "r", stdin);
	int token;
	std::string s;
	// while((token=yylex())){
	// 	switch(token){
	// 		case 0:s="KW "+std::string(yytext);
	// 		break;
	// 		case IDENTIFIER:s="ID "+std::string(yytext);
	// 		break;
	// 		case STRING_LITERAL:s="SL "+std::string(yytext);
	// 		break;
			
			
	// 		case SIZEOF: s="SIZEOF";
	// 		break;
	// 		case ENUM: s="ENUM";
	// 		break;
	// 		case STATIC: s="STATIC";
	// 		break;
	// 		case CASE: s="CASE";
	// 		break;
	// 		case DEFAULT: s="DEFAULT";
	// 		break;
	// 		case IF: s="IF";
	// 		break;
	// 		case ELSE: s="ELSE";
	// 		break;
	// 		case SWITCH: s="SWITCH";
	// 		break;
	// 		case WHILE: s="WHILE";
	// 		break;
	// 		case DO: s="DO";
	// 		break;
	// 		case FOR: s="FOR";
	// 		break;
	// 		case GOTO: s="GOTO";
	// 		break;
	// 		case CONTINUE: s="CONTINUE";
	// 		break;
	// 		case BREAK: s="BREAK";
	// 		break;
	// 		case RETURN: s="RETURN";
	// 		break;
	// 		case CONSTANT: s="CONSTANT";
	// 		break;
	// 		default: s=yytext;
	// 		// printf("token value=%d",token);
	// 	}
	// 	printf("< %s > ",s.c_str());
	// }
	// printf("%s\n", yytext);
	yyparse();
	st->print();
	return 0;
}