ORG 0100H


.CODE

 MAIN PROC
    
    mov ah,1
    int 21h
    mov bl,al
    mov cl , bl  
    
    cmp bl , 'a'  
   
    mov dl , 0DH
    mov ah , 2
    int 21h 
    mov dl , 0AH
    mov ah ,2
    int 21h
    
    JGE INPUT_LOWERCASE
    
     
    
 

    

INPUT_UPPERCASE:
    ADD bl,33
    
    mov dl ,bl
    mov ah ,2
    int 21h
    sub bl,1
    
    mov dl ,bl
    mov ah ,2
    int 21h
    sub bl,1
    
    mov dl ,bl
    mov ah ,2
    int 21h
    sub bl,1
    
    mov dl ,bl
    mov ah ,2
    int 21h
    sub bl,1
    
    mov dl ,bl
    mov ah ,2
    int 21h
    sub bl,1
    
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    
    
    JMP ENDD 
    
INPUT_LOWERCASE:
    SUB bl,31
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    add bl,1
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    add bl,1
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    add bl,1
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    add bl,1
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    add bl,1
    mov dl ,bl
    mov ah ,2
    int 21h 
    
    JMP ENDD 
    

    
    
    
ENDD:
    
    
MAIN ENDP
 
END MAIN
RET