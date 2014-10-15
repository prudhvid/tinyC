%{
	#include <bits/stdc++.h>
	#include "ass5_12CS10037_translator.h"
	#include "y.tab.h"
	char comment_word[1000];int comment_index=0;
	int line_number=0;
	void count();
	
	extern SymbolTable* st;
%}



WHITE_SPACE [ \n\v\t]
DIGIT [0-9]
IDENTIFIER_NON_DIGIT [_a-zA-Z]
IDENTIFIER {IDENTIFIER_NON_DIGIT}({IDENTIFIER_NON_DIGIT}?{DIGIT}?)*







NON_ZERO_DIGIT [1-9]
DIGIT_SEQUENCE {DIGIT}+
SIGN [\+-]
EXPONENT_PART [eE]{SIGN}?{DIGIT}+
ESCAPE_SEQUENCE \\[\'\"?\\abfnrtv]
C_CHAR [^\'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE {C_CHAR}+

FRACTIONAL_CONSTANT {DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE}|{DIGIT_SEQUENCE}\.
FLOATING_CONSTANT {FRACTIONAL_CONSTANT}{EXPONENT_PART}?|{DIGIT_SEQUENCE}{EXPONENT_PART}

INTEGER_CONSTANT {NON_ZERO_DIGIT}{DIGIT}*|0

ENUMERATION_CONSTANT {IDENTIFIER}

CHARACTER_CONSTANT \'{C_CHAR_SEQUENCE}\'

CONSTANT {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{ENUMERATION_CONSTANT}|{CHARACTER_CONSTANT}







S_CHAR [^\"\\\n]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE {S_CHAR}+
STRING_LITERAL \"{S_CHAR_SEQUENCE}?\"



%x comment
%%


"auto"			{  count();return(AUTO); }
"break"			{  count();return(BREAK); }
"case"			{  count();return(CASE); }
"char"			{  count();return(CHAR); }
"const"			{  count();return(CONST); }
"continue"		{  count();return(CONTINUE); }
"default"		{  count();return(DEFAULT); }
"do"			{  count();return(DO); }
"double"		{  count();return(DOUBLE); }
"else"			{  count();return(ELSE); }
"enum"			{  count();return(ENUM); }
"extern"		{  count();return(EXTERN); }
"float"			{  count();return(FLOAT); }
"for"			{  count();return(FOR); }
"goto"			{  count();return(GOTO); }
"if"			{  count();return(IF); }
"int"			{  count();return(INT); }
"long"			{  count();return(LONG); }
"register"		{  count();return(REGISTER); }
"return"		{  count();return(RETURN); }
"short"			{  count();return(SHORT); }
"signed"		{  count();return(SIGNED); }
"sizeof"		{  count();return(SIZEOF); }
"static"		{  count();return(STATIC); }
"struct"		{  count();return(STRUCT); }
"switch"		{  count();return(SWITCH); }
"typedef"		{  count();return(TYPEDEF); }
"union"			{  count();return(UNION); }
"unsigned"		{  count();return(UNSIGNED); }
"void"			{  count();return(VOID); }
"volatile"		{  count();return(VOLATILE); }
"while"			{  count();return(WHILE); }
"_Bool"			{count();return(BOOL);}
"_Complex"		{count();return(COMPLEX);}
"_Imaginary"	{count();return(IMAGINARY);}
"restrict"      {count();return(RESTRICT);}
"inline"   		{count();return(INLINE);}

"..."			{  count();return(ELLIPSIS); }
">>="			{  count();return(RIGHT_ASSIGN); }
"<<="			{  count();return(LEFT_ASSIGN); }
"+="			{  count();return(ADD_ASSIGN); }
"-="			{  count();return(SUB_ASSIGN); }
"*="			{  count();return(MUL_ASSIGN); }
"/="			{  count();return(DIV_ASSIGN); }
"%="			{  count();return(MOD_ASSIGN); }
"&="			{  count();return(AND_ASSIGN); }
"^="			{  count();return(XOR_ASSIGN); }
"|="			{  count();return(OR_ASSIGN); }
">>"			{  count();return(RIGHT_OP); }
"<<"			{  count();return(LEFT_OP); }
"++"			{  count();return(INC_OP); }
"--"			{  count();return(DEC_OP); }
"->"			{  count();return(PTR_OP); }
"&&"			{  count();return(AND_OP); }
"||"			{  count();return(OR_OP); }
"<="			{  count();return(LE_OP); }
">="			{  count();return(GE_OP); }
"=="			{  count();return(EQ_OP); }
"!="			{  count();return(NE_OP); }
";"			{  count();return(';'); }
("{"|"<%")		{  count();return('{'); }
("}"|"%>")		{  count();return('}'); }
","			{  count();return(','); }
":"			{  count();return(':'); }
"="			{  count();return('='); }
"("			{  count();return('('); }
")"			{  count();return(')'); }
("["|"<:")		{  count();return('['); }
("]"|":>")		{  count();return(']'); }
"."			{  count();return('.'); }
"&"			{  count();return('&'); }
"!"			{  count();return('!'); }
"~"			{  count();return('~'); }
"-"			{  count();return('-'); }
"+"			{  count();return('+'); }
"*"			{  count();return('*'); }
"/"			{  count();return('/'); }
"%"			{  count();return('%'); }
"<"			{  count();return('<'); }
">"			{  count();return('>'); }
"^"			{  count();return('^'); }
"|"			{  count();return('|'); }
"?"			{  count();return('?'); }




{INTEGER_CONSTANT} {count();return INTEGER_CONSTANT;}
{FLOATING_CONSTANT} {count();return FLOATING_CONSTANT;}
{CHARACTER_CONSTANT} {count();return CHARACTER_CONSTANT;}


{STRING_LITERAL} count();return STRING_LITERAL;

{IDENTIFIER} {st->lookup(string(yytext));count();return IDENTIFIER;}



{WHITE_SPACE}  count();







"$" return 0;
. 















\/\* 		BEGIN(comment);
<comment>[^*]* |
<comment>"*"+[^*/\n]*  {
						for(int i=0;i<yyleng;i++)comment_word[comment_index++]=yytext[i];
						}
<comment>"*"+"/" {
					yytext=comment_word;
					comment_index=0;
					BEGIN(INITIAL);
				}


\/\/.* {}





%%


int column = 0;

void count()
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			{column = 0;line_number++;}
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}
