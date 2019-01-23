
;       input.asm
;       rptinas responsaveis por ler e interpretar inputs do utilizador

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data?
                PUBLIC  CurrDir
                EXTRN   Scr1stItem:BYTE, NrItems:BYTE, CurrItem:BYTE
                EXTRN   MouseLeft:BYTE, MouseRight:BYTE, BasePath
                EXTRN   MouseXPos:BYTE, MouseYPos:BYTE, CurrItem:BYTE
                EXTRN   ScroolPos:BYTE

CurrDir         DB      81 dup(?)
                
                .data
                EXTRN   Quit:BYTE, TxtPal:WORD, INST_BUT$, CANC_BUT$
                EXTRN   ForceNewID:BYTE
                PUBLIC  Targets, BaseDirStr

CurrDirStr      EditData        <CurrDir, 80, 0, 50, 0, 111Bh>
BaseDirStr      EditData        <BasePath, 80, 0, 50, 0, 131Bh>

Targets         InputTarget     <ITEMS_BOX_ID, 2, 4, 78, 12, 0, ITB_Start, ITB_Mess, ITB_End>
                InputTarget     <BASE_DIR_ID, 27, 19, 76, 19, 0, BD_Start, BD_Mess, BD_End>
                InputTarget     <INSTALL_BUT_ID, 20, 22, 28, 22, 0, IB_Start, IB_Mess, IB_End>
                InputTarget     <CANCEL_BUT_ID, 50, 22, 58, 22, k_ESC, CB_Start, CB_Mess, CB_End>
                InputTarget     <TARGET_DIR_ID, 27, 17, 76, 17, 0, TD_Start, TD_Mess, TD_End>

ItemsBoxStat$   DB      ' Lista de items     ESPA€O - (des)selecciona   ENTER - destino   TAB - dir base', 0
BaseDirStat$    DB      ' Directoria base para a instala‡„o dos items seleccionados       TAB - instalar', 0
InstButStat$    DB      ' Instala os items seleccionados                ENTER - aceitar   TAB - terminar', 0
CancButStat$    DB      ' Terminar a execu‡„o do programa      ENTER - aceitar   TAB - seleccionar items', 0
TargetDirStat$  DB      ' Directoria destino do item seleccionado                        ENTER - aceitar', 0

                .code
                EXTRN   KeyHit:NEAR, ReadKey:NEAR, GetMouseState:NEAR
                EXTRN   PutItemDI:NEAR, LightItem:NEAR, UnlightItem:NEAR
                EXTRN   DrawItems:NEAR, DrawScrool:NEAR, DrawItem:NEAR
                EXTRN   DrawTargetDir:NEAR, ClearTargetDir:NEAR, GotoXY:NEAR
                EXTRN   MakeTargetDir:NEAR, ShowUsed:NEAR, XYChar:NEAR
                EXTRN   StrLen:NEAR, StrCopy:NEAR, XYStr:NEAR, Beep:NEAR
                EXTRN   MouseShow:NEAR, MouseHide:NEAR, Toupper:NEAR
                EXTRN   Status:NEAR, Instala:NEAR

                PUBLIC  GetInput, SHOW_STR

; GetInput      verifica se houve input do utilizador
; parƒmetros    si->para uma estrutura InputEvent
; retorno       CARRY=1 se houve input
;               CARRY=0 se n„o houve input
GetInput        PROC
                push    ax bx cx                ; salva os registos utilizados
                mov     [si].EventType, NO_EVENT; em prencipio n„o h  eventos
                mov     [si].Event, 0           ; de qq tipo
                call    GetMouseState           ; lˆ o estado do rato
                test    MouseLeft, 1            ; bot„o esquerdo premido ?
                jz      @@test_kbd              ; n„o, vˆ o teclado
@@wait_release: call    GetMouseState           ; sim, espera que a tecla
                test    MouseLeft, 1            ; sˆja libertada
                jnz     @@wait_release
                mov     [si].Event, 1           ; sinaliza o evento
                mov     [si].EventType, MOUSE_EVENT     ; idˆntifica o input
                mov     cx, N_IDS               ; N§ de alvos possiveis
                mov     bx, OFFSET Targets      ; come‡a no primeiro da lista
