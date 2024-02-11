section .data
    prompt db "What's your name? "
    prompt_len equ $ - prompt
 
section .bss
    input_len equ 100
    input resb input_len

section .text
    global _start
 
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, input_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, input_len
    syscall

    mov rax, 60
    mov rdi, 1
    syscall
