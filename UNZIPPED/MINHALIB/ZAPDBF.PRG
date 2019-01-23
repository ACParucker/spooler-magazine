*****
*
* Programa ....: ZAPDBF.PRG
* Programador .: Hugo Jorge Rodrigues Meneses
* Morada ......: 2¦ Travessa do Lazareto, N§ 1
*              : 9000 Funchal / Madeira
* Telefone ....: 34 975
* Data ........: Novembro e Dezembro de 1993
*
*****

//

#INCLUDE "INKEY.CH"

//

Set Message To 21 Center
Setcursor(3)
Set Scoreboard Off
Set Delimiters On
Set Delimiters To "[]"
Set Confirm On
Set Deleted On
Set Escape Off  // Para nao sair dos READ com o ESCAPE
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

//

SET CURSOR ON
CLS

SETCOLOR(cCores)
Fundo()
@ 1, 2 SAY Centrar(Expandir("ZAP", 2), 76)
Mess24("ZAP (c) Hugo Jorge Rodrigues Meneses 1993")
Explode(12, 10, 18, 70)

// Variaveis
cNome := Space(32)
cIndex1 := Space(24)
cIndex2 := Space(24)

cConfirmar := " Nao "

Do While cConfirmar = " Nao "

   Mess24("")
   @ 14, 15 Say "Base de Dados : " Get cNome Valid Testar(cNome)
   @ 15, 15 Say "Ficheiros de indices : " Get cIndex1 Valid Testar(cIndex1)
   @ 16, 15 Say "Ficheiros de indices : " Get cIndex2 Valid Testar(cIndex2)
   Read

   //   C O N F I R M A C A O

   cConfirmar = ""

   Mess24("Confirme ? ")
   cConfirmar = HMenu( 24, 12,  { " Sim ", " Nao " } )

   IF LASTKEY() = 27
      cConfirmar = " Nao "
   ENDIF

EndDo

//

Close All
Select 1

// Abertura dos ficheiros

If cIndex1 = Space(24) .And. cIndex2 = Space(24)
   Use &cNome New
ElseIf cIndex1 = Space(24) .And. cIndex2 <> Space(24)
   Use &cNome Index &cIndex2 New
ElseIf cIndex2 = Space(24) .And. cIndex1 <> Space(24)
   Use &cNome Index &cIndex1 New
Else
   Use &cNome Index &cIndex1, &cIndex2 New
EndIf

Zap     // Limpa a base de dados

Close All

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