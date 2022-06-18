; Hello world program
; Compile with: nasm -f elf helloworld.asm
; Link with (64 bit systems require elf_i386 option): lf -m elf_i386 helloworld.o -o helloworld
; Run with: ./helloworld

SECTION .data
message		db		'Hello world!', 0Ah			; Assign hello world to message

SECTION .text
global	_start

_start:
	mov	edx, 13
	mov	ecx, message
	mov	ebx, 1
	mov	eax, 4
	int	80h

	mov	ebx, 0
	mov	eax, 1
	int	80h
