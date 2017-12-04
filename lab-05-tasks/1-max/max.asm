%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ; cele doua numere se gasesc in eax si ebx
    mov eax, 4
    mov ebx, 1 

loop1:

    push eax;
    push ebx;
    pop eax;
    pop ebx;

    cmp ebx, eax
    jg loop1

    ; TODO: aflati maximul folosind doar o instructiune de salt si push/pop

    PRINT_DEC 4, eax ; afiseaza minimul
    NEWLINE

    ret
