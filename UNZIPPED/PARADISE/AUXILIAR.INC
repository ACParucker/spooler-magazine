;здддд-д--Ы    З                                         З          З -д-ддд©
;|                    З   З -З-д-PARADiSE CiTYд--З- З   З                   |
;           .ээ З  эээээ  эээЗ  эээ   Зэээ Ч   эээ . ээщ   Зээээ   i        Ы
;З          чш ъ.  Ышш   чш ъш  ъэ шЗ чээЗ шш  ъэ.ъЗ шшЫ   шшЧ шш  N
;           эъъъшэ  чш.Ч эшъъш  чъъэ  шшЧ  чшЗ чъъЧэ шшЧ   чшЗ чшщ T        З
;Ы          чшэЧчш  чшщЗ чш Ччщ чшЫшщ шшщ. чшщ чшээщ чшщчщ шш. шш  R
;|           ъъъъ   ъъъ   ъ  ъ  .ъ  ъ ъъъ  ъъъ  ъъъ  .ъъъ  ъъъъъЫ  O        Ы
;Ё                   Coded By SyNeRGiE (C) Copyright 1994                   |
;юдддЗд--З-З З                                        З         З     Зд-ддды
;здддд-д--Ы    З                                         З          З -д-ддд©
;З PARA QUALQUER DUVIDA CONTACTAR:          PARADiSE CiTY BBS  (01) 4602328 |
;Ы Hugo Ferreira, 2:362/46 (FidoNet)        Paraceta do Barro, Alcoit└o     Ы
;|      SyNeRGiE, 96:6902/0 (KotoNet)       2765 ESTORIL                    З
;юдддЗд--З-З З                                        З         З     Зд-ддды
;здддд-д--Ы    З                                         З          З -д-ддд©
;Ы PROCEDURES                                                               З
;юдддЗд--З-З З                                        З         З     Зд-ддды
 GetKey PROC
   XOR     AX, AX
   INT     16h
   RET
 GetKey ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 HideCursor PROC
   MOV     AX, 0100h
   MOV     CX, 0800h
   INT     10h
   RET
 HideCursor ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 ShowCursor PROC
   MOV     AX, 0100h
   MOV     CX, 0607h
   INT     10h
   RET
 ShowCursor ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 SaveScreen PROC
   PUSH    DS
   CLD
   MOV     AX, DS
   MOV     ES, AX
   MOV     DI, OFFSET Screen
   MOV     AX, 0B800h
   MOV     DS, AX
   XOR     SI, SI
   MOV     CX, 2000
   REP     MOVSW
   POP     DS
   RET
 SaveScreen ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 RestoreScreen PROC
   PUSH    DS
   CLD
   MOV     AX, 0B800h
   MOV     ES, AX
   XOR     DI, DI
   MOV     si, OFFSET Screen
   MOV     CX, 2000
   REP     MOVSW
   POP     DS
   RET
 RestoreScreen ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 WaitRetrace PROC
   MOV     DX, 03DAh
 Retrace:
   IN      al, DX
   TEST    AL, 1000b
   JNZ     Retrace
 NoRetrace:
   IN      AL, DX
   TEST    AL, 1000b
   JZ      NoRetrace
   RET
 WaitRetrace ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 FadeOut PROC
   CLI
   MOV     CX, 64
 OneCycleO:
   XOR     BX, BX
 DecRegO:
   CMP     BYTE PTR [BP+768], 00h
   JE      ContinueO
   DEC     BYTE PTR [BP+768]
 ContinueO:
   INC     BP
   INC     BX
   CMP     BX, 768
   JL      DecRegO
   PUSH    CX
   MOV     CX, 768
   SUB     BP, 768
   XOR     BX, BX
   CALL    WaitRetrace
   CALL    WaitRetrace
   MOV     DX, 03C8h
   XOR     AL, AL
   OUT     DX, AL
   MOV     DX, 03C9h
 DumpPortO:
   MOV     AL, BYTE PTR [BP+768]
   OUT     DX, AL
   INC     BP
   INC     BX
   LOOP    DumpPortO
   POP     CX
   SUB     BP,768
   LOOP    OneCycleO
   STI
   RET
 FadeOut ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 FadeIn PROC
   CLI
   MOV     CX, 64
 OneCycleI:
   XOR     BX, BX
 DecRegI:
   MOV     DH, [BP]
   MOV     DL, [BP+768]
   CMP     DL, DH
   JE      ContinueI
   INC     BYTE PTR [BP+768]
 ContinueI:
   INC     BP
   INC     BX
   CMP     BX, 768
   JL      DecRegI
   PUSH    CX
   MOV     CX, 768
   SUB     BP, 768
   XOR     BX, BX
   CALL    WaitRetrace
   CALL    WaitRetrace
   MOV     DX, 03C8h
   XOR     AL, AL
   OUT     DX, AL
   MOV     DX, 03C9h
 DumpPortI:
   MOV     AL, [BP+768]
   OUT     DX, AL
   INC     BP
   INC     BX
   LOOP    DumpPortI
   POP     CX
   SUB     BP, 768
   LOOP    OneCycleI
   STI
   RET
 FadeIn ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 SavePalette PROC
   PUSH    BP
   CLI
   MOV     CX, 768
   MOV     DX, 03C7h
   XOR     AL, AL
   OUT     DX, AL
   MOV     DX, 03C9h
 GrabNext:
   IN      AL, DX
   and     AL, 3Fh
   MOV     BYTE PTR [BP], AL
   MOV     BYTE PTR [BP+768], AL
   INC     BP
   LOOP    GrabNext
   STI
   POP     BP
   RET
 SavePalette ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 RestorePalette PROC
   PUSH    BP
   CLI
   MOV     CX, 768
   MOV     DX, 03c8h
   XOR     AL, AL
   OUT     DX, AL
   MOV     DX, 03C9h
 DumpNext:
   MOV     AL, BYTE PTR [BP]
   OUT     DX, AL
   INC     BP
   LOOP    DumpNext
   STI
   POP     BP
   RET
 RestorePalette ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 SetMemAdd PROC
   MOV     DX, 03D4h
   MOV     AL, 0Ch
   MOV     AH, BH
   OUT     DX, AX
   INC     AL
   MOV     AH, BL
   OUT     DX, AX
   RET
 SetMemAdd ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 PanScreenUp PROC
   XOR     AX, AX
   MOV     AL, [BounceVal]
   MOV     SI, AX
   MOV     DI, OFFSET BounceSpeeds
   ADD     DI, SI
   MOV     BYTE PTR [DI-1], 02h
   MOV     BYTE PTR [DI-2], 04h
   MOV     BYTE PTR [DI-3], 08h
 StartPanUp:
   SUB     DI, SI
   CLI
   CALL    WaitRetrace
 PanUp:
   MOV     BX, [MemAdd]
   add     [MemAdd],80
   CALL    SetMemAdd
   MOV     BX, 0008h
   MOV     CX, 0010h
 PanSpeedUp:
   MOV     BH, BYTE PTR [DI]
   DEC     BH
 NextUBit:
   CALL    WaitRetrace
   MOV     DX, 03D4h
   MOV     AX, BX
   OUT     DX, AX
   ADD     BH, BYTE PTR [DI]
   SUB     CL, BYTE PTR [DI]
   INC     CL
   LOOP    NextUBit
   INC     DI
   DEC     SI
   JNZ     PanUp
   SUB     [MemAdd], 80
   STI
   RET
 PanScreenUp ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 PanScreenDown PROC
   XOR     AX,AX
   MOV     AL,[bounceval]
   MOV     SI,AX
   MOV     AX,DS
   MOV     ES,AX
   MOV     DI,OFFSET bouncespeeds
   MOV     CX,SI
   CLD
   MOV     AL,16
   REP     stosb
   SUB     DI,SI
   MOV     BYTE PTR [DI],02h
   MOV     BYTE PTR [DI+1],04h
   MOV     BYTE PTR [DI+2],08h
   CLI
   CALL    WaitRetrace
 PanDown:
   MOV     BX,[MemAdd]
   SUB     [MemAdd],80
   CALL    SetMemAdd
   MOV     BX,0f08h
   MOV     CX,0010h
 PanSpeedDown:
   SUB     bh,BYTE PTR [DI]
   INC     bh
 NextDBit:
   CALL    WaitRetrace
   MOV     DX, 03D4h
   MOV     AX, BX
   OUT     DX, AX
   SUB     BH, BYTE PTR [DI]
   SUB     CL, BYTE PTR [DI]
   INC     CL
   LOOP    NextDBit
   INC     DI
   DEC     SI
   JNZ     PanDown
   ADD     [MemAdd],80
   STI
   RET
 PanScreenDown ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 MakeSpace PROC NEAR
   PUSH    DS
   PUSHA
   MOV     AX, CS
   MOV     DS, AX
   MOV     AX, 0A000h
   MOV     ES, AX

   MOV     CX, 16
   MOV     DX, 184
   CLD
 GoAgain:
   PUSH    CX
