//

#Include "InKey.Ch"

//

Set Message To 24 Center
Setcursor(3)
Set Scoreboard Off
Set Delimiters On
Set Delimiters To "[]"
Set Confirm On
Set Deleted On
Set Escape On
Set Wrap On
Set Date To British

//

If IsColor()
   cCores := "W+/B+,W+/R,B,B,W+/B"   // CORES
Else
   cCores := "N/W,W/N,N,N,W/N"       // MONOCROMATICO
EndIf

SetColor(cCores)
Cls

// Usa as teclas ALT e F4 ou ALT e C para acabar

Set Key -33 To TerminarPrograma()
SetCancel(.F.)
Set Key 302 To TerminarPrograma()

//

Fundo("PROGRAMA XYZ")
cOpcao := TheMenu({ " Opcao 1 ", ;
                    " Opcao 2 ", ;
                    " Opcao 3 ", ;
                    " Opcao 4 ", ;
                    " Opcao 5 " }, ;
                    "Isto ‚ uma mensagem de teste com varias linhas de texto!!!")

// Retorna na variavel cOpcao o conteudo da opcao do menu

Set Color To
Cls
? "Voce escolheu a opcao -> "
?? cOpcao
? "Obrigado."
?
Quit


