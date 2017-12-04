%include "io.inc"

struc stud_struct
    name: resb 32
    surname: resb 32
    age: resb 1
    group: resb 8
    gender: resb 1
    birth_year: resw 1
    id: resb 16
endstruc

section .data

sample_student:
    istruc stud_struct
        at name, db 'Andrei', 0
        at surname, db 'Voinea', 0
        at age, db 21
        at group, db '321CA', 0
        at gender, db 1
        at birth_year, dw 1994
        at id, db 0
    iend

print_format db "ID: %s", 0

section .text
global CMAIN

fill_id:
    ; TODO set the id fielt of the structure given as an argument
    ret

CMAIN:
    push ebp
    mov ebp, esp

    ; call the fill_id function to set the student's ID
    push sample_student
    call fill_id
    add esp, 4

    ; print the new ID added
    lea eax, [sample_student + id]
    push eax
    push print_format
    call printf
    add esp, 8

    leave
    ret
