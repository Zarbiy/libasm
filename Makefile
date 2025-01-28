MAKEFLAGS += --no-print-directory

NAME = libasm.a

SRCS = ft_strlen.s ft_putnbr.s ft_write.s ft_strcpy.s ft_strcmp.s ft_read.s
OBJS = $(addprefix object/, $(SRCS:.s=.o))

NASM = nasm
LD = ld
RM = rm -f
AR = ar
GCC = gcc
AR_FLAGS = rcs
C_FLAGS = -Wall -Werror -Wextra

NASM_FLAGS = -f elf64

all: $(NAME)

object/%.o: %.s
	@mkdir -p object
	$(NASM) $(NASM_FLAGS) -o $@ $<

$(NAME): $(OBJS)
	@$(AR) $(AR_FLAGS) $(NAME) $(OBJS)

main: main.c $(NAME)
	$(GCC) $(C_FLAGS) -o a.out main.c $(NAME) -lc

clean:
	@$(RM) -r object

cleanmain:
	@$(RM) main.o

fclean: clean
	@$(RM) $(NAME)

fcleanmain:
	@$(RM) main.o a.out

cleanall: clean cleanmain

fcleanall: fclean fcleanmain


re: fclean all

reall: fcleanall all main
