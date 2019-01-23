#Include "Box.Ch"
#Include "Inkey.Ch"

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Codigo(Cod)
Local I,Cond
If Cod=0
   Clear Screen
EndIf
Ecra_C:=SaveScreen(9,25,14,55)
Janela(9,25,13,54)
Faz_Som()
I:=1
Select 5
Set Confirm On
Set Exact On
SetCursor(1)
Cond:=1
Do While I<=3 .And. LastKey()!=K_ESC
   Cd0:=Cd1:=Cd2:=Cd3:=Cd4:=Cd5:=Cd6:=Cd7:=Cd8:=Cd9:=" "
   @ 11,31 Say "C¢digo: "+Space(10) Color Cor3
   SetColor(Cor6)
   @ 11,39 Say Space(10)
   @ 11,39 Say ""
   For J=1 To 10
       Cd:="Cd"+Str(J-1,1)
       Set Console Off
       If J=9
          @ 11,48 Say " "
       EndIf
       If Cond=1
          @ 11,39+J-1 Say ""
          Wait To &Cd
       ElseIf Cond=0
          Cond:=1
          Do While Cond=1
             @ 11,39+J-1 Say ""
             Wait To Cod2
             If LastKey()=K_ENTER .Or. LastKey()=K_ESC .Or. LastKey()=8
                Cond:=0
             EndIf
          EndDo
          If LastKey()=8
             Cd:=" "
          EndIf
          Cond:=1
       EndIf
       Set Console On
       If J=1 .And. LastKey()=8
          Cd:=" "
          @ 11,39+J-1 Say " "
          @ 11,39+J-1 Say ""
          J:=J-1
       ElseIf LastKey()=8
          Cd9:=Cd:=" "
          @ 11,39+J-2 Say " "
          @ 11,39+J-2 Say ""
          J:=J-2
       ElseIf J=10 .And. LastKey()!=K_ENTER .And. LastKey()!=K_ESC
          @ 11,39+J-1 Say "*"
          Cond:=0
          @ 11,39+J-1 Say ""
       ElseIf LastKey()!=K_ESC .And. LastKey()!=K_ENTER .And. LastKey()!=8
          @ 11,39+J-1 Say "*"
       ElseIf LastKey()=K_ENTER .Or. LastKey()=K_ESC
          J:=10
       EndIf
       If Cond=0
          J:=J-1
       EndIf
   Next
   Codigo1:=Cd0+Cd1+Cd2+Cd3+Cd4+Cd5+Cd6+Cd7+Cd8+Cd9
   If Len(AllTrim(Codigo1))!=10
      Codigo1:=SubStr(Codigo1,1,Len(AllTrim(Codigo1))-1)
   EndIf
   If Codigo1=Space(10)
      I:=I-1
   Else
      Go Top
      Do While !Eof()
         If AllTrim(Codigo1)=Desencripta(TransForm(Codigo,"@!"))
            I:=10
            Go Bottom
         EndIf
         Skip
      EndDo
   EndIf
   I:=I+1
EndDo
Set Exact Off
Set Confirm Off
Do Case
   Case Cod=0
        If I=4 .Or. LastKey()=K_ESC
           SetColor("W/N")
           Clear Screen
           Clear All
           Quit
        EndIf
   Case Cod=1
        If I=4 .Or. LastKey()=K_ESC
           RestScreen(9,25,14,55,Ecra_C)
           Return 1
        Endif
EndCase
RestScreen(9,25,14,55,Ecra_C)
SetColor(Cor1)
Return 0

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Janela
Parameters L1,C1,L2,C2
DispBox(L1+1,C1+1,L2+1,C2+1,"±",Cor7)
SetColor(Cor3)
@ L1,C1 Clear To L2,C2
@ L1,C1,L2,C2 BOX B_DOUBLE_SINGLE Color "B/BG+"
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Mensagem(Mens,Op)
Local Ant,N,Col1,Col2
Cur:=SetCursor()
N=Len(Mens)
Col1:=((80-N)/2)-2
Col2:=((80+N)/2)+1
Ant=SaveScreen(8,Col1,15,Col2+1)
Janela(8,Col1,14,Col2)
SetCursor(0)
@ 10,((80-n)/2)-1 Say " "+Mens+" " Color Cor5
Tec:=1
Escolhe:=1
If Op=0
   Enter(12,1)
