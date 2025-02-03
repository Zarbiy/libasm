section .text
    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy
    extern __errno_location

ft_strdup:
    ; Sauvegarder l'adresse de la source
    push    rdi
    
    ; Appeler ft_strlen pour obtenir la longueur de la chaîne
    call ft_strlen
    inc rax               ; Ajouter 1 pour le '\0'

    ; Allouer de la mémoire avec malloc
    mov rdi, rax          ; Taille allouée
    call malloc wrt ..plt
    cmp rax, 0            ; Vérifier si malloc a échoué
    jz error              ; Si malloc échoue, gérer l'erreur

    ; Copier la chaîne source vers la nouvelle destination
    pop rsi               ; Récupérer l'adresse de la source
    mov rdi, rax          ; Destination = mémoire allouée
    call ft_strcpy        ; Copie la chaîne

    ret

error:
    ; Si malloc échoue, récupérer l'adresse d'errno
    call __errno_location wrt ..plt

    ; Définir errno à ENOMEM (12) pour indiquer l'erreur de mémoire
    mov dword [rax], 12   ; errno = ENOMEM
    xor rax, rax          ; Retourner NULL
    ret
