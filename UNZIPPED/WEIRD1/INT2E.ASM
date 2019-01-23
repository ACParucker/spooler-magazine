;
;  INT2E.ASM
;

.model small                    ; s¢ funciona no modelo small
.data                           
save_ss dw ?                    
save_sp dw ?

.code                           

public _int_2e                  
_int_2e proc                    
        push    bp              
        mov     bp,sp
        push    si              ; ‚ melhor salvaguardar estes
        push    di
        push    ds
        push    es
        mov     ax,dgroup       
        mov     ds,ax
        mov     save_sp,sp      
        mov     save_ss,ss      
        mov     si,[bp+4]       
        int     2eh             ; e aqui vamos n¢s
        mov     ax,dgroup       
        mov     ds,ax
        cli                     
        mov     sp,save_sp      
        mov     ss,save_ss      
        sti                     
        pop     es              ; ainda bem que os grav mos … pouco
        pop     ds
        pop     di
        pop     si
        pop     bp
        ret                     ; j  est 

_int_2e endp

end

