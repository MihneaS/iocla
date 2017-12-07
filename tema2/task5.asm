global bruteforce_singlebyte_xor

%macro VERIFY_LETTER 2.nolist
    mov bl, %1
    test bl, bl
    jz notfound
    xor bl, cl
    cmp bl, %2
    jne notfound
%endmacro

section .data
MAXKEY equ 255
TASK5ERR equ 256

section .text

bruteforce_singlebyte_xor:

    push ebp
    mov ebp, esp
    pushad
    pushfd
    
    mov esi, [ebp + 8];  string_addr
    mov edi, [ebp + 12]; key_addr

while1:
    lodsb
    test al, al
    jz err
    xor ecx, ecx
while2:
    VERIFY_LETTER al, 'f'
    VERIFY_LETTER [esi], 'o'
    VERIFY_LETTER [esi + 1], 'r'
    VERIFY_LETTER [esi + 2], 'c'
    VERIFY_LETTER [esi + 3], 'e'
    ;found
    jmp end1
notfound:
    inc cl;
    test cl, cl
    jnz while2
;end of secound while2:
    jmp while1
end1:

    mov [edi], ecx; assumed it all went well
    mov edi, [ebp + 8]
while3:
    mov al, [edi]
    test al, al
    jz end3
    xor [edi], cl
    inc edi
    jmp while3
end3:
    pushf
    pusha
    leave
    ret

err:
    mov DWORD[edi], TASK5ERR;
    jmp end3