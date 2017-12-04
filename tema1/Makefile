
test = 31

all: run

prep: include.inc io.inc

assemble: tema1.asm include.inc
	nasm -g -f elf32 -o tema1.o tema1.asm

link: assemble
	gcc tema1.o objects/macro.o -g -o exec -m32

include.inc:
	cp inputs/input$(test).inc ./input.inc

io.inc:
	cp ~/facultate/iocla/SASM/Linux/share/sasm/include/io.inc .

run: link
	./exec
