section .text
    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy
    extern __errno_location

; Fonction pour dupliquer une chaîne
; Entree :
;   rdi - adresse de la chaîne source
; Sortie :
;   rax - adresse de la chaîne de destination
ft_strdup:
    call ft_strlen
    inc rax

    push rdi

    mov rdi, rax            ; Taille allouée pour malloc
    call malloc wrt ..plt
    cmp rax, 0              ; Vérifier si malloc a échoué
    jz error                ; Gestion d'erreur si malloc échoue

    pop rdi                 ; Récupérer l'adresse de la source
    mov rsi, rdi
    mov rdi, rax            ; Destination = mémoire allouée par malloc
    call ft_strcpy          ; Copier la chaîne source vers la destination

    ret                     ; Retourner l'adresse de la nouvelle chaîne (dans rax)

error:
    pop rdi
    call __errno_location wrt ..plt
    mov dword [rax], 12     ; errno = ENOMEM
    xor rax, rax            ; Retourner NULL
    ret
