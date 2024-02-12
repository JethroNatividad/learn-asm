.model small
.stack

.data
message db "Enter Input: $"
input db ?, "$"

.code
start:
    MOV AX, @data
    MOV DS, AX
    
    MOV AH, 00H ; Show Screen
    INT 10H
    
    MOV AH, 09H
    MOV DX, offset message
    INT 21H
    
    MOV AH, 01H
    INT 21H
    MOV input, AL
    
    MOV AH, 09H
    MOV DX, offset input
    INT 21H
    
    MOV AH, 4CH
    INT 21H
end start