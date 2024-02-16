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
newline db 10, 13, "$"

max_first_number_size db 5
first_number_size db ?
first_number_buffer db max_first_number_size dup(?)
first_number dd 0

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV DX, offset max_first_number_size
    CALL get_input

    MOV DX, offset first_number_buffer
    CALL to_num
    MOV first_number, AX

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

; Inputs: DX
print:
    MOV AH, 09H
    INT 21H
    RET

println:
    MOV BX, DX
    MOV AH, 09H

    MOV DX, newline
    INT 21H

    MOV DX, BX
    INT 21H

    MOV DX, newline
    INT 21H
    
    RET

; Inputs: max input size in DX
get_input:
    MOV AH, 0AH
    INT 21H

    ; Add $ to end
    LEA SI, DX
    INC SI
    MOV BL, [SI]
    ADD SI, BX
    INC SI
    MOV [SI], "$"
    RET

; Inputs: DX
; Outputs: AX
to_num:
    ; converting to number
    ; store num, 0
    ; from first char to $
    ; num = (num * 10) + char - "0"
    XOR AX, AX
    LEA SI, DX
to_num_loop:
    XOR DX, DX
    MOV BL, 10
    MUL BX
    MOV DL, [SI]
    SUB DL, "0"
    ADD AX, DX
    INC SI
    CMP [SI], "$"
    JNE to_num_loop
    RET
end