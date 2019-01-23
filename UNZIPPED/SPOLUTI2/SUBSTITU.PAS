Program Substitui;    {Ä->    Este utilit rio visa a substitui‡„o de uma  <Ä-}
Var Op1,Op2,Op3:String;  {Ä->  palavra por outra num ficheiro de texto.   <Ä-}

Procedure Sai(St:String);     {Ä->  Escreve St no ecran e sai do programa.  <Ä-}
Begin
     Writeln(St+'.');
     Halt
End;

Procedure Calcular;     {Ä->    Efectua a substitui‡„o das duas palavras  <Ä-}
Var Fic,Fic2:Text;      {Ä->  dadas no respectivo ficheiro.               <Ä-}
    P,T,I,J,S,L:Integer;
    Linha,Linha2,Pal,St:String;
Begin
     Assign(Fic,Op1);
     {$I-}
     Reset(Fic);           {Ä->  Verifica a existˆncia do ficheiro.  <Ä-}
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro '+'"'+Op1+'"'+' n„o existe');
     Assign(Fic2,'Substitu.'+#255);
     Rewrite(Fic2);
     T:=Length(Op2);
     L:=0;
     P:=0;
     While Not Eof(Fic) Do
     Begin
          Inc(L);
          Readln(Fic,Linha);
          Linha2:=Linha;
          For I:=1 To Length(Linha2) Do
          Begin
               Pal:='';
               S:=0;
               If I+T-1<=Length(Linha2) Then
               Begin
                    For J:=I To I+T-1 Do
                        Pal:=Pal+Linha2[J];
                    For J:=1 To Length(Pal) Do
                        If Not ((Pal[J]=Op2[J]) Or (Upcase(Pal[J])=Upcase(Op2[J]))) Then S:=1;
                    If S=0 Then
                    Begin
                         St:='';
                         For J:=I+T To Length(Linha2) Do
                             St:=St+Linha2[J];
                         Pal:='';
                         For J:=1 To I-1 Do
                             Pal:=Pal+Linha2[J];
                         Linha2:=Pal+Op3+St;
                         Inc(P);
                         Writeln('Palavra encontrada e substitu¡da na linha n§',L)
                    End
               End
               Else I:=Length(Linha);
          End;
          Writeln(Fic2,Linha2)
     End;
     Close(Fic);
     Close(Fic2);
     If P<>0 Then
     Begin
          Assign(Fic,Op1);
          {$I-}
          Erase(Fic);
          {$I+}
          If Ioresult<>0 Then Sai('Erro ao substituir o ficheiro "'+Op1+'".');
          Assign(Fic,'Substitu.'+#255);
          Rename(Fic,Op1)
     End
     Else Sai('N„o h  nenhuma palavra igual a: "'+Op2+'" no ficheiro "'+Op1+'"');
     If P=1 Then Sai('Existe uma palavra igual a: "'+Op2+'" no ficheiro "'+Op1+'"')
     Else
     Begin
          Writeln('Foram substitu¡das ',P,' palavras no ficheiro ',Op1,'.');
          Halt
     End
End;

Procedure Ajuda;       {Ä->  Apresenta um quadro de ajuda ao utilizador.  <Ä-}
Begin
     Writeln('Este utilit rio permite substituir uma palavra por outra, num ficheiro de texto.');
     Writeln('Modo de utiliza‡„o:  Substitu <Ficheiro> <Palavra1> <Palavra2> [/?]             ');
     Writeln('                     Ficheiro -> Nome do ficheiro;                              '+
             '                     Palavra1 -> Palavra a ser substituida;                     '+
             '                     Palavra2 -> Nova palavra que substituir  a outra;');
     Sai('                     /? -> Apresenta este mesmo ecr„ de ajuda');
End;

Begin
     Writeln('Substitui 1.0 - (c), 1993 Ant¢nio Jos‚ Monteiro Pereira');
     Op1:=Paramstr(1);
     Op2:=Paramstr(2);
     Op3:=Paramstr(3);
     If (Paramcount=1) And (Op1='/?') Then Ajuda;
     If Paramcount=3 then Calcular;
     Sai('Modo de utiliza‡„o errado. substitu/? para poder ser ajudado')
End.
