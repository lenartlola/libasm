; ft_read by 0xdeadabed
; 19.06.2022 11:00 AM
; nasm -f elf64 ft_read.asm

; function prototype -> read(int fd, char *buf, size_t count)
; attempts to read o count from fd into buf.

segment	.text

global	_ft_read

_ft_read:
	mov		rax, 0x00		; Move 0x00 which is the number of read systemcall in the syscall table structure ro rax
	syscall					; Do the syscall
	ret
