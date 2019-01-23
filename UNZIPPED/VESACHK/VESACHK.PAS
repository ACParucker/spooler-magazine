PROGRAM VesaCheck_186;
{
ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
³ VESA Check v1.86, 1993.                                                    ³
³ Criado e Desenvolvido em Junho de 1993              METROPOLIS BBS         ³
³ Por Hugo Ferreira & West Coast Software.            Praceta do Barro, 6    ³
³                                                     Alcoit„o               ³
³ Para d£vidas ou suporte t‚cnico devem escrever      2765 ESTORIL           ³
³ para a morada indicada ao lado, ou deixar uma                              ³
³ mensagem ao SysOp na METROPOLIS BBS (ESTORIL)                              ³
³ ou dirigida a Hugo Ferreira na BBSpooler (Lisboa).                         ³
ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾
 ************
 * ATEN€ŽO: *
 ************

 Para poder fixar um modo de video disponivel na BIOS VESA, deve inserir
 esta pequena Procedure nos seus programas.

 -------------------------------------------------------------------------
  PROCEDURE FixaModoSVGA(M : Word); Assembler;
  ASM
    MOV AH, 4Fh
    MOV AL, 02h
    MOV BX, M
    INT 10h
  END;
 -------------------------------------------------------------------------

 No decorrer do programa, quando quiser chamar o modo de video deve inserir
 as seguintes linhas no seu programa.

  IF Cmp8x8 THEN
    TextMode(LastMode OR Font8x8);
  FixaModoSVGA(Modo); -> 'Modo' equivale ao modo desejado.

}
USES Crt;
TYPE
  CadeiaHex   = String[9];
  ListaCar    = ARRAY[0..65520] OF Char;
  PtrListaCar = ^ListaCar;
  ListaVM     = ARRAY[0..65520 DIV 2] OF Word;
  PtrListaVM  = ^ListaVM;
  InfoBuffer  = RECORD
    AssinaturaVESA : ARRAY[1..4] OF Char;
    VersaoVESA     : Word;
    CadeiaOEM      : PtrListaCar;
    Capacidades    : LongInt;
    PtrModoVideo   : PtrListaVM;
    MemoriaTotal   : Byte;
    Reservado      : ARRAY[0..235] OF Byte;
  END;
  ModoInfo = RECORD
    AtributosModo     : Word;
    AtributosJanA     : Byte;
    AtributosJanB     : Byte;
    GranulacaoJan     : Word;
    TamanhoJan        : Word;
    SegmentoJanA      : Word;
    SegmentoJanB      : Word;
    PtrFuncJan        : Pointer;
    BytesPorLinhaScan : Word;
    ResolucaoX        : Word;
    ResolucaoY        : Word;
    TamCarX           : Byte;
    TamCarY           : Byte;
    NumeroDePlanos    : Byte;
    BitsPorPixel      : Byte;
    NumeroDeBancos    : Byte;
    ModeloDeMemoria   : Byte;
    TamBanco          : Byte;
    NumDePagImagem    : Byte;
    Reservado         : Byte;
    Filler            : ARRAY[0..224] OF Byte;
  END;

CONST DigitosHex : ARRAY[0..15] OF Char = '0123456789ABCDEF';

