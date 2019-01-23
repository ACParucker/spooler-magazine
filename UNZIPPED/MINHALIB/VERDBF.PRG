******
*
*  Programa ....: VERDBF.PRG
*  Programador .: Hugo Jorge Rodrigues Meneses
*  Morada ......: 2¦ Travessa do Lazareto, N§ 1
*               : 9000 Funchal / Madeira
*  Telefone ....: 34 975
*  Data ........: Outubro e Dezembro de 1993
*
******

//

#INCLUDE "INKEY.CH"
#INCLUDE "SET.CH"

//

Set Message To 21 Center
Setcursor(3)
Set Scoreboard Off
Set Delimiters Off
Set Delimiters On
Set Delimiters To "[]"
Set Confirm On
Set Deleted On  // Para nao ver os registos apagados
Set Escape Off  // Para nao sair dos read com o Escape
Set Wrap On
Set Date To British

//

IF IsColor()
   cCores := "W+/B+,W+/R,B,B,W+/B"   // CORES
ELSE
   cCores := "N/W,W/N,N,N,W/N"       // MONOCROMATICO
ENDIF

//

DIRECT = Curdir()

SETCANCEL(.F.)                 // Disable termination keys
SET KEY K_ALT_C TO ALTC        // Redefinir ALT-C para a funcao ALTC

SET KEY K_F1 TO         // Redefinir F1 (para podermos ver o Help da
                        // funcao FDBEDITPlus

//

Set Cursor On
Cls

Setcolor(cCores)
Fundo()
@ 1, 2 SAY Centrar(Expandir("VISUALIZA€AO DE BASES DE DADOS", 1), 76)
Mess24("VER (c) Hugo Jorge Rodrigues Meneses 1993")
Explode(12, 10, 18, 70)

// Variaveis
cNome := Space(32)
cIndex1 := Space(16)
cIndex2 := Space(16)

cConfirmar := " Nao "

Do While cConfirmar = " Nao "

   @ 14, 15 Say "Base de Dados : " Get cNome Valid Testar(cNome)
   @ 15, 15 Say "Ficheiro de indices numerico     : " Get cIndex1 Valid Testar(cIndex1)
   @ 16, 15 Say "Ficheiro de indices alfanumerico : " Get cIndex2 Valid Testar(cIndex2)
   Read

   //   C O N F I R M A C A O

   cConfirmar = ""

   Mess24("Confirme ? ")
   cConfirmar = HMenu( 24, 12,  { " Sim ", " Nao " } )

   If Lastkey() = 27
      cConfirmar = " Nao "
   Endif

EndDo

Mess24("")

// Abertura dos ficheiros

Close All
Select 1
Use &cNome Index &cIndex1, &cIndex2 New
@ 1, 2 Say Centrar(Expandir(" ", 75), 76) // Limpar
@ 1, 2 Say Centrar(Expandir(AllTrim(Upper(cNome)), 1), 76)
Explode(4, 4, 21, 75)
Aviso(24, ;
  "[F5] Pesquisa por Codigo [F6] Pesquisa por Nome [ENTER] Editar [Esc] Sai")
DBEdit(5, 5, 20, 74, , "FDBEDITPLUS",,)

//
Setcolor(cCores)
Fundo()
@ 1, 2 SAY Centrar(Expandir("VISUALIZA€AO DE BASES DE DADOS", 1), 76)
Mess24("VER (c) Hugo Jorge Rodrigues Meneses 1993")
Barra(0, 0, 0)
Pack
Barra(0, 0, 50)
ReIndex
Barra(0, 0, 100)
Use

Set Color To
Cls

Quit    // The End

*

Function Testar(Nome)

   If Empty(Nome)
      Return .T.
   EndIf

   If !File(Nome)
      Beep(1)
      Mess24("ERRO: Ficheiro nao EXISTE!!!")
      Return .F.
   EndIf
Return .T.

*
* End Of Program
*
