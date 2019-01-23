#Include "Box.Ch"
#Include "Inkey.Ch"

Set Scoreboard Off
Set Wrap On
SetCancel(.F.)

Cor1:="W+/B,G+/R"
Cor2:="0/15,W+/R+"
Cor3:="GR+/BG+,W+/RB+"
Cor4:="GR+/RB+"
Cor5:="0/11"
Cor6:="W+/RB+"
Cor7:="W+/BG+"

SetColor(Cor1)
Clear Screen
SetCursor(0)
Som_Ligado:=1

If !FILE ("Entradas.Dbf") .Or. !FILE ("Saidas.Dbf") .Or. !FILE ("Tipos.Dbf") .Or. !FILE ("Rem_Dest.Dbf") .Or. !FILE ("Codigo.Dbf") .Or. !FILE ("Informa.Dbf") .Or. !FILE ("Historia.Dbf") .Or. !FILE ("Numeros.Dbf")
   Mensagem("Faltam um ou mais ficheiros de dados",0)
   SetColor("W/N")
   Clear Screen
   Quit
EndIf

Use Entradas NEW
Use Saidas NEW
Use Rem_Dest NEW
Use Tipos NEW
Use Codigo NEW
Use Informa NEW
Use Historia NEW
Use Numeros NEW

Public Num_,Data_,Tip_,Ref_,Data_Doc_,Rem_,Des_,Ass1,Ass2,Ass3,Ass4,Arq_
Public N_Ant,N_Pos,Obs_,BDados,Tec,Som_Ligado,Form_1,Form_2,N_Ant2,N_Pos2
Public Ins_Cons,EI,Letra1,Letra2,Letra3,Let2,Let3,N_Imp,St_A_Ler
Public Cons1,Cons2
Private M[5],V1[2],V2[3],V3[3],V4[7],V5[2],V[5],Li[5],Ci[5],Cs[5],Lf[5],Cf[5]
Private VM[5,2],Pos[12],Men1[8],Men2[8],Men_Imp[10]

Pos:={1,1,1,1,1,1,1,1,1,1,1,1}
Letra2:=Let2:=" Letra de qualidade   "
Letra3:=Let3:=" Letra cheia          "
Form_1=" Formato Nacional "+Chr(26)+" Dia/Mˆs/Ano    "
Form_2=" Formato ANSI     "+Chr(26)+" Ano.Mˆs.Dia    "
M:={" Documentos "," Consultas "," Listagens "," Diversos "," Sa¡da "}
V:={1,1,1,1,1}
V1:={" Inserir documentos "," Alterar documentos "}
V2:=V3:={" Entrada de documentos    "," Sa¡da de documentos      "," Hist¢ria de um documento "}
V4:={" Sobre o programa "," Informa‡”es GC   "," Informa‡”es PC   "," Som"+Space(14),;
     " Actualizar data  "," Formato da data  "," Bases de dados   "}
V5:={" Sa¡da para o DOS  "," Terminar Programa "}
VM[1]:={"Inserir um determinado documento (de qualquer tipo)    ","Alterar um determinado documento (de qualquer tipo)    "}
VM[2]:={"Consultar documentos de entrada"+Space(20),"Consultar documentos de sa¡da"+Space(20),"Consultar a hist¢ria de um documento de entrada ou de sa¡da"}
VM[3]:={"Listar documentos de entrada"+Space(20),"Listar documentos de sa¡da"+Space(20),"Listar a hist¢ria de um documento de entrada oude sa¡da"}
VM[4]:={"Apresenta informa‡”es a prop¢sito do programa","Apresenta o n§ de documentos existentes (entradas e sa¡das)","Apresenta algumas informa‡”es £teis do PC"+Space(9),;
        "Liga ou desliga o som"+Space(27),"Actualiza a data e/ou a hora do sistema","Possibilita a escolha do formato da data","Permite acrescentar novos dados  s bases de dados"}
VM[5]:={"Vai ao DOS e regressa com EXIT"+Space(18),"Termina a execu‡„o do programa"+Space(18)}
Ci:={6,21,36,51,65}
Li[1]:=Li[2]:=Li[3]:=Li[4]:=Li[5]:=3
Lf:={6,7,7,11,6}
Cs:={2,15,34,48,56}
Cf:={23,42,61,67,76}
Select 6
If Som=1
   Som_Ligado:=0
ElseIf Som=0
   Som_Ligado=1
EndIf
Form_Data(Data)
Som(0)
Run Ecra_Gc

