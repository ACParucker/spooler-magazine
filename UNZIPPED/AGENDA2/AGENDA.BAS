'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
'ณ                                                                           ณ
'ณ     ÛÛÛÛÛป   ÛÛÛÛÛÛป  ÛÛÛÛÛÛÛป ÛÛÛป   ÛÛป ÛÛÛÛÛÛป   ÛÛÛÛÛป   v1.1         ณ
'ณ    ÛÛษออÛÛป ÛÛษออออผ  ÛÛษออออผ ÛÛÛÛป  ÛÛบ ÛÛษออÛÛป ÛÛษออÛÛป               ณ
'ณ    ÛÛÛÛÛÛÛบ ÛÛบ  ÛÛÛป ÛÛÛÛÛป   ÛÛษÛÛป ÛÛบ ÛÛบ  ÛÛบ ÛÛÛÛÛÛÛบ               ณ
'ณ    ÛÛษออÛÛบ ÛÛบ   ÛÛบ ÛÛษออผ   ÛÛบศÛÛปÛÛบ ÛÛบ  ÛÛบ ÛÛษออÛÛบ  West         ณ
'ณ    ÛÛบ  ÛÛบ ศÛÛÛÛÛÛษผ ÛÛÛÛÛÛÛป ÛÛบ ศÛÛÛÛบ ÛÛÛÛÛÛษผ ÛÛบ  ÛÛบ  Coast        ณ
'ณ    ศอผ  ศอผ  ศอออออผ  ศออออออผ ศอผ  ศอออผ ศอออออผ  ศอผ  ศอผ  Software     ณ
'ณ    Desenvolvido e programado por Hugo Ferreira                            ณ
'ณ                                                                           ณ
'ณ    Linguagem                      : Microsoft QuickBasic 4.5              ณ
'ณ    Data de termino da programaao : 10 de Outubro 1993                    ณ
'ณ                                                                           ณ
'รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
'ณ    Se necessitar entrar em contacto com a equipa de programaao da        ณ
'ณ    West Coast Software, por favor escreva para a morada a seguir:         ณ
'ณ                                                                           ณ
'ณ       Metropolis BBS                                                      ณ
'ณ       Praceta do Barro, 6 - Alcoitao                                      ณ
'ณ       2765 ESTORIL - PORTUGAL                                             ณ
'ณ                                                                           ณ
'ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
'
' O programa AGENDA v1.1, permite um armazenamento em memขria de 400 registos.
' Estes so organizados alfabeticamente e automaticamente pelo programa, logo
' apขs a sua insero. O programa permite ainda imprimir registos isolados,
' listas ou moradas. Possui um sistema de edio avanado, podendo executar-se
' praticamente todas as opera”es como num processador de texto.
' O programa est  equipado com um sistema de configurao que permite alterar
' praticamente todas as cores do programa, e permite ainda especificar as
' directorias de localizao dos ficheiros com que o programa trabalha, de
' modo a que o mesmo possa ser colocado no PATH.
'
'-----------------------------------------------------------------------------
'Declarao das Functions e Subs do programa por ordem alfabtica
 DECLARE SUB BOX (Lin1%, Col1%, Lin2%, Col2%, Color1%, Color2%, BoxType%, Shadow%)
 DECLARE SUB Center (Color1%, Color2%, Lin%, Text$)
 DECLARE SUB COMPUTEMonth (Year%, Month%, StartDay%, TotalDays%)
 DECLARE SUB EDIT (RecordVar AS ANY)
 DECLARE SUB CONFIG ()
 DECLARE SUB LPRINTSystem (Choice%, REC%, RecordFile() AS ANY, NumberOfRecords%)
 DECLARE SUB MenuSystem ()
 DECLARE SUB PRINTCalendar (Year%, Month%)
 DECLARE SUB PRINTDate ()
 DECLARE SUB PRINTError (Choice%, Nam%)
 DECLARE SUB PRINTF (Lin%, Col%, Color1%, Color2%, Text$)
 DECLARE SUB PRINTHelp (Help$)
 DECLARE SUB PRINTHelpMenu (Choice%)
 DECLARE SUB PRINTTime (Lin%, Col%, Color1%, Color2%)
 DECLARE SUB TBOX (Lin1%, Col1%, Lin2%, Col2%, PColor%, Title$, TCol%, TColor1%, TColor2%, Shadow%, MODE%)
 DECLARE SUB RECORD (OPERATION%)
 DECLARE SUB WORKBENCH (ScreenN%)
 DECLARE SUB WINDOWS (UL1%, UL2%, DR1%, DR2%, WNumber%, OPERATION%)
 DECLARE FUNCTION EditString$ (InString$, length%, NextField%)
 DECLARE FUNCTION FIND% (TopCard%, NumberOfRecords%)
 DECLARE FUNCTION GetKey% (CurrChoiceX%)
 DECLARE FUNCTION GetString$ (Lin%, Col%, Start$, END$, VIS%, Max%, currKey$)
 DECLARE FUNCTION IsLeapYear% (n%)
 DECLARE FUNCTION MENU% (CurrChoiceX%, MaxChoice%, Choice$(), ItemLin%(), ItemCol%(), Help$(), BarMode%, Wind%)
 DECLARE FUNCTION TestFile% ()
'Declarar todos os Arrays do programa como Dinamicos
'$DYNAMIC

'Declarar todas as variaveis de A a Z como numeros inteiros (Integer)
 DEFINT A-Z

'Declarar constantes utilizadas no programa
 CONST TRUE = -1, FALSE = NOT TRUE
 CONST CURSORON = 1, CURSOROFF = 0
 CONST SDW1 = 0, SDW2 = 1
 CONST ADD = 0, ZAP = 1, PRINTR = 2, PLIST = 3, SORT = 4, LOAD = 5, SAVE = 6
 CONST NNome = 0, NMorada = 1, NCPostal = 2, NInd = 3, NTel = 4, NFax = 5
 CONST NModem = 6, NDataDIA = 7, NDataMES = 8, NDataANO = 9, NFIELDS = NDataANO + 1
 CONST DataFilename$ = "AGENDA.DAT", ConfigFilename$ = "AGENDA.EXE", SeekPos = 160

'Declarar os tipos utilizados pelo programa
'Tipo para poder executar uma chamada … BIOS (CALL INTERRUPTX)
 TYPE REGISTERS
     AX            AS INTEGER
     BX            AS INTEGER
     CX            AS INTEGER
     DX            AS INTEGER
     BP            AS INTEGER
     SI            AS INTEGER
     DI            AS INTEGER
     FLAGS         AS INTEGER
     DS            AS INTEGER
     ES            AS INTEGER
 END TYPE

'Tipo que define o registo utilizado no programa
 TYPE IndexTYPE
    RecordNumber   AS INTEGER
    Nome           AS STRING * 40
    Morada         AS STRING * 38
    CPostal        AS STRING * 25
    Ind            AS STRING * 3
    Tel            AS STRING * 7
    Fax            AS STRING * 7
    Modem          AS STRING * 7
    DataDIA        AS STRING * 2
    DataMES        AS STRING * 2
    DataANO        AS STRING * 2
 END TYPE

'Tipo para os valores na captura das janelas (Carater, Cor)
 TYPE Wind
     CHR           AS INTEGER
     Cor           AS INTEGER
 END TYPE

'Tipo que ira conter os meses por extenso e os seus respectivos dias
 TYPE MonthType
   Number          AS INTEGER
   MName           AS STRING * 9
 END TYPE

'Tipo que ir  conter as directorias dos ficheiros AGENDA.DAT e .CFG
 TYPE DirType
   StrDir          AS STRING * 127
 END TYPE

ON ERROR GOTO ErrorHandler

'Reservar memขria para os v rios arrays e declara-los como publicos para
'todo as Subs e Functions do programa
 DIM SHARED INREG AS REGISTERS, OUTREG AS REGISTERS
 DIM SHARED Windw(1 TO 4, 1 TO 2000) AS Wind
 DIM SHARED RecordFile AS IndexTYPE, Index(1 TO 400) AS IndexTYPE
 DIM SHARED Colors(0 TO 17) AS INTEGER
 DIM SHARED MonthData(1 TO 12) AS MonthType
 DIM SHARED Choice$(6), MenuLin(6), MenuCol(6), Help$(6)
 DIM SHARED DOSDir AS DirType
 DIM SHARED NumberOfRecords AS INTEGER, RecordNumber AS INTEGER

'Apresentar o programa
 WORKBENCH 7
'Inicializar as cores, e restante configurao
 CONFIG
 
'Desligar o BLINK
 PRINT "A sua placa  EGA ou superior (S/N)?"
 DO: C$ = UCASE$(INKEY$): LOOP UNTIL C$ = "S" OR C$ = "N"
 IF C$ = "S" THEN
   INREG.AX = &H1003
   INREG.BX = 0
   CALL INTERRUPTX(&H10, INREG, OUTREG)
 ELSE
   OUT &H3D8, 9
 END IF
MenuHandler:

'Entrar na rotina principal do programa
 MenuSystem
   
'Restabelece a cor do DOS e sai do programa
ProgramEnd:
 COLOR 7, 0
 CLS
 PRINTF 1, 1, 15, 1, STRING$(80, 32)
 PRINTF 1, 1, 15, 1, " Agenda v1.1, Hugo Ferreira 1993."
 PRINT
 ON ERROR GOTO 0
 END

ErrorHandler:
  SELECT CASE ERR
         CASE 24, 25, 27, 68           ' Impressora
           WORKBENCH 11
           RESUME MenuHandler
         CASE 75, 76                   ' Path
           WORKBENCH 12
           RESUME ProgramEnd
         CASE 52, 53, 54, 55, 57, 58, 61, 63, 64, 67   ' Erros de I/O Disco
           WORKBENCH 13
           RESUME ProgramEnd
         CASE 71, 70
           WORKBENCH 14
           RESUME
         CASE ELSE
           GOTO ProgramEnd
  END SELECT

