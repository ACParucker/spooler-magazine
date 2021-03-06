Program TransfF;    {�->    Este utilit�rio transforma um ficheiro FONTE  <�-}
Uses Dos;           {�->  tornando-o mais apresent�vel, isto �, a 1� le-  <�-}
                    {�->  tra de cada palavra passa a ser mai�scula e as  <�-}
Const               {�->  seguintes min�sculas.                           <�-}
  Car2=[' ',',',';','=','<','>','[',']','{','}','.','.','�','�','^','~','@','(',')','_','-','+','*','''','$',':','&','#','"'];

Type Texto=^Estrutura;
     Estrutura=Record    {�->  Define a estrutura do record "estrutura".  <�-}
                     Lin:String;
                     Seg:Texto
               End;

Var Op1,Op2:String;                    {�->  Inicializa��o de vari�veis.  <�-}
    Inic:Texto;

Procedure Sai(S:String);       {�->  Escreve uma mensagem no ecr� e sai.  <�-}
Begin
     Writeln(S);
     Halt
End;

Procedure Inserir_Linha_Em_Memoria(L:String);{�->    Insere uma linha em  <�-}
Var Ref,Refanterior,Novoref:Texto;           {�->  mem�ria.               <�-}
Begin
     Ref:=Inic;
     While Ref<>Nil Do
           With Ref^ Do
           Begin
                Refanterior:=Ref;
                Ref:=Seg
           End;
     If Maxavail<Sizeof(Estrutura) Then Sai('Erro interno - Falta de mem�ria');
     New(Novoref);
     Novoref^.Lin:=L;
     Novoref^.Seg:=Ref;
     If Ref=Inic Then Inic:=Novoref
     Else Refanterior^.Seg:=Novoref
End;

Procedure Carrega;               {�->  Carrega o 1� ficheiro em mem�ria.  <�-}
Var Fic:Text;
    Linha:String;
Begin
     Assign(Fic,Op1);
     {$I-}
     Reset(Fic);
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro '+Op1+' n�o existe.');
     While Not Eof(Fic) Do
     Begin
          Readln(Fic,Linha);
          Inserir_Linha_Em_Memoria(Linha)
     End;
     Close(Fic);
End;

Procedure Grava;           {�->  Grava o 1� ficheiro transformado no 2�.  <�-}
Var Fic:Text;
    Ref:Texto;
Begin
     Assign(Fic,Op2);
     {$I-}
     Reset(Fic);
     {$I+}
     If Ioresult=0 Then
     Begin
          Close(Fic);
          Sai('O ficheiro '+Op2+' j� existe.')
     End;
     Rewrite(Fic);
     Ref:=Inic;
     While Ref<>Nil do
     Begin
          Writeln(Fic,Ref^.Lin);
          Ref:=Ref^.Seg
     End;
     Close(Fic);
End;

Procedure Calcula;             {�->  Efectua a respectiva transforma��o.  <�-}
Var Ref:Texto;
    Linha:String;
    I,J:Integer;
    Car:Char;
    Min,Mai:ARRAY[1..43] Of Char;  {�->    Arrays onde ser�o guardados os  <�-}
    Stmin,Stmai:String[43];        {�->  caract. min. e mai., respectiva/  <�-}
Begin
     Stmin:='abcdefghijklmnopqrstuvwxyz�����������������';
     Stmai:='ABCDEFGHIJKLMNOPQRSTUVWXYZ�����������������';
     For I:=1 To 43 Do
         Min[I]:=Stmin[I];   {�->    Preenche os arrays "Min" e "Mai" com  <�-}
     For I:=1 To 43 Do       {�->  os respectivos caracteres               <�-}
         Mai[I]:=Stmai[I];
     Ref:=Inic;
     While Ref<>Nil do
     Begin
          Linha:=Ref^.Lin;
          For I:=1 To Length(Linha) Do
          Begin
               If (Linha[I-1] In Car2) Or (I=1) Then
               Begin
                    For J:=1 To 43 Do
                        If (Linha[I]<>Mai[J]) And (Linha[I]=Min[J]) Then
                        Begin
                             Linha[I]:=Mai[J]; {�->    Faz a transforma��o de mai�sculas  <�-}
                             J:=43        {�->  para min�sculas                      <�-}
                        End
              End
              Else
              If I<>1 Then
              Begin
                   For J:=1 To 43 Do
                       If (Linha[I]<>Min[J]) And (Linha[I]=Mai[J]) Then
                       Begin
                            Linha[I]:=Min[J];
                            J:=43
                       End
              End
          End;
          Ref^.Lin:=Linha;
          Ref:=Ref^.Seg
     End
End;

Procedure Ajuda;       {�->  Apresenta um quadro de ajuda ao utilizador.  <�-}
Begin
     Writeln;
     Writeln('Este utilit�rio �transforma� um ficheiro FONTE de forma a torna-lo mais apresen-'+
            +'t�vel, isto �, todas as  palavras (Procedimentos, fun��es, etc.) passam a  ter a'+
            +'primeira letra em mai�scula e as seguintes em min�sculas.');
     Writeln;
     Writeln('Modo de utiliza��o ->  TransfF <Ficheiro1> <Ficheiro2> [/?]');
         Sai('                       Ficheiro1 -> Nome do ficheiro a ser transformado.        '+
            +'                       Ficheiro2 -> Nome do novo ficheiro transformado.         '+
            +'                       /? -> Apresenta este mesmo ecr� de ajuda.');
End;

Begin
     Inic:=Nil;
     Writeln('TransfF 1.0 -  (c), 1994  Ant�nio Jos� Monteiro Pereira');
     Op1:=Paramstr(1);
     Op2:=Paramstr(2);
     If (ParamCount=1) And (Op1='/?') Then Ajuda
     Else
     If Paramcount=2 Then
     Begin
          Carrega;
          Calcula;
          Grava;
          Sai('A transforma��o foi efectuada com �xito.')
     End;
     Sai('Modo de utiliza��o errado. TransfF/? para poder ser ajudado.')
End.
