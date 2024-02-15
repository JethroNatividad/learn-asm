; Write a program that takes a quote, and an author. and outputs it.
; Inputs: quote, author
; Processes: surround "" the quote
; Output: author says, "quote"

.model small
.stack

.data
quote_prompt db "Enter a quote: $"
author_prompt db 10, 13, "Who is the author? $"


max_quote_size db 100
quote_size db ?
quote_buffer db max_quote_size dup(?)

max_author_size db 100
author_size db ?
author_buffer db max_author_size dup(?)

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
    MOV AH, 09H
    MOV DX, offset author_prompt
    INT 21H
    RET

get_author_input:
    MOV AH, 0AH
    MOV DX, offset max_author_size
    INT 21H
    ; Change last character to $
    XOR AX, AX
    LEA SI, author_buffer
    MOV AL, author_size
    ADD SI, AX
    MOV [SI], "$"
    RET
    
show_output:
    RET

end