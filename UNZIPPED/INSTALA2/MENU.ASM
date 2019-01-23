
;       menu.asm
;       main programam loop

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data?
                PUBLIC  ScroolPos
                EXTRN   ProgTitle, VGA, Palette, Items, tmpstr, BasePath
                EXTRN   Scr1stItem:BYTE, NrItems:BYTE, CurrItem:BYTE
                EXTRN   MouseXPos:BYTE, MouseYPos:BYTE, CurrDir
NewEvent        InputEvent      <?>
ScroolPos       DB              ?

                .data
                EXTRN   TxtPal, Targets, BaseDirStr:EditData
                PUBLIC  Quit, INST_BUT$, CANC_BUT$, ForceNewID, Slash

CurrID          DB      ITEMS_BOX_ID
ForceNewID      DB      0
Quit            DB      0
MESS1$          DB      'Espa‡o ocupado pelos items seleccionados para instala‡„o:', 0
MESS2$          DB      'Directoria de destino:', 0
MESS3$          DB      'Directoria base:', 0
INST_BUT$       DB      ' INSTALA ', 0
CANC_BUT$       DB      ' TERMINA ', 0
TITLE1$         DB      'Descri‡„o do Item', 0
TITLE2$         DB      'Tamanho', 0
YOPE$           DB      '(þ)', 0
NOPE$           DB      '( )', 0
Slash           DB      '\',0

                .code
                EXTRN   ReadKey:NEAR, Pause:NEAR, XYStr:NEAR, XYChar:NEAR
                EXTRN   StrLen:NEAR, Box:NEAR, ClearLine:NEAR, FadeIn:NEAR
                EXTRN   InitMouse:NEAR, MouseShow:NEAR, MouseHide:NEAR
                EXTRN   StrCat:NEAR, XYNumber:NEAR, GotoXY:NEAR, Beep:NEAR
                EXTRN   ComputeAddr:NEAR, LastChar:NEAR, GetInput:NEAR
                EXTRN   SHOW_STR:NEAR, KeyHit:NEAR

                PUBLIC  Menu, PutItemDI, LightItem, UnlightItem
                PUBLIC  DrawItems, DrawItem, DrawTargetDir, ClearTargetDir
                PUBLIC  MakeTargetDir, ShowUsed, DrawScrool

Menu            PROC
                push    ax bx dx si             ; salva os registos utilizados
                call    ShowScreen              ; desenha o ecr„
                call    InitMouse               ; inicializa o rato
                call    MouseShow               ; mostra o cursor do rato

@@clear_kbd:    call    KeyHit
                jnc     @@cleared
                call    ReadKey
                jmp     @@clear_kbd

@@cleared:      mov     si, OFFSET NewEvent     ; si->estrutura newevent
@@new_event:    mov     al, INPUT_TARGET_SZ     ; tamanho da estrutura
                mov     ah, CurrID              ; ID corrente em ah
                dec     ah                      ; converte para zero-satrt
                mul     ah                      ; determina o offset do ID corrente
                mov     bx, OFFSET Targets      ; bx=offset do primeiro ID
                add     bx, ax                  ; offset final
                call    [bx].StartRtn           ; chama rotina de inicializa‡„o

@@get_event:
                test    Quit, 1                 ; testa a flag QUIT
                jnz     @@end                   ; se estiver a um, salta
                cmp     ForceNewID, 0           ; existe algum evento for‡ado ?
                jne     @@forced_id             ; yep, salta
                call    GetInput                ; lˆ input do utilizador
                jnc     @@get_event             ; se n„o houve input, salta

                mov     al, [si].EventType      ; guarda o tipo de evento
                mov     ah, [si].TargetID       ; guarda o ID acertado

                cmp     al, KBD_EVENT           ; foi evento do teclado ?
                je      @@new_kbd_ev            ; sim, salta

;-------------[ mouse event ]-------------------
@@new_mouse_ev: cmp     ah, CurrID              ; e foi no ID corrente ?
                je      @@process               ; processa o evento no ID corrente
                cmp     ah, ITEMS_BOX_ID
                jne     @@new_id
                push    ax
                mov     al, MouseYPos
                sub     al, 4
                add     al, Scr1stItem
                mov     ah, NrItems
                mov     CurrItem, al
                cmp     al, ah
                jb      @@done
                mov     CurrItem, ah
@@done:         pop     ax
                jmp     @@new_id

