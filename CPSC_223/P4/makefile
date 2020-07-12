CC = gcc
CFLAGS = -std=c99 -pedantic -Wall -g3

All: Blotto Unit

Blotto: blotto.c smap.o entry.o
	${CC} ${CFLAGS} -o Blotto blotto.c smap.o entry.o -lm

Unit: smap_unit.c smap.o smap_test_functions.o
	${CC} ${CFLAGS} -o Unit smap_unit.c smap.o smap_test_functions.o -lm

entry.o: entry.c entry.h
	${CC} ${CFLAGS} -c entry.c -lm

smap_test_functions.o: smap_test_functions.c smap_test_functions.h
	${CC} ${CFLAGS} -c smap_test_functions.c -lm

smap.o: smap.c smap.h 
	${CC} ${CFLAGS} -c smap.c -lm

clean: 
	rm -r *.o 

