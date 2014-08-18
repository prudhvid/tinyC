#include "stdio.h"
#include "y.tab.h"
#include "iostream"
extern int yylex();
extern char* yytext;
void yyerror(char *s);


void yyerror(char* s)
{
	printf("%s",s);
}
int main()
{
	freopen("ass3_12CS10037_test.c", "r", stdin);
	int token;
	std::string s;
	while((token=yylex())){
		switch(token){
			case KEYWORD:s="KW "+std::string(yytext);
			break;
			case IDENTIFIER:s="ID "+std::string(yytext);
			break;
			case INTEGER_CONSTANT:s="INT_C "+std::string(yytext);
			break;
			case FLOATING_CONSTANT:s="FLOAT_C "+std::string(yytext);
			break;
			case COMMENT:s="COMMENT "+std::string(yytext);
			break;
			case PUNCTUATOR:s="P "+std::string(yytext);
			break;
			case STRING_LITERAL:s="SL "+std::string(yytext);
			break;
			case CHARACTER_CONSTANT:s="CHAR_CONS "+std::string(yytext);
			break;
		}
		printf("< %s > ",s.c_str());
	}
	printf("%s\n", yytext);
	return 0;
}