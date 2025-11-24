
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA

AVERAGE DB ? 
SUM DB ?
LARGEST DB ?
SMALLEST DB ? 
CURRENT DB ?

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
            SUB [SI] , '0'
            INC SI
            LOOP INPUT   
            
        CALL FINDAVERAGE
        CALL FINDLARGEST 
            
        OUTPUT:                         
            MOV DL , 0DH
            MOV AH , 2
            INT 21H   
            MOV DL , 0AH
            MOV AH , 2
            INT 21H  
            
            MOV [SI], '$'
            MOV AH, 09 
            MOV DX , OFFSET INPUTARR
            INT 21H
             
             
            MOV AH , 2
            MOV DL , 0DH
            MOV AH , 2
            INT 21H   
            MOV DL , 0AH
            MOV AH , 2
            INT 21H     
            
            MOV DL , AVERAGE 
            ADD DL , '0'
            MOV AH , 2
            INT 21H  
            
            MOV AH , 2
            MOV DL , 0DH
            MOV AH , 2
            INT 21H   
            MOV DL , 0AH
            MOV AH , 2
            INT 21H     
            
            MOV DL , LARGEST 
            ADD DL , '0'
            MOV AH , 2
            INT 21H
            
            
            
            
            
            
    MAIN ENDP
    
    FINDAVERAGE PROC
        LEA SI ,INPUTARR
        MOV CX , 5
        XOR DL , DL
        
        ADDING:   
            ADD DL , [SI]
            INC SI
            LOOP ADDING 
            
            
        MOV AL , DL
        MOV AH , 0
        MOV DL , 5
        DIV DL
        MOV AVERAGE , AL 
        RET
        
    FINDAVERAGE ENDP
                     
                     
                     
    FINDLARGEST PROC 
        LEA SI ,INPUTARR
        MOV CX , 5
        MOV AL , [SI]
        MOV LARGEST , AL
        DEC CX 
        INC SI   
        FIND_LOOP:
            MOV AL , [SI]
            CMP AL ,  LARGEST
            JLE SKIP
            MOV LARGEST , AL 
        SKIP:
            INC SI
            LOOP FIND_LOOP 
      RET
      FINDLARGEST ENDP
         
    
    
    END MAIN   
    