@@check_pos:    mov     al, MouseXPos           ; posi‡„o X do rato em al
                cmp     al, [bx].X1             ; ‚ menor que o X1 do alvo ?
                jb      @@out                   ; sim, salta
                cmp     al, [bx].X2             ; n„o, ‚ maior que o X2 do alvo ?
                jg      @@out                   ; sim, salta
                mov     al, MouseYPos           ; X ok, agora vamos ao Y
                cmp     al, [bx].Y1             ; ‚ menor que o Y1 ?
                jb      @@out                   ; sim, salta
                cmp     al, [bx].Y2             ; n„o, ‚ maior que o Y2 ?
                jbe     @@found_id              ; n„o, salta (alvo encontrado)

@@out:          add     bx, INPUT_TARGET_SZ     ; pr¢ximo alvo
                loop    @@check_pos             ; repete at‚ estarem todos
                mov     [si].TargetID, NO_ID    ; se n„o foi encontrado, azar
                clc                             ; fica como se n„o houvesse input
                jmp     @@no_event              ; sai

@@test_kbd:     call    KeyHit                  ; existe alguma tecla no buffer ?
                jnc     @@no_event              ; n„o, salta (n„o houve input)
                mov     [si].EventType, KBD_EVENT       ; sim, sinaliza-o
                call    ReadKey                 ; lˆ a tecla premida
                mov     [si].Event, ax          ; guarda-a como evento
                mov     cx, N_IDS               ; N§ de alvos possiveis
                mov     bx, OFFSET Targets      ; come‡a no primeiro alvo
@@check_key:    cmp     ax, [bx].ShortCut       ; tecla correspondente a este alvo ?
                je      @@found_id              ; sim, salta
                add     bx, INPUT_TARGET_SZ     ; n„o, pr¢ximo alvo
                loop    @@check_key             ; repete at‚ estarem todos
                mov     [si].TargetID, NO_ID    ; se n„o foi encontrado nenhum, azar
                jmp     @@event                 ; sai

@@found_id:     mov     al, [bx].ID             ; guarda o ID do alvo
                mov     [si].TargetID, al       ; que foi excolhido

@@event:        stc                             ; sinaliza o input existente
@@no_event:     pop     cx bx ax                ; restaura os registos
                ret                             ; baza
GetInput        ENDP

;======================================================================
; Nome          SHOW_STR
; Descri‡„o     Escreve no ecr„ a string com os dados apontados por DI.
; Retorno       Nenhum
;----------------------------------------------------------------------
SHOW_STR        PROC
                PUSH    AX CX DX SI
                call    MouseHide
                MOV     CX, [DI].WinSize
                MOV     DX, [DI].WinXY
                MOV     SI, [DI].String
                ADD     SI, [DI].FstWinChar
                cld
SHWSTR1:        LODSB
                CALL    XYCHar
                INC     DL
                OR      AL, AL
                JNZ     SHWSTR2
                DEC     SI
SHWSTR2:        LOOP    SHWSTR1
                mov     dx, [di].WinXY
                mov     ax, [di].WinPos
                sub     ax, [di].FstWinChar
                add     dl, al
                call    GotoXY
                call    MouseShow
                POP     SI DX CX AX
                RET
SHOW_STR        ENDP

; EditStr       processa uma str de acordo com o input
; parƒmetros    DI->para a estrutura da string
;               dx=tecla premida
; retorno       nenhum
EditStr         PROC
                PUSH    AX BX CX DX SI DI

                mov     si, [di].String
                call    StrLen

                cmp     dx, k_HOME
                je      @@home
                cmp     dx, k_END
                je      @@end
                cmp     dx, k_LEFT
                je      @@left
                cmp     dx, k_RIGHT
                je      @@right
                cmp     dx, k_BKSP
                je      @@backspace
                cmp     dx, k_DEL
                je      @@del
                jmp     @@default

@@home:         MOV     WORD PTR [DI].winPos, 0
                MOV     WORD PTR [DI].FstWinChar, 0
                JMP     @@done

@@end:          mov     dx, cx
                MOV     [DI].WinPos, dx
                mov     ax, [di].WinSize
                dec     ax
                sub     dx, ax
                JNS     EDSTR5A
                XOR     dx, dx
EDSTR5A:        MOV     [DI].FstWinChar, dx
                JMP     @@done

@@left:         CMP     [DI].WinPos, 0
                JE      @@done
                DEC     [DI].WinPos
                MOV     AX, [DI].WinPos
                CMP     AX, [DI].FstWinChar
                JGE     @@done
                DEC     [DI].FstWinChar
                jmp     @@done

