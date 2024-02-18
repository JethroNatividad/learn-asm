; Program that takes in an age, and retirement age, then calculates the year of retirement
; Inputs: current age, retire age
; Process: calculate years until retire, get current retirement year.
; Outputs: years until retire, retirement year

.model small

.stack

.data
max_input_age_size db 5
input_age_size db ?
input_age db max_input_age_size dup(?)
age dw ?

max_input_retire_age_size db 5
input_retire_age_size db ?
input_retire_age db max_input_retire_age_size dup(?)
retire_age dw ?


years_until_retire dw ?
years_until_retire_str db 5 dup(?)
current_year dw ?
current_year_str db 5 dup(?)
retirement_year dw ?
retirement_year_str db 5 dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AX, offset input_age
    CALL str_to_num
    MOV age, AX

    MOV AX, offset input_retire_age
    CALL str_to_num
    MOV retire_age, AX

    MOV AH, 2AH
    INT 21H
    MOV current_year, CX

    XOR AX, AX
    XOR BX, BX
    MOV AX, age
    MOV BX, retire_age
    SUB BX, AX
    MOV years_until_retire, BX

    MOV AX, current_year
    MOV BX, years_until_retire
    ADD AX, BX
    MOV retirement_year, AX

    MOV AX, years_until_retire
    MOV SI, offset years_until_retire_str
    CALL num_to_str

    MOV AX, current_year
    MOV SI, offset current_year_str
    CALL num_to_str

    MOV AX, retirement_year
    MOV SI, offset retirement_year_str
    CALL num_to_str

    MOV AH, 4CH
    INT 21H

; Input: str in AX register
str_to_num:
    LEA SI, AX
    XOR AX, AX ; Start with 0
str_to_num_loop:
    XOR BX, BX
    MOV CX, 10
    MUL CX 
    MOV BL, [SI]
    SUB BL, "0"
    ADD AX, BX
    INC SI
    CMP [SI], "$"
    JNE str_to_num_loop
    RET
; Input: number in AX register
; Output: string in LEA SI
num_to_str:
    ; counter
    ; divisor to 10
    XOR CX, CX
    MOV BX, 10
division_loop:
    ; division loop
    ; div num to 10
    XOR DX, DX
    DIV BX
    INC CX

    ; push remainder to stack
    PUSH DX
    ; check if quotient 0
    CMP AX, 0
    ; jump to loop if greater than
    JG division_loop
build_str_loop:
    ; build str loop
    ; pop stack
    POP AX
    ; convert to ascii
    ADD AX, "0"
    ; add to var
    MOV [SI], AX
    ; move pointer
    INC SI
    ; loop until counter 0
    LOOP build_str_loop
    MOV [SI], "$"
    RET
end