; Program to say hello to an input name.
; inputs: name
; process: concat the name to "Hello, {name}, nice to meet you!"
; output: the message

section .data
    prompt db "What is your name? "
    promptLen equ $ - prompt
    
    preNameMessage db "Hello, "
    preNameMessageLen equ $ - preNameMessage

    postNameMessage db ", nice to meet you!", 10
    postNameMessageLen equ $ - postNameMessage

section .bss
    name resb 100

section .text
    global _start

_start:
    mov rax, 1 ;set syscall id to 1 which is sys_write
    mov rdi, 1 ;set first argument to 1 tosys_write which means standard output
    mov rsi, text
    mov rdx, 14
    syscall


    mov rax, 60
    mov rdi, 0
    syscall