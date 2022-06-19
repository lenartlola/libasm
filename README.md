# libasm

Assembly yourself

> Summary: The aim of this project is to get familiar with assembly language.

## TODOS:
- The library must be called libasm.a.
- Create a main that will test the functions.
- Create the following functions:
	- ~~ft_strlen~~
	- ~~ft_strcpy~~
	- ~~ft_strcmp~~
	- ft_write
	- ft_read
	- ft_strdup
- Errors during syscalls must be set properly.
- The variable errno must be set properly `extern ___error` or `errno_location` are allowed for that.

## Documentation

In order to build programs we need to use the linux system calls provided by the kernel. 
*System Calls* often called *SysCalls* are libraries built into the operating system to provide functions such as reading input from keyboard and writing output to the screen.

In order to make a system call we should load the corresponding number in the [SysCall table](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md#x86-32_bit) to the `eax` register,
if the function requires arguments we can load them to the remaining `edx`, `ecx`, `ebx`

For example if we want to call the `sys_write` we would load `4` to the `eax`, then we load the corresponding fd to `arg0(%ebx)`, the `arg1(%ecx)` would be the line to write and the `arg2(%edx)` would be the line length.

Ex:
```asm
mov edx, 13					; edx is the size_t count, line length the last space is reserved to '\0'
mov ecx, 'Hello World!'		; the line we want to write to ecx
mov ebx, 1					; Set the fd to 1
mov eax, 4					; Call the sys_write systemcall, its corresponding number [_NR] is 4 in the sys call table
```

*Compilation:*

To compile our program we would use `nasm`

*Install nasm:*

ArchLinux:
```sh
pacman -Sy nasm
```
Ubuntu or other debian based distros:
```
apt install nasm
```
MacOS: (Beaware the systemcall table is different on mac)
```
brew install nasm
```

I mostly target on Linux through this doc, feel free to checkout the difference on mac

Compile the sourcecode:
```
nasm -f elf sourcecode.asm
```

Link: Note that `elf_i386` is required to 64bit system.
```
ld -m elf_i386 sourcecode.o -o progname
```

Run:
```
./progname
```

*Entry lable:*

Computer programs can be thought as a long strip of instructions that are loaded into memory and divided un into sections (or segments).
This general pool of memory is then shared between all programs and can be used to store variables, instructions, etc.
Each segment is given an address so that information stored in that section can be found later.

To execute a program that is loaded in memory, we use the global label `_start` to tell the operating system where in memory our program can be found and executed.
memory is then accessed sequentially following the program logic which determines the next address to be accessed. The kernel would jump into that address and executes it.

*Exit SysCall:*

One of the most important syscall is exit, if we don't exit our program properly it would cause a `segmentation fault`, and that's not what we want.
Just like how we tell the operating system where the program start in memory, we should also tell where it ends.

Ex:
```asm
mov ebx, 0	; Return 0 status on exit - 'No Errors'
mov eax, 1	; Invoke SYS_EXIT
int	80h
```

Here is final example of *Hello world program*

```asm
SECTION .data
message	db	'Hello world!', 0Ah		; Assign hello world to message

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
```

**Registers:**

Registers are basically places where the processor can stock informations, we can think of them as tiny variables.
Here is a list of *x64* registers:
```
rbp: Base Pointer, points to the bottom of the current stack frame
rsp: Stack Pointer, points to the top of the current stack frame
rip: Instruction Pointer, points to the instruction to be executed

General Purpose Registers
These can be used for a variety of different things.
rax: ; Mostly return value
rbx:
rcx:
rdx:
rsi:
rdi:
r8:
r9:
r10:
r11:
r12:
r13:
r14:
r15:
```

In x64 arguments are passed to function via registers.
```
rdi:    First Argument
rsi:    Second Argument
rdx:    Third Argument
rcx:    Fourth Argument
r8:     Fifth Argument
r9:     Sixth Argument
```

Also, like how a C function return a value, the return value in x64 is stored in the `rax` register.

There are different sizes of registers.
```
+-----------------+---------------+---------------+------------+
| 8 Byte Register | Lower 4 Bytes | Lower 2 Bytes | Lower Byte |
+-----------------+---------------+---------------+------------+
|   rbp           |     ebp       |     bp        |     bpl    |
|   rsp           |     esp       |     sp        |     spl    |
|   rip           |     eip       |               |            |
|   rax           |     eax       |     ax        |     al     |
|   rbx           |     ebx       |     bx        |     bl     |
|   rcx           |     ecx       |     cx        |     cl     |
|   rdx           |     edx       |     dx        |     dl     |
|   rsi           |     esi       |     si        |     sil    |
|   rdi           |     edi       |     di        |     dil    |
|   r8            |     r8d       |     r8w       |     r8b    |
|   r9            |     r9d       |     r9w       |     r9b    |
|   r10           |     r10d      |     r10w      |     r10b   |
|   r11           |     r11d      |     r11w      |     r11b   |
|   r12           |     r12d      |     r12w      |     r12b   |
|   r13           |     r13d      |     r13w      |     r13b   |
|   r14           |     r14d      |     r14w      |     r14b   |
|   r15           |     r15d      |     r15w      |     r15b   |
+-----------------+---------------+---------------+------------+
```


**ft_strlen**

To output `Hello World!`, we had to hardcode the length of the string, and that's not ideal, we programmers don't like hardcode, we like to code to realtime.
To calculate the length of the string we will use a technique called *pointer arithmetic*. Two registers are initialised pointing to the same address in memory.
One register (in this case RAX) will be incremented forward one byte for each character in the output string until we reach the end of the string. The original pointer will then be subtracted from RAX.
This is effectevely like subtraction between two arrays and the result yields the number of elements between the two addresses.

We use `CMP` instruction to compare the left hand side against the right hand side and sets a number of flags that are used for program flow.
The flag we are interested in here is `ZF` or `Zero Flag`, if the values that have been compared are equal the `ZF` then would be set.

We can use another instruction `JZ` which means *jump to some specific addresses if the zero flag is set*.
