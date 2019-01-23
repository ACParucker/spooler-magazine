
;       unzip.asm
;       rotinas utilizadas na descompacta‡„o

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data?
                EXTRN   PkunzjrPath, CurrDir, ProgPath, MouseLeft:BYTE
                EXTRN   MouseRight:BYTE, Items, PSP:WORD, NrItems:BYTE
                EXTRN   tmpstr, CurrItem:BYTE, Scr1stItem:BYTE
                EXTRN   BasePath:NEAR

TAIL            LABEL   BYTE
TAIL_SZ         DB      ?               ; tamanho da linha de comandos
TAIL_LN         DB      80H DUP(?)      ; linha de comandos, esta deve
                                        ; terminar SEMPRE com um CR

STK_SEG         DW      ?               ; para gravar o conteudo do SS
STK_PTR         DW      ?               ; para gravar o conteudo do SP

LastAtMiddle    DB      ?

                .data
                EXTRN   ForceNewID:BYTE, Slash, ZIPS_dir$

WAIT$           DB      ' Procedendo … descompacta‡„o do ficheiro: ', 0
UNZIP_ERR$      DB      ' Erro ao descompactar. Pressione uma tecla para continuar.', 0
UNZIP_OK$       DB      ' Instala‡„o completa. Pressione uma tecla para continuar', 0
NO_SPACE$       DB      ' Espa‡o insuficiˆnte para descomprimir o ficheiro: ', 0
ESC_ABORT$      DB      ', ESC para abortar', 0

OVR_OPT         DB      '-O ', 0
SPACE           DB      ' ', 0

PARS            DW      CHILD_ENV       ; environment block
                DD      TAIL            ; linha de comandos (far pointer)
                DD      FCB1            ; FCB #1 (far pointer)
                DD      FCB2            ; FCB #2 (far pointer)

CHILD_ENV       DW      0               ; environment string sem nada definido

FCB1            DB      0               ; FCB #1
                DB      11 DUP(' ')
                DB      25 DUP(0)

FCB2            DB      0               ; FCB #2
                DB      11 DUP(' ')
                DB      25 DUP(0)

                .code
                EXTRN   StrCat:NEAR, StrCopy:NEAR, KeyHit:NEAR, ReadKey:NEAR
                EXTRN   StatusCursor:NEAR, Status:NEAR, DrawItems:NEAR
                EXTRN   ShowUsed:NEAR, Beep:NEAR, MakeTargetDir:NEAR
                EXTRN   LastChar:NEAR, StrLen:NEAR, LightItem:NEAR
                EXTRN   GetMouseState:NEAR, GotoXY:NEAR

                PUBLIC  Instala

; GetKeyOrMouse lˆ input do utilizador
; parƒmetros    nenhum
; retorno       CARRY=0 se n„o houve input
;               CARRY=1 se houve input
;                 AX=tecla se for premida alguma
;                 AX=k_ENTER se for premido o bot„o esquerdo do rato
;                 AX=k_ESC se for premido o bot„o direito do rato
GetKeyOrMouse   PROC
                call    GetMouseState
                mov     ax, k_ENTER
                test    MouseLeft, 1
                jnz     @@done
                mov     ax, k_ESC
                test    MouseRight, 1
                jnz     @@done
                call    KeyHit
                jnc     @@no_input
                call    ReadKey
@@done:         stc
@@no_input:     ret
GetKeyOrMouse   ENDP

;======================================================================
; Nome          INSTALA
; Descri‡„o     Instala os itens selecionados
; Retorno       nenhum
;----------------------------------------------------------------------
INSTALA         PROC
                push    ax cx dx si di

                mov     al, NrItems
                sub     al, 5
                mov     LastAtMiddle, al
                mov     CurrItem, 1
                mov     Scr1stItem, 1

                push    es
                MOV     ES, PSP                 ; sem utilizar o DOS, simula o
                MOV     BYTE PTR ES:[19H], 0FFH ; fecho do STDOUT para que o
                pop     es                      ; output do PKUNZJR n„o sˆja
                                                ; visivel

                MOV     CL, NrItems             ; CX = N§ de itens
                XOR     CH, CH
                MOV     DI, OFFSET ITEmS        ; DI -> dados do 1§ item

