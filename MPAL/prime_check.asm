; Program to check if numbers in an array are prime
ORG 100H

.DATA
    NUMBERS DW 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    ARRAY_SIZE DW 10
    MSG_INPUT DB 'Enter a number: $'
    MSG_PRIME DB 'Number of primes found: $'
    MSG_IS_PRIME DB 'Number is prime!$'
    MSG_NOT_PRIME DB 'Number is not prime.$'
    NEW_LINE DB 0DH, 0AH, '$'
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; First test: Check single number input
    LEA DX, MSG_INPUT
    MOV AH, 9
    INT 21H
    
    ; Read number
    CALL READ_NUMBER
    
    ; Check if prime
    CALL IS_PRIME
    
    ; Display result
    LEA DX, NEW_LINE
    MOV AH, 9
    INT 21H
    
    CMP AL, 1
    JNE DISPLAY_NOT_PRIME
    
    LEA DX, MSG_IS_PRIME
    JMP DISPLAY_RESULT
    
DISPLAY_NOT_PRIME:
    LEA DX, MSG_NOT_PRIME
    
DISPLAY_RESULT:
    MOV AH, 9
    INT 21H
    
    ; Second test: Check array for primes
    LEA DX, NEW_LINE
    MOV AH, 9
    INT 21H
    
    LEA SI, NUMBERS
    MOV CX, ARRAY_SIZE
    CALL CHECK_ARRAY_FOR_PRIMES
    
    ; Display result
    PUSH BX         ; Save prime count
    
    LEA DX, MSG_PRIME
    MOV AH, 9
    INT 21H
    
    POP BX          ; Restore prime count
    MOV AX, BX
    CALL DISPLAY_NUMBER
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Read a number from keyboard
; Returns: AX = number
READ_NUMBER PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AX, 0       ; Initialize result
    MOV CX, 10      ; Base 10
    
INPUT_LOOP:
    MOV AH, 1
    INT 21H         ; Read character
    
    CMP AL, 0DH     ; Check for Enter key
    JE END_INPUT
    
    SUB AL, '0'     ; Convert from ASCII
    
    MOV BL, AL
    MOV AL, AH      ; Clear AH
    
    ; Multiply current result by 10
    MUL CX
    
    ; Add new digit
    ADD AL, BL
    
    JMP INPUT_LOOP
    
END_INPUT:
    POP DX
    POP CX
    POP BX
    RET
READ_NUMBER ENDP

; Check if number in AX is prime
; Returns: AL=1 if prime, AL=0 if not prime
IS_PRIME PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    ; Special cases
    CMP AX, 1       ; 1 is not prime
    JLE NOT_PRIME
    CMP AX, 2       ; 2 is prime
    JE PRIME
    
    ; Check if even (except 2)
    MOV DX, 0
    MOV BX, 2
    DIV BX
    CMP DX, 0       ; If remainder is 0, it's even and not prime
    JE NOT_PRIME
    
    ; Check odd divisors from 3 to sqrt(AX)
    MOV BX, 3       ; Start checking from 3
    MOV CX, AX      ; Save original number
    
CHECK_LOOP:
    MOV AX, CX      ; Restore original number for division
    MOV DX, 0
    DIV BX          ; Divide by current divisor
    
    CMP DX, 0       ; If remainder is 0, not prime
    JE NOT_PRIME
    
    ADD BX, 2       ; Next odd number
    
    ; Check if we've reached sqrt(number)
    MOV AX, BX
    MUL AX          ; Square of BX in DX:AX
    CMP AX, CX      ; Compare with original number
    JA PRIME        ; If BX*BX > number, it's prime
    JB CHECK_LOOP   ; If BX*BX < number, continue checking
    
PRIME:
    MOV AL, 1       ; Return 1 (true)
    JMP END_PRIME
    
NOT_PRIME:
    MOV AL, 0       ; Return 0 (false)
    
END_PRIME:
    POP DX
    POP CX
    POP BX
    RET
IS_PRIME ENDP

; Check array for prime numbers
; Input: SI = array address, CX = array length
; Output: BX = count of prime numbers found
CHECK_ARRAY_FOR_PRIMES PROC
    PUSH AX
    PUSH SI
    PUSH CX
    PUSH DX
    
    MOV BX, 0       ; Initialize prime counter
    
ARRAY_LOOP:
    MOV AX, [SI]    ; Load current number
    PUSH CX
    CALL IS_PRIME   ; Check if prime
    POP CX
    
    CMP AL, 1       ; If prime
    JNE NOT_PRIME_IN_ARRAY
    INC BX          ; Increment prime counter
    
NOT_PRIME_IN_ARRAY:
    ADD SI, 2       ; Move to next word (if using DW)
    LOOP ARRAY_LOOP
    
    POP DX
    POP CX
    POP SI
    POP AX
    RET
CHECK_ARRAY_FOR_PRIMES ENDP

; Helper procedure to display a number in AX
DISPLAY_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV BX, 10      ; Base 10
    MOV CX, 0       ; Digit counter
    
    ; Convert to digits
CONVERT:
    MOV DX, 0
    DIV BX          ; AX = AX / 10, DX = remainder
    PUSH DX         ; Save digit
    INC CX          ; Count digits
    
    TEST AX, AX     ; Check if AX is 0
    JNZ CONVERT     ; If not, continue converting
    
    ; Display digits
DISPLAY:
    POP DX
    ADD DL, '0'     ; Convert to ASCII
    MOV AH, 2
    INT 21H
    LOOP DISPLAY
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_NUMBER ENDP

END MAIN
