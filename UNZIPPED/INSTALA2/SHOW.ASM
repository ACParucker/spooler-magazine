
;       show.asm
;       rotinas para o slide-show

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .data?
                EXTRN   ProgPath, ShowFilePath, tmpstr
TextColor       DB      ?
ImageFile       DB      9 dup(?)
LoadBuffer      DB      LOADBUF_SZ dup(?)
DataBufPos      DW      ?
DataReadSz      DW      ?

GifPalette      DB      768 dup (?)
GifHeader       Header  <?>
GifImgDesc      ImgDesc <?>
X               DW      ?
Y               DW      ?
XStart          DW      ?
YStart          DW      ?
XSize           DW      ?
YSize           DW      ?
IRight          DW      ?
IBottom         DW      ?
Used            DB      256 dup(?)
GifHandle       DW      ?

                .data
GIF$            DB      '.GIF', 0
TXT$            DB      '.TXT', 0
GifSignature    DB      'GIF87a'
GIFS_dir$       DB      'IMAGENS\', 0
KeyToContinue$  DB      '(pressione uma tecla para continuar)', 0

                .code
                EXTRN   ReadFile:NEAR, StrNCmp:NEAR, KeyHit:NEAR, ReadKey:NEAR
                EXTRN   Point13x:NEAR, Clear13x:NEAR, GetChar:NEAR
                EXTRN   OpenFile:NEAR, Mode13x:NEAR, ClearPal:NEAR
                EXTRN   FadeIn:NEAR, FadeOut:NEAR, GetLine:NEAR
                EXTRN   StrLen:NEAR, StrCopy:NEAR, StrCat:NEAR
                EXTRN   FileExist:NEAR, CloseFile:NEAR, ExpandGIF:NEAR
                EXTRN   Pause:NEAR, DarkScr:NEAR
                EXTRN   HighColor:NEAR, PutStr:NEAR, GetLineData:NEAR

                PUBLIC  ShowImages, PutByte, GetByte

ShowImages      PROC

                push    ax bx cx dx si di
                mov     dx, OFFSET ShowFilePath ; abre o ficheiro
                call    OpenFile
                jc      @@end
                mov     bx, ax

                call    Mode13x                 ; comuta para modo gr fico
                call    ClearPal                ; e coloca todas as cores a zero
                call    KeyHit
                jnc     @@next_image
                call    ReadKey
                cmp     ax, 27
                je      @@done

@@next_image:   mov     cx, 8                   ; lˆ uma linha (max. 8 chars)
                mov     si, OFFSET ImageFile
                call    GetLineData
                call    StrLen                  ; vˆ se o tamanho ‚ diferente de zero
                or      cx, cx
                jz      @@done                  ; se n„o, salta

                mov     si, OFFSET ProgPath     ; constroi a pathname do file
                mov     di, OFFSET tmpstr       ; para o ficheiro GIF
                call    StrCopy
                mov     si, di
                mov     di, OFFSET GIFS_dir$
                call    StrCat
                mov     di, OFFSET ImageFile
                call    StrCat
                mov     di, OFFSET GIF$
                call    StrCat
                mov     dx, si
                call    FileExist               ; verifica se existe
                jc      @@next_image            ; n„o, lˆ a pr¢xima linha
                
                mov     DataReadSz, 0
                call    ShowGif                 ; mostra o GIF
                jc      @@next_image            ; erro, pr¢x. imagem
                mov     si, OFFSET GifPalette
                call    FadeIn                  ; faz um fadein ao gif
                mov     al, 3
                call    Pause                   ; espera 3 sec ou uma tecla
                cmp     ax, 27
                je      @@fdout

                mov     si, OFFSET ProgPath     ; controi a pathname do TXT
                mov     di, OFFSET tmpstr
                call    StrCopy
                mov     si, di
                mov     di, OFFSET GIFS_dir$
                call    StrCat
                mov     di, OFFSET ImageFile
                call    StrCat
                mov     di, OFFSET TXT$
                call    StrCat
                mov     dx, si
                call    FileExist               ; verifica se existe
                jc      @@fdout

@@show_text:    call    ShowText                ; mostra o texto
;                mov     al, 10
;                call    Pause                   ; espera 10 segundos ou uma tecla
@@fdout:        call    FadeOut                 ; faz fade out
                cmp     ax, 27
                jne     @@next_image            ; lˆ a pr¢xima imagem

@@done:         call    CloseFile               ; fecha o ficheiro
                xor     al, al
                call    Clear13x

@@end:          pop     di si dx cx bx ax       ; restaura os registos e sai
                ret
ShowImages      ENDP


; PutByte       escreve um ponto no ecr„
; parƒmetros    al=cor
; retorno       nenhum
PutByte         PROC
                push    ax bx cx dx

                mov     bx, ax
                xor     bh, bh
                mov     Used[bx], 1

                mov     dx, X
                mov     bx, Y
                cmp     bx, IBottom
                ja      @@end
                call    Point13x
                inc     dx
                cmp     dx, IRight
                jb      @@store
                mov     dx, XStart
                inc     bx
@@store:        mov     X, dx
                mov     Y, bx

@@end:          pop     dx cx bx ax
                ret
PutByte         ENDP

GetByte         PROC
                cmp     DataReadSz, 0
                jne     @@next_byte
                mov     bx, GifHandle
                mov     dx, OFFSET LoadBuffer
                mov     DataBufPos, dx
                mov     cx, LOADBUF_SZ
                call    ReadFile
                mov     DataReadSz, ax
