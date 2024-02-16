; Write a program that takes two numbers, and outputs the addition, subtraction, multiplication, and division.
; Inputs: first_number, second_number
; Process: convert to decimal, calculate addition, subtraction, multiplication, division, convert to ASCII.
; Outputs: 
; What is the first number? 10
; What is the second number? 5
; 10 + 5 = 15
; 10 - 5 = 5
; 10 * 5 = 50
; 10 / 5 = 2

.model small

.stack

.data
str_num db "65535$"
str_num_count db 3
num dd 0

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL get_input

    ; get first number
    ; convert to int

    ; get second number
    ; convert to int

    ; calculate addition
    ; convert result to str

    ; calculate subtraction
    ; convert result to str

    ; calculate multiplication
    ; convert result to str

    ; calculate division
    ; convert result to str

    MOV AH, 4CH
    INT 21H

get_input:
    ; get input

    ; converting to number
    ; store num, 0
    ; from first char
    ; num = (num * 10) + char - "0"
    XOR AX, AX
    LEA SI, str_num
to_num_loop:
    XOR DX, DX
    MOV BL, 10
    MUL BX
    MOV DL, [SI]
    SUB DL, "0"
    SUB [SI], "0"
    ADD AX, DX
    INC SI
    CMP [SI], "$"
    JNE to_num_loop
    MOV num, AX
    RET
end