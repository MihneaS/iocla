	.file	"inline_cpuid.c"
	.intel_syntax noprefix
	.section	.rodata
.LC0:
	.string	"CPUID string: %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	lea	ecx, [esp+4]
	.cfi_def_cfa 1, 0
	and	esp, -16
	push	DWORD PTR [ecx-4]
	push	ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	mov	ebp, esp
	push	esi
	push	ebx
	push	ecx
	.cfi_escape 0xf,0x3,0x75,0x74,0x6
	.cfi_escape 0x10,0x6,0x2,0x75,0x7c
	.cfi_escape 0x10,0x3,0x2,0x75,0x78
	sub	esp, 44
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR [ebp-28], eax
	xor	eax, eax
	lea	esi, [ebp-41]
#APP
# 7 "inline_cpuid.c" 1
	xor eax, eax
cpuid
mov [esi], ebx
mov [esi + 4], ecx
mov [esi + 8], edx

# 0 "" 2
#NO_APP
	mov	BYTE PTR [ebp-29], 0
	sub	esp, 8
	lea	eax, [ebp-41]
	push	eax
	push	OFFSET FLAT:.LC0
	call	printf
	add	esp, 16
	mov	eax, 0
	mov	edx, DWORD PTR [ebp-28]
	xor	edx, DWORD PTR gs:20
	je	.L3
	call	__stack_chk_fail
.L3:
	lea	esp, [ebp-12]
	pop	ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	pop	ebx
	.cfi_restore 3
	pop	esi
	.cfi_restore 6
	pop	ebp
	.cfi_restore 5
	lea	esp, [ecx-4]
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