@@next_byte:    mov     bx, DataBufPos
                mov     al, [bx]
                xor     ah, ah
                inc     DataBufPos
                dec     DataReadSz
@@end:          ret
GetByte         ENDP

; ShowGif       lˆ um GIF e projecta-o no ecr„
; parƒmetros    ds:dx=ptr para o nome do ficheiro GIF
; retorno       ax=primeira cor n„o usada, FFFFh se for impossivel
;               CARRY=1 em caso de erro
;               CARRY=0 se tudo ok
ShowGif         PROC

                push    ax bx cx dx si di

                cld                             ; coloca a 0 nas flags de cor
                mov     di, OFFSET Used
                mov     cx, 128
                xor     ax, ax
                rep     stosw

                call    OpenFile
                jc      @@done2
                mov     bx, ax
                mov     GifHandle, ax

                mov     dx, OFFSET GifHeader
                mov     cx, HEADER_SZ
                call    ReadFile
                jc      @@done1
                cmp     ax, cx
                jne     @@done1

                mov     si, dx
                mov     di, OFFSET GifSignature
                mov     cx, 6
                call    StrNCmp
                jnc     @@done1

                add     si, 10                  ; si -> flags
                lodsb
                test    al, 80h
                jz      @@no_color_tab
                call    ReadColors
                jc      @@done1

@@no_color_tab: lodsb                           ; lˆ a cor de fundo
                call    Clear13x                ; e limpa o ecr„ com ela

                call    GetChar                 ; passa o separador de imagem

                mov     dx, OFFSET GifImgDesc
                mov     cx, IMGDESC_SZ
                call    ReadFile
                jc      @@done1
                cmp     ax, cx
                jne     @@done1

                mov     si, dx
                add     si, 4
                lodsw
                mov     XSize, ax
                mov     cx, MAXX
                cmp     ax, cx
                ja      @@done1
                sub     cx, ax
                shr     cx, 1
                mov     XStart, cx
                mov     X, cx
                add     ax, cx
                mov     IRight, ax
                lodsw
                mov     YSize, ax
                mov     cx, MAXY
                cmp     ax, cx
                ja      @@done1
                sub     cx, ax
                shr     cx, 1
                mov     YStart, cx
                mov     Y, cx
                add     ax, cx
                mov     IBottom, ax

                lodsb
                test    al, 40h
                jz      @@not_interlace
                stc
                jmp     @@done1
@@not_interlace:test    al, 80h
                jz      @@no_color_tab1
                call    ReadColors
                jc      @@done1

@@no_color_tab1:call    ExpandGIF

                std
                mov     si, OFFSET Used + 255
                mov     cx, 256
@@next_color:   lodsb
                or      al, al
                jz      @@found
                loop    @@next_color
@@found:        dec     cl
                mov     TextColor, cl

@@done1:        pushf
                mov     bx, GifHandle
                call    CloseFile
                popf

@@done2:        pop     di si dx cx bx ax
                ret

ReadColors:     mov     cx, PALETTE_SZ
                mov     di, OFFSET GifPalette
@@next_clr:     call    GetChar
                jc      @@end_read
                shr     al, 2
                stosb
                loop    @@next_clr
                clc
@@end_read:     ret

ShowGif         ENDP

; ShowText      escreve texto por cima do GIF
; parƒmetros    ds:dx=ptr para filename
; retorno       nenhum
ShowText        PROC
                push    ax bx cx dx si di

                call    OpenFile                ; abre o ficheiro
                jc      @@end                   ; e sai se houve erro
                mov     bx, ax                  ; handle em bx
                call    DarkScr                 ; escurece o ecr„
                mov     al, TextColor
                call    HighColor               ; coloca a branco a cor do texto
                xor     di, di                  ; posi‡„o Y
@@next_line:    mov     cx, 45                  ; max. 45 chars por linha
                mov     si, OFFSET tmpstr
                call    GetLine                 ; lˆ uma linha de texto
                jc      @@done                  ; se houve erro salta
                call    StrLen                  ; calcula o tamanho da linha
                shl     cx, 3                   ; multiplica por 8
                mov     dx, MAXX
                sub     dx, cx                  ; dx = posi‡„o X no ecr„
                shr     dx, 1
                xchg    bx, di                  ; coloca em bx a posi‡„o Y
                mov     ah, TextColor           ; cor do texto
                call    PutStr                  ; escreve a string
                xchg    bx, di                  ; restaura Y e o handle
                add     di, CHAR_SZ             ; avan‡a para a pr¢xima linha
                cmp     di, (MAXY - 2*16)       ; se n„o chegamos ao fim do ecr„
                jb      @@next_line             ; lˆ nova linha

@@done:         call    CloseFile
                mov     si, OFFSET KeyToContinue$
                call    StrLen                  ; calcula o tamanho da linha
                shl     cx, 3                   ; multiplica por 8
                mov     dx, MAXX
                sub     dx, cx                  ; dx = posi‡„o X no ecr„
                shr     dx, 1
                mov     bx, (MAXY - 16)
                mov     ah, TextColor           ; cor do texto
                call    PutStr                  ; escreve a string
                call    ReadKey

@@end:          pop     di si dx cx bx ax
                ret
ShowText        ENDP

                end

