.model small
.stack

.data
message_input db "Enter Input: $"
message_output db 10, 13, "Result: $"
input db ?
factorial dd ?
factorialStr db 16 dup(0) ; Buffer

max_input_size db 5
input_size db ?
input_buffer db max_input_size dup(?)


.code
start:
    MOV AX, @data
    MOV DS, AX
    
    ; Show message input
    MOV AH, 09H 
    MOV DX, offset message_input
    INT 21H
    
    ; Get input
    MOV AH, 0AH
    MOV DX, max_input_size
    INT 21H

    XOR CX, CX
    MOV CL, input_size
    LEA SI, input_buffer
    ADD SI, CX
    MOV [SI], 0


    SUB AL, "0" ; Convert ASCII input to decimal
    MOV input, AL

factorial:
    MOV AX, 00H ; Reset AX
    MOV AL, input
    MOV BL, AL ; multiplier
    
factorial_loop:
    DEC BL
    MUL BL ; AL * BL
    
    CMP BL, 1
    JG factorial_loop ; loop until multiplier > 1
    MOV factorial, AX
    
to_string:
    MOV AX, factorial
    MOV CX, 0 ; counter
    MOV BX, 10 ; divisor
to_string_divide:
    MOV DX, 00H ; Clear DX before division, DX stores the remainder
    DIV BX ; Divide AX to BX
    PUSH DX ; Push remainder to stack
    INC CX ; Increment counter
    CMP AX, 0 
    JG to_string_divide ; Divide until Result is 0
    
    LEA SI, factorialStr ; factorialStr buffer address

to_string_build:
    POP AX; get the first digit from stack
    ADD AL, "0" ; Convert to ASCII
    
    MOV [SI], AL ; Store ASCII of number to SI (factorialStr)
    INC SI ; Move to the next value of SI
    LOOP to_string_build ; Loop until CX becomes 0, Counter from the number of digits

    INC SI
    MOV [SI], "$" ; Add stopper to the end of SI (factorialStr)

    ; Outputs the factorial
    MOV AH, 09H
    MOV DX, offset message_output
    INT 21H

    MOV AH, 09H
    MOV DX, offset factorialStr
    INT 21H
       
    ; END
    MOV AH, 4CH
    INT 21H
end start
