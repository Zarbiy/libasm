section .data
    sign db '-'                          ; Caractère pour le signe négatif
    zero db '0'                          ; Caractère pour le chiffre zéro

section .bss
    buffer resb 1      ; Réserver 1 octet pour un tampon

section .text
global ft_putnbr

; Fonction pour afficher un nombre entier
; Entrée : rdi - le nombre à afficher
ft_putnbr:
    push rbx
    push rdx
    push rsi

    cmp rdi, 0
    je print_zero

    cmp rdi, 0
    js negative_number

convert_positive:
    ; Convertir le nombre en chaîne
    xor r8, r8                        ; Initialiser r8 à 0 (compteur de chiffres)
    mov rbx, 10                       ; Diviseur pour la conversion
    mov rax, rdi

divide_loop:
    xor rdx, rdx          ; Réinitialiser rdx (important pour une division correcte)
    div rbx               ; Diviser rdi par rbx (10)
    add rdx, '0'          ; Convertir le reste en ASCII
    push rdx              ; Empiler le caractère
    mov rdi, rax          ; Mettre à jour rdi avec le quotient
    inc r8                ; Incrémenter le compteur de chiffres
    test rdi, rdi         ; Vérifier si le quotient est 0
    jnz divide_loop       ; Si non, continuer la boucle

print_digits:
    cmp r8, 0               ; Vérifier si la pile est vide
    jz end_print            ; Si oui, terminer l'impression

    pop rax                 ; Récupérer le chiffre de la pile
    mov [buffer], al        ; Placer le caractère dans le tampon

    mov rdi, 1              ; Descripteur de fichier (stdout)
    lea rsi, [buffer]       ; Charger l'adresse du tampon dans rsi
    mov rdx, 1              ; Longueur du caractère (1 octet)
    mov rax, 1              ; Numéro de l'appel système (sys_write)
    syscall                 ; Appeler l'écriture sur la sortie standard

    dec r8                  ; Décrémenter le compteur de chiffres
    jmp print_digits        ; Répéter jusqu'à ce que tous les chiffres soient affichés

end_print:
    ; Restaurer les registres sauvegardés
    pop rsi
    pop rdx
    pop rbx
    ret

negative_number:
    xor r8, r8
    mov r8, rdi
    mov rax, 1
    mov rdi, 1
    lea rsi, [sign]
    mov rdx, 1
    syscall

    mov rdi, r8
    neg rdi
    jmp convert_positive

print_zero:
    mov rax, 1
    mov rdi, 1
    lea rsi, [zero]
    mov rdx, 1
    syscall

    pop rsi
    pop rdx
    pop rbx
    ret
