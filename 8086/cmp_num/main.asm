; Create a program that accepts 2 number inputs and checks if the first input is equal, less than, or greater than the second input.

.model small

.stack

.data
; first_number_prompt db 'Enter first number:  ', '$'
; second_number_prompt db 'Enter second number:  ', '$'

; first_number_max_length db 100
; first_number_actual_length db ?
; first_number_field db first_number_max_length dup(' ') ; buffer
; first_number db 0

; second_number_max_length db 100
; second_number_actual_length db ?
; second_number_field db second_number_max_length dup(' ') ; buffer
; first_number db 0

first_number_field db '123$'

.code
start:
    MOV AX, @data
    MOV DS, AX

    LEA SI, first_number_field
    CALL str_to_num 

    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H

; Convert str to num
; Inputs: SI
; Output: AX
str_to_num:
    XOR AX, AX 
    MOV CX, 10
    str_to_num_loop:
        MOV BL, [SI]
        CMP BL, '$'
        JE end_str_to_num

        ; AX = (AX * 10) + BX
        SUB BL, '0'
        MUL CX
        ADD AX, BX
        INC SI ; move to next letter

        JMP str_to_num
    end_str_to_num:
        RET

end