Tecla:=0
SetCursor(0)
SetColor(Cor1)
KeyBoard Chr(0)
Do While Tecla=0
   Scroll(14,54,16,60,1)
   Scroll(16,0,24,79,1)
   Inkey(.2)
   Tecla=Lastkey()
   If Tecla=0
      Scroll(16,0,24,79,-1)
      Scroll(14,54,16,60,-1)
      Inkey(.2)
   EndIf
   Tecla=Lastkey()
EndDo
Codigo(0)

Do Rotinas
Do Menus
Do Apr

Set Key K_ALT_A To O_Autor()
Set Key K_ALT_C To Info_PC()
Set Key K_ALT_F To Formato_Data()
Set Key K_ALT_G To Info_GC()
Set Key K_ALT_O To Teclas_Atalho()
Set Key K_ALT_P To O_Programa()
Set Key K_ALT_S To Saida()
Set Key K_ALT_U To Actualizar()
Set Key K_ALT_Q To Ir_Ao_Dos()
Set Key K_ALT_J To Escreve_Ajuda()
Set Key K_F1 To Ajuda()
Set Key K_SH_TAB To Passa_Tempo()

Oppri:=OpSeg:=1
Vet:="V1"

Clear Screen
SetColor(Cor1)
@ 00,0 To 2,79
@ 03,0 To 21,79
@ 22,0 To 24,79
Ap(23,"  [Esc  Abortar] [Alt-S  Sair do programa] [Alt-G  Informar] [Alt-O  Outras]  ")
Ecra=SaveScreen(3,1,15,78)
Do While .T.
   Codtec:=0
   Do While Codtec!=13 .And. Codtec!=27
      CodTec:=Menu_(&Vet,Oppri,Opseg)
      If Codtec=27
         Saida()
      ElseIf Codtec=13
         Do Case
            Case Oppri=1
                 Do Case
                    Case OpSeg=1
                         Menu1("I")
                    Case OpSeg=2
                         Menu1("A")
                 EndCase
            Case Oppri=2
                 Do Case
                    Case OpSeg=1
                         Menu3("E","E")
                    Case OpSeg=2
                         Menu3("S","E")
                    Case OpSeg=3
                         Menu4("E")
                 EndCase
            Case Oppri=3
                 Do Case
                    Case OpSeg=1
                         Menu3("E","I")
                    Case OpSeg=2
                         Menu3("S","I")
                    Case OpSeg=3
                         Menu4("I")
                 EndCase
            Case Oppri=4
                 Do Case
                    Case OpSeg=1
                         Menu2()
                    Case OpSeg=2
                         Info_GC()
                    Case OpSeg=3
                         Info_PC()
                    Case OpSeg=4
                         Som(1)
                    Case OpSeg=5
                         Actualizar()
                    Case OpSeg=6
                         Formato_Data()
                    Case OpSeg=7
                         Menu_BDados()
                 EndCase
            Case Oppri=5
                 Do Case
                    Case OpSeg=1
                         Ir_Ao_Dos()
                    Case OpSeg=2
                         Saida()
                 EndCase
        EndCase
      Endif
   Enddo
Enddo

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Grava
Parameters Op,Op1,Op2,Op3,Op4,Op5,Op6,Op7,Op8,Op9,Op10,Op11,Op12,Op13,Op14
If Op1="E"
   Select 1
ElseIf Op1="S"
   Select 2
EndIf
If Op="0"
   Append Blank
Else
   Set Filter To Numero=Val(Op)
   Go Top
EndIf
Replace Numero With Op2
Replace Data With Op3
Replace Tipo With Op4
Replace Referencia With Op5
Replace Data_Doc With Op6
If BDados="E"
   Replace Remetente With Op7
ElseIf BDados="S"
   Replace Destinatar With Op7
EndIf
Replace Assunto1 With Op8
Replace Assunto2 With Op9
Replace Assunto3 With Op10
Replace Assunto4 With Op11
Replace Arquivo With Op12
Replace Num_Ant With Op13
Replace Observa With Op14
Set Filter To
If Op13!=0
   Num_Posterior(Op2)
EndIf
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Rem_Des()
Ecra_RD=SaveScreen(0,0,24,79)
Area:=Select()
Select 3
Count To N_Recs
If N_Recs=0
   Mensagem("N„o foi encontrado nenhum registo",0)
   Select &Area
   Return
Endif
Colunas:={"Nome"}
If BDados="E"
   Titulos:={"                    Remetentes                    "}
ElseIf BDados="S"
   Titulos:={"                   Destinat rios                  "}
EndIf
Cons1:=Cons2:=1
Consulta(10,15,64,Titulos,Colunas,1,6)
RestScreen(0,0,24,79,Ecra_RD)
If Ins_Cons="C"
   Nome_:=St_A_Ler
Else
   If BDados="E"
      Nome_:=Rem_
   ElseIf BDados="S"
      Nome_:=Des_
   EndIf
