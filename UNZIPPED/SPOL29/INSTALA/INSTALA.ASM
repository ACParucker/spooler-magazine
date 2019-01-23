
;[ù]------------------------------------------------------------------------[ù];
;|                                                                            |;
;|           nome:           INSTALA.ASM                                      |;
;|           compilador:     TASM 3.0                                         |;
;|           autor:          Carlos Ladeira                                   |;
;|           data:           18/12/1993                                       |;
;|           descri‡„o:      Programa para fazer a instala‡„o de software     |;
;|                                                                            |;
;[ù]------------------------------------------------------------------------[ù];


                .MODEL  SMALL
                .STACK  50

                .CODE
;======================================================================
; Ajusta DS para o segmento de dados e guarda o segmento do PSP
;----------------------------------------------------------------------
START:          MOV     AX, @DATA               ; ajusta o registo DS
                MOV     DS, AX                  ; para o segmento de dados
                MOV     PSP, ES                 ; guarda o SEG do PSP

;----------------------------------------------------------------------
; Inicio do programa, ‚ verificada a vers„o do DOS
;----------------------------------------------------------------------
                MOV     AH, 30H                 ; ®pergunta¯ ao DOS qual
                INT     21H                     ; a sua vers„o
                CMP     AL, 3
                JB      BAD_DOS                 ; termina a execu‡„o do programa
                JG      REALOC_MEM              ; se n„o for pelo menos a vers„o
                CMP     AH, 2                   ; 3.2
                JGE     REALOC_MEM

;----------------------------------------------------------------------
; Se a vers„o do DOS for menor que a 3.2 sai
;----------------------------------------------------------------------
BAD_DOS:        MOV     DX, OFFSET ERR_DOS_VER$ ; mensagem
EXIT:           MOV     AH, 9                   ; fun‡„o para fazer com que o
                INT     21H                     ; DOS escreva uma string
                CALL    BEEP                    ; faz um beep
                MOV     AX, 4CFFH               ; e termina a execu‡„o do
                INT     21H                     ; programa com ERRORLEVEL=255

;----------------------------------------------------------------------
; Se o environment-block estiver currompido, sai
;----------------------------------------------------------------------
BAD_ENV:        MOV     DX, OFFSET ERR_BAD_ENV$ ; mensagem
                JMP     SHORT EXIT              ; mostra e termina

;----------------------------------------------------------------------
; Se ocorrer um erro de realoca‡„o da mem¢ria, sai
;----------------------------------------------------------------------
MEM_ERR:        MOV     DX, OFFSET REALOC_ERR$  ; mensagem
                JMP     SHORT EXIT              ; mostra e termina

;----------------------------------------------------------------------
; Se ocorrer um erro na leitura do ficheiro INSTALA.DAT, sai
;----------------------------------------------------------------------
DATA_READ_ERR:  MOV     DX, OFFSET DATA_READ_ERR$       ; mensagem
                JMP     SHORT EXIT                      ; mostra e termina

;----------------------------------------------------------------------
; Se aparecer um fim de ficheiro permaturo, sai
;----------------------------------------------------------------------
BAD_EOF:        MOV     DX, OFFSET BAD_EOF$     ; mensagem
                JMP     SHORT EXIT              ; mostra e termina

;----------------------------------------------------------------------
; Se o ficheiro PKUNZJR.COM n„o existir, termina
;----------------------------------------------------------------------
NO_PKUNZJR:     MOV     DX, OFFSET NO_PKUNZJR$  ; mensagem
                JMP     SHORT EXIT              ; modtra e termina

;----------------------------------------------------------------------
; Se o ficheiro INSTALA.DAT n„o existir, termina
;----------------------------------------------------------------------
NO_INST_DATA:   MOV     DX, OFFSET NO_INST_DATA$; mensagem
                JMP     SHORT EXIT              ; mostra e termina

;----------------------------------------------------------------------
; Se os fich. ZIP descritos no fich. INSTALA.DAT n„o existirem, termina
;----------------------------------------------------------------------
FILES_MISS:     MOV     DX, OFFSET FILES_MISS$  ; mensagem
                JMP     SHORT EXIT              ; mostra e termina

;----------------------------------------------------------------------
; Ajusta o bloco de mem¢ria alocado para o programa
;----------------------------------------------------------------------
REALOC_MEM:     MOV     AX, ES                  ; 1§ segmento do programa (PSP)
                MOV     BX, DS                  ; ultimo segmento do programa
                SUB     BX, AX                  ; n£mero de para. do programa
                MOV     AX, OFFSET STK_TOP      ; fim do segmento de dados (bytes)
                MOV     CL, 4                   ; transforma em paragrafos
                SHR     AX, CL                  ; AX = AX / 16
                INC     AX                      ; +1 para estarmos … vontade
                ADD     BX, AX                  ; BX = N§ de para. do programa
                MOV     AH, 4AH                 ; atravˆs do DOS, reajusta o
                INT     21H                     ; tamanho do MCB do programa
                JC      MEM_ERR                 ; em caso de erro, salta

;----------------------------------------------------------------------
; Activa a nova localiza‡„o da stack (pilha)
;----------------------------------------------------------------------
                MOV     AX, DS                  ; segmento de dados
                CLI                             ; desabilita interrup‡”es
                MOV     SS, AX                  ; SS = DS
                MOV     SP, OFFSET STK_TOP      ; SP = topo da pilha
                STI                             ; habilita interrup‡”es

;----------------------------------------------------------------------
; Determina a directoria de onde o programa esta a ser executado e
; copia-a para o buffer PROG_PATH.
;----------------------------------------------------------------------
GETENV1:        CLD                             ; incrementos, em oper. c/ strings
                XOR     AL, AL                  ; AL = 0
                MOV     WORD PTR ES, ES:[2CH]   ; ES = environment segment
                XOR     DI, DI                  ; DI = 0
                MOV     CX, 7FFFH               ; CX = 32k
GETENV2:        REPNE   SCASB                   ; procura o byte em AL (0)
                JNE     BAD_ENV                 ; se passou os 32k, termina
                CMP     BYTE PTR ES:[DI], 0     ; ‚ o fim das vars (00 00)
                JNE     GETENV2                 ; n„o, salta
                ADD     DI, 3                   ; passa a sequˆncia '00 01 00'

                PUSH    DS ES                   ; DS = ES & ES = DS
                POP     DS ES
                MOV     SI, DI                  ; SI = DI
                MOV     DI, OFFSET PROG_PATH    ; destino da string

                MOV     BX, DI                  ; guarda o inicio da string
GETENV3:        LODSB                           ; lˆ um car cter
                CALL    TOUPPER                 ; coloca em mai£sculas
                OR      AL, AL                  ; ‚ o fim da string ?
                JNZ     GETENV4                 ; n„o, salta
                MOV     DI, BX                  ; DI = posi‡„o do ultimo '\'
GETENV4:        STOSB                           ; escreve um car cter
                JZ      GETENV5                 ; se foi o fim de string, salta
                CMP     AL, '\'                 ; o car cter ‚ um '\' ?
                JNE     GETENV3                 ; n„o, salta
                MOV     BX, DI                  ; sim, guarda a posi‡„o, pois
                                                ; pode ser o ultimo
                JMP     SHORT GETENV3           ; vai buscar mais um car cter

GETENV5:        PUSH    ES                      ; restaura os registo ES e DS
                POP     DS

;----------------------------------------------------------------------
; Verifica a exitˆncia dos ficheiros PKUNZJR.COM e INSTALA.DAT
;----------------------------------------------------------------------
                MOV     SI, OFFSET PROG_PATH    ; SI -> path do programa
                MOV     DI, OFFSET CNAME        ; DI -> pathname p/ PKUNZJR.COM
                CALL    COPYZ                   ; copia a path
                MOV     SI, DI
                MOV     DI, OFFSET PKUNZJR      ; adiciona-lhe o PKUNZJR.COM
                CALL    STRCAT
                MOV     DX, SI                  ; DX = SI
                CALL    FEXIST                  ; verifica se existe
                JNC     CHKFILES1               ; se n„o existir, salta
                JMP     NO_PKUNZJR

CHKFILES1:      MOV     SI, OFFSET PROG_PATH    ; SI -> path do programa
                MOV     DI, OFFSET WORK_STR     ; DI -> pathname p/ INSTALA.DAT
                CALL    COPYZ                   ; copia a path
                MOV     SI, DI
                MOV     DI, OFFSET INST_DATA    ; adiciona-lhe o INSTALA.DAT
                CALL    STRCAT
                MOV     DX, SI                  ; DX = SI
                CALL    FEXIST                  ; verifica se existe
                JNC     CHKFILES2               ; se n„o existir, salta
                JMP     NO_INST_DATA
