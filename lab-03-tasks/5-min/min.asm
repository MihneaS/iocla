%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;cele doua numere se gasesc in eax si ebx
    mov eax, 4
    mov ebx, 1
    cmp eax, ebx;
    jl print;
    xchg eax, ebx;
    ; TODO: aflati minimul
   print:
    PRINT_DEC 4, eax ; afiseaza minimul
    NEWLINE

    ret