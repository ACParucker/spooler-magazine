
;       loader.asm
;       rotinas para leitura do ficheiro de dados

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small

                .data

                PUBLIC  ZIPS_dir$

ZIPS_dir$       db      'SPOOLER\', 0

                .data?

                PUBLIC  Items, NrItems, CurrItem, tmpstr, ProgTitle
                PUBLIC  BasePath, Scr1stItem
                EXTRN   DataFilePath, ProgPath

Items           LABEL   Item
                DB      MAX_ITEMS*ITEM_SZ       dup(?)
NrItems         DB      ?
CurrItem        DB      ?
Scr1stItem      DB      ?
tmpstr          DB      81 dup(?)
ProgTitle       DB      81 dup(?)
BasePath        DB      81 dup(?)

                .code

                PUBLIC  ReadDataFile
                EXTRN   OpenFile:NEAR, GetLineData:NEAR, CloseFile:NEAR
                EXTRN   StrUpper:NEAR, StrCopy:NEAR, StrCat:NEAR
                EXTRN   StrToNr:NEAR, FileExist:NEAR

ReadDataFile    PROC
                push    bx cx dx si di
                mov     dx, OFFSET DataFilePath
                call    OpenFile
                jc      @@done
                mov     bx, ax
                mov     cx, 80                          ; read title
                mov     si, OFFSET ProgTitle
                call    GetLineData
                jc      @@done
                mov     si, OFFSET BasePath             ; read base directory
                call    GetLineData
                jc      @@done
                call    StrUpper

                mov     NrItems, 0
                mov     di, OFFSET Items
@@NextItem:     mov     cx, 58                          ; read iten description
                mov     si, di
                call    GetLineData
                jc      @@end

                add     si, ZipFile                     ; read item zip file
                mov     cx, 12
                call    GetLineData
                jc      @@end
                call    StrUpper

                mov     si, di
                add     si, Directory                   ; read item directory
                mov     cx, 80
                call    GetLineData
                jc      @@end
                call    StrUpper

                push    di                              ; verifica a existˆncia
                mov     si, OFFSET ProgPath             ; do ficheiro ZIP
                mov     di, OFFSET tmpstr
                call    StrCopy
                mov     si, di

                mov     di, OFFSET ZIPS_dir$
                call    StrCat

                pop     di
                push    di
                add     di, ZipFile
                call    StrCat
                pop     di
                mov     dx, si
                call    FileExist
                jc      @@NextItem

                mov     si, offset tmpstr               ; read zip file size
                mov     cx, 5
                call    GetLineData
; n„o faz o teste de erro, pois pode ser o EOF
;               jc      @@end
                call    StrToNr
                or      ax, ax
                jz      @@NextItem
                mov     [di].SizeKB, ax
                mov     [di].Active, -1

                add     di, ITEM_SZ
                inc     NrItems
                cmp     NrItems, MAX_ITEMS
                jne     @@NextItem

@@end:          call    CloseFile
                mov     CurrItem, 1
                mov     Scr1stItem, 1
                cmp     NrItems, 1
                jge     @@done
                stc
                mov     ax, -1

@@done:         pop     di si dx cx bx
                ret
ReadDataFile    ENDP

                end

