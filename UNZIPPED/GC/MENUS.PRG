#Include "Inkey.Ch"

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Teclas()
Do Case
   Case LastKey()=28
        Ajuda()
   Case LastKey()=286
        O_Autor()
   Case LastKey()=281
        O_Programa()
   Case LastKey()=280
        Teclas_Atalho()
   Case LastKey()=292
        Escreve_Ajuda()
   Case LastKey()=302
        Info_PC()
   Case LastKey()=290
        Info_GC()
   Case LastKey()=278
        Actualizar()
   Case LastKey()=289
        Formato_Data()
   Case LastKey()=272
        Ir_Ao_Dos()
   Case LastKey()=287
        Saida()
   Case LastKey()=271
        Passa_Tempo()
EndCase
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function SubMenu(P,Lin,Col,Men1,Men2,N_Op,Max)
Cur:=SetCursor()
Posi:=Pos[P]
Cont:=0
Cont1:=0
SetCursor(0)
Do While Cont=0
   Do While Cont1=0
      Janela(Lin-1,Col-1,Lin+N_Op,Col+Max)
      For I=1 To N_Op
          @ Lin+(I-1),Col Say Men1[I] Color Cor3
      Next
      Cont1:=1
   EndDo
   @ Lin+(Posi-1),Col Say Men1[Posi] Color Cor6
   @ 20,2 Say Men2[Posi]+Space(15) Color "W+/B"
   Inkey(0)
   Pos[P]:=Posi
   Do Case
      Case LastKey()=27
           Cont:=1
           SetCursor(Cur)
           Return 0
      Case LastKey()=13
           SetCursor(Cur)
           Return Posi
      Case LastKey()=1 .Or. LastKey()=18
           @ Lin+(Posi-1),Col Say Men1[Posi] Color Cor3
           Posi:=1
      Case LastKey()=6 .Or. LastKey()=3
           @ Lin+(Posi-1),Col Say Men1[Posi] Color Cor3
           Posi:=N_Op
      Case LastKey()=24
           @ Lin+(Posi-1),Col Say Men1[Posi] Color Cor3
           Posi:=Posi+1
           Posi:=If(Posi=N_Op+1,1,Posi)
      Case LastKey()=5
           @ Lin+(Posi-1),Col Say Men1[Posi] Color Cor3
           Posi:=Posi-1
           Posi:=If(Posi=0,N_Op,Posi)
        OtherWise
           Teclas()
   EndCase
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu_()
Parameters Opcoes,Posi1,Posi2
Local Numero_Pos
Cont:=0
Cont1:=0
SetCursor(0)
RestScreen(3,1,15,78,Ecra)
SetColor(Cor1)
For F=1 To 5
    @ 1,Ci[F]+1 Say M[F] Color "GR+/B"
Next
Do While Cont=0
   Do While Cont1=0
      Ecra23=SaveScreen(Li[Posi1],Cs[Posi1],Lf[Posi1]+1,Cf[Posi1]+1)
      @ 1,Ci[Posi1]+1 Say M[Posi1] Color Cor6
      Janela(Li[Posi1],Cs[Posi1],Lf[Posi1],Cf[Posi1])
      Numero_Pos:=Len(Opcoes)
      For I=1 To Numero_Pos
          @ Li[Posi1]+I,Cs[Posi1]+1 Say Opcoes[I] Color Cor3
      Next
      Posi2:=V[Posi1]
      Cont1:=1
   EndDo
   @ Li[Posi1]+Posi2,Cs[Posi1]+1 Say Opcoes[Posi2] Color Cor6
   @ 20,2 Say VM[Posi1,Posi2]+Space(15) Color "W+/B"
   Inkey(0)
   Do Case
      Case LastKey()=27
           Cont:=1
      Case LastKey()=13
           Cont:=1
      Case LastKey()=1 .Or. LastKey()=18
           @ Li[Posi1]+Posi2,Cs[Posi1]+1 Say Opcoes[Posi2] Color Cor3
           Posi2:=1
           V[Posi1]:=Posi2
      Case LastKey()=6 .Or. LastKey()=3
           @ Li[Posi1]+Posi2,Cs[Posi1]+1 Say Opcoes[Posi2] Color Cor3
           Posi2:=Numero_Pos
           V[Posi1]:=Posi2
      Case LastKey()=4
           RestScreen(Li[Posi1],Cs[Posi1],Lf[Posi1]+1,Cf[Posi1]+1,Ecra23)
           @ 1,Ci[Posi1]+1 Say M[Posi1] Color "GR+/B"
           Posi1:=Posi1+1
           Posi1:=If(Posi1=6,1,Posi1)
           Op:="V"+Str(Posi1,1)
           Vet:="V"+Str(Posi1,1)
           Opcoes:=&Op
           Cont1:=0
      Case LastKey()=19
           RestScreen(Li[Posi1],Cs[Posi1],Lf[Posi1]+1,Cf[Posi1]+1,Ecra23)
           @ 1,Ci[Posi1]+1 Say M[Posi1] Color "GR+/B"
           Posi1:=Posi1-1
           Posi1:=If(Posi1=0,5,Posi1)
           Op:="V"+Str(Posi1,1)
           Vet:="V"+Str(Posi1,1)
           Opcoes:=&Op
           Cont1:=0
      Case LastKey()=24
           @ Li[Posi1]+Posi2,Cs[Posi1]+1 Say Opcoes[Posi2] Color Cor3
           Posi2:=Posi2+1
           Posi2:=If(Posi2=Numero_Pos+1,1,Posi2)
           V[Posi1]:=Posi2
      Case LastKey()=5
           @ Li[Posi1]+Posi2,Cs[Posi1]+1 Say Opcoes[Posi2] Color Cor3
           Posi2:=Posi2-1
           Posi2:=If(Posi2=0,Numero_Pos,Posi2)
           V[Posi1]:=Posi2
      OtherWise
           Teclas()
   EndCase
