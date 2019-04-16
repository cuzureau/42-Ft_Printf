# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cuzureau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/10/09 15:57:06 by cuzureau          #+#    #+#              #
#    Updated: 2018/10/18 14:17:32 by cuzureau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC= gcc
TEST= ok

ifeq ($(TEST),ok)
CFLAGS+= -O2
else
CFLAGS+= -Wall -Wextra -Werror -O2
endif

NOC=\033[0m
OKC=\033[32m
ERC=\033[31m
WAC=\033[33m

INC_PATH= inc/
OBJ_PATH= obj/
SRC_PATH= src/

NAME= libftprintf.a
EXE_NAME= ft_printf
INC_NAME= ft_printf.h
OBJ_NAME= $(SRC_NAME:.c=.o)
SRC_NAME= ft_printf.c numbers.c letters.c tools.c extra.c

INC= $(addprefix $(INC_PATH), $(INC_NAME))
OBJ= $(addprefix $(OBJ_PATH), $(OBJ_NAME))
SRC= $(addprefix $(SRC_PATH), $(SRC_NAME))

all:	$(NAME)

$(NAME): $(OBJ)
		@echo "$(OKC)ft_printf$(NOC)	+ obj	$(OKC)[OK]$(NOC)"
		@ar rc $(NAME) $(OBJ)
		@ranlib $(NAME)
		@echo "$(OKC)ft_printf$(NOC)	+ lib	$(OKC)[OK]$(NOC)"

$(OBJ_PATH)%.o: $(SRC_PATH)%.c
	@mkdir $(OBJ_PATH) 2> /dev/null || true
	@$(CC) $(CFLAGS) -o $@ -c $<

clean:
		@rm -rf $(OBJ_PATH)
		@echo "$(OKC)ft_printf$(NOC)	- obj	$(OKC)[OK]$(NOC)"

fclean: clean
		@rm -rf $(NAME)
		@echo "$(OKC)ft_printf$(NOC)	- lib	$(OKC)[OK]$(NOC)"
		@rm -f $(EXE_NAME)
		@echo "$(OKC)ft_printf$(NOC)	- exe	$(OKC)[OK]$(NOC)"

re: fclean all

exe: all
	@$(CC) -o $(EXE_NAME) $(CFLAGS) $(SRC_PATH)main.c -L . libftprintf.a
	@echo "$(OKC)ft_printf$(NOC)	+ exe	$(OKC)[OK]$(NOC)"
	@./$(EXE_NAME)

norme:
	@norminette $(SRC) $(INC)

.PHONY: all clean fclean re exe norme
