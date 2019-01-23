******************************************************************************
/*
  Funcao HMenu()

  Mode de Usar:    HMenu(1, 1, {" Sim ", " Nao "})

*/


Function HMenu(nLinha, nColuna, aPrompts)
   LOCAL i, cRetVal
   LOCAL nMenu

   DevPos( nLinha, nColuna )

   FOR i = 1 TO Len(aPrompts)
      @ Row(), Col() + 2 PROMPT aPrompts[i]
      // Mensagem de erro quando as colunas ultrapassa a coluna 65.
      IF Col() > 65
         ?
         ? "DEMASIADAS OPCOES !!!!!!!!!!!!!!!!!!"
         ?
         QUIT
      ENDIF
   NEXT

   MENU TO nMenu

   IF LastKey() = 27
      cRetVal := ""
   ELSE
      cRetVal := aPrompts[nMenu]
   ENDIF

Return cRetVal

******************************************************************************
//
// Fun‡ao ALTC
//
// Modo de Usar:
//      SETCANCEL(.F.)
//      SET KEY K_ALT_C TO ALTC      // Redefinir ALT-C para a funcao ALTC
//

Function ALTC

   LOCAL cScreen, nEscolha, cLastColor := SetColor("W+/B, W+/R")

   SAVE SCREEN TO cScreen

   WinShade(6, 20, 9, 60, "ON")
   @ 7, 26 SAY "ALT - C: Quer mesmo SAIR ?"
   @ 8, 33 PROMPT " Sim "
   @ 8, 39 PROMPT " Nao "
   MENU TO nEscolha

   SetColor(cLastColor)
   RESTORE SCREEN FROM cScreen
   Release cScreen

   IF nEscolha = 1
      SET COLOR TO
      CLS
      QUIT
   ENDIF

Return NIL

******************************************************************************
*
* Fun‡ao Extenso
* Criada por Hugo Jorge Rodrigues Meneses em Julho de 1992
*
* Transforma uma variavel numerica numa STRING com o valor
* (em escudos) por extenso
* Ex.: @..,.. SAY EXTENSO (123)
* Retorna "cento vinte tres escudos"
* A STRING tem um tamanho indeterminado e deve ser manipulada para satisfazer
* as necessidades do programa.
*

