******************************************************************************
//
// Programador: Hugo Jorge Rodrigues Meneses
// Morada     : 2¶ Travessa do Lazareto, Nß 1
//            : 9000 Funchal / Madeira
// Telefone   : 34 975
//
// Data       : 1 994
//

Function Fundo(cMensagem)
   @ 0, 0, 24, 79 Box "≤≤≤≤≤≤≤≤≤"
   SetColor("B/N")      // Topo da caixa
   @ 0, 0, 0, 79 Box "€€€€€€€€€"
   SetColor('W+/B')
   @ 0, 0 Say Centrar(cMensagem, 80)
   @ 0, 0 Say "[˛]"
Return NIL

******************************************************************************
//
// Programador: Hugo Jorge Rodrigues Meneses
// Morada     : 2¶ Travessa do Lazareto, Nß 1
//            : 9000 Funchal / Madeira
// Telefone   : 34 975
//
// Data       : 1 994
//

Function TheMenu(aPrompts, cMsg)

   If Len(aPrompts) < 2 .Or. Len(aPrompts) > 5
      Cls
      ?
      ? "ERRO: DEMASIADAS OU NENHUMAS OPÄôES!!!"
      ?
      Quit
   EndIf

   nVezes := 0
   For i := 1 To Len(aPrompts)
       If Len(aPrompts[i]) > nVezes
          nVezes = Len(aPrompts[i])
       EndIf
   Next

   If nVezes > 12       // Para evitar prompts maiores que 12
      nVezes = 12
   EndIf

   // Para por todos os prompts com o mesmo comprimento
   For i := 1 To Len(aPrompts)
       If Len(aPrompts[i]) <= nVezes
          aPrompts[i] = aPrompts[i] + Space(nVezes-Len(aPrompts[i]))
       ElseIf Len(aPrompts[i]) > nVezes
          aPrompts[i] = SubStr(aPrompts[i], 1, nVezes)
       EndIf
   Next

   CorAntiga := SetColor()

   // Caixa
   SetColor('N/N')      // Fundo
   @ 7, 22, 7 + Len(aPrompts) * 2 + 2, 58 Box "€€€€€€€€€"
   SetColor('W/B')      // Exterior
   @ 6, 21, 6 + Len(aPrompts) * 2 + 2, 57 Box "€€€€€€€€€"
   SetColor("B/N")      // Topo da caixa
   @ 6, 21, 6, 57 Box "€€€€€€€€€"
   SetColor('W+/B')
   @ 6, 21 Say "[˛]           [M E N U]"

   // Caixa com a mensagem (Variavel - cMsg)
   SetColor('N/W')
   @ 9, 40, 9 + Len(aPrompts) * 2 - 3, 55 Box "€€€€€€€€€"
   SetColor('B/W')
   @ 8, 39, 9 + Len(aPrompts) * 2 - 4, 54 Box "€€€€€€€€€"
   // Texto
   /* 2 prompts - 1 linha
      3    "    - 2 linhas
      4    "    - 4   "
      5    "    - 6   "
   */
   SetColor('W+/B')

   Do Case
      Case Len(aPrompts) = 2
           nMaxLinhas := 1
      Case Len(aPrompts) = 3
           nMaxLinhas := 2
      Case Len(aPrompts) = 4
           nMaxLinhas := 4
      Case Len(aPrompts) = 5
           nMaxLinhas := 6
   EndCase

   cTexto := cMsg
   For i := 1 To nMaxLinhas
       cLinha := SubStr(cTexto, 1, 14)
       nPosicao := Rat(" ", cLinha)
       If nPosicao <> 0
          @ 8 + i, 40 Say SubStr(cLinha, 1, nPosicao)
          cTexto := SubStr(cTexto, nPosicao + 1)
       ElseIf nPosicao = 0
          @ 8 + i, 40 Say cTexto
       EndIf
   Next

   // Sombra dos prompts
   SetColor('N/W')
   For i := 1 To Len(aPrompts)
       @  6 + i * 2, 26 Say Replicate("‹", nVezes)  // Chr(220)
       @  7 + i * 2, 26 Say Replicate("ﬂ", nVezes)  // Chr(223)
   Next

   SetColor("W/N")
   For i := 1 To Len(aPrompts)
       @ 6 + i * 2, 25 Say Replicate("€", nVezes)  // Chr(219)
   Next

   SetColor(CorAntiga)
   For i := 1 To Len(aPrompts)
       @ 6 + i * 2, 25 Prompt aPrompts[i]
   Next

   Menu To nMenu

   If LastKey() = 27
      cRetVal := ""
   Else
      cRetVal := aPrompts[nMenu]
   EndIf

Return cRetVal

*******************************************************************************
//
// Programador: Hugo Jorge Rodrigues Meneses
// Morada     : 2¶ Travessa do Lazareto, Nß 1
//            : 9000 Funchal / Madeira
// Telefone   : 34 975
//
// Data       : 1 994
//
// Funcao     : TerminarPrograma()
//

Procedure TerminarPrograma()

   #Include "InKey.Ch"

   Local cScreen, nChoice, cLastColor := SetColor("W+/B, W+/R")

   Save Screen To cScreen

   CorAntiga := SetColor()

   SetColor('N/W')
   For i := 1 To 3
       @  1 + i, 1 Say Replicate("€", 18)  // Chr(219)
   Next
   SetColor("W+/B")
   @ 1, 0 Say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
   @ 2, 0 Say "∫"
   SetColor("W+/R")
   ?? " FECHAR  ALT+F4 "
   SetColor("W+/B")
   ??"∫"
   @ 3, 0 Say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"

   InKey(0)

   If LastKey(0) <> 13
      SetColor(CorAntiga)
      Restore Screen From cScreen
      Release cScreen
      Return .T.
   EndIf

   Set Color To
   Close All
   Cls
   Quit
Return .T.

******************************************************************************

//
// Funcao Centrar
// Criada por Hugo Jorge Rodrigues Meneses em 24 de Janeiro de 1993
//
// Modo de Usar: @ y, 0 SAY Centrar(String, Espacos)
//

Function Centrar

   Parameters O_Que, Quanto

   NovaString := ""

   Tamanho = Len(O_Que)
   Espaco = (Quanto - Tamanho) / 2

   NovaString = Replicate(" ", Espaco) + O_Que

Return NovaString

******************************************************************************

******************************************************************************
//                                   F i m
*******************************************************************************