@@right:        MOV     AX, [DI].WinPos
                CMP     AX, cx
                JGE     @@done
                INC     [DI].WinPos
                INC     AX
                SUB     AX, [DI].FstWinChar
                CMP     AX, [DI].WinSize
                JB      @@done
                INC     [DI].FstWinChar
                jmp     @@done

@@backspace:    CMP     [DI].WinPos, 0
                JE      @@done
                DEC     [DI].WinPos
                CALL    DEL_CHAR
                MOV     AX, [DI].WinPos
                CMP     AX, [DI].FstWinChar
                JNE     @@done
                OR      AX, AX
                JZ      @@done
                DEC     [DI].FstWinChar
                JMP     @@done

@@del:          MOV     AX, [DI].WinPos
                CMP     AX, cx
                JGE     @@done
                CALL    DEL_CHAR
                JMP     @@done

@@default:      mov     ax, dx
                CMP     ax, 32
                JB      @@done
                CMP     ax, 0FFH
                JG      @@done
                call    Toupper

                MOV     SI, cx
                CMP     SI, [DI].StrSize
                JE      @@done
                INC     cx

                PUSH    DI
                MOV     SI, [DI].String
                ADD     SI, [DI].WinPos
                MOV     DI, SI
                XCHG    AH, AL
                cld
EDSTR3C:        LODSB
                XCHG    AH, AL
                STOSB
                OR      AL, AL
                JNZ     EDSTR3C
                POP     DI
                jmp     @@right

@@done:         MOV     BX, TxtPal
                MOV     AH, [BX].CURrentTEXT
                CALL    SHOW_STR

                POP     DI SI DX CX BX AX
                RET
EditStr         ENDP

DEL_CHAR        PROC
                PUSH    DI
                MOV     SI, [DI].String
                ADD     SI, [DI].WinPos
                MOV     DI, SI
                INC     SI
                CALL    StrCOPY
                POP     DI
                DEC     cx
                RET
DEL_CHAR        ENDP


;-----------------------------
; ItemBox
ITB_Start       PROC
                push    bx dx
                call    DrawItems
                call    LightItem
                mov     bx, OFFSET CurrDirStr
                mov     [bx].WinPos, 0
                mov     [bx].FstWinChar, 0
                call    DrawTargetDir
                mov     dx, OFFSET ItemsBoxStat$
                call    Status
                pop     dx bx
                ret
ITB_Start       ENDP

ITB_Mess        PROC
                push    ax di
                call    UnlightItem
                call    ClearTargetDir
                cmp     al, MOUSE_EVENT
                je      @@mouse_press
                cmp     dx, k_SPACE
                je      @@space
                cmp     dx, k_UP
                je      @@up
                cmp     dx, k_DOWN
                je      @@down
                cmp     dx, k_HOME
                je      @@home
                cmp     dx, k_END
                je      @@end
                cmp     dx, k_PGUP
                je      @@pgup
                cmp     dx, k_PGDN
                je      @@pgdn
                cmp     dx, k_ENTER
                je      @@enter
                jmp     @@done

@@space:        MOV     AL, CurrItem            ; AL = item corrente
                CALL    PutItemDI               ; DI -> item corrente
                NOT     [DI].ACTIVE             ; inverte o estado do item
                CALL    ShowUsed                ; mostra o espa‡o a usar na inst.
                jmp     @@done1

@@up:           CMP     CurrItem, 1             ; se j  estiver no 1§ item
                JE      @@done                  ; ignora-se o comando
                DEC     CurrItem                ; se n„o, item anterior
                MOV     AL, Scr1stItem          ; AL = primeiro item do ecr„
                CMP     CurrItem, AL            ; ‚ maior que o corrente
                JGE     @@done                  ; n„o, salta
                DEC     Scr1stItem              ; sim, decrementa-o
                JMP     @@done1                 ; faz o loop

@@down:         MOV     AL, NrItems             ; AL = N§ de itens
                CMP     CurrItem, AL            ; o corrente ‚ igual ?
                JE      @@done                  ; sim, ignora o comando
                INC     CurrItem                ; n„o, pr¢ximo item
                MOV     AL, Scr1stItem          ; coloca em AL o £ltimo item
                ADD     AL, 9                   ; do ecr„
                CMP     CurrItem, AL            ; o corrente ‚ menor ?
                JB      @@done                  ; sim, salta
                INC     Scr1stItem              ; n„o, inc. o 1§ no ecr„
                JMP     @@done1                 ; faz o loop

