%include "io.inc"

extern puts
extern printf


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

next_str:
    push ebp
    mov ebp, esp
    
    
    
    leave
    ret


main:
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

           PRINT_STRING [ecx]
           NEWLINE
           PRINT_STRING [ecx + 22]
           NEWLINE
           ;xor eax, eax;
           mov al, [ecx + 22]
           xor [ecx], al
           mov al, [ecx + 23]
           xor [ecx+1], al
           mov al, [ecx + 24]
           xor [ecx+2], al
           mov al, [ecx + 25]
           xor [ecx+3], al
           mov al, [ecx + 26]
           xor [ecx+4], al
           mov al, [ecx + 27]
           xor [ecx+5], al
           mov al, [ecx + 28]
           xor [ecx+6], al
           mov al, [ecx + 29]
           xor [ecx+7], al
           mov al, [ecx + 30]
           xor [ecx+8], al
           mov al, [ecx + 31]
           xor [ecx+9], al
           mov al, [ecx + 32]
           xor [ecx+10], al
           mov al, [ecx + 33]
           xor [ecx+11], al
           mov al, [ecx + 34]
           xor [ecx+12], al
           mov al, [ecx + 35]
           xor [ecx+13], al
           mov al, [ecx + 36]
           xor [ecx+14], al
           mov al, [ecx + 37]
           xor [ecx+15], al
           mov al, [ecx + 38]
           xor [ecx+16], al
           mov al, [ecx + 39]
           xor [ecx+17], al
           mov al, [ecx + 40]
           xor [ecx+18], al
           mov al, [ecx + 41]
           xor [ecx+19], al
           mov al, [ecx + 42]
           xor [ecx+20], al
           mov al, [ecx + 43]

           ;inc eax;
           PRINT_STRING [ecx]
           NEWLINE
           PRINT_STRING [ecx + 22]
           NEWLINE

	; TASK 1: Simple XOR between two byte streams
	; TODO: compute addresses on stack for str1 and str2
	; TODO: XOR them byte by byte
	;push addr_str2
	;push addr_str1
	;call xor_strings
	;add esp, 8

	; Print the first resulting string
	;push addr_str1
	;call puts
	;add esp, 4

	; TASK 2: Rolling XOR
	; TODO: compute address on stack for str3
	; TODO: implement and apply rolling_xor function
	;push addr_str3
	;call rolling_xor
	;add esp, 4

	; Print the second resulting string
	;push addr_str3
	;call puts
	;add esp, 4

	
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
