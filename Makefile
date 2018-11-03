teste: teste.o
	ld -m elf_i386 -o teste teste.o

teste.o: teste.asm
	nasm -f elf teste.asm
