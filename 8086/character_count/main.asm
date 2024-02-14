; Problem: program that counts the number of characters of an input
; input: something
; process: count the length
; output: the length

.model small
.stack

.data
prompt_message db "What is the input string? $"

max_input_size db 100
input_size db ?
input_buffer db max_input_size dup(?)

input_size_str db 3 dup("0") ; 3 as max input size only 100

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_prompt
    CALL get_input
    CALL input_size_to_string
    CALL show_output

    MOV AH, 4CH
    INT 21H

show_prompt:
    MOV AH, 09H
    MOV DX, offset prompt_message
    INT 21H
    RET

get_input:
    MOV AH, 0AH
    MOV DX, offset max_input_size
    INT 21H

    ; Add $ to end of input
    LEA SI, input_buffer
    XOR CX, CX
    MOV CL, input_size
    ADD SI, CX
    MOV [SI], "$"
    RET

input_size_to_string:
    MOV AL, input_size
    XOR CX, CX
    MOV BL, 10 ; to divide
input_size_to_string_loop:
    ; divide by 10 until 0
    ; push remainder to stack
    XOR DX, DX ; clear dx, dx stores remainder
    DIV BL
    PUSH DL
    INC CX
    CMP AL, 0
    JNE input_size_to_string_loop

    LEA SI, input_size_str
input_size_to_string_loop2:
    ; pop stack one by one, add "0"
    ; append to string input size
    POP AL
    ADD AL, "0"

    MOV [SI], AL
    INC SI
    LOOP input_size_to_string_loop2

    ; add $ to the end
    INC SI
    MOV [SI], "$"

    RET

show_output:
    RET

end