ElseIf Op=2
   @ 12,26 Say " Abortar " Color Cor4
   @ 12,36 Say " Repetir   Gravar " Color Cor3
   Faz_Som()
   Do While Escolhe=1
      Inkey(0)
      Do Case
         Case LastKey()=K_LEFT
              Tec:=Tec-1
              If Tec=0
                 Tec:=3
              EndIf
         Case LastKey()=K_RIGHT
              Tec:=Tec+1
              If Tec=4
                 Tec:=1
              EndIf
         Case LastKey()=K_ENTER
              Escolhe:=0
      EndCase
      @ 12,26 Say " Abortar   Repetir   Gravar " Color Cor3
      Do Case
         Case Tec=1
              @ 12,26 Say " Abortar " Color Cor4
         Case Tec=2
              @ 12,36 Say " Repetir " Color Cor4
         Case Tec=3
              @ 12,46 Say " Gravar " Color Cor4
      EndCase
   EndDo
ElseIf Op=3
   @ 12,33 Say " Sim " Color Cor4
   @ 12,41 Say " N„o " Color Cor3
   Faz_Som()
   Do While Escolhe=1
      Inkey(0)
      Do Case
         Case LastKey()=K_LEFT
              If Tec=1
                 Tec:=2
              Else
                 Tec:=1
              EndIf
         Case LastKey()=K_RIGHT
              If Tec=1
                 Tec:=2
              Else
                 Tec:=1
              EndIf
         Case LastKey()=K_ENTER
              Escolhe:=0
      EndCase
      @ 12,33 Say " Sim     N„o " Color Cor3
      Do Case
         Case Tec=1
              @ 12,33 Say " Sim " Color Cor4
         Case Tec=2
              @ 12,41 Say " N„o " Color Cor4
      EndCase
   EndDo
EndIf
SetCursor(Cur)
RestScreen(8,Col1,15,Col2+1,Ant)
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Faz_Som()
If Som_Ligado=1
   Tone(415,0)
EndIf
Return

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Encripta(St)
Local St1
St1:=""
For I=1 To Len(AllTrim(St))
    St1:=St1+Chr(Asc(SubStr(TransForm(St,"@!"),I,1))+I)
Next
Return St1

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Desencripta(St)
Local St1
St1:=""
For I=1 To Len(AllTrim(St))
    St1:=St1+Chr(Asc(SubStr(St,I,1))-I)
Next
Return St1

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Function Numero(N1,N2)
Num:=""
For I=1 To N1-Len(AllTrim(Str(N2)))
    Num:=Num+"0"
Next
Return Num

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

Procedure Consulta
Parameters L1,C1,C2,Tit,Campo,N_Campos,N_Linhas
Local Tam
Private Campos[10]
Cor:=SetColor()
Cur:=SetCursor()
SetCursor(0)
Count To NRecs
If N_Linhas>NRecs
   N_Linhas:=NRecs
EndIf
DispBox(L1-2,C1,L1+N_Linhas+1,C2+2,"±",Cor7)
SetColor("B/BG+")
@ L1-3,C1-1 Clear To L1+N_Linhas,C2+1
@ L1-3,C1-1,L1+N_Linhas,C2+1 BOX B_DOUBLE_SINGLE
C:=C1
L:=L1
@ L1-1,C1 To L1-1,C2
@ L1-1,C1-1 Say "Ã"
@ L1-1,C2+1 Say "´"
For I=1 To N_Campos
    If I!=1
       C:=C+Len(Tit[I-1])+1
       @ L-1,C-1 Say "Å"
       @ L-2,C-1 Say "³"
       @ L-3,C-1 Say "Ñ"
       @ L1+N_Linhas,C-1 Say "Ï"
    EndIf
    @ L-2,C-1 Say "³"
    @ L-2,C Say Tit[I] Color "W+/RB+"
Next
Faz_Som()
L:=L1
C:=C1
Cond:=0
If RecNo()!=1
   Cond:=1
EndIf
Go Top
If Cons1!=1 .Or. Cond=1
   Ant:=Cons2
   If Ant!=1
      For I=1 To Cons1-1
          Ant:=Ant-1
      Next
   EndIf
   Go Ant
   Ant:=Cons2
