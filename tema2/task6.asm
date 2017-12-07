global break_substitution

section .text

break_substitution:
    push ebp
    mov ebp, esp
    pusha
    pushf

    mov esi, [ebp + 8]; str_addr
    mov edx, [ebp + 12]; substitution_table 
            
    cld
while1:
    lodsb
    test al, al
    jz end1

    mov edx, [ebp + 12]; substitution_table     
while2:
    cmp al, [edx]
    je end2
    add edx, 2
    jmp while2
end2:    
    mov al, [edx + 1]
    mov [esi - 1], al
    
    jmp while1
end1:
      

    pushf
    pusha
    leave
    ret