Function Extenso
   PARAMETERS nNumero

   num = STR(nNumero,6,0)
   comp = LEN(ALLTRIM(num))
   valor = VAL(num)

   IF valor = 0
      cExtenso:="Zerinho"
      Return cExtenso
   ENDIF

   DECLARE cNumero[900]
   DECLARE xt[6]

   cNumero[1] = "um "
   cNumero[2] = "dois "
   cNumero[3] = "tres "
   cNumero[4] = "quatro "
   cNumero[5] = "cinco "
   cNumero[6] = "seis "
   cNumero[7] = "sete "
   cNumero[8] = "oito "
   cNumero[9] = "nove "
   cNumero[10] = "dez "
   cNumero[11] = "onze "
   cNumero[12] = "doze "
   cNumero[13] = "treze "
   cNumero[14] = "catorze "
   cNumero[15] = "quinze "
   cNumero[16] = "dezasseis "
   cNumero[17] = "dezassete "
   cNumero[18] = "dezoito "
   cNumero[19] = "dezanove "
   cNumero[20] = "vinte "
   cNumero[30] = "trinta "
   cNumero[40] = "quarenta "
   cNumero[50] = "cinquenta "
   cNumero[60] = "sessenta "
   cNumero[70] = "setenta "
   cNumero[80] = "oitenta "
   cNumero[90] = "noventa "
   cNumero[100] = "cento "
   cNumero[200] = "duzentos "
   cNumero[300] = "trezentos "
   cNumero[400] = "quatrocentos "
   cNumero[500] = "quinhentos "
   cNumero[600] = "seiscentos "
   cNumero[700] = "setecentos "
   cNumero[800] = "oitocentos "
   cNumero[900] = "novecentos "

   FOR ciclo := 1 TO 6
      xt[ciclo] = VAL( SUBSTR(num, ciclo, 1) )
   NEXT

   cExtenso1 := ""
   cExtenso2 := ""
   cExtenso := cExtenso1 + cExtenso2

   *
   * CENTENAS
   *

   If xt[5] = 0 .AND. xt[6] = 0                                 && 0 0
      cExtenso2 = "escudos"

   ElseIf xt[5] = 0 .AND. xt[6] <> 0                            && 0 1
      cExtenso2 = cNumero[xt[6]] + 'escudos'

   ElseIf xt[5] <> 0 .AND. xt[6] = 0                            && 1 0
      cExtenso2 = cNumero[xt[5]*10] + 'escudos'

   ElseIf xt[5]*10 + xt[6] <= 20 .AND. xt[5] <> 0               && >=10 e <=20
      cExtenso2 = cNumero[xt[5]*10 + xt[6]] + 'escudos'

   ElseIf xt[5]*10 + xt[6] > 20 .AND. xt[5]*10 + xt[6] <= 99    && >20 e <=99
      cExtenso2 = cNumero[xt[5]*10] + 'e ' + cNumero[xt[6]] + 'escudos'
   EndIf

   //

   If xt[4] = 0
      cExtenso2 = cExtenso2

   ElseIf xt[4] = 1 .AND. xt[5] = 0 .AND. xt[6] = 0
      cExtenso2 = 'cem ' + cExtenso2

   Else
      cExtenso2 = cNumero[xt[4]*100] + cExtenso2
   EndIf

   *
   * MILHARES
   *

   If xt[2] = 0 .AND. xt[3] = 0                                 &&   0 0
      cExtenso1 = ''

   ElseIf xt[2] = 0 .AND. xt[3] <> 0 .AND. xt[3] <> 1           &&   0 1
      cExtenso1 = cNumero[xt[3]] + 'mil '

   ElseIf xt[2] <> 0 .AND. xt[3] = 0                            &&   1 0
      cExtenso1 = cNumero[xt[2]*10] + 'mil '

   ElseIf xt[2]*10 + xt[3] > 20 .AND. xt[2]*10 + xt[3] <= 99    &&   >20 e <=99
      cExtenso1 = cNumero[xt[2]*10] + 'e ' + cNumero[xt[3]] + 'mil '

   ElseIf xt[2]*10 + xt[3] <= 20 .AND. xt[2] <> 0               &&   >=10 e <=20
      cExtenso1 = cNumero[xt[2]*10 + xt[3]] + 'mil '

   ElseIf xt[2] = 0 .AND. xt[3] = 1                             &&   0 1
      cExtenso1 = 'mil '

   EndIf

   //

   If xt[1] = 0
      cExtenso1 = cExtenso1

   ElseIf xt[1] = 1 .AND. xt[2] <> 0 .AND. xt[3] <> 0
      cExtenso1 = 'cento ' + cExtenso1

   ElseIf xt[1] = 1 .AND. xt[2] = 0 .AND. xt[3] = 0             && 1 0 0
      cExtenso1 = 'cem mil ' + cExtenso1

   ElseIf xt[1] = 1 .AND. xt[2] <> 0 .AND. xt[3] = 0
      cExtenso1 = 'cento ' + cExtenso1

   ElseIf xt[1] <> 1 .AND. xt[2] = 0 .AND. xt[3] = 0
      cExtenso1 = cNumero[xt[1]*100] + 'mil '

   ElseIf xt[1] <> 1 .AND. xt[2] <> 0 .AND. xt[3] <> 0
      cExtenso1 = cNumero[xt[1]*100] + cExtenso1

   ElseIf xt[1] <> 1 .AND. xt[2] = 0 .AND. xt[3] <> 0
      cExtenso1 = cNumero[xt[1]*100] + cExtenso1

   EndIf

   // Resultado final

   cExtenso = cExtenso1 + cExtenso2

