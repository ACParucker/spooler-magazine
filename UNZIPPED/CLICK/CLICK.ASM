	.MODEL tiny     ; Usamos a directiva .MODEL para especificarmos que
			; o nosso programa utiliza menos de 64K na totalidade
			; de dados e c¢digo

	.CODE           ; Usamos a directiva .CODE para especificarmos que o
			; nosso segmento de c¢digo (que Ç o £nico e tambÇm
			; segmento de dados, visto ser um programa .COM) vai
			; iniciar-se

	.STARTUP        ; Diz ao compilador para fazer todas as inicializaáîes
			; necess†rias inclu°ndo neste caso tambÇm a directiva
			; ORG 100h pertecente aos ficheiros .COM


JMP Start       ; Aqui saltamos para a parte nÑo residente e que vai tratar
		; dos parÉmetros introduzidos pelo utilizador e da instalaáÑo
		; do residente

; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
; €€                                         €€
; €€  I N I C I O   D O   R E S I D E N T E  €€
; €€                                         €€
; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€

ClickTsr:               ; Este procedimento inicializa o speaker interno com
			; uma determinada frequància durante um determinado 
			; tempo
	
	PUSH AX         ; Guardamos os registos
	PUSH BX         ; ê boa politica nos TSRs preservar os registos
	PUSH CX
	PUSH DX
	PUSH DS
	PUSH ES
	PUSH SS
	PUSH SI
	PUSH DI
	PUSH BP
	PUSH SP
	PUSHF           ; E as flags tambÇm
	
	; *** CÜLCULO DOS VALORES DE FREQUâNCIA ***
			
	MOV BX,WORD PTR CS:[Freq]       ; Em BX guardamos a frequància
	MOV AX,034DDh                   ; AX passa a ter o valor 34DDH
	MOV DX,012h                     ; DX passa a ter o valor 0012H
	DIV BX          ; Dividimos o valor guardado nos registos DXAX 
			; (001234DDh = 1193181) por BX ou seja pela frequencia
			; Em AX vem o quociente e em DX o resto
	MOV CX,AX       ; Guardamos o quociente em CX pois vai ser necess†rio
	
	; *** INTRODUÄéO DOS VALORES CALCULADOS NOS DEVIDOS PORTOS ***
	
	MOV AL, 0B6h    ; Em AL guardamos o byte B6h
	OUT 43h, AL     ; Introduzimos o byte AL no porto 43h
	MOV AL, DL      ; AL passa a guardar o resto
	OUT 42h, AL     ; Introduzimos o byte AL no porto 42h
	MOV AL, CL      ; AL passa a guardar o quociente
	OUT 42h, AL     ; Introduzimos o byte AL no porto 42h

	; *** INICIALIZAÄéO DO SPEAKER INTERNO ***
	
	IN AL, 61h      ; Lemos o byte existente no porto 61h
	MOV BL, AL      ; Guardamos o AL em BL pois este valor Ç necess†rio
			; para desligarmos o speaker interno
	OR AL,03h       ; Fazemos o OR de AL com 03h
	OUT 61h, AL     ; E pomos o resultado no porto 61h

	; *** FAZEMOS UMA PAUSA CORRESPONDENTE AO TEMPO DE TOQUE ***
	
	XOR DX,DX                       ; Pomos o DX a zero
	MOV CX,WORD PTR CS:[Temp]       ; Guardamos em CX o tempo de duraáÑo do som
CICLO0: DEC CX          ; Decrementamos o CX
CICLO1: INC DX          ; Incrementamos o DX
	CMP DX,00FFH    ; Comparamos o DX com FFh ( 256 )
	JZ CICLO2       ; Se for igual saltamos para CICLO2
	JMP CICLO1      ; Se nÑo saltamos de novo para CICLO1
CICLO2: XOR DX,DX       ; Pomos o DX a zero
	CMP CX,0000H    ; Comparamos o CX com zero
	JNZ CICLO0      ; Se nÑo for igual salta para CICLO0

	; *** DESLIGAMOS O SPEAKER INTERNO ***
	
	MOV AL,BL       ; MOVemos o valor de BL para AL
	OUT 61h, AL     ; Pomos no porto 61h o byte existente antes de
			; produzirmos o som e que tive o cuidado de guardar
			; em BL
			; E assim desligamos o speaker interno
	
	POPF            ; Recuperamos as flags e os registos
	POP SP
	POP BP
	POP DI
	POP SI
	POP SS
	POP ES
	POP DS
	POP DX
	POP CX
	POP BX
	POP AX
			; Chamamos a antiga rotina do Int 09h pois a tecla que
			; premida tem de ser utilizada pelo programa uma vez
			; que qualquer tecla provoca esta interrupáÑo
	JMP CS:[OLD09]

