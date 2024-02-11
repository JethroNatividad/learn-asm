section .data
    input dd 5

section .bss
    output resb 8

section .text
    global _start

_start:
    mov rax, input
    call _factorial
    call _printFactorial


    ; END
    mov rax, 60
    mov rdi, 0
    syscall

; input: value from rax
; output: factorial to rax
_factorial:
    mov rcx, rax ; total product
_factorialLoop:
    sub rax, 1
    mul rcx

    cmp rax, 1
    jg _factorialLoop
    mov rax, rcx
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
    ret

_printFactorial:
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, 8
    syscall