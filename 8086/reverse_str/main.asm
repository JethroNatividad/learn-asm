; A program that takes in a str, and prints it in reverse
.model small
.stack

.data
max_input_size db 100
input_size db ?
input db max_input_size dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX



    MOV AH, 4CH
    INT 21H
end