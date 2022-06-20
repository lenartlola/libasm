; ft_strlen by 0xdeadabed
; 18.06.2022 07:52 PM
; nasm -f elf64 ft_strlen.asm

segment .text

global ft_strlen

ft_strlen:
	push	rcx					; Create a counter
	xor		rcx, rcx			; Use the XOR to set the counter to zero

_loop_chars:
	cmp		[rdi], byte 0x0		; Compare to nullbyte
	jz		_null_byte			; Stop the loop if reached null byte

	inc		rcx					; Increment the counter
	inc		rdi					; Move to the next char
	jmp		_loop_chars			; Restart the loop


_null_byte:
	mov		rax, rcx			; put the counter(tcx) to rax

	pop		rcx					; restore rcx
	ret
