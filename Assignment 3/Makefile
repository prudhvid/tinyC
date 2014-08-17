compiler: y.tab.o lex.yy.o
	g++ lex.yy.o y.tab.o -lfl

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

lex.yy.c: y.tab.h tinyC.l
	flex tinyC.l

y.tab.c: tinyC.y
	yacc -dvl tinyC.y
