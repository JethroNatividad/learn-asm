; Create a menu that you can select, and prints the message.
.model small
.stack

.data
newline db 10, 13, '$'
item1 db '1] 'Activity 1', '$'
item2 db '2] 'Activity 2', '$'
item3 db '3] 'Activity 3', '$'
item4 db '4] 'Activity 4', '$'
item5 db '5] 'Activity 5', '$'
item6 db '6] 'Activity 6', '$'

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
        CMP choice
        CMP choice_field, '1'
        JE activity_1
        CMP choice_field, '2'
        JE activity_1
        CMP choice_field, '3'
        JE activity_1

        activity_1:
            LEA DX, item1
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