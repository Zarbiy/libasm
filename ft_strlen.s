section .text
global ft_strlen

; Fonction pour calculer la longueur d'une chaîne
; Entrée : rdi - pointeur vers la chaîne
; Sortie : rax - longueur de la chaîne
ft_strlen:
    push rcx
    xor rcx, rcx

count_length:
    cmp byte [rdi + rcx], 0
    jz done_counting
    inc rcx
    jmp count_length

done_counting:
    mov rax, rcx
    pop rcx
    ret