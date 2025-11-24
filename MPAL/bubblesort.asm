
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here  
      
    
.data
    array db 6 dup(?) , '$'
    len db 6
    
.code
    main proc  
        mov ax , @data
        mov ds , ax
        mov si , offset array 
        mov cl , len
        
    INPUT:
        MOV AH , 01
        INT 21H 
        sub al , '0'
        MOV [SI] , AL
        INC SI
        LOOP INPUT 
          
          
        mov si, offset array
        mov cl , len 
        call bubble_sort
        
        
        mov si, offset array
        mov cl, len
    convert_loop:
        add [si], '0' 
        inc si
        loop convert_loop
         
        
        
    OUTPUT:  
        
        
        MOV AH, 09 
        MOV DX , OFFSET array
        INT 21H
        
        
    ret  
        
    
    
    bubble_sort proc
        push ax
        push bx
        push cx
        push dx  
        push si
         
        dec cx
        jbe sort_done  
        
    outer_loop:
        mov bx , 0
        mov dx , 0
        
        
        inner_loop:
            mov al , [si + bx]
            cmp al , [si + bx + 1]
            jle no_swap
            
            
            mov ah , [si + bx + 1]
            mov [si + bx] , ah
            mov [si + bx + 1 ] , al
            
            mov dx , 1
            
            
            no_swap:
                inc bx
                cmp bx ,cx
                jl inner_loop
                
                test dx , dx
                jz sort_done
                
                dec cx
                
                jnz outer_loop  
    
    
    sort_done:
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
        
    bubble_sort endp
                
   
                 
    end main           
             
        
            
        
        
    main endp        
    
    
    
    
    
    
    







