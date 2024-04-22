; Create a menu that you can select, and prints the message.
.model small
.stack

.data
full_name db 'Name: Natividad, Jethro Ezekiel R.', '$'
section db 'Section: BSCS-2B', '$'
group db 'Group: Ada', '$'
newline db 10, 13, '$'
item1 db '1] Name', '$'
item2 db '2] Section', '$'
item3 db '3] Group', '$'

choice_prompt db 'Enter choice: $'

choice_max_length db 2
choice_actual_length db ?
choice_field db choice_max_length dup(' ') ; buffer

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

    ; Get choice

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
    JE print_name
    CMP choice_field, '2'
    JE print_section
    CMP choice_field, '3'
    JE print_group

    print_name:
        LEA DX, full_name
        CALL print
        JMP exit
    
    print_section:
        LEA DX, section
        CALL print
        JMP exit

    print_group:
        LEA DX, group
        CALL print
        JMP exit

    exit:

    MOV AH, 4CH
    INT 21H

; Inputs: DX
print:
    MOV AH, 09H
    INT 21H
    RET

end start