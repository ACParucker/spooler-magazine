Program Unidades;  {Ä->    Este programa visualiza todas as unidades ac-  <Ä-}
                   {Ä->  tivas no sistema.                                <Ä-}
Procedure Sai(St:String);      {Ä->  Escreve uma mensagem no ecr„ e sai.  <Ä-}
Begin
     Writeln(St);
     Halt
End;

Procedure Calcula;              {Ä->  Procura todas as unidades activas.  <Ä-}
Var I,J:Integer;
    Unidade:Array[1..26] Of Char;
    St,St1:String;
Begin
     GetDir(0,St);              {Ä->  ST toma o valor da unidade actual.  <Ä-}
     J:=0;
     For I:=65 To 90 Do
     Begin
          {$I-}
          ChDir(Chr(I)+':');     {Ä->  Verifica a existˆncia da unidade.  <Ä-}
          {$I+}
          If Ioresult=0 Then
          Begin
               Inc(J);                     {Ä->  Conta o n§ de unidades.  <Ä-}
               Unidade[J]:=Chr(I)
          End
     End;
     ChDir(St);                 {Ä->  Coloca-se na unidade inicial (ST).  <Ä-}
     St:='';
     For I:=1 To J Do
         St:=St+Unidade[I]+': ';
     Str(J,St1);
     If J=1 Then Sai('H  apenas uma unidade activa: '+St)
     Else Sai('H  '+St1+' unidades activas: '+St)
End;

Procedure Ajuda;       {Ä->  Apresenta um quadro de ajuda ao utilizador.  <Ä-}
Begin
     Writeln('Este utilit rio tem como objectivo apresentar, no ecr„, todas as unidades       '+
             'activas no sistema e, tamb‚m, o n§ total das mesmas.                            ');
     Sai('Modo de utiliza‡„o ->  Unidades [/?]                                            '+
         '                       /? -> Apresenta este mesmo ecr„ de ajuda.')
End;

Begin
     Writeln('Unidades 1.0 -  (c), 1994  Ant¢nio Jos‚ Monteiro Pereira');
     If (Paramcount=1) And (Paramstr(1)='/?') Then Ajuda
     Else If Paramcount<>0 Then Sai('Modo de utiliza‡„o errado. Unidades/? para poder ser ajudado.');
     Calcula
End.
