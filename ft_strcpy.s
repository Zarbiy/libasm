section .text
global ft_strcpy

; Fonction pour copier une chaîne
; Entrée :
;   rdi - adresse de la chaîne source
;   rcx - adresse de la chaîne de destination
;   rdx - Taille maximale du tampon de destination
; Sortie :
;   rcx - adresse de la chaîne de destination (mise à jour)
ft_strcpy:
    push rsi
    mov rsi, rdi
    mov rbx, rcx
    xor r8, r8

copy_loop:
    cmp r8, rdx
    je buffer_overflow

    mov al, byte [rsi]
    mov byte [rcx], al
    inc rsi
    inc rcx
    inc r8
    test al, al
    jnz copy_loop

    pop rsi
    mov rcx, rbx
    ret

buffer_overflow:
    mov byte [rcx + rdx - 1], 0
    pop rsi
    mov rcx, rbx
    ret