INST3:          call    GetKeyOrMouse
                jnc     Inst3a
                CMP     AX, k_ESC               ; ‚ ESCAPE ?
                JNE     INST3                   ; n„o, salta
                call    DrawItems
                JMP     SHORT INST5             ; sim, termina

INST3A:         call    DrawItems
                call    LightItem
                call    ShowUsed

                CMP     [DI].ACTIVE, -1         ; est  activo ?
                JNE     INST4                   ; n„o, salta
                CALL    CHECK_SIZE              ; verifica se tem espa‡o para instalar
                JC      INST8                   ; se n„o couber, salta
                CALL    MAKE_DIRS               ; sim, cria as directorias
                JC      INST7                   ; se houve erro, salta
                CALL    UNZIP                   ; descomprime o ficheiro
                JC      INST7                   ; se houve erro, salta
                NOT     [DI].ACTIVE             ; depois de instalado, desactiva-se
INST4:          ADD     DI, ITEM_SZ             ; DI -> pr¢ximo item
                mov     al, CurrItem
                cmp     al, NrItems
                je      @@dont_inc
                cmp     NrItems, 9
                jbe     @@no_calc
                cmp     al, 5
                jb      @@no_calc
                cmp     al, LastAtMiddle
                ja      @@no_calc
                inc     Scr1stItem
@@no_calc:      inc     CurrItem
@@dont_inc:     LOOP    INST3                   ; instala o pr¢ximo item

                call    DrawItems
                MOV     DX, OFFSET UNZIP_OK$    ; mensagem de status
                CALL    STATUSCURSOR            ; mostra-a
                CALL    BEEP
@@read_input1:  call    GetKeyOrMouse
                jnc     @@read_input1
                mov     ForceNewID, CANCEL_BUT_ID

INST5:          push    es
                MOV     ES, PSP                 ; reabre o STDOUT alterando o
                MOV     BYTE PTR ES:[19H], 1    ; 2§ byte da tabela de handles
                pop     es
                pop     di si dx cx ax
                RET                             ; e termina

INST7:          MOV     DX, OFFSET UNZIP_ERR$   ; em caso de erro
                CALL    STATUSCURSOR            ; mostra a mensagem de erro
                CALL    DRAWITEMS
                CALL    SHOWUSED
                CALL    BEEP                    ; faz ouvir um beep
@@read_input2:  call    GetKeyOrMouse
                jnc     @@read_input2
                jmp     inst5

INST8:          PUSH    SI DI                   ; guarda os registos
                MOV     DX, DI                  ; endere‡o dos dados do item
                MOV     SI, OFFSET NO_SPACE$    ; cria a string a informar
                MOV     DI, OFFSET tmpstr       ; o utilizador que n„o existe
                CALL    StrCOPY                 ; espa‡o suficiente para
                MOV     SI, DI                  ; descompactar o resp‚ctivo
                MOV     DI, DX                  ; ficheiro
                ADD     DI, ZIPFILE
                CALL    STRCAT
                MOV     DI, OFFSET ESC_ABORT$
                CALL    STRCAT
                MOV     DX, SI
                POP     DI SI
                CALL    STATUSCURSOR            ; mostra-a
                CALL    BEEP
@@read_input3:  call    GetKeyOrMouse
                jnc     @@read_input3
                CMP     AX, k_ESC               ; ‚ ESCAPE
                Jne     INST4                   ; n„o, continua
                call    DrawItems
                Jmp     INST5                   ; sim, termina
                JMP     INST4                   ; n„o, continua
INSTALA         ENDP

;======================================================================
; Nome          CHECK_SIZE
; Descri‡„o     Verifica o espa‡o para instala‡„o do item apontado por DI.
; Retorno       Nunhum
;----------------------------------------------------------------------
CHECK_SIZE      PROC
                PUSH    AX BX CX DX SI          ; guarda o conteudo dos regs
                XOR     DL, DL                  ; drive = 0 (omiss„o)
                MOV     SI, DI                  ; SI -> path de destino
                ADD     SI, Directory
                CMP     BYTE PTR [SI + 1], ':'  ; tem drive ?
                JE      CHKSZ1                  ; tem, salta
                mov     si, OFFSET BasePath
