; A program that prompts for a noun, a verb, an adverb, and an adjective and generates a statement on it.

.model small
.stack

.data
noun_prompt db "Enter a noun: $"
verb_prompt db "Enter a verb: $"
adverb_prompt db "Enter an adverb: $"
adjective_prompt db "Enter an adjective: $"

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_noun_prompt
    CALL get_noun

    CALL show_verb_prompt
    CALL get_verb

    CALL show_adverb_prompt
    CALL get_adverb

    CALL show_adjective_prompt
    CALL get_adjective

    CALL show_output

    MOV AH, 4CH
    INT 21H

show_noun_prompt:
    MOV AH, 09H
    MOV DX, offset noun_prompt
    INT 21H
    RET

end