EndIf
If LastKey()=K_ENTER
   Nome_:=TransForm(Nome,"@!")
   If Ins_Cons="I"
      @ 9,20 Say Nome_ Color Cor2
   EndIf
Endif
Select &Area
If Ins_Cons="C"
   Return St_A_Ler:=Nome_
Else
   If BDados="E"
      Return Rem_:=Nome_
   ElseIf BDados="S"
      Return Des_:=Nome_
   EndIf
EndIf
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Num_Anterior()
Ecra_N=SaveScreen(0,0,24,79)
Area:=Select()
If BDados="E"
   Select 2
ElseIf BDados="S"
   Select 1
EndIf
If BDados="E"
   Copy To Numero FIELDS Numero,Data,Tipo,Destinatar For Num_Pos=0
ElseIf BDados="S"
   Copy To Numero FIELDS Numero,Data,Tipo,Remetente For Num_Pos=0
EndIf
Select 8
Zap
Append From Numero
Count To N_Recs
If N_Recs=0
   Mensagem("N„o foi encontrado nenhum documento anterior",0)
   Select &Area
   Return 0
Endif
If BDados="E"
   Titulos:={" N§ ","  Data  "," Tipo Doc ","                  Destinat rios                   "}
   Colunas:={"Numero","Data","Tipo","Destinatar"}
ElseIf BDados="S"
   Titulos:={" N§ ","  Data  "," Tipo Doc ","                    Remetente                     "}
   Colunas:={"Numero","Data","Tipo","Remetente"}
EndIf
Cons1:=Cons2:=1
Consulta(12,2,76,Titulos,Colunas,4,6)
RestScreen(0,0,24,79,Ecra_N)
If LastKey()=K_ENTER
   @ 16,66 Say Numero Picture "9999" Color Cor2
   Return Numero
Endif
Select &Area
Return 0

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Num_Posterior()
Parameters Numero_Actual
Area:=Select()
If BDados="E"
   Select 2
ElseIf BDados="S"
   Select 1
EndIf
Set Filter To Numero=N_Ant
Go Top
Replace Num_Pos With Numero_Actual
Set Filter To
Select &Area
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Inic_Var1()
Data_:=Date()
Tip_:=Space(10)
Ref_:=Space(10)
Data_Doc_:=Date()
Rem_:=Space(50)
Des_:=Space(50)
Arq_:=Space(20)
Obs_:=Space(48)
Ass1:=Space(52)
Ass2:=Space(52)
Ass3:=Space(52)
Ass4:=Space(52)
N_Ant:=0
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Inic_Var2()
Num_:=Numero
Data_:=Data
Tip_:=Tipo
Ref_:=Referencia
Data_Doc_:=Data_Doc
If BDados="E"
   Rem_:=Remetente
ElseIf BDados="S"
   Des_:=Destinatar
EndIf
Arq_:=Arquivo
Obs_:=Observa
Ass1:=Assunto1
Ass2:=Assunto2
Ass3:=Assunto3
Ass4:=Assunto4
N_Ant:=Num_Ant
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ler()
Parameters Ent_Sai
@ 5,30 Get Data_ Picture "D" Color Cor2
@ 5,60 Get Tip_ Picture "@!" Color Cor2
@ 7,21 Get Ref_ Picture "@!" Color Cor2
@ 7,52 Get Data_Doc_ Picture "D" Color Cor2
If Ent_Sai="E"
   @ 9,20 Get Rem_ Picture "@!" Color Cor2
ElseIf Ent_Sai="S"
   @ 9,20 Get Des_ Picture "@!" Color Cor2
EndIf
@ 11,18 Get Ass1 Picture "@!" Color Cor2
@ 12,18 Get Ass2 Picture "@!" Color Cor2 When Ass1!=Space(52) .Or. Ass2!=Space(52)
@ 13,18 Get Ass3 Picture "@!" Color Cor2 When Ass2!=Space(52) .Or. Ass3!=Space(52)
@ 14,18 Get Ass4 Picture "@!" Color Cor2 When Ass3!=Space(52) .Or. Ass4!=Space(52)
@ 16,18 Get Arq_ Picture "@!" Color Cor2
@ 16,66 Get N_Ant Picture "9999" Color Cor2
@ 18,22 Get Obs_ Picture "@!" Color Cor2
Read
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Ler_Doc
Parameters Ent_Sai
BDados:=Ent_Sai
EcraL:=SaveScreen(0,0,24,79)
Quadro(BDados)
Inic_Var1()
Acabou:=1
If Ent_Sai="E"
   Ap(1,"     [Alt-T  Tipos de docs] [Alt-R  Remetentes] [Alt-N  Docs anteriores]      ")