;-------------[ kbd event ]---------------------
@@new_kbd_ev:   cmp     ah, CurrID              ; corresponde ao ID corrente ?
                je      @@get_event             ; sim, ignora
                cmp     ah, NO_ID               ; corresponde a algum ID ?
                jne     @@new_id                ; sim, activa-o de pois de terminar o corrente
                mov     dx, [si].Event          ; n„o, coloca a tecla em DX

                cmp     dx, k_TAB               ; ‚ um TAB ?
                jne     @@process               ; n„o, processa-a

                mov     ah, CurrID
                inc     ah                      ; sim, ok pr¢ximo ID
                cmp     ah, LAST_GLOBAL_ID      ; j  chegamos ao fim dos globais ?
                jbe     @@new_id                ; n„o, salta
                mov     ah, ITEMS_BOX_ID        ; sim, volta ao prencipio
                jmp     @@new_id                ; salta

@@process:      call    [bx].ProcessRtn         ; processa um evento no ID corrente
                jmp     @@get_event             ; n„o, faz o loop

@@forced_id:    mov     ah, ForceNewID          ; guarda o novo ID
                mov     ForceNewID, 0           ; limpa a flag

@@new_id:       call    [bx].EndRtn             ; rotina de fim do ID corrente
                mov     CurrID, ah              ; coloca na mem¢ria
                jmp     @@new_event

@@end:          call    MouseHide               ; esconde o rato
                pop     si dx bx ax             ; restaura registos
                ret                             ; sai
Menu            ENDP

ShowScreen      PROC
                push    ax cx dx si di

                MOV     SI, TxtPal              ; SI -> paletta de cores
                MOV     AX, 600H                ; limpa todo o ecr„
                MOV     BH, [SI].Text
                XOR     CX, CX
                MOV     DX, 184FH
                INT     10H

                MOV     AH, [SI].FRAMES         ; desenha as caixas
                ; ---------------
                MOV     CX, 0301H
                MOV     DX, 0D4EH
                CALL    BOX
                ; ---------------
                MOV     CX, 0D01H
                MOV     DX, 0F4EH
                CALL    BOX
                ; ---------------
                MOV     CX, 1001H
                MOV     DX, 124EH
                CALL    BOX
                ; ---------------
                MOV     CX, 1201H
                MOV     DX, 144EH
                CALL    BOX
                ; ---------------
                MOV     CX, 1512H
                MOV     DX, 171EH
                CALL    BOX
                ; ---------------
                MOV     CL, 48
                MOV     DL, 60
                CALL    BOX
                ; ---------------
                MOV     DX, 0D01H
                MOV     AL, 'Ã'
                CALL    XYChar
                ; ---------------
                MOV     DH, 12H
                CALL    XYChar
                ; ---------------
                MOV     DL, 4EH
                MOV     AL, '´'
                CALL    XYChar
                ; ---------------
                MOV     DH, 0DH
                CALL    XYChar

                MOV     AH, [SI].Text        ; escreve string's
                ; ---------------
                MOV     CX, 0E03H
                MOV     DX, OFFSET MESS1$
                CALL    XYSTR
                ; ---------------
                MOV     Ch, 11H
                MOV     DX, OFFSET MESS2$
                CALL    XYSTR
                ; ---------------
                MOV     CX, 1309H
                MOV     DX, OFFSET MESS3$
                CALL    XYSTR
                ; ---------------
                MOV     DX, 0E4BH               ; escreve um car cter
                MOV     AL, 'K'
                CALL    XYChar

                MOV     AH, [SI].TEXTHI        ; escreve strings
                ; ---------------
                MOV     CX, 1614H
                MOV     DX, OFFSET INST_BUT$
                CALL    XYSTR
                ; ---------------
                MOV     CL, 50
                MOV     DX, OFFSET CANC_BUT$
                CALL    XYSTR
                ; ---------------
                MOV     CX, 0208H
                MOV     DX, OFFSET TITLE1$
                CALL    XYSTR
                ; ---------------
                MOV     CL, 69
                MOV     DX, OFFSET TITLE2$
                CALL    XYSTR

                MOV     AH, [SI].TITLes         ; escreve o titulo centralizado
                XOR     CX, CX
                MOV     DL, 79
                CALL    CLeaRLiNe
                MOV     SI, OFFSET PROGTITLE
                CALL    STRLEN
                SUB     CL, 80
                NEG     CL
                SHR     CL, 1
                MOV     DX, SI
                CALL    XYSTR

                CALL    DrawItems               ; desenha os items
                CALL    ShowUsed                ; mostra o espa‡o ocupado

                mov     si, TxtPal
                mov     ah, [si].TextHi
                mov     di, OFFSET BaseDirStr
                call    SHOW_STR

                test    VGA, 1
                jz      @@end

                ; fadein the screen to the initial palette
                mov     si, OFFSET Palette
                call    FadeIn
