compiler: y.tab.o lex.yy.o myfile.o
	g++ myfile.o lex.yy.o y.tab.o -lfl

myfile.o: myfile.c
	g++ -c myfile.c -lfl

y.tab.o: y.tab.c
	g++ -c y.tab.c 

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c 

lex.yy.c: y.tab.h newl.l
	flex newl.l

y.tab.c: sample.y
	yacc -dvl sample.y


clean:
	rm y.tab.c lex.yy.c sample.o