Assg    dw 0            ; Espaáo para guardar a assinatura do programa
OLD09   dd 0            ; Espaáo para guardar o enderáo da antiga rotina do
			; Int 09h
Freq    dw 0            ; Espaáo para guardar a frequància de som
Temp    dw 0            ; Espaáo para guardar a duraáÑo do som


; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
; €€                                   €€
; €€  F I M   D O   R E S I D E N T E  €€
; €€                                   €€
; €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€


Start:  PUSH ES
	POP DS
	MOV SI,81h      ; O inicio da linha de comando Ç no offset 81h e
			; termina onde estiver o caracter 0Dh(carriage
			; return)
	
	CMP BYTE PTR [SI],0Dh   ; Comparamos o primeiro byte do offset si com 0dh
	JNZ ParamAnalise        ; Se nÑo for igual salta para ParamAnalise
	MOV DX, OFFSET Msg1     ; Caso contr†rio vamos indicar ao utilizador que
	MOV AH,09h              ; podemos usar parÉmetros
	INT 21h
	
	MOV Freq,0190h  ; Introduzimos os valores por defeito
	MOV Temp,0005h  ; Freq = 400    Temp = 05
	
	PUSH ES         ; Empilhamos o registo ES
	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h

	MOV AX,WORD PTR ES:[Assg]       ; Guardamos em AX a assinatura

	MOV SI, BX      ; Recuperamos o ES depois
	MOV BX, ES      ; de copiar o valor deste para BX
	
	POP ES
	CMP AX,'LO'     ; Se a assinatura for igual a 'LO' Ç porque o
			; programa est† instalado
	
	JZ Altera       ; Se for igual alteramos os valores do programa
	JMP Instala     ; Se nÑo for instalamos o TSR
	
Altera:
	PUSH ES         ; Empilhamos o registo ES
	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h

	MOV AX,0190H
	MOV ES:[Freq],AX; Introduzimos os valores por defeito
	MOV AX,0005H
	MOV ES:[Temp],AX; Freq = 400    Temp = 05
	
	POP ES

	MOV DX, OFFSET Msg6
	MOV AH,09h      ; Informamos que instalamos o residente com novos
			; valores
	INT 21h
	
	MOV AH,4Ch
	INT 21h

ParamAnalise:
IncSi:  INC SI          ; Incrementamos o SI
	CMP BYTE PTR [SI],20h
			; Comparamos o byte seguinte com ' '
	JZ IncSi        ; Se for igual salta para IncSi, isto permite-nos tirar
			; os espaáos que existem(se existem) antes dos
			; parametros

	PUSH AX         ; Guardamos os parametros nas vari†veis _Freq e _Temp
			; pois mais tarde vamos precisar delas
	MOV AL,BYTE PTR [SI]
	MOV [_Freq],AL
	MOV AL,BYTE PTR [SI+1]
	MOV [_Freq+1],AL
	MOV AL,BYTE PTR [SI+2]
	MOV [_Freq+2],AL
	MOV AL,BYTE PTR [SI+4]
	MOV [_Temp],AL
	MOV AL,BYTE PTR [SI+5]
	MOV [_Temp+1],AL
	POP AX
	
	CMP BYTE PTR [SI],44h
			; Comparamos o primeiro byte diferente de ' ' com o
			; caracter 'D'
	JNZ BuscaD      ; Se nÑo for igual continuamos
	JMP Desinst     ; Se for igual o utilizador pediu para desinstalar o
			; programa
BuscaD: CMP BYTE PTR [SI],64h
			; Comparamos o primeiro byte diferente de ' ' com o
			; caracter 'd'
	JNZ  Cont       ; Se nÑo for igual continuamos
	JMP Desinst     ; Se for igual o utilizador pediu para desinstalar o
			; programa

Cont:   XOR AX,AX               ; Pomos o AX a zero
	CMP BYTE PTR [SI+5],'9' ; Comparamos o byte com '9'
	JNG NH1                 ; Se nÑo for maior podemos continuar
	JMP InvParam            ; Se for maior saltamos para InvParam
NH1:    CMP BYTE PTR [SI+5],'0' ; Comparamos o byte com '0'
	JNL NL1                 ; Se nÑo for menor podemos continuar
	JMP InvParam            ; Se for menor saltamos para InvParam
	
