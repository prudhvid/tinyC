compile:compiler asm_file
	gcc -m32 out.s
asm_file:compiler
	./compiler ass5_12CS10037_test.c > out.s

compiler: y.tab.o lex.yy.o target_generate.o
	g++ -o compiler lex.yy.o y.tab.o ass5_12CS10037_translator.o quad.o SymbolTable.o target_generate.o -lfl

target_generate.o: target_generate.cpp
	g++ -g -c target_generate.cpp -lfl

y.tab.o: y.tab.c y.tab.h
	g++ -g -c -Wno-write-strings y.tab.c 

lex.yy.o: lex.yy.c ass5_12CS10037_translator.o
	g++ -g -c lex.yy.c

lex.yy.c: y.tab.h ass5_12CS10037.l ass5_12CS10037_translator.o
	flex ass5_12CS10037.l

y.tab.c: ass5_12CS10037.y
	yacc -dtv  ass5_12CS10037.y



ass5_12CS10037_translator.o:ass5_12CS10037_translator.h ass5_12CS10037_translator.cpp quad.o SymbolTable.o
	g++ -g -c ass5_12CS10037_translator.cpp

quad.o: quad.cpp quad.h y.tab.h
	g++ -g -c quad.cpp

SymbolTable.o: SymbolTable.cpp SymbolTable.h
	g++ -g -c SymbolTable.cpp

clean:
	rm y.tab.c y.tab.h lex.yy.c ass5_12CS10037.o *.o compiler out.s y.output