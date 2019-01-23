******************************************************************************
*                                                                            *
*  Programa ....: PRGED.PRG                                                  *
*  Programador .: Hugo Jorge Rodrigues Meneses                               *
*  Morada ......: 2¦ Travessa do Lazareto, N§ 1                              *
*               : 9000 Funchal / Madeira                                     *
*  Telefone     : 34975                                                      *
*  Data ........: Agosto de 1992                                             *
*                                                                            *
******************************************************************************
*                                                                            *
*  Notas para compilar o PRGED:                                              *
*  No directorio tem de estar os seguintes ficheiros:                        *
*     - PRGED.PRG                                                            *
*     - PE.PRG (Vem com o CLIPPER 5.01)                                      *
*  Criar os ficheiros objectos com:                                          *
*     - CLIPPER PRGED                                                        *
*     - CLIPPER PE                                                           *
*  Compilar com:                                                             *
*     - RTLINK FILE PRGED,PE                                                 *
*                                                                            *
*                                                                            *
******************************************************************************

SETCOLOR( "W+/B+,W+/R,B,B,W/N" )  && Cores

CLS
WINSHADE( 1, 20, 5, 60, 'ON' )
@ 3, 27 SAY "E D I T O R  D E  P R G 's"
WINSHADE( 7, 23, 9, 57, 'ON' )
@ 8, 26 SAY "Escolha o arquivo desejado:"

PRIVATE vdir[ADIR("*.PRG")]
editar := ' '

ADIR("*.PRG",vdir)
WINSHADE( 11, 31, 21, 47, 'ON' )
vop := ACHOICE(12, 33, 20, 45, vdir)

IF vop = 0  // ESCAPE
   SET COLOR TO
   CLS
   QUIT
ENDIF

cFile = vdir[vop]

CLS
WINSHADE( 1, 20, 5, 60, 'ON' )
@ 3, 26 SAY "E D I T O R  D E  P R G 's"

cEd = ";;Ficheiro escolhido: " + cFile + ";Editar o ficheiro ? "
nOpcoes := { " Sim ", " N„o "}

nEditar := ALERT(cEd,nOpcoes)

IF nEditar = 1
   PE ( cFile )
   SET COLOR TO
   CLS
ELSE
   SET COLOR TO
   CLS
   QUIT
ENDIF

*
* End Of Program
*

FUNCTION WinShade( nT, nL, nB, nR, cSet)

STATIC cWinScr := {}
STATIC nEl := 0

IF cSET == 'ON'
   Aadd(cWinScr,SaveScreen( nT, nL, nB+1, nR+1) )
   nEl++
   RestScreen( nT+1, nL+1, nB+1, nR+1, ;
   Transform( SaveScreen( nT+1, nL+1, nB+1, nR+1), ;
   Replicate("X" + Chr(7), Len( SaveScreen( nT+1, nL+1, nB+1, nR+1)) )))
   @ nT, nL CLEAR TO nB, nR
   @ nT, nL TO nB, nR DOUBLE
ELSE
   RestScreen( nT, nL, nB+1, nR+1,cWinScr[nEl])
   Adel( cWinScr, nEl)
   Asize( cWinScr, --nEl)
ENDIF

RETURN NIL
