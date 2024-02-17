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
space db " $"
plus db " + $"
minus db " - $"
multiply db " * $"
divide db " / $"
equals db " = $"

first_number_prompt db "What's the first number? $"
second_number_prompt db 10, 13, "What's the second number? $"

max_first_number_size db 5
first_number_size db ?
first_number_buffer db max_first_number_size dup(?)
first_number dd 0

max_second_number_size db 5
second_number_size db ?
second_number_buffer db max_second_number_size dup(?)
second_number dd 0

sum dw 0
sum_str db 6 dup(?)

difference dw 0
difference_str db 6 dup(?)

product dw 0
product_str db 6 dup(?)

quotient dw 0
quotient_str db 6 dup(?)


.code
start:
    MOV AX, @data
    MOV DS, AX

    ; get first number
    MOV DX, offset first_number_prompt
    CALL print

    MOV DX, offset max_first_number_size
    CALL get_input

    ; convert to int
    MOV DX, offset first_number_buffer
    CALL to_num
    MOV first_number, AX

    ; get second number
    MOV DX, offset second_number_prompt
    CALL print

    MOV DX, offset max_second_number_size
    CALL get_input

    ; convert to int
    MOV DX, offset second_number_buffer
    CALL to_num
    MOV second_number, AX

    ; calculate addition
    XOR AX, AX
    MOV AX, first_number
    MOV BX, second_number
    ADD AX, BX
    MOV sum, AX

    ; convert result to str
    MOV AX, sum
    MOV BX, offset sum_str
    CALL to_str


    ; calculate subtraction
    XOR AX, AX
    MOV AX, first_number
    MOV BX, second_number
    SUB AX, BX
    MOV difference, AX
    ; convert result to str
    MOV AX, difference
    MOV BX, offset difference_str
    CALL to_str


    ; calculate multiplication
    XOR AX, AX
    MOV AX, first_number
    MOV BX, second_number
    MUL BX
    MOV product, AX
    ; convert result to str
    MOV AX, product
    MOV BX, offset product_str
    CALL to_str

    ; calculate division
    XOR AX, AX
    XOR DX, DX
    MOV AX, first_number
    MOV BX, second_number
    DIV BX
    MOV quotient, AX
    ; convert result to str
    MOV AX, quotient
    MOV BX, offset quotient_str
    CALL to_str

    ; print sum
    MOV DX, offset newline
    CALL print
    MOV DX, offset first_number_buffer
    CALL print
    MOV DX, offset plus
    CALL print
    MOV DX, offset second_number_buffer
    CALL print
    MOV DX, offset equals
    CALL print
    MOV DX, offset sum_str
    CALL print

    ; print difference
    MOV DX, offset newline
    CALL print
    MOV DX, offset first_number_buffer
    CALL print
    MOV DX, offset minus
    CALL print
    MOV DX, offset second_number_buffer
    CALL print
    MOV DX, offset equals
    CALL print
    MOV DX, offset difference_str
    CALL print

    MOV AH, 4CH
    INT 21H

; Inputs: AX - input, BX - output
to_str:
    LEA SI, BX
    XOR CX, CX ; counter
    MOV BX, 10
to_str_loop:
    MOV DX, 00H ; Clear DX before division, DX stores the remainder
    DIV BX
    PUSH DX ; remainder
    INC CX
    CMP AX, 0
    JG to_str_loop
to_str_loop_2:
    POP AX
    ADD AX, "0" ; Convert to ascii
    MOV [SI], AX
    INC SI
    LOOP to_str_loop_2
    MOV [SI], "$"
    RET

; input: text in DX
print:
    MOV AH, 09H
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