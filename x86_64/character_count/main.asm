; Program that takes in an input, and outputs the number of characters it has.
; inputs: input
; process: count the number of characters
; output: {input} has {len} characters.

section .data
    prompt db "What is the input string? "
    prompt_len equ $ - prompt

section .bss
    input_len equ 100
    input resb input_len

section .text
    global _start

_start:
    call _displayPrompt
    call _getInput
    call _convertLengthToString
    call _displayLength

    mov rax, 60
    mov rdi, 0
    syscall

_displayPrompt:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

_getInput:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, input_len
    syscall
