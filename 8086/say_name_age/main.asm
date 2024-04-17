; Prompt the user to input their First Name.
; After the user inputs their first name, prompt them to input their Age
; Then clear the screen and display the inputted Name and Age of your user.

.model small
.stack

.data
name_prompt db 'What is your name? ', '$'
pre_name db 'Name: ', '$'

age_prompt db 10, 13, 'How old are you? ', '$'
pre_age db 10, 13, 'Age: ', '$'

name_max_length db 100
name_actual_length db ?
name_field db name_max_length dup(' ') ; buffer

age_max_length db 100
age_actual_length db ?
age_field db age_max_length dup(' ') ; buffer

.code
start:
    MOV AX, @data
    MOV DS, AX

    ; --- Prompt for name --- 
    ; Print prompt
    MOV AH, 09H
    LEA DX, name_prompt
    INT 21H

    ; Get Input
    MOV AH, 0AH
    LEA DX, name_max_length
    INT 21H

    ; Add $ to end of input
    XOR BH, BH
    MOV BL, name_actual_length
    MOV name_field[BX], '$'

    ; --- Prompt for age ---
    ; Print prompt
    MOV AH, 09H
    LEA DX, age_prompt
    INT 21H

    ; Get Input
    MOV AH, 0AH
    LEA DX, age_max_length
    INT 21H

    ; Add $ to end of input
    XOR BH, BH
    MOV BL, age_actual_length
    MOV age_field[BX], '$'

    ; Clear screen
    MOV AH, 00H
    MOV AL, 03H
    INT 10H


    ; Print name
    MOV AH, 09H
    LEA DX, pre_name
    INT 21H
    LEA DX, name_field
    INT 21H
    
    ; Print age
    MOV AH, 09H
    LEA DX, pre_age
    INT 21H
    LEA DX, age_field
    INT 21H

    MOV AH, 4CH
    INT 21H

end start