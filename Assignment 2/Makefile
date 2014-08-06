a.out: mainMyl.o libmyl.a
	cc -m32 mainMyl.o -L. -lmyl
mainMyl.o: mainMyl.c myl.h
	cc -Wall -m32 -c mainMyl.c
libmyl.a: myl.o
	ar -rcs libmyl.a myl.o
myl.o: myl.c myl.h
	cc -Wall -m32 -c myl.c

clean:
	rm mainMyl.o libmyl.a myl.o a.out