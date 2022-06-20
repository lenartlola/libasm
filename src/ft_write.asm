; ft_write by 0xdeadabed
; 19.06.2022 10:12 AM
; nasm -f elf64 ft_strlen.asm

; function prototype -> write(int fd, const char *buf, size_t nbyte)
; writes nbyte from buf on the specified fd.

segment	.text

global	_ft_write

_ft_write:
	mov		rax, 0x01		; Call the write system-call, its number in the systemcall table structure is 0x01 for x64 arch
	syscall
	ret
	
