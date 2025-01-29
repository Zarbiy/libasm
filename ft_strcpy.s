section .text
    global ft_strcpy

; Fonction pour copier une chaîne
; Entrée :
;   rdi - adresse de la chaîne de destination
;   rsi - adresse de la chaîne source
; Sortie :
;   rax - adresse de la chaîne de destination

ft_strcpy:
    test rdi, rdi       ; Vérifier si destination est NULL
    jz error            ; Si NULL, retourner erreur
    test rsi, rsi       ; Vérifier si source est NULL
    jz error            ; Si NULL, retourner erreur

    mov rax, rdi        ; Sauvegarder adresse destination

copy_loop:
    mov al, [rsi]       ; Charger un octet depuis la source
    mov [rdi], al       ; Copier dans la destination
    inc rdi             ; Avancer destination
    inc rsi             ; Avancer source
    test al, al         ; Vérifier si on a copié '\0'
    jnz copy_loop       ; Continuer tant que ce n'est pas la fin

    ret                 ; Retourner l'adresse de destination

error:
    xor rax, rax        ; Retourner NULL si erreur
    ret

