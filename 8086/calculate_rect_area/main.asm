; Program that calculates the sqft of a rectangular room
; Inputs: Length and Width in ft
; Process: L*W = sqft, convert to square meters
; Outputs: square feet, and square meters

.model small
.stack

.data

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AH, 4CH
    INT 21H
end