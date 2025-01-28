section .text
    global ft_read
    extern ft_putnbr

; Fonction pour lire des octets dans un fichier
; Entree:
;   rdi - le descripteur de fichier (fd)
;   rsi - le buffer de destination
;   rdx - le nombre maximum d'octets à lire
; Sortie:
;   rax - le nombre d'octets réellement lus, ou -1 en cas d'erreur

ft_read:
    mov rax, 0
    syscall

    test rax, rax
    js handle_error

    ret

handle_error:
    mov rax, -1
    ret
