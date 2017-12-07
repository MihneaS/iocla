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
substitution_table: db  "c  ektqagolsii.nsredyhhmflwcnwmux.ufdpzytgjvrbpkojbxvzaq", 0xa, 0

section .text
global main

; TODO: define functions and helper functions
next_string:
    xor eax, eax
    mov edi, ecx
    mov ecx, -1
    cld
    repnz scasb
    mov ecx, edi;
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
    push eax
    push DWORD[eax + 6*4]; addr_str6
    call base32decode
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
    ; addr_str7 already pushed
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
    mov ebx, substitution_table
    push ebx

    push DWORD[eax + 8*4];push addr_str8
    call break_substitution
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