DATAMONTHS:
DATA Janeiro,  31, Fevereiro, 28, Maro,    31, Abril,    30
DATA Maio,     31, Junho,     30, Julho,    31, Agosto,   31
DATA Setembro, 30, Outubro,   31, Novembro, 30, Dezembro, 31

REM $STATIC
'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                   BOX                                   บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Dezenha uma caixa no ecra, atraves das coordenadas dadas pelo utilizadorบ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB BOX (Lin1, Col1, Lin2, Col2, Color1, Color2, BoxType, Shadow) STATIC
   
    SELECT CASE BoxType
      CASE 1: BT$ = "ÛÛÛÛÛÛÛ"
      CASE 2: BT$ = "       "
      CASE 3: BT$ = "ภฺูฟฤณ "
      CASE 4: BT$ = "ศผษปอบ "
    END SELECT
    
    IF Color2 <= 7 THEN Comp = 0 ELSE IF Color2 >= 8 THEN Comp = 16
    COLOR Color1 + Comp, Color2

    TAMANHO = Col2 - Col1 + 1

    LOCATE Lin1, Col1
    PRINT MID$(BT$, 3, 1) + STRING$(TAMANHO - 2, MID$(BT$, 5, 1)) + MID$(BT$, 4, 1);

    FOR a = Lin1 + 1 TO Lin2 - 1
        LOCATE a, Col1
        PRINT MID$(BT$, 6, 1) + STRING$(TAMANHO - 2, MID$(BT$, 7, 1)) + MID$(BT$, 6, 1);
        IF Shadow THEN
          COLOR 7, 0
          a$ = CHR$(SCREEN(a, Col2 + 1))
          B$ = CHR$(SCREEN(a, Col2 + 2))
          IF ASC(a$) >= 219 OR ASC(B$) >= 219 THEN a$ = CHR$(0): B$ = CHR$(0)
          PRINT a$ + B$;
          COLOR Color1 + Comp, Color2
        END IF
    NEXT a

    LOCATE Lin2, Col1
    PRINT MID$(BT$, 1, 1) + STRING$(TAMANHO - 2, MID$(BT$, 5, 1)) + MID$(BT$, 2, 1);
    IF Shadow THEN
      COLOR 7, 0
      a$ = CHR$(SCREEN(Lin2, Col2 + 1))
      B$ = CHR$(SCREEN(Lin2, Col2 + 2))
      IF ASC(a$) >= 219 OR ASC(B$) >= 219 THEN a$ = CHR$(0): B$ = CHR$(0)
      PRINT a$ + B$;
      COLOR Color1 + Comp, Color2
    END IF
     
    IF Shadow THEN
      COLOR 7, 0
      S$ = ""
      FOR V% = Col1 + 2 TO Col2 + 2
            a$ = CHR$(SCREEN(Lin2 + 1, V%))
            IF ASC(a$) >= 219 THEN a$ = CHR$(0)
            S$ = S$ + a$
      NEXT
      LOCATE Lin2 + 1, Col1 + 2
      PRINT S$;
    END IF


