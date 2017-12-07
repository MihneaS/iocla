global base32decode

%macro END_IF_NULL 0.nolist
    test edx, edx
    jnz t4end
%endmacro

section .text
nextdecoded32char:
    lodsb
    cmp al, '='
    ja aux4alpha
    jb aux4numnull
    xor al, al
    jmp aux4end

aux4numnull:
    test al, al
    jz aux4null
    sub al, '2'
    add al, 26
    jmp aux4end

aux4null:
    xor al, al
    inc dl
    jmp aux4end

aux4alpha:
    sub al, 'A'
    jmp aux4end

aux4end:
    ret



base32decode:
    push ebp
    mov ebp, esp
    pushad
    pushfd

    mov edi, [ebp + 8]
    mov esi, edi
    xor edx, edx

t4while:
                                            ;edi[0]
                                                ;esi[0]
    call nextdecoded32char; al = esi[0]
    mov [edi], dl; edi[0] = 0;must be called after al=esi[0]
    shl al, 3
    add [edi], al; edi[0] += esi[0] << 3
                                                ;esi[1]
    call nextdecoded32char; al = esi[1]
    mov bl, al;
    shr al, 2
    add [edi], al; edi[0] += esi[1] >> 2
                                            ;edi[1]
    mov [edi + 1], dl; edi[1] = 0
                                                ;esi[1]
    mov al, bl;
    shl al, 6;
    add [edi + 1], al
                                                ;esi[2]
    call nextdecoded32char; al = esi[2]
    shl al, 1;
    add [edi + 1], al
                                                ;esi[3]
    call nextdecoded32char; al = esi[3]
    mov bl, al
    shr al, 4
    add [edi + 1], al
                                            ;edi[2]
    mov [edi + 2], dl; edi[2] = 0
                                                ;esi[3]
    mov al, bl
    shl al, 4
    add [edi + 2], al
                                                ;esi[4]
    call nextdecoded32char; al = esi[4]
    mov bl, al
    shr al, 1
    add [edi + 2], al
                                            ;edi[3]
    mov [edi + 3], dl
                                                ;esi[4]
    mov al, bl
    shl al, 7
    add [edi + 3], al
                                                ;esi[5]
    call nextdecoded32char; al = esi[5]
    shl al, 2
    add [edi + 3], al
                                                ;esi[6]
    call nextdecoded32char; al = esi[6]
    mov bl, al
    shr al, 3
    add [edi + 3], al
                                            ;edi[4]
    mov [edi + 4], dl
                                                ;esi[6]
    mov al, bl
    shl al, 5
    add [edi + 4], al
                                                ;esi[7]
    call nextdecoded32char; al = esi[7]
    add [edi + 4], al

    ; increment edi 5 times
    add edi, 5
    END_IF_NULL
    jmp t4while
t4end:
    pushfd
    pushad
    leave
    ret
