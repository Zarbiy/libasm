; nasm -f elf64 -o main.o main.s
; ld -o a.out main.o libasm.a

section .data
    newline db 10, 0
    msg db "Hello, World!", 10, 0
    src db "Hello source", 0
    msgError db "Error exiting", 10, 0

    filename db "ft_write.s", 0

section .bss
    dest resb 50
    buffer resb 20         ; Buffer ft_read

section .text
    global _start
    extern errno_location

    extern ft_strlen
    extern ft_putnbr
    extern ft_write
    extern ft_strcpy
    extern ft_strcmp
    extern ft_read

_start:
; Test ft_read
    mov rdi, filename               ; Chemin du fichier
    mov rsi, 0                      ; O_RDONLY (lecture seule)
    mov rdx, 0                      ; Pas de permissions nécessaires ici
    mov rax, 2                      ; Syscall number pour open (2)
    syscall
    
    call verifExecSyscall

    mov rdi, rax
    lea rsi, [buffer]
    mov rdx, 20
    call ft_read

    cmp rax, -1
    jl handle_error_main

    mov rdi, buffer
    call ft_write
    call verifExecSyscall
    call printendl
; Test ft_write
    mov rdi, msg
    call ft_write
    call verifExecSyscall
    call printendl
; Test ft_strlen
    mov rdi, msg
    call ft_strlen

    mov rdi, rax
    call ft_putnbr

    call printendl
; Test ft_strcpy
    mov rdi, src
    lea rcx, [dest]
    mov rdx, 50
    call ft_strcpy

    mov rdi, src
    call ft_write
    call verifExecSyscall
    call printendl
    mov rdi, dest
    call ft_write
    call verifExecSyscall
    call printendl
; Test ft_strcmp
    mov rdi, msg
    mov rcx, src
    call ft_strcmp

    mov rdi, rax
    call ft_putnbr
    call printendl

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

printendl:
    push rax
    push rdi
    push rsi
    push rdx

    mov rax, 1
    lea rsi, [newline]
    mov rdx, 1
    mov rdi, 1
    syscall

    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

handle_error_main:
    mov rdi, msgError
    call ft_write
    call verifExecSyscall

    mov rax, 60
    mov rdi, rax
    syscall

verifExecSyscall:
    test rax, rax
    js handle_error_main
    ret