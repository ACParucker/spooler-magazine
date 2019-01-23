	.MODEL tiny     ; O modelo Ç o tiny
	.CODE           ; Iniciamos o segmento de c¢digo, que nos ficheiros
			; .COM Ç tambÇm o de dados
	.STARTUP        ; Fazemos a inicializaáÑo

Jmp Start

; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
; €€                                         €€
; €€  I N I C I O   D O   R E S I D E N T E  €€
; €€                                         €€
; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€

OLD1C   dd 0            ; Espaáo para o endereáo da antiga rotina do Int 1Ch
tMin    dw 0

SAVAX:  DW 0            ; Espaáo para guardarmos os registos
SAVBX:  DW 0
SAVCX:  DW 0
SAVDX:  DW 0
SAVBP:  DW 0
SAVDI:  DW 0
SAVSI:  DW 0
SAVDS:  DW 0
SAVES:  DW 0
SAVSS:  DW 0
SAVSP:  DW 0
FLAGS:  DW 0
SAVIP:  DW 0
SAVCS:  DW 0

Alarme:
	push ax         ; Guardamos os registos que vÑo ser alterados
	push bx
	push cx
	push dx
	push es
	pushf
	mov bx,0040h                    ; Movemos 0040h para BX
	mov es,bx                       ; Movemos BX para ES
					; A double word situada no endereáo
					; 0040h:006Ch contÇm o tick corrente
	mov ax,word ptr es:[006ch]      ; Guardamos esse tick em DXAX
	mov dx,word ptr es:[006eh]

	mov cx,0444h                    ; Pomos o CX com 0444h (1092)
	div cx                          ; Dividimos o tick por 1092 e em AX
					; Retornar† o nß de minutos
	cmp cs:[tMin],ax                ; Comparamos o total de minutos com AX
	jle Beep                        ; Se o minuto objecto Ç inferior ou
		; igual ao minuto corrente saltamos para Beep. O leitor poder†
		; pensar entÑo se for inferior tambÇm toca o alarme. A
		; resposta Ç nÑo porque no fim de tocar o alarme o programa
		; desinstala-se, isto Ç pois uma protecáÑo contra o Windows
		; ou outro TSR que intercepte o interrupt 1Ch e que faáa com
		; que a hora passe sem que o ALARME se tenha desinstalado.

	popf    ; Recuperamos os registos anteriormente guardados
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	jmp cs:[OLD1C]          ; Se for inferior voltamos de imediato Ö
				; rotina original

Beep:
	popf            ; Recuperamos os registos anteriormente guardados
	pop es
	pop dx
	pop cx
	pop bx
	pop ax

		; Como vou ter de utilizar interrupts o que Ç 'imposs°vel'
		; nos TSR vou usar o mÇtodo descrito, na SPOOLER Nß 19,
		; pelo Franco Gomes. Trata-se de um malabarismo que permite
		; utilizar todas as funáîes dos interrupts Ö excepáÑo da 10 e
		; menores do Int 21h

	mov word ptr cs:[SAVAX],ax ; Guardam-se todos os registos em vari†veis
	mov word ptr cs:[SAVBX],bx ; do nosso programa
	mov word ptr cs:[SAVCX],cx
	mov word ptr cs:[SAVDX],dx
	mov word ptr cs:[SAVBP],bp
	mov word ptr cs:[SAVDI],di
	mov word ptr cs:[SAVSI],si
	mov word ptr cs:[SAVDS],ds
	mov word ptr cs:[SAVES],es
	pop word ptr cs:[SAVIP]
	pop word ptr cs:[SAVCS]
	pop word ptr cs:[FLAGS]
	mov word ptr cs:[SAVSS],ss
	mov word ptr cs:[SAVSP],sp

	sti                     ; Liga a interrupt flag
	cld                     ; Limpa a direction flag

	pushf                   ; Guardamos as flags
	mov ax,cs               ; Pomos em AX o nosso segmento de c¢digo
	push ax                 ; Empilhamos o AX para enganarmos o IRET
	mov ax,offset Volta
	push ax
	iret            ; Neste IRET a execuáÑo do processador em vez de
			; voltar a onde foi chamada vai continuar na nossa
			; rotina Volta devido a ter sido enganada.

