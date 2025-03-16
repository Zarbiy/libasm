section .text:
    global ft_list_sort

; Entree:
;   rdi - list
;   rsi - function (strcmp)
ft_list_sort:
    test rdi, rdi
    jz .end

    test rsi, rsi
    jz .end

    mov r10, rsi         ; save function
    mov r12, rdi

.init:
    xor r11, r11         ; init flag swap
    mov rbx, r12

.loop:
    mov rcx, [rbx+8]

    test rcx, rcx
    jz .check_swap

    mov rdi, [rbx]
    mov rsi, [rcx]
    call r10
    cmp rax, 0
    jle .no_swap         ; if rdi <= rsi no change

    mov r8, [rbx]
    mov r9, [rcx]
    mov [rbx], r9
    mov [rcx], r8
    mov r11, 1

.no_swap:
    mov rbx, rcx
    jmp .loop

.check_swap:              ; if swap restart
    test r11, r11
    jnz .init

.end:
    ret
