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
		
		return KEYWORD;
	}




{SIGN}?{INTEGER_CONSTANT} return INTEGER_CONSTANT;
{SIGN}?{FLOATING_CONSTANT} return FLOATING_CONSTANT;
{CHARACTER_CONSTANT} return CHARACTER_CONSTANT;


{STRING_LITERAL} return STRING_LITERAL;

{IDENTIFIER} return IDENTIFIER;


\[ |
\] | 
\( |
\) |
\{ |
\} | 
\. |
-> |  
\+\+ |
\-- | 
& |
\* |
[+] |
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
\# return PUNCTUATOR;




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
\n printf("\n");line_number++;




%%