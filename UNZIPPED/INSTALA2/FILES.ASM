
;       fileio.asm
;       rotinas para leitura de ficheiros utilizando o DOS

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small

                .data?
tmp             DB      ?
                
                .code

                PUBLIC  FileExist, OpenFile, CloseFile, ReadFile, GetChar
                PUBLIC  GetLine, GetLineData

; FileExist     determina a existˆncia de um ficheiro
; parƒmetros    ds:dx=ptr para o nome do ficheiro
; retorno       CARRY=0 se existir
;                    =1 se n„o existir e ax=c¢digo de erro
FileExist       PROC
                push    cx
                mov     ah, 4Eh
                xor     cx, cx
                int     DOS
                pop     cx
                ret
FileExist       ENDP

; OpenFile      abre um ficheiro existente s¢ para leitura
; parƒmetros    ds:dx=ptr para o nome do ficheiro
; retorno       ax=handle caso a opera‡„o sˆja bem sucedida
;               CARRY=1 em caso de erro e ax=c¢digo de erro
OpenFile        PROC
                mov     ax, 3D00h
                int     DOS
                ret
OpenFile        ENDP

; CloseFile     fecha um ficheiro previamente aberto
; parƒmetros    bx=handle
;               CARRY=1 em caso de erro e ax=c¢digo de erro
CloseFile       PROC
                mov     ah, 3Eh
                int     DOS
                ret
CloseFile       ENDP

; ReadFile      lˆ n bytes de um ficheiro
; parƒmetros    bx=handle do ficheiro
;               ds:dx=buffer para colocar os dados lidos
;               cx=n£mero de bytes a ler
; retorno       ax=n£mero de bytes lidos
;               CARRY=1 em caso de erro e ax=c¢digo de erro
ReadFile        PROC
                mov     ah, 3Fh
                int     DOS
                jc      @@end
                or      ax, ax
                jnz     @@end
                stc
@@end:          ret
ReadFile        ENDP

; GetChar       lˆ um byte do ficheiro com o handle em bx
; parƒmetros    bx=handle do ficheiro
; retorno       al=byte lido
;               CARRY=1 em caso de erro
GetChar         PROC
                push    cx dx
                mov     dx, OFFSET tmp
                mov     cx, 1
                call    ReadFile
                jc      @@end_getch
                mov     al, tmp
@@end_getch:    pop     dx cx
                ret
GetChar         ENDP

; GetLine       lˆ uma linha de texto de um ficheiro
; parƒmetros    bx=handle
;               cx=tamanho m ximo da linha
;               ds:si=buffer
; retorno       carry=1 em caso de erro
GetLine         PROC
                cld
                push    ax cx di
                mov     di, si
@@read_char:    call    GetChar
                jc      @@end
                cmp     al, 13                  ; fim da linha ?
                je      @@eol
                stosb
                loop    @@read_char
@@find_eol:     call    GetChar
                jc      @@end
                cmp     al, 13
                jne     @@find_eol
@@eol:          call    GetChar                 ; passa o LF
                jc      @@end
                clc
@@end:          pushf
                xor     al, al
                stosb
                popf
                pop     di cx ax
                ret
GetLine         ENDP

; GetLineData   lˆ uma linha de texto com texto
; parƒmetros    bx=handle
;               cx=tamanho m ximo da linha
;               ds:si=buffer
; retorno       carry=1 em caso de erro
GetLineData     PROC
@@read_line:    call    GetLine
                jc      @@end
                cmp     byte ptr [si], 0
                je      @@read_line
                cmp     byte ptr [si], '*'
                je      @@read_line
                clc
@@end:          ret
GetLineData     ENDP

                end