Return cExtenso

******************************************************************************
/*

 Function DATA

*/

Function DATA(dData)

   // DESCRI€AO : Se nao for entrada nenhuma data assume a do sistema

   IF dData = NIL
      dData = DATE()
   ENDIF

   //

   PUBLIC dia, mes, ano, semana, DataCompleta

   dia = LTRIM(STR(DAY(dData),2))
   ano = STR(YEAR(dData),4)

   DO CASE  // Mes
      CASE CMONTH(dData) = "January"
           mes = "Janeiro"
      CASE CMONTH(dData) = "February"
           mes = "Fevereiro"
      CASE CMONTH(dData) = "March"
           mes = "Mar‡o"
      CASE CMONTH(dData) = "April"
           mes = "Abril"
      CASE CMONTH(dData) = "May"
           mes = "Maio"
      CASE CMONTH(dData) = "June"
           mes = "Junho"
      CASE CMONTH(dData) = "July"
           mes = "Julho"
      CASE CMONTH(dData) = "August"
           mes = "Agosto"
      CASE CMONTH(dData) = "September"
           mes = "Setembro"
      CASE CMONTH(dData) = "October"
           mes = "Outubro"
      CASE CMONTH(dData) = "November"
           mes = "Novembro"
      CASE CMONTH(dData) = "December"
           mes = "Dezembro"
   ENDCASE

   DO CASE  // Dia da Semana
      CASE CDOW(dData) = "Sunday"
           semana = "Domingo"
      CASE CDOW(dData) = "Monday"
           semana = "Segunda"
      CASE CDOW(dData) = "Tuesday"
           semana = "Ter‡a"
      CASE CDOW(dData) = "Wednesday"
           semana = "Quarta"
      CASE CDOW(dData) = "Thursday"
           semana = "Quinta"
      CASE CDOW(dData) = "Friday"
           semana = "Sexta"
      CASE CDOW(dData) = "Saturday"
           semana = "S bado"
   ENDCASE

   DataCompleta = semana + ", " + LTRIM(STR(DAY(dData),2)) + " de " + mes ;
              + " de " + STR(YEAR(dData)-1900,2)
   //

Return DataCompleta

******************************************************************************
//
// Fun‡ao PassWord ( x, y)
// Criada por Hugo Jorge Rodrigues Meneses em 19 de Agosto de 1992
// Para ser usada tem de existir um ficheiro PASSWORD.DBF com a seguinte
// configura‡ao: PASSWORD C 10
// NOTA: Este ficheiro tem de ser actualizado manualmente (com o DBU.EXE)
// ou com a funcao MudaPassWord()
//
// Modo de Usar : PassWord ( x, y )
//

Function PassWord()
   PARAMETERS x, y

   IF x = 0 .AND. y = 0
      x = 20
      y = 8
   ENDIF

   //

   USE password
   cPChave = password
   USE

   WinShade(y, x, y + 4, x + 40, "ON")

   pass_word = SPACE(15)

   DO WHILE pass_word <> cPChave

      pass_word = SPACE(15)

      @ y + 2, x + 4 SAY "Palavra Chave : "
      SET COLOR TO W+/B+, X

      @ y + 2, x + 20 GET pass_word PICTURE "@X"
      Read

      SET COLOR TO W+/B+, W+/R

      IF LASTKEY() = 27
         pass_word = "ERRADA"
      ENDIF

      IF pass_word <> cPChave
         Mess24("PALAVRA CHAVE INCORRECTA. Tente de novo.")
      Else
         Mess24("PALAVRA CHAVE CORRECTA.")
      ENDIF

   ENDDO

Return .T.

******************************************************************************
//
// Funcao Barra
// Criada por Hugo Jorge Rodrigues Meneses em 1992
//
// Modo de Usar:
//      Barra( x, y , % )
//

