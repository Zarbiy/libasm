section .text
    global ft_strcmp

; Fonction pour comparer deux strings
; Entree:
;   rdi - chaine 1
;   rcx - chaine 2
; Sortie:
;   rax - entier
ft_strcmp:
    xor r8, r8

loop:
    mov al, byte[rdi + r8]
    mov bl, byte[rcx + r8]

    cmp al, bl
    jne stop_string

    cmp byte[rdi + r8], 0
    je stop_string

    cmp byte[rcx + r8], 0
    je stop_string

    inc r8
    jmp loop

stop_string:
    sub al, bl
    movsx rax, al
    ret