ElseIf Ent_Sai="S"
   Ap(1,"     [Alt-T  Tipos de docs] [Alt-E  Remetentes] [Alt-N  Docs anteriores]      ")
EndIf
Do While Acabou=1
   Activa_Teclas()
   If Ent_Sai="E"
      Select 1
   ElseIf Ent_Sai="S"
      Select 2
   EndIf
   Go Bottom
   Num_:=Numero+1
   SetCursor(1)
   @ 5,17 Say Num_ Picture "9999" Color Cor2
   Ler(Ent_Sai)
   Desactiva_Teclas()
   If LastKey()=K_ESC
      Mensagem("Confirma a sa¡da deste ecr„?",3)
      If Tec=1
         RestScreen(0,0,24,79,EcraL)
         Return
      EndIf
   Else
      Mensagem("Aten‡„o! Fa‡a a escolha de uma das seguintes op‡”es",2)
      Do Case
         Case Tec=1
              Acabou:=0
         Case Tec=3
              If Ent_Sai="E"
                 Grava("0",Ent_Sai,Num_,Data_,Tip_,Ref_,Data_Doc_,Rem_,Ass1,Ass2,Ass3,Ass4,Arq_,N_Ant,Obs_)
              ElseIf Ent_Sai="S"
                 Grava("0",Ent_Sai,Num_,Data_,Tip_,Ref_,Data_Doc_,Des_,Ass1,Ass2,Ass3,Ass4,Arq_,N_Ant,Obs_)
              EndIf
              Inic_Var1()
      EndCase
   EndIf
EndDo
RestScreen(0,0,24,79,EcraL)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Escolhe_Doc()
Ecra_E=SaveScreen(0,0,24,79)
Count To N_Recs
If N_Recs=0
   Mensagem("N„o foi encontrado nenhum documento",0)
   Return 0
EndIf
If BDados="E"
   Colunas:={"Numero","Data","Tipo","Remetente"}
   Titulos:={" N§ ","  Data  "," Tipo Doc ","                    Remetente                     "}
ElseIf BDados="S"
   Colunas:={"Numero","Data","Tipo","Destinatar"}
   Titulos:={" N§ ","  Data  "," Tipo Doc ","                  Destinat rios                   "}
EndIf
Cons1:=Cons2:=1
Consulta(12,2,76,Titulos,Colunas,4,6)
RestScreen(0,0,24,79,Ecra_E)
If LastKey()=K_ENTER
   Return Numero
Endif
Return 0

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Alterar
Parameters Ent_Sai
Local Num_Doc_Alt
EcraA:=SaveScreen(0,0,24,79)
BDados:=Ent_Sai
Num_Doc_Alt:=Ler_Numero("N§ do documento a alterar")
If LastKey()!=K_ESC
   Quadro(BDados)
   If Ent_Sai="E"
      Ap(1,"     [Alt-T  Tipos de docs] [Alt-R  Remetentes] [Alt-N  Docs anteriores]      ")
   ElseIf Ent_Sai="S"
      Ap(1,"     [Alt-T  Tipos de docs] [Alt-E  Remetentes] [Alt-N  Docs anteriores]      ")
   EndIf
   Acabou:=1
Else
   Acabou:=0
EndIf
Do While Acabou=1
   Set Filter To Numero=Num_Doc_Alt
   Go Top
   Inic_Var2()
   SetCursor(1)
   @ 5,17 Say Num_Doc_Alt Picture "9999" Color Cor2
   Set Filter To
   Activa_Teclas()
   Ler(Ent_Sai)
   Desactiva_Teclas()
   If LastKey()=K_ESC
      Mensagem("Confirma a sa¡da deste ecr„?",3)
      If Tec=1
         RestScreen(0,0,24,79,EcraA)
         Return
      EndIf
   Else
      Mensagem("Aten‡„o! Fa‡a a escolha de uma das seguintes op‡”es",2)
   EndIf
   Do Case
      Case Tec=1
           Acabou:=0
      Case Tec=3
           If Ent_Sai="E"
              Grava(Str(Num_Doc_Alt),Ent_Sai,Num_,Data_,Tip_,Ref_,Data_Doc_,Rem_,Ass1,Ass2,Ass3,Ass4,Arq_,N_Ant,Obs_)
           ElseIf Ent_Sai="S"
              Grava(Str(Num_Doc_Alt),Ent_Sai,Num_,Data_,Tip_,Ref_,Data_Doc_,Des_,Ass1,Ass2,Ass3,Ass4,Arq_,N_Ant,Obs_)
           EndIf
           Acabou:=0
   EndCase
