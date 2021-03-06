Program Calendario; {�->    Este utilit�rio apresenta o calend�rio de um  <�-}
Uses Dos;           {�->  determinado m�s (e/ou ano) ou o dia actual.     <�-}

Const Dias:Array[0..6] Of String[14]=('Domingo','Segunda-Feira','Ter�a-Feira',
                                      'Quarta-Feira','Quinta-Feira',
                                      'Sexta-Feira','S�bado');
      Meses:Array[1..12] Of String[9]=('Janeiro','Fevereiro','Mar�o','Abril',
                                       'Maio','Junho','Julho','Agosto',
                                       'Setembro','Outubro','Novembro',
                                       'Dezembro');
      N_Dias:Array[1..12] Of Integer=(31,1,31,30,31,30,31,31,30,31,30,31);

Var Dia,Mes,Ano,Semana,Erro:Word;          {�->  Defini��o de vari�veis.  <�-}
    R:Registers;

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

Procedure Sai(St:String);      {�->  Escreve uma mensagem no ecr� e sai.  <�-}
Begin
     Writeln(St+'.');
     Halt
End;

Function Espacos(St:String):String;     {�->    Coloca espa�os em ST, de  <�-}
Var I:Integer;                          {�->  forma a que ST tenha o seu  <�-}
Begin                                   {�->  tamanho igual a 12.         <�-}
     For I:=Length(St)+1 To 12 Do
         St:=St+' ';
     Espacos:=St
End;

Procedure Quadro(M,A:Word);{�->  Desenha no ecr� o quadro do calend�rio.  <�-}
Begin
     Writeln('                �����������������������������Ŀ');
     Writeln('                �       ',Espacos(Meses[M]),'   � ',A,' �');
     Writeln('���������������������������������������������ʹ');
     Writeln('� Domingo       �    �    �    �    �    �    �');
     Writeln('���������������������������������������������Ĵ');
     Writeln('� Segunda-Feira �    �    �    �    �    �    �');
     Writeln('���������������������������������������������Ĵ');
     Writeln('� Ter�a-Feira   �    �    �    �    �    �    �');
     Writeln('���������������������������������������������Ĵ');
     Writeln('� Quarta-Feira  �    �    �    �    �    �    �');
     Writeln('���������������������������������������������Ĵ');
     Writeln('� Quinta-Feira  �    �    �    �    �    �    �');
     Writeln('���������������������������������������������Ĵ');
     Writeln('� Sexta-Feira   �    �    �    �    �    �    �');
     Writeln('���������������������������������������������Ĵ');
     Writeln('� S�bado        �    �    �    �    �    �    �');
     Writeln('�����������������������������������������������')
End;

Procedure Hoje; {�->    Apresenta o data actual, ou seja, dia da semana,  <�-}
Var A,M,D,S:Word;  {�->  dia (n�), m�s (extenso) e ano (n�).              <�-}
Begin
     Getdate(A,M,D,S);
     Writeln(Dias[S],', ',D,' de ',Meses[M],' de ',A)
End;

Function Numero(N:Integer):String;{�->    Devolve N com ou sem um espa�o  <�-}
Var St:String;                    {�->  antes (o n� de d�gitos de N  tem  <�-}
Begin                             {�->  que ser igual a 2).               <�-}
     Str(N,St);
     If Length(St)=1 Then Numero:=' '+St
     Else Numero:=St
End;

Procedure Cal(M,A:Integer);  {�->  Apres. o calend�rio do m�s M e ano A.  <�-}
Var I,J,Col,Lin,Lin_Max,L1:Integer;
    Ano_,Mes_,Dia_,Semana_,A_,M_,D_,S_:Word;
Begin
     Writeln;
     GetDate(Ano_,Mes_,Dia_,Semana_);        {�->  Recebe a data actual.  <�-}
     SetDate(A,M,1);      {�->  Atribui a data indicada pelo utilizador.  <�-}
     GetDate(A_,M_,D_,S_);         {�->    Recebe a data do sistema para  <�-}
     Quadro(M,A);                  {�->  saber o dia da semana (Dia 1).   <�-}
     L1:=Linha-14;
     Lin:=L1;
     Lin_Max:=Linha-2;
     Col:=19;
     If S_<>0 Then
     For I:=1 To S_ Do
         Inc(Lin,2);
     J:=N_Dias[M];
     If M=2 Then
     If ((A Mod 4=0) And (A Mod 100<>0)) Or (A Mod 400=0) Then J:=29
     Else J:=28;        {�->  Verifica o n� de dias do m�s de fevereiro.  <�-}
     For I:=1 To J Do
     Begin
          Vai(Col,Lin);
          Write(Numero(I));
          If Lin=Lin_Max Then
          Begin
               Lin:=L1;
               Inc(Col,5)
          End
          Else Inc(Lin,2)
     End;
     Vai(1,Lin_Max+2);
     SetDate(Ano_,Mes_,Dia_)      {�->    Atribui ao sist. a data actual  <�-}
End;                              {�->  (a data �verdadeira�).            <�-}

Procedure Ajuda;       {�->  Apresenta um quadro de ajuda ao utilizador.  <�-}
Begin
     Writeln('Este utilit�rio tem como objectivo visualizar, no ecr�, o dia de hoje ou ent�o  '+
             'o calend�rio de um determinado m�s (e/ou ano). Assim, se n�o for  especificado');
     Writeln('nenhum par�metro, o dia actual ser� apresentado; se for especificado  um par�-  '+
             'metro (este ter� que ser um m�s) ser� visualizado o calend�rio do m�s indicado');
     Writeln('e do ano actual; se forem  especificados 2 par�metros (m�s e ano)  ent�o, ser�  '+
             'apresentado o calend�rio do m�s e ano indicados.                                ');
     Writeln('Modo de utiliza��o: Cal [M�s] [Ano] [/?]');
     Writeln;
     Writeln('                    M�s -> Ter� que ter valores compreendidos entre 1 e 12;');
     Sai('                    Ano -> Ter� que ter valores compreendidos entre 1980 e 2099;'+
         '                    /?  -> Apresenta este mesmo ecr� de ajuda')
End;

Begin
     Writeln('Calend�rio 1.0 -  (c), 1993  Ant�nio Jos� Monteiro Pereira');
     If Paramcount=0 Then Hoje
     Else If Paramcount=1 Then
          Begin
               If Paramstr(1)='/?' Then Ajuda;
               Getdate(Ano,Mes,Dia,Semana);
               Val(Paramstr(1),Mes,Erro);
               If (Erro<>0) Or ((Mes<1) Or (Mes>12)) Then Sai('O m�s indicado n�o � v�lido');
               Cal(Mes,Ano)
          End
     Else If Paramcount=2 Then
          Begin
               Val(Paramstr(1),Mes,Erro);
               If (Erro<>0) Or ((Mes<1) Or (Mes>12)) Then Sai('O m�s indicado n�o � v�lido');
               Val(Paramstr(2),Ano,Erro);
               If (Erro<>0) Or ((Ano<1980) Or (Mes>2099)) Then Sai('O ano indicado n�o � v�lido');
               Cal(Mes,Ano)
          End
     Else If Paramcount>2 Then Sai('Modo de utiliza��o errado. Cal/? para poder ser ajudado')
End.
