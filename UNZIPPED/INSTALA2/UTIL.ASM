
;       util.asm
;       rotinas varias de utiliza‡„o geral

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data
                EXTRN   Copyright$
Error$          DB      13, 10, 'ERRO: ', '$'

                .code

                PUBLIC  ReadKey, KeyHit, Toupper, Beep, Exit
                PUBLIC  Print, ErrorMsg, Toupper, Is286, Pause

; Beep          reproduz um beep no altifalante
; parƒmetros    nenhum
; retorno       nenhum
Beep            PROC
                push    ax
                mov     ax, 0E07h
                int     VIDEO
                pop     ax
                ret
Beep            ENDP

; ReadKey       lˆ uma tecla do buffer do teclado
; parƒmetros    nenhum
; retorno       ax=tecla lida
ReadKey         PROC
                xor     ax, ax
                int     KEYBOARD
                or      al, al
                jz      @@special_key
                xor     ah, ah
@@special_key:  ret
ReadKey         ENDP

; KeyHit        verifica se existem teclas no buffer do teclado
; parƒmetros    nenhum
; retorno       CARRY=1 se existirem teclas
;               CARRY=0 se o buffer estiver vazio
KeyHit          PROC
                push    ax
                mov     ah, 1
                int     KEYBOARD
                jnz     @@key
                clc
@@end:          pop     ax
                ret
@@key:          stc
                jmp     @@end
KeyHit          ENDP

; Toupper       converte para letra mai£scula
; parƒmetros    al=letra
; retorno       al=letra convertida
Toupper         PROC
                cmp     al, 61h
                jb      @@no
                cmp     al, 7Ah
                ja      @@no
                sub     al, 20h
@@no:           ret
Toupper         ENDP

; Exit          termina o pograna e volta ao SO
; parƒmetros    al=c¢digo do retorno (errorlevel)
; retorno       errorlevel para o SO
Exit            PROC
                mov     ah, 4Ch
                int     DOS
Exit            ENDP

; Print         Escreve uma string no ecr„
; parƒmetros    ds:dx=ptr para a string que termina com '$'
; retorno       nenhum
Print           PROC
                push    ax
                mov     ah, 9
                int     DOS
                pop     ax
                ret
Print           ENDP

; ErrorMsg      mostra uma mensagem, faz um beep e termina o pograna
; parƒmetros    ds:dx=ptr para a mensagem
; retorno       errorlevel 255 para o SO
ErrorMsg        PROC
                push    dx
                mov     dx, OFFSET Copyright$
                call    Print
                mov     dx, OFFSET Error$
                call    Print
                pop     dx
                call    Print
                call    Beep
                mov     al, 0FFh
                call    Exit
ErrorMsg        ENDP

; Is286         determina se o processador ‚ pelo menos um 286
; parƒmetros    nenhum
; retorno       CARRY=1 se for 286 ou superior
;               CARRY=0 se n„o for 286 ou superior
Is286           PROC
                push    cx dx
                mov     dx, sp
                push    sp
                pop     cx
                cmp     cx, dx
                jz      @@is286
                clc
                jmp     @@end
@@is286:        stc
@@end:          pop     dx cx
                ret
Is286           ENDP

; Pause         espera n segundos ou que sˆja pressionada uma t‚cla
; parƒmetros    al=n£mero de segundos de espera
; retorno       ax=tecla premida ou zero se timeout
Pause           PROC
                push    bx cx dx
                mov     bl, 18
                mul     bl
                mov     bx, ax
                xor     ah, ah
                int     1Ah
                add     bx, dx
@@loop:         xor     ah, ah
                int     1Ah
                xor     ax, ax
                cmp     bx, dx
                jb      @@done
                call    KeyHit
                jnc     @@loop
                call    ReadKey
@@done:         pop     dx cx bx
                ret
Pause           ENDP

                end