Function Barra()

   PARAMETERS x, y, Percentagem

   IF x = 0 .AND. y = 0
      x = 22
      y = 8
   ENDIF

   Menos := 2

   IF Percentagem <= 0
      Percentagem = 10
      Menos = 0
   ENDIF

   WinShade(y, x, y + 5, x + 33, "ON")

   @ y, x + 2 SAY " Progresso "
   @ y + 2, x + 2 SAY REPLICATE("±", 30)
   @ y + 2, x + 2 SAY REPLICATE("Û", Percentagem/10*3)
   @ y + 3, x + Percentagem / 10 * 3 - Menos SAY Percentagem PICTURE "999%"

Return

******************************************************************************
//
//  Fun‡ao MudaPassWord ( x, y)
//  Criada por Hugo Jorge Rodrigues Meneses em 1992
//  Para ser usada tem de existir um ficheiro PASSWORD.DBF com a seguinte
//  configura‡ao: PASSWORD C 10
//
//  Modo de Usar : MudaPassWord ()
//

Function MudaPassWord(x, y)

   Cls
   PassWord( x, y )

   Cls
   @ 1, 24 SAY " A L T E R A R  P A S S W O R D "
   Mess24("(C) Hugo Jorge Rodrigues Meneses 1992                          [ESC] para Sair")

   //

   USE password
   BROWSE(8, 20, 14, 60)
   CLOSE DATABASES

   //

Return .T.

******************************************************************************
//
// FUNCAO DataExtenso()
//
// Modo de Usar: DataExtenso(DATE())
//

Function DataExtenso

   PARAMETERS DATA

   // DESCRI€AO : Se nao for entrada nenhuma data assume a do sistema

   IF DATA = NIL
      DATA = DATE()
   ENDIF

   //

   MES = MONTH(DATA)

   DO CASE
      CASE MES=1
         MESEXT="Janeiro"
      CASE MES=2
         MESEXT="Fevereiro"
      CASE MES=3
         MESEXT="Mar‡o"
      CASE MES=4
         MESEXT="Abril"
      CASE MES=5
         MESEXT="Maio"
      CASE MES=6
         MESEXT="Junho"
      CASE MES=7
         MESEXT="Julho"
      CASE MES=8
         MESEXT="Agosto"
      CASE MES=9
         MESEXT="Setembro"
      CASE MES=10
         MESEXT="Outubro"
      CASE MES=11
         MESEXT="Novembro"
      CASE MES=12
         MESEXT="Dezembro"
   ENDCASE

Return (STR( DAY(DATA), 2) + " de "+  MESEXT + " de " + STR( YEAR(DATA), 4))

******************************************************************************
//
// LIST DA FUNCAO DiaExtenso()
//
// Modo de Usar: DiaExtenso(DATE())
//

Function DiaExtenso(DATA)

   // DESCRI€AO : Se nao for entrada nenhuma data assume a do sistema

   IF DATA = NIL
      DATA = DATE()
   ENDIF

   //

   DIA = DOW(DATA)
   DO CASE
      CASE DIA=1
         DIAEXT="Domingo"
      CASE DIA=2
         DIAEXT="Segunda-Feira"
      CASE DIA=3
         DIAEXT="Ter‡a-Feira"
      CASE DIA=4
         DIAEXT="Quarta-Feira"
      CASE DIA=5
         DIAEXT="Quinta-Feira"
      CASE DIA=6
         DIAEXT="Sexta-Feira"
      CASE DIA=7
         DIAEXT="Sabado"
   ENDCASE

Return (DIAEXT)

******************************************************************************
//
// Fun‡ao Expandir
// Criada por Hugo Jorge Rodrigues Meneses em 24 de Janeiro de 1993
//
// Modo de Usar: Expandir(String, Espa‡os)
//
// EXEMPLO:
//     ? Expandir("ABC", 1)
// Retorna
//     A B C

