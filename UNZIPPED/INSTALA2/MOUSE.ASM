
;       mouse.asm
;       rotinas de tratamento do rato em modo texto 80x25

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data?

                PUBLIC  MousePresent, MouseVisible,  MouseXPos, MouseYPos
                PUBLIC  MouseLeft, MouseRight

MousePresent    DB      ?
MouseVisible    DB      ?
MouseXPos       DW      ?
MouseYPos       DW      ?
MouseLeft       DB      ?
MouseRight      DB      ?

                .code

                PUBLIC  InitMouse, DeinitMouse, GetMouseState
                PUBLIC  MouseShow, MouseHide, SetMousePos

; InitMouse     inicializa o driver do rato
; parƒmetros    nenhum
; retorno       nenhum
InitMouse       PROC
                push    ax bx cx dx
                mov     MousePresent, 0
                mov     MouseVisible, 0
                mov     MouseLeft, 0
                mov     MouseRight, 0
                xor     ax, ax
                int     MOUSE
                or      ax, ax
                jz      @@end
                mov     MousePresent, 1
                call    GetMouseState
                mov     ax, 0Ah
                xor     bx, bx
                mov     cx, 07000h
                mov     dx, 08A04h
                int     MOUSE
                xor     cx, cx
@@end:          pop     dx cx bx ax
                ret
InitMouse       ENDP

; DeinitMouse   desinicializa o driver do rato
; parƒmetros    nenhum
; retorno       nenhum
DeinitMouse     PROC
                push    ax bx
                xor     ax, ax
                int     MOUSE
                pop     bx ax
                ret
DeinitMouse     ENDP

; GetMouseState lˆ as coordenadas e o estado das teclas do cursor do rato
; parƒmetros    nenhum
; retorno       nenhum
GetMouseState   PROC
                push    ax bx cx dx
                test    MousePresent, 1
                jz      @@end
                mov     ax, 3
                int     MOUSE
                shr     cx, 3
                shr     dx, 3
                mov     MouseXPos, cx
                mov     MouseYPos, dx
                test    bx, 1
                jz      @@no_left
                mov     MouseLeft, 1
                jmp     @@test_right
@@no_left:      mov     MouseLeft, 0
@@test_right:   test    bx, 2
                jz      @@no_right
                mov     MouseRight, 1
                jmp     @@end
@@no_right:     mov     MouseRight, 0
@@end:          pop     dx cx bx ax
                ret
GetMouseState   ENDP

; MouseShow     mostra o cursor do rato
; parƒmetros    nenhum
; retorno       nenhum
MouseShow       PROC
                push    ax
                test    MousePresent, 1
                jz      @@end
                test    MouseVisible, 1
                jnz     @@end
                mov     ax, 1
                int     MOUSE
                mov     MouseVisible, 1
@@end:          pop     ax
                ret
MouseShow       ENDP
                                              
; MouseHide     esconde o cursor do rato
; parƒmetros    nenhum
; retorno       nenhum
MouseHide       PROC
                push    ax
                test    MousePresent, 1
                jz      @@end
                test    MouseVisible, 1
                jz      @@end
                mov     ax, 2
                int     MOUSE
                mov     MouseVisible, 0
@@end:          pop     ax
                ret
MouseHide       ENDP

; SetMousePos   posiciona o cursor do rato
; parƒmetros    cx=x pos
;               dx=y pos
; retorno       nenhum
SetMousePos     PROC
                push    ax
                test    MousePresent, 1
                jz      @@end
                mov     ax, 4
                int     MOUSE
                call    GetMouseState
@@end:          pop     ax
                ret
SetMousePos     ENDP

                end
