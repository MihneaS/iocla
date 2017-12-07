global break_substitution

section .text

break_substitution:
    push ebp
    mov ebp, esp
    pusha
    pushf

    mov esi, [ebp + 8]; str_addr
    mov edi, [ebp + 12]; substitution_table    

while1:
    lodsb
    test al, al
    jz end1
    
    mov edi, [ebp + 12]
while2:
    cmp eax, [edi]
    ;je end2
    ;add edi, 2
    ;inc edi
    ;jmp while2
end2:
    mov bl, [edi + 1]
    mov [esi - 1], bl
    
    jmp while1
end1:
    pushf
    pusha
    leave
    ret
