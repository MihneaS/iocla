%include "io.inc"

extern puts
extern printf

extern xor_strings
extern rolling_xor
extern xor_hex_strings
extern base32decode
extern bruteforce_singlebyte_xor
extern break_substitution

section .data
filename: db "./input.dat",0
inputlen: dd 2263
fmtstr: db "Key: %d",0xa,0
;substitution_table: db " ce tkaqogsliin.rsdehymhlfcwwnum.xfupdyzgtvjbrkpjoxbzvqa", 0xa, 0
substitution_table: db "aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz  ..", 0xa, 0

addr_str8: dd 0

MAXKEY equ 255
TASK5ERR equ 256

section .text
global main



%macro END_IF_NULL 0.nolist
    test edx, edx
    jnz t4end
%endmacro

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



base32decode2:
    push ebp
    mov ebp, esp
    pushad
    pushfd

    mov edi, [ebp + 8]
    mov esi, edi
    xor edx, edx

    mov ecx, [ebp + 12]
    PRINT_HEX 4, [ecx +4*8]
    NEWLINE


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
    
;    PRINT_HEX 4,[ecx +4*8]
;    NEWLINE
    
    
    jmp t4while
t4end:
    pushfd
    
    PRINT_HEX 4,[ecx +4*8]
    NEWLINE
    
    pushad
    
    mov eax, [ebp + 12]
        PRINT_HEX 4, [eax + 8*4]
    NEWLINE
    
    
    leave
    ret




; TODO: define functions and helper functions
next_string:
    xor eax, eax
    mov edi, ecx
    mov ecx, -1
    cld
    repnz scasb
    mov ecx, edi;
    ret

break_substitution2:
    push ebp
    mov ebp, esp
    pusha
    pushf

    mov esi, [ebp + 8]; str_addr
;    PRINT_HEX 4, esi
;    NEWLINE
    mov edi, [ebp + 12]; substitution_table    

xor ecx,ecx
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
    
inc ecx    
    jmp while1
end1:
    pushf
    pusha
    leave
    ret

main:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    sub esp, 2300

    ; fd = open("./input.dat", O_RDONLY);
    mov eax, 5
    mov ebx, filename
    xor ecx, ecx
    xor edx, edx
    int 0x80

    ; read(fd, ebp-2300, inputlen);
    mov ebx, eax
    mov eax, 3
    lea ecx, [ebp-2300]
    mov edx, [inputlen]
    int 0x80

    ; close(fd);
    mov eax, 6
    int 0x80

    ; all input.dat contents are now in ecx (address on stack)
    
    ;compute all string addresses and store them
    ;reserve space for addresses
    sub esp, 9*4 +200
    
    ;compute
    mov [esp + 1*4], ecx; addr_str1;
    call next_string
    mov [esp + 2*4], ecx; addr_str2;
    call next_string
    mov [esp + 3*4], ecx; addr_str3;
    call next_string
    mov [esp + 4*4], ecx; addr_str4;
    call next_string
    mov [esp + 5*4], ecx; addr_str5;
    call next_string
    mov [esp + 6*4], ecx; addr_str6;
    call next_string
    mov [esp + 7*4], ecx; addr_str7;
    call next_string
    mov [esp + 8*4], ecx; addr_str8;
    mov [addr_str8], ecx;
;    PRINT_HEX 4, [addr_str8]
;    NEWLINE
;    PRINT_HEX 4, [esp + 8*4]
;    NEWLINE
    push esp
    

    ; TASK 1: Simple XOR between two byte streams
    pop eax;
    push eax;
    push DWORD[eax + 1*4]; push addr_str1
    push DWORD[eax + 2*4]; push addr_str2
    call xor_strings
    add esp, 8; pop arguments

    ; Print the first resulting string

    pop eax
    push eax
    push DWORD[eax + 4*1]
    call puts
    add esp, 4; pop ruined argument of puts
    
    ; TASK 2: Rolling XOR
    pop eax;
    push eax;
    push DWORD[eax + 3*4];push addr_str3
    call rolling_xor
    add esp, 4

    ; Print the second resulting string
    ;push addr_str3; already pushed
    pop eax;
    push eax;
    push DWORD[eax + 3*4];push addr_str3
    call puts
    pop ecx;

    ; TASK 3: XORing strings represented as hex strings

    pop eax
    push eax
    push DWORD[eax + 4*5];push addr_str5
    push DWORD[eax + 4*4];push addr_str4
    call xor_hex_strings
    add esp, 8

    ; Print the third string
    pop eax
    push eax
    push DWORD[eax + 4*4];push addr_str4
    call puts
    add esp, 4;
    
    ; TASK 4: decoding a base32-encoded string

    pop eax
;PRINT_HEX 4, [eax + 8*4]
;NEWLINE

    push eax
    push DWORD[eax + 6*4]; addr_str6
    call base32decode2
    
;pop eax
;push eax
;PRINT_HEX 4, [eax + 8*4]
;NEWLINE

;    PRINT_HEX 4, [addr_str8]
;    NEWLINE
    
    add esp, 4

    ; Print the fourth string
    pop eax
    push eax
    push DWORD[eax + 6*4]; addr_str6
    call puts
    add esp, 4

    ; TASK 5: Find the single-byte key used in a XOR encoding
    pop eax
    push eax
    push eax;push key_addr
    push DWORD[eax + 7*4];push addr_str7
    call bruteforce_singlebyte_xor
    add esp, 0; keep em on stack

    ; Print the fifth string and the found key value
    ;done push ecx;push addr_str7
    call puts
    add esp, 4; pop addr_str7, keep key_addr on stack

    pop ebx
    push DWORD[ebx];push keyvalue
    push fmtstr
    call printf
    add esp, 8

    ; TASK 6: Break substitution cipher
    pop eax
    push eax
    mov eax, substitution_table
    push eax
;    PRINT_HEX 4, [eax + 8*4]
;    NEWLINE
;    push DWORD[eax + 8*4];push addr_str8
    push DWORD[addr_str8]
    call break_substitution2
    add esp, 8

    ; Print final solution (after some trial and error)
    pop eax
    push eax
    push DWORD[eax + 8*4];push addr_str8
    call puts
    add esp, 4

    ; Print substitution table
    push substitution_table
    call puts
    add esp, 4

    ; Phew, finally done
    xor eax, eax
    leave
    ret
