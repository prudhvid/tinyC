compiler: y.tab.o lex.yy.o myfile.o
	g++ myfile.o lex.yy.o y.tab.o -lfl

myfile.o: myfile.c
	g++ -c myfile.c -lfl

y.tab.o: y.tab.c
	g++ -c y.tab.c 

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c 

lex.yy.c: y.tab.h ass3_12CS10037.l
	flex ass3_12CS10037.l

y.tab.c: ass3_12CS10037.y
	yacc -dvl ass3_12CS10037.y


clean:
	rm y.tab.c lex.yy.c ass3_12CS10037.o