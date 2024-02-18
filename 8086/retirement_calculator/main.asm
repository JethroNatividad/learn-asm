; Program that takes in an age, and retirement age, then calculates the year of retirement
; Inputs: current age, retire age
; Process: calculate years until retire, get current retirement year.
; Outputs: years until retire, retirement year

.model small

.stack

.data
age db 25
retire_age db 65
years_until_retire dw ?
current_year dw ?
retirement_year dw ?

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 2AH
    INT 21H
    MOV current_year, CX

    XOR AX, AX
    XOR BX, BX
    MOV AL, age
    MOV BL, retire_age
    SUB BX, AX
    MOV years_until_retire, BX

    MOV AX, current_year
    MOV BX, years_until_retire
    ADD AX, BX
    MOV retirement_year, AX

    MOV AH, 4CH
    INT 21H

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
    JGE division_loop

    ; build str loop
    ; pop stack
    ; convert to ascii
    ; add to var
    ; move pointer
    ; loop until counter 0
end