;  MOV     DI, DX
;  MOV     BYTE PTR ES:[DI], 0      ;erase the star
   MOV     AH, 12
   MOV     AL, 0
   MOV     CX, 319
   INT     10h
   INC     DX
   POP     CX
   LOOP    GoAgain
   POPA
   POP     DS
   RET
 MakeSpace ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 MoveScroll PROC NEAR
   PUSH    DS
   PUSHA
   MOV     AX, 0A000H
   MOV     ES, AX
   MOV     DS, AX
   MOV     AX, CS:ScrollWidth
   MOV     BX, 320
   MUL     BX
   MOV     SI, AX
   MOV     DI, AX
   MOV     CX, CS:ScrollHeight
   CLD
 LINE:
   PUSH    CX
   INC     SI
   MOV     CX, 319
   REP     MOVSB
   INC     DI
   POP     CX
   LOOP    LINE
   POPA
   POP     DS
   RET
 MoveScroll ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 WhatLetter PROC NEAR
   PUSHA
 Begin:
   LEA     DX, Text
   MOV     BX, DX
   ADD     BX, LetterNum
   MOV     AL, CS:[BX]
   CMP     AL, 255
   JE      TextDone
   SUB     AL, 1
   MOV     CX, 256
   MUL     CX
   MOV     LetterOfs, AX
   JMP     ContText
 TextDone:
   MOV     LetterNum, 0
   MOV     LetterOfs, 0
   JMP     Begin
 ContText:
   POPA
   RET
 WhatLetter ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 PrintChar PROC NEAR
   PUSHA
   MOV     AX, 0A000H
   MOV     ES, AX
   MOV     AUXWord, 184
   LEA     SI, CS:FONT
   ADD     SI, LetterOfs
   ADD     SI, CS:BitRow

   MOV     CX, CS:ScrollHeight
   CLD
 Loop1:
   PUSH    CX
   MOV     AX, CS:AUXWord
   MOV     BX, 320
   MUL     BX
   ADD     AX, 319
   MOV     DI, AX
   MOV     CX, 1
   CLD
   REP     MOVSB
   ADD     SI, 15
   INC     AUXWord
   POP     CX
   LOOP    Loop1
   POPA
   RET
 PrintChar ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 PrintParadise PROC NEAR
   PUSHA
   MOV     AUXWord, 47
   MOV     AX, 0A000h
   MOV     ES, AX
   LEA     SI, PARADISE
   MOV     DX, 0
 Loop2:
   MOV     AX, AUXWord
   MOV     BX, 320
   MUL     BX
   ADD     AX, 57
   MOV     DI, AX
   MOV     CX, 205
   CLD
   REP     MOVSB
   INC     AUXWord
   CMP     AUXWord, 75
   JNE     Loop2
   POPA
   RET
 PrintParadise ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 PrintCity PROC NEAR
   PUSHA
   MOV     AUXWord, 84
   MOV     AX, 0A000h
   MOV     ES, AX
   LEA     SI, CiTY
 Loop3:
   MOV     AX, AUXWord
   MOV     BX, 320
   MUL     BX
   ADD     AX, 113
   MOV     DI, AX
   MOV     CX, 94
   CLD
   REP     MOVSB
   INC     AUXWord
   CMP     AUXWord, 111
   JNE     loop3
   POPA
   RET
 PrintCity ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 MakeStar PROC NEAR
   PUSHA
   MOV     AX, CS
   MOV     ES, AX
   MOV     DS, AX

   CMP     [NumActive], MaxStars
   JAE     NoEmptySpace
   MOV     SI, 0

 TryAgain:
   CMP     WORD PTR [Stars.Z+SI], 0
   JE      GotOne
   ADD     SI, StarStrucSize
   CMP     SI, MaxStars*StarStrucSize
   JB      TryAgain
   JMP     NoEmptySpace

 GotOne:
   MOV     DI, [Yindex]
   ADD     DI, DI
   MOV     AX, [StarPos+DI]
   SHL     AX, 3
   MOV     [Stars.Y+SI], AX

   MOV     DI, [Xindex]
   ADD     DI, DI
   MOV     AX, [StarPos+DI]
   SHL     AX, 3
   MOV     [Stars.X+SI], AX

   MOV     [Stars.Z+SI], MaxZpos
   INC     [NumActive]

   MOV     DI, [Cindex]
   MOV     AL, [ColorChart+DI]
   MOV     [Stars.Color+SI], AL

   INC     [Cindex]
   CMP     [Cindex], NumColors
   JB      OkColor
   MOV     [Cindex], 0

 OkColor:
   INC     [Yindex]
   CMP     [Yindex], NumRnds
   JB      YindNotZero
   SUB     [Yindex], NumRnds

 YindNotZero:
   INC     [Xindex]
   CMP     [Xindex], NumRnds
   JB      XindNotZero

   INC     [Yindex]
   MOV     AX, [Yindex]
   CMP     AX, [Xindex]
   JNE     NotTheSame
   INC     [Yindex]

 NotTheSame:
   MOV     [Xindex], 0
 XindNotZero:

 NoEmptySpace:
   POPA
   RET
 MakeStar ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З

 DisplayStars PROC NEAR
   PUSHA
   MOV     AX, CS
   MOV     DS, AX
   MOV     AX, 0A000h
   MOV     ES, AX

   MOV     SI, 0
   MOV     AUXWord, 0
 DispLoop:
   MOV     CX, [Stars.Z+SI]
   OR      CX, CX
   JE      Cont
   MOV     DI, [Stars.OldDi+SI]

   CMP     [Stars.GFX+SI], 0
   JNE     NotStar
   MOV     BYTE PTR ES:[DI], 0

 NotStar:
   CMP     CX, MinZpos
   JL      TermStar

   MOV     AX, [Stars.Y+SI]
   MOVSX   DX, AH
   SHL     AX, 8

   IDIV    CX
   ADD     AX, ScreenHeight/2
   MOV     DI, AX
   CMP     DI, ScreenHeight
   JAE     PreTermStar
   IMUL    DI, ScreenWidth

   MOV     AX, [Stars.X+SI]
   MOVSX   DX, AH
   SHL     AX, 8

   IDIV    CX
   ADD     AX, ScreenWidth/2
   CMP     AX, ScreenWidth
   JAE     PreTermStar
   ADD     DI,AX
   MOV     [Stars.OldDi+SI],DI
   MOV     CH, 20
   CMP     ES:[DI], 0
   JNE     NoPlotStar
   MOV     [Stars.GFX+SI], 0
   MOV     ES:[DI], CH
   JMP     GoOver
 NoPlotStar:
   MOV     [Stars.GFX+SI], 1
 GoOver:
   MOV     AX, CS:[WarpSpeed]
   SUB     CS:[Stars.Z+SI], AX
 Cont:
   ADD     SI, StarStrucSize
   CMP     SI, MaxStars*StarStrucSize
   JB      DispLoop
   POPA
   RET

 PreTermStar:
   MOV     [Stars.Z+SI], 1
   JMP     SHORT Cont

 TermStar:
   MOV     [Stars.Z+SI], 0
   DEC     [NumActive]
   JMP     SHORT Cont
 DisplayStars ENDP

;З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З  З   З Зд-ддддддЗд--З-З З