@@home:         MOV     CurrItem, 1
                MOV     Scr1stItem, 1
                JMP     @@done1

@@end:          MOV     AL, NrItems
                CMP     AL, 9
                JA      @@big
                MOV     AL, NrItems
                MOV     CurrItem, AL
                JMP     @@done
@@big:          MOV     CurrItem, AL
                SUB     AL, 8
                MOV     Scr1stItem, AL
                JMP     @@done1

@@pgup:         MOV     AL, Scr1stItem
                CMP     AL, CurrItem
                JE      @@at_top
                MOV     CurrItem, AL
                JMP     @@done
@@at_top:       CMP     AL, 1
                je      @@done
                CMP     AL, 9
                JB      @@at_1st_page
                SUB     AL, 8
                MOV     Scr1stItem, AL
                mov     CurrItem, al
                JMP     @@done1
@@at_1st_page:  MOV     Scr1stItem, 1
                mov     CurrItem, 1
                JMP     @@done1

@@pgdn:         MOV     AL, NrItems
                CMP     AL, CurrItem
                JE      @@done
                CMP     AL, 9
                JA      @@big_list
                MOV     CurrItem, AL
                JMP     @@done
@@big_list:     MOV     AL, Scr1stItem
                ADD     AL, 8                 ; AL - ultimo no ecr„
                CMP     AL, CurrItem
                JE      @@at_bottom
                MOV     CurrItem, AL
                JMP     @@done
@@at_bottom:    MOV     AH, NrItems
                SUB     AH, 8
                CMP     AL, AH
                JBE     @@not_last_page
                MOV     AL, AH
@@not_last_page:MOV     Scr1stItem  , AL
                add     al, 8
                mov     CurrItem, al
                jmp     @@done1

@@enter:        mov     ForceNewID, TARGET_DIR_ID
                jmp     @@done

@@mouse_press:  mov     al, MouseYPos
                sub     al, 4
                add     al, Scr1stItem
                mov     ah, NrItems
                cmp     ah, al
                jb      @@end
                cmp     MouseXPos, 78
                je      @@hit_scrool
                cmp     CurrItem, al
                je      @@space
                mov     CurrItem, al
                jmp     @@done

@@hit_scrool:   cmp     NrItems, 9
                jbe     @@done
                mov     al, MouseYPos
                cmp     al, 4
                je      @@up
                cmp     al, 12
                je      @@down
                sub     al, 4
                cmp     al, ScroolPos
                jb      @@pgup
                jg      @@pgdn
                jmp     @@done

@@done1:        call    DrawItems
@@done:         call    LightItem
                call    DrawScrool
                call    DrawTargetDir
                pop     di ax
                ret
ITB_Mess        ENDP

ITB_End         PROC
                call    UnlightItem
                call    ClearTargetDir
                ret
ITB_End         ENDP

;-----------------------------
; TargetDir
SetCursorPos    PROC
                mov     si, [di].String
                call    StrLen
                mov     al, MouseXPos
                xor     ah, ah
                sub     al, byte ptr [di].WinXY
                add     ax, [di].FstWinChar
                cmp     ax, cx
                jbe     @@at_limits
                mov     ax, cx
@@at_limits:    mov     [di].WinPos, ax
                mov     si, TxtPal
                mov     ah, [si].CurrentText
                call    SHOW_STR
                ret
SetCursorPos    ENDP

TD_Start        PROC
                push    ax dx si di
                call    DrawItems
                call    LightItem
                MOV     AL, CurrItem            ; AL = item corrente
                CALL    PutItemDI             ; DI -> item corrente
                CALL    MakeTargetDir
                mov     si, TxtPal
                mov     ah, [si].CurrentText
                mov     di, OFFSET CurrDirStr
                call    SHOW_STR
                mov     dx, OFFSET TargetDirStat$
                call    Status
                pop     di si dx ax
                ret
TD_Start        ENDP

TD_Mess         PROC
                push    ax cx si di
                mov     di, OFFSET CurrDirStr
                cmp     al, MOUSE_EVENT
                je      @@mouse
                cmp     dx, k_ENTER
                je      @@force_new
                call    EditStr
                jmp     @@end

