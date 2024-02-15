; Write a program that takes a quote, and an author. and outputs it.
; Inputs: quote, author
; Processes: surround "" the quote
; Output: author says, "quote"

.model small
.stack

.data
quote_prompt db "Enter a quote: $"

max_quote_size db 100
quote_size db ?
quote_buffer db max_quote_size dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_quote_prompt
    CALL get_quote_input
    CALL show_author_prompt
    CALL get_author_input
    CALL show_output

    MOV AH, 4CH
    INT 21H


show_quote_prompt:
    MOV AH, 09H
    MOV DX, offset quote_prompt
    INT 21H
    RET

get_quote_input:
    MOV AH, 0AH
    MOV DX, offset max_quote_size
    INT 21H

    ; Change last character to $
    XOR AX, AX
    LEA SI, quote_buffer
    MOV AL, quote_size
    ADD SI, AX
    MOV [SI], "$"
    RET

show_author_prompt:
    RET
get_author_input:
    RET
show_output:
    RET

end