section .text
    global ft_atoi_base
    extern ft_strlen

; Fonction pour afficher une string de nombre dans une base donne
; Entree:
;   rdi - chaine (str)
;   rsi - base (str)
; Sortie:
;   rax - entier
ft_atoi_base:
    push rdi
    call check_base
    test rax, rax           ; Verifie si rax == 0 (base invalide)
    jz .handle_error
    pop rdi

    ret

.handle_error:
    pop rdi
    xor rax, rax
    ret

; Verifie si la base est valide
; Entree : rsi (base)
; Sortie : rax = 1 si valide, 0 sinon
check_base:
    push rsi                ; Sauvegarde base
    mov rdi, rsi            ; Met la base en parametre pour ft_strlen
    call ft_strlen          ; rax = taille base

    cmp rax, 2              ; Verifie si la base a au moins 2 caracteres
    jl .invalid_base

    mov rcx, rax            ; rcx = taille base
    xor rdx, rdx            ; init compteur

.base_loop:
    mov al, [rsi + rdx]
    
    cmp al, '+'
    je .invalid_base
    cmp al, '-'
    je .invalid_base

    mov rbx, rdx            ; rbx = i (index actuel)
    inc rbx                 ; Commencer à i + 1

.check_duplicate:
    cmp rbx, rcx            ; Si on depasse la longueur, passer au prochain caractere
    jge .next_char

    mov ah, [rsi + rbx]     ; Charger base[j]
    cmp al, ah              ; Si base[i] == base[j], erreur
    je .invalid_base

    inc rbx
    jmp .check_duplicate

.next_char:
    inc rdx                 ; Passer au caractere suivant de la base
    cmp rdx, rcx            ; Si on a parcouru toute la base, c'est bon
    jl .base_loop

    pop rsi                 ; Restaure base
    mov rax, 1              ; Base valide
    ret

.invalid_base:
    pop rsi
    xor rax, rax
    ret

