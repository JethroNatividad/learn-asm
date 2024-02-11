; Program that takes in an input, and outputs the number of characters it has.
; inputs: input
; process: count the number of characters
; output: the number of characters

section .data
    prompt db "What is the input string? "
    prompt_len equ $ - prompt
section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    mov rax, 60
    mov rdi, 0
    syscall