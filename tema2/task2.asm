global rolling_xor

extern xor_strings

section .text

rolling_xor:
    push ebp
    mov ebp, esp
    pusha
    pushf
    mov esi, [ebp + 8]
    mov edi, esi
    inc edi; we've just assumed the string is not empty
    ; save first character
    mov dl, [esi]
    ; roll xor everthing
    push esi
    push edi
    call xor_strings
    add esp, 8
    ; move string 1 byte rigjt
    cld
t2while:
    mov al, [esi]
    test al, al
    jz t2end
    mov [esi], dl;
    mov dl, al
    inc esi
    jmp t2while
t2end:
    popf
    popa
    leave
    ret