EndIf
For J=1 To N_Linhas
    For I=1 To N_Campos
        Posicao:=FieldGet(FieldPos(Campo[I]))
        If ValType(Posicao)="D"
           Campos[I]:=TransForm(Posicao,"D")
        ElseIf ValType(Posicao)="N"
           Campos[I]:=Str(Posicao)
        Else
           Campos[I]:=Posicao
        EndIf
    Next
    Tam:=C1
    For I=1 To N_Campos
        Tam:=Tam+Len(Campos[I])
        If I!=1
           C:=C+Len(Campos[I-1])+1
        EndIf
        @ L,C-1 Say "³"
        @ L,C Say Campos[I] Color "GR+/BG+"
    Next
    Skip
    L:=L+1
    C:=C1
Next
If N_Campos=1
   Tam:=Tam-1
EndIf
Count To NRecs
Recs:=AllTrim(Str(NRecs))
@ L1+N_Linhas,(C2-3)-Len(Recs) Say "/"+Recs+" "
Go Top
L:=L1
If Cons1!=1 .Or. Cond=1
   Go Ant
   L:=L1+(Cons1-1)
EndIf
Do While !Eof()
   C:=C1
   For I=1 To N_Campos
       Posicao:=FieldGet(FieldPos(Campo[I]))
       If ValType(Posicao)="D"
          Campos[I]:=TransForm(Posicao,"D")
       ElseIf ValType(Posicao)="N"
          Campos[I]:=Str(Posicao)
       Else
          Campos[I]:=Posicao
       EndIf
   Next
   For I=1 To N_Campos
       If I!=1
          C:=C+Len(Campos[I-1])+1
       EndIf
       @ L,C-1 Say "³"
       @ L,C Say Campos[I] Color "W+/RB+"
   Next
   Tecla:=0
   @ L1+N_Linhas,(C2-3)-(Len(Recs)+(Len(Str(RecNo(),Len(Recs))))+1) Say " "+Numero(Len(Recs),RecNo())+AllTrim(Str(RecNo(),Len(AllTrim(Str(RecNo())))))
   Do While Tecla=0
      Inkey(0)
      If NRecs=1
         If LastKey()=K_ENTER .Or. LastKey()=K_ESC
            Tecla:=1
         EndIf
      ElseIf RecNo()=1 .And. RecNo()!=NRecs
         If LastKey()=K_ENTER .Or. LastKey()=K_ESC .Or. LastKey()=K_DOWN .Or. LastKey()=K_PGDN .Or. LastKey()=K_END .Or. LastKey()=K_CTRL_PGDN .Or. LastKey()=K_CTRL_END
            Tecla:=1
         EndIf
      ElseIf RecNo()=NRecs .And. RecNo()!=1
         If LastKey()=K_ENTER .Or. LastKey()=K_ESC .Or. LastKey()=K_UP .Or. LastKey()=K_PGUP .Or. LastKey()=K_HOME .Or. LastKey()=K_CTRL_PGUP .Or. LastKey()=K_CTRL_HOME
            Tecla:=1
         EndIf
      Else
         If LastKey()=K_ENTER .Or. LastKey()=K_ESC .Or. LastKey()=K_DOWN .Or. LastKey()=K_UP .Or. LastKey()=K_PGUP .Or. LastKey()=K_PGDN .Or. LastKey()=K_HOME .Or. LastKey()=K_END .Or. LastKey()=K_CTRL_PGUP .Or. LastKey()=K_CTRL_PGDN .Or. LastKey()=K_CTRL_HOME .Or. LastKey()=K_CTRL_END
            Tecla:=1
         EndIf
      EndIf
   EndDo
   C:=C1
   For I=1 To N_Campos
       If I!=1
          C:=C+Len(Campos[I-1])+1
       EndIf
       @ L,C-1 Say "³"
       @ L,C Say Campos[I] Color "GR+/BG+"
   Next
   Do Case
      Case LastKey()=K_ENTER
           SetColor(Cor)
           SetCursor(Cur)
           Cons1:=L-(L1-1)
           Cons2:=RecNo()
           Return 1
      Case LastKey()=K_ESC
           SetColor(Cor)
           SetCursor(Cur)
           Cons1:=L-(L1-1)
           Cons2:=RecNo()
           Return 0
      Case LastKey()=K_DOWN
           L:=L+1
           Skip
      Case LastKey()=K_UP
           L:=L-1
           Skip-1
      Case LastKey()=K_PGDN
           If NRecs-RecNo()<N_Linhas     //  Era <=
              Go NRecs-N_Linhas+1
           EndIf
           L:=L1
           For J=1 To N_Linhas
               For I=1 To N_Campos
                   Posicao:=FieldGet(FieldPos(Campo[I]))
                   If ValType(Posicao)="D"
                      Campos[I]:=TransForm(Posicao,"D")
                   ElseIf ValType(Posicao)="N"
                      Campos[I]:=Str(Posicao)
                   Else
                      Campos[I]:=Posicao
                   EndIf
               Next
               C:=C1
               For I=1 To N_Campos
                   If I!=1
                      C:=C+Len(Campos[I-1])+1
                   EndIf
                   @ L,C Say Campos[I] Color "GR+/BG+"
               Next
               Skip
               L:=L+1
               C:=C1
           Next
           L:=L+N_Linhas
           If L>=L1+N_Linhas
              L:=L1+N_Linhas-1
           EndIf
           Skip -1
      Case LastKey()=K_PGUP
           Rec:=RecNo()
           If Rec<=N_Linhas
              Go 1
           Else
              Go Rec-(N_Linhas-1)
           EndIf
           L:=L1
           For J=1 To N_Linhas
               For I=1 To N_Campos
                   Posicao:=FieldGet(FieldPos(Campo[I]))
                   If ValType(Posicao)="D"
                      Campos[I]:=TransForm(Posicao,"D")
                   ElseIf ValType(Posicao)="N"
                      Campos[I]:=Str(Posicao)
                   Else
                      Campos[I]:=Posicao
                   EndIf
               Next
               C:=C1
               For I=1 To N_Campos
                   If I!=1
                      C:=C+Len(Campos[I-1])+1
                   EndIf
                   @ L,C Say Campos[I] Color "GR+/BG+"
               Next
               Skip
               L:=L+1
               C:=C1
           Next
           L:=L1
           If Rec<=N_Linhas
              Go 1
           Else
              Go Rec-(N_Linhas-1)
           EndIf
      Case LastKey()=K_HOME .Or. LastKey()=K_CTRL_HOME .Or. LastKey()=K_CTRL_PGUP
           L:=L1
           Go Top
           For J=1 To N_Linhas
               For I=1 To N_Campos
                   Posicao:=FieldGet(FieldPos(Campo[I]))
                   If ValType(Posicao)="D"
                      Campos[I]:=TransForm(Posicao,"D")
                   ElseIf ValType(Posicao)="N"
                      Campos[I]:=Str(Posicao)
                   Else
                      Campos[I]:=Posicao
                   EndIf
               Next
               C:=C1
               For I=1 To N_Campos
                   If I!=1
                      C:=C+Len(Campos[I-1])+1
                   EndIf
                   @ L,C Say Campos[I] Color "GR+/BG+"
               Next
               Skip
               L:=L+1
               C:=C1
           Next
           L:=L1
           Go Top
      Case LastKey()=K_END .Or. LastKey()=K_CTRL_END .Or. LastKey()=K_CTRL_PGDN
           L:=L1
           Go NRecs-N_Linhas+1
           For J=1 To N_Linhas
               For I=1 To N_Campos
                   Posicao:=FieldGet(FieldPos(Campo[I]))
                   If ValType(Posicao)="D"
                      Campos[I]:=TransForm(Posicao,"D")
                   ElseIf ValType(Posicao)="N"
                      Campos[I]:=Str(Posicao)
                   Else
                      Campos[I]:=Posicao
                   EndIf
               Next
               C:=C1
               For I=1 To N_Campos
                   If I!=1
                      C:=C+Len(Campos[I-1])+1
                   EndIf
                   @ L,C Say Campos[I] Color "GR+/BG+"
               Next
               Skip
               L:=L+1
               C:=C1
           Next
           L:=L1+N_Linhas-1
           Go Bottom
   EndCase
   If L=L1+N_Linhas
      Scroll(L1,C1,L1+N_Linhas-1,Tam,1)
      L:=L1+N_Linhas-1
   ElseIf L=L1-1
      Scroll(L1,C1,L1+N_Linhas-1,Tam,-1)
      L:=L1
   EndIf
EndDo
Return

