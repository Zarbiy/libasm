section .text
global ft_write
extern ft_strlen

; Fonction pour afficher une string
; Entrée : rdi - la string a afficher
ft_write:
    push rdi
    call ft_strlen
    mov rdx, rax
    pop rdi

    mov rax, 1
    mov rsi, rdi
    mov rdi, 1
    syscall
    ret


