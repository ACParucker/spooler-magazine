#Include "Box.Ch"
#Include "Inkey.Ch"

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Quadro()
Parameters Ent_Sai
SetColor("G+/B")
@ 0,0,2,79 BOX B_DOUBLE_SINGLE
@ 3,0,21,79 BOX B_DOUBLE_SINGLE
@ 22,0,24,79 BOX B_DOUBLE_SINGLE
@ 4,1 Clear To 20,78
SetColor("W+/B")
@ 5,09 Say "N£mero:"
@ 5,24 Say "Data:"
@ 5,41 Say "Tipo de documento:"
@ 7,09 Say "Referˆncia:"
@ 7,33 Say "Data do documento:"
If Ent_Sai="E"
   @ 9,09 Say "Remetente:"
ElseIf Ent_Sai="S"
   @ 9,09 Say "Destinat.:"
EndIf
@ 11,09 Say "Assunto:"
@ 16,09 Say "Arquivo:"
@ 16,46 Say "Documento anterior:"
@ 18,09 Say "Observa‡”es:"
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Enter(Lin,N)
@ Lin,37 Say " Enter " Color Cor4
Faz_Som()
If N=1
   Inkey(0)
EndIf
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function O_Autor()
Mensagem("GC 1.6 - 1993, (c)  Ant¢nio Jos‚ Monteiro Pereira",0)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function O_Programa()
Cur:=SetCursor()
Ecra31:=SaveScreen(0,0,24,79)
Janela(9,10,17,69)
SetCursor(0)
@ 11,28 Say "Gest„o de Correspondˆncia" Color Cor5
@ 13,12 Say "GC Vers„o 1.6 - 1993, (c)  Ant¢nio Jos‚ Monteiro Pereira" Color Cor5
Enter(15,1)
SetCursor(Cur)
RestScreen(0,0,24,79,Ecra31)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Teclas_Atalho()
Cur:=SetCursor()
Cor:=SetColor()
Ecra32:=SaveScreen(0,0,24,79)
Janela(5,8,17,72)
SetCursor(0)
SetColor(Cor5)
@ 07,14 Say "F1 "+Chr(26)+" Significado de cada ³   Shift-TAB "+Chr(26)+" Passa tempo "
@ 08,19 Say "campo de um doc.    ³"
@ 09,14 Say "Alt-A "+Chr(26)+" O Autor          ³   Alt-P "+Chr(26)+" O Programa"
@ 10,14 Say "Alt-S "+Chr(26)+" Sa¡da            ³   Alt-O "+Chr(26)+" Teclas de Atalho"
@ 11,14 Say "Alt-G "+Chr(26)+" Informa‡”es GC   ³   Alt-C "+Chr(26)+" Informa‡”es PC"
@ 12,14 Say "Alt-U "+Chr(26)+" Actualizar       ³   Alt-F "+Chr(26)+" Formato da Data"
@ 13,14 Say "Alt-Q "+Chr(26)+" Ir ao DOS        ³   Alt-J "+Chr(26)+" Ajuda"
Enter(15,1)
SetColor(Cor)
SetCursor(Cur)
RestScreen(0,0,24,79,Ecra32)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Escreve_Ajuda()
If !FILE("Ajuda_Gc.Txt")
   Mensagem("N„o foi encontrado o ficheiro 'Ajuda_Gc.Txt'",0)
   Return
