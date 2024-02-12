.model small
.stack

.data
message_input db "Enter Input: $"
message_output db 10, 13, "Result: $"
input db ?
factorial dd ?
factorialStr db 16 dup(0) ; Buffer to store the string representation of the number

.code
start:
    MOV AX, @data
    MOV DS, AX
    
    MOV AH, 00H ; Show Screen
    INT 10H
    
    MOV AH, 09H ; Show message
    MOV DX, offset message_input
    INT 21H
    
    MOV AH, 01H ; Get input
    INT 21H
    SUB AL, "0"
    MOV input, AL
    
    ; factorial the input
    
    ; product
    ; multiplier
    MOV AX, 00H
    MOV AL, input
    MOV BL, AL
    
factorial_loop:
    DEC BL
    MUL BL
    
    CMP BL, 1
    JG factorial_loop
    MOV factorial, AX
    
to_string:
    MOV AX, factorial ; number to convert  
    MOV CX, 0 ; counter
    MOV BX, 10; divisor
to_string_divide:
    
    XOR DX, DX ; Clear DX before division, DX stores the remainder
    DIV BX; Divide AX to BX
    PUSH DX ;Push remainder to stack
    INC CX ; Increment counter
    CMP AX, 0; Check If result is 0
    JG to_string_divide
    
    lea si, factorialStr
to_string_build:
    POP AX; get the first digit from stack
    ADD AL, "0"
    
    MOV [SI], AL
    INC SI
    LOOP to_string_build
    INC SI
    MOV [SI], "$"
                
    ; Print the factorial

    MOV AH, 09H
    MOV DX, offset message_output
    INT 21H

    MOV AH, 09H
    MOV DX, offset factorialStr
    INT 21H
       
    
    MOV AH, 4CH
    INT 21H
end start
