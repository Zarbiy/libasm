#include "main_bonus.h"

void printf_list(t_list *list) {
    while (list)
    {
        dprintf(0,"%s / ", (char *)list->data);
        list = list->next;
    }
    dprintf(0, "\n");
}

void free_list(t_list **list) {
    t_list *current = *list;
    t_list *next;

    while (current) {
        next = current->next;
        free(current);
        current = next;
    }
    *list = NULL;
}

int main(){
    /* TEST ATOI BASE C04 */
    {
        dprintf(0, "\033[1;32m TEST ATOI BASE \033[0m\n");
        {
            dprintf(0, "453 -- 0123456789: (base 10)\n");
            int nb = ft_atoi_base("453", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "1101 -- 01: (base 2)\n");
            int nb = ft_atoi_base("1101", "01");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "FF -- 0123456789ABCDEF: (base 16)\n");
            int nb = ft_atoi_base("FF", "0123456789ABCDEF");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "FF -- 0123456789: (Error nb)\n");
            int nb = ft_atoi_base("FF", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "12 -- 90123456789: (Error base)\n");
            int nb = ft_atoi_base("12", "90123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, " -- 0123456789: (nb null)\n");
            int nb = ft_atoi_base("", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }
        {
            dprintf(0, "-453 -- 0123456789: (nb negatif ?)\n");
            int nb = ft_atoi_base("-453", "0123456789");
            if (nb == 0)
                dprintf(0, "Error\n");
            else
                dprintf(0, "nb = %d\n", nb);
        }

        dprintf(0, "\n\033[1;31m END-ATOI-BASE---------------------------- \033[0m\n");
    }
    /* TEST LIST PUSH FRONT BASE C12 */
    {
        dprintf(0, "\033[1;32m TEST LIST PUSH FRONT \033[0m\n");

        t_list *list = NULL;
        char *data1 = "Hello";
        char *data2 = "I am";
        char *data3 = "Bob";

        ft_list_push_front(&list, data1);
        ft_list_push_front(&list, data2);
        ft_list_push_front(&list, data3);

        printf_list(list);
        free_list(&list);
        dprintf(0, "\n\033[1;31m END-LIST-PUSH-FRONT---------------------- \033[0m\n");
    }
    /* TEST LIST SIZE C12 */
    {
        dprintf(0, "\033[1;32m TEST LIST SIZE \033[0m\n");

        t_list *list = NULL;

        dprintf(0, "Taille list:%d\n", ft_list_size(list));
        char *data1 = "Hello";
        char *data2 = "I am";
        char *data3 = "Bob";

        ft_list_push_front(&list, data1);
        dprintf(0, "Taille list:%d\n", ft_list_size(list));
        ft_list_push_front(&list, data2);
        ft_list_push_front(&list, data3);

        dprintf(0, "Taille list:%d\n", ft_list_size(list));
        free_list(&list);
        dprintf(0, "\n\033[1;31m END-LIST-SIZE---------------------------- \033[0m\n");
    }
    /* TEST LIST SORT C12 */
    {
        dprintf(0, "\033[1;32m TEST LIST SORT \033[0m\n");

        t_list *list = NULL;

        char *data1 = "1";
        char *data2 = "2";
        char *data3 = "3";
        char *data4 = "4";
        char *data5 = "5";
        char *data6 = "6";

        ft_list_push_front(&list, data3);
        ft_list_push_front(&list, data2);
        ft_list_push_front(&list, data1);
        ft_list_push_front(&list, data5);
        ft_list_push_front(&list, data6);
        ft_list_push_front(&list, data4);

        dprintf(0, "Before:\n");
        printf_list(list);

        ft_list_sort(&list, &strcmp);
    
        dprintf(0, "After:\n");
        printf_list(list);

        free_list(&list);

        dprintf(0, "\n\033[1;31m END-LIST-SORT---------------------------- \033[0m\n");
    }
    /* TEST LIST REMOVE IF C12 */
    {
        dprintf(0, "\033[1;32m TEST LIST REMOVE IF \033[0m\n");

        t_list *list = NULL;

        char *data1 = "Hello";
        char *data2 = "I am";
        char *data3 = "Bob";

        ft_list_push_front(&list, data1);
        ft_list_push_front(&list, data2);
        ft_list_push_front(&list, data3);

        printf_list(list);

        dprintf(0, "\n\033[1;31m END-LIST-REMOVE-IF----------------------- \033[0m\n");
    }
    return (0);
}