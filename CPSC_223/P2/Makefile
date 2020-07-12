CFLAGS=-std=c99 -g3 -pedantic -Wall
CC=gcc

TSP: TSP.o location.o 
	${CC}  ${CFLAGS} -o TSP TSP.c location.o -lm

TSP.o: TSP.c location.h
	${CC} ${CFLAGS} -c TSP.c

location.o: location.c 
	${CC} ${CFLAGS} -c location.c

clean:
	rm -r *.o TSP