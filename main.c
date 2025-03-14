#include "main.h"

int main() {
    /* TEST WRITE */
    {
        dprintf(0, "\033[1;32m TEST WRITE \033[0m\n");
        char *test_str = "Hello bob";
        char *null_str = "\0";

        dprintf(0, "\n1--------------------------------------\n");
        ft_write(1, test_str, 9);
        ft_write(0, "\n", 1);
        write(1, test_str, 9);

        dprintf(0, "\n2--------------------------------------\n");
        ft_write(0, test_str, 2);
        ft_write(0, "\n", 1);
        write(0, test_str, 2);

        dprintf(0, "\n3--------------------------------------\n");
        ft_write(0, null_str, 0);
        ft_write(0, "\n", 1);
        write(0, null_str, 0);

        dprintf(0, "\n\033[1;31m END-WRITE------------------------------ \033[0m\n");
    }

    /* TEST STRLEN */
    {
        dprintf(0, "\033[1;32m TEST STRLEN \033[0m\n");
        char *test_str = "Hello bob";
        char *null_str = "\0";
        int a = ft_strlen(test_str);
        int b = ft_strlen(null_str);

        dprintf(0, "\n1--------------------------------------\n");
        dprintf(0, "len: %d", a);
        dprintf(0, "\n2--------------------------------------\n");
        dprintf(0, "len: %d", b);
        dprintf(0, "\n\033[1;31m END-STRLEN----------------------------- \033[0m\n");
    }

    /* TEST STRCPY */
    {
        dprintf(0, "\033[1;32m TEST STRCPY \033[0m\n");
        char test_str[] = "Salut Jacob";
        char *null_str = "\0";
        char cpy[20];
        char cpyReel[20];
        {
            ft_strcpy(cpy, test_str);
            strcpy(cpyReel, test_str);

            dprintf(0, "\n1--------------------------------------\n");
            ft_write(0, cpy, ft_strlen(cpy));
            ft_write(0, "\n", 1);
            ft_write(0, cpyReel, ft_strlen(cpyReel));
        }
        {
            ft_strcpy(cpy, null_str);
            strcpy(cpyReel, null_str);

            dprintf(0, "\n2--------------------------------------\n");
            ft_write(0, cpy, ft_strlen(cpy));
            ft_write(0, "\n", 1);
            ft_write(0, cpyReel, ft_strlen(cpyReel));
        }
        dprintf(0, "\n\033[1;31m END-STRCPY----------------------------- \033[0m\n");
    }

    /* TEST STRCMP */
    {
        dprintf(0, "\033[1;32m TEST STRCMP \033[0m\n");

        // char *str0 = NULL;
        char *str1 = "Bonjour";
        char *str2 = "Salut";
        char *str3 = "Bontour";
        char *str4 = "Salut";

        dprintf(0, "\n1--------------------------------------\n");
        dprintf(0, "CMP: %s & %s || %d\n", str1, str2, ft_strcmp(str1, str2));
        dprintf(0, "R CMP: %s & %s || %d\n", str1, str2, strcmp(str1, str2));

        // dprintf(0, "\n2--------------------------------------\n");
        // dprintf(0, "CMP: %s & %s || %d\n", str0, str2, ft_strcmp(str0, str2));
        // dprintf(0, "R CMP: %s & %s || %d\n", str0, str2, strcmp(str0, str2));

        dprintf(0, "\n3--------------------------------------\n");
        dprintf(0, "CMP: %s & %s || %d\n", str2, str4, ft_strcmp(str2, str4));
        dprintf(0, "R CMP: %s & %s || %d\n", str2, str4, strcmp(str2, str4));

        dprintf(0, "\n4--------------------------------------\n");  
        dprintf(0, "CMP: %s & %s || %d\n", str1, str3, ft_strcmp(str1, str3));
        dprintf(0, "R CMP: %s & %s || %d\n", str1, str3, strcmp(str1, str3));

        dprintf(0, "\n\033[1;31m END-STRCMP----------------------------- \033[0m\n");
    }

    /* TEST READ */
    {
        dprintf(0, "\033[1;32m TEST READ \033[0m\n");
        int fd = open("ft_write.s", O_RDONLY);
        int Rfd = open("ft_write.s", O_RDONLY);
        char buffer[50];
        char Rbuffer[50];

        dprintf(0, "\n--------------FD=FILE------------------\n");
        ft_read(fd, buffer, 50);
        dprintf(0, "%s", buffer);
        read(Rfd, Rbuffer, 50);
        dprintf(0, "\nREEL: \n%s", Rbuffer);
        dprintf(0, "\n---------------------------------------\n");
        ft_read(fd, buffer, 50);
        dprintf(0, "%s", buffer);
        dprintf(0, "\n---------------------------------------\n");
        read(Rfd, Rbuffer, 50);
        dprintf(0, "REEL: \n%s", Rbuffer);

        dprintf(0, "\n\033[1;31m END-READ------------------------------- \033[0m\n");
    }

    /* TEST STRDUP */
    {
        dprintf(0, "\033[1;32m TEST STRDUP \033[0m\n");

        char *str = "Hello, world!";
        char *dup;

        dup = ft_strdup(str);

        if (!dup) {
            dprintf(0, "Error ft_strdup\n");
            return 1;
        }

        dprintf(0, "Base: %s\nNew str: %s\n", str, dup);
        free(dup);
        dprintf(0, "Base: %s\n", str);

        dprintf(0, "\n--------------CHAINE-NULL--------------\n");
        char *strnull = "\0";
        dup = ft_strdup(strnull);
        if (!dup) {
            dprintf(0, "Error ft_strdup\n");
        }
        dprintf(0, "Base: %s\nNew str: %s\n", strnull, dup);
        free(dup);

        dprintf(0, "\n\033[1;31m END-STRDUP------------------------------- \033[0m\n");
    }

    /* TEST ATOI BASE */
    {
        dprintf(0, "\033[1;32m TEST ATOI BASE \033[0m\n");
        {
            dprintf(0, "453 -- 0123456789:\n");
            int nb = ft_atoi_base("453", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "1101 -- 01:\n");
            int nb = ft_atoi_base("1101", "01");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "FF -- 0123456789ABCDEF:\n");
            int nb = ft_atoi_base("FF", "0123456789ABCDEF");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "FF -- 0123456789:\n");
            int nb = ft_atoi_base("FF", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "12 -- 90123456789:\n");
            int nb = ft_atoi_base("12", "90123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, " -- 0123456789:\n");
            int nb = ft_atoi_base("", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }

        dprintf(0, "\n\033[1;31m END-ATOI-BASE---------------------------- \033[0m\n");
    }
    return 0;
}