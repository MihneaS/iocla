%include "io.inc"

section .data
    %include "input.inc"
    bad_base: db "Baza incorecta", 0

section .text
global CMAIN
CMAIN:
    mov  ebp, esp

    xor  ecx, ecx
forbeg:
    cmp  ecx, [nums]
    jae  forend

    cmp  DWORD[base_array + 4*ecx], 2;  if base_array[ecx] < 2
    jb  badbase;
    cmp  DWORD[base_array + 4*ecx], 16; if base_array[ecx] > 16
    ja   badbase

    mov  eax, [nums_array + 4*ecx];     eax = nums_array[ecx]
;push digits in new base on stack
dowhile1:
    xor  edx, edx
    div  DWORD[base_array + 4*ecx];     eax = base_array[ecx]
    push dx
    test eax, eax
    jnz  dowhile1
;print digits
dowhile2:
    pop  ax
    cmp  ax, 9
    ja   isalpha
    add  ax, '0'
    jmp  endif
isalpha:
    add  ax, 'a' - 10
endif:
    PRINT_CHAR al
    cmp  esp, ebp;                      if stack is not empty
    jnz  dowhile2
    NEWLINE
    jmp forinc

badbase:
    PRINT_STRING bad_base
    NEWLINE
    jmp forinc

forinc:
    inc  ecx
    jmp  forbeg
forend:

    xor  eax, eax
    mov  esp, ebp
    ret