EndDo
RestScreen(0,0,24,79,EcraA)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Hist()
Parameters Ent_Sai
Local Num_Doc_Hist,Area1,Area2
EcraH:=SaveScreen(0,0,24,79)
BDados:=Ent_Sai
Num_Doc_Hist:=Ler_Numero("N§ do documento")
N_Ant2:=Num_Doc_Hist
N_Pos2:=Num_Doc_Hist
Select 7
Zap
If Ent_Sai="E"
   Area1:=1
   Area2:=2
ElseIf Ent_Sai="S"
   Area1:=2
   Area2:=1
EndIf
If LastKey()=K_ESC
   RestScreen(0,0,24,79,EcraH)
   Return
EndIf
Acabou:=1
Do While Acabou=1
   If N_Ant2!=0
      Select &Area1
      Set Filter To Numero=N_Ant2
      Go Top
      N_Ant2:=Num_Ant
      Set Filter To
      If N_Ant2!=0
         N_Pos2:=N_Ant2
      EndIf
   EndIf
   If N_Ant2!=0
      Select &Area2
      Set Filter To Numero=N_Ant2
      Go Top
      N_Ant2:=Num_Ant
      Set Filter To
      If N_Ant2!=0
         N_Pos2:=N_Ant2
      EndIf
   EndIf
   If N_Ant2=0
      Acabou:=0
   EndIf
EndDo
Area:=Select()
If Area=1
   Area1:=1
   Area2:=2
Else
   Area1:=2
   Area2:=1
EndIf
Acabou:=1
Do While Acabou=1
   If N_Pos2!=0
      Select &Area1
      Bd_Hist()
   EndIf
   If N_Pos2!=0
      Select &Area2
      Bd_Hist()
   EndIf
   If N_Pos2=0
      Acabou:=0
   EndIf
EndDo
Select 7
Count To N_Recs
Go Top
If EI="E"
   Ap(1,"                   [Enter  para visualizar este documento]                    ")
   Colunas:={"Bd","Numero","Data","Tipo","Nome"}
   Titulos:={"D"," N§ ","  Data  "," Tipo Doc ","                       Nome                       "}
   Tecla:=0
   Cons1:=Cons2:=1
   Do While Tecla=0
      Consulta(12,1,77,Titulos,Colunas,5,6)
      If LastKey()=K_ESC
         Tecla:=1
      Else
         Controla()
         Tecla:=0
      EndIf
   EndDo
ElseIf EI="I"
   Imprime(BDados,"H")
EndIf
RestScreen(0,0,24,79,EcraH)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Bd_Hist()
Local Numero2,Data2,Tipo2,Ref2,Data_Doc2,Nome2,Ass21,Ass22,Ass23,Ass24,Arq2,N_Ant2,Obs2
Area:=Select()
Set Filter To Numero=N_Pos2
Go Top
N_Pos2:=Num_Pos
Numero2:=Numero
Data2:=Data
Tipo2:=Tipo
Ref2:=Referencia
Data_Doc2:=Data_Doc
If Area=1
   Nome2:=Remetente
   Bd2:="E"
ElseIf Area=2
   Nome2:=Destinatar
   Bd2:="S"
EndIf
Ass21:=Assunto1
Ass22:=Assunto2
Ass23:=Assunto3
Ass24:=Assunto4
Arq2:=Arquivo
N_Ant2:=Num_Ant
Obs2:=Observa
Set Filter To
Select 7
Append Blank
Replace Numero With Numero2
Replace Data With Data2
Replace Tipo With Tipo2
Replace Referencia With Ref2
Replace Data_Doc With Data_Doc2
Replace Nome With Nome2
Replace Assunto1 With Ass21
Replace Assunto2 With Ass22
Replace Assunto3 With Ass23
Replace Assunto4 With Ass24
Replace Arquivo With Arq2
Replace Observa With Obs2
Replace Bd With Bd2
Select &Area
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Controla()
Area:=Select()
If Lastkey()=K_ENTER
   Num__:=Numero
   If Bd="E"
      Select 1
      Escreve_Doc("E",Num__)
   ElseIf Bd="S"
      Select 2
      Escreve_Doc("S",Num__)
   EndIf
EndIf
Select &Area
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Controla_2()
Area:=Select()
If Lastkey()=K_ENTER
   Num__:=Numero
   Escreve_Doc(BDados,Num__)
EndIf
Select &Area
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Escreve_Doc()
Parameters Ent_Sai,Num__
Area2:=Select()
EcraED:=SaveScreen(0,0,24,79)
Quadro(Ent_Sai)
Ap(1,"                           [Enter  para continuar]                            ")
SetColor(Cor2)
If Ent_Sai="E"
   Select 1
ElseIf Ent_Sai="S"
   Select 2
