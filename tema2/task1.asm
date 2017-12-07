global xor_strings

section .text

xor_strings:
    push ebp
    mov ebp, esp
    pushf
    push eax
    push edi
    push esi

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]

while:
    lodsb
    test al ,al
    jz end
    xor [edi], al
    inc edi
    jmp while

end:
    pop esi
    pop edi
    pop eax
    popf
    leave
    ret
