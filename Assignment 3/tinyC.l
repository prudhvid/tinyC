%{
	#include "y.tab.h"
%}




DIGIT [0-9]
IDENTIFIER_NON_DIGIT [a-zA-Z]
IDENTIFIER {IDENTIFIER_NON_DIGIT}({IDENTIFIER_NON_DIGIT}?{DIGIT}?)*




NON_ZERO_DIGIT [1-9]
DIGIT_SEQUENCE {DIGIT}+
SIGN [+-]
EXPONENT_PART [eE]{SIGN}{DIGIT}+
ESCAPE_SEQUENCE \['"?\abfnrtv]
C_CHAR [^'\\n]
C_CHAR_SEQUENCE {C_CHAR}+

FRACTIONAL_CONSTANT {DIGIT_SEQUENCE}?+"."+{DIGIT_SEQUENCE}|{DIGIT_SEQUENCE}+"."
FLOATING_CONSTANT {FRACTIONAL_CONSTANT}{EXPONENT_PART}?|{DIGIT_SEQUENCE}{EXPONENT_PART}

INTEGER_CONSTANT {DIGIT}+

ENUMERATION_CONSTANT {IDENTIFIER}

CHARACTER_CONSTANT '{C_CHAR_SEQUENCE}'

CONSTANT {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{ENUMERATION_CONSTANT}|{}







S_CHAR [^"\\\n]
S_CHAR_SEQUENCE {S_CHAR}+
STRING_LITERAL "\""+{S_CHAR_SEQUENCE}+"\""


PUNCTUATOR \[ | \] |
			\( | \) |
			\{ | \} |
			\. | -> | 
			\++ | \-- |
			\& | \* | \+ | \- | \~ | \! | \/ | \% | 
			\<< | \>> |\ < |\ > | \<= | \>= | \== |
			\!= | \^ | \| | \&& | \|| |
			\? | \: | \; | \... |
			\= | \*= | \/= | \\%= | \+= | \-= |
			\<<= | \>>= | \&= | \^= | \|= | \, | \#



%%



auto	 |
break	 |
case	 |
char	 |
const	 |
continue |
default	 | 
do		 |	
double	 |
else	 |
enum	 |
extern	 |
float	 |
for		 |
goto	 |
if		 |
inline	 |
int	 	|
long	 |
register |
restrict |
return	 |
short	 |
signed	 |
sizeof	 |
static	 |
struct	 |
switch	 |
typedef	 |
union	 |
unsigned |
void	 |
volatile |
while	 |
_Bool	 |
_Complex |
_Imaginary {
	/*for(int i=0;i<yyleng;i++)
		yylval.name[i]=yytext[i];
	yylval.name[yyleng]='\0';*/
	printf("<KEYWORD %s> ",yytext);
	
}




{INTEGER_CONSTANT} printf("<INTEGER_CONSTANT %s>",yytext);
{FLOATING_CONSTANT} printf("<FLOATING_CONSTANT %s>",yytext);
{CHARACTER_CONSTANT} printf("<CHARACTER_CONSTANT %s>",yytext);




{IDENTIFIER} printf("<IDENTIFIER %s>",yytext);




{PUNCTUATOR} printf("<PUNCTUATOR %s> ",yytext);
											 	


\n printf("\n");
[ \t] 
%%