EndIf
Set Filter To Numero=Num__
Go Top
@ 5,17 Say Numero Picture "9999"
@ 5,30 Say Data
@ 5,60 Say Tipo
@ 7,21 Say Referencia
@ 7,52 Say Data_Doc
If Ent_Sai="E"
   @ 9,20 Say Remetente
ElseIf Ent_Sai="S"
   @ 9,20 Say Destinatar
EndIf
@ 11,18 Say Assunto1
@ 12,18 Say Assunto2
@ 13,18 Say Assunto3
@ 14,18 Say Assunto4
@ 16,18 Say Arquivo
@ 16,66 Say Num_Ant
@ 18,22 Say Observa
Inkey(0)
Set Filter To
RestScreen(0,0,24,79,EcraED)
Select &Area2
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ler_Numero()
Parameters Mens
Local Num_A_Ler
Ap(1,"                 [Alt-M  Documentos que podem ser alterados]                  ")
Cur:=SetColor()
N=Len(Mens+Space(6))
Janela(12,((80-N)/2)-2,14,((80+N)/2)+1)
Num_A_Ler:=0
Cont2:=0
If BDados="E"
   Select 1
ElseIF BDados="S"
   Select 2
EndIf
Do While Cont2=0
   Set Key K_ALT_M To Num_A_Ler:=Escolhe_Doc()
   SetCursor(1)
   @ 13,(80-N)/2 Say Mens+":" Color Cor7 Get Num_A_Ler Picture "9999" Color Cor2
   Read
   SetCursor(0)
   Set Key K_ALT_M To
   Go Bottom
   Num_Max:=Numero
   Cont2:=1
   If LastKey()=K_ESC
      Cont2:=1
   ElseIf Num_A_Ler<=0
      Cont2:=0
   ElseIf Num_A_Ler>Num_Max
      Mensagem("O n§ inserido n„o ‚ v lido",0)
      Cont2:=0
   EndIf
EndDo
Return Num_A_Ler

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Cons_Num()
Parameters Ent_Sai
Local Num_Doc_Cons
EcraCN:=SaveScreen(0,0,24,79)
BDados:=Ent_Sai
Num_Doc_Cons:=Ler_Numero("N§ do documento")
If LastKey()=K_ENTER
   If EI="E"
      Escreve_Doc(BDados,Num_Doc_Cons)
   ElseIf EI="I"
      Set Filter To Numero=Num_Doc_Cons
      Go Top
      Imprime(BDados," ")
      Set Filter To
   EndIf
EndIf
RestScreen(0,0,24,79,EcraCN)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Cons_St()
Parameters Ent_Sai,Mens,Mens2,Op
Local N_Espacos
Ecra_CS:=SaveScreen(0,0,24,79)
If Op="D"
   N_Espacos:=8
ElseIf Op="T"
   Ap(1,"                 [Alt-M  Documentos que podem ser alterados]                  ")
   N_Espacos:=10
ElseIf Op="F"
   N_Espacos:=10
ElseIf Op="N"
   Ap(1,"                 [Alt-M  Documentos que podem ser alterados]                  ")
   N_Espacos:=50
ElseIf Op="A"
   N_Espacos:=20
EndIf
Cur:=SetColor()
N=Len(Mens+Space(N_Espacos+2))
Janela(12,((80-N)/2)-2,14,((80+N)/2)+1)
If Op!="D"
   St_A_Ler:=Space(N_Espacos)
Else
   St_A_Ler:=Date()
EndIf
Cont2:=0
If Ent_Sai="E"
   Select 1
ElseIF Ent_Sai="S"
   Select 2
EndIf
BDados:=Ent_Sai
Do While Cont2=0
   Ins_Cons:="C"
   If Op="T"
      Set Key K_ALT_M To St_A_Ler:=Menu_Tipo()
   ElseIf Op="N"
      Set Key K_ALT_M To St_A_Ler:=Rem_Des()
   EndIf
   SetCursor(1)
   @ 13,(80-N)/2 Say Mens+":" Color Cor7 Get St_A_Ler Picture "@!" Color Cor2
   Read
   SetCursor(0)
   Set Key K_ALT_M To
   If Op="D"
      Set Filter To St_A_Ler=Data
   ElseIf Op="T"
      Set Filter To RTrim(St_A_Ler) $ Tipo
   ElseIf Op="F"
      Set Filter To RTrim(St_A_Ler) $ Referencia
   ElseIf Op="N"
      If Ent_Sai="E"
         Set Filter To RTrim(St_A_Ler) $ Remetente
      ElseIf Ent_Sai="S"
         Set Filter To RTrim(St_A_Ler) $ Destinatar
      EndIf
   ElseIf Op="A"
      Set Filter To RTrim(St_A_Ler) $ Arquivo
   EndIf
   Count To N_Recs
   Cont2:=1
   If LastKey()=K_ESC
      Cont2:=1
   ElseIf Len(TransForm(St_A_Ler,"D"))=0
      Cont2:=0
   ElseIf N_Recs=0
      Mensagem(Mens2,0)
      Cont2:=0
   EndIf
   Set Filter To
