; A program that prompts for a noun, a verb, an adverb, and an adjective and generates a statement on it.

.model small
.stack

.data

.code
start:
    MOV AX, @data
    MOV DS, AX

    CALL show_prompt_noun
    CALL get_noun

    CALL show_prompt_verb
    CALL get_verb

    CALL show_prompt_adverb
    CALL get_adverb

    CALL show_prompt_adjective
    CALL get_adjective

    CALL show_output


    MOV AH, 4CH
    INT 21H
end