EndDo
Oppri:=Posi1
OpSeg:=Posi2
Return LastKey()

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu1()
Parameters Ins_Alt
Local Lin,N_Opcao
Lin:=0
N_Opcao:=6
Pal:="Insere "
If Ins_Alt="A"
   Lin:=1
   N_Opcao:=7
   Pal:="Altera "
EndIf
Opcao1:=1
Men1:={" Entrada de documentos "," Sa¡da de documentos   "}
Men2:={Pal+"documentos de entrada"+Space(30),Pal+"documentos de sa¡da"+Space(30)}
Do While Opcao1!=0
   Opcao1:=SubMenu(N_Opcao,6+Lin,11,Men1,Men2,2,23)
   Do Case
      Case Opcao1=1
           If Ins_Alt="I"
              Ler_Doc("E")
           ElseIf Ins_Alt="A"
              If Verifica("E")!=0
                 Alterar("E")
              EndIf
           EndIf
      Case Opcao1=2
           If Ins_Alt="I"
             Ler_Doc("S")
          ElseIf Ins_Alt="A"
              If Verifica("S")!=0
                 Alterar("S")
              EndIf
           EndIf
   EndCase
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu2()
Opcao2:=1
Men1:={" O Autor          "," O Programa       "," Teclas de atalho "," Ajuda            "}
Men2:={"Apresenta o autor deste programa"+Space(20), "Apresenta o pr¢prio programa"+Space(25),"Apresenta todas as teclas de ®atalho¯ definidas no programa","Explica o funcionamento do programa (inclui todas op‡”es)"}
Do While Opcao2!=0
   Opcao2:=SubMenu(1,6,57,Men1,Men2,4,18)
   Do Case
      Case Opcao2=1
           O_Autor()
      Case Opcao2=2
           O_Programa()
      Case Opcao2=3
           Teclas_Atalho()
      Case Opcao2=4
           Escreve_Ajuda()
   EndCase
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu3()
Parameters Cons_,Cons2_
Local Lin,Col,N_Opcao
BDados:=Cons_
Lin:=0
Col:=0
EI:="E"
Pal:="documentos entrados "
Pal2:=" entrado "
Nom:="pelo remetente"
Pal3:="Consulta "
If Cons_="S"
   Pal:="documento sa¡dos "
   Pal2:=" sa¡do "
   Nom:="pelo destinat rio"
EndIf
If Cons_="S"
   Lin:=1
EndIf
If Cons2_="I"
   Col:=19
   EI:="I"
   N_Opcao:=4
   If Cons_="S"
      N_Opcao:=5
   EndIf
   Pal3:="Imprime "
ElseIf Cons2_="E"
   N_Opcao:=2
   If Cons_="S"
      N_Opcao:=3
   EndIf
EndIf
Men2:={Pal3+"todos os "+Pal+Space(15),Pal3+"um documento"+Pal2+"pelo n£mero"+Space(20),Pal3+Pal+"pela data"+Space(10),;
       Pal3+Pal+"pelo tipo (de documento)"+Space(5),Pal3+Pal+"pela referˆncia"+Space(10),Pal3+Pal+Nom+Space(10),Pal3+Pal+"pelo arquivo"+Space(10)}