EndDo
RestScreen(0,0,24,79,Ecra_CS)
If LastKey()=K_ESC
   Return
EndIf
If Op="D"
   Set Filter To St_A_Ler=Data
ElseIf Op="T"
   Set Filter To RTrim(St_A_Ler) $ Tipo
ElseIf Op="F"
   Set Filter To RTrim(St_A_Ler) $ Referencia
ElseIf Op="N"
   If Ent_Sai="E"
      Set Filter To RTrim(St_A_Ler) $ Remetente
   ElseIf Ent_Sai="S"
      Set Filter To RTrim(St_A_Ler) $ Destinatar
   EndIf
ElseIf Op="A"
   Set Filter To RTrim(St_A_Ler) $ Arquivo
EndIf
Go Top
If EI="E"
   If Ent_Sai="E"
      Copy To Numero FIELDS Numero,Data,Tipo,Referencia,Remetente,Arquivo
   ElseIf Ent_Sai="S"
      Copy To Numero FIELDS Numero,Data,Tipo,Referencia,Destinatar,Arquivo
   EndIf
   Set Filter To
   Select 8
   Zap
   Append From Numero
   Set Filter To
   Go Top
   Ap(1,"                   [Enter  para visualizar este documento]                    ")
   Tecla:=0
   Cons1:=Cons2:=1
   Do While Tecla=0
      If Op="D" .Or. Op="T" .Or. Op="N"
         If Ent_Sai="E"
            Titulos:={" N§ ","  Data  "," Tipo Doc ","                    Remetente                     "}
            Colunas:={"Numero","Data","Tipo","Remetente"}
         ElseIf Ent_Sai="S"
            Titulos:={" N§ ","  Data  "," Tipo Doc ","                   Destinat rio                   "}
            Colunas:={"Numero","Data","Tipo","Destinatar"}
         EndIf
         Consulta(12,2,76,Titulos,Colunas,4,6)
      ElseIf Op="F"
         If Ent_Sai="E"
            Titulos:={" N§ ","  Data  ","Referˆncia","                    Remetente                     "}
            Colunas:={"Numero","Data","Referencia","Remetente"}
         ElseIf Ent_Sai="S"
            Titulos:={" N§ ","  Data  ","Referˆncia","                   Destinat rio                   "}
            Colunas:={"Numero","Data","Referencia","Destinatar"}
         EndIf
         Consulta(12,2,76,Titulos,Colunas,4,6)
      ElseIf Op="A"
         Titulos:={" N§ ","  Data  ","Referˆncia","      Arquivo       "}
         Colunas:={"Numero","Data","Referencia","Arquivo"}
         Consulta(12,16,60,Titulos,Colunas,4,6)
      EndIf
      If LastKey()=K_ESC
         Tecla:=1
      Else
         Controla_2()
         Tecla:=0
      EndIf
   EndDo
ElseIf EI="I"
   Imprime(BDados," ")
   Set Filter To
EndIf
RestScreen(0,0,24,79,Ecra_CS)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Imprime()
Parameters Ent_Sai,Ent_Sai2
Local Tipo__,Ref__,Nome__,Nom__,As1,Arq__,Obs__,Linha,Linha2
If !IsPrinter()
   Mensagem("Impressora desligada ou sem papel",0)
