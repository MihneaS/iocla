%include "io.inc"

struc stud_struct
    name: resb 32
    surname: resb 32
    age: resb 1
    group: resb 8
    gender: resb 1
    birth_year: resw 1
endstruc

%define NUM_STUDENTS 20

; .bss section is used for unitialized data.
section .bss

; `students' is an array of structures. There are NUM_STUDENTS items in the
; array of size STRUCT_SIZE. We use a large enough STRUCT_SIZE to cover
; for the size of the stud_struct structure.
students resb stud_struct_size*NUM_STUDENTS

section .data

string_name db "Name: ", 0
string_surname db "Surname: ", 0
string_age db "Age: ", 0
string_group db "Group: ", 0
string_gender db "Gender: ", 0
string_year db "Birth year: ", 0

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    ; ecx is the index in the array of structures.
    ; We start from the last item (index NUM_STUDENTS-1) and go down to the
    ; first item (index 0).
    mov ecx, NUM_STUDENTS
init_student:
    dec ecx

    ; We use eax tot compute the memory offset of the current item in the
    ; array. eax <- STRUCT_SIZE * ecx.
    mov eax, stud_struct_size 
    mul ecx

    ; We use ebx to store the start address of the current item in the
    ; array. We initialize ebx to the array address (students) and then
    ; we add the memory offset computed above in eax.
    mov ebx, students
    add ebx, eax

    ; We refer fields in the structure as offsets to ebx.
    mov byte [ebx + age], 21
    mov word [ebx + birth_year], 1995
    mov byte [ebx + gender], 2
    mov byte [ebx + group], 0
    mov byte [ebx + name], 0
    mov byte [ebx + surname], 0

    ; We stop after we reach the first item in the array.
    test ecx, ecx
    jnz init_student

    mov ecx, NUM_STUDENTS
print_student:
    dec ecx
    mov eax, stud_struct_size 
    mul ecx
    mov ebx, students
    add ebx, eax
    push ecx
    lea eax, [ebx + name]
    PRINT_STRING string_name
    PRINT_STRING [eax]
    NEWLINE
    lea eax, [ebx + surname]
    PRINT_STRING string_surname
    PRINT_STRING [eax]
    NEWLINE
    mov al, byte [ebx + age]
    PRINT_STRING string_age
    PRINT_UDEC 1, al
    NEWLINE
    lea eax, [ebx + group]
    PRINT_STRING string_group
    PRINT_STRING [eax]
    NEWLINE
    mov al, byte [ebx + gender]
    PRINT_STRING string_gender
    PRINT_UDEC 1, al
    NEWLINE
    mov ax, [ebx + birth_year]
    PRINT_STRING string_year
    PRINT_UDEC 2, ax
    NEWLINE
    pop ecx
    test ecx, ecx
    jnz print_student

    leave
    ret
