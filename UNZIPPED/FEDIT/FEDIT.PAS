{****************************************************************************}
{                FEDIT  V1.1 POR SERGIO FREIRE , 1994                        }
{                                                                            }
{                                                                            }
{   BENVINDOS AO FEDIT, UM PROGRAMA QUE SERVE PARA ALTERAR UM FICHEIRO,      }
{ SEM DANIFICAR A SUA ESTRUTURA ( EXPERIMENTAR .TXT, .EXE, ETC.).            }
{   O FEDIT FOI FEITO EM TURBO PASCAL 6.0 E SER-VOS-A DE GRANDE AJUDA QUANDO }
{ QUISEREM ALTERAR, POR UM EXEMPLO, NUM EXECUTAVEL DETERMINADO CARACTER OU   }
{ CARACTERES.                                                                }
{  EU SOU UM JOVEM, COM DEZASSEIS ANOS + UNS DIAS, ESPECIALMENTE VIRADO PARA }
{ A PARTE MATEMATICA E ALGORITMICA NO QUE SE REFERE A PROGRAMA€AO. NO ENTANTO}
{  ESTES ALGORITMOS NAO SAO OS MAIS RAPIDOS.                                 }
{ ALEM DISTO TENHO MUITA FACILIDADE EM FAZER UM PROGRAMA COMO POR EXEMPLO O  }
{ O FEDIT. BREVEMENTE ACABAREI UM PROJECTO, ("X -DESIGN"-PROGRAMA DE DESENHO)}
{ E UMA ESPECTACULAR DEMO GRAFICA. CASO QUEIRAM CONTACTAREM-ME EIS A MORADA: }
{                                                                            }
{   SERGIO FREIRE                                                            }
{   RUA DR. JOSE ANTONIO ALMEIDA, Nง15                                       }
{   SOZA 3840 VAGOS                                                          }
{                                                                            }
{ PODEM ESCREVER E CONVERSAR, TROCAR IDEIAS, PROGRAMAS, ETC. E JA SABEM, SE  }
{ POSSUIREM PROCEDIMENTOS GRAFICOS RAPIDOS ( COMO LINHAS,POLIGONOS,ENCHIMENTO}
{ DE SUPERFICIES,PONTOS,BARRAS,ETC) QUE FUNCIONEM SOB O TURBO PASCAL 6.0,    }
{  AVISEM-ME ! NAO ME IMPORTO QUE SEJAM EM ASSEMBLY ( TEEM DE SER !) DESDE   }
{ QUE FUNCIONEM. AJUDAR-ME-IAM MUITO E FICARIA-VOS MUITO GRATO.              }
{ EU TAMBEM TENHO ALGUMAS COISAS QUE VOS PODERIAM AJUDAR.                    }
{****************************************************************************}

Uses Crt,Dos;

  Var F                    : File of char;
      Ch                   : Char;
      S                    : String;
      N,I,A,M,J,ACRX,ACRY  : Integer;
      End_File,Start_File  : Boolean;
      Tecla                : Char;
      Aux                  : Array[1..256] of record
                                 alt:boolean;
                                 nchar:byte;
                                 end;
      Restox,Restoy        : Integer;
      Dir                  : DirStr;
      Nome                 : NameStr;
      Ext                  : ExtStr;
      Nome_Fich            : String;


procedure Cursor(On:boolean);
var r:registers;
begin
  if On then
    begin
      r.ah:=01;
      r.ch:=3;
      r.cl:=4;
      intr($10,r);
    end
  else
    begin
      r.ah:=01;
      r.ch:=40;
      r.cl:=0;
      intr($10,r);
    end;
