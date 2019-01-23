Program Calendario; {Ä->    Este utilit rio apresenta o calend rio de um  <Ä-}
Uses Dos;           {Ä->  determinado mˆs (e/ou ano) ou o dia actual.     <Ä-}

Const Dias:Array[0..6] Of String[14]=('Domingo','Segunda-Feira','Ter‡a-Feira',
                                      'Quarta-Feira','Quinta-Feira',
                                      'Sexta-Feira','S bado');
      Meses:Array[1..12] Of String[9]=('Janeiro','Fevereiro','Mar‡o','Abril',
                                       'Maio','Junho','Julho','Agosto',
                                       'Setembro','Outubro','Novembro',
                                       'Dezembro');
      N_Dias:Array[1..12] Of Integer=(31,1,31,30,31,30,31,31,30,31,30,31);

Var Dia,Mes,Ano,Semana,Erro:Word;          {Ä->  Defini‡„o de vari veis.  <Ä-}
    R:Registers;

Procedure Vai(C,L:Integer);      {Ä->  Coloca-se na coluna C da linha L.  <Ä-}
Begin
     R.Ah:=02;
     R.Dh:=L-1;
     R.Dl:=C-1;
     R.Bh:=0;
     Intr($10,R)
End;

Function Linha:Byte;    {Ä->    Devolve o n§ da linha em que se encontra  <Ä-}
Begin                   {Ä->  o cursor.                                   <Ä-}
     R.Ah:=03;
     R.Bh:=0;
     Intr($10,R);
     Linha:=R.Dh+1
End;

Procedure Sai(St:String);      {Ä->  Escreve uma mensagem no ecr„ e sai.  <Ä-}
Begin
     Writeln(St+'.');
     Halt
End;

Function Espacos(St:String):String;     {Ä->    Coloca espa‡os em ST, de  <Ä-}
Var I:Integer;                          {Ä->  forma a que ST tenha o seu  <Ä-}
Begin                                   {Ä->  tamanho igual a 12.         <Ä-}
     For I:=Length(St)+1 To 12 Do
         St:=St+' ';
     Espacos:=St
End;

Procedure Quadro(M,A:Word);{Ä->  Desenha no ecr„ o quadro do calend rio.  <Ä-}
Begin
     Writeln('                ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄ¿');
     Writeln('                ³       ',Espacos(Meses[M]),'   ³ ',A,' ³');
     Writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÍÍÍÍÑÍÍÍÍÑÍÍÍÍÑÍÍÍÍÑÍÍÏÍÑÍÍÍÍ´');
     Writeln('³ Domingo       ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄ´');
     Writeln('³ Segunda-Feira ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄ´');
     Writeln('³ Ter‡a-Feira   ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄ´');
     Writeln('³ Quarta-Feira  ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄ´');
     Writeln('³ Quinta-Feira  ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄ´');
     Writeln('³ Sexta-Feira   ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄ´');
     Writeln('³ S bado        ³    ³    ³    ³    ³    ³    ³');
     Writeln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÙ')
End;

Procedure Hoje; {Ä->    Apresenta o data actual, ou seja, dia da semana,  <Ä-}
Var A,M,D,S:Word;  {Ä->  dia (n§), mˆs (extenso) e ano (n§).              <Ä-}
Begin
     Getdate(A,M,D,S);
     Writeln(Dias[S],', ',D,' de ',Meses[M],' de ',A)
End;

Function Numero(N:Integer):String;{Ä->    Devolve N com ou sem um espa‡o  <Ä-}
Var St:String;                    {Ä->  antes (o n§ de d¡gitos de N  tem  <Ä-}
Begin                             {Ä->  que ser igual a 2).               <Ä-}
     Str(N,St);
     If Length(St)=1 Then Numero:=' '+St
     Else Numero:=St
End;

Procedure Cal(M,A:Integer);  {Ä->  Apres. o calend rio do mˆs M e ano A.  <Ä-}
Var I,J,Col,Lin,Lin_Max,L1:Integer;
    Ano_,Mes_,Dia_,Semana_,A_,M_,D_,S_:Word;
Begin
     Writeln;
     GetDate(Ano_,Mes_,Dia_,Semana_);        {Ä->  Recebe a data actual.  <Ä-}
     SetDate(A,M,1);      {Ä->  Atribui a data indicada pelo utilizador.  <Ä-}
     GetDate(A_,M_,D_,S_);         {Ä->    Recebe a data do sistema para  <Ä-}
     Quadro(M,A);                  {Ä->  saber o dia da semana (Dia 1).   <Ä-}
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
     Else J:=28;        {Ä->  Verifica o n§ de dias do mˆs de fevereiro.  <Ä-}
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
     SetDate(Ano_,Mes_,Dia_)      {Ä->    Atribui ao sist. a data actual  <Ä-}
End;                              {Ä->  (a data ®verdadeira¯).            <Ä-}

Procedure Ajuda;       {Ä->  Apresenta um quadro de ajuda ao utilizador.  <Ä-}
Begin
     Writeln('Este utilit rio tem como objectivo visualizar, no ecr„, o dia de hoje ou ent„o  '+
             'o calend rio de um determinado mˆs (e/ou ano). Assim, se n„o for  especificado');
     Writeln('nenhum parƒmetro, o dia actual ser  apresentado; se for especificado  um parƒ-  '+
             'metro (este ter  que ser um mˆs) ser  visualizado o calend rio do mˆs indicado');
     Writeln('e do ano actual; se forem  especificados 2 parƒmetros (mˆs e ano)  ent„o, ser   '+
             'apresentado o calend rio do mˆs e ano indicados.                                ');
     Writeln('Modo de utiliza‡„o: Cal [Mˆs] [Ano] [/?]');
     Writeln;
     Writeln('                    Mˆs -> Ter  que ter valores compreendidos entre 1 e 12;');
     Sai('                    Ano -> Ter  que ter valores compreendidos entre 1980 e 2099;'+
         '                    /?  -> Apresenta este mesmo ecr„ de ajuda')
End;

Begin
     Writeln('Calend rio 1.0 -  (c), 1993  Ant¢nio Jos‚ Monteiro Pereira');
     If Paramcount=0 Then Hoje
     Else If Paramcount=1 Then
          Begin
               If Paramstr(1)='/?' Then Ajuda;
               Getdate(Ano,Mes,Dia,Semana);
               Val(Paramstr(1),Mes,Erro);
               If (Erro<>0) Or ((Mes<1) Or (Mes>12)) Then Sai('O mˆs indicado n„o ‚ v lido');
               Cal(Mes,Ano)
          End
     Else If Paramcount=2 Then
          Begin
               Val(Paramstr(1),Mes,Erro);
               If (Erro<>0) Or ((Mes<1) Or (Mes>12)) Then Sai('O mˆs indicado n„o ‚ v lido');
               Val(Paramstr(2),Ano,Erro);
               If (Erro<>0) Or ((Ano<1980) Or (Mes>2099)) Then Sai('O ano indicado n„o ‚ v lido');
               Cal(Mes,Ano)
          End
     Else If Paramcount>2 Then Sai('Modo de utiliza‡„o errado. Cal/? para poder ser ajudado')
End.
