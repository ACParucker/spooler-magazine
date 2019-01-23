// >>>>>>>>>>>>>>>>>>>>>>>>>>>   FDBEditPlus()   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//
// Funcao para Consulta e Actualizacao com DBEDIT
//
// MODO DE USAR: Trˆs vezes ao dia ou, por exemplo:
// Nomes = { "Codigo", "Nome" }    <-- Exemplo
// Explode(4, 4, 21, 75)
// Aviso(24, ;
// "[F5] Pesquisa por Codigo [F6] Pesquisa por Nome [ENTER] Editar [Esc] Sai")
// USE ficheiro INDEX ficheiron, ficheiroa NEW
// DBEDIT(5, 5, 20, 74, , "FDBEDITPLUS",,Nomes)
// CLOSE DATABASES  // Fecha a base de dados.
//

FUNCTION FDBEditPlus(nModo, nColuna)

   IF nModo = 1
      Mensagem("Inicio do Arquivo !", 8, 1)
      Return(1)

   ELSEIF nModo = 2
      Mensagem("Fim do Arquivo !", 1, 1)
      Mess24("Deseja criar um novo registo ? ")
      cSim_Nao := HMenu(24, 31, { " Sim ", " Nao " } )
      If LastKey() = 27
         cSim_Nao := " Nao "
      EndIf
      If cSim_Nao = " Sim "
         DBGoBottom()
         DBAppend()
      EndIf
      @ 24, 0 CLEAR
      Return(2)

   ELSEIF nModo = 3
      Beep(1)
      Mensagem("Arquivo Vazio !", 8, 1)
      Mess24("Deseja criar um novo registo ? ")
      cSim_Nao := HMenu(24, 31, { " Sim ", " Nao " } )
      If LastKey() = 27
         cSim_Nao := " Nao "
      EndIf
      If cSim_Nao = " Sim "
         DBGoBottom()
         DBAppend()
      EndIf
      If cSim_Nao = " Nao "
         Return(0)
      EndIf
      @ 24, 0 Clear
      Return(2)

   ELSEIF nModo = 4

      IF LASTKEY() = 27
         // Foi pressionada a tecla <Esc>, finaliza a consulta
         Return(0)

      ELSEIF LASTKEY() = 7
         // Foi pressionada a tecla <DEL>, apaga o registo
         Mess24("Deseja apagar este registo ? ")
         cSim_Nao := HMenu(24, 30, { " Sim ", " Nao " } )
         If LastKey() = 27
            cSim_Nao := " Nao "
         EndIf
         If cSim_Nao = " Sim "
            Delete
         EndIf
         @ 24, 0 CLEAR
         DBGoTop()
         Return(1)

      ELSEIF LASTKEY() = 13
         // Foi pressionada a tecla <Enter>, edita o campo seleccionado
         lDelimiters := Set(_SET_DELIMITERS)
         Set Delimiters Off
         A_Editar := FieldName(nColuna) // Fica com o nome do CAMPO
         Set Cursor On                 // Liga o cursor
         @ Row(), Col() Get &A_Editar  // Edita o CAMPO
         Read
         Set Cursor Off                    // Desliga o cursor
         Set(_SET_DELIMITERS, lDelimiters)
         Return(1)

      ELSEIF LASTKEY() = 28     //  [F1]
         // Foi pressionada a tecla <F1>, mostra um ecran de ajuda
         WinShade(7, 10, 19, 70, "ON")
         @  9, 15 Say "AJUDA"
         @ 10, 15 Say "Teclas:"
         @ 11, 15 Say "F1 - Mostra este ecran de ajuda."
         @ 12, 15 Say "F5 - Procura pelo indice numerico."
         @ 13, 15 Say "F6 - Procura pelo indice alfanumerico."
         @ 14, 15 Say "[ENTER] - Edita o campo onde o cursor se encontra."
         @ 15, 15 Say "[DEL] - Apaga o registo onde o cursor se encontra."
         @ 16, 15 Say "[ALT e V] - Visualiza o registo onde o cursor est ."
         @ 17, 15 Say "[ESC] - Sai do ecran de edicao de dados."
         Inkey(0)
         WinShade(7, 10, 19, 70, "OFF")
         Return(1)

      ELSEIF LASTKEY() = -4     //  [F5]
         // Foi pressionada a tecla <F5>, pesquisa por codigo
         SET ORDER TO 1
         vcodi := 0
         @ 24, 0 CLEAR
         @ 24, 19 SAY "Codigo a pesquisar: " GET vcodi PICTURE "999999999999"
         Le()
         Aviso(24, ;
  "[F5] Pesquisa por Codigo [F6] Pesquisa por Nome [ENTER] Editar [Esc] Sai")
         rec := RECNO()
         SEEK vcodi
         IF EOF()
            // Se nao for encontrado retorna.
            Mensagem("Codigo INEXISTENTE !", 8, 1)
            GO rec
            Return(2)
         ENDIF
         // Reconstroi a janela de visualizacao de DBEDIT()
         Return(2)

      ELSEIF LASTKEY() = -5     //  [F6]
         // Foi pressionada a tecla <F6>, pesquisa por nome
         SET ORDER TO 2
         vnome := SPACE(30)
         @ 24, 0 CLEAR
         @ 24, 15 SAY "Codigo a pesquisar: " GET vnome PICTURE "@X"
         Le()
         @ 24, 0 CLEAR
         If Empty(vnome)
            Return(2)
         EndIf
         Aviso(24, ;
   "[F5] Pesquisa por Codigo [F6] Pesquisa por Nome [ENTER] Editar [Esc] Sai")
         rec := RECNO()
         vnome := AllTrim(vnome)
         Set SoftSeek On
         SEEK vnome
         Set SoftSeek Off
         IF EOF()
            // Se nao for encontrado retorna.
            Mensagem("Codigo INEXISTENTE !", 8, 1)
            GO rec
            Return(2)
         ENDIF
         // Reconstroi a janela de visualizacao de DBEDIT()
         Return(2)
      ELSEIF LASTKEY() = 303     //  [ALT e V]
         // Foi pressionada a tecla <ALT e V>
         WinShade(7, 10, 18, 70, "ON")
         For nField := 1 TO If(FCount() > 10, 10, FCount())
             @ 7 + nField, 12 Say PADR(FieldName(nField), 12)
             If VALTYPE(&(FIELDNAME(nField))) = "C"
                @ 7 + nField, 25 Say PadL(FieldGet(nField), 45)
             Else
                @ 7 + nField, 25 Say FieldGet(nField)
             EndIf
         Next
         Inkey(0)
         WinShade(7, 10, 18, 70, "OFF")
         Return(1)
      ELSE
         Mensagem("TECLA/FUNCAO nao suportada!", 8, 1)
         Return(2)
      ENDIF
   ENDIF

Return(1)

***************************************************************** E O Function
