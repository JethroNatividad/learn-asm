; Problem: program that counts the number of characters of an input
; input: something
; process: count the length
; output: the length

.model small
.stack

.data

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

end show_prompt

get_input:

end get_input

to_string:

end to_string

show_output:

end show_output

