; Create a program that accepts 2 number inputs and checks if the first input is equal, less than, or greater than the second input.
.model small
.stack

.data
first_number_prompt db 'Enter first number:  ', '$'
second_number_prompt db 'Enter second number:  ', '$'
equal_msg db ' is equal to ', '$'
less_than_msg db ' is less than ', '$'
greater_than_msg db ' is greater than ', '$'

first_number_max_length db 100
first_number_actual_length db ?
first_number_field db first_number_max_length dup(' ') ; buffer

second_number_max_length db 100
second_number_actual_length db ?
second_number_field db second_number_max_length dup(' ') ; buffer

.code
start:
    MOV AX, @data
    MOV DS, AX

    ; Get first number
    MOV AH, 09H
    LEA DX, first_number_prompt
    INT 21H

    MOV AH, 0AH
    LEA DX, first_number_max_length
    INT 21H
    ; Add '$' to end
    XOR BX, BX
    MOV BL, first_number_actual_length
    MOV first_number_field[BX], '$'

    ; Get second number
    MOV AH, 09H
    LEA DX, second_number_prompt
    INT 21H

    MOV AH, 0AH
    LEA DX, second_number_max_length
    INT 21H
    ; Add '$' to end
    XOR BX, BX
    MOV BL, second_number_actual_length
    MOV second_number_field[BX], '$'



    MOV AH, 4CH
    INT 21H
end