Function Expandir

   PARAMETERS O_Que, Quanto

   NovaString := ""
   Tamanho = LEN(O_Que)

   FOR Vezes = 1 TO Tamanho
       NovaString = NovaString + SUBSTR(O_Que, Vezes, 1)
       NovaString = NovaString + REPLICATE(" ", Quanto)
   NEXT

Return NovaString

******************************************************************************

//
// Fun‡ao Centrar
// Criada por Hugo Jorge Rodrigues Meneses em 24 de Janeiro de 1993
//
// Modo de Usar: @ y, 0 SAY Centrar(String, Espa‡os)
//

Function Centrar

   PARAMETERS O_Que, Quanto

   NovaString := ""

   Tamanho = LEN(O_Que)
   Espaco = (Quanto - Tamanho) / 2

   NovaString = REPLICATE(" ", Espaco) + O_Que

Return NovaString

******************************************************************************
//
// Funcao Rato()
//
// Criada por Hugo Jorge Rodrigues Meneses em Marco de 1993
//

Function Rato()

   Cls
   @ 1, 2 SAY Centrar(Expandir("MOUSE", 1), 76)

   cRatoSN := ""
   Mess24("Utilizar o Mouse ?")
   cRatoSN := HMenu(24, 21, { " Sim ", " Nao " } )

   IF LastKey() = 27
      Return .T.
   ENDIF

   IF cRatoSN = " Sim "
      Estado := M_SET_ON()
   ELSE
      M_SET_OFF()
   ENDIF

Return .T.

******************************************************************************
// Funcao Cores()
//
// Criada por Hugo Jorge Rodrigues Meneses em Marco de 1993
//

Function Cores()

   Cls
   @ 1, 2 SAY Centrar(Expandir("CORES", 1), 76)

   cCoresSN := ""
   Mess24("Modo CORES ou MONO ?")
   cCoresSN := HMenu(24, 21, { " CORES ", " MONO " } )

   IF LastKey() = 27
      Return .T.
   ENDIF

   IF cCoresSN = " MONO "
      cCores := "N/W,W/N,N,N,W/N"         // MONO
   ELSE
      cCores := "W+/B+,W+/R,B,B,W+/B"     // CORES
   ENDIF

Return .T.

*******************************************************************************

PROCEDURE Help(cPrograma)

/*

   Esta funcao activa-se ao pressionar a tecla F1.
   Nao e' preciso defenir com a funcao SET KEY K_F1 TO Help()

*/

   LOCAL Tela:=SAVESCREEN(00,00,24,79), vcursor
   vcursor:=SETCURSOR(0)
   IF cPrograma="HELP"
      // Evita que o Help() chame ele mesmo.
      Return
   ENDIF

   WinShade(1, 1, 23, 77, "ON")

   @ 5, 23 SAY "   HELP - Auxilio ao Utilizador"
   @ 6, 23 SAY "   Teclas de Controle de Edicao"
   @ 7, 23 SAY "Para inclusao ou alteracao de Dados"
   @ 10,10 SAY "[Enter]  -> Da entrada nos dados ou efetua uma alteracao"
   @ 11,10 SAY "[Setas]  -> Movimentam o cursor para a direccao indicada"
   @ 12,10 SAY "[Home]   -> Movimenta o cursor para o inicio do campo"
   @ 13,10 SAY "[End]    -> Movimenta o cursor para o fim do campo"
   @ 14,10 SAY "[<---]   -> Apaga o caractere a esquerda do cursor"
   @ 15,10 SAY "[Ins]    -> Liga ou Desliga o modo de insercao de caracteres"
   @ 16,10 SAY "[Del]    -> Apaga o caractere sob o cursor"
   @ 17,10 SAY "[Ctrl-T] -> Apaga a palavra a direita do cursor"
   @ 18,10 SAY "[Ctr-Y]  -> Apaga todo o conteudo de um campo"
   @ 19,10 SAY "[Ctrl-W] -> Finaliza gravando os dados digitados"
   @ 20,10 SAY "[Esc]    -> Finaliza sem gravar os dados digitados"

   @ 22, 20 SAY "Pressione qualquer tecla para continuar..."
   InKey(0)

   Restscreen(00, 00, 24, 79, Tela)

   Release Tela

