Program Conta;    {�->    Este utilit�rio conta o n� de palavras, linhas  <�-}
Uses Dos;         {�->  ou caracteres de um ficheiro de texto.            <�-}

Const Pont:Array[1..7] Of Char=(' ','.',',',';','!','?',Chr(13));

Var R:Registers;                           {�->  Defini��o de vari�veis.  <�-}
    St,Fich:String;

Procedure Sai(St:String);                {�->  Escreve ST no ecr� e sai.  <�-}
Begin
     Writeln(St);
     R.Ah:=01;                                      {�->  Liga o cursor.  <�-}
     R.Ch:=3;
     R.Cl:=4;
     Intr($10,R);
     Halt
End;

Procedure Vai(C,L:Integer);      {�->  Coloca-se na coluna C da linha L.  <�-}
Begin
     R.Ah:=02;
     R.Dh:=L-1;
     R.Dl:=C-1;
     R.Bh:=0;
     Intr($10,R)
End;

Function Linha:Byte;    {�->    Devolve o n� da linha em que se encontra  <�-}
Begin                   {�->  o cursor.                                   <�-}
     R.Ah:=03;
     R.Bh:=0;
     Intr($10,R);
     Linha:=R.Dh+1
End;

Procedure Palavras;   {�->  Calcula o n� de palavras que o ficheiro tem.  <�-}
Var Fic:Text;
    Texto:String;
    Num,L,I,J:Integer;
Begin
     Num:=0;                  {�->  Inicializa o n� de palavras inicial.  <�-}
     Assign(Fic,Fich);
     {$I-}
     Reset(Fic);    {�->  Verifica a exist�ncia do ficheiro Fich.  <�-}
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro "'+Fich+'" n�o foi encontrado.');
     If Eof(Fic) Then Sai('O ficheiro "'+Fich+'" n�o tem nenhuma palavra.');
     L:=Linha;
     Repeat
           Readln(Fic,Texto);            {�->  L� uma linha do ficheiro.  <�-}
           For I:=1 To Length(Texto) Do
               For J:=1 To 7 Do
                   If (Texto[I]=Pont[J]) And (Texto[I+1]<>Pont[J]) Then
                   Begin
                        Num:=Num+1;
                        Vai(1,L);
                        Write(Fich,' (',Num,')')
                   End
     Until Eof(Fic);
     Close(Fic);
     Vai(1,L);
     Write('O ficheiro "',Fich,'" tem ',Num,' palavra(s).');
     Sai('')
End;

Procedure Linhas;       {�->  Calcula o n� de linhas que o ficheiro tem.  <�-}
Var Fic:Text;
    Texto:String;
    Num,L:Integer;
Begin
     Num:=0;                    {�->  Inicializa o n� de linhas inicial.  <�-}
     Assign(Fic,Fich);
     {$I-}
     Reset(Fic);    {�->  Verifica a exist�ncia do ficheiro Fich.  <�-}
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro "'+Fich+'" n�o foi encontrado.');
     If Eof(Fic) Then Sai('O ficheiro "'+Fich+'" n�o tem nenhuma linha.');
     L:=Linha;
     Repeat
           Readln(Fic,Texto);            {�->  L� uma linha do ficheiro.  <�-}
           Num:=Num+1;
           Vai(1,L);
           Write(Fich,' (',Num,')')
     Until Eof(Fic);
     Close(Fic);
     Vai(1,L);
     Write('O ficheiro "',Fich,'" tem ',Num,' linha(s).');
     Sai('')
End;

Procedure Caracteres;  {�->    Calcula o n� de caracteres que o ficheiro  <�-}
Var Fic:Text;          {�->  tem.                                         <�-}
    Texto:String;
    Num,L:Integer;
Begin
     Num:=0;                    {�->  Inicializa o n� de linhas inicial.  <�-}
     Assign(Fic,Fich);
     {$I-}
     Reset(Fic);    {�->  Verifica a exist�ncia do ficheiro Fich.  <�-}
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro "'+Fich+'" n�o foi encontrado.');
     If Eof(Fic) Then Sai('O ficheiro "'+Fich+'" n�o tem nenhum caracter.');
     L:=Linha;
     Repeat
           Readln(Fic,Texto);            {�->  L� uma linha do ficheiro.  <�-}
           Num:=Num+Length(Texto);
           Vai(1,L);
           Write(Fich,' (',Num,')')
     Until Eof(Fic);
     Close(Fic);
     Vai(1,L);
     Write('O ficheiro "',Fich,'" tem ',Num,' caracter(es).');
     Sai('')
End;

Procedure Ajuda;       {�->  Apresenta um quadro de ajuda ao utilizador.  <�-}
Begin
     Writeln('Este utilit�rio conta o n� de palavras, de linhas ou de caracteres de um        '+
             'determinado ficheiro de texto.                                                  ');
     Writeln('Modo de utiliza��o: Conta -P|-L|-C <Ficheiro> [/?]                              ');
     Writeln('                    -P -> Conta o n� de palavras;                               '+
             '                    -L -> Conta o n� de linhas;');
     Writeln('                    -C -> Conta o n� de caracteres;                             '+
             '                    Ficheiro -> Nome do ficheiro a contar;');
     Sai('                    /? -> Apresenta este mesmo quadro de ajuda.')
End;

Begin
     R.Ah:=01;                                   {�->  Desliga o cursor.  <�-}
     R.Ch:=40;
     R.Cl:=0;
     Intr($10,R);
     Writeln('Conta 1.0 -  (c), 1993  Ant�nio Jos� Monteiro Pereira');
     St:=Paramstr(1);
     Fich:=Paramstr(2);
     If (Paramcount=1) And (St='/?') Then Ajuda;
     If Paramcount<>2 Then Sai('Modo de utiliza��o errado. Conta/? para poder ser ajudado.');
     If (St='-P') Or (St='-p') Then Palavras
     Else If (St='-L') Or (St='-l') Then Linhas
     Else If (St='-C') Or (St='-c') Then Caracteres
     Else Sai('Op��o indicada n�o v�lida.')
End.