EndIf
Ecra_Aj:=SaveScreen(0,0,24,79)
Janela(3,5,20,73)
Cur:=SetCursor()
Cor:=SetColor()
SetColor(Cor5)
SetCursor(1)
Texto:=MemoRead("Ajuda_Gc.Txt")
Faz_Som()
Texto:=MemoEdit(Texto,4,7,19,72,.F.)
SetCursor(Cur)
RestScreen(0,0,24,79,Ecra_Aj)
SetColor(Cor)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Info_GC()
Ecra33:=SaveScreen(0,0,24,79)
Cur:=SetCursor()
Area:=Select()
Select 1
Count To N_Entradas
Select 2
Count To N_Saidas
Janela(8,19,18,61)
SetCursor(0)
@ 10,23 Say "N§ de entradas de documentos "+Chr(26) Color Cor5
@ 10,54 Say Str(N_Entradas,4,0) Color Cor4
@ 12,23 Say "N§ de sa¡das de documentos   "+Chr(26) Color Cor5
@ 12,54 Say Str(N_Saidas,4,0) Color Cor4
@ 13,54 Say "ÄÄÄÄ" Color "1/BG+"
@ 14,23 Say "N§ total de documentos       "+Chr(26) Color Cor5
@ 14,54 Say Str(N_Entradas+N_Saidas,4,0) Color Cor4
Enter(16,1)
Select &Area
RestScreen(0,0,24,79,Ecra33)
SetCursor(Cur)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Info_PC()
Cur:=SetCursor()
Cor:=SetColor()
Ecra34:=SaveScreen(0,0,24,79)
Janela(6,16,18,63)
SetCursor(0)
SetColor(Cor5)
@ 08,20 Say "Espa‡o livre em disco     "+Chr(26)+" "+Str((DiskSpace()/1024)/1024,3,1)+" MBytes"
@ 09,20 Say "Espa‡o livre em mem¢ria   "+Chr(26)+" "+Str(Memory(0),5,1)+" KBytes"
@ 10,20 Say "Maior bloco de mem. livre "+Chr(26)+" "+Str(Memory(1),5,1)+" KBytes"
@ 11,20 Say "Mem¢ria livre para o DOS  "+Chr(26)+" "+Str(Memory(2),5,1)+" KBytes"
@ 12,20 Say "Data do Sistema Operativo "+Chr(26)+" "+TransForm(Date(),"D")
@ 13,20 Say "Hora do Sistema Operativo "+Chr(26)+" "+Time()
@ 14,20 Say "Sistema Operativo         "+Chr(26)+" "+Os()
Enter(16,0)
Tecla:=0
Keyboard Chr(0)
Do While Tecla=0
   @ 13,48 Say Time()
   Inkey(.1)
   Tecla=LastKey()
Enddo
SetColor(cor)
SetCursor(Cur)
RestScreen(0,0,24,79,Ecra34)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ir_Ao_Dos()
Ecra_ID=Savescreen(0,0,24,79)
Cur:=SetCursor()
SetColor("0/0")
Clear Screen
Mensagem("Para regressar ao GC, digite EXIT e prima ENTER",0)
SetColor("W/N")
Clear Screen
SetCursor(1)
@ 0,1
Run Command
SetCursor(Cur)
RestScreen(0,0,24,79,Ecra_ID)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Passa_Tempo()
EcraPT:=SaveScreen(0,0,24,79)
Ap(23,"                    [Autor  Ant¢nio Jos‚ Monteiro Pereira]                    ")
Tecla=0
Cur:=SetCursor()
SetCursor(0)
KeyBoard Chr(0)
Do While Tecla=0
   For I=1 To 22
       Ecra_PT:=SaveScreen(23-I,0,25-I,79)
       Inkey(.1)
       RestScreen(0,0,24,79,EcraPT)
       RestScreen(23-(I+1),0,25-(I+1),79,Ecra_PT)
       Tecla=Lastkey()
       If Tecla!=0
          I:=23
       EndIf
   Next
   If Tecla=0
      For I=1 To 22
         Ecra_PT:=SaveScreen(I-1,0,I+1,79)
          Inkey(.1)
          RestScreen(0,0,24,79,EcraPT)
          RestScreen(I,0,I+2,79,Ecra_PT)
          Tecla=Lastkey()
          If Tecla!=0
             I:=23
          EndIf
      Next
   EndIf
   Tecla=Lastkey()
Enddo
RestScreen(0,0,24,79,EcraPT)
SetCursor(Cur)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Saida()
Private Apaga[3]
Mensagem("Confirma a sa¡da do programa?",3)
EcraS:=SaveScreen(0,0,24,79)
If Tec=1
   SetColor("W/N")
   Clear All
   For I=1 To 25
       Scroll(0,0,24,39,1)
       Scroll(0,40,24,79,-1)
   Next
   Apaga:={"RemDest.Dbf","Tipo.Dbf","Numero.Dbf"}
   For I=1 To 3
       If FILE (Apaga[I])
          FErase(Apaga[I])
       EndIf
   Next
   @ 0,0
   SetCursor(1)
   Quit
EndIf
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ap()
Parameters Lin,Linha
Local N_Op,I,J,Linha1
Private B1[4],B2[4]
N_Op:=0
For I=1 To Len(Linha)
    If SubStr(Linha,I,1)="["
       N_Op:=N_Op+1
       B1[N_Op]:=I+1
    ElseIf SubStr(Linha,I,1)="]"
       B2[N_Op]:=I
    EndIf
Next
@ Lin,1 Say Linha Color "G+/RB+"
J:=1
Do While J<=N_Op
   Linha1:=Linha
   Linha1:=SubStr(Linha1,B1[J],Len(Linha1)-(B1[J])-(Len(Linha1)-B2[J]))
   For I=1 To Len(Linha1)
       If SubStr(Linha1,I,1)!="E"
          @ Lin,B1[J] Say Substr(Linha1,1,5) Color Cor4
          @ Lin,B1[J]+Len(Substr(Linha1,1,5))+2 Say Substr(Linha1,8,Len(Linha1)-7) Color Cor6
       Else
          @ Lin,B1[J] Say Substr(Linha1,1,3) Color Cor4
          @ Lin,B1[J]+Len(Substr(Linha1,1,3))+2 Say Substr(Linha1,6,Len(Linha1)-5) Color Cor6
       EndIf
   Next
   J:=J+1
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Som(M)
If Som_Ligado=1
   V4[4]:=" Som              "
   Som_Ligado:=0
