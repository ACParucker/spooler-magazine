Program Numera;  {Ä->    Este utilit rio numera as linhas de um ficheiro  <Ä-}
                 {Ä->  de texto.                                          <Ä-}
Type Str_=String[150]; {Ä->  Define STR_ como sendo igual a String[150].  <Ä-}
     Texto=^Estrutura;
     Estrutura=Record    {Ä->  Define a estrutura do record "estrutura".  <Ä-}
                 Lin:Str_;
                 Seg:Texto
               End;

Var Inic:Texto;                            {Ä->  Defini‡„o de vari veis.  <Ä-}
    Op1:String;
    Max,I:Integer;

Procedure Sai(St:String);      {Ä->  Escreve uma mensagem no ecr„ e sai.  <Ä-}
Begin
     Writeln(St+'.');         {Ä->    Escreve a string ST e...            <Ä-}
     Halt                     {Ä->  ...termina a execu‡„o do utilit rio.  <Ä-}
End;

Procedure Inserir_Linha_Em_Memoria(L:Str_);  {Ä->    Insere uma linha em  <Ä-}
Var Ref,Refanterior,Novoref:Texto;           {Ä->  mem¢ria.               <Ä-}
Begin
     Ref:=Inic;
     While Ref<>Nil Do
           With Ref^ Do
           Begin
                Refanterior:=Ref;
                Ref:=Seg
           End;
     If Maxavail<Sizeof(Estrutura) Then Sai('Erro interno - Falta de mem¢ria');
     New(Novoref);
     Novoref^.Lin:=l;
     Novoref^.Seg:=Ref;
     If Ref=Inic Then Inic:=Novoref
     Else Refanterior^.Seg:=Novoref
End;

Procedure Carrega;     {Ä->  Carrega o ficheiro de texto para a mem¢ria.  <Ä-}
Var Fic:Text;
    Linha:Str_;
Begin
     Assign(Fic,Op1);
     {$I-}
     Reset(Fic);
     {$I+}
     If Ioresult<>0 Then Sai('O ficheiro '+Op1+' n„o foi encontrado');
     I:=0;
     While Not Eof(Fic) Do
     Begin
          {$I-}
          Readln(Fic,Linha);
          {$I+}
          If Ioresult<>0 Then Sai('Erro de leitura do ficheiro '+Op1);
          Inc(I);
          Inserir_Linha_Em_Memoria(Linha)
     End;
     Close(Fic);
     Str(I,Linha);
     Max:=Length(Linha)
End;

Function Numero(N:Integer):String;     {Ä->    Devolve o n§ da linha com  <Ä-}
Var Tam,J:Integer;                     {Ä->  espa‡os antes.               <Ä-}
    St,St1:String;
Begin
     Str(N,St);
     Tam:=Length(St);
     St1:='';
     For J:=Max Downto 1 Do
         If J>Tam Then St1:=St1+' '
         Else J:=1;
     Numero:=St1+St+': '
End;

Procedure Lista;       {Ä->    Lista no ecr„ o ficheiro de texto, com as  <Ä-}
Var Ref:Texto;         {Ä->  linhas numeradas.                            <Ä-}
Begin
     Carrega;
     Writeln;
     I:=0;
     Ref:=Inic;
     While Ref<>Nil do
     Begin
          Inc(I);
          Writeln(Numero(I),Ref^.Lin);
          Ref:=Ref^.Seg
     End
End;

Procedure Ajuda;     {Ä->    Apresenta um quadro de ajuda ao utilizador.  <Ä-}
Begin
     Writeln('Este utilit rio tem como objectivo numerar todas as linhas de um determinado    '+
             'ficheiro de texto (a passar como  parƒmetro). Essa numera‡„o ‚  feita para o    '+
             'ecr„. No entanto, poder  ser redireccionada para um outro ficheiro.             ');
     Writeln('Modo de utiliza‡„o: Numera <Ficheiro> [/?]                                      ');
     Writeln('                    Ficheiro -> Ficheiro a numerar;');
     Sai('                    /? -> Apresenta este mesmo ecr„ de ajuda')
End;

Begin
     Inic:=Nil;                             {Ä->  Inicializa INIC a NIL.  <Ä-}
     Op1:=Paramstr(1);
     Writeln('Numera 1.0 -  (c), 1993  Ant¢nio Jos‚ Monteiro Pereira');
     If (Paramcount=1) And (Op1='/?') Then Ajuda;
     If Paramcount<>1 Then Sai('Modo de utiliza‡„o errado. Numera/? para poder ser ajudado');
     Lista
End.
