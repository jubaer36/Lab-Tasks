
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA

AVERAGE DB ?
LARGEST DB ?
SMALLEST DB ? 

INPUTARR DB ?

.CODE
    MAIN PROC
        MOV AX , @DATA
        MOV DS , AX
        
        MOV SI , OFFSET INPUTARR
        
        MOV CX , 5
        
        INPUT:
            MOV AH , 01
            INT 21H
            MOV [SI] , AL
            INC SI
            LOOP INPUT
            
        OUTPUT:   
            MOV [SI], '$'
            MOV AH, 09 
            MOV DX , OFFSET INPUTARR
            INT 21H   
            
            
            
            
    MAIN ENDP
    END MAIN   
    






