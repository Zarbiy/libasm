section .text
    global ft_write
    extern  errno_location

; Entree :
;   rdi - descripteur de fichier (par exemple, 1 pour stdout)
;   rsi - adresse du buffer (chaîne à afficher)
;   rdx - longueur de la chaîne à afficher

ft_write:
    mov rax, 1            ; Syscall number pour write (1)
    syscall               ; Appeler le système

    test rax, rax
    je handle_error

    ret

handle_error:
    neg		rax
	mov		rdi, rax
	call	__errno_location
	mov		[rax], rdi
	mov		rax, -1
	ret