section .data
    prompt db "Enter a number for factorial: "
    prompt_len equ $ - prompt

section .bss
    output resb 8
    reverse resb 8
    input resb 8

section .text
    global _start

_start:
    call _printPrompt
    call _getInput
    call _factorial
    call _convertToString
    call _printFactorial

    ; END
    mov rax, 60
    mov rdi, 0
    syscall

_getInput:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 8
    syscall
    ret

_printPrompt:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall
    ret

; input: value from rax
; output: factorial to rax
_factorial:
    mov rax, [input]
    mov rcx, rax ; lower value
_factorialLoop:
    dec rcx
    mul rcx

    cmp rcx, 1
    jg _factorialLoop
    ret

; input: value from rax
; output: string
_convertToString:
    mov rcx, 0 ;counter

_convertToStringLoop:
    mov rsi, output
    mov rdx, 0
    mov rbx, 10
    div rbx
    add rdx, '0' ; convert the remainder to an ASCII character
    mov byte [rsi + rcx], dl ; store the character in the buffer
    inc rcx
    cmp rax, 0
    jne _convertToStringLoop

; inputs: rax as input, rdi as length
; ouputs: reverse string
    mov rdi, rcx
_reverseString:
    mov rax, rsi
    add rax, rdi
    dec rax
_reverseStringLoop:
    cmp rsi, rax
    jae _reverseStringEnd
    mov dl, [rsi]
    mov bl, [rax]
    mov [rsi], bl
    mov [rax], dl
    inc rsi
    dec rax
    jmp _reverseStringLoop
_reverseStringEnd:
    ret
    
_printFactorial:
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, 8
    syscall
    ret