Opcao3:=1
If Verifica(Cons_)=0
   Opcao3:=0
EndIf
Men1:={" Todos os documentos     "," Por n£mero de documento "," Por data de documento   ",;
       " Por tipo de documento   "," Por referˆncia          "," Por remetente           "," Por arquivo             "}
If Cons_="S"
   Men1[6]:=" Por destinat rio        "
EndIf
Do While Opcao3!=0
   Opcao3:=SubMenu(N_Opcao,6+Lin,24+Col,Men1,Men2,7,25)
   Do Case
      Case Opcao3=1
           Cons_Docs(BDados)
      Case Opcao3=2
           Cons_Num(BDados)
      Case Opcao3=3
           Cons_St(BDados,"Data","N„o foi encontrado nenhum documento com esta data","D")
      Case Opcao3=4
           Cons_St(BDados,"Tipo de documento","N„o foi encontrado nenhum documento com este tipo","T")
      Case Opcao3=5
           Cons_St(BDados,"Referˆncia","N„o foi encontrado nenhum documento com esta referˆncia","F")
      Case Opcao3=6
           If BDados="E"
              Cons_St("E","Remetente","N„o foi encontrado nenhum documento com este remetente","N")
           ElseIf BDados="S"
              Cons_St("S","Destinat rio","N„o foi encontrado nenhum documento com este destinat rio","N")
           EndIf
      Case Opcao3=7
           Cons_St(BDados,"Arquivo","N„o foi encontrado nenhum documento com este arquivo","A")
   EndCase
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu4()
Parameters Cons_
Local Col,N_Opcao
Opcao4:=1
If Verifica("T")=0
   Opcao4:=0
EndIf
Col:=0
N_Opcao:=8
Pal:="Consulta "
EI:="E"
If Cons_="I"
   EI:="I"
   Col:=19
   EI:="I"
   N_Opcao:=10
   Pal:="Imprime "
EndIf
Men1:={" Entrada de um documento "," Sa¡da de um documento   "}
Men2:={Pal+"a hist¢ria de um documento entrado"+Space(15),Pal+"a hist¢ria de um documento sa¡do"+Space(15)}
Do While Opcao4!=0
   Opcao4:=SubMenu(N_Opcao,8,24+Col,Men1,Men2,2,25)
   Do Case
      Case Opcao4=1
           If Verifica("E")!=0
              Hist("E")
           EndIf
      Case Opcao4=2
           If Verifica("S")!=0
              Hist("S")
           EndIf
   EndCase
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Formato_Data()
Cur:=SetCursor()
EcraF=SaveScreen(0,0,24,79)
Janela(9,23,12,59)
OpcaoF:=1
Do While OpcaoF!=0
   SetColor(Cor3)
   SetCursor(0)
   @ 10,24 Prompt Form_1
   @ 11,24 Prompt Form_2
   Menu To OpcaoF
   If OpcaoF!=0
      Form_Data(OpcaoF)
   EndIf
EndDo
SetCursor(Cur)
RestScreen(0,0,24,79,EcraF)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu_BDados()
OpcaoBD:=1
Men1:={" Remetentes/Destinat rios "," Tipos de documentos      "," C¢digos de entrada       "}
Men2:={"Permite gravar novos remetentes e destinat rios"+Space(10),"Permite gravar novos tipos de documentos"+Space(10),;
       "Permite gravar novos c¢digos para entrada no programa     "}
Do While OpcaoBD!=0
   OpcaoBD:=SubMenu(12,10,27,Men1,Men2,3,26)
   Do Case
      Case OpcaoBD=1
           Ins_St("Novo remet./destinat.",50,3,"Nome")
      Case OpcaoBD=2
           Ins_St("Novo tipo de documento",10,4,"Tipo_Doc")
      Case OpcaoBD=3
           If Codigo(1)=0
              Ins_St("Novo c¢digo de entrada",10,5,"Codigo")
           EndIf
   EndCase
EndDo
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Menu_Tipo()
Menu_Td:=SaveScreen(0,0,24,79)
Area:=Select()
Select 4
If Ins_Cons="C"
   Tip_:=St_A_Ler
EndIf
Colunas:={"Tipo_Doc"}
Titulos:={"Tipos docs"}
Cons1:=Cons2:=1
Consulta(10,63,72,Titulos,Colunas,1,6)
RestScreen(0,0,24,79,Menu_Td)
If LastKey()!=K_ESC
   Tip_:=TransForm(Tipo_Doc,"@!")
   If Ins_Cons="I"
      @ 5,60 Say Tip_ Color Cor2
   EndIf
EndIf
Select &Area
Return Tip_

