;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;|                   ú   ú -ú-Ä-PARADiSE CiTYÄ--ú- ú   ú                    |
;ù          .ÜÜ ú  ÜÜÜÜÜ  ÜÜÜú  ÜÜÜ   úÜÜÜ þ   ÜÜÜ . ÜÜÝ   úÜÜÜÜ   i        ù
;ú          ÞÛ ß.  ùÛÛ   ÞÛ ßÛ  ßÜ Ûú ÞÜÜú ÛÛ  ßÜ.ßú ÛÛù   ÛÛþ ÛÛ  N
;           ÜßßßÛÜ  ÞÛ.þ ÜÛßßÛ  ÞßßÜ  ÛÛþ  ÞÛú ÞßßþÜ ÛÛþ   ÞÛú ÞÛÝ T        ú
;ù          ÞÛÜþÞÛ  ÞÛÝú ÞÛ þÞÝ ÞÛùÛÝ ÛÛÝ. ÞÛÝ ÞÛÜÜÝ ÞÛÝÞÝ ÛÛ. ÛÛ  R
;|           ßßßß   ßßß   ß  ß  .ß  ß ßßß  ßßß  ßßß  .ßßß  ßßßßßù  O        ù
;³                   Coded By SyNeRGiE (C) Copyright 1994                   |
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;ú PARA QUALQUER DUVIDA CONTACTAR:          PARADiSE CiTY BBS  (01) 4602328 |
;ù Hugo Ferreira, 2:362/46 (FidoNet)        Paraceta do Barro, Alcoit„o     ù
;|      SyNeRGiE, 96:6902/0 (KotoNet)       2765 ESTORIL                    ú
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;ù PROGRAM DEFENiTiONS                                                      ú
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
    DOSSEG
    .MODEL SMALL
    .STACK 200h
    .CODE
    .386
    ASSUME CS:@CODE, DS:@CODE
    LOCALS

;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;ù iNCLUDED DATA FiLES                                                      ú
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
INCLUDE ANSi.iNC
INCLUDE AUXiLiAR.iNC
INCLUDE CiTY.iNC
INCLUDE FONT.iNC
INCLUDE PALETTE.iNC
INCLUDE PARADiSE.iNC
INCLUDE STARPOS.iNC
INCLUDE TEXT.iNC

;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;ù DATA STRUCTURES                                                          ú
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
 Star_Struc      STRUC
         X       DW  0
         Y       DW  0
         Z       DW  0
         OldDi   DW  0
         GFX     DB  0
         Color   DB  0
 Star_Struc      ENDS

 StarStrucSize = 9

;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;ù DATA                                                                     ú
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
 ScreenWidth     EQU 320
 ScreenHeight    EQU 184
 NumRnds         EQU 400
 MaxZpos         EQU 4096
 MinZpos         EQU 2
 MaxStars        EQU 190
 NumColors       EQU 5
 Video           EQU 0A000h
 TextSeg         EQU 0B800h
 WarpSpeed       DW  50
 MaxWarp         EQU 90
 Xindex          DW  30
 Yindex          DW  230
 ScrollHeight    DW  16
 ScrollWidth     DW  184
 MemAdd          DW  1920
 BounceVal       DB  25
 BounceSpeeds    DB  25 dup(16)
 StartX          DB  ?
 StartY          DB  ?
 AUXWord         DW  0
 BitRow          DW  ?
 LetterOfs       DW  0
 LetterNum       DW  0
 NumActive       DW  0
 Cindex          DW  0
 ColorChart      DB  0,16,32,48,64,80
 Stars           Star_Struc MaxStars DUP (<>) ;where all the data is held
 PaletteBuffer   DB  768*2 dup(?)
 Screen          DB  4000 dup(?)
 Coder           DB 13, 10, 'iNTRO Coded áy SyNeRGiE (C) 1994 - Call PARADiSE CiTY +351-1-4602328', 13, 10, '$'

;ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
;ù MAiN CODE                                                                ú
;ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
START:

   MOV     AX, CS
   MOV     DS, AX
   MOV     ES, AX

   MOV     AH, 3
   MOV     BH, 0
   INT     10h
   MOV     StartX, DH
   MOV     StartY, DL

   CALL    HideCursor
   CALL    SaveScreen
   MOV     BP, OFFSET PaletteBuffer
   CALL    SavePalette
   CALL    FadeOut

   MOV     AX, 0013h
   INT     10h

   MOV     DX, OFFSET Palette
   MOV     AX, 1012h
   MOV     BX, 0
   MOV     CX, 256
   INT     10h

   MOV     BitRow, 0
   MOV     LetterNum, 0

   CALL    PrintParadise
   CALL    PrintCity
   CALL    WhatLetter

   MOV     AL, 01111010b
   OUT     21h, AL

StarLoop:
   CALL    MakeStar
   CALL    MakeStar
   CALL    MakeStar
   CALL    WaitRetrace
   CALL    DisplayStars
   CALL    PrintChar
   CALL    MoveScroll

   INC     BitRow
   CMP     BitRow, 16
   JNE     GoNext
   MOV     BitRow, 0
   CALL    WaitRetrace
   CALL    MakeSpace
   INC     LetterNum
   CALL    WhatLetter
   CALL    MoveScroll

GoNext:

   IN   AL, 60h
   CMP  AL, 1
   JNE  StarLoop

   MOV     AL, 0
   OUT     21h, AL

   MOV     AX, 0003h
   INT     10h

   MOV     AX, 0501h
   INT     10h
   MOV     AX, 0B800h
   MOV     ES, AX
   XOR     AX, AX
   MOV     DI, 4000
   MOV     CX, 2000
   REP     STOSW
   CALL    WaitRetrace
   CALL    RestorePalette
   CALL    SavePalette
   XOR     DI, DI
   MOV     SI, OFFSET ANSiLOGO
   MOV     CX, 2000
   REP     MOVSW
Bounce:
   CALL    PanScreenDown
   SUB     [bounceval], 05h
   CMP     [bounceval], 00h
   JLE     NoBounce
   CALL    PanScreenUp
   CALL    WaitRetrace
   JMP     Bounce
NoBounce:
   CALL    GetKey
   MOV     AX, 0500h
   INT     10h
   MOV     BP, OFFSET PaletteBuffer
   CALL    FadeOut
   CALL    RestoreScreen
   MOV     BP, OFFSET PaletteBuffer
   CALL    FadeIn
   CALL    ShowCursor

   MOV     AH, 2
   MOV     BH, 0
   MOV     DH, StartX
   MOV     DL, StartY
   INT     10h

   LEA     DX, Coder
   MOV     AH, 9
   INT     21h
   MOV     AX, 4C00h
   INT     21h
END START
