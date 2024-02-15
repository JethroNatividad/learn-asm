; A program that prompts for a noun, a verb, an adverb, and an adjective and generates a statement on it.

.model small
.stack

.data
noun_prompt db "Enter a noun: $"
verb_prompt db 10, 13, "Enter a verb: $"
adverb_prompt db 10, 13, "Enter an adverb (describes a verb): $"
adjective_prompt db 10, 13, "Enter an adjective (describes a noun): $"

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

start_output db 10, 13, "Do you $"
post_verb db " your $"
end_output db " ? That's hilarious!", 10, 13, "$"
space db " $"


.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV DX, offset noun_prompt
    CALL print
    MOV DX, offset max_input_noun_size
    CALL get_input

    MOV DX, offset adjective_prompt
    CALL print
    MOV DX, offset max_input_adjective_size
    CALL get_input

    MOV DX, offset verb_prompt
    CALL print
    MOV DX, offset max_input_verb_size
    CALL get_input

    MOV DX, offset adverb_prompt
    CALL print
    MOV DX, offset max_input_adverb_size
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
    MOV DX, offset start_output
    CALL print

    MOV DX, offset input_verb_buffer
    CALL print

    MOV DX, offset post_verb
    CALL print

    MOV DX, offset input_adjective_buffer
    CALL print

    MOV DX, offset space
    CALL print

    MOV DX, offset input_noun_buffer
    CALL print

    MOV DX, offset space
    CALL print

    MOV DX, offset input_adverb_buffer
    CALL print

    MOV DX, offset end_output
    CALL print
    RET
end