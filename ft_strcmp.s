section .text
    global ft_strcmp

; Fonction pour comparer deux strings
; Entree:
;   rdi - chaine 1
;   rsi - chaine 2
; Sortie:
;   rax - entier
ft_strcmp:
    xor r8, r8

loop:
    mov al, byte[rdi + r8]
    mov bl, byte[rsi + r8]

    cmp byte[rdi + r8], 0
    je stop_string

    cmp byte[rsi + r8], 0
    je stop_string

    cmp al, bl
    jne stop_string

    inc r8
    jmp loop

stop_string:
    sub al, bl
    movsx rax, al
    ret

stop_string_null:
    mov rax, 0
    ret