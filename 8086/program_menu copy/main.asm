.data
; Constants
newline db 10, 13, '$'
choice_max_length db 2
name_max_length db 30
age_max_length db 3
first_number_max_length db 30
second_number_max_length db 30
third_number_max_length db 30
max_input_noun_size db 30
max_input_occupation_size db 30
max_input_adjective_size db 30
max_input_verb_size db 30

; Menu Items
menu_item1 db '1] Activity 1', '$'
menu_item2 db '2] Activity 2', '$'
menu_item3 db '3] Activity 3', '$'
menu_item4 db '4] Activity 4', '$'
menu_item5 db '5] Activity 5', '$'
menu_item6 db '6] Activity 6', '$'
invalid_choice db 'Invalid choice, please try again.', '$'
choice_prompt db 'Enter choice: $'

; Activity 1 Variables
surname_list db 'Alvarez$', 'Bobon$', 'Falcatan$', 'Gomez$', 'Marcelino$', 'Natividad$', 'Sahibul$', 'Tulawe$'

; Activity 2 Variables
name_prompt db 'What is your name? ', '$'
pre_name db 'Name: ', '$'
age_prompt db 10, 13, 'How old are you? ', '$'
pre_age db 10, 13, 'Age: ', '$'
name_field db name_max_length dup('$')
age_field db age_max_length dup('$') 

; Activity 3 Variables
first_number_prompt db 'Enter first number:  ', '$'
second_number_prompt db 'Enter second number:  ', '$'
third_number_prompt db 'Enter third number:  ', '$'
first_number_field db first_number_max_length dup('$')
second_number_field db second_number_max_length dup('$')
third_number_field db third_number_max_length dup('$')
largest_number_label db 'The largest number is: ', '$'
largest_number_str db 30 dup('$')

; Activity 4 Variables
verb_prompt db "Enter a verb: $"
noun_prompt db 10, 13, "Enter a noun: $"
occupation_prompt db 10, 13, "Enter an occupation: $"
adjective_prompt db 10, 13, "Enter an adjective: $"
input_noun_buffer db max_input_noun_size dup('$')
input_occupation_buffer db max_input_occupation_size dup('$')
input_adjective_buffer db max_input_adjective_size dup('$')
input_verb_buffer db max_input_verb_size dup('$')
output_buffer db 256 dup('$') ; Increased size for combined output

.code
start:
    MOV AX, @data
    MOV DS, AX

    ; Print menu
    CALL print_menu
    
    ; Get choice and run activity
    CALL get_choice
    
    ; Exit program
    MOV AH, 4CH
    INT 21H

; Procedures
print_menu:
    LEA DX, menu_item1
    CALL print_string
    LEA DX, newline
    CALL print_string
    LEA DX, menu_item2
    CALL print_string
    LEA DX, newline
    CALL print_string
    LEA DX, menu_item3
    CALL print_string
    LEA DX, newline
    CALL print_string
    LEA DX, menu_item4
    CALL print_string
    LEA DX, newline
    CALL print_string    
    RET

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

    ; Compare choice and jump to activity
    CMP choice_field, '1'
    JE activity_1
    CMP choice_field, '2'
    JE activity_2
    CMP choice_field, '3'
    JE activity_3
    CMP choice_field, '4'
    JE activity_4
    ; ... (add comparisons for other choices if needed) 

    ; Invalid choice handling
    LEA DX, invalid_choice
    CALL print_string
    LEA DX, newline
    CALL print_string
    JMP get_choice  ; Loop back to prompt for input again

activity_1:
    CALL activity_1_proc
    JMP exit_activity

activity_2:
    ; ... (Get name and age using get_input)
    LEA DX, name_prompt
    CALL print_string
    CALL get_input
    LEA DX, pre_name
    CALL print_string
    CALL print_string
    CALL print_name_and_age
    JMP exit_activity

activity_3: 
    ; ... (Get numbers using get_input and find largest)
    CALL print_largest_number
    JMP exit_activity

activity_4:
    ; ... (Get input words using get_input) 
    CALL construct_and_print_output
    JMP exit_activity

exit_activity: 
    ; ... (Option to return to menu or exit) 
    RET 

activity_1_proc:
    CALL clear_screen
    MOV CX, 8 ; Number of surnames
    MOV DX, 0 ; Initial row offset
    
print_surname_loop:
    MOV AH, 02H ; Set cursor position
    MOV BH, 0 ; Page number
    MOV DL, 0 ; Column
    INT 10H

    LEA SI, surname_list[DX] ; Calculate surname offset 
    CALL print_string

    ADD DX, 7 ; Increment row offset for next surname (assuming $ termination)
    LOOP print_surname_loop
    RET

print_name_and_age:
    ; ... (Print name and age with formatting)
    RET

print_largest_number: 
    ; ... (Print largest number message)
    RET

construct_and_print_output: 
    ; ... (Combine output strings into output_buffer) 
    LEA DX, output_buffer
    CALL print_string
    RET 
; ... (Rest of the procedures: clear_screen, get_input, print_string, str_to_num, num_to_str) 

; Inputs: DX
print_string:
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