
;       string.asm
;       rotinas varias para manipula‡„o de strings ASCIIZ

;       Copyright (C) 1995, Carlos Ladeira


                jumps
                locals
                .286
                .model  small
                .code

                EXTRN   Toupper:NEAR
                PUBLIC  StrLen, StrCopy, StrCat, LastChar
                PUBLIC  StrUpper, StrNCmp, StrToNr


; StrLen        determina o tamanho de uma string ASCIIZ
; parƒmetros    ds:si=ptr para a string
; retorno       cx=n£mero de caracteres da string
StrLen          PROC
                push    ax si
                xor     cx, cx
                cld
@@loop:         lodsb
                or      al, al
                jz      @@end
                inc     cx
                jmp     @@loop
@@end:          pop     si ax
                ret
StrLen          ENDP

; StrCopy       copia uma string
; parƒmetros    ds:si=source
;               es:di=target
; retorno       nenhum
StrCopy         PROC
                push    ax si di
                cld
@@copy:         lodsb
                stosb
                or      al, al
                jnz     @@copy
                pop     di si ax
                ret
StrCopy         ENDP

; StrCat        adiciona uma string a outra
; parƒmetros    es:di=source
;               ds:si=target
; retorno       nenhum
StrCat          PROC
                push    cx si di ds es
                call    StrLen
                add     si, cx
                xchg    si, di
                push    ds es
                pop     ds es
                call    StrCopy
                pop     es ds di si cx
                ret
StrCat          ENDP

; LastChar      determina o £ltimo caracter de uma string
; parƒmetros    ds:si=ptr para a string
; retorno       al=£ltimo car cter
LastChar        PROC
                push    si
                cld
@@load:         lodsb
                or      al, al
                jnz     @@load
                mov     al, [si-2]
                pop     si
                ret
LastChar        ENDP

; StrUpper      transforma todas as letras de uma string em mai£sculas
; parƒmetros    ds:si=ptr para a string
; retorno       nenhum
StrUpper        PROC
                push    ax si
@@load:         mov     al, [si]
                or      al, al
                jz      @@end
                call    Toupper
                mov     [si], al
                inc     si
                jmp     @@load
@@end:          pop     si ax
                ret
StrUpper        ENDP

; StrNCmp       compara N caracteres de duas strings
; parƒmetros    ds:si=s1
;               es:di=s2
;               cx=N§ de caracteres a comparar
; retorno       CARRY=1 se forem iguais
;               CARRY=0 se forem diferentes
StrNCmp         PROC
                push    si di
                cld
                rep     cmpsb
                jne     @@mismatch
                stc
                jmp     @@end
@@mismatch:     clc
@@end:          pop     di si
                ret
StrNCmp         ENDP

; StrToNr       converte uma string para um n£mero
; parƒmetros    ds:si=ptr para a string
; retorno       ax=n£mero
StrToNr         PROC
                push    bx cx dx si
                mov     cx, 10
                xor     ax, ax
                xor     bh, bh
@@next:         mov     bl, [si]
                inc     si
                cmp     bl, '0'
                jb      @@end
                cmp     bl, '9'
                ja      @@end
                mul     cx
                sub     bl, '0'
                add     ax, bx
                jmp     @@next
@@end:          pop     si dx cx bx
                ret
StrToNr         ENDP

                end

