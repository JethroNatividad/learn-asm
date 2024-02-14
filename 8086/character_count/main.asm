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

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_prompt
    CALL get_input
    CALL to_string
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
    MOV DX, max_input_size
    INT 21H
    RET

to_string:
    RET

show_output:
    RET

end