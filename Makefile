MAKEFLAGS += --no-print-directory

NAME = libasm.a

SRCS = ft_strlen.s ft_putnbr.s ft_write.s ft_strcpy.s ft_strcmp.s ft_read.s ft_strdup.s
OBJS = $(addprefix object/, $(SRCS:.s=.o))

SRCS_BONUS = ft_atoi_base.s ft_list_push_front.s ft_list_size.s ft_list_sort.s
OBJS_BONUS = $(addprefix object/, $(SRCS_BONUS:.s=.o))

NASM = nasm
RM = rm -f
AR = ar
GCC = gcc
AR_FLAGS = rcs
C_FLAGS = -Wall -Werror -Wextra -g3
NASM_FLAGS = -f elf64

all: $(NAME)

object/%.o: %.s
	@mkdir -p object
	$(NASM) $(NASM_FLAGS) -o $@ $<

$(NAME): $(OBJS) $(OBJS_BONUS)
	@$(AR) $(AR_FLAGS) $(NAME) $(OBJS) $(OBJS_BONUS)

# bonus: $(NAME) $(OBJS_BONUS)
# 	@$(AR) $(AR_FLAGS) $(NAME) $(OBJS_BONUS)

main: main.c $(NAME)
	$(GCC) $(C_FLAGS) -o a.out main.c $(NAME)

bonus: main_bonus.c $(NAME)
	$(GCC) $(C_FLAGS) -o a.out main_bonus.c $(NAME)

clean:
	@$(RM) -r object

fclean: clean
	@$(RM) $(NAME) a.out

re: fclean all
