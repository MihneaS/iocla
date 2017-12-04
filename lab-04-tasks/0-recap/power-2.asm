%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 211     ; to be broken down into powers of 2
    mov ebx, 1       ; stores the current power
    mov ecx, 32
    
    while:
    test ebx, eax;
    jz dontwrite    
    PRINT_DEC 4, ebx;
    NEWLINE    
    dontwrite:
    SHL ebx, 1;
    sub ecx, 1;       
    jnz while
    
    xor eax, eax
    ret