
;       video.asm
;       rotinas para manipular o video

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small

                .data?
pal             DB      768 dup(?)

                .code
                PUBLIC  GetMode, SetMode, isVGA, SetPalette
                PUBLIC  GetPalette, FadeIn, FadeOut, ClearPal
                PUBLIC  DarkScr, HighColor

; WaitRetrace   macro que espera o inicio do retra‡o vertical
;               destroi os registos dx e ax
WaitRetrace     MACRO
                mov     dx, STATUS_PORT
@@wait1:        in      al, dx
                and     al, 8
                jnz     @@wait1
@@wait2:        in      al, dx
                and     al, 8
                jz      @@wait2
                ENDM


; GetMode       determina o modo de video actual
; parƒmetros    nenhun
; retorno       al=modo de video corrente
;               bh=p gina de video corrente
GetMode         PROC
                mov     ah, 0Fh
                int     VIDEO
                ret
GetMode         ENDP

; SetMode       muda o modo de video corrente
; parƒmetros    al=modo de video pretendido
; retorno       nenhum
SetMode         PROC
                xor     ah, ah
                int     VIDEO
                ret
SetMode         ENDP

; isVGA         determina a existˆncia de uma placa VGA no sistema
; parƒmetros    nenhum
; retorno       CARRY=1 VGA ok
isVGA           PROC
                push    ax bx cx dx bp es
                mov     ax, 1A00h
                int     VIDEO
                cmp     al, 1Ah
                jne     @@noVGA
                cmp     bl, 6
                jbe     @@noVGA
                stc
                jmp     @@endVGA
@@noVga:        clc
@@endVGA:       pop     es bp dx cx bx ax
                ret
isVGA           ENDP

; ClearPal      coloca os valores RGB de todas as cores a 0
; parƒmetros    nenhum
; retorno       nenhum
ClearPal        PROC
                push    ax cx dx
                cld
                mov     dx, 3C8h
                xor     al, al
                out     dx, al
                inc     dx
                mov     cx, 768
@@clear:        out     dx, al
                loop    @@clear
                pop     dx cx ax
                ret
ClearPal        ENDP

; GetPalette    lˆ os valores (RGB) de todas as cores
; parƒmetros    es:di=ptr para os 768 bytes RGB
; retorno       ptr(es:di) com os valores da cor
GetPalette      PROC
                push    ax bx cx dx di
                cld
                mov     dx, 3C7h
                xor     al, al
                out     dx, al
                add     dx, 2
                mov     bx, dx
                mov     cx, 768
                WaitRetrace
                mov     dx, bx
                rep     insb
                pop     di dx cx bx ax
                ret
GetPalette      ENDP

; SetPalette    altera os valores (RGB) de todas as cores
; parƒmetros    ds:si=ptr para os 768 bytes RGB
; retorno       nenhum
SetPalette      PROC
                push    ax bx cx dx si
                cld
                mov     dx, 3C8h
                xor     al, al
                out     dx, al
                inc     dx
                mov     bx, dx
                mov     cx, 768
                WaitRetrace
                mov     dx, bx
                rep     outsb
                pop     si dx cx bx ax
                ret
SetPalette      ENDP

; FadeIn        faz um fade in e uma palette
; parƒmetros    ds::si=ptr para a palette
; retorno       nenhum
FadeIn          PROC
                push    ax bx cx di
                xor     bx, bx                  ; bx - contador 0 .. 63
                mov     di, OFFSET pal
                call    GetPalette
@@fade_loop:    mov     cx, 768
                push    si di
@@inc_pal:      lodsb
                mov     ah, [di]
                push    cx
                mov     cx, FADE_STEP
@@inc_loop:     cmp     ah, al
                jae     @@ok
                inc     ah
                loop    @@inc_loop
@@ok:           pop     cx
                mov     [di], ah
                inc     di
                loop    @@inc_pal
                pop     si di
                call    SetPalette
                xchg    si, di
                inc     bx
                test    bx, 40h
                jz      @@fade_loop
                pop     di cx bx ax
                ret
FadeIn          ENDP

; FadeOut       faz um fade out
; parƒmetros    nenhum
; retorno       nenhum
FadeOut         PROC
                push    ax bx cx si di
                xor     bx, bx                  ; bx - contador 0 .. 63
                mov     di, OFFSET pal
                mov     si, di
                call    GetPalette
@@fade_loop:    push    di
                mov     cx, 768
@@dec_pal:      lodsb
                push    cx
                mov     cx, FADE_STEP
@@dec_loop:     or      al, al
                jz      @@zero
                dec     al
                loop    @@dec_loop
@@zero:         pop     cx
                stosb
                loop    @@dec_pal
                pop     di
                mov     si, di
                call    SetPalette
                inc     bx
                test    bx, 40h
                jz      @@fade_loop
                pop     di si cx bx ax
                ret
FadeOut         ENDP


; DarkScr       escurece todas as cores do ecr„
; parƒmetros    nenhum
; retorno       nenhum
DarkScr         PROC
                push    ax bx cx si di
                mov     cx, DARKNESS_LEVEL
                mov     di, OFFSET pal
                mov     si, di
                call    GetPalette
@@fade_loop:    push    di cx
                mov     cx, 768
@@next_color:   lodsb
                or      al, al
                jz      @@zero
                dec     al
@@zero:         stosb
                loop    @@next_color
                pop     cx di
                mov     si, di
                call    SetPalette
                loop    @@fade_loop
                pop     di si cx bx ax
                ret
DarkScr         ENDP

; HighColor     coloca a cor em al a branco
; parƒmetros    al=cor
; retorno       nenhum
HighColor       PROC
                push    ax dx
                cld
                mov     dx, 3C8h
                out     dx, al
                inc     dx
                mov     al, 0FFh
                out     dx, al
                out     dx, al
                out     dx, al
                pop     dx ax
                ret
HighColor       ENDP

                end
