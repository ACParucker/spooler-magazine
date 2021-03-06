Program CopiaM;{�->  Copia N vezes o conte�do de um ficheiro para outro.  <�-}

Type Texto=^Estrutura;
     Estrutura=Record    {�->  Define a estrutura do record "estrutura".  <�-}
                 Lin:String;
                 Seg:Texto
               End;

Var Op,Fich1,Fich2:String;                 {�->  Defini��o de vari�veis.  <�-}
    Inic:Texto;
    N_Copias,E:Integer;

Procedure Sai(St:String);                {�->  Escreve ST no ecr� e sai.  <�-}
Begin
     Writeln(St+'.');
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

Procedure Carrega;                  {�->  Carrega o ficheiro em mem�ria.  <�-}
Var Fic:Text;
    Linha:String;
Begin
     Assign(Fic,Fich1);
     {$I-}
     Reset(Fic);
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro '+Fich1+' n�o foi encontrado');
     While Not Eof(Fic) Do
     Begin
          {$I-}
          Readln(Fic,Linha);
          {$I+}
          If Ioresult<>0 Then Sai('Erro de leitura do ficheiro '+Fich1);
          Inserir_Linha_Em_Memoria(Linha)
     End;
     Close(Fic)
End;

Procedure Calcula;     {�->    Efectua a(s) copia(s) do ficheiro inicial  <�-}
Var Fic:Text;          {�->  para o novo ficheiro.                    <�-}
    Linha:String;
    I:Integer;
    Ref:Texto;
Begin
     Carrega;
     Assign(Fic,Fich2);
     {$I-}
     Rewrite(Fic);
     {$I+}
     If Ioresult<>0 Then Sai('Erro de escrita no ficheiro '+Fich2);
     For I:=1 To N_Copias Do
     Begin
          Ref:=Inic;
          While Ref<>Nil Do
          Begin
               {$I-}
               Writeln(Fic,Ref^.Lin);
               {$I+}
               If Ioresult<>0 Then Sai('Erro de escrita no ficheiro '+Fich2);
               Ref:=Ref^.Seg
          End
     End;
     {$I-}
     Close(Fic);
     {$I+}
     If Ioresult<>0 Then Sai('Erro de escrita no ficheiro '+Fich2);
     If N_Copias=1 Then Sai('A copia do ficheiro '+Fich1+' foi efectuada com �xito')
     Else If N_Copias<>1 Then Sai('As copias do ficheiro '+Fich1+' foram efectuadas com �xito')
End;

Procedure Ajuda;       {�->  Apresenta um quadro de ajuda ao utilizador.  <�-}
Begin
     Writeln('Este utilit�rio tem como objectivo copiar N vezes o conte�do de um ficheiro     '+
             'de texto para outro ficheiro.                                                   ');
     Writeln('Modo de utiliza��o: CopiaM [N] <Fich1> <Fich2> [/?]                             ');
     Writeln('                    N -> Representa o n� de c�pias. O n� m�ximo de c�pias �     '+
             '                         de 100;');
     Writeln('                    Fich1 -> Ficheiro de origem;                                '+
             '                    Fich2 -> Novo ficheiro a ser  criado (com  N c�pias  de     '+
             '                             Fich1);');
     Sai('                    /? -> Apresenta este mesmo ecr� de ajuda')
End;

Begin
     Inic:=Nil;                             {�->  Inicializa INIC a NIL.  <�-}
     Writeln('CopiaM 1.0 -  (c), 1993  Ant�nio Jos� Monteiro Pereira');
     If (Paramcount=1) And (Paramstr(1)='/?') Then Ajuda;
     If Paramcount<>3 Then Sai('Modo de utiliza��o errado. CopiaM/? para poder ser ajudado');
     Op:=Paramstr(1);
     Fich1:=Paramstr(2);
     Fich2:=Paramstr(3);
     If Fich1=Fich2 Then Sai('O primeiro ficheiro n�o pode ser igual ao segundo');
     Val(Op,N_Copias,E);
     If (E<>0) Or ((N_Copias<1) Or (N_Copias>100)) Then Sai('O valor indicado n�o � v�lido');
     Calcula
End.