NL1:    MOV AL,BYTE PTR [SI+5]  ; Vamos guardar o caractÇr
	SUB AL,30h      ; Decrementamos AL em 30h para que AL guarde o valor
			; representado pelo caracter e nÑo o caracter, pois
			; '0' Ç igual a 30h em ASCII se lhe subtrair 30h
			; o c¢digo ASCII passa a ser 0 ou seja o valor do
			; algarismo
	MOV Temp, AX    ; Guardamos o valor de AX em Temp
	XOR AX,AX       ; XOReamos o AX
	CMP BYTE PTR [SI+4],'9' ; Comparamos o byte com '9'
	JNG NH2                 ; Se nÑo for maior podemos continuar
	JMP InvParam            ; Se for maior saltamos para InvParam
NH2:    CMP BYTE PTR [SI+4],'0' ; Comparamos o byte com '0'
	JNL NL2                 ; Se nÑo for maior podemos continuar
	JMP InvParam            ; Se for menor saltamos para InvParam
NL2:     MOV AL,BYTE PTR [SI+4] ; Uma vez que o caracter 'presta' vamos guard†-lo
	SUB AL,30h              ; Decrementamos CH em 30h
	MOV BL,0Ah
	MUL BL  ; Multiplicamos AL por 0Ah e guardamos o resultado em AX
	ADD Temp,AX             ; Adicionamos AX Ö vari†vel Temp

			  ; Repetimos todo o processo para a vari†vel Freq
	XOR AX,AX
	CMP BYTE PTR [SI+2],'9'
	JNG NH3
	JMP InvParam
NH3:    CMP BYTE PTR [SI+2],'0'
	JNL NL3
	JMP InvParam
NL3:    MOV AL,BYTE PTR [SI+2]
	SUB AL,30h
	MOV Freq, AX    ; Guardamos o valor de AX em Freq
	
	XOR AX,AX
	CMP BYTE PTR [SI+1],'9'
	JNG NH4
	JMP InvParam
NH4:    CMP BYTE PTR [SI+1],'0'
	JNL NL4
	JMP InvParam
NL4:    MOV AL,BYTE PTR [SI+1]
	SUB AL,30h
	MOV BL,0Ah
	MUL BL
	ADD Freq,AX     ; Adicionamos AX Ö vari†vel Freq
		
	XOR AX,AX
	CMP BYTE PTR [SI],'9'
	JNG NH5
	JMP InvParam
NH5:    CMP BYTE PTR [SI],'0'
	JNL NL5
	JMP InvParam
NL5:    MOV AL,BYTE PTR [SI]
	SUB AL,30h
	MOV BL,64h
	MUL BL
	ADD Freq,AX     ; Adicionamos AX Ö vari†vel Freq
	
	PUSH ES         ; Empilhamos o registo ES
	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h

	MOV AX,WORD PTR ES:[Assg]       ; Guardamos a assinatura em AX

	MOV SI, BX      ; Recuperamos o ES depois
	MOV BX, ES      ; de copiar o valor deste para BX
	
	POP ES
	
	CMP AX,'LO'     ; Se a assinatura for igual a 'LO' Ç porque o
			; programa est† instalado
	JNZ Instala     ; Se nÑo for igual instalamos o programa
	
	PUSH ES         ; Empilhamos o registo ES
	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h

	MOV AX,Freq     ; Vamos alterar os valores antigos da frequància e
			; tempo pelos novos
	MOV WORD PTR ES:[Freq],AX
	MOV AX,Temp
	MOV WORD PTR ES:[Temp],AX
	
	POP ES
	
	MOV DX, OFFSET Msg6
	MOV AH,09h      ; Informamos que instalamos o residente com novos 
			; valores
	INT 21h
	
	MOV AH,4Ch
	INT 21h

Desinst:
	PUSH ES         ; Empilhamos o registo ES
	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h

	MOV AX,WORD PTR ES:[Assg]       ; Guardamos a assinatura em AX

	MOV SI, BX      ; Recuperamos o ES depois
	MOV BX, ES      ; de copiar o valor deste para BX

	POP ES
	
	CMP AX,'LO'     ; Se a assinatura for igual a 'LO' Ç porque o
			; programa est† instalado
	JNZ NoInst      ; Se nÑo for igual saltamos para NoInst
			; Caso contr†rio vamos desinstalar o programa
	
	MOV DX, OFFSET Msg4     ; Temos de dizer ao utilizador que o programa
	MOV AH, 09h             ; j† se encontra desinstalado
	INT 21h

	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h
	
	MOV AH,49h      ; Vamos entÑo libertar a mem¢ria do segmento ocupado
			; por este programa (segmento que vem em ES)
	INT 21h         ; Usamos a funáÑo 49h do Int 21h
	PUSH ES
	
	MOV BX,WORD PTR ES:[002Ch]
	MOV ES,BX       ; Libertamos a mem¢ria ocupada pelo DOS Environment
	MOV AH,49h      ; pois caso contr†rio ficam uns bytes ocupados
	INT 21h
	POP ES

	PUSH ES         ; Empilhamos o registo ES
	MOV AX,3509h    ; Obtemos o endereáo da rotina que intercepta o Int 9h
	INT 21h         ; Usamos a funáÑo 35h do Int 21h
	
	MOV AX,2509h    ; Vamos apontar o Int 09h de novo para a sua rotina
			; original
	MOV BX,WORD PTR ES:[OLD09]
	MOV DX,BX       ; O DX passa a ser o offset da rotina
	MOV BX,WORD PTR ES:[OLD09+2]
	MOV DS,BX       ; O DS passa a ser o segmento da rotina
			; AtenáÑo porque em OLD09 foi primeiro guardado o
			; offset e depois o segmento

	INT 21h         ; Usamos a funáÑo 25h do Int 21h
	POP ES

	MOV AX,4C00h    ; Fazemos a saida para o DOS utilizando a funáÑo 4Ch
	INT 21h         ; do Int 21h


