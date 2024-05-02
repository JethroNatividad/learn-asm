; Create a program that accepts 2 number inputs and checks if the first input is equal, less than, or greater than the second input.
.model small
.stack

.data
first_number_prompt db 'Enter first number:  ', '$'
second_number_prompt db 'Enter second number:  ', '$'
third_number_prompt db 'Enter third number:  ', '$'
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

third_number_max_length db 100
third_number_actual_length db ?
third_number_field db third_number_max_length dup(' ') ; buffer
third_number dw 0

largest_number dw 0
largest_number_label db 'The largest number is: ', '$'
largest_number_str db 100 dup(' ')

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

    ; Get third number
    MOV AH, 09H
    LEA DX, newline
    INT 21H
    
    MOV AH, 09H
    LEA DX, third_number_prompt
    INT 21H

    MOV AH, 0AH
    LEA DX, third_number_max_length
    INT 21H
    ; Add '$' to end
    XOR BX, BX
    MOV BL, third_number_actual_length
    MOV third_number_field[BX], '$'

    ; Convert to int
    LEA SI, third_number_field
    CALL str_to_num
    MOV third_number, AX

    ; Get the largest number
    ; 1st > 2nd ? 1st > 3rd ? 1st : 3rd : 2nd > 3rd ? 2nd : 3rd
    MOV AX, first_number
    CMP AX, second_number
    JG first_greater_than_second
    MOV AX, second_number
    first_greater_than_second:
    CMP AX, third_number
    JG first_greater_than_third
    MOV AX, third_number
    first_greater_than_third:
    MOV largest_number, AX

    LEA BX, largest_number_str
    CALL num_to_str

    ; Print largest number
    MOV AH, 09H
    LEA DX, largest_number_label
    INT 21H

    MOV AH, 09H
    LEA DX, largest_number_str
    INT 21H

    exit:

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

; Inputs: AX - input, BX - output
num_to_str:
    LEA SI, BX
    XOR CX, CX ; counter
    MOV BX, 10
num_to_str_loop:
    MOV DX, 00H ; Clear DX before division, DX stores the remainder
    DIV BX
    PUSH DX ; remainder
    INC CX
    CMP AX, 0
    JG num_to_str_loop
num_to_str_loop_2:
    POP AX
    ADD AX, "0" ; Convert to ascii
    MOV [SI], AX
    INC SI
    LOOP num_to_str_loop_2
    MOV [SI], "$"
    RET
end