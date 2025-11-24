ORG 0100H

.DATA
   input_string DB 'IUT is an International University', 0Dh, 0Ah, '$'  
   
.CODE

MAIN PROC
    MOV AH,9
    LEA DX , input_string
    INT 21H
    LEA SI , input_string 
    MOV AL , 0 
    MOV CX, 100
    
    iterate: 
           mov ax,[si]
           CMP [SI] , '$'
           
           JZ ENDD       
           CMP [SI] , ' '
           JZ space 
           CMP [SI] , 0Dh
           JZ space
           CMP [SI] , 0Ah
           JZ space
           
           CMP [SI] , 'a'
           JGE lower
           ADD [SI] , 32
           INC SI
           LOOP iterate 
           
    lower: 
           
           INC BX 
           SUB [SI] , 32
           INC SI
           JMP iterate  
           
    space: 
           INC SI
           jmp iterate
           
           
    ENDD:  
           MOV CX , 0
           MOV AH,9
           LEA DX , input_string
           INT 21H
         
        
        
        
    
    
MAIN ENDP
END MAIN
RET