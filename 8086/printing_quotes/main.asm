.model small
.stack

.data

.code
start:
    MOV AX, @data
    MOV DS, AX


    MOV AX, 4CH
    INT 21H
end