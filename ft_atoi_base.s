section .text
    global ft_atoi_base
    extern ft_strlen

; Entree:
;   rdi - chaine (str) à convertir (ex: "-1A")
;   rsi - base (str) (ex: "0123456789ABCDEF")
; Sortie:
;   rax - entier en base 10 (ou -1 en cas d'erreur)
ft_atoi_base:
    cmp byte [rdi], 0
    je .handle_error
    push rdi
    call check_base
    test rax, rax
    jz .handle_error
    pop rdi

    push rsi
    mov rdi, rsi
    call ft_strlen
    mov r8, rax                 ; r8 taille de la base
    pop rsi

    call .pass_whitespace
    call .check_sign            ; r15 signe (1 ou -1)

    ; Conversion du nombre
    call .read_number

    imul rdx, r15            ; rdx = rdx * signe
    mov rax, rdx             ; rax = résultat final
    ret

.pass_whitespace:
    cmp byte [rdi], 0x20    ; ' '
    je .next_char
    cmp byte [rdi], 0x09    ; '\t'
    je .next_char
    cmp byte [rdi], 0x0A    ; '\n'
    je .next_char
    jmp .check_sign

.next_char:
    inc rdi
    jmp .pass_whitespace

.check_sign:
    mov r15, 1
    cmp byte [rdi], '-'
    je .minus_sign
    cmp byte [rdi], '+'
    je .plus_sign
    ret

.minus_sign:
    inc rdi
    mov r15, -1
    ret

.plus_sign:
    inc rdi
    ret

.handle_error:
    pop rdi                  ; nettoyer la pile (si besoin)
    mov rax, -1
    ret

; r15 : signe (-1 ou 1)
; r8 : longueur de la chaine base
; 
.read_number:
    xor rdx, rdx             ; init number

.loop:
    movzx rcx, byte [rdi]
    cmp rcx, 0
    je .end_string

    mov dl, cl

    push rdi
    mov rdi, rsi
    call find_in_base
    pop rdi
    cmp rax, -1
    je .handle_error

    ; result = result * (base_length) + valeur_digit
    imul rdx, r8        ; rdx = rdx * longueur_de_la_base
    add rdx, rax            ; rdx = rdx + index (valeur du digit)

    inc rdi
    jmp .loop

.end_string:
    ret

; find_in_base:
; Recherche le caractere dans la base
; Sortie:
;   rax = position du caractere dans la base, -1 si non trouvé
find_in_base:
    xor rax, rax

.find_loop:
    cmp byte [rdi], 0
    je .not_found
    cmp byte [rdi], dl       ; comparer avec le caractere à chercher
    je .found
    inc rdi
    inc rax
    jmp .find_loop

.found:
    ret

.not_found:
    mov rax, -1
    ret


; Conditions:
;   - longueur >= 2
;   - ne contient pas '+' ni '-' ni espaces
;   - tous les caracteres sont uniques
; Sortie:
;   rax = 1 si valide, 0 sinon
check_base:
    push rsi
    mov rdi, rsi
    call ft_strlen
    cmp rax, 2
    jl .invalid_base

    mov rcx, rax             ; rcx = longueur de la base
    xor rdx, rdx

.base_loop:
    mov al, [rsi + rdx]
    cmp al, '+'
    je .invalid_base
    cmp al, '-'
    je .invalid_base
    cmp al, ' '
    je .invalid_base

    mov rbx, rdx             ; rbx = i
    inc rbx                  ; commencer a i+1

.check_duplicate:
    cmp rbx, rcx
    jge .next_char
    mov ah, [rsi + rbx]
    cmp al, ah
    je .invalid_base
    inc rbx
    jmp .check_duplicate

.next_char:
    inc rdx
    cmp rdx, rcx
    jl .base_loop

    pop rsi
    mov rax, 1               ; base valide
    ret

.invalid_base:
    pop rsi
    xor rax, rax             ; base invalide
    ret
