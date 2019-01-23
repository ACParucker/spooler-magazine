;
;
;     JOYSTICK.ASM
;
;     Exemplo de como utilizar o Joystick em ASSEMBLY
;
;     Este c¢digo ou partes do mesmo pode ser distribuido ou
;     integrado livremente em programas para qualquer tipo de uso,
;     desde que na sua distribui‡„o os coment rios sejam divulgados
;     intactos.
;
;     Para quaisquer coment rios ou d£vidas contactar o autor:
;
;      Pedro Sinogas
;      Rua A - Lote 6A
;      Madorna
;      2775 Parede
;
;     Novembro 93
;

   DOSSEG
   .MODEL SMALL
   .STACK 100h
   .DATA

Texto     DB 'Joystick 1',13,10,10,10,'Joystick 2$'
CoorX1    DB 'X1 $'
CoorY1    DB 'Y1 $'
CoorX2    DB 'X2 $'
CoorY2    DB 'Y2 $'                                           
BotaoA1   DW "a1"
	  db "$"
BotaoB1   DW "b1"
	  db "$"
BotaoA2   DW "a2"
	  db "$"
BotaoB2   DW "b2"
	  db "$"
X1        DW ?
Y1        DW ?
X2        DW ?
Y2        DW ?

   .CODE

   mov  ah,0                        ;Muda para modo de Texto,
   mov  al,2                        ;se j  estiver em modo de texto,
   int  10h                         ;faz um CLS

   mov  ah,1                        ;Torna o Cursor invisivel
   mov  ch,00100000b
   mov  cl,0
   int  10h

   mov  ax,@data
   mov  ds,ax                       
   mov  ah,9                        
   mov  dx,OFFSET Texto
   int  21h                         ; Escreve o texto fixo no ecran

CICLO:

   mov ah,84h				    ; Get Coor
   mov dx,0001h
   int 15h
   mov X1, ax
   mov Y1, bx
   mov X2, cx
   mov Y2, dx

   mov cx,x1
   mov si, offset [CoorX1]
   call HEX2ASCII

   mov cx,y1
   mov si, offset [CoorY1]
   call HEX2ASCII

   mov cx,x2
   mov si, offset [CoorX2]
   call HEX2ASCII

   mov cx,y2
   mov si, offset [CoorY2]
   call HEX2ASCII

					    ; Converte o valor das
					    ; Coordenadas em Decimal
					    ; para uma String

   mov ah,84h				    ; Get Bot”es
   mov dx,0000h
   int 15h

   mov bx," 0"                              ; Converte o valor dos Bot”es
   mov cx,"1-"				    ; para uma String
   not al
   test al,00010000b
   jnz A1on
   mov [BotaoA1],bx
   jmp B1

A1on:
   mov [BotaoA1],cx

B1:
   test al,00100000b
   jnz B1on
   mov [BotaoB1],bx
   jmp A2

B1on:
   mov [BotaoB1],cx

A2:
   test al,01000000b
   jnz A2on
   mov [BotaoA2],bx
   jmp B2

A2on:
   mov [BotaoA2],cx
B2:
   test al,10000000b
   jnz B2on
   mov [BotaoB2],bx
   jmp BOK

B2on:
   mov [BotaoB2],cx

BOK:

   mov ah,2                                 ; Escreve tudo no ecran
   mov bh,0
   mov dh,1
   mov dl,1
   int 10h
   mov  ah,9
   mov  dx,OFFSET CoorX1                    ; Escreve a Coordenada X
   int  21h                                 ; do Joystick 1 no ecran

   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,15
   int 10h
   mov  ah,9
   mov  dx,OFFSET CoorY1                    ; Escreve a Coordenada Y
   int  21h                                 ; do Joystick 1 no ecran

   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,29
   int 10h
   mov  ah,9
   mov  dx,OFFSET BotaoA1                   ; Escreve o Bot„o 1
   int  21h                                 ; do Joystick 1 no ecran

   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,43
   int 10h
   mov  ah,9
   mov  dx,OFFSET BotaoB1                   ; Escreve o bot„o 2
   int  21h                                 ; do Joystick 1 no ecran

   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,1
   int 10h
   mov  ah,9
   mov  dx,OFFSET CoorX2                    ; Escreve a Coordenada X
   int  21h                                 ; do Joystick 2 no ecran

   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,15
   int 10h
   mov  ah,9
   mov  dx,OFFSET CoorY2                    ; Escreve a Coordenada Y
   int  21h                                 ; do Joystick 2 no ecran

   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,29
   int 10h
   mov  ah,9
   mov  dx,OFFSET BotaoA2                   ; Escreve o Bot„o 1
   int  21h                                 ; do Joystick 2 no ecran

   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,43
   int 10h
   mov  ah,9
   mov  dx,OFFSET BotaoB2                   ; Escreve o bot„o 2
   int  21h                                 ; do Joystick 2 no ecran


   mov ah,1
   int 16h                ; Vˆ se o utilizador primiu alguma tecla, 
   jnz FIM                ; se n„o recome‡a, se sim acaba

   jmp CICLO

FIM:

   mov  ah,1              ; Rep”e o cursor no ecran
   mov  ch,00011111b
   mov  cl,00001110b
   int  10h


   mov  ah,4ch
   int  21h                         ; Fim!

HEX2ASCII PROC NEAR
			    ; Converte o valor das
			    ; Coordenadas para Decimal
   mov al,0          ;unidades
   mov bh,0          ;dezenas
   mov bl,0          ;centenas
rciclo:
   cmp cx,0
   jz volta
   dec cx
   inc al
   cmp al,0ah
   jnz dezenas
   mov al,0
   inc bh
dezenas:
   cmp bh,0ah
   jnz rciclo
   inc bl
   mov bh,0
   jmp rciclo
volta:
   add al,'0'
   add bh,'0'
   add bl,'0'
   cmp bl,'0'
   jne nzero
   mov bl,bh
   mov bh,al
   mov al,' '
   cmp bl,'0'
   jne nzero
   mov bl,bh
   mov bh,' '
nzero:
   mov [si+2],al
   mov [si+1],bh
   mov [si],bl
   ret

HEX2ASCII ENDP

   END
