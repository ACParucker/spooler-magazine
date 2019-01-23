
;       main.asm
;       main program

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small
                .stack  STACK_SIZE
                .data
                PUBLIC  Copyright$

Copyright$      DB      13,10,'INSTALA v2.00  Copyright (C) 1995  Carlos Ladeira'
                DB      13,10,'InterNET (e-mail): carlos.ladeira@skyship.alce.pt'
                DB      13,10,'100% Assembly!!!'
                DB      13,10,'$'

BadDosVer$      DB      '‚ necess rio a vers„o do DOS 3.2.',13,10,'$'
BadEnvStr$      DB      'ambiente do DOS currompido.',13,10,'$'
BadCpuType$     DB      '‚ necess rio pelo menos um processador 286.',13,10,'$'
BadDataFile$    DB      'ficheiro INSTALA.DAT mal construido',13,10,'$'
NoInstalaDat$   DB      '‚ necess rio o ficheiro INSTALA.DAT',13,10,'$'
NoPkunzjr$      DB      '‚ necess rio o ficheiro PKUNZJR.COM',13,10,'$'
RealockErr$     DB      'problemas na realoca‡„o da mem¢ria',13,10,'$'

PkunzjrCom$     DB      'PKUNZJR.COM', 0
InstalaDat$     DB      'INSTALA.DAT', 0
InstalaShw$     DB      'INSTALA.SHW', 0

                .data?

                PUBLIC  PkunzjrPath, DataFilePath, ShowFilePath
                PUBLIC  ProgPath, VGA, VideoMode, Palette, PSP

PkunzjrPath     DB      81 dup(?)
DataFilePath    DB      81 dup(?)
ShowFilePath    DB      81 dup(?)
ProgPath        DB      81 dup(?)
Palette         DB      768 dup(?)
VideoMode       DB      ?
VGA             DB      ?
ShowFilePresent DB      ?
PSP             DW      ?

                .code

                EXTRN   GetPalette:NEAR, FadeOut:NEAR, ReadKey:NEAR
                EXTRN   FadeIn:NEAR, Beep:NEAR, SetPalette:NEAR
                EXTRN   GetMode:NEAR, SetMode:NEAR, ClearPal:NEAR
                EXTRN   Print:NEAR, Exit:NEAR, ErrorMsg:NEAR, IsVGA:NEAR
                EXTRN   StrCat:NEAR, StrCopy:NEAR, FileExist:NEAR
                EXTRN   Toupper:NEAR, ReadDataFile:NEAR, Menu:NEAR
                EXTRN   ShowImages:NEAR, Init80x25Mode:NEAR, Is286:NEAR
                EXTRN   ClearTxtMode:NEAR

main            PROC
                ; sets ds
                mov     ax, @DATA
                mov     ds, ax
                mov     PSP, es

                ; check dos version. must be above 3.2
                call    CheckDOS32

                ; resize memory block for the program
                mov     bx, ss
                mov     ax, es
                sub     bx, ax
                add     bx, (STACK_SIZE+1)/16
                mov     ah, 4Ah
                int     DOS
                jnc     @@realock_ok
                mov     dx, OFFSET RealockErr$
                call    ErrorMsg
@@realock_ok:

                ; copy to ProgPath the directory where the program is being
                ; executed. ex. C:\LING\ASM\OUT\
                call    GetProgPath
                push    ds
                pop     es

                ; check the existence of the faloing files: INSTALA.DAT,
                ; PKUNZJR.EXE and INSTALA.SHW in the same directory as
                ; the executable INSTALA.EXE
                call    CheckFiles

                ; verifica o tipo do processador
                call    Is286
                jc      @@286_ok
                mov     dx, OFFSET BadCpuType$
                call    ErrorMsg
@@286_ok:

                ; load data file
                call    ReadDataFile
                jnc     @@LoadDataOk

                mov     dx, OFFSET BadDataFile$
                call    ErrorMsg
@@LoadDataOk:

                ; check for a VGA graphic card
                mov     VGA, 0
                call    IsVGA
                jnc     @@no_vga
                mov     VGA, 1
