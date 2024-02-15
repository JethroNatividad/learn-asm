; Write a program that takes a quote, and an author. and outputs it.
; Inputs: quote, author
; Processes: surround "" the quote
; Output: author says, "quote"

.model small
.stack

.data

.code
start:
    MOV AX, @data
    MOV DS, AX


    MOV AX, 4CH
    INT 21H
end