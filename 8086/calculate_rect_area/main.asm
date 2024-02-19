; Program that calculates the sqft of a rectangular room

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