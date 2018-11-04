#include <stdio.h>

int main(int argc, char **argv) {
    register char* esp asm("esp");
    register char* ebp asm("ebp");

    printf("esp aponta para: %p\n", esp);
    printf("ebp aponta para: %p\n", ebp);
    printf("Endereco argc: %p\n", &argc);
    printf("Endereco argv: %p\n", &argv);
    printf("Endereco argv[0]: %p\n", argv);
}

