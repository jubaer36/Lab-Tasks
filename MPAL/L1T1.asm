
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h 

.CODE  
MAIN PROC

    MOV AX , 30
    ADD AX , 15
    MOV BX , 575
    SUB BX , 225
    ADD AX , BX
    ADD AX , 210 
    
MAIN ENDP
END MAIN



ret




