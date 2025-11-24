ORG 0100H


.CODE

 MAIN PROC
    
    mov ah,1
    int 21h
    mov bl,al
    
    mov ah,0
    mov al,bl
    mov cl,2
    div cl
    cmp ah,0 
     
    mov dl , 0DH
    mov ah , 2
    int 21h 
    mov dl , 0AH
    
    JNZ LABEL_ODD
    
LABEL_EVEN: 
    
    mov ah ,2
    mov dl ,'E'
    int 21h 
    JMP ENDD
     
    
LABEL_ODD: 
    mov ah ,2
    mov dl ,'O'
    int 21h 
    JMP ENDD
    
ENDD:
    
    
MAIN ENDP
 
END MAIN
RET