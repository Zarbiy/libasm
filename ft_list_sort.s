section .text
    global ft_list_sort

; Entree:
;   rdi - **list
;   rsi - function (strcmp)
ft_list_sort:
    test rdi, rdi
    jz .end

    test rsi, rsi
    jz .end

    mov r10, rsi            ; save function
    mov r12, [rdi]          ; save list

.init:
    xor r11, r11            ; init flag swap
    mov rbx, r12

.loop:
    mov rcx, [rbx+8]        ; next node

    test rcx, rcx
    jz .check_swap

    mov rdi, [rbx]
    mov rsi, [rcx]
    push rcx
    call r10
    pop rcx
    cdqe                    ; permet de passer le retour de strcmp de 32bits a 64bits
    cmp rax, 0
    jle .no_swap            ; if rdi <= rsi no change

    mov [rbx], rsi
    mov [rcx], rdi
    mov r11, 1

.no_swap:
    mov rbx, rcx
    jmp .loop

.check_swap:                ; if swap restart
    test r11, r11
    jnz .init

.end:
    ret