CHKFILES2:

;----------------------------------------------------------------------
; Lˆ o ficheiro com os dados da instala‡„o
;----------------------------------------------------------------------
                MOV     AX, 3D00H               ; abre o ficheiro INSTALA.DAT
                INT     21H                     ; utilizando o DOS
                JNC     RD_DATA1                ; Se houver erro,
                JMP     DATA_READ_ERR           ; salta

RD_DATA1:       MOV     BX, AX                  ; handle em BX
                MOV     SI, 80                  ; N§ max. de caracteres a ler
                MOV     DX, OFFSET PROG_TITLE   ; buffer
                CALL    READ_LINE               ; lˆ a linha
                JNC     RD_DATA2                ; em caso de erro,
                JMP     BAD_EOF                 ; salta

RD_DATA2:       MOV     DI, OFFSET ITENS        ; DI -> para o 1§ item
RD_DATA3:       MOV     DX, DI                  ; DX -> buffer p/ a descri‡„o
                MOV     SI, 40                  ; N§ max. de caracteres a ler
                CALL    READ_LINE               ; lˆ a linha
                JC      RD_DATA7                ; se houve erro, salta

                MOV     DX, DI
                ADD     DX, ZIPFILE             ; DX -> buffer para o fich. ZIP
                MOV     SI, 12                  ; N§ max. de caracteres a ler
                CALL    READ_LINE               ; lˆ a linha
                JC      RD_DATA7                ; se houve erro, salta
                CALL    STRUPR                  ; coloca em maiusculas

                MOV     DX, DI
                ADD     DX, DIR                 ; DX -> buffer p/ directoria
                MOV     SI, 80                  ; N§ max. de caracteres a ler
                CALL    READ_LINE               ; lˆ a linha
                JC      RD_DATA7                ; se houve erro, salta
                CALL    STRUPR                  ; coloca em maiusculas

                MOV     DX, OFFSET WORK_STR     ; DX -> buffer p/ o n£mero
                MOV     SI, 5                   ; com o m ximo de 5 caracteres
                CALL    READ_LINE               ; lˆ-o
                JC      RD_DATA7                ; em caso de erro, salta

                PUSH    BX                      ; guarda BX
                MOV     SI, DX                  ; SI -> n£mero lido
                MOV     CX, 10                  ; converte para decimal
                XOR     AX, AX                  ; AX = 0
                XOR     BH, BH                  ; BH = 0
RD_DATA4:       MOV     BYTE PTR BL, [SI]       ; BL = 1 digito do n£mero
                INC     SI                      ; SI -> pr¢ximo digito
                OR      BL, BL                  ; BL = 0 (fim do n£mero) ?
                JZ      RD_DATA5                ; sim, salta
                MUL     CX                      ; AX:DX = AX * CX
                SUB     BL, '0'                 ; converte BL para n£mero
                ADD     AX, BX                  ; e soma-o ao resultado
                JMP     SHORT RD_DATA4          ; lˆ o pr¢ximo digito
RD_DATA5:       POP     BX                      ; restaura BX

                MOV     DX, DI
                ADD     DX, ZIPFILE             ; DX -> buffer para o fich. ZIP
                CALL    FEXIST                  ; verifica se existe
                JNC     RD_DATA6                ; existe, salta
                MOV     FILES_MISSING, 1        ; sinaliza falta do ZIP
                JMP     RD_DATA3                ; e lˆ o pr¢ximo item

RD_DATA6:       MOV     WORD PTR [DI].SIZE_KB, AX       ; guarda o tamanho
                MOV     BYTE PTR [DI].ACTIVE, -1        ; por defeito: activo
                ADD     DI, ITEM_SZ             ; prepara-se para ler o pr¢ximo
                INC     NR_ITENS                ; item. Isto claro, se n„o foram
                CMP     NR_ITENS, MAX_ITENS     ; j  lidos o max. possivel
                JB      RD_DATA3                ; n„o, lˆ o pr¢ximo

RD_DATA7:       MOV     AH, 3EH                 ; fecha o ficheiro INSTALA.DAT
                INT     21H                     ; utilizando o DOS

                CMP     NR_ITENS, 1             ; quantos itens foram lidos ?
                JGE     RD_DATA9                ; 1 ou mais, salta
                CMP     FILES_MISSING, 1        ; 0, faltam ficheiros ?
                JNE     RD_DATA8                ; n„o, salta
                JMP     FILES_MISS              ; sim, termina
RD_DATA8:       JMP     BAD_EOF                 ; EOF permaturo, termina
RD_DATA9:

;----------------------------------------------------------------------
; Inicializa o video e guarda o seu estado actual
;----------------------------------------------------------------------
                MOV     AH, 0FH                 ; determina o modo de video
                INT     10H                     ; corrente
                MOV     OLD_PAG, BH             ; guarda a p gina activa
                MOV     OLD_MODE, AL            ; e modo de video corrente

                MOV     AH, 3                   ; grava o tamanho actual
                INT     10H                     ; do cursor na variavel
                MOV     OLD_CUR_SZ, CX          ; OLD_CUR_SZ

                MOV     AX, 7                   ; activa o modo 7
                CMP     OLD_MODE, 7             ; se estiver em modo 7
                JE      IVID1
                CMP     OLD_MODE, 15            ; ou 15
                JE      IVID1
                ADD     VIDADR, 800H            ; n„o ‚ mono, B000H -> B800H
                MOV     AX, 2                   ; activa o modo 2
                CMP     OLD_MODE, 2             ; se estiver em modo 2
                JE      IVID1
                CMP     OLD_MODE, 0             ; ou 0
                JE      IVID1
                MOV     AX, OFFSET COLOR_PAL    ; n„o ‚ P&B, ajusta as cores
                MOV     PALETTE, AX
                MOV     AX, 3                   ; activa o modo 3
IVID1:          INT     10H

;----------------------------------------------------------------------
; Desenha o ecr„ principal
;----------------------------------------------------------------------
                MOV     SI, PALETTE             ; SI -> paletta de cores

                MOV     AX, 600H                ; limpa todo o ecr„
                MOV     BH, [SI].TEXT_LO
                XOR     CX, CX
                MOV     DX, 184FH
                INT     10H

                MOV     AH, [SI].FRAMES         ; desenha uma caixa
                MOV     CX, 0201H
                MOV     DX, 144EH
                CALL    BOX

                MOV     CX, 1201H               ; desenha outra
                MOV     DX, 144EH
                CALL    BOX

                MOV     DX, 1201H               ; desenha 2 caracteres
                MOV     AL, 'Ã'
                CALL    XYCH
                MOV     DL, 4EH
                MOV     AL, '´'
                CALL    XYCH

                MOV     AH, [SI].TEXT_LO        ; escreve uma string
                MOV     CX, 1304H
                MOV     DX, OFFSET MESS2$
                CALL    XYSTR

                MOV     DX, 134BH               ; escreve um car cter
                MOV     AL, 'K'
                CALL    XYCH

                CALL    SHOW_USED               ; mostra o espa‡o ocupado
                CALL    DRAW_ITENS              ; desenha os itens
                CALL    DRAW_SCROOL             ; desenha a barra de scrool

                MOV     AH, [SI].TEXT_HI        ; escreve 4 strings
                MOV     CX, 1610H
                MOV     DX, OFFSET INST_BUT$
                CALL    XYSTR
                MOV     CL, 37H
                MOV     DX, OFFSET CANC_BUT$
                CALL    XYSTR
                MOV     CX, 207H
                MOV     DX, OFFSET DESC_HDR$
                CALL    XYSTR
                MOV     CL, 49
                MOV     DX, OFFSET DIRE_HDR$
                CALL    XYSTR

                MOV     AH, [SI].TITL           ; escreve o titulo centralizado
                XOR     CX, CX
                MOV     DL, 79
                CALL    CLR_LN
                MOV     SI, OFFSET PROG_TITLE
                CALL    STRLEN
                SUB     CL, 80
                NEG     CL
                SHR     CL, 1
                MOV     DX, SI
                CALL    XYSTR

;----------------------------------------------------------------------
; Main loop do programa
;----------------------------------------------------------------------
MAIN_LOOP:      CALL    SEL_ITENS               ; seleciona itens
                CALL    INSTALA                 ; instala
                CALL    CANCELA                 ; termina
                JMP     SHORT MAIN_LOOP         ; faz tudo novamente

