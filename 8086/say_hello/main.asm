.model small
.stack

.data
message db "Hello World!$"

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 09H
    MOV DX, offset message
    INT 21H

    MOV AH, 4CH
    INT 21H
end start