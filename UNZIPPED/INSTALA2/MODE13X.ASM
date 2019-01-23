
;
;       MODE13X.ASM
;
;       rotinas para o modo VGA 360 por 480, 256 cores
;
;       Carlos Ladeira (C) Copyright 1995
;


                include instala.inc

		jumps
		locals
		.286
		.model small

                include 8x16fnt.inc

		.data?
LineOff         DW      480 dup (?)             ;offset for each scanline

		.data
; Index/data pairs for CRT Controller registers that differ between
; mode 13h and mode X.
CRTParms        label  word
		dw      06B00h                  ; horz total
		dw      05901h                  ; horz displayed
		dw      05A02h                  ; start horz blanking
		dw      08E03h                  ; end horz blanking
		dw      05E04h                  ; start h sync
		dw      08A05h                  ; end h sync
		dw      00D06h                  ; vertical total
		dw      03E07h                  ; overflow
		dw      04009h                  ; cell height
		dw      0EA10h                  ; v sync start
		dw      0AC11h                  ; v sync end and protect cr0-cr7
		dw      0DF12h                  ; vertical displayed
		dw      02D13h                  ; offset
		dw      00014h                  ; turn off dword mode
		dw      0E715h                  ; v blank start
		dw      00616h                  ; v blank end
		dw      0E317h                  ; turn on byte mode
CRT_PARM_LENGTH equ     (($-CRTParms)/2)


		.code
                PUBLIC  Mode13x, Point13x, Clear13x, PutChar, PutStr

; Mode13x       activa o modo de video 360x480x256 das placas VGA
; parƒmetros    nenhum
; retorno       nenhum
Mode13x         PROC
		push    ax cx dx si di es
		mov     ax, 13h         ; start with standard mode 13h
		int     10h             ; let the bios set the mode

		mov     dx, SC_INDEX    ; alter sequencer registers
		mov     ax, 0604h       ; disable chain 4
		out     dx, ax

                xor     al, al
		call    clear13x

		mov     ax, 0100h       ; synchronous reset
		out     dx, ax          ; asserted
		mov     dx, MISC_OUTPUT ; misc output
		mov     al, 0E7h        ; use 28 mHz dot clock
		out     dx, al          ; select it
		mov     dx, SC_INDEX    ; sequencer again
		mov     ax, 0300h       ; restart sequencer
		out     dx, ax          ; running again

		mov     dx, CRTC_INDEX   ; alter crtc registers

		mov     al, 11h         ; cr11
		out     dx, al          ; current value
		inc     dx              ; point to data
		in      al, dx          ; get cr11 value
		and     al, 7Fh         ; remove cr0 -> cr7 write protect
		out     dx, al
		dec     dx              ; point to index
		cld
		mov     si, OFFSET CRTParms
		mov     cx, CRT_PARM_LENGTH
		rep     outsw

		mov     ax, ds
		mov     es, ax
		xor     ax, ax
		mov     si, SCAN_LINE
		mov     di, OFFSET LineOff
		mov     cx, MAXY
@@store_off:    stosw
		add     ax, si
		loop    @@store_off
		pop     es di si dx cx ax
		ret
mode13x         ENDP

; Point13x      coloca um ponto no ecr„
; parƒmetros    dx=coordenada x
;               bx=coordenada y
;               al=cor
Point13x        PROC   
		cmp     dx, MAXX
		jae     @@exit
		cmp     bx, MAXY
		jae     @@exit
		push    bx cx dx es
		shl     bx, 1
		mov     cx, dx
		shr     dx, 2
		add     dx, word ptr LineOff[bx]
		mov     bx, dx
		push    ax
		mov     ax, 102h
		and     cl, 3
		shl     ah, cl                  ;create bit plane mask
		mov     dx, SC_INDEX
		out     dx, ax                  ;set EGA bit plane mask register
		mov     ax, SCREEN_SEG
		mov     es, ax                  ;setup screen segment
		pop     ax
		mov     es:[bx], al
		pop     es dx cx bx
@@exit:         ret
Point13x        ENDP

; Clear13x      limpa o ecr„
; parƒmetros    al=cor a utilizar para limpar o ecr„
; retorno       nenhum
Clear13x        PROC
		push    ax cx dx di es
                push    ax
		mov     dx, SC_INDEX    ; alter sequencer registers
		mov     ax, 0F02h       ; set write plane mask to all bit planes
		out     dx, ax
		xor     di, di
		mov     ax, SCREEN_SEG  ; screen starts at segment A000
		mov     es, ax
		mov     cx, 21600       ; ((XSIZE*YSIZE)/(4 planes))/(2 bytes per word)
                pop     ax
                mov     ah, al
		cld
		rep     stosw           ; clear the whole of the screen
		pop     es di dx cx ax
		ret
Clear13x        ENDP

; PutChar       escreve um caracter (8x16) no ecr„
; parƒmetros    dx=coordenada x
;               bx=coordenada y
;               ah=cor
;               al=char
; retorno       nenhum
PutChar         PROC
                push    ax bx cx dx si          ; preserva os registos
                cmp     al, 33                  ; ve rifica se o car cter
                jb      @@done                  ; est  nos limites
                cmp     al, 175                 ; 33..175
                ja      @@done                  ; e se n„o estiver, sai
                sub     al, 33                  ; ajusta para poder endere‡ar

                xor     ch, ch                  ; determina o offset do char
                mov     cl, al                  ; pretendido
                shl     cx, 4

                mov     al, ah                  ; coloca a cor em AL
                mov     si, OFFSET Fnt_8x16     ; coloca em SI o off. da fonte
                add     si, cx                  ; adiciona o offset do car cter
                mov     cx, CHAR_SZ             ; loop para as linhas
@@next_row:     push    dx                      ; guarda a posi‡„o x
                push    cx                      ; guarda a linha em execu‡„o
                mov     cx, 8                   ; loop para as 8 colunas
                mov     ah, 80h                 ; m scara para testar os bits
@@next_column:  test    byte ptr [si], ah       ; existe um pixel nesta posi‡„o?
                jz      @@dont_put              ; n„o, salta
                call    Point13x                ; sim, escreve-o
@@dont_put:     inc     dx                      ; incrementa a posi‡„o X
                shr     ah, 1                   ; desloca a m scara para a direita
                loop    @@next_column           ; pr¢x. coluna at‚ estarem todas
                pop     cx                      ; restaura a linha
                pop     dx                      ; restaura a posi‡„o X
                inc     bx                      ; incrementa a posi‡„o Y
                inc     si                      ; pr¢xima linha do car cter
                loop    @@next_row              ; pr¢x. linha at‚ estarem todas
@@done:         pop     si dx cx bx ax          ; restaura os registos alterados
                ret
PutChar         ENDP

; PutStr        escreve uma string em modo gr fico
; parƒmetros    ds:si=ptr para a string (ASCIIZ)
;               dx=coordenada x
;               bx=coordenada y
;               ah=atributo da string
; retorno       nenhum
PutStr          PROC
                PUSH    AX DX SI
                CLD
@@next_char:    LODSB
                OR      AL, AL
                JZ      @@end_string
                call    PutChar
                add     dx, 8
                JMP     @@next_char
@@end_string:   POP     SI DX AX
                RET
PutStr          ENDP

                end

