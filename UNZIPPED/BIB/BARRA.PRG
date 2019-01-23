#define B_LEN           9
#define B_TOP           1
#define B_LEFT          2
#define B_BOTTOM        3
#define B_RIGHT         4
#define B_BACKCOLOR     5
#define B_BARCOLOR      6
#define B_DISPLAYNUM    7
#define B_BARCHAR       8
#define B_PERCENT       9

#define B_BOXLINES      "ÚÄ¿³ÙÄÀ³"

FUNCTION BarraNova( nTop, nLeft, nBottom, nRight, ;
                 cBackColor, cBarColor, cBarCharacter )
   LOCAL aHandle[ B_LEN ]

   // Assign default values
   aHandle[ B_TOP ]        := nTop
   aHandle[ B_LEFT ]       := nLeft
   aHandle[ B_BOTTOM ]     := nBottom
   aHandle[ B_RIGHT ]      := nRight
   aHandle[ B_BACKCOLOR ]  := "W/N"
   aHandle[ B_BARCOLOR ]   := "W+/N"
   aHandle[ B_DISPLAYNUM ] := .T.
   aHandle[ B_BARCHAR ]    := CHR( 219 )
   aHandle[ B_PERCENT ]    := 0

   IF cBackColor <> NIL
      aHandle[ B_BACKCOLOR ] := cBackColor
   ENDIF
   IF cBarColor <> NIL
      aHandle[ B_BARCOLOR ] := cBarColor
   ENDIF
   IF cBarCharacter <> NIL
      aHandle[ B_BARCHAR ] := cBarCharacter
   ENDIF

   IF aHandle[ B_RIGHT ] < aHandle[ B_LEFT ] + 4
      aHandle[ B_RIGHT ] := aHandle[ B_LEFT ] + 4
   ENDIF

   IF aHandle[ B_BOTTOM ] < aHandle[ B_TOP ] + 2
      aHandle[ B_BOTTOM ] := aHandle[ B_TOP ] + 2
   ENDIF

   IF aHandle[ B_RIGHT ] < aHandle[ B_LEFT ] + 9
      aHandle[ B_DISPLAYNUM ] := .F.
   ENDIF

   RETURN( aHandle )

********************************
FUNCTION BarraDisplay( aHandle )
   LOCAL nCenter := ROUND((aHandle[ B_RIGHT ] - aHandle[ B_LEFT ]) / 2, 0 ) + 1
   LOCAL cOldColor := SETCOLOR( aHandle[ B_BACKCOLOR ] )

   @ aHandle[ B_TOP ], aHandle[ B_LEFT ] CLEAR TO ;
     aHandle[ B_BOTTOM ], aHandle[ B_RIGHT ]

   @ aHandle[ B_TOP ], aHandle[ B_LEFT ], ;
     aHandle[ B_BOTTOM ], aHandle[ B_RIGHT ] BOX B_BOXLINES

   IF aHandle[ B_DISPLAYNUM ]
      @ aHandle[ B_TOP ], nCenter SAY "[      ]"
   ENDIF

   SETCOLOR( cOldColor )

   // Draw bar to show current percent
   BarraUpdate( aHandle, aHandle[ B_PERCENT ] )

   RETURN( aHandle )

******************************************
FUNCTION BarraUpdate( aHandle, nPercent )
   LOCAL nCenter := ROUND((aHandle[ B_RIGHT ] - aHandle[ B_LEFT ]) / 2, 0 ) + 1
   LOCAL cOldColor := SETCOLOR( aHandle[ B_BARCOLOR ] )
   LOCAL nBarRatio := (aHandle[ B_RIGHT ]) - (aHandle[ B_LEFT ] + 1)
   LOCAL nRow := 0, nCols := 0

   IF aHandle[ B_DISPLAYNUM ]
      @ aHandle[ B_TOP ], nCenter + 2 SAY STR( nPercent * 100, 3 ) + "%"
   ENDIF

   IF nPercent > 1
      nPercent := 1
   ENDIF

   IF nPercent < 0
      nPercent := 0
   ENDIF

   nCols := ROUND( nPercent * nBarRatio, 0 )

   @ aHandle[ B_TOP ] + 1, aHandle[ B_LEFT ] + 1 CLEAR TO ;
     aHandle[ B_BOTTOM ] - 1, aHandle[ B_RIGHT ] - 1

   FOR nRow := 1 TO (aHandle[ B_BOTTOM ] - aHandle[ B_TOP ] - 1)
      @ nRow + aHandle[ B_TOP ], aHandle[ B_LEFT ] + 1 SAY ;
        REPLICATE( aHandle[ B_BARCHAR ], nCols )
   NEXT

   SETCOLOR( cOldColor )

   RETURN( aHandle )

*****************************************
* Fim de Ficheiro.
