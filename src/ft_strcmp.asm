; ft_strcmp by 0xdeadabed
; 19.06.2022 06:52 PM
; nasm -f elf64 ft_strcmp.asm

; function prototype -> strcmp(char *s1, char *s2)
; returns 0 if the strings are equal
; rdi register -> the first argument
; rsi register -> the second argument

segment .text						; the text segment or section is dedicated to the actual code - aka code segment.

global	_ft_strcmp					; global tells the kernel where the program starts

_ft_strcmp:
	push	rcx
	xor		rcx, rcx
	jmp		_loop_cmp

_loop_cmp:
	cmp		[rsi+rcx], byte 0x0
	jz		_return_zero
	cmp		[rdi+rcx], byte 0x0
	jz		_return_zero
	mov		al, [rsi+rcx]			; Put a byte from rsi to al
	mov		bl, [rdi+rcx]			; Put a byte from rdi to bl
	cmp		al, bl					; Compare the two bytes
	jne		_return_one				; Jump to the function that returns one if they are not equal
	inc		rcx
	jmp		_loop_cmp


_return_one:
	pop		rcx
	mov		rax, 1
	ret

_return_zero:
	pop		rcx
	mov		rax, 0
	ret
