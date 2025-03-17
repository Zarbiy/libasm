section .text
    global ft_strcpy

; Fonction pour copier une chaîne
; Entree :
;   rdi - adresse de la chaîne de destination
;   rsi - adresse de la chaîne source
; Sortie :
;   rax - adresse de la chaîne de destination

ft_strcpy:
    test rdi, rdi
    jz error
    test rsi, rsi
    jz error

    mov rax, rdi

copy_loop:
    mov dl, [rsi]
    mov [rdi], dl
    inc rdi
    inc rsi
    test dl, dl
    jnz copy_loop

    ret

error:
    xor rax, rax
    ret

