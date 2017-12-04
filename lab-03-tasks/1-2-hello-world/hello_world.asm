%include "io.inc"

section .data
    myString: db "Hello, World!",0
    bye: db "Goodbye, world!",0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, 6                 ; N = valoarea registrului ecx
    mov eax, 5
    mov ebx, 4
    cmp eax, ebx
    jg print                   ; TODO1: eax > ebx?
    ret
print:
    PRINT_STRING myString
    NEWLINE
    sub ecx, 1;
    jg print
    PRINT_STRING bye           ; TODO2.1: afisati "Goodbye, World!"

    ret
