tema2: tema2.asm tasks
	nasm -g -f elf32 tema2.asm -o tema2.o 
	gcc -g -m32 -o $@ *.o

tasks: task1 task2 task3 task4 task5 task6

task1: task1.asm
	nasm -g -f elf32 -o task1.o $<

task2: task2.asm
	nasm -g -f elf32 -o task2.o $<

task3: task3.asm
	nasm -g -f elf32 -o task3.o $<

task4: task4.asm
	nasm -g -f elf32 -o task4.o $<

task5: task5.asm
	nasm -g -f elf32 -o task5.o $<

task6: task6.asm
	nasm -g -f elf32 -o task6.o $<

clean:
	rm -f tema2 *.o

run: tema2
	./tema2
