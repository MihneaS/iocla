%include "io.inc"

extern printf

section .data
    string db "Lorem ipsum dolor sit amet.", 0
    print_format_strlen db "strlen('%s') = %d", 10, 0
    print_format_occ db "occurences('%s' , '%c') = %d", 10, 0

    length dd 0
    char db 'i'

section .text
global CMAIN

strlen:
    push ebp
    mov ebp, esp

    mov edi, [ebp + 8]


    xor ecx, ecx
    xor eax, eax;
while:
    inc ecx
    scasb
    jnz while 

    dec ecx
    mov eax, ecx
    leave
    ret
    ; TODO find number of occurences of a

occurences:
    ;      in a string using scasb
    ; EBP + 8  - string to search in
    ; EBP + 12 - length of the string
    ; EBP + 16 - character to search for

    push ebp;
    mov ebp, esp;

    mov edi, [ebp + 8]
    mov ecx, [ebp + 12]
    mov eax, [ebp + 16]

    cld

    xor ebx, ebx
    whilea:
    repne scasb
    inc ebx;
    cmp byte[edi - 1], al
    jz whilea

    dec ebx;
    mov eax, ebx
    leave
    ret

CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    ; call the strlen function
    push string
    call strlen
    add esp, 4

    ; save the result in at address length
    mov [length], eax

    ; print the result of strlen
    push eax
    push string
    push print_format_strlen
    call printf
    add esp, 12

    ; initialize the char to be found
    ; char in bl must be promoted to double-word ebx when passed on the stack
    xor ebx, ebx
    mov bl, [char]

    ; call the occurences function
    push ebx
    push dword [length]
    push string
    call occurences
    add esp, 8
    pop ebx

    ; print the number of occurences of the char
    push eax
    push ebx
    push string
    push print_format_occ
    call printf
    add esp, 16

    xor eax, eax
    leave
    ret
