; Create a menu that you can select, and prints the message.
.data
; Parent Program Variables
newline db 10, 13, '$'
item1 db '1] Activity 1', '$'
item2 db '2] Activity 2', '$'
item3 db '3] Activity 3', '$'
item4 db '4] Activity 4', '$'
item5 db '5] Activity 5', '$'
item6 db '6] Activity 6', '$'
invalid_choice db 'Invalid choice, please try again.', '$'

choice_prompt db 'Enter choice: $'

choice_max_length db 2
choice_actual_length db ?
choice_field db choice_max_length dup(' ') ; buffer
; End Parent Program Variables


; Activity 1 Variables
Surname_1 DB 'Alvarez', '$'
Surname_2 DB 'Bobon', '$'
Surname_3 DB 'Falcatan', '$'
Surname_4 DB 'Gomez', '$'
Surname_5 DB 'Marcelino', '$'
Surname_6 DB 'Natividad', '$'
Surname_7 DB 'Sahibul', '$'
Surname_8 DB 'Tulawe', '$'
; End Activity 1 Variables

; Activity 2 Variables
name_prompt db 'What is your name? ', '$'
pre_name db 'Name: ', '$'

age_prompt db 10, 13, 'How old are you? ', '$'
pre_age db 10, 13, 'Age: ', '$'

name_max_length db 30
name_actual_length db ?
name_field db name_max_length dup(' ') ; buffer

age_max_length db 30
age_actual_length db ?
age_field db age_max_length dup(' ') ; buffer
; End Activity 2 Variables

; Activity 3 Variables
first_number_prompt db 'Enter first number:  ', '$'
second_number_prompt db 'Enter second number:  ', '$'
third_number_prompt db 'Enter third number:  ', '$'
equal_msg db ' is equal to ', '$'
less_than_msg db ' is less than ', '$'
greater_than_msg db ' is greater than ', '$'

first_number_max_length db 30
first_number_actual_length db ?
first_number_field db first_number_max_length dup(' ') ; buffer
first_number dw 0

second_number_max_length db 30
second_number_actual_length db ?
second_number_field db second_number_max_length dup(' ') ; buffer
second_number dw 0

third_number_max_length db 30
third_number_actual_length db ?
third_number_field db third_number_max_length dup(' ') ; buffer
third_number dw 0

largest_number dw 0
largest_number_label db 'The largest number is: ', '$'
largest_number_str db 30 dup(' ')
; End Activity 3 Variables

; Activity 4 Variables
output1 db 10, 13, "One day our teacher decided to quit his job and apply to be the school's $"
output2 db ". The employer of the university however thought that he was too $"
output3 db ".  So our teacher decided to $"
output4 db ", not knowing that his $"
output5 db " broke down, costing him the job. $"

verb_prompt db "Enter a verb: $"
noun_prompt db 10, 13, "Enter a noun: $"
occupation_prompt db 10, 13, "Enter an occupation: $"
adjective_prompt db 10, 13, "Enter an adjective: $"

max_input_noun_size db 30
input_noun_size db ?
input_noun_buffer db max_input_noun_size dup(' ')

max_input_occupation_size db 30
input_occupation_size db ?
input_occupation_buffer db max_input_occupation_size dup(' ')

max_input_adjective_size db 30
input_adjective_size db ?
input_adjective_buffer db max_input_adjective_size dup(' ')

max_input_verb_size db 30
input_verb_size db ?
input_verb_buffer db max_input_verb_size dup(' ')

; End Activity 4 Variables

; Activity 5 Variables
prompt_message db "What is the input string? $"
output_message db 10, 13, "$"
output_message1 db " has $"
output_message2 db " character/s. ", 10, 13, "$"

max_input_size db 100
input_size db ?
input_buffer db max_input_size dup('' )

input_size_str db 3 dup(' ') ; 3 as max input size only 100
; End Activity 5 Variables


