CFLAGS=-std=c99 -g3 -pedantic -Wall
CC=gcc

ParseGPX: ParseGPX.o
	${CC}  ${CFLAGS} ParseGPX.o -o ParseGPX

ParseGPX.o: ParseGPX.c
	${CC} ${CFLAGS} -c ParseGPX.c