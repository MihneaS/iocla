%include "io.inc"

%define NUM_FIBO 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    
    mov eax, 1;
    mov ebx, 1;
    mov ecx, NUM_FIBO;
    
    while1:
        push eax;
        mov edx, eax;
        mov eax, ebx;
        mov ebx, edx;
        add eax, ebx;
    loop while1;
    
    mov ecx, NUM_FIBO;
print:
    PRINT_UDEC 4, [esp + (ecx - 1) * 4]
    PRINT_STRING " "
    dec ecx
    cmp ecx, 0
    ja print

    mov esp, ebp
    xor eax, eax
    ret