.code
start:
    MOV AX, @data
    MOV DS, AX

    ; Print menu
    LEA DX, item1
    CALL print

    LEA DX, newline
    CALL print

    LEA DX, item2
    CALL print

    LEA DX, newline
    CALL print

    LEA DX, item3
    CALL print

    LEA DX, newline
    CALL print

    LEA DX, item4
    CALL print

    LEA DX, newline
    CALL print

    LEA DX, item5
    CALL print

    LEA DX, newline
    CALL print

    LEA DX, item6
    CALL print

    LEA DX, newline
    CALL print

    ; Get choice
    get_choice:
        MOV AH, 09H
        LEA DX, choice_prompt
        INT 21H

        MOV AH, 0AH
        LEA DX, choice_max_length
        INT 21H

        XOR BX, BX
        MOV BL, choice_actual_length
        MOV choice_field[BX], '$'

        LEA DX, newline
        CALL print

        ; Compare choice and print message
        CMP choice_field, '1'
        JE activity_1
        CMP choice_field, '2'
        JE activity_2
        CMP choice_field, '3'
        JE activity_3
        CMP choice_field, '4'
        JE activity_4
        CMP choice_field, '5'
        JE activity_5
        CMP choice_field, '6'
        JE activity_6

        LEA DX, invalid_choice
        CALL print
        LEA DX, newline
        CALL print
        JMP get_choice

        activity_1:
            CALL clear_screen
            ; Surname 1
            ; Set cursor position
            MOV DH, 0 ; Row number
            MOV DL, 0 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_1
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
                
                
            ; Surname 2
            ; Set cursor position
            MOV DH, 2 ; Row number
            MOV DL, 7 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_2
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
            
            
            ; Surname 3
            ; Set cursor position
            MOV DH, 4 ; Row number
            MOV DL, 12 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_3
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
            
            
            ; Surname 4
            ; Set cursor position
            MOV DH, 6 ; Row number
            MOV DL, 20 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_4
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
            
            
            ; Surname 5
            ; Set cursor position
            MOV DH, 8 ; Row number
            MOV DL, 25 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_5
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
            
            
            ; Surname 6
            ; Set cursor position
            MOV DH, 10 ; Row number
            MOV DL, 34 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_6
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
            
            
            ; Surname 7
            ; Set cursor position
            MOV DH, 12 ; Row number
            MOV DL, 43 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_7
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H 
            
            ; Surname 8
            ; Set cursor position
            MOV DH, 14 ; Row number
            MOV DL, 50 ; Column number
            MOV AH, 02H ; Function to set cursor position
            INT 10H     ; BIOS interrupt 
            
            ; Load address of the string
            LEA DX, Surname_8
            
            ; Output the string loaded in DX
            MOV AH, 09H
            INT 21H
            JMP exit
        
        activity_2:
            CALL clear_screen
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

            JMP exit
        
        activity_3:
            CALL clear_screen
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
            LEA DX, newline
            INT 21H

            MOV AH, 09H
            LEA DX, largest_number_label
            INT 21H

            MOV AH, 09H
            LEA DX, largest_number_str
            INT 21H

            JMP exit

        activity_4:
            CALL clear_screen

            MOV DX, offset verb_prompt
            CALL print
            MOV DX, offset max_input_verb_size
            CALL get_input

            MOV DX, offset noun_prompt
            CALL print
            MOV DX, offset max_input_noun_size
            CALL get_input

            MOV DX, offset occupation_prompt
            CALL print
            MOV DX, offset max_input_occupation_size
            CALL get_input

            MOV DX, offset adjective_prompt
            CALL print
            MOV DX, offset max_input_adjective_size
            CALL get_input

            ; Print output
            LEA DX, output1
            CALL print

            LEA DX, input_occupation_buffer
            CALL print

            LEA DX, output2
            CALL print

            LEA DX, input_adjective_buffer
            CALL print

            LEA DX, output3
            CALL print

            LEA DX, input_verb_buffer
            CALL print

            LEA DX, output4
            CALL print

            LEA DX, input_noun_buffer
            CALL print

            LEA DX, output5
            CALL print

            JMP exit

        activity_5:
            CALL clear_screen
            LEA DX, prompt_message
            CALL print

            LEA DX, max_input_size
            CALL get_input

            ; input size to str
            LEA BX, input_size_str
            LEA DX, input_size
            CALL num_to_str

            ; Print output
            LEA DX, output_message
            CALL print

            LEA DX, input_buffer
            CALL print

            LEA DX, output_message1
            CALL print

            LEA DX, input_size_str
            CALL print

            LEA DX, output_message2
            CALL print

            JMP exit
        activity_6:
            CALL clear_screen
            jmp exit
        exit:

        MOV AH, 4CH
        INT 21H

; Inputs: DX
print:
    MOV AH, 09H
    INT 21H
    RET

clear_screen:
    mov ax, 3
    int 10h
    RET

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

get_input:
    MOV AH, 0AH
    INT 21H

    ; ADD $ to end
    LEA SI, DX ; max input size address
    INC SI 
    XOR BX, BX
    MOV BL, [SI] ; input size
    INC SI
    ADD SI, BX ; buffer location
    MOV [SI], "$"
    RET

end start