Volta:
	mov ax,cs       ; J† com o Int 1Ch todo enganado vamos apontar o
	mov ds,ax       ; nosso Data Segment e Extra Segment para o Code
	mov es,ax       ; Segment

	mov al,07h      ; Pomos em AL 07h, que Ç o valor do beep
	int 29h         ; Chamamos o Int 29h que imprime na posiáÑo corrente
	int 29h         ; do cursor o caracter que se encontra em AL
	int 29h
	int 29h
	int 29h
	int 29h
	int 29h
	int 29h
	int 29h

	; Agora que j† fizemos o 'basqueiro' todo j† nÑo precisamos de manter
	; o Int 1Ch desviado para a nossa rotina, e podemos libertar a mem¢ria
	; utilizada pelo TSR

	mov ax,351Ch    ; Obtemos o endereáo da rotina do Int 1Ch
	int 21h         ; Usamos a funáÑo 35h do Int 21h

	push es         ; Empilhamos o registo ES
	mov ax,251Ch    ; Vamos apontar o Int 1Ch de novo para a sua rotina
	mov bx,word ptr es:[OLD1C]
	mov dx,bx       ; O DX passa a ser o offset da rotina
	mov bx,word ptr es:[OLD1C+2]
	mov ds,bx       ; O DS passa a ser o segmento da rotina
	int 21h         ; Usamos a funáÑo 25h do Int 21h
	pop es

	mov ah,49h      ; Vamos entÑo libertar a mem¢ria do segmento ocupado
			; por este programa (segmento que vem em ES)
	int 21h         ; Usamos a funáÑo 49h do Int 21h

	push es
	mov bx,word ptr es:[002Ch]
	mov es,bx       ; Libertamos a mem¢ria ocupada pelo DOS Environment,
	mov ah,49h      ; cujo segmento se encontra na word [2Ch] do PSP,
	int 21h         ; pois caso contr†rio ficam uns bytes ocupados
	pop es

	mov bx, word ptr cs:[SAVBX] ; Vamos buscar os registos anteriormente
	mov cx, word ptr cs:[SAVCX] ; guardados em cÇlulas de mem¢ria
	mov dx, word ptr cs:[SAVDX]
	mov bp, word ptr cs:[SAVBP]
	mov di, word ptr cs:[SAVDI]
	mov si, word ptr cs:[SAVSI]
	mov ds, word ptr cs:[SAVDS]
	mov es, word ptr cs:[SAVES]
	mov ss, word ptr cs:[SAVSS]
	mov sp, word ptr cs:[SAVSP]
	mov ax, word ptr cs:[FLAGS]
	push ax
	mov ax, word ptr cs:[SAVCS]
	push ax
	mov ax, word ptr cs:[SAVIP]
	push ax
	mov ax, word ptr cs:[SAVAX]
	iret                  ; E 'pimba' a interrupáÑo volta sÑ e salva



; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
; €€                                   €€
; €€  F I M   D O   R E S I D E N T E  €€
; €€                                   €€
; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€


Start:
        mov ah, 09h             ; Toda a gente precisa de saber quem Ç
        mov dx, offset AUTOR    ; o autor, para tal usei a funáÑo 09h
        int 21h                 ; dos serviáos do DOS 
        
	mov si,0080h            ; Vamos apontar o SI para o °nicio da linha
				; de comando menos 1

