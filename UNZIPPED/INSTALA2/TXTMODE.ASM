
;       txtmode.asm
;       rotinas varias para trabalhar em modo texto 80x25

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data?
                EXTRN   VideoMode:BYTE, VGA:BYTE

                .data
                PUBLIC  TxtPal
VideoAddr       DW      0B000h
TxtPal          DW      OFFSET b&wPal
b&wPal          Colors  <0FH, 0FH, 70H, 7FH, 07H, 70H, 07H, 70H, 70H, 71H>
ColorPal        Colors  <31H, 3BH, 70H, 7EH, 3FH, 71H, 1FH, 1FH, 78H, 74H>

                .code
                EXTRN   SetMode:NEAR, StrLen:NEAR, ClearPal:NEAR
                EXTRN   MouseHide:NEAR, MouseShow:NEAR
                PUBLIC  Init80x25Mode, ClearLine, XYChar, XYStr, XYNumber
                PUBLIC  StatusCursor, Status, Box, ClearTxtMode, ComputeAddr
                PUBLIC  GotoXY

ClearTxtMode    PROC
                push    ax cx di es
                mov     cx, 80*25
                mov     es, VideoAddr
                xor     ax, ax
                mov     di, ax
                cld
                rep     stosw
                pop     es di cx ax
                ret
ClearTxtMode    ENDP

Init80x25Mode   PROC
                push    ax
                mov     al, 7
                cmp     VideoMode, 7
                je      @@set_mode
                cmp     VideoMode, 15
                je      @@set_mode
                add     VideoAddr, 0800h
                mov     al, 2
                cmp     VideoMode, 2
                je      @@set_mode
                cmp     VideoMode, 0
                je      @@set_mode
                mov     ax, OFFSET ColorPal
                mov     TxtPal, ax
                mov     al, 3
@@set_mode:     call    SetMode
                test    VGA, 1
                jz      @@no_vga
                call    ClearPal
@@no_vga:       pop     ax
                ret
Init80x25Mode   ENDP

; GotoXY        posiciona o cursor
; parƒmetros    dl=coordenada x
;               dh=coordenada y
; retorno       nenhum
GotoXY          PROC
                PUSH    AX BX
                XOR     BH, BH          ; p gina 0
                MOV     AH, 2           ; posiciona o cursor
                INT     VIDEO
                POP     BX AX
                RET
GotoXY          ENDP

; ComputeAddr   calcula o offset na mem¢ria de video de uma posi‡„o X,Y
; parƒmetros    dl=coordenada x
;               dh=coordenada y
; retorno       es=segmento da mem¢ria de video
;               di=offset na memm¢ria de video
ComputeAddr     PROC
                PUSH    AX DX
                MOV     AL, 160         ; N§ DE BYTES POR LINHA
                MUL     DH
                SHL     DL, 1
                ADD     AL, DL
                ADC     AH, 0
                MOV     DI, AX
                MOV     ES, VideoAddr
                POP     DX AX
                RET
ComputeAddr     ENDP

; ClearLine     limpa uma linha, ou parte
; parƒmetros    cl=coordenada x1
;               dl=coordenada x2
;               ch=coordenada y
;               ah=atributo
; retorno       nenhum
ClearLine       PROC
                PUSH    AX CX DX
                call    MouseHide
                XCHG    CX, DX
                MOV     AL, ' '
@@next_char:    CALL    XYChar
                INC     DL
                CMP     DL, CL
                JBE     @@next_char
                call    MouseShow
                POP     DX CX AX
                RET
ClearLine       ENDP

; XYChar        escreve um car cter no ecr„
; parƒmetros    al=codigo ASCII do car cter
;               ah=atributo do car cter
;               dl=coordenada x
;               dh=coordenada y
; retorno       nenhum
XYChar          PROC
                PUSH    ES DI
                CALL    ComputeAddr
                STOSW
                POP     DI ES
                RET
XYChar          ENDP

