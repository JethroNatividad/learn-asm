; A program that takes in a str, and prints it in reverse
.model small
.stack

.data
max_input_size db 100
input_size db ?
input db max_input_size dup(?)
reverse_input db 50 dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV DX, offset max_input_size
    CALL get_input

    MOV AX, offset input
    MOV BX, offset reverse_input
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

; Inputs: str in AX, output buffer in BX
; Output: reverse in DX
reverse:
    MOV SI, AX
    XOR CX, CX
reverse_loop:
    MOV DL, [SI]
    PUSH DX
    INC SI
    MOV DL, [SI]
    INC CX
    CMP DL, "$"
    JNE reverse_loop
    MOV SI, BX
reverse_loop_2:
    POP [SI]
    INC SI
    LOOP reverse_loop_2
    MOV [SI], "$"
    RET
    
end