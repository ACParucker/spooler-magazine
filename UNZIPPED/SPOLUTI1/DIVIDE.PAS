Program Divide;   {�->    Este utilit�rio permite dividir um determinado  <�-}
                  {�->  ficheiro de texto em partes com N linhas.         <�-}
Type Str_=String[140]; {�->  Define STR_ como sendo igual a String[140].  <�-}
     Texto=^Estrutura;
     Estrutura=Record    {�->  Define a estrutura do record "estrutura".  <�-}
                 Lin:Str_;
                 Seg:Texto
               End;

Var Op,Fich,F:Str_;                        {�->  Defini��o de vari�veis.  <�-}
    Inic:Texto;
    N_Linhas,E:Integer;

Procedure Sai(St:Str_);                  {�->  Escreve ST no ecr� e sai.  <�-}
Begin
     Writeln(St+'.');
     Halt
End;

Procedure Inserir_Linha_Em_Memoria(L:Str_);  {�->    Insere uma linha em  <�-}
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
    Linha:Str_;
Begin
     Assign(Fic,Fich);
     {$I-}
     Reset(Fic);
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro '+Fich+' n�o foi encontrado');
     While Not Eof(Fic) Do
     Begin
          {$I-}
          Readln(Fic,Linha);
          {$I+}
          If Ioresult<>0 Then Sai('Erro de leitura do ficheiro '+Fich);
          Inserir_Linha_Em_Memoria(Linha)
     End;
     Close(Fic)
End;

Procedure Nome_Ficheiro(St:Str_);      {�->    Retira a extens�o ao nome  <�-}
Var I:Integer;                         {�->  do ficheiro.                 <�-}
Begin
     F:='';
     For I:=1 To Length(St) Do
         If St[I]<>'.' Then F:=F+St[I]
         Else I:=Length(St)
End;

Function Inc_Fich(N:Integer):Str_;{�->    Acrescenta a extens�o adequada  <�-}
Var St:Str_;                      {�->  ao nome do ficheiro e, devolve o  <�-}
Begin                             {�->  nome+'.'+extens�o.                <�-}
     Str(N,St);
     Case Length(St) Of
          1:Inc_Fich:=F+'.00'+St;
          2:Inc_Fich:=F+'.0'+St;
          3:Inc_Fich:=F+'.'+St
     End
End;

Procedure Avanca_Na_Lista(N:Integer);  {�->  Avan�a N registos na lista.  <�-}
Var I:Integer;
    Ref:Texto;
Begin
     For I:=1 To N Do
         Ref:=Ref^.Seg
End;

Procedure Calcula;                  {�->  Efectua a divis�o do ficheiro.  <�-}
Var Fic:Text;
    Linha:Str_;
    I,N_Fich,Avanca:Integer;
    Ref:Texto;
Begin
     Carrega;
     N_Fich:=0;
     Avanca:=0;
     Ref:=Inic;
     Nome_Ficheiro(Fich);
     Writeln;
     Repeat
           Writeln('-> ',Inc_Fich(N_Fich));
           Assign(Fic,Inc_Fich(N_Fich));
           {$I-}
           Rewrite(Fic);
           {$I+}
           If Ioresult<>0 Then Sai('Erro de escrita no ficheiro '+Inc_Fich(N_Fich));
           I:=1;
           While (Ref<>Nil) And (I<=N_Linhas) Do
           Begin
                If (Avanca<>0) And (I=0) Then Avanca_Na_Lista(Avanca);
                Inc(Avanca);
                {$I-}
                Writeln(Fic,Ref^.Lin);
                {$I+}
                If Ioresult<>0 Then Sai('Erro de escrita no ficheiro '+Inc_Fich(N_Fich));
                Ref:=Ref^.Seg;
                Inc(I)
           End;
           Close(Fic);
           Inc(N_Fich);
           If N_Fich=1000 Then
           Begin
                Writeln;
                Sai('Divis�o interrompida. J� foram criados 1000 novos ficheiros.                    '+
                    'N�o � permitida a cria��o de mais ficheiros')
           End
     Until Ref=Nil
End;

Procedure Ajuda;       {�->  Apresenta um quadro de ajuda ao utilizador.  <�-}
Begin
     Writeln('Este utilit�rio permite dividir um determinado ficheiro de texto em partes      '+
             'com N linhas. Sendo criado, portanto, uma s�rie de ficheiros com o nome i-');
     Writeln('gual ao ficheiro inicial mas com extens�o diferente (000,001,002,003,... e      '+
             'assim sucessivamente). O n� m�ximo de ficheiros a criar � de 1000.              ');
     Writeln('Modo de utiliza��o: Divide N <Ficheiro> [/?]');
     Writeln;
     Writeln('                    N -> N� de linhas para cada ficheiro;');
     Writeln('                    Ficheiro -> Nome do ficheiro a �cortar�;');
     Sai('                    /? -> Apresenta este mesmo ecr� de ajuda')
End;

Begin
     Inic:=Nil;                            {�->  Inicializa INIC a NIL.  <�-}
     Writeln('Divide 1.0 -  (c), 1993  Ant�nio Jos� Monteiro Pereira');
     If (Paramcount=1) And (Paramstr(1)='/?') Then Ajuda;
     If Paramcount<>2 Then Sai('Modo de utiliza��o errado. Divide/? para poder ser ajudado');
     Op:=Paramstr(1);
     Fich:=Paramstr(2);
     Val(Op,N_Linhas,E);
     If (E<>0) Or ((N_Linhas<1) Or (N_Linhas>32767)) Then Sai('O valor indicado n�o � v�lido');
     Calcula
End.