;======================================================================
; Nome          KEY_JMP
; Descri‡„o     Salta para a localiza‡„o correspondente … tecla em AX
;               SI aponta para a tab‚la de ®saltos¯
; Retorno       local do salto
;----------------------------------------------------------------------
KEY_JMP         PROC
GJMP1:          CMP     [SI].KEY_CODE, -1       ; default ?
                JE      GJMP2                   ; sim, salta
                CMP     [SI].KEY_CODE, AX       ; tecla certa ?
                JE      GJMP2                   ; sim, salta
                ADD     SI, 4                   ; pr¢xima posi‡„o da tabela
                JMP     SHORT GJMP1             ; faz o loop
GJMP2:          ADD     SP, 2                   ; passa o ret desta fun‡„o
                JMP     [SI].LOCATION           ; salta para o local pretendido
KEY_JMP         ENDP

;======================================================================
; Nome          SEL_ITENS
; Descri‡„o     Permite que o utilizador active apenas os itens que
;               pretenda instalar
; Retorno       Nenhum
;----------------------------------------------------------------------
SEL_ITENS       PROC
                MOV     DX, OFFSET SELE_STAT$   ; linha de status
                CALL    STATUS                  ; escreve-a
SELI1:          CALL    DRAW_ITENS              ; desenha os itens
SELI1A:         CALL    LIGHT_ITEM              ; posiciona o ®cursor¯
                CALL    DRAW_SCROOL             ; desenha a barra de scrool
                CALL    READ_KEY                ; lˆ uma tecla
                CALL    UNLIGHT_ITEM            ; apaga o ®cursor¯

                MOV     SI, OFFSET SELI_JMP     ; tabela de saltos para esta func.
                CALL    KEY_JMP                 ; salta de acordo com a tec. premida

; SPACE
SELI2:          MOV     AL, CUR_ITEM            ; AL = item corrente
                CALL    PUT_ITEM_DI             ; DI -> item corrente
                NOT     [DI].ACTIVE             ; inverte o estado do item
                CALL    SHOW_USED               ; mostra o espa‡o a usar na inst.
                JMP     SHORT SELI1             ; faz o loop

; UP
SELI3:          CMP     CUR_ITEM, 1             ; se j  estiver no 1§ item
                JE      SELI1A                  ; ignora-se o comando
                DEC     CUR_ITEM                ; se n„o, item anterior
                MOV     AL, SCR_1ST_ITEM        ; AL = primeiro item do ecr„
                CMP     CUR_ITEM, AL            ; ‚ maior que o corrente
                JGE     SELI1A                  ; n„o, salta
                DEC     SCR_1ST_ITEM            ; sim, decrementa-o
                JMP     SHORT SELI1             ; faz o loop

; DOWN
SELI4:          MOV     AL, NR_ITENS            ; AL = N§ de itens
                CMP     CUR_ITEM, AL            ; o corrente ‚ igual ?
                JE      SELI1A                  ; sim, ignora o comando
                INC     CUR_ITEM                ; n„o, pr¢ximo item
                MOV     AL, SCR_1ST_ITEM        ; coloca em AL o £ltimo item
                ADD     AL, SCR_SZ              ; do ecr„
                CMP     CUR_ITEM, AL            ; o corrente ‚ menor ?
                JB      SELI1A                  ; sim, salta
                INC     SCR_1ST_ITEM            ; n„o, inc. o 1§ no ecr„
                JMP     SHORT SELI1             ; faz o loop

; ENTER
SELI6:          MOV     DX, OFFSET EDIT_STAT$   ; linha de status
                CALL    STATUS                  ; escreve-a
                MOV     AL, CUR_ITEM            ; AL = item corrente
                CALL    PUT_ITEM_DI             ; DI -> dados do item corrente
                MOV     SI, DI                  ; SI -> dir do item corrente
                ADD     SI, DIR
                MOV     DI, OFFSET W_PATH       ; DI -> estrutura de edi‡„o
                MOV     [DI].STRING, SI         ; string a editar (dir)
                MOV     [DI].STR_POS, 0         ; posi‡„o de ed. na string
                MOV     [DI].STR_ED_POS, 0      ; posi‡„o da janela na string
                MOV     AH, CUR_ITEM            ; calcula a posi‡„o X,Y da
                SUB     AH, SCR_1ST_ITEM        ; directoria a editar
                ADD     AH, 3
                MOV     AL, 50
                MOV     [DI].STR_XY, AX         ; e guarda-a
                CALL    EDIT_STR                ; edita a string
                JMP     SEL_ITENS               ; faz o loop

; TAB, ESCAPE
SELI5:          RET                             ; termina a execu‡„o da fun‡„o
SEL_ITENS       ENDP

;======================================================================
; Nome          INSTALA
; Descri‡„o     Instala os itens selecionados
; Retorno       nenhum
;----------------------------------------------------------------------
INSTALA         PROC
                MOV     DX, OFFSET INST_STAT$   ; mensagem de status
                CALL    STATUS                  ; mostra-a
                MOV     SI, PALETTE             ; AH = atributo de texto activo
                MOV     AH, [SI].CUR_TEXT
                MOV     CX, 1610H               ; posi‡„o X,Y
                MOV     DX, OFFSET INST_BUT$    ; mensagem "INSTALA"
                CALL    XYSTR                   ; escreve-a
                MOV     DX, 1611H               ; e posiciona o cursor en cima
                CALL    GOTOXY

INST1:          CALL    READ_KEY                ; lˆ uma tecla
                CMP     AX, KTAB                ; ‚ TAB ?
                JE      INST6                   ; sim, salta
                CMP     AX, KCR                 ; ‚ ENTER ?
                JNE     INST1                   ; n„o, lˆ nova tecla

INST2:          MOV     ES, PSP                 ; sem utilizar o DOS, simula o
                MOV     BYTE PTR ES:[19H], 0FFH ; fecho do STDOUT para que o
                                                ; output do PKUNZJR n„o sˆja
                                                ; visivel

                MOV     CL, NR_ITENS            ; CX = N§ de itens
                XOR     CH, CH
                MOV     DI, OFFSET ITENS        ; DI -> dados do 1§ item

INST3:          MOV     AH, 1                   ; verifica se existe alguma
                INT     16H                     ; tecla premida
                JZ      INST3A                  ; se n„o houver, salta
                CALL    READ_KEY                ; se houver, lˆ-a
                CMP     AX, KESC                ; ‚ ESCAPE ?
                JNE     INST3                   ; n„o, salta
                JMP     SHORT INST5             ; sim, termina

INST3A:         CMP     [DI].ACTIVE, -1         ; est  activo ?
                JNE     INST4                   ; n„o, salta
                CALL    CHECK_SIZE              ; verifica se tem espa‡o para instalar
                JC      INST8                   ; se n„o couber, salta
                CALL    MAKE_DIRS               ; sim, cria as directorias
                JC      INST7                   ; se houve erro, salta
                CALL    UNZIP                   ; descomprime o ficheiro
                JC      INST7                   ; se houve erro, salta
                NOT     [DI].ACTIVE             ; depois de instalado, desactiva-se
INST4:          ADD     DI, ITEM_SZ             ; DI -> pr¢ximo item
                LOOP    INST3                   ; instala o pr¢ximo item

                MOV     DX, OFFSET UNZIP_OK$    ; mensagem de status
                CALL    STATUS_CURSOR           ; mostra-a
                CALL    BEEP
                CALL    READ_KEY                ; espera que o utiliz. tecle

INST5:          MOV     ES, PSP                 ; reabre o STDOUT alterando o
                MOV     BYTE PTR ES:[19H], 1    ; 2§ byte da tabela de handles

INST6:          MOV     AH, [SI].TEXT_HI        ; restaura a cor do texto do
                MOV     CX, 1610H               ; ®bot„o¯ "INSTALA"
                MOV     DX, OFFSET INST_BUT$
                CALL    XYSTR
                CALL    DRAW_ITENS
                CALL    SHOW_USED
                RET                             ; e termina

INST7:          MOV     DX, OFFSET UNZIP_ERR$   ; em caso de erro
                CALL    STATUS_CURSOR           ; mostra a mensagem de erro
                CALL    DRAW_ITENS
                CALL    SHOW_USED
                CALL    BEEP                    ; faz ouvir um beep
                CALL    READ_KEY                ; e espera a leitura de uma tecla
                JMP     INSTALA                 ; salta para o inicio