ElseIf Som_Ligado=0
   V4[4]:=" Som            û "
   Som_Ligado:=1
EndIf
If M=1
   Faz_Som()
EndIf
Area:=Select()
Select 6
Replace Som With Som_Ligado
Select &Area
SetColor(Cor1)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Form_Data(FD)
Area:=Select()
Select 6
If FD=1
   Form_1=" Formato Nacional "+Chr(26)+" Dia/Mˆs/Ano  û "
   Form_2=" Formato ANSI     "+Chr(26)+" Ano.Mˆs.Dia    "
   Set Date British
ElseIf FD=2
   Form_1=" Formato Nacional "+Chr(26)+" Dia/Mˆs/Ano    "
   Form_2=" Formato ANSI     "+Chr(26)+" Ano.Mˆs.Dia  û "
   Set Date Ansi
EndIf
Replace Data With FD
Select &Area
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Actualizar()
Local Data_Act
Cur:=SetCursor()
EcraA:=SaveScreen(0,0,24,79)
Data_Act:=Date()
Janela(9,33,11,50)
SetCursor(1)
@ 10,35 Say "Data:" Color Cor7 Get Data_Act Picture "D" Color Cor2
Read
RestScreen(0,0,24,79,EcraA)
St1:="Date "+TransForm(Data_Act,"D")
If LastKey()=K_ENTER
   Run &St1>Nul
EndIf
SetCursor(Cur)
RestScreen(0,0,24,79,EcraA)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Activa_Teclas()
Ins_Cons:="I"
Set Key K_ALT_T To Tip_:=Menu_Tipo()
If BDados="E"
   Set Key K_ALT_R To Rem_=Rem_Des()
ElseIf BDados="S"
   Set Key K_ALT_E To Des_=Rem_Des()
EndIf
Set Key K_ALT_N To N_Ant:=Num_Anterior()
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Desactiva_Teclas()
Set Key K_ALT_T To
If BDados="E"
   Set Key K_ALT_R To
ElseIf BDados="S"
   Set Key K_ALT_E To
EndIf
Set Key K_ALT_N To
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Verifica()
Parameters Ent_Sai
Area:=Select()
If Ent_Sai="E"
   Select 1
ElseIf Ent_Sai="S"
   Select 2
ElseIf Ent_Sai="T"
   Select 1
EndIf
Count To N_Recs
If Ent_Sai="T"
   Select 2
   Count To N_Recs2
   N_Recs:=N_Recs+N_Recs2
EndIf
If N_Recs=0
   Mensagem("N„o foi encontrado nenhum documento nas bases de dados",0)
EndIf
Select &Area
Return N_Recs

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ajuda()
Cur:=SetCursor()
Cor:=SetColor()
Ecra32:=SaveScreen(0,0,24,79)
Janela(1,2,22,77)
SetCursor(0)
SetColor(Cor5)
@ 03,04 Say "Significado de cada campo:"
@ 05,07 Say "ş N£mero:  o n£mero do documento."
@ 06,17 Say "Este campo incrementa-se automaticamente."
@ 07,07 Say "ş Data:  a data da chegada ou s ida do documento."
@ 08,07 Say "ş Tipo de documento:  o tipo do documento entrado ou sa¡do."
@ 09,07 Say "ş Referˆncia:  a referˆncia do documento entrado ou sa¡do."
@ 10,07 Say "ş Data do documento: ‚ a data em que o documento foi elaborado."
@ 11,07 Say "ş Remetente:  o nome da pessoa (institui‡„o) que enviou o documento."
@ 12,07 Say "ş Destinat rio:  o nome da pessoa (institui‡„o) para quem foi envia-"
@ 13,23 Say "do o documento."
@ 14,07 Say "ş Assunto:  o assunto (motivo) do chegada ou sa¡da de  um documento."
@ 15,18 Say "Est„o dispon¡veis 4 linhas para este campo."
@ 16,07 Say "ş Arquivo:  a coloca‡„o do documento."
@ 17,07 Say "ş Documento anterior:  o n§ do documento anterior (se houver)."
@ 18,07 Say "ş Observa‡”es: S„o observa‡”es necess rias ao documento."
Enter(20,1)
SetColor(Cor)
SetCursor(Cur)
RestScreen(0,0,24,79,Ecra32)
Return

