; A program that takes in a str, and prints it in reverse
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