VAR
  MBuffer               : ModoInfo;
  Buffer                : InfoBuffer;
  ModoVideo, CmpX, CmpY,
  N, X, Y, CmpModo      : Word;
  Cmp8x8                : Boolean;
  CH                    : Char;
  Power2                : ARRAY[0..15] OF Word;
  S                     : String;


  FUNCTION ConvHex(W : Word) : CadeiaHex;
  VAR Temp : CadeiaHex;
  BEGIN
    Temp[0] := #4;
    Temp[1] := DigitosHex[W SHR 12];
    Temp[2] := DigitosHex[(W SHR 8) AND $F];
    Temp[3] := DigitosHex[(W SHR 4) AND $F];
    Temp[4] := DigitosHex[W AND $F];
    ConvHex := Temp;
  END;

  FUNCTION SuportaVESA : Boolean; Assembler;
  ASM
    MOV AH, 4Fh
    MOV AL, 00h
    PUSH DS
    POP ES
    LEA DI, Buffer
    INT 10h
    CMP AL, 4Fh
    JNE @Nao_e_VESA
    MOV AL, 1
    RET
    @Nao_e_VESA:
    MOV AL, 0
  END;

  FUNCTION AchaModoVideoVESA : WORD; Assembler;
  ASM
    MOV AH, 4Fh
    MOV AL, 03h
    INT 10h
    CMP AH, 0h
    JNE @Falhou
    MOV AX, BX
    RET
    @Falhou:
    MOV AX, 0FFFFh
  END;

  FUNCTION AchaInfoModo(M : Word) : Boolean; Assembler;
  ASM
    MOV AH, 4Fh
    MOV AL, 01h
    MOV CX, M
    PUSH DS
    POP ES
    LEA DI, MBuffer
    INT 10h
    MOV AL, 0
    CMP AH, 0h
    JNE @Falhou
    INC AL
    @Falhou:
  END;

  PROCEDURE Intro;
  BEGIN
    TextBackGround(0);
    TextColor(9);  WriteLn(#13, #10, 'VESA Check v1.86, 1993.');
    TextColor(15); WriteLn('Criado e Desenvolvido por Hugo Ferreira & WCS, 1993.');
    TextColor(7);  writeln ('Praceta do barro, 6 - Alcoitao - 2765 ESTORIL PORTUGAL');
                   writeln ('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ', #10);
  END;


  PROCEDURE MostraInfoModo(M : Word);
  BEGIN
    Write(' ', ConvHex(M), '':5);
    IF (NOT AchaInfoModo(M)) OR (MBuffer.AtributosModo AND 2 = 0) THEN
      WriteLn('informa‡„o n„o disponivel')
    ELSE
      WITH MBuffer DO
        BEGIN
          IF ModeloDeMemoria = 0 THEN
            BEGIN
              Write(' TEXTO ','':3);
              IF ResolucaoX * ResolucaoY > CmpX * CmpY THEN
                BEGIN
                  CmpX := ResolucaoX;
                  CmpY := ResolucaoY;
                  CmpModo := M;
                  Cmp8x8 := TamCarY = 8;
                END;
            END
          ELSE
            Write('GRAFICO','':3);
            Write(ResolucaoX:4,'x');
            Write(ResolucaoY:4,'':3);
            Write(Power2[BitsPorPixel]:5,'':3);
            Write(TamCarX:1,'x',TamCarY:2);
            IF (ParamStr(1)='/x') or (ParamStr(1)='/X') then
            BEGIN
              Write(ModeloDeMemoria:5);
              Write(NumeroDePlanos:4);
              Write(BitsPorPixel:4);
              Write(NumeroDeBancos:3);
              Write(TamBanco:3);
              WriteLn(NumDePagImagem:3);
            END ELSE WriteLn;
       END;  
  END;

BEGIN
  Intro;
  IF NOT SuportaVESA THEN
    BEGIN
      WriteLn('Esta placa gr fica n„o suporta VESA');
      Halt;
    END;
  ModoVideo := AchaModoVideoVESA;
  IF ModoVideo = $FFFF THEN
    BEGIN
      WriteLn('Tentativa de achar o modo de video VESA falhada.');
      Halt;
    END;
  IF Buffer.AssinaturaVESA <> 'VESA' THEN
    BEGIN
      WriteLn('Bloco de informa‡”es VESA achado, mas ');
      WriteLn('a assinatura VESA n„o se encontra presente.');
      Halt;
    END;
  WriteLn('Placa Gr fica suporta VESA.');
  WriteLn('Corrente modo de video   : ', ModoVideo);
  WITH Buffer DO
    BEGIN
      WriteLn('Vers„o da BIOS VESA      : ', Hi(VersaoVESA), '.', Lo(VersaoVESA));
      Write('Mem¢ria detectada        : ');
      IF VersaoVESA > $100 THEN
        WriteLn(MemoriaTotal * 64, 'K')
      ELSE
        WriteLn('N„o disponivel na vers„o VESA 1.0');
      Write('Nome do fabricante (OEM) : ');
      N := 0;
      REPEAT
        Write(CadeiaOEM^[N]);
        Inc(N);
      UNTIL (CadeiaOEM^[N] = #0) OR (N > 256);
      WriteLn; WriteLn;
      
      Power2[0] := 1;
      FOR N := 1 to 15 DO
        Power2[N] := 2 * Power2[pred(N)];
      N := 0;
      CmpModo := 0; CmpX := 80; CmpY := 25;
      WHILE PtrModoVideo^[N] <> $FFFF DO
        BEGIN
          IF N MOD 20 = 0 THEN
            BEGIN
              Write('Prima < ENTER > Para Continuar ... ');
              Repeat until readkey=#13;
              Write(Chr(13));

              Write(' Modo#     Tipo     Resolu‡„o   Cores   Car.');
              IF (ParamStr(1)='/x') or (ParamStr(1)='/X') THEN WriteLn('   MM  #P BPP #B BS #IP')
              ELSE WriteLn;
            END;
          MostraInfoModo(PtrModoVideo^[N]);
          Inc(N);
        END;
      WriteLn;
      Write('Char. - Tamanho do caracter');
      IF (ParamStr(1)='/x') or (ParamStr(1)='/X') THEN
      BEGIN
        WriteLn('                BPP - Bytes Por Pixel');
        WriteLn('MM    - Modelo de mem¢ria                  #B  - Numero de bancos');
        WriteLn('#P    - Numero de planos                   BS  - Tamanho dos bancos');
        WriteLn('#IP   - Numero de paginas de imagem');
      END ELSE WriteLn;
   END;
END.
