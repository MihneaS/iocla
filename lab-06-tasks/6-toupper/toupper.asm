%include "io.inc"
extern printf

section .data
    before_format db "before %s", 13, 10, 0
    after_format db "after %s", 13, 10, 0
    mystring db "abcdefghij", 0
    

section .text
global CMAIN

rot13:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8]
    
while2:
    mov bl, byte[eax]
    test bl, bl
    jz endfunction2
    cmp bl, 'a' + 13
    jg jum2
    add bl, 13
    jmp end
    jum2:
    sub bl, 13;
    end:
    mov byte[eax], bl;
    inc eax
    jmp while2
endfunction2:
    leave
    ret

toupper:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8]

while:
    mov bl, byte[eax]
    test bl, bl
    jz endfunction
    cmp bl, 'a'
    jl whileupper:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8]

while:
    mov bl, byte[eax]
    test bl, bl
    jz endfunction
    cmp bl, 'a'
    jl while
    cmp bl, 'z'
    jg while
    sub bl, 0x20;
    mov byte[eax], bl;
    inc eax
    jmp while
endfunction:
    leave
    ret

    cmp bl, 'z'
    jg while
    sub bl, 0x20;
    mov byte[eax], bl;
    inc eax
    jmp while
endfunction:
    leave
    ret

CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    push mystring
    push before_format
    call printf
    add esp, 8

    push mystring
    call rot13
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8
    
    push mystring
    call toupper
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8

    leave
    ret
