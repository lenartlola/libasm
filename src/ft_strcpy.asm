; ft_strcpy by 0xdeadabed
; 19.06.2022 05:03
; nasm -f elf64 ft_strcpy.asm

segment .text

global	ft_strcpy

ft_strcpy:
	push	rcx						; Create a typical counter
	xor		rcx, rcx				; Set the counter to zero
	jmp		_loop_cpy

_loop_cpy:
	; rdi -> the first argument passed
	; rsi -> the second argument passed
	; strcpy prototype -> strcpy(char *dst, char *src)

	cmp		[rsi+rcx], byte 0x0		; Compate the source to see if it's nullbyte
	jz		_null_byte_end
	
	mov		dl, byte [rsi+rcx]		; dl is 8bit char, [rsi+rcx] is used to dereference it's same as src[i]
	mov		byte [rdi+rcx], dl
	inc		rcx
	jmp		_loop_cpy


_null_byte_end:
	mov		byte [rdi+rcx], 0		; set nullbyte to the end of the dst
	mov		rax, rdi				; put the return value to rax
	pop		rcx						; delete the counter
	ret
