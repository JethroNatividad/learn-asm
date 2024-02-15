; Write a program that takes two numbers, and outputs the addition, subtraction, multiplication, and division.

.model small

.stack

.data

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 4CH
    INT 21H
end