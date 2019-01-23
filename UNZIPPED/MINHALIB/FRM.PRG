******************************************************************************
*                                                                            *
*  Programa ....: FRM.PRG                                                    *
*  Programador .: Hugo Jorge Rodrigues Meneses                               *
*  Morada ......: 2¦ Travessa do Lazareto, N§ 1                              *
*               : 9000 Funchal / Madeira                                     *
*  Telefone     : 34975                                                      *
*  Data ........: 8 de Junho de 1993                                         *
*                                                                            *
******************************************************************************

//

IF IsColor()
   cCores := "W+/B+,W+/R+,B,B,W+/B"   // CORES
ELSE
   cCores := "N/W,W/N,N,N,W/N"       // MONOCROMATICO
ENDIF

SetColor(cCores)

//      >>>>>>>>>>>>    DBF

Mat()
Mess24("(c) Hugo Meneses 1993")
@ 1, 2 SAY Centrar(Expandir("FRM's TO PRINTER", 1), 76)

PRIVATE vdir[ADIR("*.DBF")]

If ADIR("*.DBF") = 0
   Mensagem("Nao existem bases de dados para trabalhar!!!", 8, 1)
   Set Color To
   Cls
   Quit
EndIf

WinShade( 7, 23, 9, 57, 'ON' )
@ 8, 26 SAY "Escolha o arquivo desejado:"

ADIR("*.DBF",vdir)
WinShade( 11, 31, 21, 47, 'ON' )
vop := ACHOICE(12, 33, 20, 45, vdir)

If vop = 0  // ESCAPE
   Set Color To
   Cls
   Quit
EndIf

cFileDBF := vdir[vop]

//      >>>>>>>>>>>>    NTX

Mat()
Mess24("(c) Hugo Meneses 1993")
@ 1, 2 SAY Centrar(Expandir("FRM's TO PRINTER", 1), 76)

PRIVATE vdir[ADIR("*.NTX")]

If ADIR("*.NTX") = 0
   Mensagem("Nao existem indices para trabalhar!!!", 8, 1)
   Set Color To
   Cls
   Quit
EndIf

WinShade( 7, 23, 9, 57, 'ON' )
@ 8, 26 SAY "Escolha o arquivo desejado:"

ADIR("*.NTX",vdir)
WinShade( 11, 31, 21, 47, 'ON' )
vop := ACHOICE(12, 33, 20, 45, vdir)

IF vop = 0  // ESCAPE
   SET COLOR TO
   CLS
   QUIT
ENDIF

cFileNTX := vdir[vop]

//      >>>>>>>>>>>>    FRM

Mat()
Mess24("(c) Hugo Meneses 1993")
@ 1, 2 SAY Centrar(Expandir("FRM's TO PRINTER", 1), 76)

PRIVATE vdir[ADIR("*.FRM")]

If ADIR("*.FRM") = 0
   Mensagem("Nao existem ficheiros FRM para trabalhar!!!", 8, 1)
   Set Color To
   Cls
   Quit
EndIf

WinShade( 7, 23, 9, 57, 'ON' )
@ 8, 26 SAY "Escolha o arquivo desejado:"

ADIR("*.FRM",vdir)
WinShade( 11, 31, 21, 47, 'ON' )
vop := ACHOICE(12, 33, 20, 45, vdir)

IF vop = 0  // ESCAPE
   Set Color To
   Cls
   Quit
ENDIF

cFileFRM := vdir[vop]

//      >>>>>>>>>>>>    Listagem Printer / Screen & File

Mat()
Mess24("(c) Hugo Meneses 1993")
@ 1, 2 SAY Centrar(Expandir("FRM's TO PRINTER", 1), 76)

cTitulo = ";;Ficheiro escolhido: " + cFileFRM
nOpcoes := { " Imprimir ", " Ficheiro de Texto ", " Cancelar " }

nImp_FRM := ALERT(cTitulo, nOpcoes)

If nImp_FRM = 1

   If TestarPrinter()           // Testar a impressora
      LigaPrinter()
   Else
      Set Color To
      Cls
      Quit
   EndIf

   Use (cFileDBF) Index (cFileNTX) New
   Report Form (cFile) To Printer

ElseIf nImp_FRM = 2

   Cls

   Use (cFileDBF) Index (cFileNTX) New

   cFicheiroTexto := ( SubStr( cFileFRM, 1, At( ".", cFileFRM ) ) ) + "TXT"

   Report Form (cFileFRM) To File (cFicheiroTexto)

Else

   Set Color To
   Cls
   Quit

EndIf

Close All
Select 1

If IsPrinter()
   DesligaPrinter()
EndIf

Mensagem("OPERACAO CONCLUIDA. Prima qualquer tecla para continuar...", 8, 1)
Set Color To
Cls
Quit

*
* End Of Program
*

*******************************************************************************
//                                   F i m
*******************************************************************************
