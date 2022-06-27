; ft_strdup by 0xdeadabed
; 23.06.2022 04:42 PM
; nasm -f elf64 ft_strdip.asm

; function prototype -> strdup(const char *s1);
; allocates sufficient memory for a copy of the string 's1' and copy it.
; returns a string of chars
; rdi register -> the argument 's1'

segment .text

global	_ft_strdup
extern	_malloc

