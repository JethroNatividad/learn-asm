; Problem: program that counts the number of characters of an input
; input: something
; process: count the length
; output: the length

.model small
.stack

.data
prompt_message db "What is the input string? $"

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
end start

show_prompt:
    MOV AH, 09H
    MOV DX, offset prompt_message
    INT 21H
    RET
end show_prompt

get_input:

end get_input

to_string:

end to_string

show_output:

end show_output