CHKSZ1:         mov     dl, [si]
                sub     dl, 'A'-1
                MOV     AH, 36H                 ; determina o espa‡o livre
                INT     21H                     ; utilizando o DOS
                MUL     CX                      
                MUL     BX                      ; DX:AX = N§ de bytes livres

             ; seguidamente, o n£mero em DX:AX vai ser rodado para a direita
             ; 10 bits o que equivale a dividi-lo por 1024

             ;         DX               AX
             ;  ???????????????? ??????xxxxxxxxxx
             ;                         |-------->|
             ;  |-------->|
             ;  xxxxxxxxxx?????? ????????????????
             ;  

                MOV     BX, DX                  ; guarda o conteudo de DX em BX
                SHR     AX, 10                  ; desloca AX
                SHR     DX, 10                  ; desloca DX
                ROR     BX, 10                  ; roda BX
                AND     BX, 1111111111000000B   ; aproveita os 10 bits mais sign.
                ADD     AX, BX                  ; coloca-os em AX
                ADC     DX, 0                   ; ajusta DX em caso de overflow

                OR      DX, DX                  ; mais que 64 Mb ?
                JNZ     CHKSZ2                  ; sim, salta
                CMP     AX, [DI].SizeKB         ; n„o, maior que o espa‡o pretendido ?
                JA      CHKSZ2                  ; sim, salta
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
                PUSH    AX BX DX SI             ; guarda registos

                CALL    MakeTargetDir
                MOV     SI, OFFSET CurrDir
                MOV     DX, SI                  ; inicio da dir
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
                JC      MKD4                    ; se houve erro, salta
                MOV     BYTE PTR [SI-1], '\'    ; restaura a '\'
                JMP     SHORT MKD2              ; faz o loop

MKD3:           call    MDir
MKD4:           POP     SI DX BX AX             ; restaura os registos
                RET
MAKE_DIRS       ENDP

;======================================================================
; Nome          UNZIP
; Descri‡„o     executa o programa PKUNZJR para o item em DI.
; Retorno       nenhum
;----------------------------------------------------------------------
UNZIP           PROC
                PUSH    AX BX CX DX SI DI ES

                PUSH    DS                      ; ES = DS
                POP     ES

                MOV     BX, DI

                MOV     SI, OFFSET WAIT$        ; cria a mensagem de status
                MOV     DI, OFFSET tmpstr
                CALL    StrCOPY
                MOV     SI, DI
                MOV     DI, BX
                ADD     DI, ZIPFILE
                CALL    STRCAT
                MOV     DI, OFFSET ESC_ABORT$
                CALL    STRCAT
                MOV     DX, SI
                CALL    STATUSCURSOR            ; e escreve-a

                MOV     SI, OFFSET OVR_OPT      ; cria a linha de comandos para
                MOV     DI, OFFSET TAIL_LN      ; o PKUNZJR.COM
                CALL    StrCOPY
                MOV     SI, DI
                MOV     DI, OFFSET PROGPATH
                CALL    STRCAT
                mov     di, OFFSET ZIPS_dir$
                call    StrCat
                MOV     DI, BX
                ADD     DI, ZIPFILE
                CALL    STRCAT
                MOV     DI, OFFSET SPACE
                CALL    STRCAT
                MOV     DI, BX
                CALL    MAKETARGETDIR
                MOV     DI, OFFSET CurrDir
                CALL    STRCAT
                CALL    LASTCHAR
                CMP     AL, '\'
                JE      UNZ01
                MOV     DI, OFFSET SLASH
                CALL    STRCAT
UNZ01:          CALL    STRLEN
                MOV     BX, CX
                MOV     BYTE PTR [SI+BX], 13
                MOV     TAIL_SZ, CL

                PUSH    DS                      ; executa o PKUNZJR.COM
                MOV     STK_SEG, SS
                MOV     STK_PTR, SP
                MOV     DX, OFFSET PkunzjrPath
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

                end
