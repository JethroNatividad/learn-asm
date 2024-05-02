; A program that prompts for a noun, a verb, an adverb, and an adjective and generates a statement on it.

.model small
.stack

.data
verb_prompt db "Enter a verb: $"
noun_prompt db 10, 13, "Enter a noun: $"
occupation_prompt db 10, 13, "Enter an occupation: $"
adjective_prompt db 10, 13, "Enter an adjective: $"

max_input_noun_size db 100
input_noun_size db ?
input_noun_buffer db max_input_noun_size dup(' ')

max_input_verb_size db 100
input_verb_size db ?
input_verb_buffer db max_input_verb_size dup(' ')

max_input_occupation_size db 100
input_occupation_size db ?
input_occupation_buffer db max_input_occupation_size dup(' ')

max_input_adjective_size db 100
input_adjective_size db ?
input_adjective_buffer db max_input_adjective_size dup(' ')

output1 db 10, 13, "One day our teacher decided to quit his job and apply to be the school's $"
output2 db ". The employer of the university however thought that he was too $"
output3 db ".  So our teacher decided to $"
output4 db ", not knowing that his $"
output5 db " broke down, costing him the job $"


.code
start:
    MOV AX, @data
    MOV DS, AX

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

    CALL show_output

    MOV AH, 4CH
    INT 21H

; input: value in DX register
; Output: print the contents
print:
    MOV AH, 09H
    INT 21H
    RET

; input: max input size in DX
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

show_output:
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
    RET
end