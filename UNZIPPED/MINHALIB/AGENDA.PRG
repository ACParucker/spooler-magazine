/*
                   ีออออออออออออออออออออออออออออออออออออออธ
                   ณ Structure of AGENDA.DBF   Field 1    ณ
                   ณ                                      ณ
                   ณ Field Name   Type        Width   Dec ณ
                   ฦออออออออออออัอออออออออออัอออออออัอออออต
                   ณ NUMERO     ณ Numeric   ณ    12 ณ   0 ณ
                   ณ NOME       ณ Character ณ    50 ณ     ณ
                   ณ MORADA1    ณ Character ณ    50 ณ     ณ
                   ณ MORADA2    ณ Character ณ    50 ณ     ณ
                   ณ MORADA3    ณ Character ณ    50 ณ     ณ
                   ณ OBSERV_1   ณ Character ณ    50 ณ     ณ
                   ณ OBSERV_2   ณ Character ณ    50 ณ     ณ
                   ณ OBSERV_3   ณ Character ณ    50 ณ     ณ
                   ิออออออออออออฯอออออออออออฯอออออออฯอออออพ
*/


*****
*
* Demonstracao do procedimento FDBEDITPlus()
*
* Programador : Hugo Jorge Rodrigues Meneses
* Morada      : 2ฆ Travessa do Lazareto, Nง 1
*               9000 Funchal
*               Ilha da Madeira
* Telefone    : 34 975
*
*****

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

SETCANCEL(.F.)                 // Disable termination keys
SET KEY K_ALT_C TO ALTC        // Redefinir ALT-C para a funcao ALTC

SET KEY K_F1 TO         // Redefinir F1 (para podermos ver o Help da
                        // funcao FDBEDITPlus

//

DIRECT = CurDir()       // Para uso da funcao ALTC

//

Set Cursor On
Cls
Setcolor(cCores)
Fundo()
@ 1, 2 SAY Centrar(Expandir("AGENDA", 2), 76)
Mess24("")

// Titulos das Colunas
Titulos = { "Numero", "Nome", "Morada", "", "", "Observaoes", "", "" }
// Campos a mostrar
Nomes_Campos = { "NUMERO", "NOME", "MORADA1", "MORADA2", "MORADA3", "OBSERV_1", "OBSERV_2", "OBSERV_3" }
// PICTURE dos campos
Pict_Campos = { "999999999999", "@X", "@X", "@X", "@X", "@X", "@X", "@X" }

Explode(4, 4, 21, 75)
Aviso(24, "[F5] Pesquisa por Codigo [F6] Pesquisa por Nome [ENTER] Editar [Esc] Sai")
*                Indice Numerico
*                    |        Indice Alfanumerico
*                    |         |
USE agenda INDEX agenda_n, agenda_a NEW
DBEDIT(5, 5, 20, 74, Nomes_Campos , "FDBEDITPLUS", Pict_Campos, Titulos)

// FIM

Cls
Setcolor(cCores)
Fundo()
@ 1, 2 SAY Centrar(Expandir("AGENDA", 2), 76)
Mess24("")
Barra(0, 0, 0)
Pack
Barra(0, 0, 50)
ReIndex
Barra(0, 0, 100)
Close All
Select 1

Set Color To
Cls

Quit    // The End

*
*  E O Program
*