Return

******************************************************************************
//
// Funcoes para controle da impressora
// Criadas por Hugo Jorge Rodrigues Meneses em 31 de Marco de 1993
//

// Verificacao do estado da impressora

Function TestarPrinter()

cOpcao := { " Sim ", " Nao " }
nOpcao := 1

DO WHILE !IsPrinter()

   nOpcao  = ALERT ("IMPRESSORA DESLIGADA;;Continuar a tentar ?", cOpcao)

   IF nOpcao = 0 .OR. nOpcao = 2
      Return .F.
   ENDIF

ENDDO

Return .T.

//

Function LigaPrinter()

   SET CONSOLE OFF
   SET DEVICE TO PRINTER
   SET PRINTER ON

Return

*

Function DesligaPrinter()

   SET CONSOLE ON
   SET DEVICE TO SCREEN
   SET PRINTER OFF
   SET PRINTER TO

Return

******************************************************************************
//
// Retirado do livro: CLIPPER Programmer's reference
//                    W. Edward Tiley
//                    PROGRAMMING SERIES
//                    QUE
//
//
// Screen windowing stack.
// Accept 5 formal parameters: the four corners and
// a setting that determines if the window is to be pushed or
// popped.
//

Function WinShade( nT, nL, nB, nR, cSet)

   // Creat an empty array to hold the character strings created
   // by SaveScreen() and an element pointer to show the current
   // array element.

   STATIC cWinScr := {}
   STATIC nEl := 0

   IF cSET == 'ON'
   // Use the SaveScreen to save the area to an element, including
   // the shadow area.
      Aadd(cWinScr,SaveScreen( nT, nL, nB+1, nR+1) )
      nEl++
   // Increment the pointer.
   // This next bit of code alters the colors of a screen area
   // leaving the actual charecters displayed intact.
      RestScreen( nT+1, nL+1, nB+1, nR+1, ;
      Transform( SaveScreen( nT+1, nL+1, nB+1, nR+1), ;
      Replicate("X" + Chr(7), Len( SaveScreen( nT+1, nL+1, nB+1, nR+1)) )))
      // Now, just clear out the area for the window and paint it.
      @ nT, nL CLEAR TO nB, nR
      @ nT, nL TO nB, nR DOUBLE
   ELSE
      RestScreen( nT, nL, nB+1, nR+1,cWinScr[nEl])
      Adel( cWinScr, nEl)
      Asize( cWinScr, --nEl)
   ENDIF

Return NIL

******************************************************************************

/*

  Function Mess24()

  Modo de Usar:     Mess24("Isto e um teste!!")
  Retorna     :     A frase: Isto e um teste na linha 24

*/

Function Mess24( cString )

   IF cString == NIL
      cString := ' '
   ENDIF

   @ 24, 1 SAY PadR( cString, 80 )

Return NIL

******************************************************************************
******************************************************************************

Function Fundo()
   @ 0, 0, 24, 79 BOX Chr(220) + Chr(220) + Chr(220) + ;
   Chr(177) + Chr(174) + Chr(219) + Chr(175) + ;
   Chr(177) + Chr(177)
   @ 1, 0 SAY Replicate( Chr(219), 80)
   @ 2, 0 SAY Replicate( Chr(223), 80)
   @ 1, 2 SAY PadL(" ",76)
Return NIL

*******************************************************************************
PROCEDURE Aviso(Linha, cTexto)
/*
 Objectivo..: Apresenta um aviso centralizado em uma linha da tela.
 Parametros.: O texto do aviso e a linha onde dever  ser apresentado.
*/
   LOCAL Coluna:=Int((78-Len(cTexto))/2)
   // Centraliza o texto do aviso na tela.
   @ Linha, Coluna SAY cTexto
