.model small
.stack

.data
question db "What is your name? $"
message db 13, 10, "Hello $"
message2 db "How are you?", 13, 10, "$"

max_input_size db 100
input_size db ?
input_buffer db max_input_size dup(?) ; buffer

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 00H
    INT 10H

    MOV AH, 09H
    MOV DX, offset question
    INT 21H

    MOV AH, 0AH
    MOV DX, offset max_input_size
    INT 21H

    MOV BL, AL
    MOV AL, "$"
    XOR CX, CX
    MOV CL, input_size
    LEA SI, input_buffer
    ADD SI, CX
    MOV [SI], AL

    MOV AH, 09H
    MOV DX, offset message
    INT 21H

    MOV AH, 09H
    MOV DX, offset input_buffer
    INT 21H

    MOV AH, 09H
    MOV DX, offset message2
    INT 21H

    MOV AH, 4CH
    INT 21H
end start