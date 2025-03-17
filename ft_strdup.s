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

    mov rdi, rax
    call malloc wrt ..plt
    cmp rax, 0
    jz error

    pop rdi
    mov rsi, rdi
    mov rdi, rax
    call ft_strcpy

    ret

error:
    pop rdi
    call __errno_location wrt ..plt
    mov dword [rax], 12     ; errno = ENOMEM
    xor rax, rax            ; Retourner NULL
    ret
