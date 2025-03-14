section .text
    global ft_atoi_base
    extern ft_strlen

; Entree:
;   rdi - chaine (str)
;   rsi - base (str)
; Sortie:
;   rax - entier en base 10 (ou -1 en cas d'erreur)
ft_atoi_base:
    cmp byte [rdi], 0
    je .handle_error

    call check_base
    test rax, rax
    jz .handle_error

    push rdi
    mov rdi, rsi
    call ft_strlen
    mov r8, rax                 ; r8 taille de la base
    pop rdi

    call pass_whitespace
    call check_sign
    call read_number

    imul r14, r15            ; rdx = rdx * signe
    mov rax, r14             ; rax = résultat final
    ret

.handle_error:
    mov rax, 0
    ret

pass_whitespace:
    cmp byte [rdi], 0x20    ; ' '
    je .next_char
    cmp byte [rdi], 0x09    ; '\t'
    je .next_char
    cmp byte [rdi], 0x0A    ; '\n'
    je .next_char
    ret

.next_char:
    inc rdi
    jmp pass_whitespace

check_sign:
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

; r15 : signe (-1 ou 1)
; r8 : longueur de la chaine base
read_number:
    xor r14, r14             ; init number

.loop:
    mov dl, byte [rdi]
    test dl, dl
    je .end_string

    push rdi
    mov rdi, rsi
    call find_in_base
    pop rdi
    cmp rax, -1
    je .handle_error

    ; result = result * (base_length) + valeur_digit
    imul r14, r8        ; r14 = r14 * longueur_de_la_base
    add r14, rax            ; r14 = r14 + index (valeur du digit)

    inc rdi
    jmp .loop

.end_string:
    mov rax, r14
    ret

.handle_error:
    pop rdi                  ; nettoyer la pile (si besoin)
    mov rax, 0
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
    push rdi
    mov rdi, rsi
    call ft_strlen
    cmp rax, 2
    jl .invalid_base
    pop rdi

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

    mov rax, 1               ; base valide
    ret

.invalid_base:
    xor rax, rax             ; base invalide
    ret