@@end:          pop     di si dx cx ax
                ret
ShowScreen      ENDP

;======================================================================
; Nome          PutItemDI
; Descri‡„o     Coloca em DI o endere‡o dos dados do item el AL.
; Retorno       Nunhum
;----------------------------------------------------------------------
PutItemDI       PROC
                PUSH    AX                      ; guarda AX
                DEC     AL                      ; AX = AL * tamanho de cada item
                MOV     AH, ITEM_SZ
                MUL     AH
                MOV     DI, AX                  ; coloca em DI
                ADD     DI, OFFSET ITEMS        ; soma-lhe o off do 1§ item
                POP     AX                      ; restaura AX
                RET
PutItemDI      ENDP

;======================================================================
; Nome          LightItem
; Descri‡„o     Activa o item corrente.
; Retorno       Nunhum
;----------------------------------------------------------------------
LightItem       PROC
                PUSH    AX CX DX SI DI ES
                call    MouseHide
                MOV     DH, CurrItem            ; posiciona o cursor
                SUB     DH, Scr1stItem
                ADD     DH, 4
                MOV     DL, 4
                CALL    GOTOXY

                MOV     DL, 2                   ; video off do 3§ car do item
                CALL    COMPuteADDR
                MOV     CX, 75                  ; linha com 75 caracteres
                MOV     SI, TxtPal             ; DL = atributo
                MOV     DL, [SI].CurrentText
                PUSH    DS ES                   ; guarda DS e DS = ES
                POP     DS
                MOV     SI, DI
                CLD
LGTI1:          LODSW                           ; altera s¢ o attr da linha
                MOV     AH, DL
                STOSW
                LOOP    LGTI1
                POP     DS                      ; restaura DS

                call    MouseShow
                POP     ES DI SI DX CX AX
                RET
LightItem       ENDP

;======================================================================
; Nome          UNLightItem
; Descri‡„o     Dessactiva o item corrente
; Retorno       Nunhum
;----------------------------------------------------------------------
UNLightItem     PROC
                PUSH    AX
                MOV     AL, CurrItem            ; desenha o item normalmente
                CALL    DrawItem
                POP     AX
                RET
UNLightItem     ENDP

;======================================================================
; Nome          DrawScrool
; Descri‡„o     Desenha a barra de scrool
; Retorno       Nunhum
;----------------------------------------------------------------------
DrawScrool      PROC
                PUSH    AX DX SI

                MOV     AL, NrItems            ; se o N§ de items for <= que o
                CMP     AL, 9                 ; N§ de linhas do ®ecr„¯ ?
                JBE     DRWS4                   ; n„o desenha

                call    MouseHide
                MOV     SI, TxtPal             ; escreve toda a barra
                MOV     AH, [SI].ScroolBAR
                MOV     DX, 044EH
                MOV     AL, ''
                CALL    XYChar
                MOV     AL, '°'
DRWS2:          INC     DH
                CALL    XYChar
                CMP     DH, 0BH
                JB      DRWS2
                INC     DH
                MOV     AL, ''
                CALL    XYChar

                MOV     AL, 7          ; calcula a posi‡„o corrente
                MUL     CurrItem
                DIV     NrItems
                OR      AL, AL
                JNZ     DRWS3
                INC     AL

DRWS3:          mov     ScroolPos, al
                MOV     AH, [SI].SCRoolBARHI    ; e escreve-a
                MOV     DX, 044EH
                ADD     DH, AL
                MOV     AL, 'Û'
                CALL    XYChar
                call    MouseShow

DRWS4:          POP     SI DX AX
                RET
DrawScrool      ENDP

;======================================================================
; Nome          DrawItems
; Descri‡„o     Desenha os items que couberem no ecr„ e ajusta a
;               barra de scrool
; Retorno       Nunhum
;----------------------------------------------------------------------
DrawItems       PROC
                PUSH    AX CX DX SI
                call    DrawScrool

                MOV     AL, Scr1stItem        ; come‡a pelo 1§ do ecr„
                MOV     CX, 9              ; N§ de items a escrever
DRWI1:          CALL    DrawItem                ; desenha-os
                INC     AL
                CMP     AL, NrItems
                JG      DRWI4
                LOOP    DRWI1

DRWI4:          POP     SI DX CX AX
                RET
DrawItems       ENDP