INST8:          PUSH    SI DI ES DS             ; guarda os registos
                POP     ES                      ; ES = DS
                MOV     DX, DI                  ; endere‡o dos dados do item
                MOV     SI, OFFSET NO_SPACE$    ; cria a string a informar
                MOV     DI, OFFSET WORK_STR     ; o utilizador que n„o existe
                CALL    COPYZ                   ; espa‡o suficiente para
                MOV     SI, DI                  ; descompactar o resp‚ctivo
                MOV     DI, DX                  ; ficheiro
                ADD     DI, ZIPFILE
                CALL    STRCAT
                MOV     DI, OFFSET ESC_ABORT$
                CALL    STRCAT
                MOV     DX, SI
                POP     ES DI SI
                CALL    STATUS_CURSOR           ; mostra-a
                CALL    BEEP
                CALL    READ_KEY                ; lˆ uma tecla
                CMP     AX, KESC                ; ‚ ESCAPE
                JE      INST5                   ; sim, termina
                JMP     SHORT INST4             ; n„o, continua
INSTALA         ENDP

;======================================================================
; Nome          CANCELA
; Descri‡„o     Cancela a execu‡„o do programa, saindo para o DOS
; Retorno       nenhum
;----------------------------------------------------------------------
CANCELA         PROC
                MOV     DX, OFFSET CANC_STAT$   ; mensagem de status
                CALL    STATUS                  ; mostra-a
                MOV     SI, PALETTE             ; SI -> palette
                MOV     AH, [SI].CUR_TEXT       ; AH = atributo
                MOV     CX, 1637H               ; CX = X,Y
                MOV     DX, OFFSET CANC_BUT$    ; mensagem "CANCELA"
                CALL    XYSTR                   ; escreve-a
                MOV     DX, 1638H               ; e posiciona o cursor
                CALL    GOTOXY

CANC2:          CALL    READ_KEY                ; lˆ uma tecla
                CMP     AX, KCR                 ; ‚ ENTER ?
                JE      CANC1                   ; sim, salta
                CMP     AX, KTAB                ; ‚ TAB ?
                JNE     CANC2                   ; n„o, salta

                MOV     AH, [SI].TEXT_HI        ; restaura a cor do bot„o
                MOV     DX, OFFSET CANC_BUT$    ; CANCELA
                CALL    XYSTR
                RET

CANC1:          MOV     AL, OLD_MODE            ; restaura o modo antigo
                XOR     AH, AH
                INT     10H

                MOV     AH, 5                   ; restaura a p gina antiga
                MOV     AL, OLD_PAG
                INT     10H

                MOV     AH, 1                   ; restaura o tamanho do cursor
                MOV     CX, OLD_CUR_SZ
                INT     10H

                MOV     DX, OFFSET COPYRIGHT$   ; mostra mensagem de copyright
                MOV     AH, 9
                INT     21H

                MOV     AX, 4C00H               ; termina o programa
                INT     21H
CANCELA         ENDP

;======================================================================
; Nome          CHECK_SIZE
; Descri‡„o     Verifica o espa‡o para instala‡„o do item apontado por DI.
; Retorno       Nunhum
;----------------------------------------------------------------------
CHECK_SIZE      PROC
                PUSH    AX BX CX DX SI          ; guarda o conteudo dos regs
                XOR     DL, DL                  ; drive = 0 (omiss„o)
                MOV     SI, DI                  ; SI -> path de destino
                ADD     SI, DIR
                CMP     BYTE PTR [SI + 1], ':'  ; tem drive ?
                JNE     CHKSZ1                  ; n„o, salta
                MOV     DL, [SI]                ; sim, guarda-a
                SUB     DL, 'A' - 1             ; converte-a para 1 a ...
CHKSZ1:         MOV     AH, 36H                 ; determina o espa‡o livre
                INT     21H                     ; utilizando o DOS
                MUL     CX                      ; AX:DX = N§ de bytes livres
                MUL     BX
                MOV     SI, 1024                ; transforma em Kbytes
                MOV     BX, AX
                MOV     AX, DX
                XOR     DX, DX
                DIV     SI
                XCHG    AX, BX
                DIV     SI
                OR      BX, BX                  ; mais que 65 Mb ?
                JNZ     CHKSZ2                  ; sim, salta
                CMP     AX, [DI].SIZE_KB        ; n„o, maior que o espa‡o pretendido ?
                JG      CHKSZ2                  ; sim, salta
                STC                             ; n„o, sinaliza a falta de espa‡o
                JMP     SHORT CHKSZ3            ; e termina
CHKSZ2:         CLC                             ; h  espa‡o suficiente
CHKSZ3:         POP     SI DX CX BX AX          ; restaura os registos alterados
                RET
CHECK_SIZE      ENDP

;======================================================================
; Nome          MAKE_DIRS
; Descri‡„o     Cria (se n„o existirem) as directorias de destino.
; Retorno       Nunhum
;----------------------------------------------------------------------
MDIR            PROC                            ; verifica a existˆncia de uma dir
                PUSH    AX CX                   ; guarda registos
                MOV     AH, 4EH                 ; find first
                MOV     CX, 10H                 ; atributo (dirs)
                INT     21H
                JNC     MD1                     ; se j  existe, salta
                MOV     AH, 39H                 ; se n„o, cria-a
                INT     21H
MD1:            POP     CX AX                   ; restaura registos
                RET
MDIR            ENDP

MAKE_DIRS       PROC
                PUSH    AX BX DX SI DI ES       ; guarda registos
                ADD     DI, DIR                 ; DI -> directoria a criar

                PUSH    DS                      ; ES = DS
                POP     ES
                MOV     SI, DI                  ; WORK_STR = directoria
                MOV     DI, OFFSET WORK_STR
                CALL    COPYZ
                MOV     SI, DI

                MOV     DX, SI                  ; inicio da dir
                CMP     BYTE PTR [SI+1], ':'    ; tem drive ?
                JNE     MKD1                    ; n„o, salta
                ADD     SI, 2                   ; sim, passa-a ("x:...")
                CMP     BYTE PTR [SI], '\'      ; ‚ na ROOT ?
                JNE     MKD1                    ; n„o, salta
                INC     SI                      ; sim, passa-a

MKD1:           CLD
MKD2:           LODSB                           ; lˆ car cter
                OR      AL, AL                  ; ‚ fim de string
                JZ      MKD3                    ; sim, salta
                CMP     AL, '\'                 ; n„o, ‚ '\' ?
                JNE     MKD2                    ; n„o, salta
                MOV     BYTE PTR [SI-1], 0      ; sim, fim de str temporario
                CALL    MDIR                    ; cria a directoria
                JC      MKD3                    ; se houve erro, salta
                MOV     BYTE PTR [SI-1], '\'    ; restaura a '\'
                JMP     SHORT MKD2              ; faz o loop

MKD3:           POP     ES DI SI DX BX AX       ; restaura os registos
                RET
MAKE_DIRS       ENDP

;======================================================================
; Nome          PUT_ITEM_DI
; Descri‡„o     Coloca em DI o endere‡o dos dados do item el AL.
; Retorno       Nunhum
;----------------------------------------------------------------------
PUT_ITEM_DI     PROC
                PUSH    AX                      ; guarda AX
                DEC     AL                      ; AX = AL * tamanho de cada item
                MOV     AH, ITEM_SZ
                MUL     AH
                MOV     DI, AX                  ; coloca em DI
                ADD     DI, OFFSET ITENS        ; soma-lhe o off do 1§ item
                POP     AX                      ; restaura AX
                RET
PUT_ITEM_DI     ENDP

;======================================================================
; Nome          LIGHT_ITEM
; Descri‡„o     Activa o item corrente.
; Retorno       Nunhum
;----------------------------------------------------------------------
LIGHT_ITEM      PROC
                PUSH    AX CX DX SI DI ES
                MOV     DH, CUR_ITEM            ; posiciona o cursor
                SUB     DH, SCR_1ST_ITEM
                ADD     DH, 3
                MOV     DL, 4
                CALL    GOTOXY

                MOV     DL, 2                   ; video off do 3§ car do item
                CALL    COMP_ADDR
                MOV     CX, 75                  ; linha com 75 caracteres
                MOV     SI, PALETTE             ; DL = atributo
                MOV     DL, [SI].CUR_TEXT
                PUSH    DS ES                   ; guarda DS e DS = ES
                POP     DS
                MOV     SI, DI
                CLD
LGTI1:          LODSW                           ; altera s¢ o attr da linha
                MOV     AH, DL
                STOSW
                LOOP    LGTI1
                POP     DS                      ; restaura DS

                POP     ES DI SI DX CX AX
                RET
LIGHT_ITEM      ENDP

