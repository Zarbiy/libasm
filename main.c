#include "main.h"
#include <unistd.h>
#include <stdio.h>

int main() {

    char *test_str = "Hello bob";
    char *null_str = "\0";

    ft_write(0, test_str, 9);
    ft_write(0, "\n", 1);
    ft_write(0, test_str, 2);
    ft_write(0, "\n", 1);
    // ft_write(0, null_str, 0);
    // ft_write(0, "\n", 1);
    write(0, null_str, 0);

    printf("Len: %ld", ft_strlen(test_str));
    printf("Len: %ld", ft_strlen(null_str));

    return 0;
}