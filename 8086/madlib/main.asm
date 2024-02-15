; A program that prompts for a noun, a verb, an adverb, and an adjective and generates a statement on it.

.model small
.stack

.data
noun_prompt db "Enter a noun: $"
verb_prompt db "Enter a verb: $"
adverb_prompt db "Enter an adverb: $"
adjective_prompt db "Enter an adjective: $"

max_input_noun_size db 100
input_noun_size db ?
input_noun_buffer db max_input_noun_size dup(?)

max_input_verb_size db 100
input_verb_size db ?
input_verb_buffer db max_input_verb_size dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_noun_prompt
    CALL get_noun

    CALL show_verb_prompt
    CALL get_verb

    ; CALL show_adverb_prompt
    ; CALL get_adverb

    ; CALL show_adjective_prompt
    ; CALL get_adjective

    ; CALL show_output

    MOV AH, 4CH
    INT 21H

show_noun_prompt:
    MOV AH, 09H
    MOV DX, offset noun_prompt
    INT 21H
    RET

get_noun:
    MOV AH, 0AH
    MOV DX, offset max_input_noun_size
    INT 21H

    ; ADD $ to end
    XOR BX, BX
    LEA SI, input_noun_buffer
    MOV BL, input_noun_size
    ADD SI, BX
    MOV [SI], "$""
    RET

show_verb_prompt:
    MOV AH, 09H
    MOV DX, verb_prompt
    INT 21H
    RET

get_verb:
    MOV AH, 0AH
    MOV DX, max_input_verb_size
    INT 21H

    XOR AX, AX
    LEA SI, input_verb_buffer
    MOV AL, input_verb_size
    ADD SI, AX
    MOV [SI], "$"
    RET

end