end;


 Procedure Sintaxe;
  begin
   Writeln('Fedit v1.1  by Sergio Freire, 1994');
   Writeln;
   Writeln('Sintaxe: Fedit (Nome do Ficheiro)');
   Writeln('Exemplo: Fedit Texto.txt');
   Writeln;
   Halt(1);
  end;

 Procedure TestaExistencia;
  Var
   S: PathStr;
   N: Integer;

  begin
   For n:=1 to 2 do
    begin
      S := FSearch(PARAMSTR(1),getenv('path'));
       if S = '' then
        BEGIN
        WRITELN;
        WriteLn('Erro: ',PARAMSTR(1),' nao encontrado !');
        Writeln;
        Sintaxe;
        END;
    end;
  end;

 Function Tohex(W: Word):String;
  Const
   HexChars: Array [0..$F] of Char = '0123456789ABCDEF';

  begin
   tohex:=hexChars[Lo(w) shr 4]+hexChars[Lo(w) and $F];
  end;

 Procedure Ecra;
  begin
   TEXTATTR:=$09;
   Writeln('ฑฑฑฑฑฑ  ฑฑฑฑ  ฑฑฑฑ   ฑฑ  ฑฑฑฑฑฑ    ');
   Writeln('ฑฑ      ฑฑÜ   ฑฑ  ฑ        ฑฑ                    Ficheiro:',Nome_Fich);
   Writeln('ฑฑฑฑ    ฑฑ฿   ฑฑ  ฑ  ฑฑ    ฑฑ    ฑ ฑ  ฑ  ฑ ');
   Writeln('ฑฑ      ฑฑฑฑ  ฑฑฑฑ   ฑฑ    ฑฑ     ฑ   ฑ. ฑ por Sergio Freire, 1994 ');
   TEXTATTR:=$01;
   Writeln(' ษอออออออออออออออออ Valor Hex. ออออออออออออออออออออป     ษออ Valor ASCII อออป ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' บ                                                 บ     บ                  บ ');
   Writeln(' ศอออออออออออออออออออออออออออออออออออออออออออออออออผ     ศออออออออออออออออออผ ');
   TEXTATTR:=$17;
   Writeln(' Page Down=Pag. Seguinte  Page Up=Pag. Anterior   Home=Principio do Ficheiro   ');
   Writeln(' ESC=Sair F3=Editar F1=Mudar de Janela  F5=Gravar fhcheiro End=Fim do Ficheiro.');
   TEXTATTR:=$07;
  end;

 Procedure Lista(Up:Boolean);
  begin
   Clrscr;
   Ecra;

    If Up then Inc(J);
    If Not Up then Dec(J);
    If J<0 then J:=0;
    If J<=1 then Start_File:=True else Start_File:=False;

    If Not Up then
     begin
      N:=256*J-256;
      If n<0 then N:=0;
      Seek(F,N);
      End_File:=False;
     end;

   for i:=1 to 16 do
    begin
     a:=0;m:=0;
     for n:=1 to 16 do
      begin
        if eof(F) then
          begin
           End_File:=True;
           Exit;
          end;
       Read(F,Ch);
       Gotoxy(4+A,5+I);
       Write(tohex(ord(Ch)));
       Gotoxy(60+M,5+I);
       if (ch<>chr(7)) and (ch<>chr(8)) then Write(Ch);
       if (ch=chr(7)) or (ch=chr(8)) then Write(chr(32));
       Inc(A,3);
       Inc(M,1);
      end;
    end;
 end;

 Procedure Alterar;

  VAR NUP,NDOWN,NRIGHT,NLEFT,X,Y:INTEGER;
      OK,GO,ENDLINE,MODOHEX,SPCH:BOOLEAN;

  CONST hexChars: array [0..15] of Char = '0123456789ABCDEF';

 PROCEDURE UP;
  BEGIN
  IF MODOHEX THEN
   BEGIN
    NUP:=WHEREY-1;
    IF NUP<6 THEN NUP:=6;
    GOTOXY(WHEREX,NUP);
   END ELSE
    NUP:=WHEREY-1;
    IF NUP<6 THEN NUP:=6;
    GOTOXY(WHEREX,NUP);
  END;

 PROCEDURE DOWN;
  BEGIN
 IF MODOHEX THEN
  BEGIN
  IF (WHEREY-5 <= RESTOY-1) AND (END_FILE) THEN
   BEGIN
   IF (((WHEREX-4) DIV 3 <= RESTOX-1) AND (WHEREY-5 <= RESTOY-1)) OR (WHEREY-5 <= RESTOY-2) THEN
    BEGIN
      NDOWN:=WHEREY+1;
      IF NDOWN>21 THEN NDOWN:=21;
      GOTOXY(WHEREX,NDOWN);
    END;
   END;
  IF NOT END_FILE THEN
    BEGIN
      NDOWN:=WHEREY+1;
      IF NDOWN>21 THEN NDOWN:=21;
      GOTOXY(WHEREX,NDOWN);
    END;

   END ELSE

 IF (WHEREY-59 <= RESTOY) AND (END_FILE) THEN
   BEGIN
   IF (((WHEREX-59) <= RESTOX) AND (WHEREY-4 <= RESTOY)) OR (WHEREY-4 <= RESTOY-1) THEN
    BEGIN
      NDOWN:=WHEREY+1;
      IF NDOWN>21 THEN NDOWN:=21;
      GOTOXY(WHEREX,NDOWN);
    END;
   END;
  IF NOT END_FILE THEN
    BEGIN
      NDOWN:=WHEREY+1;
      IF NDOWN>21 THEN NDOWN:=21;
      GOTOXY(WHEREX,NDOWN);
    END;

  END;

 PROCEDURE RIGHT;
  BEGIN
 IF MODOHEX THEN
   BEGIN
  IF (((WHEREX-4) DIV 3 <= RESTOX-2) OR (WHEREY-5 <= RESTOY-1)) AND (END_FILE) THEN
    BEGIN
      NRIGHT:=WHEREX+3;
      IF NRIGHT>49 THEN NRIGHT:=49;
      GOTOXY(NRIGHT,WHEREY);
    END;
  IF NOT END_FILE THEN
    BEGIN
      NRIGHT:=WHEREX+3;
      IF NRIGHT>49 THEN NRIGHT:=49;
      GOTOXY(NRIGHT,WHEREY);
    END;
   END;

 IF NOT MODOHEX THEN
   BEGIN

  IF ((WHEREX-58 <= RESTOX) OR (WHEREY-4 <= RESTOY)) AND (END_FILE) THEN
    BEGIN
      NRIGHT:=WHEREX+1;
      IF NRIGHT>75 THEN NRIGHT:=75;
      GOTOXY(NRIGHT,WHEREY);
    END;
  IF NOT END_FILE THEN
    BEGIN
      NRIGHT:=WHEREX+1;
      IF NRIGHT>75 THEN NRIGHT:=75;
      GOTOXY(NRIGHT,WHEREY);
    END;
   END;

  END;

 PROCEDURE LEFT;
  BEGIN
 IF MODOHEX THEN
  BEGIN
   NLEFT:=WHEREX-3;
   IF NLEFT<4 THEN NLEFT:=4;
   GOTOXY(NLEFT,WHEREY);
  END;

 IF NOT MODOHEX THEN
  BEGIN
   NLEFT:=WHEREX-1;
   IF NLEFT<60 THEN NLEFT:=60;
   GOTOXY(NLEFT,WHEREY);
  END;
 END;

  PROCEDURE WRITEXYB(X,Y:INTEGER;S:STRING);
   VAR X2,Y2:INTEGER;
     BEGIN
       X2:=WHEREX;Y2:=WHEREY;
       GOTOXY(X,Y);WRITE(S);
       GOTOXY(X2,Y2);
    END;

  PROCEDURE ALTERA(NCHAR:INTEGER);
     Var Asc_Code:INTEGER;

    BEGIN
    N:=0;OK:=FALSE;ENDLINE:=FALSE;
    TEXTATTR:=$17;

  IF MODOHEX THEN
   BEGIN

    repeat
     If ch=Hexchars[n] then Ok:=True;
     Inc(N);
    until ok;

    WRITE(Ch);

    I:=N;Ok:=False;N:=0;Go:=False;

    repeat
     Ch:=Upcase(Readkey);
     for N:=0 to 15 do
      begin
       If Ch=Hexchars[n] then Go:=true;
      end;
    until Go;

    N:=0;

    repeat
     if Ch=Hexchars[n] then Ok:=True;
     Inc(N);
    until Ok;

    WRITE(Ch);

    Go:=False;
    Asc_Code:=(I-1)*16+N-1;
    N:=Wherex+1;
    If n>49 then begin N:=49;Endline:=True;end;
    IF ((n+3) div 3 > restox) and (wherey-5 >= restoy) and (end_file) then n:=4+(restox-1)*3;
    I:=WHEREY;
    Gotoxy(N,I);
    X:=Wherex;Y:=Wherey;
    ACRX:=(X DIV 3)-1;
    If (X=49) AND (ENDLINE) then Acrx:=Acrx+1;
    ACRY:=Y-6;
    if (asc_code<>7) and (asc_code<>8) then  WRITEXYB(59+ACRX,6+ACRY,CHR(ASC_CODE));;
    if (asc_code=7) or (asc_code=8) then WRITEXYB(59+ACRX,6+ACRY,CHR(32));
    Ch:=Chr(Asc_Code);
    Aux[acrx+(acry*16)].Nchar:=Asc_Code;
    Aux[acrx+(acry*16)].Alt:=True;
    Textattr:=$07;
    ENDLINE:= FALSE;

  END;

  IF NOT MODOHEX THEN
   BEGIN

    WRITE(Ch);

    Go:=False;
    Asc_Code:=Ord(Ch);
    X:=WhereX;Y:=Wherey;
    GotoXY((X-60)*3+1,Y);Write(tohex(ord(ch)));
    Aux[(X-60)+(Y-6)*16].Nchar:=Asc_Code;
    Aux[(X-60)+(Y-6)*16].Alt:=True;
    If X>75 then begin X:=75;Endline:=True;end;
    IF (X-59>restox) and (y>=restoy) and (end_file) then x:=59+restox;
    GOTOXY(X,Y);
    Textattr:=$07;
    ENDLINE:= FALSE;
   END;
  END;

  PROCEDURE SAVE;
   Var FPos:integer;
    BEGIN
     FPos:=(J-1)*256;
     Seek(F,FPos);
     FOR N:=1 TO 256 DO
       BEGIN
        Ch:=Chr(AUX[N].NCHAR);
        IF AUX[N].ALT THEN WRITE(F,CH);
        Inc(FPos);
        Seek(F,FPos);
       END;
   END;

  Begin
  CURSOR(TRUE);
  Gotoxy(4,6);
  Ch:=' ';Go:=False;MODOHEX:=TRUE;

  repeat
   SPCH:=FALSE;
   IF MODOHEX THEN Ch:=UPCASE(Readkey);
   IF NOT MODOHEX THEN Ch:=Readkey;

   If Ch=#0 then
    Begin
     Ch:=Readkey;
      If Ch=#59 then BEGIN
        MODOHEX:=NOT MODOHEX;
        If ModoHex then GotoXY(4,6);
        If NOT ModoHex then GotoXY(60,6) ;  { F1       }
                     END;
      If Ch=#72 then Up;                    { CIMA     }
      If Ch=#80 then Down;                  { BAIXO    }
      If Ch=#77 then Right;                 { DIREITA  }
      If Ch=#75 then Left;                  { ESQUERDA }
      If Ch=#63 then Save;                  {    F5    }
    SPCH:=True;
    End;

   IF MODOHEX THEN
    BEGIN
     For N:=0 to 15 do
      begin
        if Ch=Hexchars[n] then Go:=True;
      end;
    END;

   IF (NOT MODOHEX) AND (NOT SPCH) AND (CH<>#08) AND (CH<>#13) AND (CH<>#27)THEN
    BEGIN
     GO:=TRUE;
    END;

   IF GO THEN ALTERA(10);

  Until Ch=#27;                           {    F1    }
  CURSOR(FALSE);
  FOR N:=1 TO 256 DO AUX[N].ALT:=FALSE;
 end;


       {************************** MAIN *******************************}

 begin
  clrscr;
  A:=0;J:=0;M:=0;End_File:=False;Start_File:=True;TEXTATTR:=$07;
  For N:=1 to 256 do Aux[N].Alt:=False;

  IF PARAMCOUNT<1 THEN Sintaxe ELSE TestaExistencia;
  FSPLIT(PARAMSTR(1),Dir,Nome,Ext);
  Nome_Fich:=Nome+Ext;
  Assign(F,Nome_Fich);
  Reset(F);
  RESTOY:=((FILESIZE(F) MOD 256) DIV 16)+1;
  RESTOX:=(FILESIZE(F) MOD 256) MOD 16;
  CURSOR(FALSE);LISTA(TRUE);

 repeat
  Tecla:=Upcase(Readkey);

   If (Tecla=#81) And (Not End_file) then Lista(True);     { PG UP   }

   If (Tecla=#73) And (Not Start_file) then Lista(False);  { PG DOWN }

   If (Tecla=#71) And (Not Start_File) then                {  HOME   }
    begin
     J:=0;
     Lista(False);
    end;

   If (tecla=#79) And (Not End_File) then                  {   END   }
    begin
     J:=(Filesize(F) div 256)+2;
     Lista(false);
    end;

   If (Tecla=#61) THEN ALTERAR;                            {   F3   }

 Until Tecla=#27;

Close(F);
Clrscr;
WRITELN('Fedit v1.1 por Srgio Freire (C), 1994');
WRITELN;
WRITELN('Se quiserem escrever-me, a morada  : ');
WRITELN;
WRITELN(' Srgio Freire                                    ');
WRITELN(' Rua Dr. Jos Antขnio Almeida, nง15               ');
WRITELN(' Soza 3840 Vagos                                  ');
WRITELN;
CURSOR(TRUE);

End.
