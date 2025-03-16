section .text
    global ft_list_size

; Entree:
;   rdi - list
; Sortie:
;   rax - size list
ft_list_size:
    xor r8, r8
    test rdi, rdi
    jz .end

.loop:
    inc r8

    mov rdi, [rdi+8]
    test rdi, rdi
    jnz .loop

.end:
    mov rax, r8
    ret
