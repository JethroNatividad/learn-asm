.model small
.stack

.data
message db "What is your name? $"

max_input_size db 100
actual_input_size db ?
input db 100 dup(0) ; buffer

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 00H
    INT 10H

    MOV AH, 09H
    MOV DX, offset message
    INT 21H

    LEA DX, max_input_size
    MOV AH, 0AH
    INT 21H

    MOV AL, "$"
    MOV SI, offset input
    ADD SI, offset actual_input_size
    MOV [SI], AL

    MOV AH, 09H
    MOV DX, offset input
    INT 21H

    MOV AH, 4CH
    INT 21H
end start