global bruteforce_singlebyte_xor

%macro T5_VERIFY_LETTER 2.nolist
    mov bl, %1
    test bl, bl
    jz t5notfound
    xor bl, cl
    cmp bl, %2
    jne t5notfound
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

t5while1:
    lodsb
    test al, al
    jz t5err
    xor ecx, ecx
t5while2:
    T5_VERIFY_LETTER al, 'f'
    T5_VERIFY_LETTER [esi], 'o'
    T5_VERIFY_LETTER [esi + 1], 'r'
    T5_VERIFY_LETTER [esi + 2], 'c'
    T5_VERIFY_LETTER [esi + 3], 'e'
    ;found
    jmp t5end1
t5notfound:
    inc cl;
    test cl, cl
    jnz t5while2
;t5end2:
    jmp t5while1
t5end1:

    mov [edi], ecx; assumed it all went well
    mov edi, [ebp + 8]
t5while3:
    mov al, [edi]
    test al, al
    jz t5end3
    xor [edi], cl
    inc edi
    jmp t5while3
t5end3:
    pushf
    pusha
    leave
    ret

t5err:
    mov DWORD[edi], TASK5ERR;
    jmp t5end3