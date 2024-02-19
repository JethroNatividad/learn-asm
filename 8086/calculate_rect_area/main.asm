; Program that calculates the sqft of a rectangular room
; Inputs: Length and Width in ft
; Process: L*W = sqft, convert to square meters
; Outputs: square feet, and square meters

.model small
.stack

.data
length dw 15
width dw 20
area_sqft dw 0


.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AX, length
    MOV BX, width
    MUL BX
    MOV area_sqft, AX

    MOV AH, 4CH
    INT 21H
end