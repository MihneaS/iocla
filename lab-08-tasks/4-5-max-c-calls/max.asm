section .text

global get_max

get_max:
	push ebp
	mov ebp, esp

	; [ebp+8] is array pointer
	; [ebp+12] is array length

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	mov edx, [ebp+16]
	xor eax, eax

compare:
	cmp eax, [ebx+ecx*4-4]
	jge check_end
	mov eax, [ebx+ecx*4-4]
    mov [edx], ecx;
    dec DWORD[edx];
check_end:
	loopnz compare

	leave
	ret
