%include "io.inc"

extern puts
extern printf

    %macro NEXT_STRING 0
     xor eax, eax
     mov edi, ecx
     mov ecx, -1
     cld

     repne scasb
     mov ecx, edi;
    %endmacro

section .data
filename: db "./input.dat",0
inputlen: dd 2263
fmtstr: db "Key: %d",0xa,0

section .text
global main

; TODO: define functions and helper functions
xor_strings:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]

t1while:
    lodsb
    test al ,al
    jz t1end
    xor [edi], al
    inc edi
    jmp t1while

t1end:
    leave
    ret



rolling_xor:
    mov ebp, esp
    push ebp

    mov edi, [ebp + 8]
    mov esi, edi
    inc esi; we've just assumed the string is not empty

    push edi
    push esi
    call xor_strings
    add esp, 8

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

    ; TASK 1: Simple XOR between two byte streams
    ; TODO: compute addresses on stack for str1 and str2
    mov edx, ecx; mov edx, addr_str1
    NEXT_STRING
    push edx; push addr_str1
    push ecx; push addr_str2
    ; TODO: XOR them byte by byte
    call xor_strings
    add esp, 4; pop addr_str2, keeps addr_str1 for puts

    ; Print the first resulting string
    ;push addr_str1; already done
    call puts
    add esp, 4
    mov ecx, edx; restore ecx
    

    ; TASK 2: Rolling XOR
    ; TODO: compute address on stack for str3
    NEXT_STRING
    push ecx;push addr_str3

    xor eax, eax    ; TODO: implement and apply rolling_xor function
    call rolling_xor
;    add esp, 0 ; keep addr_str3 on stack for puts

    ; Print the second resulting string
    ;push addr_str3; already pushed
;    call puts
;    add esp, 4

	
	; TASK 3: XORing strings represented as hex strings
	; TODO: compute addresses on stack for strings 4 and 5
	; TODO: implement and apply xor_hex_strings
	;push addr_str5
	;push addr_str4
	;call xor_hex_strings
	;add esp, 8

	; Print the third string
	;push addr_str4
	;call puts
	;add esp, 4
	
	; TASK 4: decoding a base32-encoded string
	; TODO: compute address on stack for string 6
	; TODO: implement and apply base32decode
	;push addr_str6
	;call base32decode
	;add esp, 4

	; Print the fourth string
	;push addr_str6
	;call puts
	;add esp, 4

	; TASK 5: Find the single-byte key used in a XOR encoding
	; TODO: determine address on stack for string 7
	; TODO: implement and apply bruteforce_singlebyte_xor
	;push key_addr
	;push addr_str7
	;call bruteforce_singlebyte_xor
	;add esp, 8

	; Print the fifth string and the found key value
	;push addr_str7
	;call puts
	;add esp, 4

	;push keyvalue
	;push fmtstr
	;call printf
	;add esp, 8

	; TASK 6: Break substitution cipher
	; TODO: determine address on stack for string 8
	; TODO: implement break_substitution
	;push substitution_table_addr
	;push addr_str8
	;call break_substitution
	;add esp, 8

	; Print final solution (after some trial and error)
	;push addr_str8
	;call puts
	;add esp, 4

	; Print substitution table
	;push substitution_table_addr
	;call puts
	;add esp, 4

    ; Phew, finally done
    xor eax, eax
    leave
    ret