; XYStr         escreve uma string no ecr„
; parƒmetros    ds:dx=ptr para a string (ASCIIZ)
;               ah=atributo da string
;               cl=coordenada x
;               ch=coordenada y
; retorno       nenhum
XYStr           PROC
                PUSH    AX DX SI DI ES
                call    MouseHide
                MOV     SI, DX
                MOV     DX, CX
                CALL    ComputeAddr
                CLD
@@next_char:    LODSB
                OR      AL, AL
                JZ      @@end_string
                STOSW
                JMP     @@next_char
@@end_string:   call    MouseShow
                POP     ES DI SI DX AX
                RET
XYStr           ENDP

; XYNumber      escreve um n£mero no ecr„
; parƒmetros    ax=n£mero a escrever
;               bh=attributo
;               dl=coordenada x
;               dh=coordenada y
;               cl=n£mero m ximo de digitos
; retorno       nenhum
XYNumber        PROC
                PUSH    AX CX DX SI DI ES       ; guarda os registos
                call    MouseHide
                CALL    ComputeAddr             ; calcula a pos. no video
                STD
                XOR     CH, CH
                MOV     SI, 10                  ; divide por 10
@@next_digit:   XOR     DX, DX
                DIV     SI                      ; AX=DX:AX/SI  DX=DX:AX%SI
                PUSH    AX                      ; guarda resultado
                MOV     AL, DL                  ; N§ extraido
                ADD     AL, '0'                 ; converte para digito
                MOV     AH, BH                  ; coloca o atributo em AH
                STOSW                           ; escreve o n£mero
                POP     AX                      ; restaura o resultado
                OR      AX, AX                  ; resultado == 0 || CX == 0 ?
                LOOPNE  @@next_digit            ; n„o, salta
                JCXZ    @@end_nr                ; se CX = 0, salta
                MOV     AL, ' '                 ; preenche o resto com espa‡os
                MOV     AH, BH                  ; com o mesmo atributo
                REP     STOSW
@@end_nr:       call    MouseShow
                POP     ES DI SI DX CX AX       ; restaura os registos
                RET
XYNumber        ENDP

; StatusCursor  escreve uma string na linha de status e posiciona o cursor no fim
; parƒmetros    ds:dx=ptr para a string
; retorno       nenhum
StatusCursor    PROC
                PUSH    CX DX SI
                CALL    STATUS
                MOV     SI, DX
                CALL    STRLEN
                MOV     DL, CL
                MOV     DH, 24
                CALL    GOTOXY
                POP     SI DX CX
                RET
StatusCursor    ENDP

; Status        escreve uma string na linha de status
; parƒmetros    ds:dx=ptr para a string
; retorno       nenhum
Status          PROC
                PUSH    AX CX SI
                PUSH    DX
                MOV     SI, TxtPal
                MOV     BYTE PTR AH, [SI].StatLn
                MOV     CX, 1800H
                MOV     DL, 4FH
                CALL    ClearLine
                POP     DX
                CALL    XYStr
                POP     SI CX AX
                RET
Status          ENDP

; Box           desenha uma caixa a linha simples
; parƒmetros    cl=coordenada x1
;               ch=coordenada y1
;               dl=coordenada x2
;               dh=coordenada y2
;               ah=atributo
; retorno       nenhum
Box             PROC
                PUSH    AX BX DX
                MOV     BX, DX

                MOV     DL, CL
                MOV     AL, 'Ä'
@@h_loop:       INC     DL
                MOV     DH, CH
                CALL    XYChar
                MOV     DH, BH
                CALL    XYChar
                CMP     DL, BL
                JB      @@h_loop

                MOV     DH, CH
                MOV     AL, '³'
@@v_loop:       INC     DH
                MOV     DL, CL
                CALL    XYChar
                MOV     DL, BL
                CALL    XYChar
                CMP     DH, BH
                JB      @@v_loop

                MOV     DX, CX
                MOV     AL, 'Ú'
                CALL    XYChar

                MOV     DL, BL
                MOV     AL, '¿'
                CALL    XYChar

                MOV     DX, BX
                MOV     AL, 'Ù'
                CALL    XYChar

                MOV     DL, CL
                MOV     AL, 'À'
                CALL    XYChar

                POP     DX BX AX
                RET
Box             ENDP

                end

