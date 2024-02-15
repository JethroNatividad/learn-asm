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

.code
start:
    MOV AX, @data
    MOV DS, AX

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

get_number:
    ; get input

    ; converting to number
    ; store num, 0
    ; from first char
    ; num = (num * 10) + char - "0"

end