
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA    
test_string DB 'We are IUT Students',0Dh,0Ah,'$'

.CODE
MAIN PROC                                           
   MOV CX , 100
   XOR DX , DX 
   XOR BX , BX
   LEA SI , test_string
   
LOOPINGOVER:        
    CMP [SI] , '$'
    JZ PRINT
    INC BX       
    INC SI
    LOOP LOOPINGOVER 
     
PRINT:   
    MOV CX , 0
    MOV AH , 2
    INT 21H   
    
    MOV AH , 9
    LEA DX , test_string
    INT 21H    
    MOV DX , BX
    
    
    

   
MAIN ENDP
END MAIN

ret




