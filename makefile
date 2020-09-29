all: main

simple_io.o: simple_io.asm
	nasm -felf64 -o simple_io.o simple_io.asm
main.o: main.asm simple_io.inc
	nasm -felf64 -o main.o main.asm
main: driver.c main.o simple_io.o
	gcc -o main driver.c main.o simple_io.o

