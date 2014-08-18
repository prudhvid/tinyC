%{
	#include "y.tab.h"
%}



WHITE_SPACE [ \n\v\t]
DIGIT [0-9]
IDENTIFIER_NON_DIGIT [a-zA-Z]
IDENTIFIER {IDENTIFIER_NON_DIGIT}({IDENTIFIER_NON_DIGIT}?{DIGIT}?)*




NON_ZERO_DIGIT [1-9]
DIGIT_SEQUENCE {DIGIT}+
SIGN [\+-]
EXPONENT_PART [eE]{SIGN}?{DIGIT}+
ESCAPE_SEQUENCE \\[\'\"?\\abfnrtv]
C_CHAR [^\'\\n]|{ESCAPE_SEQUENCE}
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
int	 	 |
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
		printf(" <KEYWORD %s > ",yytext);
		
	}





{INTEGER_CONSTANT}/{WHITE_SPACE} printf(" <INTEGER_CONSTANT %s >",yytext);
{FLOATING_CONSTANT}/{WHITE_SPACE} printf(" <FLOATING_CONSTANT %s >",yytext);
{CHARACTER_CONSTANT}/{WHITE_SPACE} printf(" <CHARACTER_CONSTANT %s >",yytext);


{STRING_LITERAL}/{WHITE_SPACE} printf(" <STRING_LITERAL %s >",yytext);

{IDENTIFIER}/{WHITE_SPACE} printf(" <IDENTIFIER %s >",yytext);


"[" |
\] | 
\( |
\) |
\{ |
\} | 
\. |
-> |  
\++ |
\-- | 
& |
\* |
'+' |
- |
~ |
! |
\/ |
% |  
\<< |
>> |
\< |
> |
\<= |
>= |
== | 
!= |
\^ |
\| | 
&& |
\|\| |
\? |
: |
; |
\... | 
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
\|= |
\, |
\# printf(" <PUNCTUATOR %s >",yytext);



\/\*((.|\n)*)\*\/ printf("<COMMENT %s >",yytext);

\/\/.* printf("<COMMENT %s>",yytext+2);

\n printf("\n");
[ \t] 


%%