NAME = prog

SHELL = /usr/sbin/sh

ASM_SRC = $(shell find . -name "*.asm")

OBJ = $(shell find . -name "*.o")

all: nasm $(NAME)

nasm:
	for file in $(ASM_SRC) ; do \
		nasm -f elf64 $$file ; \
	done

$(NAME):
	@gcc $(OBJ) main.c -o $(NAME)
	@echo "Compilation done"

clean:
	rm -rf $(OBJ)

fclean: clean
	rm -rf $(NAME)

re: fclean all
