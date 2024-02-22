; A program that takes in a str, and prints it in reverse
.model small
.stack

.data

max_input_size db 100
input_size db ?
input_buffer db max_input_size dup(?)

reverse_input db 100 dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV DX, offset max_input_size
    CALL get_input

    LEA SI, input_buffer
    LEA DI, reverse_input
    CALL reverse

    MOV AH, 4CH
    INT 21H

; inputs: max input size in DX
get_input:
    MOV AH, 0AH
    INT 21H

    ; add $ to end of str
    XOR BX, BX
    LEA SI, DX
    INC SI
    MOV BL, [SI] ; input size
    INC SI
    ADD SI, BX
    MOV [SI], "$"
    RET

; Inputs: str in LEA SI, output buffer in LEA DI
reverse:
    XOR CX, CX
    XOR DX, DX
find_end:
    MOV DL, [SI]
    INC SI
    MOV DL, [SI]
    INC CX
    CMP DL, "$"
    JNE find_end
    DEC SI
reverse_loop:
    MOV DL, [SI]
    MOV [DI], DL
    INC DI
    DEC SI
    LOOP reverse_loop
    MOV [DI], "$"
    RET 
end