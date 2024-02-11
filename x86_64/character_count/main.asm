; Program that takes in an input, and outputs the number of characters it has.
; inputs: input
; process: count the number of characters
; output: {input} has {len} characters.

section .data
    prompt db "What is the input string? "
    prompt_len equ $ - prompt

    output_text_1 db " has "
    output_text_1_len equ $ - output_text_1
    output_text_2 db " characters.", 10
    output_text_2_len equ $ - output_text_2


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

    mov rcx, rax
    dec rcx
    mov byte [rsi + rcx], 0
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
    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, input_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, output_text_1
    mov rdx, output_text_1_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, len_string
    mov rdx, 8
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, output_text_2
    mov rdx, output_text_2_len
    syscall
    ret