END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                 Center                                  บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Centra um texto na linha especificada.                                  บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB Center (Color1, Color2, Lin, Text$)
    IF Color2 <= 7 THEN Comp = 0 ELSE IF Color2 >= 8 THEN Comp = 16
    PRINTF Lin, 41 - LEN(Text$) \ 2, Color1, Color2, Text$
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                              COMPUTEMonth                               บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Calcula o primeiro dia do mes e o total de dias do mes.                 บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB COMPUTEMonth (Year, Month, StartDay, TotalDays) STATIC
SHARED MonthData() AS MonthType
CONST LEAP = 366 MOD 7
CONST NORMAL = 365 MOD 7
  
   NumDays = 0
   FOR I = 1899 TO Year - 1
      IF IsLeapYear(I) THEN
         NumDays = NumDays + LEAP
      ELSE
         NumDays = NumDays + NORMAL
      END IF
   NEXT

   
   FOR I = 1 TO Month - 1
      NumDays = NumDays + MonthData(I).Number
   NEXT

   TotalDays = MonthData(Month).Number

   IF IsLeapYear(Year) THEN

   IF Month > 2 THEN
         NumDays = NumDays + 1

      ELSEIF Month = 2 THEN
         TotalDays = TotalDays + 1

      END IF
   END IF

   StartDay = NumDays MOD 7
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                 CONFIG                                  บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Carrega o Array de cores do ficheiro de configuraao.                   บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB CONFIG STATIC
SHARED Path$
           OPEN ConfigFilename$ FOR INPUT AS #2
             SEEK #2, SeekPos
               FOR REC = 1 TO 17
                 INPUT #2, Colors(REC)
               NEXT REC
             INPUT #2, DOSDir.StrDir
             Path$ = RTRIM$(DOSDir.StrDir)
           CLOSE #2
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                  EDIT                                   บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Edita campo a campo um registo, para serem perfomadas as altera”es     บ
'บ necessarias.                                                            บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB EDIT (RecordVar AS IndexTYPE)

    WORKBENCH 9
    NextFlag = 1
  
    DO

    IF NextFlag = 11 THEN NextFlag = 1
    IF NextFlag = 0 THEN NextFlag = 10

     SELECT CASE NextFlag

       CASE 1
        LOCATE 6, 10
        RecordVar.Nome = UCASE$(EditString(RTRIM$(RecordVar.Nome), 40, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
      
       CASE 2
        LOCATE 8, 12
        RecordVar.Morada = UCASE$(EditString(RTRIM$(RecordVar.Morada), 38, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB

       CASE 3
        LOCATE 10, 19
        RecordVar.CPostal = UCASE$(EditString(RTRIM$(RecordVar.CPostal), 25, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
   
       CASE 4
        LOCATE 12, 16
        RecordVar.Ind = UCASE$(EditString(RTRIM$(RecordVar.Ind), 3, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB

       CASE 5
        LOCATE 12, 38
        RecordVar.Tel = UCASE$(EditString(RTRIM$(RecordVar.Tel), 7, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
   
       CASE 6
        LOCATE 14, 9
        RecordVar.Fax = UCASE$(EditString(RTRIM$(RecordVar.Fax), 7, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
   
       CASE 7
        LOCATE 14, 34
        RecordVar.Modem = UCASE$(EditString(RTRIM$(RecordVar.Modem), 7, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
    
       CASE 8
        LOCATE 16, 24
        RecordVar.DataDIA = UCASE$(EditString(RTRIM$(RecordVar.DataDIA), 2, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
      
       CASE 9
        LOCATE 16, 28
        RecordVar.DataMES = UCASE$(EditString(RTRIM$(RecordVar.DataMES), 2, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
    
       CASE 10
        LOCATE 16, 32
        RecordVar.DataANO = UCASE$(EditString(RTRIM$(RecordVar.DataANO), 2, NextFlag))
        IF NextFlag = FALSE THEN EXIT SUB
      
       CASE ELSE
        NextFlag = 0
    END SELECT
 
    LOOP

END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                EditString$                              บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Edita uma cadeia.                                                       บ
'บ                                                                         บ
'บ Esta rotina permite todas as funoes de ediao, como:                   บ
'บ Del - Apaga o caracter na posiao do cursor.                            บ
'บ Ins - Insere um caracter na posiao do cursor.                          บ
'บ BackSpace - Apaga o ultimo caracter da cadeia.                          บ
'บ Home - Vai para o principio da cadeia.                                  บ
'บ End - Vai para o fim da cadeia.                                         บ
'บ Esc - Faz um UNDO as alteraoes feitas.                                 บ
'บ Teclas cursoras - Permitem deslocaao dentro da cadeia e para outras    บ
'บ cadeias.                                                                บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION EditString$ (InString$, length, NextField)
STATIC INSERT

    COLOR Colors(13), Colors(7)
    Work$ = InString$: Row = CSRLIN: Column = POS(0)
    FirstTime = TRUE: P = LEN(Work$): MaxP = P
   
    PRINT SPACE$(length);
   
    IF INSERT THEN
       LOCATE Row, Column, CURSORON, 6, 7
    ELSE
       LOCATE Row, Column, CURSORON, 0, 7
    END IF
   
    COLOR Colors(13), Colors(14)
    PRINT Work$;

    DO
      DO
        Choice$ = INKEY$
      LOOP WHILE Choice$ = ""
       
      IF LEN(Choice$) = 2 THEN
             Choice$ = RIGHT$(Choice$, 1)
             SELECT CASE Choice$
                    CASE CHR$(75): Choice$ = CHR$(19)
                    CASE CHR$(77): Choice$ = CHR$(4)
                    CASE CHR$(82): Choice$ = CHR$(22)
                    CASE CHR$(83): Choice$ = CHR$(7)
                    CASE CHR$(71): P = 0: Choice$ = CHR$(NULL)
                    CASE CHR$(79): P = MaxP: Choice$ = CHR$(NULL)
                    CASE CHR$(80): NextField = NextField + 1: EXIT DO
                    CASE CHR$(72): NextField = NextField - 1: EXIT DO
                    CASE CHR$(68): NextField = FALSE: EXIT DO
                    CASE ELSE: Choice$ = CHR$(1)
            END SELECT
      END IF

            SELECT CASE ASC(Choice$)
                   CASE NULL
                   CASE 13
                        IF NextField THEN
                           NextField = NextField + 1
                           EXIT DO
                         ELSE
                           SOUND 1000, 1
                        END IF
                   CASE 27
                        Work$ = InString$
                        LOCATE Row, Column, CURSOROFF
                        PRINT SPACE$(MaxP)
                        EXIT DO
                   CASE 19
                        IF P > 0 THEN
                           P = P - 1
                           LOCATE , P + Column
                         ELSE
                           SOUND 1000, 1
                        END IF
                   CASE 4
                        IF P < MaxP THEN
                           P = P + 1
                           LOCATE , P + Column
                         ELSE
                           SOUND 1000, 1
                        END IF
                   CASE 7
                        IF P < MaxP THEN
                           Work$ = LEFT$(Work$, P) + RIGHT$(Work$, MaxP - P - 1)
                           MaxP = MaxP - 1
                         ELSE
                           SOUND 1000, 1
                        END IF
                   CASE 8, 127
                        IF P > 0 THEN
                           Work$ = LEFT$(Work$, P - 1) + RIGHT$(Work$, MaxP - P)
                           P = P - 1
                           MaxP = MaxP - 1
                        END IF
                   CASE 22
                        INSERT = NOT INSERT
                        IF INSERT THEN
                           LOCATE , , , 6, 7
                         ELSE
                           LOCATE , , , 0, 7
                        END IF
                   CASE IS >= 32
                        IF FirstTime THEN
                           LOCATE , Column
                           COLOR Colors(13), Colors(7)
                           PRINT SPACE$(MaxP);
                           LOCATE , Column
                           P = 0: MaxP = P
                           Work$ = ""
                        END IF

                IF INSERT THEN
                    IF MaxP < length THEN
                        Work$ = LEFT$(Work$, P) + Choice$ + RIGHT$(Work$, MaxP - P)
                        MaxP = MaxP + 1
                        P = P + 1
                    ELSE
                        SOUND 1000, 1
                    END IF

                ELSE
                    IF P = MaxP THEN
                        IF MaxP < length THEN
                            Work$ = Work$ + Choice$
                            MaxP = MaxP + 1
                            P = P + 1
                        ELSE
                            SOUND 1000, 1
                        END IF

                    ELSE
                        MID$(Work$, P + 1, 1) = Choice$
                        P = P + 1
                    END IF
                END IF

            CASE ELSE
                SOUND 1000, 1
        END SELECT
  
        COLOR Colors(13), Colors(7)
        LOCATE Row, Column, CURSOROFF
        PRINT Work$ + " "
        LOCATE Row, Column + P, CURSORON
        FirstTime = FALSE
       
    LOOP

    COLOR Colors(13), Colors(7)
    LOCATE Row, Column, CURSOROFF
    PRINT Work$;
    EditString$ = Work$
    LOCATE Row, Column

END FUNCTION

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                               FindRecord                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Encontra um registo em memoria, atraves de uma comparaao do registo    บ
'บ a ser analisado, com o registo corrente nesse momento.                  บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION FIND% (TopCard%, NumberOfRecords%)
SHARED Index() AS IndexTYPE
STATIC TmpRecord AS IndexTYPE, NotFirst


    IF NotFirst = FALSE THEN
        TmpRecord.Nome = ""
        TmpRecord.Morada = ""
        TmpRecord.CPostal = ""
        TmpRecord.Ind = ""
        TmpRecord.Tel = ""
        TmpRecord.Fax = ""
        TmpRecord.Modem = ""
        TmpRecord.DataDIA = ""
        TmpRecord.DataMES = ""
        TmpRecord.DataANO = ""
        NotFirst = TRUE
    END IF

    
    PRINTF 6, 10, Colors(13), Colors(7), TmpRecord.Nome
    PRINTF 8, 12, Colors(13), Colors(7), TmpRecord.Morada
    PRINTF 10, 19, Colors(13), Colors(7), TmpRecord.CPostal
    PRINTF 12, 16, Colors(13), Colors(7), TmpRecord.Ind
    PRINTF 12, 38, Colors(13), Colors(7), TmpRecord.Tel
    PRINTF 14, 9, Colors(13), Colors(7), TmpRecord.Fax
    PRINTF 14, 34, Colors(13), Colors(7), TmpRecord.Modem
    PRINTF 16, 24, Colors(13), Colors(7), TmpRecord.DataDIA
    PRINTF 16, 28, Colors(13), Colors(7), TmpRecord.DataMES
    PRINTF 16, 32, Colors(13), Colors(7), TmpRecord.DataANO
     
    EDIT TmpRecord

    Card = TopCard
    DO
       
        Card = Card + 1
        IF Card > NumberOfRecords THEN Card = 1
        Found = 0
   
        SELECT CASE RTRIM$(UCASE$(TmpRecord.Nome))
            CASE "", RTRIM$(UCASE$(Index(Card).Nome))
                Found = Found + 1
            CASE ELSE
        END SELECT
                             
        SELECT CASE RTRIM$(UCASE$(TmpRecord.Morada))
            CASE "", RTRIM$(UCASE$(Index(Card).Morada))
                Found = Found + 1
            CASE ELSE
        END SELECT
                             
        SELECT CASE RTRIM$(UCASE$(TmpRecord.CPostal))
            CASE "", RTRIM$(UCASE$(Index(Card).CPostal))
                Found = Found + 1
            CASE ELSE
        END SELECT
                            
        SELECT CASE RTRIM$(UCASE$(TmpRecord.Ind))
            CASE "", RTRIM$(UCASE$(Index(Card).Ind))
                Found = Found + 1
            CASE ELSE
        END SELECT
                           
        SELECT CASE RTRIM$(UCASE$(TmpRecord.Tel))
            CASE "", RTRIM$(UCASE$(Index(Card).Tel))
                Found = Found + 1
            CASE ELSE
        END SELECT
                            
        SELECT CASE RTRIM$(UCASE$(TmpRecord.Fax))
            CASE "", RTRIM$(UCASE$(Index(Card).Fax))
                Found = Found + 1
            CASE ELSE
        END SELECT
                            
        SELECT CASE RTRIM$(UCASE$(TmpRecord.Modem))
            CASE "", RTRIM$(UCASE$(Index(Card).Modem))
                Found = Found + 1
            CASE ELSE
        END SELECT
                           
        SELECT CASE RTRIM$(UCASE$(TmpRecord.DataDIA))
            CASE "", RTRIM$(UCASE$(Index(Card).DataDIA))
                Found = Found + 1
            CASE ELSE
        END SELECT
                          
        SELECT CASE RTRIM$(UCASE$(TmpRecord.DataMES))
            CASE "", RTRIM$(UCASE$(Index(Card).DataMES))
                Found = Found + 1
            CASE ELSE
        END SELECT
                          
        SELECT CASE RTRIM$(UCASE$(TmpRecord.DataANO))
            CASE "", RTRIM$(UCASE$(Index(Card).DataANO))
                Found = Found + 1
            CASE ELSE
        END SELECT
                          
    
        IF Found = NFIELDS THEN
        
            FIND% = Card
            EXIT FUNCTION
        END IF

    LOOP UNTIL Card = TopCard

    FIND% = FALSE

END FUNCTION

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                  GetKey                                 บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Retorna as teclas premidas a fim de permitir saber qual foi a opao     บ
'บ pretendida.                                                             บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION GetKey (CurrChoiceX)

    currChoice = CurrChoiceX
    finished = FALSE

    WHILE NOT finished
        GOSUB FGETKGetKey
       
        SELECT CASE kbd$
            CASE CHR$(0) + "H": GOSUB FGETKUp
            CASE CHR$(0) + "P": GOSUB FGETKDown
            CASE CHR$(0) + "M": GOSUB FGETKLeft
            CASE CHR$(0) + "K": GOSUB FGETKRight
            CASE CHR$(0) + "G": GOSUB FGETKHOME
            CASE CHR$(0) + "O": GOSUB FGETKEND
            CASE CHR$(0) + "I": GOSUB FGETKPgUP
            CASE CHR$(0) + "Q": GOSUB FGETKPgDOWN
            CASE CHR$(13): GOSUB FGETKEnter
            CASE CHR$(27): GOSUB FGETKEscape
            CASE ELSE:  SOUND 1000, 1
        END SELECT
    WEND

    GetKey = currChoice

    EXIT FUNCTION


FGETKEnter:
    finished = TRUE
    RETURN

FGETKEscape:
    currChoice = 0
    finished = TRUE
    RETURN
FGETKUp:
    currChoice = 1
    finished = TRUE
    RETURN
FGETKLeft:
    currChoice = 2
    finished = TRUE
    RETURN
FGETKRight:
    currChoice = 3
    finished = TRUE
    RETURN
FGETKDown:
    currChoice = 4
    finished = TRUE
    RETURN
FGETKPgUP:
    currChoice = 5
    finished = TRUE
    RETURN
FGETKHOME:
    currChoice = 6
    finished = TRUE
    RETURN
FGETKEND:
    currChoice = 7
    finished = TRUE
    RETURN
FGETKPgDOWN:
    currChoice = 8
    finished = TRUE
    RETURN

FGETKGetKey:
    kbd$ = ""
    WHILE kbd$ = ""
        IF Colors(7) <= 7 THEN Comp = 0 ELSE IF Colors(7) >= 8 THEN Comp = 16
        PRINTTime 14, 57, Colors(11) + Comp, Colors(7)
        kbd$ = INKEY$
    WEND
    RETURN

END FUNCTION

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                GetString$                               บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Edita uma cadeia especificada. Tem a possibilidade de editar uma cadeia บ
'บ num sistema tipo janela.                                                บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION GetString$ (Lin, Col, Start$, END$, VIS, Max, currKey$)
   
    curr$ = RTRIM$(LEFT$(Start$, Max))
    IF curr$ = CHR$(8) THEN curr$ = ""
   
    IF INSERT THEN
       LOCATE Lin, Col, CURSORON, 6, 7
    ELSE
       LOCATE Lin, Col, CURSORON, 0, 7
    END IF

    finished = FALSE
    DO
        GOSUB GetStringShowText
        GOSUB GetStringGetKey

       
        IF LEN(kbd$) > 1 THEN
            finished = TRUE
            GetString$ = curr$
            currKey$ = kbd$
        ELSE
            SELECT CASE kbd$
                CASE CHR$(13), CHR$(27), CHR$(9)
                    finished = TRUE
                    GetString$ = curr$
                    currKey$ = kbd$
                CASE CHR$(8)
                    IF curr$ <> "" THEN
                        curr$ = LEFT$(curr$, LEN(curr$) - 1)
                    END IF

                CASE " " TO "}"
                    IF LEN(curr$) < Max THEN
                        curr$ = curr$ + kbd$
                    ELSE
                        BEEP
                    END IF

                CASE ELSE
                    BEEP
            END SELECT
        END IF

    LOOP UNTIL finished

    END$ = curr$
    LOCATE , , 0
    EXIT FUNCTION
    

GetStringShowText:
    LOCATE Lin, Col
    IF LEN(curr$) > VIS THEN
        PRINT RIGHT$(curr$, VIS);
    ELSE
        PRINT curr$; SPACE$(VIS - LEN(curr$));
        LOCATE Lin, Col + LEN(curr$)
    END IF
    RETURN

GetStringGetKey:
    kbd$ = ""
    WHILE kbd$ = ""
        kbd$ = INKEY$
    WEND
    RETURN
END FUNCTION

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                               IsLeapYear                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Determina se uma ano e bissexto ou nao.                                 บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION IsLeapYear (n) STATIC
  IsLeapYear = (n MOD 4 = 0 AND n MOD 100 <> 0) OR (n MOD 400 = 0)
END FUNCTION

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                               LPrintSystem                              บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Sistema que controla as rotinas de impressao.                           บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB LPRINTSystem (Choice%, REC%, RecordFile() AS IndexTYPE, NumberOfRecords%) STATIC

   PRINTHelp "Continuar com a impressao (S/N)?"
   SOUND 1000, 1
   DO
     C$ = UCASE$(INKEY$)
   LOOP UNTIL C$ = "S" OR C$ = "N"
     IF C$ = "N" THEN EXIT SUB
     o$ = "AGENDA v1.1, por Hugo Ferreira, 1993."
     LPRINT
     SELECT CASE Choice%
            CASE 1
              S$ = SPACE$(5)
              LPRINT S$ + o$
              LPRINT S$ + "REGISTO:"; REC; SPACE$(27);
              LPRINT MID$(DATE$, 4, 3) + LEFT$(DATE$, 3) + RIGHT$(DATE$, 4)
              LPRINT S$ + STRING$(50, 205)
              LPRINT S$ + "Nome: "; RecordFile(REC).Nome
              LPRINT S$ + "Morada: "; RecordFile(REC).Morada
              LPRINT S$ + "Codigo Postal :"; RecordFile(REC).CPostal
              LPRINT S$ + "Indicativo: "; RecordFile(REC).Ind; SPACE$(10);
              LPRINT S$ + "Telefone: "; RecordFile(REC).Tel
              LPRINT S$ + "Fax: "; RecordFile(REC).Fax; SPACE$(10)
              LPRINT S$ + "Modem: "; RecordFile(REC).Modem
              LPRINT S$ + "Data de nascimento: "; RecordFile(REC).DataDIA;
              LPRINT "/"; RecordFile(REC).DataMES; "/"; RecordFile(REC).DataANO
              LPRINT S$ + STRING$(50, 205)
            CASE 2
              S$ = "ณ"
              LPRINT o$
              LPRINT SPACE$(58) + MID$(DATE$, 4, 3) + LEFT$(DATE$, 3) + RIGHT$(DATE$, 4)
              LPRINT "ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤ"
              LPRINT "  Nome                                  ณIndณTelefonณModem  ณReg."
              LPRINT "ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤลฤฤฤฤฤฤฤลฤฤฤฤฤฤฤลฤฤฤฤ"
              FOR R = 1 TO NumberOfRecords
                LPRINT RecordFile(R).Nome + S$ + RecordFile(R).Ind + S$ + RecordFile(R).Tel + S$ + RecordFile(R).Modem + S$ + STR$(R)
              NEXT R
            CASE 3
              LPRINT S$ + RecordFile(REC).Nome
              LPRINT S$ + RecordFile(REC).Morada
              LPRINT S$ + RecordFile(REC).CPostal
            CASE ELSE
     END SELECT
EXIT SUB
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                  Menu                                   บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Retorna o numero da escolha feita mudando CurrChoiceX e retorna o SCAN  บ
'บ Code da tecla que foi premida para sair.                                บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION MENU (CurrChoiceX, MaxChoice, Choice$(), ItemLin(), ItemCol(), Help$(), BarMode, Wind)
SHARED AX, BX, CX, DX

    currChoice = CurrChoiceX
    MenuBar$ = "  SISTEMA    EDITAR    PROCURAR    IMPRIMIR    CONSULTAR "

    IF NOT BarMode THEN
        
        PRINTF 2, 1, Colors(1), Colors(3), MenuBar$
        WINDOWS ItemLin(1) - 1, ItemCol(1) - 1, ItemLin(MaxChoice) + 2, ItemCol(1) + LEN(Choice$(1)) + 3, Wind, CURSORON
        BOX ItemLin(1) - 1, ItemCol(1) - 1, ItemLin(MaxChoice) + 1, ItemCol(1) + LEN(Choice$(1)) + 1, Colors(1), Colors(3), 3, TRUE

    END IF
   
    IF Colors(3) <= 7 THEN Comp = 0 ELSE IF Colors(3) >= 8 THEN Comp = 16
    COLOR Colors(1) + Comp, Colors(3)
    FOR a = 1 TO MaxChoice
        LOCATE ItemLin(a), ItemCol(a)
        PRINT Choice$(a);
    NEXT a
   
    finished = FALSE

    WHILE NOT finished
        
        GOSUB MenuShowCursor
        GOSUB MenuGetKey
        GOSUB MenuHideCursor

        SELECT CASE kbd$
            CASE CHR$(0) + "H": GOSUB MenuUp
            CASE CHR$(0) + "P": GOSUB MenuDown
            CASE CHR$(0) + "K": GOSUB MenuLeft
            CASE CHR$(0) + "M": GOSUB MenuRight
            CASE CHR$(13): GOSUB MenuEnter
            CASE CHR$(27): GOSUB MenuEscape
            CASE ELSE:  SOUND 1000, 1
        END SELECT
    WEND

    MENU = currChoice

    EXIT FUNCTION


MenuEnter:
    finished = TRUE
    RETURN

MenuEscape:
    IF BarMode THEN
        
    ELSE
     currChoice = 0
     WINDOWS ItemLin(1) - 1, ItemCol(1) - 1, ItemLin(MaxChoice) + 2, ItemCol(1) + LEN(Choice$(1)) + 3, Wind, CURSOROFF
     finished = TRUE
     RETURN
    END IF

MenuUp:
    IF BarMode THEN
        BEEP
    ELSE
        currChoice = (currChoice + MaxChoice - 2) MOD MaxChoice + 1
    END IF
    RETURN

MenuLeft:
    IF BarMode THEN
        currChoice = (currChoice + MaxChoice - 2) MOD MaxChoice + 1
    ELSE
        currChoice = -2
        WINDOWS ItemLin(1) - 1, ItemCol(1) - 1, ItemLin(MaxChoice) + 2, ItemCol(1) + LEN(Choice$(1)) + 3, Wind, CURSOROFF
        finished = TRUE
    END IF
    RETURN

MenuRight:
    IF BarMode THEN
        currChoice = (currChoice) MOD MaxChoice + 1
    ELSE
        currChoice = -3
        WINDOWS ItemLin(1) - 1, ItemCol(1) - 1, ItemLin(MaxChoice) + 2, ItemCol(1) + LEN(Choice$(1)) + 3, Wind, CURSOROFF
        finished = TRUE
    END IF
    RETURN

MenuDown:
    IF BarMode THEN
        finished = TRUE
    ELSE
        currChoice = (currChoice) MOD MaxChoice + 1
    END IF
    RETURN

MenuShowCursor:
    PRINTF ItemLin(currChoice), ItemCol(currChoice), Colors(1), Colors(2), Choice$(currChoice)
    PRINTHelp Help$(currChoice)
    RETURN

MenuGetKey:
    kbd$ = ""
    WHILE kbd$ = ""
        kbd$ = INKEY$
        IF Colors(7) <= 7 THEN Comp = 0 ELSE IF Colors(7) >= 8 THEN Comp = 16
        PRINTTime 14, 57, Colors(11) + Comp, Colors(7)
    WEND
    RETURN
         
MenuHideCursor:
    PRINTF ItemLin(currChoice), ItemCol(currChoice), Colors(1), Colors(3), Choice$(currChoice)
    RETURN
END FUNCTION

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                 MenuSystem                              บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Rotina que principal que controla o programa.                           บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB MenuSystem STATIC
     
    LOCATE , , 0
    Choice = 1
    finished = FALSE: FIRST = TRUE: SECOND = TRUE

    PRINTF 25, 1, Colors(14), Colors(15), SPACE$(80)
    PRINTF 1, 1, 15, 1, SPACE$(80)
    PRINTF 2, 1, Colors(2), Colors(3), SPACE$(80)
    Center 15, 1, 1, "AGENDA v1.1, por Hugo Ferreira, 1993."
   
    FOR B% = 3 TO 24
    PRINTF B%, 1, Colors(17), Colors(17), STRING$(80, 219)
    NEXT
   
    NumberOfRecords = 0
    RECORD LOAD
    RecordNumber = 1
BEGIN:
    WORKBENCH 1
    GOSUB MenuSystemPrintRecord
    WHILE NOT finished
      GOSUB MenuSystemMain
      SubChoice = -1
        WHILE SubChoice < 0
          SELECT CASE Choice
                 CASE 1: GOSUB MenuSystemWindow1
                 CASE 2: GOSUB MenuSystemWindow2
                 CASE 3: GOSUB MenuSystemWindow3
                 CASE 4: GOSUB MenuSystemWindow4
                 CASE 5: GOSUB MenuSystemWindow5
          END SELECT
           
          SELECT CASE SubChoice
                 CASE -2: Choice = (Choice + 3) MOD 5 + 1
                 CASE -3: Choice = (Choice) MOD 5 + 1
          END SELECT
        WEND
    WEND
    EXIT SUB


MenuSystemMain:

    Choice$(1) = " SISTEMA "
    Choice$(2) = " EDITAR "
    Choice$(3) = " PROCURAR "
    Choice$(4) = " IMPRIMIR "
    Choice$(5) = " CONSULTAR "
   
    MenuLin(1) = 2: MenuCol(1) = 2
    MenuLin(2) = 2: MenuCol(2) = 13
    MenuLin(3) = 2: MenuCol(3) = 23
    MenuLin(4) = 2: MenuCol(4) = 35
    MenuLin(5) = 2: MenuCol(5) = 47
   
    Help$(1) = "Sai para o menu anterior"
    Help$(2) = "Edita/Adiciona/Apaga registos"
    Help$(3) = "Localiza e procura registos"
    Help$(4) = "Imprime registos"
    Help$(5) = "Consulta registo a registo ou por lista de registos"
   
    PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
    DO
      NewChoice = MENU((Choice), 5, Choice$(), MenuLin(), MenuCol(), Help$(), TRUE, 1)
    LOOP WHILE NewChoice = 0
    Choice = NewChoice
    
    RETURN

MenuSystemWindow1:
   
    Choice$(1) = " Informaoes "
    Choice$(2) = " DOS Shell   "
    Choice$(3) = " Sair/DOS    "
   
    MenuLin(1) = 4: MenuCol(1) = 3
    MenuLin(2) = 5: MenuCol(2) = 3
    MenuLin(3) = 6: MenuCol(3) = 3

    Help$(1) = "Informaoes sobre o programa e o autor."
    Help$(2) = "Executa um Shell ao DOS."
    Help$(3) = "Termina programa e sai para o DOS."
    
    PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
    
    SubChoice = MENU(1, 3, Choice$(), MenuLin(), MenuCol(), Help$(), FALSE, 1)
    WINDOWS MenuLin(1) - 1, MenuCol(1) - 1, MenuLin(3) + 2, MenuCol(1) + LEN(Choice$(1)) + 3, 1, CURSOROFF
   
    SELECT CASE SubChoice
           CASE 1: WORKBENCH 6: BarMode = TRUE
           CASE 2: GOSUB MenuSystemFileShell
           CASE 3: finished = TRUE
           CASE ELSE
    END SELECT
  RETURN

MenuSystemWindow2:
    Choice$(1) = " Editar    "
    Choice$(2) = " Adicionar "
    Choice$(3) = " Apagar    "
   
    MenuLin(1) = 4: MenuCol(1) = 14
    MenuLin(2) = 5: MenuCol(2) = 14
    MenuLin(3) = 6: MenuCol(3) = 14
    
    Help$(1) = "Edita os registos"
    Help$(2) = "Adiciona registos"
    Help$(3) = "Apaga registos   "

    PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
    
    SubChoice = MENU(1, 3, Choice$(), MenuLin(), MenuCol(), Help$(), FALSE, 1)
    WINDOWS MenuLin(1) - 1, MenuCol(1) - 1, MenuLin(2) + 3, MenuCol(1) + LEN(Choice$(1)) + 3, 1, CURSOROFF
    WINDOWS 4, 56, 23, 79, 2, CURSORON
   
    SELECT CASE SubChoice
           CASE 1
             Number = Index(RecordNumber).RecordNumber
             IF Number = 0 THEN
               RECORD SAVE
               Number = Index(RecordNumber).RecordNumber
               IF Number <= 0 THEN Number = 1
             END IF
             GOSUB MenuSystemPrintRecord
             PRINTHelp "F10 para ACEITAR."
             EDIT Index(RecordNumber)
             PUT #1, Number, Index(RecordNumber)
             RECORD SORT
             TopCard = RecordNumber
             WINDOWS 4, 56, 23, 79, 2, CURSOROFF
             GOSUB MenuSystemPrintRecord
      
           CASE 2
             IF NumberOfRecords = 400 THEN
               SOUND 1000, 1
               PRINTHelp "O ficheiro atingiu o limite de registos!"
             ELSE
               RECORD ADD
               WINDOWS 4, 56, 23, 79, 2, CURSOROFF
               GOSUB MenuSystemPrintRecord
             END IF
      
           CASE 3
             PRINTHelp "Tem a certeza de quer APAGAR este registo (S/N)?"
             SOUND 1000, 1
             a$ = INPUT$(1)
             IF UCASE$(a$) = "S" THEN
               RECORD ZAP
               RECORD SORT
               NumberOfRecords = NumberOfRecords - 1
               RECORD SAVE
               GOSUB MenuSystemPrintRecord
              ELSE
              END IF
       
            CASE ELSE
    END SELECT
    PRINTF 10, 64, 9, Colors(7), STR$(LOF(1))
RETURN

MenuSystemWindow3:

    Choice$(1) = " Procurar "
    Choice$(2) = " Ir Para  "
   
    MenuLin(1) = 4: MenuCol(1) = 24
    MenuLin(2) = 5: MenuCol(2) = 24
   
    Help$(1) = "Procura um determinado registo, escolhido pelo utilizador"
    Help$(2) = "Vai para o registo numero..."
    
    PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
    
    SubChoice = MENU(1, 2, Choice$(), MenuLin(), MenuCol(), Help$(), FALSE, 1)

    WINDOWS MenuLin(1) - 1, MenuCol(1) - 1, MenuLin(2) + 2, MenuCol(1) + LEN(Choice$(1)) + 3, 1, CURSOROFF
    Cartao = RecordNumber
    WINDOWS 4, 56, 23, 79, 3, CURSORON
    SELECT CASE SubChoice
           CASE 1
             WORKBENCH 2
             RecordNumber = FIND%(1, NumberOfRecords)
             IF RecordNumber THEN
               TopCard = RecordNumber
             ELSE
               PRINTHelp "Registo no encontrado"
               SOUND 1000, 1
               WHILE INKEY$ = "": WEND
               RecordNumber = Cartao
             END IF
             WINDOWS 4, 56, 23, 79, 3, CURSOROFF
             GOSUB MenuSystemPrintRecord
           CASE 2
             PRINTF 5, 64, Colors(9), Colors(7), "   "
             PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
             erro = FALSE
             E$ = GetString$(5, 65, "", d$, 3, 3, currKey$)
             FOR F = 1 TO LEN(d$)
               IF ASC(MID$(d$, 1, F)) < 48 OR ASC(MID$(d$, 1, F)) > 97 THEN erro = TRUE
             NEXT
             IF VAL(d$) < 1 OR VAL(d$) > 300 THEN RecordNumber = NumberOfRecords
             IF erro THEN
               SOUND 1000, 1
               PRINTHelp "NUMERO DE REGISTO INVALIDO"
               SLEEP 1
             ELSE
               RecordNumber = VAL(d$)
             END IF
             WINDOWS 4, 56, 23, 79, 3, CURSOROFF
             GOSUB MenuSystemPrintRecord
           CASE ELSE
    END SELECT
RETURN

MenuSystemWindow4:
    Choice$(1) = " Registo    "
    Choice$(2) = " Lista      "
    Choice$(3) = " Morada     "
   
    MenuLin(1) = 4: MenuCol(1) = 36
    MenuLin(2) = 5: MenuCol(2) = 36
    MenuLin(3) = 6: MenuCol(3) = 36
    
    Help$(1) = "Imprime o registo actual"
    Help$(2) = "Imprime a lista de todos os registos da base"
    Help$(4) = "Imprime a morada do registo"
   
    PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
    
    SubChoice = MENU(1, 3, Choice$(), MenuLin(), MenuCol(), Help$(), FALSE, 1)
    WINDOWS MenuLin(1) - 1, MenuCol(1) - 1, MenuLin(3) + 2, MenuCol(1) + LEN(Choice$(1)) + 3, 1, CURSOROFF
    
    SELECT CASE SubChoice
           CASE 1: LPRINTSystem 1, RecordNumber, Index(), NumberOfRecords%
           CASE 2: LPRINTSystem 2, RecordNumber, Index(), NumberOfRecords%
           CASE 3: LPRINTSystem 3, RecordNumber, Index(), NumberOfRecords%
           CASE ELSE
    END SELECT
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemWindow5:
   
    Choice$(1) = " Registo a Registo "
    Choice$(2) = " Lista de Registos "

    MenuLin(1) = 4: MenuCol(1) = 48
    MenuLin(2) = 5: MenuCol(2) = 48

    Help$(1) = "Consulta registo a registo"
    Help$(2) = "Consultar lista de registos"
   
    PRINTF 6, 64, Colors(9), Colors(7), STR$(NumberOfRecords%) + " "
    
    SubChoice = MENU(1, 2, Choice$(), MenuLin(), MenuCol(), Help$(), FALSE, 1)
    WINDOWS MenuLin(1) - 1, MenuCol(1) - 1, MenuLin(2) + 2, MenuCol(1) + LEN(Choice$(1)) + 3, 1, CURSOROFF
    WINDOWS 4, 54, 16, 79, 3, CURSORON
    SELECT CASE SubChoice
           CASE 1
             DO
               SubChoice = GetKey(Choice%)
               SELECT CASE SubChoice
                      CASE 0:  EXIT DO
                      CASE 1: GOSUB MenuSystemKeyLEFT
                      CASE 2: GOSUB MenuSystemKeyRIGHT
                      CASE 3: GOSUB MenuSystemKeyLEFT
                      CASE 4: GOSUB MenuSystemKeyRIGHT
                      CASE 5: GOSUB MenuSystemKeyPgUp
                      CASE 6: GOSUB MenuSystemKeyHome
                      CASE 7: GOSUB MenuSystemKeyEnd
                      CASE 8: GOSUB MenuSystemKeyPgDown
                      CASE ELSE
               END SELECT
             LOOP
             WINDOWS 4, 54, 16, 79, 3, CURSOROFF
             GOSUB MenuSystemPrintRecord
          
           CASE 2
             WINDOWS 4, 3, 23, 53, 2, CURSORON
             RECORD PLIST
             WINDOWS 4, 54, 16, 79, 3, CURSOROFF
             WINDOWS 4, 3, 23, 53, 2, CURSOROFF
             GOSUB MenuSystemPrintRecord
          
           CASE ELSE
    END SELECT
  RETURN

MenuSystemKeyLEFT:
    RecordNumber = RecordNumber - 1
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemKeyRIGHT:
    RecordNumber = RecordNumber + 1
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemKeyHome:
    RecordNumber = 1
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemKeyEnd:
    RecordNumber = NumberOfRecords
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemKeyPgUp:
    RecordNumber = RecordNumber - 10
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemKeyPgDown:
    RecordNumber = RecordNumber + 10
    GOSUB MenuSystemPrintRecord
RETURN

MenuSystemPrintRecord:
    IF NumberOfRecords <= 0 THEN RecordNumber = 1: NumberOfRecords = 1
    IF RecordNumber <= 0 THEN RecordNumber = 1
    IF RecordNumber > NumberOfRecords THEN RecordNumber = NumberOfRecords
    RECORD PRINTR
RETURN

MenuSystemFileShell:
 WINDOWS 1, 1, 25, 80, 4, CURSORON
 COLOR 7, 0: CLS
 PRINTF 1, 1, 15, 1, STRING$(80, 32)
 PRINTF 1, 1, 15, 1, " Agenda v1.1, Hugo Ferreira 1993."
 PRINTF 3, 2, 15, 0, "Digite EXIT para retornar … Agenda."
 COLOR 7, 0
 SHELL
 WINDOWS 1, 1, 25, 80, 4, CURSOROFF
 PRINTCalendar VAL(RIGHT$(DATE$, 4)), VAL(LEFT$(DATE$, 2))
RETURN
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                              PrintCalendar                              บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime um calend rio formatado de um determinado dia e ms             บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTCalendar (Year, Month) STATIC
SHARED MonthData() AS MonthType
  
   COMPUTEMonth Year, Month, StartDay, TotalDays
   Header$ = MID$(DATE$, 4, 2) + " " + RTRIM$(MonthData(Month).MName) + "," + STR$(Year)
   LeftMargin = (35 - LEN(Header$)) \ 2

   
   PRINTF 15, 57, Colors(12), Colors(7), Header$
   PRINTF 16, 57, Colors(10), Colors(7), "DO SE TE QU QU SX SA"
  
   IF StartDay = 0 THEN LeftMargin = 56
   IF StartDay = 1 THEN LeftMargin = 59
   IF StartDay = 2 THEN LeftMargin = 62
   IF StartDay = 3 THEN LeftMargin = 65
   IF StartDay = 4 THEN LeftMargin = 68
   IF StartDay = 5 THEN LeftMargin = 71
   IF StartDay = 6 THEN LeftMargin = 74
   IF StartDay = 7 THEN LeftMargin = 77
  
   LOCATE 17, LeftMargin
   IF Colors(7) <= 7 THEN Comp = 0 ELSE IF Colors(7) >= 8 THEN Comp = 16
   a = 17: COLOR Colors(9) + Comp, Colors(7)
   
   FOR I = 1 TO TotalDays
      IF I = VAL(MID$(DATE$, 4, 2)) THEN
        IF Colors(9) = 11 THEN
          COLOR 14 + Comp, Colors(7)
        ELSE
          COLOR 11 + Comp, Colors(7)
        END IF
      END IF
      PRINT USING " ##"; I;
      COLOR Colors(9) + Comp, Colors(7)
      IF POS(0) > 74 THEN a = a + 1: LOCATE a, 56
   NEXT

END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                               PrintDate                                 บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime a data em Portugus por extenso e respectivo calend rio         บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTDate
       RESTORE DATAMONTHS
       FOR I = 1 TO 12
        READ MonthData(I).MName, MonthData(I).Number
       NEXT
       PRINTCalendar VAL(RIGHT$(DATE$, 4)), VAL(LEFT$(DATE$, 2))
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                 PRINTF                                  บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime uma string numa determinada posio, com os atributos escolhidosบ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTF (Lin%, Col%, Color1%, Color2%, Text$)
  LOCATE Lin%, Col%
  IF Color2% <= 7 THEN Comp = 0 ELSE IF Color2% >= 8 THEN Comp = 16
  COLOR Color1 + Comp, Color2
  PRINT Text$;
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                PRINTHelp                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime uma cadeia na linha 25 do ecran                                 บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTHelp (Help$)
    PRINTF 25, 1, Colors(15), Colors(16), SPACE$(80)
    Center Colors(15), Colors(16), 25, Help$
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                PRINTTime                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime a hora e verifica se ainda no passou da meia noite para        บ
'บ actualizar a data.                                                      บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTTime (Lin%, Col%, Color1%, Color2%)
  COLOR Color1%, Color2%
  LOCATE Lin%, Col%
  PRINT TIME$
  IF TIME$ = "00:00:00" THEN PRINTDate
END SUB

SUB RECORD (OPERATION%) STATIC
SHARED Path$
  SELECT CASE OPERATION
         CASE ADD:
           PRINTHelp "F10 para ACEITAR."
           DO
             NumberOfRecords = NumberOfRecords + 1
             Index(NumberOfRecords).Nome = SPACE$(40)
             Index(NumberOfRecords).Morada = SPACE$(38)
             Index(NumberOfRecords).CPostal = SPACE$(25)
             Index(NumberOfRecords).Ind = SPACE$(3)
             Index(NumberOfRecords).Tel = SPACE$(7)
             Index(NumberOfRecords).Fax = SPACE$(7)
             Index(NumberOfRecords).Modem = SPACE$(7)
             Index(NumberOfRecords).DataDIA = SPACE$(2)
             Index(NumberOfRecords).DataMES = SPACE$(2)
             Index(NumberOfRecords).DataANO = SPACE$(2)

             WORKBENCH 2
             EDIT Index(NumberOfRecords)
             PUT #1, NumberOfRecords, Index(NumberOfRecords)
     
             Index(NumberOfRecords).RecordNumber = NumberOfRecords

             PRINTHelp "Adicionar ESTE registo (S/N)?"
             SOUND 1000, 1
             OK$ = UCASE$(INPUT$(1))
             IF OK$ = "N" THEN
               NumberOfRecords = NumberOfRecords - 1
               EXIT SUB
             END IF
    
             PRINTHelp "Adicionar OUTRO registo (S/N)?"
             SOUND 1000, 1
             OK$ = UCASE$(INPUT$(1))
             PRINTHelp ""
           LOOP WHILE OK$ = "S"
           RECORD SAVE
           RECORD SORT

         CASE ZAP:
           Index(RecordNumber).Nome = STRING$(30, 255)
           Index(RecordNumber).Morada = STRING$(30, 255)
           Index(RecordNumber).CPostal = STRING$(25, 255)
           Index(RecordNumber).Ind = STRING$(3, 255)
           Index(RecordNumber).Tel = STRING$(7, 255)
           Index(RecordNumber).Fax = STRING$(7, 255)
           Index(RecordNumber).Modem = STRING$(7, 255)
           Index(RecordNumber).DataDIA = STRING$(2, 255)
           Index(RecordNumber).DataMES = STRING$(2, 255)
           Index(RecordNumber).DataANO = STRING$(2, 255)
        
         CASE PRINTR:
           PRINTF 5, 64, Colors(9), Colors(7), STR$(RecordNumber) + "  "
           PRINTF 6, 10, Colors(13), Colors(7), Index(RecordNumber).Nome
           PRINTF 8, 12, Colors(13), Colors(7), Index(RecordNumber).Morada
           PRINTF 10, 19, Colors(13), Colors(7), Index(RecordNumber).CPostal
           PRINTF 12, 16, Colors(13), Colors(7), Index(RecordNumber).Ind
           PRINTF 12, 38, Colors(13), Colors(7), Index(RecordNumber).Tel
           PRINTF 14, 9, Colors(13), Colors(7), Index(RecordNumber).Fax
           PRINTF 14, 34, Colors(13), Colors(7), Index(RecordNumber).Modem
           PRINTF 16, 24, Colors(13), Colors(7), Index(RecordNumber).DataDIA
           PRINTF 16, 28, Colors(13), Colors(7), Index(RecordNumber).DataMES
           PRINTF 16, 32, Colors(13), Colors(7), Index(RecordNumber).DataANO

         CASE PLIST:
           IF NumberOfRecords <= 5 THEN
             WORKBENCH 15
             EXIT SUB
           END IF

           WORKBENCH 3
           GOSUB ShowProgramListPrint
 
           DO
             DO
               Choice$ = INKEY$
               IF Colors(7) <= 7 THEN Comp = 0 ELSE IF Colors(7) >= 8 THEN Comp = 16
               PRINTTime 14, 57, Colors(11) + Comp, Colors(7)
             LOOP WHILE Choice$ = ""
     
             SELECT CASE Choice$
               CASE CHR$(0) + "H": RecordNumber = RecordNumber - 1
               CASE CHR$(0) + "P": RecordNumber = RecordNumber + 1
               CASE CHR$(0) + "K": RecordNumber = RecordNumber - 1
               CASE CHR$(0) + "M": RecordNumber = RecordNumber + 1
               CASE CHR$(0) + "G": RecordNumber = 1
               CASE CHR$(0) + "I": RecordNumber = RecordNumber - 10
               CASE CHR$(0) + "O": RecordNumber = NumberOfRecords
               CASE CHR$(0) + "Q": RecordNumber = RecordNumber + 10
               CASE CHR$(27): EXIT SUB
               CASE ELSE:  SOUND 1000, 1
             END SELECT

             IF RecordNumber < 1 THEN RecordNumber = 1
             IF RecordNumber > NumberOfRecords - 5 THEN RecordNumber = NumberOfRecords - 5
                                       
ShowProgramListPrint:
             SP$ = CHR$(32) + CHR$(179) + CHR$(32): Eraser$ = STRING$(2, 32)
                                                     
             PRINTF 6, 4, Colors(13), Colors(7), Index(RecordNumber).Nome + SP$ + Index(RecordNumber + count).Tel + SP$ + Index(RecordNumber).Modem + SP$ + STR$(RecordNumber) + Eraser$
             PRINTF 7, 4, Colors(13), Colors(7), Index(RecordNumber + 1).Nome + SP$ + Index(RecordNumber + 1).Tel + SP$ + Index(RecordNumber + 1).Modem + SP$ + STR$(RecordNumber + 1) + Eraser$
             PRINTF 8, 4, Colors(13), Colors(7), Index(RecordNumber + 2).Nome + SP$ + Index(RecordNumber + 2).Tel + SP$ + Index(RecordNumber + 2).Modem + SP$ + STR$(RecordNumber + 2) + Eraser$
             PRINTF 9, 4, Colors(13), Colors(7), Index(RecordNumber + 3).Nome + SP$ + Index(RecordNumber + 3).Tel + SP$ + Index(RecordNumber + 3).Modem + SP$ + STR$(RecordNumber + 3) + Eraser$
             PRINTF 10, 4, Colors(13), Colors(7), Index(RecordNumber + 4).Nome + SP$ + Index(RecordNumber + 4).Tel + SP$ + Index(RecordNumber + 4).Modem + SP$ + STR$(RecordNumber + 4) + Eraser$
             PRINTF 11, 4, Colors(13), Colors(7), Index(RecordNumber + 5).Nome + SP$ + Index(RecordNumber + 5).Tel + SP$ + Index(RecordNumber + 5).Modem + SP$ + STR$(RecordNumber + 5) + Eraser$
           LOOP
        
         CASE SORT:
           OffSet = NumberOfRecords \ 2
           DO WHILE OffSet > 0
             Limit = NumberOfRecords - OffSet
             DO
               Switch = FALSE
               FOR I = 1 TO Limit
                 IF Index(I).Nome > Index(I + OffSet).Nome THEN
                   SWAP Index(I), Index(I + OffSet)
                   Switch = I
                 END IF
               NEXT I
               Limit = Switch
             LOOP WHILE Switch
             OffSet = OffSet \ 2
           LOOP

         CASE LOAD:
           CLOSE
        
           OPEN Path$ + DataFilename$ FOR RANDOM AS #1 LEN = LEN(RecordFile)
           NumberOfRecords = LOF(1) \ LEN(RecordFile)

           IF NumberOfRecords = 0 THEN WORKBENCH 10

           IF NumberOfRecords > 0 THEN
             FOR RecordNumber = 1 TO NumberOfRecords
               GET #1, RecordNumber, Index(RecordNumber)
               Index(RecordNumber).RecordNumber = RecordNumber
             NEXT
             RECORD SORT
           ELSE

           END IF

         CASE SAVE:
           CLOSE
           KILL Path$ + DataFilename$
           RECORD SORT
           OPEN Path$ + DataFilename$ FOR RANDOM AS #1 LEN = LEN(RecordFile)
             FOR Card = 1 TO NumberOfRecords
               PUT #1, Card, Index(Card)
             NEXT
           CLOSE #1
           IF ERRstate THEN GOTO ExitSubSaveRecords
           RECORD LOAD
ExitSubSaveRecords:

         CASE ELSE
  END SELECT
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                  TBOX                                   บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Dezenha uma caixa sem linhas e com local para titulo destacado.         บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB TBOX (Lin1, Col1, Lin2, Col2, PColor, Title$, TCol, TColor1, TColor2, Shadow, MODE) STATIC
 
    BoxWidth = Col2 - Col1 + 1
                                      
    PRINTF Lin1, Col1, TColor1, TColor2, STRING$(BoxWidth - 2, 0)
    PRINTF Lin1, TCol, TColor1, TColor2, Title$
    FOR a = Lin1 + 1 TO Lin2 - 1
        PRINTF a, Col1, PColor, PColor, STRING$(BoxWidth - 2, 32)
        IF Shadow THEN
          IF MODE = 1 THEN
            PRINTF a, Col2 - 1, 9, 0, CHR$(0)
          ELSE
            COLOR 7, 0
            a$ = CHR$(SCREEN(a, Col2 - 1))
            B$ = CHR$(SCREEN(a, Col2))
            IF ASC(a$) >= 219 OR ASC(B$) >= 219 THEN a$ = CHR$(0): B$ = CHR$(0)
            PRINT a$ + B$;
          END IF
       END IF
    NEXT a
    IF Shadow THEN
      IF MODE = 1 THEN
        PRINTF Lin2, Col1 + 2, Colors(17), 0, STRING$((Col2 - Col1) - 2, 220)
      ELSE
        COLOR 7, 0
        B$ = ""
        FOR V% = Col1 + 2 TO Col2
            a$ = CHR$(SCREEN(Lin2, V%))
            IF ASC(a$) >= 219 THEN a$ = CHR$(0)
            B$ = B$ + a$
        NEXT
        LOCATE Lin2, Col1 + 2
        PRINT B$;
      END IF
    END IF
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                 Windows                                 บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Salva e restora uma poro de ecra, para um dos 5 buffers disponiveis   บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB WINDOWS (UL1, UL2, DR1, DR2, WNumber, OPERATION)

 DEF SEG = &HB800
 a = 1

 SELECT CASE OPERATION
  CASE CURSORON
   FOR n = UL1% TO DR1%
    FOR m = UL2% TO DR2%
     OffSet = 160 * (n - 1) + 2 * (m - 1)
     Windw(WNumber, a).CHR = PEEK(OffSet)
     Windw(WNumber, a).Cor = PEEK(OffSet + 1)
     a = a + 1
    NEXT
   NEXT
  CASE CURSOROFF
   FOR n = UL1% TO DR1%
    FOR m = UL2% TO DR2%
     OffSet = 160 * (n - 1) + 2 * (m - 1)
     CHR = Windw(WNumber, a).CHR
     Cor = Windw(WNumber, a).Cor
     POKE OffSet, CHR
     POKE OffSet + 1, Cor
     a = a + 1
    NEXT
   NEXT
  CASE ELSE
 END SELECT
 DEF SEG
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                WorkBench                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Rotina encarregue de imprimir os menus e janelas do programa.           บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB WORKBENCH (ScreenN%)

  SELECT CASE ScreenN%
         CASE 1
           TBOX 4, 3, 18, 53, Colors(7), "REGISTO INDIVIDUAL", 4, Colors(4), Colors(6), TRUE, SDW2
           TBOX 4, 56, 8, 79, Colors(7), "REGISTO", 57, Colors(5), Colors(6), TRUE, SDW2
           TBOX 9, 56, 12, 79, Colors(7), "FICHEIRO", 57, Colors(5), Colors(6), TRUE, SDW2
           TBOX 13, 56, 23, 79, Colors(7), "HORA/DATA", 57, Colors(5), Colors(6), TRUE, SDW2
           TBOX 19, 3, 23, 53, Colors(7), "AJUDA", 4, Colors(5), Colors(6), TRUE, SDW2

           LOCATE 6, 4: COLOR Colors(8), Colors(7): PRINT "Nome:"
           LOCATE 8, 4: COLOR Colors(8), Colors(7): PRINT "Morada:"
           LOCATE 10, 4: COLOR Colors(8), Colors(7): PRINT "Codigo Postal:"
           LOCATE 12, 4: COLOR Colors(8), Colors(7): PRINT "Indicativo:"
           LOCATE 12, 27: COLOR Colors(8), Colors(7): PRINT "Telefone:"
           LOCATE 14, 4: COLOR Colors(8), Colors(7): PRINT "Fax:"
           LOCATE 14, 27: COLOR Colors(8), Colors(7): PRINT "Modem:"
           LOCATE 16, 4: COLOR Colors(8), Colors(7): PRINT "Data de Nascimento:    /   /"
  
           LOCATE 5, 57: COLOR Colors(8), Colors(7): PRINT "ACTUAL:"
           LOCATE 6, 57: COLOR Colors(8), Colors(7): PRINT "EXISTE:"
           LOCATE 7, 57: COLOR Colors(8), Colors(7): PRINT "MAXIMO:"
           LOCATE 10, 57: COLOR Colors(8), Colors(7): PRINT "ACTUAL:"
           LOCATE 11, 57: COLOR Colors(8), Colors(7): PRINT "MAXIMO:"
           LOCATE 7, 65: COLOR 9, Colors(7): PRINT "400"
           LOCATE 10, 64: COLOR 9, Colors(7): PRINT STR$(LOF(1))
           LOCATE 11, 64: COLOR 9, Colors(7): PRINT STR$(LEN(RecordFile) * 135)
           PRINTDate
           WORKBENCH 5

         CASE 2
           LOCATE 6, 10: COLOR Colors(7), Colors(7): PRINT SPACE$(40)
           LOCATE 8, 12: COLOR Colors(7), Colors(7): PRINT SPACE$(38)
           LOCATE 10, 19: COLOR Colors(7), Colors(7): PRINT SPACE$(25)
           LOCATE 12, 16: COLOR Colors(7), Colors(7): PRINT SPACE$(3)
           LOCATE 12, 38: COLOR Colors(7), Colors(7): PRINT SPACE$(7)
           LOCATE 14, 9: COLOR Colors(7), Colors(7): PRINT SPACE$(7)
           LOCATE 14, 34: COLOR Colors(7), Colors(7): PRINT SPACE$(7)
           LOCATE 16, 24: COLOR Colors(7), Colors(7): PRINT SPACE$(2)
           LOCATE 16, 28: COLOR Colors(7), Colors(7): PRINT SPACE$(2)
           LOCATE 16, 32: COLOR Colors(7), Colors(7): PRINT SPACE$(2)
         
         CASE 3
           FOR m = 11 TO 23
             LOCATE m, 3: COLOR 9, 9: PRINT STRING$(50, 219)
           NEXT m
           TBOX 13, 3, 23, 54, Colors(7), "AJUDA", 5, Colors(5), Colors(6), TRUE, SDW2
           LOCATE 15, 5: COLOR 15, Colors(7): PRINT "<ESC>   Menu"
           LOCATE 16, 5: COLOR 15, Colors(7): PRINT "<  >   Recua 1 Registo"
           LOCATE 17, 5: COLOR 15, Colors(7): PRINT "<  >   Avana 1 Registo"
           LOCATE 18, 5: COLOR 15, Colors(7): PRINT "<PgUp>  Avana 10 Registos"
           LOCATE 19, 5: COLOR 15, Colors(7): PRINT "<PgDn>  Recua 10 Registos"
           LOCATE 20, 5: COLOR 15, Colors(7): PRINT "<Home>  Vai para o 1ง  Registo"
           LOCATE 21, 5: COLOR 15, Colors(7): PRINT "<End>   Vai para o Ultimo Registo"

           TBOX 4, 3, 12, 79, Colors(7), "LISTA DE REGISTOS", 4, Colors(4), Colors(6), TRUE, SDW2
           PRINTHelp "Consulta continua a todos os registos do ficheiro"
           LOCATE 5, 4: COLOR 12, Colors(7): PRINT "Nome" + SPACE$(38) + "Telefone   Modem     Registo"
 
         CASE 4
            'No Utilizado
        
         CASE 5
           LOCATE 20, 4: COLOR Colors(8), Colors(7): PRINT " Utilize as teclas de direo para movimentar"
           LOCATE 21, 4: COLOR Colors(8), Colors(7): PRINT " a barra cursora e ENTER para aceitar a opo"
           LOCATE 22, 4: COLOR Colors(8), Colors(7): PRINT " desejada."

         CASE 6
           WINDOWS 7, 15, 20, 66, 4, CURSORON
           TBOX 7, 15, 20, 65, 7, "INFORMA€O", 17, 15, 4, TRUE, SDW1
     
           LOCATE 9, 17: COLOR 9, 7: PRINT "AGENDA v1.1"
           LOCATE 10, 17: COLOR 15, 7: PRINT "Desenvolvido e programado por HUGO FERREIRA"
           LOCATE 11, 17: COLOR 15, 7: PRINT "WEST COAST SOFTWARE, 1993."
           LOCATE 13, 17: COLOR 15, 7: PRINT "Se necessitar  de  entrar em contacto  com  a"
           LOCATE 14, 17: COLOR 15, 7: PRINT "equipa de programao da West Coast Software,"
           LOCATE 15, 17: COLOR 15, 7: PRINT "por  favor escreva  para  a  seguinte morada:"
           LOCATE 16, 20: COLOR 15, 7: PRINT "Metropolis BBS"
           LOCATE 17, 20: COLOR 15, 7: PRINT "Praceta do Barro, 6 - Alcoito"
           LOCATE 18, 20: COLOR 15, 7: PRINT "2765 ESTORIL - PORTUGAL"
           PRINTHelp "PRIMA UMA TECLA PARA CONTINUAR"
   
           Choice$ = INPUT$(1)
           WINDOWS 7, 15, 20, 66, 4, CURSOROFF
        
         CASE 7
           COLOR 9, 0
           PRINT
           PRINT "AGENDA v1.1"
           COLOR 7, 0
           PRINT "Desenvolvido e programado por Hugo Ferreira"
           PRINT "WEST COAST SOFTWARE, 1993"
           PRINT

          
        CASE 8
          TBOX 4, 56, 12, 79, Colors(7), "AJUDA", 58, Colors(5), Colors(6), TRUE, SDW2
          LOCATE 5, 57: COLOR 15, Colors(7): PRINT "<ESC>   Menu"
          LOCATE 6, 57: COLOR 15, Colors(7): PRINT "<  >   -1  Registo"
          LOCATE 7, 57: COLOR 15, Colors(7): PRINT "<  >   +1  Registo"
          LOCATE 8, 57: COLOR 15, Colors(7): PRINT "<PgUp>  +10 Registo"
          LOCATE 9, 57: COLOR 15, Colors(7): PRINT "<PgDn>  -10 Registo"
          LOCATE 10, 57: COLOR 15, Colors(7): PRINT "<Home>  1ง  Registo"
          LOCATE 11, 57: COLOR 15, Colors(7): PRINT "<End>   Ultimo Reg."
       
        CASE 9
           FOR m = 17 TO 23
             LOCATE m, 56: COLOR 9, 9: PRINT STRING$(23, 219)
           NEXT m
           TBOX 4, 56, 19, 79, Colors(7), "AJUDA", 58, Colors(5), Colors(6), TRUE, SDW2
           LOCATE 6, 57: COLOR 15, Colors(7): PRINT "<ESC>   Anular "
           LOCATE 7, 57: COLOR 15, Colors(7): PRINT "<ENTER> Proximo"
           LOCATE 8, 57: COLOR 15, Colors(7): PRINT "<  >   -1 Campo"
           LOCATE 9, 57: COLOR 15, Colors(7): PRINT "<  >   +1 Campo"
           LOCATE 10, 57: COLOR 15, Colors(7): PRINT "<  >   +1 Cara."
           LOCATE 11, 57: COLOR 15, Colors(7): PRINT "<   >   -1 Cara."
           LOCATE 12, 57: COLOR 15, Colors(7): PRINT "<Home>  Principio"
           LOCATE 13, 57: COLOR 15, Colors(7): PRINT "<End>   Fim"
           LOCATE 14, 57: COLOR 15, Colors(7): PRINT "<BKSP>  Apagar "
           LOCATE 15, 57: COLOR 15, Colors(7): PRINT "<Del>   Apagar "
           LOCATE 16, 57: COLOR 15, Colors(7): PRINT "<Ins>   Inserir"
           LOCATE 17, 57: COLOR 15, Colors(7): PRINT "<F10>   Aceitar"
        
         CASE 10
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           LOCATE 9, 17: COLOR 12, 7: PRINT "No encontro o ficheiro AGENDA.DAT."
           LOCATE 10, 17: COLOR 15, 7: PRINT "Um novo ficheiro ir  ser criado."
           DO: LOOP UNTIL INKEY$ <> ""
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
           NumberOfRecords = 1
           RECORD SAVE
        
         CASE 11
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           LOCATE 9, 17: COLOR 12, 7: PRINT "A impressora no se encontra pronta."
           LOCATE 10, 17: COLOR 15, 7: PRINT "Corrija o problema e tente de novo."
           DO: LOOP UNTIL INKEY$ <> ""
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 12
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           LOCATE 9, 17: COLOR 12, 7: PRINT "Erro no directorio de AGENDA.DAT."
           LOCATE 10, 17: COLOR 15, 7: PRINT "Corra AGENDCFG.EXE para corrigir o problema."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 13
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           LOCATE 9, 17: COLOR 12, 7: PRINT "Erro na escrita no disco."
           LOCATE 10, 17: COLOR 15, 7: PRINT "O programa vai terminar a sua execuo."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 14
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           LOCATE 9, 17: COLOR 12, 7: PRINT "A disquete no se encontra pronta."
           LOCATE 10, 17: COLOR 15, 7: PRINT "Corrija o problema e prima uma tecla."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 15
           WINDOWS 7, 15, 13, 66, 4, CURSORON
           TBOX 7, 15, 13, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           LOCATE 9, 17: COLOR 12, 7: PRINT "FUN€O NO DISPONIVEL."
           LOCATE 10, 17: COLOR 15, 7: PRINT "Sข poder  usar esta funo quando o"
           LOCATE 11, 17: COLOR 15, 7: PRINT "ficheiro tiver seis ou mais registos."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 13, 66, 4, CURSOROFF
         CASE ELSE
END SELECT
EXIT SUB

PrintChoseKey:
  PRINTHelp "PRIMA UMA TECLA PARA CONTINUAR"
  DO: LOOP UNTIL INKEY$ <> ""
RETURN
END SUB