Return

*******************************************************************************
//
// Retirado do livro: CLIPPER Programmer's reference
//                    W. Edward Tiley
//                    PROGRAMMING SERIES
//                    QUE
//
//

Function Explode(nT, nL, nB, nR)

   LOCAL nRow := Row(), nCol := Col()
   LOCAL nlT := (Int((nB-nT)/2) + nT + 1)
   LOCAL nlB := nlT + 1
   LOCAL nlL := (Int((nR-nL)/2) + nL + 1)
   LOCAL nlR := nlL + 1
   LOCAL nC := Int((nR-nL)/2) + nL

   RestScreen (nT+1, nL+1, nB+1, nR+2, ;
     Transform(SaveScreen(nT+1, nL+1, nB+1, nR+2), ;
     Replicate("X" + Chr(7), ;
     Len(SaveScreen(nT+1, nL+1, nB+1, nR+2)) )))

   DO WHILE .T.
      If(nlT == nT, "", nlT--)
      If(nlL == nL, "", nlL--)
      If(nlB == nB, "", nlB++)
      If(nlR == nR, "", nlR++)

      DispBegin()
      @ nlT, nlL CLEAR TO nlB, nlR
      @ nlT, nlL TO nlB, nlR DOUBLE
      DispEnd()

      IF nlT == nT .AND. ;
         nlL == nL .AND. ;
         nlB == nB .AND. ;
         nlR == nR

         EXIT

      ENDIF

   ENDDO

   DevPos(nRow, nCol)

Return NIL
*******************************************************************************
//
// Fun‡ao Beep
//

Function Beep(nSom)

/*
   Sintaxe....: Beep()
   Objectivo..: Emite um sinal sonoro para chamar a aten‡ao
   Parametros.: Indicam o tipo de som a emitir (1 a 3)
   Fornece....: O som
*/

   IF nSom = 1
      // Emite um som desagradavel, indicando erro
      Tone(87.3,2)
      Tone(40,7)
   ELSEIF nSom = 2
      // Emite um som agradavel, indicando "tudo bem"
      Tone(261.7,2)
      Tone(392,7)
   ELSEIF nSom = 3
      // Emite um som de finaliza‡ao de opera‡oes
      Tone(300,4)
      Tone(300,4)
      Tone(300,4)
      Tone(300,7)
   ENDIF

Return

******************************************************************************
PROCEDURE Le()
/*
 Sintaxe...: Le()
 Objectivo.: Ligar o cursor e ler dados de objetos GET pendentes
 Parametros: Nenhum
*/

   LOCAL Cursor
   Cursor:=SETCURSOR(2)  // Liga o cursor
   Read
   SETCURSOR(Cursor)     // Volta o cursor ao formato anterior
   @ 24, 0 Clear
Return
*******************************************************************************
PROCEDURE Mensagem(cTexto, nTempo, Som)
/*
 Objectivo.: Apresenta, por um determinado tempo, uma mensagem de alerta
             (piscante e em video reverso) na linha 24 da tela.
 Parametros: O texto da mensagem, o tempo que a mesma devera' ser apresen-
             tada na tela e o sinal sonoro a emitir.
*/
*******************************************************************************

   LOCAL Cor:=SetColor()
   IF VALTYPE(Som)#"N"
      Som:=2
   ENDIF
   @ 24,00 CLEAR
   // Apresenta a mensagem
   SetColor("W+*/R")
   @ 24, 0 Say PadC(Trim(cTexto),80)
   SetColor(Cor)
   Beep(Som)             // Emite um determinado Som
   // Aguarda um determinado tempo.
   InKey(nTempo)
   @ 24, 0 Clear
Return

*******************************************************************************

*******************************************************************************
//                                   F i m
*****************************************************************************
