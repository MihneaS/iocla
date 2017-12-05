tema2: tema2.asm
	nasm -g -f elf32 -o tema2.o $<
	gcc -g -m32 -o $@ tema2.o

clean:
	rm -f tema2 tema2.o

run: tema2
	./tema2
