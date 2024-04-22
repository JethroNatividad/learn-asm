; Create a program that accepts 2 number inputs and checks if the first input is equal, less than, or greater than the second input.
.model small
.stack

.data
first_number_prompt db 'Enter first number:  ', '$'
second_number_prompt db 'Enter second number:  ', '$'
equal_msg db ' is equal to ', '$'
less_than_msg db ' is less than ', '$'
greater_than_msg db ' is greater than ', '$'
newline db 10, 13, '$'

first_number_max_length db 100
first_number_actual_length db ?
first_number_field db first_number_max_length dup(' ') ; buffer
first_number dw 0

second_number_max_length db 100
second_number_actual_length db ?
second_number_field db second_number_max_length dup(' ') ; buffer
second_number dw 0

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

    ; Convert to int
    LEA SI, first_number_field
    CALL str_to_num
    MOV first_number, AX

    ; Get second number
    MOV AH, 09H
    LEA DX, newline
    INT 21H

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

    ; Convert to int
    LEA SI, second_number_field
    CALL str_to_num
    MOV second_number, AX

    ; Print output
    MOV AH, 09H
    LEA DX, newline
    INT 21H

    MOV AH, 09H
    LEA DX, first_number_field
    INT 21H

    MOV AX, first_number
    MOV BX, second_number

    CMP AX, BX
    JE equal
    JG greater_than
    JL less_than

    equal:
        LEA DX, equal_msg
        JMP exit
    less_than:
        LEA DX, less_than_msg
        JMP exit
    greater_than:
        LEA DX, greater_than_msg
        JMP exit

    exit:
    MOV AH, 09H
    INT 21H

    MOV AH, 09H
    LEA DX, second_number_field
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

        JMP str_to_num_loop
    end_str_to_num:
        RET

end