@@no_vga:

                ; save current video mode
                call    GetMode
                mov     VideoMode, al

                test    VGA, 1
                jz      @@do_menu

                ; save current palette
                mov     di, offset Palette
                call    GetPalette

                ; fadeout the screen
                call    FadeOut

                test    ShowFilePresent, 1
                jz      @@do_menu

                call    ShowImages

@@do_menu:      call    Init80x25Mode
                call    Menu            ; main program loop

                test    VGA, 1
                JZ      @@set_mode
                call    FadeOut

@@set_mode:     call    ClearTxtMode

                ; restore initial video mode
                mov     al, VideoMode
                call    SetMode

                test    VGA, 1
                jz      @@print_cw

                ; set all colors in the current pallete to black
                call    ClearPal

@@print_cw:     ; print the copyright message on the screen
                mov     dx, OFFSET Copyright$
                call    Print

                test    VGA, 1
                jz      @@end

                ; fadein the screen to the initial palette
                mov     si, offset Palette
                call    FadeIn

                ; return to dos with errorlevel=0
@@end:          xor     al, al
                call    Exit
main            ENDP

; CheckFiles    verifica a existˆncia dos ficheiros PKUNZJR.COM e INSTALA.DAT
;               verifica ainda se existe o ficheiro INSTALA.SHW
; parƒmetros    nenhum
; retorno       nenhum; sai para o dos se n„o encontrar os dois 1§s ficheiros
CheckFiles      PROC
                push    dx si di
                mov     si, OFFSET ProgPath
                mov     di, OFFSET PkunzjrPath
                call    StrCopy
                mov     si, di
                mov     di, OFFSET PkunzjrCom$
                call    StrCat
                mov     dx, si
                call    FileExist
                mov     dx, OFFSET NoPkunzjr$
                jc      @@missing_file
                mov     si, OFFSET ProgPath
                mov     di, OFFSET DataFilePath
                call    StrCopy
                mov     si, di
                mov     di, OFFSET InstalaDat$
                call    StrCat
                mov     dx, si
                call    FileExist
                mov     dx, OFFSET NoInstalaDat$
                jc      @@missing_file
                mov     si, OFFSET ProgPath
                mov     di, OFFSET ShowFilePath
                call    StrCopy
                mov     si, di
                mov     di, OFFSET InstalaShw$
                call    StrCat
                mov     dx, si
                mov     ShowFilePresent, 0
                call    FileExist
                jc      @@no_show
                mov     ShowFilePresent, 1
@@no_show:      pop     di si dx
                ret
@@missing_file: call    ErrorMsg
CheckFiles      ENDP

; CheckDOS32    verica a vers„o do DOS
; parƒmetros    nenhum
; retorno       sai para o DOS se a ver. < 3.20
CheckDOS32      PROC
                push    ax dx
                mov     ah, 30h
                int     DOS
                cmp     al, 3
                ja      @@dos_ok
                jb      @@bad_dos
                cmp     ah, 2
                jae     @@dos_ok
@@bad_dos:      mov     dx, OFFSET BadDosVer$
                call    ErrorMsg
@@dos_ok:       pop     dx ax
                ret
CheckDOS32      ENDP
                             
; GetProgPath   lˆ para uma string a path do executavel
; parƒmetros    es=program segment prefix
; retorno       em caso de erro sai para o DOS
GetProgPath     PROC
                push    ax bx cx si di ds es
                mov     si, OFFSET ProgPath
                cld
                xor     al, al
                mov     es, word ptr es:[2Ch]
                xor     di, di
                mov     cx, 7FFFh
@@next_str:     repne   scasb
                jne     @@bad_env
                cmp     byte ptr es:[di], 0
                jne     @@next_str
                add     di, 3
                xchg    di, si
                push    ds es
                pop     ds es
                mov     bx, di
@@next:         lodsb
                call    Toupper
                or      al, al
                jnz     @@not_zero
                mov     di, bx
@@not_zero:     stosb
                jz      @@end_str
                cmp     al, '\'
                jne     @@next
                mov     bx, di
                jmp     @@next
@@end_str:      pop     es ds di si cx bx ax
                ret
@@bad_env:      mov     ax, @DATA
                mov     ds, ax
                mov     dx, OFFSET BadEnvStr$
                call    ErrorMsg
GetProgPath     ENDP

                end     main
