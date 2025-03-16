section .text 
    global ft_list_push_front
    extern malloc

; Entree:
;   rdi - list
;   rsi - data
ft_list_push_front:
    test rdi, rdi
    jz .end

    test rsi, rsi
    jz .end

    push rdi
    push rsi
    mov rdi, 16             ; create node 16 octet
    call malloc wrt ..plt
    test rax, rax
    jz .error_malloc
    pop rsi
    pop rdi

    mov [rax], rsi          ; first 8 put data in
    mov rdx, [rdi]
    mov [rax+8], rdx        ; second 8 put next in
    mov [rdi], rax          ; reset begin list

    ret

.error_malloc:
    pop rsi
    pop rdi
    mov rax, -1
    ret

.end:
    ret
