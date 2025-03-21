section .text
    global ft_list_remove_if

; Entree:
;   rdi - **list
;   rsi - data to find
;   rdx - strcmp
;   rcx - free
ft_list_remove_if:
    test rdi, rdi
    jz .end

    test rdx, rdx
    jz .end

    test rcx, rcx
    jz .end

    mov r8, [rdi]       ; save first node
    mov r9, rsi         ; save data to find
    mov r10, rdx        ; save strcmp
    mov r11, rcx        ; save free

.loop:
    test r8, r8
    jz .end

    mov rdi, r9
    mov rsi, [r8]
    call r10




    mov r8, [r8+8]
    jmp .loop

.remove_node:

    call r11


    mov r8, [r8+8]
    jmp .loop


.end:
    ret
