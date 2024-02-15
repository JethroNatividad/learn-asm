; A program that prompts for a noun, a verb, an adverb, and an adjective and generates a statement on it.

.model small
.stack

.data
noun_prompt db "Enter a noun: $"
verb_prompt db 10, 13, "Enter a verb: $"
adverb_prompt db 10, 13, "Enter an adverb: $"
adjective_prompt db 10, 13, "Enter an adjective: $"

max_input_noun_size db 100
input_noun_size db ?
input_noun_buffer db max_input_noun_size dup(?)

max_input_verb_size db 100
input_verb_size db ?
input_verb_buffer db max_input_verb_size dup(?)

max_input_adverb_size db 100
input_adverb_size db ?
input_adverb_buffer db max_input_adverb_size dup(?)

max_input_adjective_size db 100
input_adjective_size db ?
input_adjective_buffer db max_input_adjective_size dup(?)

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV DX, offset noun_prompt
    CALL print
    CALL get_noun

    MOV DX, offset verb_prompt
    CALL print
    CALL get_verb

    MOV DX, offset adverb_prompt
    CALL print
    CALL get_adverb

    MOV DX, offset adjective_prompt
    CALL print
    CALL get_adjective

    ; CALL show_output

    MOV AH, 4CH
    INT 21H

; input: value in DX register
; Output: print the contents
print:
    MOV AH, 09H
    INT 21H
    RET

get_noun:
    MOV AH, 0AH
    MOV DX, offset max_input_noun_size
    INT 21H

    ; ADD $ to end
    XOR AX, AX
    LEA SI, input_noun_buffer
    MOV AL, input_noun_size
    ADD SI, AX
    MOV [SI], "$"
    RET

get_verb:
    MOV AH, 0AH
    MOV DX, offset max_input_verb_size
    INT 21H

    XOR AX, AX
    LEA SI, input_verb_buffer
    MOV AL, input_verb_size
    ADD SI, AX
    MOV [SI], "$"
    RET

get_adverb:
    MOV AH, 0AH
    MOV DX, offset max_input_adverb_size
    INT 21H

    XOR AX, AX
    LEA SI, input_adverb_buffer
    MOV AL, input_adverb_size
    ADD SI, AX
    MOV [SI], "$"
    RET

get_adjective:
    MOV AH, 0AH
    MOV DX, offset max_input_adjective_size
    INT 21H

    XOR AX, AX
    LEA SI, input_adjective_buffer
    MOV AL, input_adjective_size
    ADD SI, AX
    MOV [SI], "$"
    RET

end