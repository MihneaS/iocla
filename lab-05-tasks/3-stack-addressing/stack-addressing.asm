%include "io.inc"

%define NUM 5

section .text
global CMAIN
CMAIN:
    PRINT_HEX 4, esp
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands
    mov ecx, NUM
push_nums:
    sub esp, 4;
    mov [esp],ecx
    loop push_nums

    ;push 0
    mov DWORD[esp], 0x0
    PRINT_STRING [esp]
    NEWLINE
    sub esp, 4
    mov DWORD[esp], "mere"
    ;push "mere"
    PRINT_STRING [esp]
    NEWLINE
    sub esp, 4
    mov DWORD[esp], "are "
    
    ;push "are "
    PRINT_STRING [esp]
    NEWLINE
    sub esp, 4
    mov DWORD[esp], "Ana "

    PRINT_STRING [esp]
    NEWLINE


    mov ecx, esp;
    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
loop2:

    PRINT_UDEC 4,ecx;
    PRINT_STRING ":"
    mov eax, [ecx]
    PRINT_UDEC 4, eax;
    PRINT_STRING "/"
    PRINT_STRING [ecx]
    NEWLINE
    add ecx, 4
    cmp ecx, ebp
    jne loop2
    PRINT_UDEC 4,ecx;
    PRINT_STRING ":"
    mov eax, [ecx]
    PRINT_UDEC 4, eax;
    NEWLINE
    ;PRINT_UDEC 4,DWORD[esp]

    ; TODO 3: print the string
    
    PRINT_STRING [esp]

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    NEWLINE
    PRINT_HEX 4, esp
    ret