Else
   Linha:=1
   Set Console Off
   Set Device To Printer
   Set Printer On
   ? Chr(15)
   Do While !Eof()
      Tipo__:=Tipo
      If Tipo=Space(10)
         Tipo__:="Nenhum    "
      EndIf
      Ref__:=Referencia
      If Referencia=Space(10)
         Ref__:="Nenhuma    "
      EndIf
      If Ent_Sai="E"
         Nome__:="  Remetente:"
         If Ent_Sai2=" "
            Nom__:=Remetente
            If Remetente=Space(50)
               Nom__:="Nenhum"+Space(44)
            EndIf
         EndIf
      Else
         Nome__:="  Destinat rio:"
         If Ent_Sai2=" "
            Nom__:=Destinatar
            If Destinatar=Space(50)
               Nom__:="Nenhum"+Space(44)
            EndIf
         EndIf
      EndIf
      If Ent_Sai2="H"
         Nom__:=Nome
         Ent_Sai:=Bd
         If Nome=Space(50)
            Nom__:="Nenhum"+Space(44)
         EndIf
      EndIf
      As1:=Assunto1
      If Assunto1=Space(52) .And. Assunto2=Space(52) .And. Assunto3=Space(52) .And. Assunto4=Space(52)
         As1:="Nenhum"+Space(46)
      EndIf
      Arq__:=Arquivo
      If Arquivo=Space(20)
         Arq__:="Nenhum"+Space(14)
      EndIf
      Obs__:=Observa
      If Observa=Space(48)
         Obs__:="Nenhuma"+Space(42)
      EndIf
      @ Linha,10 Say ""
      Linha:=Linha+1
      @ Linha,10 Say "Documento n§"+Str(Numero)+"  Data:"+TransForm(Data,"D")+"  Tipo de documento:"+Tipo__+"  Referˆncia:"+Ref__+"  Data do documento:"+TransForm(Data_Doc,"D")
      Linha:=Linha+1
      @ Linha,10 Say "Assunto:"+As1+Nome__+Nom__
      Linha:=Linha+1
      If Assunto2!=Space(50)
         @ Linha,10 Say Space(8)+Assunto2
         Linha:=Linha+1
      EndIf
      If Assunto3!=Space(50)
         @ Linha,10 Say Space(8)+Assunto3
         Linha:=Linha+1
      EndIf
      If Assunto4!=Space(50)
         @ Linha,10 Say Space(8)+Assunto4
         Linha:=Linha+1
      EndIf
      @ Linha,10 Say "Arquivo:"+Arq__+"  N§ do documento anterior:"+Str(Num_Ant)+"  Observa‡”es:"+Obs__
      Linha:=Linha+1
      @ Linha,10 Say ""
      Linha:=Linha+1
      Linha2:=6
      If Assunto2=Space(52) .And. Assunto3=Space(52) .And. Assunto4=Space(52)
         Linha2:=3
      ElseIf Assunto3=Space(52) .And. Assunto4=Space(52)
         Linha2:=4
      ElseIf Assunto4=Space(52)
         Linha2:=5
      EndIf
      If !Eof() .And. Linha+Linha2>=64
         Linha:=1
         Eject
      EndIf
      Skip
   EndDo
   ? Chr(18)
   Eject
   Set Printer Off
   Set Device To Screen
   Set Console On
EndIf
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Cons_Docs()
Parameters Ent_Sai
EcraCD:=SaveScreen(0,0,24,79)
If Ent_Sai="E"
   Select 1
ElseIf Ent_Sai="S"
   Select 2
EndIf
BDados:=Ent_Sai
If EI="E"
   Ap(1,"                   [Enter  para visualizar este documento]                    ")
   Tecla:=0
   Cons1:=Cons2:=1
   Do While Tecla=0
      If Ent_Sai="E"
         Titulos:={" N§ ","  Data  "," Tipo Doc ","                    Remetente                     "}
         Colunas:={"Numero","Data","Tipo","Remetente"}
      ElseIf Ent_Sai="S"
         Titulos:={" N§ ","  Data  "," Tipo Doc ","                  Destinat rios                   "}
         Colunas:={"Numero","Data","Tipo","Destinatar"}
      EndIf
      Consulta(12,2,76,Titulos,Colunas,4,6)
      If LastKey()=K_ESC
         Tecla:=1
      Else
         Controla_2()
         Tecla:=0
      EndIf
   EndDo
ElseIf EI="I"
   Go Top
   Imprime(BDados," ")
EndIf
RestScreen(0,0,24,79,EcraCD)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ins()
Parameters Mens,N_Espacos
Ecra_IS:=SaveScreen(12,0,15,79)
Cur:=SetColor()
N=Len(Mens+Space(N_Espacos+2))
Janela(12,((80-N)/2)-2,14,((80+N)/2)+1)
St_A_Ler:=Space(N_Espacos)
Do While St_A_Ler=Space(N_Espacos) .And. LastKey()!=K_ESC
   SetCursor(1)
   @ 13,(80-N)/2 Say Mens+":" Color Cor7 Get St_A_Ler Color Cor2
   Read
EndDo
SetCursor(Cur)
RestScreen(12,0,15,79,Ecra_IS)
Return St_A_Ler

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Ins_St(Mens,N_Esp,Ar,Campo)
Novo:=Ins(Mens,N_Esp)
If LastKey()=K_ENTER
   Area:=Select()
   Select &Ar
   Append Blank
   If Campo="Codigo"
      Replace &Campo With Encripta(Novo)
   Else
      Replace &Campo With Novo
   EndIf
   If Ar=3
      Sort To RemDest On Nome
      Zap
      Append From RemDest
   ElseIf Ar=4
      Sort To Tipo On Tipo_Doc
      Zap
      Append From Tipo
   EndIf
   Select &Area
EndIf
Return Novo