;======================================================================
; Nome          UNLIGHT_ITEM
; Descri‡„o     Dessactiva o item corrente
; Retorno       Nunhum
;----------------------------------------------------------------------
UNLIGHT_ITEM    PROC
                PUSH    AX
                MOV     AL, CUR_ITEM            ; desenha o item normalmente
                CALL    DRAW_ITEM
                POP     AX
                RET
UNLIGHT_ITEM    ENDP

;======================================================================
; Nome          DRAW_SCROOL
; Descri‡„o     Desenha a barra de scrool
; Retorno       Nunhum
;----------------------------------------------------------------------
DRAW_SCROOL     PROC
                PUSH    AX DX SI

                MOV     AL, NR_ITENS            ; se o N§ de itens for <= que o
                CMP     AL, SCR_SZ              ; N§ de linhas do ®ecr„¯ ?
                JBE     DRWS4                   ; n„o desenha

                MOV     SI, PALETTE             ; escreve toda a barra
                MOV     AH, [SI].SCRL_BAR
                MOV     DX, 034EH
                MOV     AL, ''
                CALL    XYCH
                MOV     AL, '°'
DRWS2:          INC     DH
                CALL    XYCH
                CMP     DH, 10H
                JB      DRWS2
                INC     DH
                MOV     AL, ''
                CALL    XYCH

                MOV     AL, SCR_SZ - 2          ; calcula a posi‡„o corrente
                MUL     CUR_ITEM
                DIV     NR_ITENS
                OR      AL, AL
                JNZ     DRWS3
                INC     AL

DRWS3:          MOV     AH, [SI].SCRL_BAR_HI    ; e escreve-a
                MOV     DX, 034EH
                ADD     DH, AL
                MOV     AL, 'Û'
                CALL    XYCH

DRWS4:          POP     SI DX AX
                RET
DRAW_SCROOL     ENDP

;======================================================================
; Nome          DRAW_ITENS
; Descri‡„o     Desenha os itens que couberem no ecr„ e ajusta a
;               barra de scrool
; Retorno       Nunhum
;----------------------------------------------------------------------
DRAW_ITENS      PROC
                PUSH    AX CX DX SI

                MOV     AL, SCR_1ST_ITEM        ; come‡a pelo 1§ do ecr„
                MOV     CX, SCR_SZ              ; N§ de itens a escrever
DRWI1:          CALL    DRAW_ITEM               ; desenha-os
                INC     AL
                CMP     AL, NR_ITENS
                JG      DRWI4
                LOOP    DRWI1

DRWI4:          POP     SI DX CX AX
                RET
DRAW_ITENS      ENDP

;======================================================================
; Nome          DRAW_ITEM
; Descri‡„o     Desenha um item (AL)
; Retorno       Nunhum
;----------------------------------------------------------------------
DRAW_ITEM       PROC
                PUSH    AX BX CX DX SI DI

                CALL    PUT_ITEM_DI             ; DI -> dados do item em AL

                MOV     SI, PALETTE             ; limpa a linha
                MOV     AH, [SI].TEXT_LO
                SUB     AL, SCR_1ST_ITEM
                MOV     CX, 302H
                ADD     CH, AL
                MOV     DL, 76
                CALL    CLR_LN

                MOV     CL, 3                   ; dependendo se est  activo
                CMP     [DI].ACTIVE, -1         ; escreve (þ) ou ( )
                JNE     DWI1
                MOV     [CIRCLE$+1], 'þ'
                MOV     AH, [SI].ITEM_HI
                JMP     SHORT DWI2
DWI1:           MOV     [CIRCLE$+1], ' '
                MOV     AH, [SI].ITEM_LO
DWI2:           MOV     DX, OFFSET CIRCLE$
                CALL    XYSTR

                MOV     CL, 8                   ; escreve a descri‡„o
                MOV     DX, DI
                ADD     DX, DESC
                CALL    XYSTR

                MOV     DX, CX                  ; escreve a directoria de destino
                MOV     DL, 50
                MOV     CX, 18
                MOV     SI, DI
                ADD     SI, DIR
DWI3:           LODSB
                CALL    XYCH
                INC     DL
                OR      AL, AL
                JNZ     DWI4
                DEC     SI
DWI4:           LOOP    DWI3

                MOV     DL, 75                  ; escreve o car cter 'K'
                MOV     AL, 'K'
                CALL    XYCH

                MOV     BH, AH                  ; escreve o tamanho
                MOV     AX, [DI].SIZE_KB
                MOV     CL, 5
                SUB     DL, 2
                CALL    WRNUM

                POP     DI SI DX CX BX AX
                RET
DRAW_ITEM       ENDP

;======================================================================
; Nome          BEEP
; Descri‡„o     Faz com que o altifalante emita um BEEP !!!
; Retorno       Nunhum
;----------------------------------------------------------------------
BEEP            PROC
                MOV     AX, 0E07H       ; escreve o car cter 7 em modo TTY
                INT     10H             ; ®escreve¯ o car cter
                RET
BEEP            ENDP

;======================================================================
; Nome          READ_KEY
; Descri‡„o     Esta fun‡„o lˆ a pr¢xima tecla do buffer do teclado, se
;               esta n„o existir, espera que o utilizador pressione uma.
; Retorno       Retoma o valor ASCII da tecla lida em AL, se esta for
;               uma tecla especial, AH conter  o scan code desta e AL
;               ter  o valor ZERO. Se a tecla for uma letra min£scula,
;               esta ser  convertida para mai£scula.
;----------------------------------------------------------------------
READ_KEY        PROC
                XOR     AX, AX          ; lˆ uma tecla
                INT     16h
                OR      AL, AL          ; ‚ especial ?
                JZ      SPECIAL_KEY     ; sim, salta
                XOR     AH, AH          ; apaga o scan-code
                CALL    TOUPPER         ; coloca em mai£scula
SPECIAL_KEY:    RET
READ_KEY        ENDP

;======================================================================
; Nome          TOUPPER
; Descri‡„o     Transforma o caracter ASCII em AL para letra mai£scula
;               se este for min£scula.
; Retorno       Retoma
;----------------------------------------------------------------------
TOUPPER         PROC
                CMP     AL, 61H         ; AL < 'a' ?
                JB      NO1             ; sim, salta
                CMP     AL, 7AH         ; AL > 'z'
                JA      NO1             ; sim, salta
                SUB     AL, 20H         ; converte para mai£scula
NO1:            RET
TOUPPER         ENDP

;======================================================================
; Nome          GOTOXY
; Descri‡„o     Posiciona o cursor nas coordenadas X (DL) , Y (DH)
; Retorno       Nenhum
;----------------------------------------------------------------------
GOTOXY          PROC
                PUSH    AX BX
                XOR     BH, BH          ; p gina 0
                MOV     AH, 2           ; posiciona o cursor
                INT     10h
                POP     BX AX
                RET
GOTOXY          ENDP

;======================================================================
; Nome          COMP_ADDR
; Descri‡„o     Calcula o deslocamento no video da posi‡„o DL=X , DH=Y
; Retorno       ES=VIDADR, DI=Y*160+X*2
;----------------------------------------------------------------------
COMP_ADDR       PROC
                PUSH    AX DX
                MOV     AL, 160         ; N§ DE BYTES POR LINHA
                MUL     DH
                SHL     DL, 1
                ADD     AL, DL
                ADC     AH, 0
                MOV     DI, AX
                MOV     ES, VIDADR
                POP     DX AX
                RET
COMP_ADDR       ENDP

;======================================================================
; Nome          CLR_LN
; Descri‡„o     Limpa uma linha, ou parte; DL=X2, CL=X1, CH=Y, AH=attr
; Retorno       Nenhum
;----------------------------------------------------------------------
CLR_LN          PROC
                PUSH    AX CX DX
                XCHG    CX, DX
                MOV     AL, ' '
CL1:            CALL    XYCH
                INC     DL
                CMP     DL, CL
                JBE     CL1
                POP     DX CX AX
                RET
CLR_LN          ENDP

;======================================================================
; Nome          XYCH
; Descri‡„o     Escreve um car cter (AL) com atributo (AH) em X, Y (DL, DH)
; Retorno       Nenhum
;----------------------------------------------------------------------
XYCH            PROC
                PUSH    ES DI
                CALL    COMP_ADDR
                STOSW
                POP     DI ES
                RET
XYCH            ENDP

;======================================================================
; Nome          XYSTR
; Descri‡„o     Escreve uma string ASCIIZ apontada por DS:DX com o
;               atributo em AH na posi‡„o CL, CH (X, Y)
; Retorno       Nunhum
;----------------------------------------------------------------------
XYSTR           PROC
                PUSH    AX DX SI DI ES
                MOV     SI, DX
                MOV     DX, CX
                CALL    COMP_ADDR
                CLD
