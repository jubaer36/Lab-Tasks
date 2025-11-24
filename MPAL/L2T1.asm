
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.CODE
MAIN PROC
    MOV AH , 1
    INT 21H
    
    CMP AL , 'a' 
    JL TOLOWER
    
TOUPPER: 
    SUB AL , 32
    JMP PRINT
TOLOWER: 
    ADD AL , 32 
PRINT:
    MOV AH , 2
    MOV DL , AL
    INT 21H    

MAIN ENDP
END MAIN

ret