@@mouse:        call    SetCursorPos
                jmp     @@end

@@force_new:    mov     ForceNewID, ITEMS_BOX_ID
@@end:          pop     di si cx ax
                ret
TD_Mess         ENDP

TD_End          PROC
                push    ax cx si di

                MOV     DI, OFFSET CurrDir
                MOV     SI, OFFSET BasePath
                CALL    STRLEN                  ; CX = LEN(BASE_DIR)
                CLD
                REPE    CMPSB
                JNE     @@MISMATCH

                CMP     BYTE PTR [DI], '\'
                JNE     @@no_slash
                INC     DI
@@no_slash:     MOV     SI, DI
                JMP     @@copy_dir

@@MISMATCH:     MOV     SI, OFFSET CurrDir
                CMP     BYTE PTR [SI], '\'
                JNE     @@copy_dir
                INC     SI

@@copy_dir:     mov     al, CurrItem
                CALL    PutItemDI
                ADD     DI, Directory
                CALL    StrCopy

                call    UnlightItem
                call    ClearTargetDir
                pop     di si cx ax
                ret
TD_End          ENDP

;-----------------------------
; BaseDir
BD_Start        PROC
                push    ax dx si di
                mov     si, TxtPal
                mov     ah, [si].CurrentText
                mov     di, OFFSET BaseDirStr
                call    SHOW_STR
                mov     dx, OFFSET BaseDirStat$
                call    Status
                pop     di si dx ax
                ret
BD_Start        ENDP

BD_Mess         PROC
                push    ax cx si di
                mov     di, OFFSET BaseDirStr
                cmp     al, MOUSE_EVENT
                je      @@mouse
                call    EditStr
                jmp     @@end

@@mouse:        call    SetCursorPos

@@end:          pop     di si cx ax
                ret
BD_Mess         ENDP

BD_End          PROC
                push    ax si di
                mov     si, TxtPal
                mov     ah, [si].TextHi
                mov     di, OFFSET BaseDirStr
                call    SHOW_STR
                pop     di si ax
                ret
BD_End          ENDP

;-----------------------------
; InstallBut
IB_Start        PROC
                push    ax cx dx si
                mov     si, TxtPal
                MOV     AH, [SI].CurrentText        ; escreve strings
                MOV     CX, 1614H
                MOV     DX, OFFSET INST_BUT$
                CALL    XYSTR
                mov     dx, cx
                inc     dl
                call    GotoXY
                mov     dx, OFFSET InstButStat$
                call    Status
                pop     si dx cx ax
                ret
IB_Start        ENDP

IB_Mess         PROC
                cmp     al, MOUSE_EVENT
                je      @@ok
                cmp     dx, k_ENTER
                jne     @@end
@@ok:           call    Instala
                mov     dx, OFFSET InstButStat$
                call    Status
                MOV     dx, 1615H
                call    GotoXY
@@end:          ret
IB_Mess         ENDP

IB_End          PROC
                push    ax cx dx si
                mov     si, TxtPal
                MOV     AH, [SI].TEXTHI        ; escreve strings
                MOV     CX, 1614H
                MOV     DX, OFFSET INST_BUT$
                CALL    XYSTR
                pop     si dx cx ax
                ret
IB_End          ENDP

;-----------------------------
; CancelBut
CB_Start        PROC
                push    ax cx dx si
                mov     si, TxtPal
                MOV     AH, [SI].CurrentText        ; escreve strings
                MOV     CX, 1632H
                MOV     DX, OFFSET CANC_BUT$
                CALL    XYSTR
                mov     dx, cx
                inc     dl
                call    GotoXY
                mov     dx, OFFSET CancButStat$
                call    Status
                pop     si dx cx ax
                ret
CB_Start        ENDP

CB_Mess         PROC
                cmp     al, MOUSE_EVENT
                je      @@quit
                cmp     dx, k_ENTER
                jne     @@not_end
@@quit:         mov     Quit, 1
@@not_end:      ret
CB_Mess         ENDP

CB_End          PROC
                push    ax cx dx si
                mov     si, TxtPal
                MOV     AH, [SI].TEXTHI        ; escreve strings
                MOV     CX, 1632H
                MOV     DX, OFFSET CANC_BUT$
                CALL    XYSTR
                pop     si dx cx ax
                ret
CB_End          ENDP

                end