;======================================================================
; Nome          DrawItem
; Descri‡„o     Desenha um item (AL)
; Retorno       Nunhum
;----------------------------------------------------------------------
DrawItem        PROC
                PUSH    AX BX CX DX SI DI
                call    MouseHide

                CALL    PutItemDI             ; DI -> dados do item em AL

                MOV     SI, TxtPal             ; limpa a linha
                MOV     AH, [SI].ITEMc
                SUB     AL, Scr1stItem
                MOV     CX, 402H
                ADD     CH, AL
                MOV     DL, 76
                CALL    CLeaRLiNe

                MOV     CL, 3                   ; dependendo se est  activo
                CMP     [DI].ACTIVE, -1          ; escreve (sim) ou (n„o)
                JNE     DWI1
                MOV     DX, OFFSET YOPE$
                MOV     AH, [SI].ITEMHI
                JMP     SHORT DWI2
DWI1:           MOV     DX, OFFSET NOPE$
                MOV     AH, [SI].ITEMc
DWI2:           CALL    XYSTR

                MOV     CL, 8                   ; escreve a descri‡„o
                MOV     DX, DI
                ADD     DX, DESCription
                CALL    XYSTR

                MOV     DH, CH
                MOV     DL, 75                  ; escreve o car cter 'K'
                MOV     AL, 'K'
                CALL    XYChar

                MOV     BH, AH                  ; escreve o tamanho
                MOV     AX, [DI].SIZEKB
                MOV     CL, 5
                SUB     DL, 2
                CALL    XYNumber

                call    MouseShow
                POP     DI SI DX CX BX AX
                RET
DrawItem        ENDP

;======================================================================
; Nome          DrawTargetDir
; Descri‡„o     Desenha a directoria do item corrente
; Retorno       Nunhum
;----------------------------------------------------------------------
DrawTargetDir   PROC
                PUSH    AX CX DX SI DI
                call    MouseHide

                MOV     SI, TxtPal
                MOV     AL, CurrItem            ; AL = item corrente
                CALL    PutItemDI             ; DI -> item corrente
                CALL    MakeTargetDir
                MOV     AH, [SI].TEXTHI
                MOV     DX, 111BH
                MOV     SI, OFFSET CurrDir
                MOV     CX, 50
                cld
DTD3:           LODSB
                OR      AL, AL
                JZ      DTD4
                CALL    XYChar
                INC     DL
                LOOP    DTD3

DTD4:           call    MouseShow
                POP     DI SI DX CX AX
                RET

DrawTargetDir   ENDP

;======================================================================
; Nome          ClearTargetDir
; Descri‡„o     limpa o espa‡o para a directoria corrente
; Retorno       Nunhum
;----------------------------------------------------------------------
ClearTargetDir  PROC

                PUSH    AX CX DX SI

                MOV     SI, TxtPal
                MOV     AH, [SI].TEXTHI
                MOV     CX, 111BH
                MOV     DL, 77
                CALL    CLeaRLiNe

                POP     SI DX CX AX
                RET

ClearTargetDir  ENDP

;======================================================================
; Nome          MakeTargetDir
; Descri‡„o     Cria a directoria destino do item apontado por DI tendo
;               em conta a directoria base. O resultado ser  colocado
;               na string CurrDir
; Retorno       Nunhum
;----------------------------------------------------------------------
MakeTargetDir   PROC
                PUSH    AX BX SI DI

                MOV     BX, DI
                ADD     BX, DIRectory              ; BX -> [item].dir

                MOV     SI, OFFSET CurrDir
                MOV     BYTE PTR [SI], 0

                MOV     DI, BX
                CMP     BYTE PTR [DI+1], ':'
                JE      MTD6

                MOV     DI, OFFSET BasePath
                CALL    STRCAT

                mov     di, bx
                CALL    LASTCHAR
                CMP     AL, '\'
                JE      MTD6
                MOV     DI, OFFSET SLASH
                CALL    STRCAT
                MOV     DI, BX

MTD6:           CALL    STRCAT

                POP     DI SI BX AX
                RET
MakeTargetDir   ENDP

;======================================================================
; Nome          ShowUsed
; Descri‡„o     Escreve no ecr„ o espa‡o ocupado pelos prog. a instalar
; Retorno       Nenhum
;----------------------------------------------------------------------
ShowUsed        PROC
                PUSH    AX BX CX DX SI DI

                XOR     AX, AX
                MOV     CL, NrItems
                XOR     CH, CH
                MOV     DI, OFFSET items
SHU1:           CMP     [DI].ACTIVE, -1
                JNE     SHU2
                ADD     AX, [DI].SIZEKB
SHU2:           ADD     DI, ITEM_SZ
                LOOP    SHU1

                MOV     DX, 0E49H
                MOV     CL, 4
                MOV     SI, TxtPal
                MOV     BH, [SI].TEXTHI
                CALL    XYNumber

                POP     DI SI DX CX BX AX
                RET
ShowUsed        ENDP

                end

