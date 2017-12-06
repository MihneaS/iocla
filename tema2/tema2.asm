%include "io.inc"

extern puts
extern printf

section .data
filename: db "./input.dat",0
inputlen: dd 2263
fmtstr: db "Key: %d",0xa,0

NULL32 equ -1

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



ascii_hex_to_udec:

    cmp al, '9'
    jg aux2alpha
    sub al, '0'
    jmp aux2end
aux2alpha:
    sub al, 'a' - 10
aux2end:
    ret



hex_enc_to_byte:
    xor eax, eax
    ;first char
    lodsb
    test al, al
    jz aux3endofstring
    call ascii_hex_to_udec
    mov bl, 16
    mul bl; assuming multiplication result fits in al
    mov bl, al
    ;second char
    lodsb
    call ascii_hex_to_udec
    add al, bl
    ret
aux3endofstring:
    ret



nextdecoded32char:
    lodsb
    cmp al, '='
    ja aux4alpha
    jb aux4numnull
    xor al, al
    jmp aux4end

aux4numnull:
    cmp al, '2'
    jl aux4null
    sub al, '2'
    add al, 26
    jmp aux4end

aux4null:
    mov al, NULL32
    jmp aux4end

aux4alpha:
    sub al, 'A'
    jmp aux4end

aux4end:
    ret



xor_strings:
    push ebp
    mov ebp, esp
    pushf
    push eax
    push edi
    push esi

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
    pop esi
    pop edi
    pop eax
    popf
    leave
    ret



rolling_xor:
    push ebp
    mov ebp, esp
    pusha
    pushf
    mov esi, [ebp + 8]
    mov edi, esi
    inc edi; we've just assumed the string is not empty
    ; save first character
    mov dl, [esi]
    ; roll xor everthing
    push esi
    push edi
    call xor_strings
    add esp, 8
    ; move string 1 byte rigjt
    cld
t2while:
    mov al, [esi]
    test al, al
    jz t2end
    mov [esi], dl;
    mov dl, al
    inc esi
    jmp t2while
t2end:
    popf
    popa
    leave
    ret



xor_hex_strings:
    push ebp
    mov ebp, esp
    pusha
    pushf

    mov edi, [ebp + 8]; place to write
    mov ecx, edi; encoded string
    mov edx, [ebp + 12]; key
    xor eax, eax
t3while:
    ;encoded byte
    mov esi, ecx
    call hex_enc_to_byte
    jz t3end
    mov ecx, esi
    ;save it
    push ax
    ;key byte
    mov esi, edx
    call hex_enc_to_byte
    mov edx, esi
    ;recover encoded byte
    pop bx
    ;xor and write bytes
    xor al, bl
    stosb
    jmp t3while
t3end:
    ;adding '\0'
    xor al, al
    stosb
    popf
    popa
    leave
    ret


base32decode:
    push ebp
    mov ebp, esp
    pusha
    pushf

    mov edi, [ebp + 8]
    mov esi, edi
    xor edx, edx

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
    cmp al, NULL32
    jnz t4while
t4end:
    pushf
    pusha
    leave
    ret



bruteforce_singlebyte_xor:
    push ebp
    mov ebp, esp
    pusha
    pushf

    ;TODO

    pushf
    pusha
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

    ; all input.dat contents are now in ecx (address on stack)

    ; TASK 1: Simple XOR between two byte streams
    ; TODO: compute addresses on stack for str1 and str2
    mov edx, ecx; mov edx, addr_str1
    call next_string
    push edx; push addr_str1
    push ecx; push addr_str2
    ; TODO: XOR them byte by byte
    call xor_strings
    add esp, 8; pop arguments

    ; Print the first resulting string

    push ecx; push addr_str2 to save it
    push edx; push addr_str1 for puts
    call puts
    add esp, 4; pop ruined argument of puts
    pop ecx; restore ecx and clear argument from stack

    ; TASK 2: Rolling XOR
    ; TODO: compute address on stack for str3
    call next_string
    push ecx;push addr_str3

    ; TODO: implement and apply rolling_xor function
    call rolling_xor
    add esp, 0 ; keep addr_str3 on stack for puts

    ; Print the second resulting string
    ;push addr_str3; already pushed
    call puts
    pop ecx;

    ; TASK 3: XORing strings represented as hex strings
    ; TODO: compute addresses on stack for strings 4 and 5
    call next_string
    mov edx, ecx; save addr_str4
    call next_string
    mov ebx, ecx;
    call next_string; compute next string now because xor_hex_strings affects the stack
    push ecx; protect ecx from evil puts
    ; TODO: implement and apply xor_hex_strings
    push ebx;push addr_str5
    push edx;push addr_str4
    call xor_hex_strings
    add esp, 8

    ; Print the third string
    push edx;push addr_str4
    call puts
    add esp, 4;

    ; TASK 4: decoding a base32-encoded string
    ; TODO: compute address on stack for string 6
    ;call next_string; already done
    ; TODO: implement and apply base32decode
    ;push ecx;push addr_str6 already pushed <3
    call base32decode
    add esp, 0; keep addr_str6 on stack for puts

    ; Print the fourth string
    ;push addr_str6; done
    call puts
    add esp, 4

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
