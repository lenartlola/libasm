# libasm

Assembly yourself

> Summary: The aim of this project is to get familiar with assembly language.

## TODOS:
	- The library must be called libasm.a.
	- Create a main that will test the functions.
	- Create the following functions:
		- ft_strlen 
		- ft_strcpy
		- ft_strcmp
		- ft_write
		- ft_read
		- ft_strdup
	- Errors during syscalls must be set properly.
	- The variable errno must be set properly `extern ___error` or `errno_location` are allowed for that.

## Documentation

In order to build programs we need to use the linux system calls provided by the kernel. 
*System Calls* often called *SysCalls* are libraries built into the operating system to provide functions such as reading input from keyboard and writing output to the screen.

In order to make a system call we should load the corresponding number in the (SysCall table)[https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md#x86-32_bit] to the `eax` register,
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
