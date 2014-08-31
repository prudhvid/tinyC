%{
	#include "y.tab.h"
	char comment_word[1000];int comment_index=0;
	int line_number=0;
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


extern | 
auto | 
register  return STORAGE_CLASS_SPECIFIER;


void |
char |
short |
int |
long |
float |
double |
signed |
unsigned |
_Bool |
_Complex |
_Imaginary  return TYPE_SPECIFIER;


const |
restrict |
volatile  return TYPE_QUALIFIER;

inline  return FUNCTION_SPECIFIER;



sizeof  return SIZEOF;
enum return ENUM;
static  return STATIC;
case  return CASE;
default  return DEFAULT;
if  return IF;
else  return ELSE;
switch  return SWITCH;
while  return WHILE;
do  return DO;
for  return FOR;
goto  return GOTO;
continue  return CONTINUE;
break  return BREAK;
return  return RETURN;



struct	 |
typedef	 |
union	 {
			/*for(int i=0;i<yyleng;i++)
				yylval.name[i]=yytext[i];
			yylval.name[yyleng]='\0';*/
			
			return 987;
		}




{SIGN}?{INTEGER_CONSTANT} return CONSTANT;
{SIGN}?{FLOATING_CONSTANT} return CONSTANT;
{CHARACTER_CONSTANT} return CONSTANT;


{STRING_LITERAL} return STRING_LITERAL;

{IDENTIFIER} return IDENTIFIER;

& | 
\* | 
\+ | 
- | 
\~ |
! return UNARY_OPERATOR;

= |
\*= |
\/= |
\%= |
\+= |
\-= |
\<<= | 
\>>= | 
\&= | 
\^= | 
\|=  return ASSIGNMENT_OPERATOR;


"&&" return LOGICAL_AND;
"||" return LOGICAL_OR;
"->" return POINTER_REFERENCE;
"++" return PLUS_PLUS;
"--" return MINUS_MINUS;
">=" return GTEQUAL;
"<=" return LTEQUAL;
"!=" return NOTEQUAL;
"==" return EQUAL;
">>" return LEFT_SHIFT;
"<<" return RIGHT_SHIFT;


"..." return ELLIPSES;
{WHITE_SPACE} 














"$" return 0;
. {
	return yytext[0];
}


















\/\* 		BEGIN(comment);
<comment>[^*]* |
<comment>"*"+[^*/\n]*  {
						for(int i=0;i<yyleng;i++)comment_word[comment_index++]=yytext[i];
						}
<comment>"*"+"/" {
					yytext=comment_word;
					comment_index=0;
					BEGIN(INITIAL);
					return COMMENT;
				}


\/\/.* {return COMMENT;}





%%