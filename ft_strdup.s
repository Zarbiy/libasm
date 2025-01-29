section .text
    global ft_strdup
    extern malloc
    extern ft_strlen

; Fonction pour creer un nouveau pointeur d'une string
; Entree:
;   rdi - chaine a copier
; Sortie:
;   
ft_strdup: