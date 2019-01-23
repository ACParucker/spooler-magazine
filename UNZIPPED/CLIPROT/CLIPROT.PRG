#include "Inkey.Ch"

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴 //

Function Anos(dData1,dData2)
Local nDia1:=Day(dData1),nMes1:=Month(dData1),nAno1:=Year(dData1)-1
Local nDia2:=Day(dData2),nMes2:=Month(dData2),nAno2:=Year(dData2)
Local nAnos:=0
Do While nAno2<=nAno1
   If nAno2<nAno1
      nAnos++
   ElseIf nAno2==nAno1
      If nMes2<nMes1
         nAnos++
      ElseIf nMes2==nMes1
         If nDia2<=nDia1
            nAnos++
         EndIf
      EndIf
   EndIf
   nAno2++
EndDo
Return nAnos

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴 //

Function Ultimo_Dia(nMes,nAno)
Local nDia:=0
Local aMeses30:={4,6,9,11}
Local aMeses31:={1,3,5,7,8,10,12}
If AScan(aMeses31,nMes)!=0
   nDia:=31
ElseIf AScan(aMeses30,nMes)!=0
   nDia:=30
ElseIf nMes==2
   If((nAno%4==0 .And. nAno%100!=0) .Or. (nAno%400==0),nDia:=29,nDia:=28)
EndIf
Return nDia

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴 //

Function Editar(mTexto,nL1,nC1,nL2,nC2,lVal,nCols,nTab,Cor_1,Cor_2,Cor_3,Cor_4)
Local Cor:=SetColor(),Cur:=SetCursor()
Local nLin:=1,nCol:=0
MemVar nLinha,nColuna,Cores_1,Cores_2
Private nLinha:=nL2+1, nColuna:=nC1+7, Cores_1:=Cor_3, Cores_2:=Cor_4
@ nL1-1,nC1-1 To nL2+1,nC2+1 Color Cor_2
@ nL2+1,nC1+2 Say "Lin:       Col:      " Color Cor_2
@ nL1-1,nC1+2 Say "F2 Gravar" Color Cor_2
SetColor(Cor_1)
SetCursor(1)
mTexto:=MemoEdit(mTexto,nL1,nC1,nL2,nC2,lVal,"Linhas_Colunas",nCols,nTab,nLin,nCol)
SetColor(Cor)
SetCursor(Cur)
Return

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴 //

Function Linhas_Colunas()
Parameters nMode,nValor1,nValor2
Local nCursor:=SetCursor(), nValor:=0
SetCursor(0)
If LastKey()==K_INS
   If nCursor==1
      @ M->nLinha,M->nColuna+16 Say "I" Color M->Cores_1
      SetCursor(2)
   ElseIf nCursor==2
      @ M->nLinha,M->nColuna+16 Say " " Color M->Cores_1
      SetCursor(1)
   EndIf
   Return
ElseIf LastKey()==K_F2
   nValor:=K_CTRL_W
EndIf
cEsp1:=6-Len(AllTrim(TransForm(nValor1,"@!")))
cEsp2:=3-Len(AllTrim(TransForm(nValor2,"@!")))
cSt1:=AllTrim(TransForm(nValor1,"@!"))+Space(cEsp1)
cSt2:=AllTrim(TransForm(nValor2+1,"@!"))+Space(cEsp2)
@ M->nLinha,M->nColuna Say cSt1 Color M->Cores_2
@ M->nLinha,M->nColuna+11 Say cSt2 Color M->Cores_2
SetCursor(nCursor)
Return nValor

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴 //

Function DataExt(dData)
Local aDia:={"Domingo, ","Segunda-Feira, ","Ter놹-Feira, ","Quarta-Feira, ",;
             "Quinta-Feira, ","Sexta-Feira, ","S쟟ado, "}
Local aMes:={" de Janeiro de "," de Fevereiro de "," de Mar뇇 de ",;
             " de Abril de "," de Maio de "," de Junho de "," de Julho de ",;
             " de Agosto de "," de Setembro de "," de Outubro de ",;
             " de Novembro de "," de Dezembro de "}
Local nDia:=Day(dData),nMes:=Month(dData),nAno:=Year(dData)
Return aDia[Dow(dData)]+AllTrim(Str(nDia,2))+aMes[nMes]+Str(nAno,4)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴 //

Function Fraccao(nValor)
Local cSinal:=If(SubStr(AllTrim(Str(nValor)),1,1)=="-","-","")
Local cSt:=If(cSinal=="-",SubStr(AllTrim(Str(nValor)),2),AllTrim(Str(nValor)))
Local nPos:=At(".",cSt)
Local nInt:=If(nPos!=0,Val(SubStr(cSt,1,nPos-1)),Val(cSt))
Local nDec:=If(nPos!=0,Val(SubStr(cSt,nPos+1,Len(cSt)-nPos)),0)
Local nTamDec:=Len(AllTrim(Str(nDec)))
Local lContinua:=.T.,nVal:=0,nNum:=0,nDen:=0,nVal2
Local cRes
If(nValor==Round(nValor,0),nTamDec:=0,)
Do While lContinua==.T.
   If nTamDec==1
      nVal+=10
      nVal2:=10
   ElseIf nTamDec==2
      nVal+=100
      nVal2:=100
   ElseIf nTamDec==3
      nVal+=1000
      nVal2:=1000
   ElseIf nTamDec==4
      nVal+=10000
      nVal2:=10000
   EndIf
   If nTamDec==0
      lContinua:=.F.
   ElseIf (nVal/nDec)%1==0
      nDen:=nVal/nDec
      nNum:=nDen*nInt
      nNum+=nDec/(nVal2/nDen)
      lContinua:=.F.
   EndIf
EndDo
If nTamDec==0
   cRes:=AllTrim(Str(nValor))+"/1"
Else
   cRes:=cSinal+AllTrim(Str(Round(nNum,0)))+"/"+AllTrim(Str(Round(nDen,0)))
EndIf
Return cRes

