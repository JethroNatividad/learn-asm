; Write a program that takes a quote, and an author. and outputs it.
; Inputs: quote, author
; Processes: surround "" the quote
; Output: author says, "quote"

.model small
.stack

.data
quote_prompt db "Enter a quote: $"

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_quote_prompt
    CALL get_quote_input
    CALL show_author_prompt
    CALL get_author_input
    CALL show_output

    MOV AX, 4CH
    INT 21H


show_quote_prompt:
    MOV AX, 09H
    MOV DX, quote_prompt
    INT 21H
    RET

get_quote_input:
    RET
show_author_prompt:
    RET
get_author_input:
    RET
show_output:
    RET

end