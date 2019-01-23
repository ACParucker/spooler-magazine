Program PProcura;          {Ä->    Este utilit rio visa a procura de uma  <Ä-}
Var Op1,Op2:String;        {Ä->  palavra num determinado ficheiro.        <Ä-}

Procedure Sai(St:String);    {Ä->  Escreve St no ecr„ e sai do programa.  <Ä-}
Begin
     Writeln(St+'.');
     Halt
End;

Procedure Calcular;         {Ä->    Efectua a procura da palavra dada no  <Ä-}
Var Fic:Text;               {Ä->  ficheiro dado.                          <Ä-}
    P,T,I,J,S,L:Integer;
    Linha,Pal:String;
Begin
     Assign(Fic,Op1);
     {$I-}
     Reset(Fic);           {Ä->  Verifica a existˆncia do ficheiro.  <Ä-}
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro '+'"'+Op1+'"'+' n„o existe');
     T:=Length(Op2);
     L:=0;
     P:=0;
     While Not Eof(Fic) Do
     Begin
          Inc(L);
          Readln(Fic,Linha);
          For I:=1 To Length(Linha) Do
          Begin
               Pal:='';
               S:=0;
               If I+T-1<=Length(Linha) Then
               Begin
                    For J:=I To I+T-1 Do
                        Pal:=Pal+Linha[J];
                    For J:=1 To Length(Pal) Do
                        If Not ((Pal[J]=Op2[J]) Or (Upcase(Pal[J])=Upcase(Op2[J]))) Then S:=1;
                    If S=0 Then
                    Begin
                         Inc(P);
                         Writeln('Palavra encontrada na linha n§',L)
                    End
               End
               Else I:=Length(Linha)
          End
     End;
     Close(Fic);
     If P=0 Then Sai('N„o h  nenhuma palavra igual a: "'+Op2+'" no ficheiro "'+Op1+'"')
     Else If P=1 Then Sai('Existe uma palavra igual a: "'+Op2+'" no ficheiro "'+Op1+'"')
     Else
     Begin
          Writeln('Existem ',P,' palavras iguais a: "'+Op2+'" no ficheiro "'+Op1+'".');
          Halt
     End
End;

Procedure Ajuda;       {Ä->  Apresenta um quadro de ajuda ao utilizador.  <Ä-}
Begin
     Writeln('Este utilit rio permite procurar uma  determinada palavra num ficheiro. O utili-'+
             'zador poder  verificar se essa palavra existe ou n„o. Caso existe,ficar  a saber'+
             'em que linha(s) ela se encontra e o n£mero de vezes que ela aparece no ficheiro.');
     Writeln('Modo de utiliza‡„o:  PProcura <Ficheiro> <Palavra> [/?]                          ');
     Writeln('                     Ficheiro -> Nome do ficheiro;                              '+
             '                     Palavra  -> Palavra a ser procurada;');
     Sai('                     /? -> Apresenta este mesmo ecr„ de ajuda')
End;

Begin
     Writeln('PProcura 1.0 - (c), 1993 Ant¢nio Jos‚ Monteiro Pereira');
     Op1:=Paramstr(1);
     Op2:=Paramstr(2);
     If (Paramcount=1) And (Op1='/?') Then Ajuda;
     If Paramcount=2 then Calcular;
     Sai('Modo de utiliza‡„o errado. PProcura/? para poder ser ajudado')
End.
