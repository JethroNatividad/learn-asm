; Program to say hello to an input name.
; inputs: name
; process: concat the name to "Hello, {name}, nice to meet you!"
; output: the message

section .data
    text db "Hello, World!", 10 ;define bytes "Hello, World!\n"

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, text
    mov rdx, 14
    syscall

    mov rax, 60
    mov rdi, 0
    syscall