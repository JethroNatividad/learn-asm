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

    MOV DX, max_input_size
    CALL get_input

    MOV AH, 4CH
    INT 21H

; inputs: max input size in DX
get_input:
    MOV AH, 0AH
    INT 21H

    ; add $ to end of str
    LEA SI, DX
    INC SI
    MOV BX, [SI] ; input size
    INC SI
    ADD SI, BX
    MOV [SI], "$"
    RET
    
end