XYSTR1:         LODSB
                OR      AL, AL
                JZ      XYSTR2
                STOSW
                JMP     SHORT XYSTR1
XYSTR2:         POP     ES DI SI DX AX
                RET
XYSTR           ENDP

;======================================================================
; Nome          WRNUM
; Descri‡„o     Escreve um numero no ecra.
;               N§=AX, Attr=BH, (DL,DH) = (X,Y) posi‡„o do N¦,
;               N¦ de caracteres a escrever = CL
; Retorno       Nenhum
;--------------------------------------------------------------------
WRNUM           PROC
                PUSH    AX CX DX SI DI ES       ; guarda os registos
                CALL    COMP_ADDR               ; calcula a pos. no video
                STD
                XOR     CH, CH
                MOV     SI, 10                  ; divide por 10
WRN1:           XOR     DX, DX
                DIV     SI                      ; AX=DX:AX/SI  DX=DX:AX%SI
                PUSH    AX                      ; guarda resultado
                MOV     AL, DL                  ; N§ extraido
                ADD     AL, '0'                 ; converte para digito
                MOV     AH, BH                  ; coloca o atributo em AH
                STOSW                           ; escreve o n£mero
                POP     AX                      ; restaura o resultado
                OR      AX, AX                  ; resultado == 0 || CX == 0 ?
                LOOPNE  WRN1                    ; n„o, salta
                JCXZ    WRN2                    ; se CX = 0, salta
                MOV     AL, ' '                 ; preenche o resto com espa‡os
                MOV     AH, BH                  ; com o mesmo atributo
                REP     STOSW
WRN2:           POP     ES DI SI DX CX AX       ; restaura os registos
                RET
WRNUM           ENDP

;======================================================================
; Nome          SHOW_STR
; Descri‡„o     Escreve no ecr„ a string com os dados apontados por DI.
; Retorno       Nenhum
;----------------------------------------------------------------------
SHOW_STR        PROC
                PUSH    AX CX DX SI
                MOV     CX, [DI].STR_ED_SZ
                MOV     DX, [DI].STR_XY
                MOV     SI, [DI].STRING
                ADD     SI, [DI].STR_ED_POS
SHWSTR1:        LODSB
                CALL    XYCH
                INC     DL
                OR      AL, AL
                JNZ     SHWSTR2
                DEC     SI
SHWSTR2:        LOOP    SHWSTR1
                POP     SI DX CX AX
                RET
SHOW_STR        ENDP

;======================================================================
; Nome          EDIT_STR
; Descri‡„o     Faz a edi‡„o da string com os dados apontados por DI.
; Retorno       Nenhum
;----------------------------------------------------------------------
EDIT_STR        PROC
                PUSH    AX BX CX DX SI DI ES

                CLD
                PUSH    DS
                POP     ES
                MOV     SI, [DI].STRING
                CALL    STRLEN
                MOV     STR_SZ, CX
                MOV     BX, PALETTE

EDSTR1:         MOV     AH, [BX].CUR_TEXT
                CALL    SHOW_STR
                MOV     DX, [DI].STR_XY
                MOV     AX, [DI].STR_POS
                SUB     AX, [DI].STR_ED_POS
                ADD     DL, AL
                CALL    GOTOXY
EDSTR3:         CALL    READ_KEY

                MOV     SI, OFFSET EDIT_JMP
                CALL    KEY_JMP

; HOME
EDSTR4:         MOV     WORD PTR [DI].STR_POS, 0
                MOV     WORD PTR [DI].STR_ED_POS, 0
                JMP     SHORT EDSTR1

; END
EDSTR5:         MOV     SI, STR_SZ
                MOV     [DI].STR_POS, SI
                MOV     AX, [DI].STR_ED_SZ
                DEC     AX
                SUB     SI, AX
                JNS     EDSTR5A
                XOR     SI, SI
EDSTR5A:        MOV     [DI].STR_ED_POS, SI
                JMP     SHORT EDSTR1

; LEFT
EDSTR6:         CMP     [DI].STR_POS, 0
                JE      EDSTR3
                DEC     [DI].STR_POS
                MOV     AX, [DI].STR_POS
                CMP     AX, [DI].STR_ED_POS
                JGE     EDSTR1
                DEC     [DI].STR_ED_POS
EDSTR6A:        JMP     SHORT EDSTR1

; RIGHT
EDSTR7:         MOV     AX, [DI].STR_POS
                CMP     AX, STR_SZ
                JGE     EDSTR3
                INC     [DI].STR_POS
                INC     AX
                SUB     AX, [DI].STR_ED_POS
                CMP     AX, [DI].STR_ED_SZ
                JB      EDSTR1
                INC     [DI].STR_ED_POS
EDSTR7A:        JMP     SHORT EDSTR6A

; BACKSPACE
EDSTR8:         CMP     [DI].STR_POS, 0
                JE      EDSTR3
                DEC     [DI].STR_POS
                CALL    DEL_CHAR
                MOV     AX, [DI].STR_POS
                CMP     AX, [DI].STR_ED_POS
                JNE     EDSTR7A
                OR      AX, AX
                JZ      EDSTR7A
                DEC     [DI].STR_ED_POS
                JMP     SHORT EDSTR7A

EDSTR3A:        JMP     EDSTR3

; DEL
EDSTR9:         MOV     AX, [DI].STR_POS
                CMP     AX, STR_SZ
                JGE     EDSTR3A
                CALL    DEL_CHAR
                JMP     SHORT EDSTR7A

EDSTR11:        CMP     AX, 32
                JB      EDSTR3A
                CMP     AX, 0FFH
                JG      EDSTR3A

                MOV     SI, STR_SZ
                CMP     SI, [DI].STR_MAX_SZ
                JE      EDSTR3A
                INC     STR_SZ

                PUSH    DI
                MOV     SI, [DI].STRING
                ADD     SI, [DI].STR_POS
                MOV     DI, SI
                XCHG    AH, AL
EDSTR3C:        LODSB
                XCHG    AH, AL
                STOSB
                OR      AL, AL
                JNZ     EDSTR3C
                POP     DI
                JMP     EDSTR7

EDSTR10:        MOV     AH, [BX].TEXT_HI
                CALL    SHOW_STR
                POP     ES DI SI DX CX BX AX
                RET
EDIT_STR        ENDP

DEL_CHAR        PROC
                PUSH    DI
                MOV     SI, [DI].STRING
                ADD     SI, [DI].STR_POS
                MOV     DI, SI
                INC     SI
                CALL    COPYZ
                POP     DI
                DEC     STR_SZ
                RET
DEL_CHAR        ENDP

;======================================================================
; Nome          STATUS_CURSOR
; Descri‡„o     Escreve texto na linha de STATUS (DX = offset da string)
;               e coloca o cursor no fim da linha
; Retorno       Nenhum
;----------------------------------------------------------------------
STATUS_CURSOR   PROC
                PUSH    CX DX SI
                CALL    STATUS
                MOV     SI, DX
                CALL    STRLEN
                MOV     DL, CL
                MOV     DH, 24
                CALL    GOTOXY
                POP     SI DX CX
                RET
STATUS_CURSOR   ENDP

;======================================================================
; Nome          STATUS
; Descri‡„o     Escreve texto na linha de STATUS (DX = offset da string)
; Retorno       Nenhum
;----------------------------------------------------------------------
STATUS          PROC
                PUSH    AX CX SI
                PUSH    DX
                MOV     SI, PALETTE
                MOV     BYTE PTR AH, [SI].STAT
                MOV     CX, 1800H
                MOV     DL, 4FH
                CALL    CLR_LN
                POP     DX
                CALL    XYSTR
                POP     SI CX AX
                RET
STATUS          ENDP

;======================================================================
; Nome          BOX
; Descri‡„o     Desenha uma caixa nas coordenadas :
;               (X1, Y1) -- (CL, CH)    (X2, Y2) -- (DL, DH)
;               ATTR -- AH
; Retorno       Nenhum
;----------------------------------------------------------------------
BOX             PROC
                PUSH    AX BX DX
                MOV     BX, DX

                MOV     DL, CL
                MOV     AL, 'Ä'
BX1:            INC     DL
                MOV     DH, CH
                CALL    XYCH
                MOV     DH, BH
                CALL    XYCH
                CMP     DL, BL
                JB      BX1

                MOV     DH, CH
                MOV     AL, '³'
