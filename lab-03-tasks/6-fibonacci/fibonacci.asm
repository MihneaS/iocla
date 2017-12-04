%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7
    mov ebx, 1;
    mov ecx, 0;
    xchg eax, ecx;
for:
    xchg ebx, eax;
    add ebx, eax;
    loop for;
    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)
    PRINT_DEC 4, eax;
    ret