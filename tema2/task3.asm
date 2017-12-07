global xor_hex_strings

section .text

ascii_hex_to_udec:

    cmp al, '9'
    jg aux2alpha
    sub al, '0'
    jmp aux2end
aux2alpha:
    sub al, 'a' - 10
aux2end:
    ret



hex_enc_to_byte:
    xor eax, eax
    ;first char
    lodsb
    test al, al
    jz aux3endofstring
    call ascii_hex_to_udec
    mov bl, 16
    mul bl; assuming multiplication result fits in al
    mov bl, al
    ;second char
    lodsb
    call ascii_hex_to_udec
    add al, bl
    ret
aux3endofstring:
    ret


xor_hex_strings:
    push ebp
    mov ebp, esp
    pusha
    pushf

    mov edi, [ebp + 8]; place to write
    mov ecx, edi; encoded string
    mov edx, [ebp + 12]; key
    xor eax, eax
t3while:
    ;encoded byte
    mov esi, ecx
    call hex_enc_to_byte
    jz t3end
    mov ecx, esi
    ;save it
    push ax
    ;key byte
    mov esi, edx
    call hex_enc_to_byte
    mov edx, esi
    ;recover encoded byte
    pop bx
    ;xor and write bytes
    xor al, bl
    stosb
    jmp t3while
t3end:
    ;adding '\0'
    xor al, al
    stosb
    popf
    popa
    leave
    ret
