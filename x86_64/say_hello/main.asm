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
    nameLen equ 50
    name resb nameLen

section .text
    global _start

_start:
    call _displayPrompt
    call _getName
    call _displayGreeting

    mov rax, 60
    mov rdi, 0
    syscall

_displayPrompt:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, promptLen
    syscall
    ret

_getName:
    mov rax, 0
    mov rdi, 0
    mov rsi, name
    mov rdx, nameLen
    syscall

    dec rax
    mov byte [rsi + rax], 0
    ret

_displayGreeting:
    mov rax, 1
    mov rdi, 1
    mov rsi, preNameMessage
    mov rdx, preNameMessageLen
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, name
    mov rdx, nameLen
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, postNameMessage
    mov rdx, postNameMessageLen
    syscall
    ret