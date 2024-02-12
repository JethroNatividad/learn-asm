.model small
.stack

.data
message db "Enter Input: $"
input db ?
factorial db ?

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

    ; factorial the input
    
    ; product
    ; multiplier
    MOV AX, 00H
    MOV AL, input
    MOV BL, AL
    
factorial_loop:
    DEC BL
    MUL BL
    
    CMP BL, 1
    JG factorial_loop
    MOV factorial, AX
    
    MOV AH, 09H
    MOV DX, offset input
    INT 21H
    
    MOV AH, 4CH
    INT 21H
end start