BX2:            INC     DH
                MOV     DL, CL
                CALL    XYCH
                MOV     DL, BL
                CALL    XYCH
                CMP     DH, BH
                JB      BX2

                MOV     DX, CX
                MOV     AL, 'Ú'
                CALL    XYCH

                MOV     DL, BL
                MOV     AL, '¿'
                CALL    XYCH

                MOV     DX, BX
                MOV     AL, 'Ù'
                CALL    XYCH

                MOV     DL, CL
                MOV     AL, 'À'
                CALL    XYCH

                POP     DX BX AX
                RET
BOX             ENDP

;======================================================================
; Nome          UNZIP
; Descri‡„o     executa o programa PKUNZJR.
; Retorno       nenhum
;----------------------------------------------------------------------
UNZIP           PROC
                PUSH    AX BX CX DX SI DI ES

                PUSH    DS                      ; ES = DS
                POP     ES

                MOV     BX, DI

                MOV     SI, OFFSET WAIT$        ; cria a mensagem de status
                MOV     DI, OFFSET WORK_STR
                CALL    COPYZ
                MOV     SI, DI
                MOV     DI, BX
                ADD     DI, ZIPFILE
                CALL    STRCAT
                MOV     DI, OFFSET ESC_ABORT$
                CALL    STRCAT
                MOV     DX, SI
                CALL    STATUS_CURSOR           ; e escreve-a

                MOV     SI, OFFSET OVR_OPT      ; cria a linha de comandos para
                MOV     DI, OFFSET TAIL_LN      ; o PKUNZJR.COM
                CALL    COPYZ
                MOV     SI, DI
                MOV     DI, OFFSET PROG_PATH
                CALL    STRCAT
                MOV     DI, BX
                ADD     DI, ZIPFILE
                CALL    STRCAT
                MOV     DI, OFFSET SPACE
                CALL    STRCAT
                MOV     DI, BX
                ADD     DI, DIR
                CALL    STRCAT
                CALL    STRLEN
                MOV     BX, CX
                MOV     BYTE PTR [SI+BX], 13
                MOV     TAIL_SZ, CL

                PUSH    DS                      ; executa o PKUNZJR.COM
                MOV     STK_SEG, SS
                MOV     STK_PTR, SP
                MOV     DX, OFFSET CNAME
                MOV     BX, OFFSET PARS
                MOV     AX, 4B00H
                INT     21H

                CLI                             ; restaura a pilha
                MOV     SS, STK_SEG
                MOV     SP, STK_PTR
                STI
                POP     DS

                POP     ES DI SI DX CX BX AX
                RET
UNZIP           ENDP

;======================================================================
; Nome          STRLEN
; Descri‡„o     Retoma o tamanho da string apontada por DS:SI.
; Retorno       CX=N§ de caracteres da string
;----------------------------------------------------------------------
STRLEN          PROC
                PUSH    AX SI
                XOR     CX, CX
                CLD
STRLEN1:        LODSB
                OR      AL, AL
                JZ      STRLEN2
                INC     CX
                JMP     SHORT STRLEN1
STRLEN2:        POP     SI AX
                RET
STRLEN          ENDP

;======================================================================
; Nome          STRCAT
; Descri‡„o     Adiciona a string em ES:DI … apontada por DS:SI.
; Retorno       Nenhum
;----------------------------------------------------------------------
STRCAT          PROC
                PUSH    CX SI
                CALL    STRLEN
                ADD     SI, CX
                XCHG    SI, DI
                CALL    COPYZ
                MOV     DI, SI
                POP     SI CX
                RET
STRCAT          ENDP

;======================================================================
; Nome          COPYZ
; Descri‡„o     Copia a string em DS:SI para ES:DI.
; Retorno       Nenhum
;----------------------------------------------------------------------
COPYZ           PROC
                PUSH    AX SI DI
                CLD
CPZ1:           LODSB
                STOSB
                OR      AL, AL
                JNZ     CPZ1
                POP     DI SI AX
                RET
COPYZ           ENDP

;======================================================================
; Nome          STRUPR
; Descri‡„o     Transforma uma string (DS:DX) em mai£sculas
; Retorno       Nenhum
;----------------------------------------------------------------------
STRUPR          PROC
                PUSH    AX SI DI ES
                CLD
                MOV     SI, DX
                MOV     DI, SI
                PUSH    DS
                POP     ES
SUP1:           LODSB
                CALL    TOUPPER
                STOSB
                OR      AL, AL
                JNZ     SUP1
                POP     ES DI SI AX
                RET
STRUPR          ENDP

;======================================================================
; Nome          SHOW_USED
; Descri‡„o     Escreve no ecr„ o espa‡o ocupado pelos prog. a instalar
; Retorno       Nenhum
;----------------------------------------------------------------------
SHOW_USED       PROC
                PUSH    AX BX CX DX SI DI

                XOR     AX, AX
                MOV     CL, NR_ITENS
                XOR     CH, CH
                MOV     DI, OFFSET ITENS
SHU1:           CMP     [DI].ACTIVE, -1
                JNE     SHU2
                ADD     AX, [DI].SIZE_KB
SHU2:           ADD     DI, ITEM_SZ
                LOOP    SHU1

                MOV     DX, 1349H
                MOV     CL, 4
                MOV     SI, PALETTE
                MOV     BH, [SI].TEXT_HI
                CALL    WRNUM

                POP     DI SI DX CX BX AX
                RET
SHOW_USED       ENDP

;======================================================================
; Nome          FEXIST
; Descri‡„o     Verifica a existˆncia do ficheiro com o nome na string
;               apontada por DS:DX.
; Retorno       CARRY=1 se n„o existir, caso contr rio CARRY=0
;----------------------------------------------------------------------
FEXIST          PROC
                PUSH    AX BX
                MOV     AX, 3D00H
                INT     21H
                JC      FEX1
                MOV     BX, AX
                MOV     AH, 3EH
                INT     21H
FEX1:           POP     BX AX
                RET
FEXIST          ENDP

;======================================================================
; Nome          READ_LINE
; Descri‡„o     Lˆ uma linha de texto com o m ximo de SI caracteres
;               para um buffer apontado por DS:DX de um ficheiro com
;               o handle em BX
; Retorno       CARRY=1 se EOF for encontrado, caso contr rio CARRY=0
;----------------------------------------------------------------------

GETCHAR         PROC
                MOV     AH, 3FH                 ; lˆ caracteres de um handle
                MOV     CX, 1                   ; N§ de caracteres a ler
                PUSH    DX                      ; guarda DX
                MOV     DX, OFFSET CHAR         ; buffer para colocar os carac.
                INT     21H
                POP     DX                      ; restaura DX
                JNC     GC1                     ; se n„o houve erro, salta
                JMP     DATA_READ_ERR           ; caso contrario, termina
GC1:            OR      AX, AX                  ; leu algum car cter ?
                JNZ     GC2                     ; sim, salta
                ADD     SP, 2                   ; n„o, salta o ret desta fun‡„o
                STC                             ; e sinaliza EOF
                JMP     SHORT RL4               ; salta para o fim de READ_LINE
GC2:            RET
GETCHAR         ENDP

READ_LINE       PROC
                PUSH    AX CX SI DI             ; guarda os registos utilizados
                MOV     DI, DX                  ; buffer de dados em DI
RL1:            CALL    GETCHAR                 ; lˆ um car cter do ficheiro
                CMP     CHAR, 13                ; chegamos ao fim da linha ?
                JE      RL3                     ; sim, salta
                CMP     CHAR, '*'               ; linha de comentario ?
                JNE     RL5                     ; n„o, salta
                CMP     DI, DX                  ; sim, ‚ o 1§ car cter da linha?
                JE      RL2                     ; sim, ent„o ‚ um comentario
RL5:            MOV     AL, CHAR                ; coloca o car cter no buffer
                MOV     BYTE PTR [DI], AL
                INC     DI                      ; pr¢xima posi‡„o do buffer
                DEC     SI                      ; N§ de bytes que falta ler
                JNZ     RL1                     ; se n„o for 0, lˆ novo car cter
RL2:            CALL    GETCHAR                 ; lˆ o resto da linha, at‚ CR LF
                CMP     CHAR, 13                ; ‚ um CR ?
                JNE     RL2                     ; n„o, lˆ o pr¢ximo
RL3:            CALL    GETCHAR                 ; passa o LF
                CMP     DI, DX                  ; se ‚ uma linha ®branca¯
                JE      RL1                     ; lˆ a pr¢xima
                CLC                             ; ainda n„o foi EOF
RL4:            MOV     BYTE PTR [DI], 0        ; marca o fim da string lida
                POP     DI SI CX AX             ; restaura os registos usados
                RET
READ_LINE       ENDP
                    
                .DATA