NoInst:
	MOV DX, OFFSET Msg3
			; Temos de dizer ao utilizador que o programa nÑo se
	MOV AH, 09h     ; encontra instalado
	INT 21h
	MOV AX,4C00h    ; Fazemos a saida para o DOS utilizando a funáÑo 4Ch
	INT 21h         ; do Int 21h


Instala:
	PUSH ES         ; Guarda-se o registo ES que vai ser afectado
	MOV AX,3509h    ; Obtàm-se o endereáo da rotina que intercepta o
			; Int 09h
	INT 21h         ; Usamos para tal a funáÑo 35h do Int 21h

	MOV WORD PTR [OLD09],BX   ; Guardamos o endereáo da rotina que
	MOV WORD PTR [OLD09+2],ES ; vem no par ES:BX
	
	MOV WORD PTR [Assg],'LO'
			; 'Assinamos' o TSR para sabermos se este est† ou
			; nÑo instalado
	
	POP ES          ; Recuperamos o ES

	MOV AH,09h      ; Vamos imprimir uma mensagem informativa
	MOV DX, OFFSET Msg6
	INT 21h

	MOV AX,2509h    ; Substituimos o endereáo da antiga rotina do Int 09h
			; pelo endereáo da nossa rotina ClickTsr
	MOV DX, OFFSET ClickTsr
	INT 21h         ; Usamos a funáÑo 25h do Int 21h

	MOV DX, OFFSET Start
			; Temos que dizer onde termina a rotina a ficar
			; residente assim temos de especificar o primeiro
			; byte a nÑo ficar residente

	INT 27h         ; E por fim chamamos o Int 27h para terminarmos e
			; ficarmos residentes na mem¢ria

InvParam:
	MOV DX, OFFSET Msg1
	MOV AH, 09h     ; Informamos o utilizador acerca da sintaxe
	INT 21h
	MOV DX, OFFSET Msg5
	MOV AH, 09h     ; Informamos que o parametro Ç inv†lido
	INT 21h
	MOV AX,4C00h    ; Fazemos a saida para o DOS utilizando a funáÑo 4Ch
	INT 21h         ; do Int 21h


Msg1    DB 10,13
	DB 'Click TSR 1.0 - Luciano Oliveira',10,13
	DB 'Sintaxe:',10,13
	DB '        CLICK [D] [fff dd]',10,13,10,13
	DB '        D   - Desinstala o programa da mem¢ria',10,13
	DB '        fff - Instala o programa com a frequància fff',10,13
	DB '        dd  - instala o programa com a duraáÑo dd',10,13,10,13
	DB 'Nota: Os valores deverÑo ter sempre no caso da frequància 3 algarismos',10,13
	DB '     e no caso da duraáÑo dois. Se desejar utilizar valores inferiores',10,13
	DB '     dever† utilizar zeros Ö esquerda para completar o n£mero.',10,13,'$'
	

Msg2    DB 10,13
	DB '  Programa instalado com os valores originais.',10,13
	DB '  Frequància = 400               DuraáÑo = 05',10,13,'$'

Msg3    DB 10,13
	DB 'Click TSR 1.0 - Luciano Oliveira',10,13
	DB 'Click TSR nÑo se encontra instalado !',10,13,'$'

Msg4    DB 10,13
	DB 'Click TSR 1.0 - Luciano Oliveira',10,13
	DB 'Click TSR desinstalado com sucesso !',10,13,'$'

Msg5    DB 10,13,'ParÉmetro utilizado inv†lido !',10,13,'$'

Msg6    DB 10,13
	DB 'Click instalado com os seguintes valores:',10,13
	DB '      Frequància = '
_Freq   DB '400'
	DB 10,13
	DB '      DuraáÑo = '
_Temp   DB '05'
	DB 10,13
	DB '$'

END

