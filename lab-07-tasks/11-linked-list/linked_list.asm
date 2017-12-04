%include "io.inc"

extern malloc

struc list_elem
    next: resd 1
    value: resd 1
endstruc

section .data  
list_start: dd 0

source_array: dd 424, 12, 98, 6243, 1349, 512, 915, 24012, 523, 634

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    ; Example of allocating a list_elem:
    mov eax, list_elem_size
    push eax
    call malloc
    add esp, 4
    ; Address of newly allocated element is stored in eax
    mov [list_start], eax  

    ; TODO: Create a linked list containing the elements of source_array

    ; TODO: Print the linked list

    leave
    ret