;----------------------------------------------------------------------
; Mensagens v rias a dar ao utilizador
;----------------------------------------------------------------------
ERR_DOS_VER$    DB      'ERRO: necess ria a vers„o 3.2 ou superior do DOS.$'
ERR_BAD_ENV$    DB      'ERRO: ambiente currompido.$'
REALOC_ERR$     DB      'ERRO: realoca‡„o de mem¢ria falhada.$'
DATA_READ_ERR$  DB      'ERRO: ao ler o ficheiro INSTALA.DAT$'
BAD_EOF$        DB      'ERRO: ficheiro INSTALA.DAT incompleto.$'
NO_PKUNZJR$     DB      'ERRO: O ficheiro PKUNZJR.COM n„o se encontra presente.$'
NO_INST_DATA$   DB      'ERRO: O ficheiro INSTALA.DAT n„o se encontra presente.$'
FILES_MISS$     DB      'ERRO: Nenhum dos ficheiros ZIP definidos no INSTALA.DAT foi encontrado.$'
COPYRIGHT$      DB      10, 'INSTALA 1.0 por Carlos Ladeira , 18/12/93', 13, 10, '$'

MESS2$          DB      'Espa‡o ocupado pelos itens selecionados para instala‡„o:', 0

INST_BUT$       DB      ' INSTALA ', 0
CANC_BUT$       DB      ' CANCELA ', 0
DESC_HDR$       DB      ' DESCRI€ŽO DO ITEM ', 0
DIRE_HDR$       DB      ' DIRECTORIA DESTINO ', 0

CIRCLE$         DB      '(þ)', 0

CANC_STAT$      DB      ' ENTER para terminar o programa ou TAB para selecionar itens', 0
INST_STAT$      DB      ' ENTER para instalar os itens selecionados ou TAB para cancelar', 0
SELE_STAT$      DB      ' ESPA€O - on/off,  - movimentar, ENTER - editar dir, TAB - para instalar', 0
EDIT_STAT$      DB      ' ENTER - ok,  HOME END - movimentar', 0
WAIT$           DB      ' Procedendo … descompacta‡„o do ficheiro: ', 0
UNZIP_ERR$      DB      ' Erro ao descompactar. Pressione uma tecla para continuar.', 0
UNZIP_OK$       DB      ' Instala‡„o completa. Pressione uma tecla para continuar', 0
NO_SPACE$       DB      ' Espa‡o insuficiˆnte para descomprimir o ficheiro: ', 0
ESC_ABORT$      DB      ', ESC para abortar', 0

;----------------------------------------------------------------------
; Variaveis v rias
;----------------------------------------------------------------------
INST_DATA       DB      'INSTALA.DAT', 0
FILES_MISSING   DB      0
CHAR            DB      ?
STR_SZ          DW      ?
PSP             DW      ?

; estrutura de dados necess ria para editar uma string
ED_STR_DATA     STRUC
STRING          DW      ?               ; ponteiro para a string
STR_MAX_SZ      DW      ?               ; tamanho m ximo da string
STR_POS         DW      ?               ; posi‡„o de edi‡„o na string
STR_ED_SZ       DW      ?               ; tamanho da ®janela¯ de edi‡„o
STR_ED_POS      DW      ?               ; ptr para o 1§ car cter da ®janela¯
STR_XY          DW      ?               ; posi‡„o (X, Y) da ®janela¯
ED_STR_DATA     ENDS

W_PATH          ED_STR_DATA     <?, 80, 0, 18, 0, ?>

;----------------------------------------------------------------------
; Rotinas referentes … correspondencia entre teclas e as respec. fun‡”es
;----------------------------------------------------------------------
KBS             EQU     0008H           ; backspace
KTAB            EQU     0009H           ; tab
KCR             EQU     000DH           ; enter
KESC            EQU     001BH           ; escape
KSP             EQU     0020H           ; espa‡o
KUP             EQU     4800H           ; cursor a cima
KDOWN           EQU     5000H           ; cursor a baixo
KLEFT           EQU     4B00H           ; cursor … esquerda
KRIGHT          EQU     4D00H           ; cursor … direita
KHOME           EQU     4700H           ; home
KEND            EQU     4F00H           ; end
KDEL            EQU     5300H           ; del

JMP_DATA        STRUC
KEY_CODE        DW      ?
LOCATION        DW      ?
JMP_DATA        ENDS

; para selecao de itens
SELI_JMP        JMP_DATA        <  KSP, SELI2>
                JMP_DATA        <  KUP, SELI3>
                JMP_DATA        <KDOWN, SELI4>
                JMP_DATA        < KTAB, SELI5>
                JMP_DATA        <  KCR, SELI6>
                JMP_DATA        <   -1, SELI1>

; para a edi‡„o de strings
EDIT_JMP        JMP_DATA        < KHOME, EDSTR4>
                JMP_DATA        <  KEND, EDSTR5>
                JMP_DATA        < KLEFT, EDSTR6>
                JMP_DATA        <KRIGHT, EDSTR7>
                JMP_DATA        <   KBS, EDSTR8>
                JMP_DATA        <  KDEL, EDSTR9>
                JMP_DATA        <   KCR, EDSTR10>
                JMP_DATA        <    -1, EDSTR11>

;----------------------------------------------------------------------
; Rotinas referentes ao video
;----------------------------------------------------------------------
OLD_PAG         DB      ?
OLD_MODE        DB      ?
OLD_CUR_SZ      DW      ?
VIDADR          DW      0B000h          ; in¡cio da RAM video para MDA e HGC

COLORS          STRUC
TITL            DB      ?
STAT            DB      ?
TEXT_LO         DB      ?
TEXT_HI         DB      ?
CUR_TEXT        DB      ?
FRAMES          DB      ?
SCRL_BAR        DB      ?
SCRL_BAR_HI     DB      ?
ITEM_HI         DB      ?
ITEM_LO         DB      ?
COLORS          ENDS

COLOR_PAL       COLORS  <31H, 3BH, 70H, 7EH, 3FH, 71H, 1FH, 2FH, 74H, 78H>
B&W_PAL         COLORS  <0FH, 0FH, 70H, 7FH, 07H, 70H, 07H, 70H, 71H, 70H>
PALETTE         DW      OFFSET B&W_PAL

;----------------------------------------------------------------------
; Rotinas referentes ao shell feito ao PKUNZJR
;----------------------------------------------------------------------
PKUNZJR         DB      'PKUNZJR.COM', 0
OVR_OPT         DB      '-O ', 0
SPACE           DB      ' ', 0

STK_SEG         DW      ?               ; para gravar o conteudo do SS
STK_PTR         DW      ?               ; para gravar o conteudo do SP

PARS            DW      CHILD_ENV       ; environment block
                DD      TAIL            ; linha de comandos (far pointer)
                DD      FCB1            ; FCB #1 (far pointer)
                DD      FCB2            ; FCB #2 (far pointer)

CHILD_ENV       DW      0               ; environment string sem nada definido

CNAME           DB      80 DUP(0)       ; pathname para o PKUNZJR.COM

TAIL            LABEL   BYTE
TAIL_SZ         DB      ?               ; tamanho da linha de comandos
TAIL_LN         DB      80H DUP(?)      ; linha de comandos, esta deve
                                        ; terminar SEMPRE com um CR
                
FCB1            DB      0               ; FCB #1
                DB      11 DUP(' ')
                DB      25 DUP(0)

FCB2            DB      0               ; FCB #2
                DB      11 DUP(' ')
                DB      25 DUP(0)

;----------------------------------------------------------------------
; Dados referentes aos itens a instalar
;----------------------------------------------------------------------
NR_ITENS        DB      0
CUR_ITEM        DB      1
SCR_1ST_ITEM    DB      1
SCR_SZ          EQU     15

ITEM            STRUC
DESC            DB      41 DUP(?)
DIR             DB      81 DUP(?)
ZIPFILE         DB      13 DUP(?)
SIZE_KB         DW      ?
ACTIVE          DB      ?
ITEM            ENDS

ITEM_SZ         EQU     41 + 81 + 13 + 2 + 1
MAX_ITENS       EQU     100
STK_SZ          EQU     512

;----------------------------------------------------------------------
; As variaveis daqui para a frente s¢ s„o alocadas quando o programa for
; executado. Assim, poupa-se quase 14KB no executavel
;----------------------------------------------------------------------
PROG_PATH       =       $
WORK_STR        =       PROG_PATH + 81
PROG_TITLE      =       WORK_STR + 81
ITENS           =       PROG_TITLE + 81
STK             =       ITENS + MAX_ITENS * ITEM_SZ
STK_TOP         =       STK + STK_SZ

                END   START