Ciclo:  inc si                  ; Neste ciclo vamos retirar os poss°veis
				; espaáos que existam antes do parÉmetro
	cmp byte ptr [si],0dh   ; Comparamos com o fim da string
	jz  NoParam             ; Se for igual saltamos para NoParam
	cmp byte ptr [si],20h   ; Comparamos com espaáo (' ')
	jz Ciclo                ; Se for igual saltamos para o inicio do ciclo

	call Param              ; Chamamos a rotina de an†lise do parÉmetro

				; Agora vamos calcular o tick de rel¢gio a
				; qual o TSR ter† de reagir
				; Existem em cada minuto 1092 ticks de rel¢gio
				; Em cada hora obviamente 60 * 1092
				; Sendo assim o tick da hora pretendida ser†
				; (hora * 60 + minuto) * 1092

	mov ch,3ch              ; CH passa a ter o multiplicador 60
	mov al,Hora             ; Guardamos a hora em al
	mul ch                  ; Multiplicamos AL (Hora) por CH (60) e o
				; resultado aparece em AX, ou seja o nß de
				; minutos correspondentes a essa hora
	mov bx,ax               ; Guardamos o nß de minutos em BX
	xor ax,ax               ; Pomos AX a zero
	mov al,Min              ; Guardamos Min em AL
	cbw                     ; Convertemos o byte AL na word AX
	add bx,ax               ; Adicionamos os restantes minutos (AX) a BX
	mov tMin,bx

	push es                         ; Guardamos o ES
	mov bx,0040h                    ; Movemos 0040h para BX
	mov es,bx                       ; Movemos BX para ES
					; A double word situada no endereáo
					; 0040h:006Ch contÇm o tick corrente
	mov ax,word ptr es:[006ch]      ; Guardamos esse tick em DXAX
	mov dx,word ptr es:[006eh]
	mov cx,0444h                    ; Pomos o CX com 0444h (1092)
	div cx                          ; Dividimos o tick por 1092 e em AX
					; Retornar† o nß de minutos

	cmp tMin,ax                     ; Comparamos o total de minutos,
					; inserido pelo utilizador, com AX
	jle PastTime                    ; Se o total de minutos for inferior
					; ou igual aos minutos correntes
					; saltamos para PastTime
	pop es                          ; Recuperamos o ES

	mov dx, offset InstMsg  ; Vamos notificar o utilizador da instalaáÑo
	mov ah,09h              ; Usamos a estafada funáÑo 09h do Int 21h
	int 21h

	push es                       ; Guardamos o Extra Segment
	mov ax,351ch                  ; Lemos o enderáo da rotina do Int 1Ch
	int 21h
	mov word ptr [OLD1C],bx       ; O endereáo vem no par ES:BX que vamos
	mov word ptr [OLD1C+2],es     ; guardar na double word OLD1C
	pop es                        ; Recuperamos o ES

	mov ax,251ch            ; Substituimos o endereáo do Int 1Ch pela
	mov dx, offset Alarme   ; nossa rotina Alarme
	int 21h

	mov dx, offset Start    ; Em dx pomos o enderáo do primeiro byte a nÑo
				; precisar de ficar residente
	int 27h                 ; E chamamos o Int 27h para terminarmos e
				; ficarmos residentes

NoParam:
	mov dx,offset NPmsg     ; Vamos dizer ao utilizador que o programa
	mov ah,09h              ; necessita de um parÉmetro
	int 21h
	mov ax,4c00h            ; E depois voltamos ao DOS
	int 21h

Param:
	mov al,byte ptr [si]    ; Guardamos o byte em ah
	sub al,30h              ; Subtraimos 30h a cada caracter do parametro
				; pois assim, por exemplo, se o algarismo Ç o
				; '9' decrementado o seu c¢digo ASCII em 30h
				; o seu c¢digo passar† a ser 09h, ou seja o
				; valor do algarismo
	mov ah,0ah              ; Pomos em AH o multiplicador
	mul ah                  ; Multiplicamos o AL por AH (10), o resultado
				; vem em AX
	mov word ptr Hora,ax    ; Guardamos o resultado em Hora

				; Vamos executar as operaáîes semelhantes para
				; os restantes bytes do parÉmetro
	inc si
	xor ax,ax
	mov al,byte ptr [si]
	sub al,30h
	add Hora,al

	inc si
	xor ax,ax
	mov al,byte ptr [si]
	sub al,30h
	mov ah,0ah
	mul ah
	mov word ptr Min,ax

	inc si
	xor ax,ax
	mov al,byte ptr [si]
	sub al,30h
	add Min,al

				; Vamos analisar se a hora introduzida Ç
				; correcta ou nÑo

	cmp Hora,17h            ; Comparamos a hora com 17h (23)
	jg NoParam              ; Se for superior saltamos para NoParam
	cmp Min,3bh             ; Comparamos os minutos com 3bh (59)
	jg NoParam              ; Se for superior saltamos para NoParam

	ret                     ; Retornamos

PastTime:
	mov dx, offset TPast    ; Vamos informar que a hora inserida Ç menor
	mov ah,09h              ; que a actual
	int 21h
	mov ax,4c00h            ; E saimos para o DOS
	int 21h

AUTOR   db 10,13,'Alarme TSR 1.0 - Alarme Residente',10,13
	db '(C) 1993 Luciano Oliveira',10,13,'$'

NPmsg   db 7,10,13,'Erro de sintaxe !',10,13
	db 'Sintaxe : ALARME hhmm',10,13,'$'

InstMsg db 10,13,'Alarme TSR instalado !'
	db 10,13,'A desinstalaáÑo ser† autom†tica !',10,13,'$'

TPast   db 7,10,13,'Hora passada !',10,13,'$'

Hora    db 0
Min     db 0

END

