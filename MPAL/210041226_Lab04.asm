org 100h
.DATA ; Data segment starts
    A dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
    n dw ?
    message db 'Enter the value of N:$' ;1-D array for string
.CODE ; Code segment starts
MAIN PROC     
    mov ax, @DATA
    mov ds, ax
    xor ax,ax
    mov si, OFFSET A
    mov dx, OFFSET message
    mov ah, 09h ;display string function
    int 21h ;display message 
    xor ax, ax
    mov ah, 01h
    int 21h
    xor ah , ah
    sub ax,'0'  
    mov n , ax      
    xor ax, ax 
    xor dx,dx 
    mov cx , n
    mov ax , 20
    div cx
    mov cx, ax   
   
    
    
    
    
    
    
Loop_1:  
    xor ax,ax            
    add si ,bx
    add si ,bx
    
    cmp cx , 0
    JZ end 
    JNZ squareAndadd
    


      

squareAndadd:
    
    mov ax, [si] 
    mul ax  
    add dx , ax 
    dec cx
    JZ Loop_1
    
end:
    
    
    

MAIN ENDP
END MAIN
RET