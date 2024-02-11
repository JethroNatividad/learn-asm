; Program that takes in an input, and outputs the number of characters it has.
; inputs: input
; process: count the number of characters
; output: {input} has {len} characters.

section .data
    prompt db "What is the input string? "
    prompt_len equ $ - prompt

    outputText1 db " has "
    outputText2 db " characters."

section .bss
    input_len equ 100
    input resb input_len
    len_string resb 8

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
    ret

_getInput:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, input_len
    syscall
    ret


_convertLengthToString:
    mov rcx, 0 ;counter
_convertLengthToStringLoop:
    mov rsi, len_string
    mov rdx, 0
    mov rbx, 10
    div rbx
    add rdx, '0' ; convert the remainder to an ASCII character
    mov byte [rsi + rcx], dl ; store the character in the buffer
    inc rcx
    cmp rax, 0
    jne _convertLengthToStringLoop
    ret

_displayLength:

    mov byte
    ; TODO
    mov rax, 1
    mov rdi, 1
    mov rsi, len_string
    mov rdx, 2
    syscall
    ret