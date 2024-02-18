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

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 2AH
    INT 21H
    MOV current_year, CX

    XOR AX, AX
    MOV AL, age
    MOV BL, retire_age
    SUB BX, AX
    MOV years_until_retire, BX

    MOV AH, 4CH
    INT 21H
end