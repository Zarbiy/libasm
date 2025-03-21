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

    mov r14, rdi        ; save tete de liste
    mov r8, [rdi]       ; save first node
    mov r9, rsi         ; save data to find
    mov r10, rdx        ; save strcmp
    mov r11, rcx        ; save free
    xor r12, r12        ; prev node

.loop:
    test r8, r8
    jz .end

    mov rdi, r9
    mov rsi, [r8]
    call r10
    cdqe
    cmp rax, 0
    jnz .pass

    mov r13, [r8+8]
    mov rdi, r8
    call r11

    cmp r12, 0          ; check if update first node
    je .update_first

    mov [r12+8], r13     ; sinon update les next
    jmp .continue_loop


.update_first:
    mov [r14], r13

.continue_loop:
    mov r8, r13
    jmp .loop

.pass:
    mov r12, r8         ; prev = current
    mov r8, [r8+8]      ; current = next
    jmp .loop

.end:
    ret
