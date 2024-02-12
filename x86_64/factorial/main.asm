section .data
    input db 11

section .bss
    output resb 8
    reverse resb 8

section .text
    global _start

_start:
    mov rax, [input]
    call _factorial
    call _convertToString
    call _printFactorial

    ; END
    mov rax, 60
    mov rdi, 0
    syscall

; input: value from rax
; output: factorial to rax
_factorial:
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
    

    ; length: 3
    ; 0 2 1
    ; [rsi + 2] [rsi + 1 ] [rsi + 0] 
    ; 1 2 0




_printFactorial:
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, 8
    syscall
    ret