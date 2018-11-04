cod: cod.o
	ld -m elf_i386 -o cod cod.o

cod.o: cod.asm
	nasm -f elf cod.asm

teste: teste.o
	ld -m elf_i386 -o teste teste.o

teste.o: teste.asm
	nasm -f elf teste.asm

loc: loc.c
	gcc -g -o loc loc.c
