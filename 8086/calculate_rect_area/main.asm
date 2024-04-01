; Program that calculates the sqft of a rectangular room
; Inputs: Length and Width in ft
; Process: L*W = sqft, convert to square meters
; Outputs: square feet, and square meters

.model small
.stack

.data
length dw 15
width dw 20
area_sqft dw ?
area_sqft_str db 6 dup(?)

area_sqm dw ?
area_sqm_str db 6 dup(?)

sqm_factor dw 93
sqm_scale dw 1000

sqm_remainder dw ?
sqm_remainder_str db 6 dup(?)

length_label db "Length(ft): $"
width_label db "Width(ft): $"
sqft_label db "In Square Feet: $"
sqm_label db "In Square Meters: $"

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AX, length
    MOV BX, width
    MUL BX
    MOV area_sqft, AX

    MOV AX, area_sqft
    MOV BX, sqm_factor
    MUL BX
    MOV area_sqm, AX
    MOV sqm_remainder, DX

    XOR AX, AX
    XOR DX, DX
    MOV AX, area_sqm
    MOV BX, sqm_scale
    DIV BX
    MOV area_sqm, AX
    MOV sqm_remainder, DX

    MOV AX, area_sqft
    MOV BX, OFFSET area_sqft_str
    CALL num_to_str

    MOV AX, area_sqm
    MOV BX, OFFSET area_sqm_str
    CALL num_to_str

    MOV AX, sqm_remainder
    MOV BX, OFFSET sqm_remainder_str
    CALL num_to_str

    MOV DX, OFFSET sqft_label
    CALL print

    MOV DX, OFFSET area_sqft_str
    CALL print

    MOV DX, OFFSET sqm_label
    CALL print

    MOV DX, OFFSET area_sqm_str
    CALL print

    MOV AH, 4CH
    INT 21H

    ; inputs: print str in DX
print:
    MOV AH, 09H
    INT 21H
    RET

; Inputs: ax = number, bx = address to output
num_to_str:
    LEA SI, BX
    XOR CX, CX
    MOV BX, 10

    extract_number_loop:
        XOR DX, DX
        DIV BX
        PUSH DX
        INC CX
        CMP AX, 0
        JG extract_number_loop
    
    build_str_loop:
        POP AX
        ADD AX, "0"
        MOV [SI], AX
        INC SI
        LOOP build_str_loop

    MOV [SI], "$"
    RET

end