%include "io.inc"

struc stud_struct
    .name: resb 32
    .surname: resb 32
    .age: resb 1
    .group: resb 8
    .gender: resb 1
    .birth_year: resw 1
endstruc

section .data

string_name db "Name: ", 0
string_surname db "Surname: ", 0
string_age db "Age: ", 0
string_group db "Group: ", 0
string_gender db "Gender: ", 0
string_year db "Birth year: ", 0

name db "Andrei", 0
surname db "Voinea", 0
group db "321CA", 0

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 100

    mov esi, group
    lea edi, [ebp - 100 + stud_struct.group]
    mov ecx, 6
    rep movsb

    ; TODO: Fill name, surname, birth_year, gender and age.
    ; Use rep movsb and name and surname global variables to filll
    ; name and surname fields in structure.
    ; Use any value you like for birth_year, gender and age.
    ; The base address of the structure is (ebp - 100)

    lea eax, [ebp - 100 + stud_struct.name]
    PRINT_STRING string_name
    PRINT_STRING [eax]
    NEWLINE
    lea eax, [ebp - 100 + stud_struct.surname]
    PRINT_STRING string_surname
    PRINT_STRING [eax]
    NEWLINE
    mov al, byte [ebp - 100 + stud_struct.age]
    PRINT_STRING string_age
    PRINT_UDEC 1, al
    NEWLINE
    lea eax, [ebp - 100 + stud_struct.group]
    PRINT_STRING string_group
    PRINT_STRING [eax]
    NEWLINE
    mov al, byte [ebp - 100 + stud_struct.gender]
    PRINT_STRING string_gender
    PRINT_UDEC 1, al
    NEWLINE
    mov ax, [ebp - 100 + stud_struct.birth_year]
    PRINT_STRING string_year
    PRINT_UDEC 2, ax
    NEWLINE

    leave
    ret
