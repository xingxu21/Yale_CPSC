CC = gcc
CFLAGS = -std=c99 -pedantic -Wall -g3 

TSP: TSP.o location.o lugraph.o
	${CC}  ${CFLAGS} -o TSP TSP.c location.o lugraph.o -lm


Unit: lugraph.o location.o lugraph_unit.o
	${CC} -o $@ ${CFLAGS} $^ -lm

lugraph_unit.o: lugraph.h location.h
location.o: location.h

clean:
	rm -r *.o Unit