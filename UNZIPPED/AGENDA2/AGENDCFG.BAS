' AGENDA CONFIG - Programa de Configurao do Agenda v1.1
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
'Declarao das Functions e Subs do programa por ordem alfabtica
DECLARE SUB BOX (Lin1%, Col1%, Lin2%, Col2%, Color1%, Color2%, BoxType%, Shadow%)
DECLARE SUB ColorSystem ()
DECLARE SUB COMPUTEMonth (Year%, Month%, StartDay%, TotalDays%)
DECLARE SUB CONFIG (OPERATION%)
DECLARE SUB DirSystem ()
DECLARE FUNCTION IsLeapYear% (n%)
DECLARE SUB PRINTDate ()
DECLARE SUB PRINTF (Lin%, Col%, Color1%, Color2%, Text$)
DECLARE SUB PrintHelp (Help$)
DECLARE SUB PRINTTime (Lin%, Col%, Color1%, Color2%)
DECLARE SUB Main ()
DECLARE SUB TBOX (Lin1%, Col1%, Lin2%, Col2%, PColor%, Title$, TCol%, TColor1%, TColor2%, Shadow%, MODE%)
DECLARE SUB WINDOWS (UL1%, UL2%, DR1%, DR2%, WNumber%, OPERATION%)
DECLARE SUB WORKBENCH (ScreenN%)
DECLARE FUNCTION GetKey% (CurrChoiceX%)
DECLARE FUNCTION GetString$ (Lin%, Col%, Start$, END$, VIS%, Max%, currKey$)

'$DYNAMIC

'Declarar todas as variaveis de A a Z como numeros inteiros (Integer)
 DEFINT A-Z

'Declarar constantes utilizadas no programa
 CONST TRUE = -1, FALSE = NOT TRUE
 CONST CURSORON = 1, CURSOROFF = 0
 CONST LOAD = 1, SAVE = 2
 CONST SDW1 = 0, SDW2 = 1
 CONST ConfigFilename$ = "AGENDA.EXE", SeekPos = 160

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
 DIM SHARED Colors(0 TO 17) AS INTEGER, AuxColors(0 TO 17) AS INTEGER
 DIM SHARED MonthData(1 TO 12) AS MonthType
 DIM SHARED DOSDir AS DirType

 RESTORE DATAMONTHS
 FOR I = 1 TO 12
   READ MonthData(I).MName, MonthData(I).Number
 NEXT

 Day = VAL(MID$(DATE$, 4, 2))
 Month = VAL(LEFT$(DATE$, 2))
 Year = VAL(RIGHT$(DATE$, 4))

'Apresentar o programa
 WORKBENCH 7

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
 PRINT
 PRINT "Insira a drive e directorio onde se encontra o ficheiro AGENDA.EXE."
 PRINT "Prima ENTER para o directorio actual."
 INPUT CONFPATH$
 IF CONFPATH$ <> "" THEN IF RIGHT$(CONFPATH$, 1) <> "\" THEN CONFPATH$ = CONFPATH$ + "\"

'Inicializar as cores, e restante configurao
 CONFIG LOAD

MenuHandler:

'Entrar na rotina principal do programa
 Main
 
'Restabelece a cor do DOS e sai do programa
ProgramEnd:
 COLOR 7, 0
 CLS
 PRINTF 1, 1, 15, 1, STRING$(80, 32)
 PRINTF 1, 1, 15, 1, "Agenda v1.1, Hugo Ferreira 1993."
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
'บ                              ColorSystem                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Sistema que permite selecionar as cores com que o programa vai operar   บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB ColorSystem

 WINDOWS 4, 3, 24, 66, 2, CURSORON

 WORKBENCH 4

 FOR m = 6 TO 21
  PRINTF m, 5, m - 6, 7, STRING$(3, 219)
 NEXT
 PrintHelp "TAB ou ENTER para mudar de janela. ESC Sair/Gravar configurao."
  Count = AuxColors(1): Clr = 1: CORFUNDO = 7: SETA = 1
  PRINTF SETA + 5, 13, 13, CORFUNDO, CHR$(16)
  GOSUB PRINTCURSOR
     DO
BEGN: DO
       Choice$ = INKEY$
       IF CORFUNDO <= 7 THEN Comp = 0 ELSE IF CORFUNDO >= 8 THEN Comp = 16
       PRINTTime 14, 56, AuxColors(11), AuxColors(7)
      LOOP WHILE Choice$ = ""
    
      IF INSTR("ABCDEFGHIJKLMNOPQabcdefghijklmnopq", Choice$) > 0 THEN
        GOSUB COLOROPTION
        GOSUB PRINTCURSOR
        GOTO BEGN
      END IF
    
      CONTADOR = Count
      GOSUB COLORCOUNT
      GOSUB PRINTCURSOR
  LOOP

COLORCOUNT:
     SELECT CASE Choice$
            CASE CHR$(0) + "H": Count = Count - 1
            CASE CHR$(0) + "P": Count = Count + 1
            CASE CHR$(0) + "K": Count = Count - 1
            CASE CHR$(0) + "M": Count = Count + 1
            CASE CHR$(0) + "G": Count = 0
            CASE CHR$(0) + "I": Count = Count - 10
            CASE CHR$(0) + "O": Count = 15
            CASE CHR$(0) + "Q": Count = Count + 10
            CASE CHR$(9), CHR$(13), CHR$(27): GOTO exitSub
            CASE ELSE:  SOUND 1000, 1
      END SELECT
         
         IF Count < 0 THEN Count = 0
         IF Count > 15 THEN Count = 15
         AuxColors(Clr) = Count
RETURN

COLOROPTION:
     FIRST = TRUE
     PRINTF AuxColors(Clr) + 6, 10, CORFUNDO, CORFUNDO, CHR$(219)
     PRINTF Count + 6, 10, CORFUNDO, CORFUNDO, CHR$(219)
     PRINTF SETA + 5, 13, CORFUNDO, CORFUNDO, CHR$(219)
     SELECT CASE ASC(UCASE$(Choice$))
            CASE IS < 65: GOTO ENDS
            CASE IS > 81: GOTO ENDS
            CASE ELSE
             Count = AuxColors(ASC(UCASE$(Choice$)) - 64)
             Clr = ASC(UCASE$(Choice$)) - 64
             AUXSETA = SETA
             SETA = Clr
    PRINTF SETA + 5, 13, 13, CORFUNDO, CHR$(16)
ENDS: END SELECT
RETURN

PRINTCURSOR:
  PRINTF CONTADOR + 6, 10, CORFUNDO, CORFUNDO, CHR$(219)
  PRINTF Count + 6, 10, 12, CORFUNDO, CHR$(251)

  IF SETA >= 1 AND SETA <= 3 THEN
    PRINTF 2, 1, AuxColors(1), AuxColors(3), " SISTEMA    EDITAR    PROCURAR    IMPRIMIR    CONSULTAR                         "
    BOX 3, 46, 6, 66, AuxColors(1), AuxColors(3), 3, TRUE
    PRINTF 4, 47, AuxColors(1), AuxColors(2), " Registo a Registo "
    PRINTF 5, 48, AuxColors(1), AuxColors(3), "Lista de Registos"
    MNU = TRUE
  ELSE
    
    IF MNU = TRUE THEN MNU = FALSE: WORKBENCH 5
    
    IF SETA >= 4 AND SETA <= 6 THEN PRINTF 4, 3, AuxColors(4), AuxColors(6), " CONFIGURA€O DE CORES                         ": WORKBENCH 4
    IF SETA >= 5 AND SETA <= 7 THEN TBOX 13, 55, 23, 78, AuxColors(7), "HORA/DATA", 56, AuxColors(5), AuxColors(6), TRUE, SDW2: WORKBENCH 3
    IF SETA >= 5 AND SETA <= 12 THEN IF SETA <> 8 THEN PRINTDate
    IF SETA >= 7 AND SETA <= 8 THEN WORKBENCH 3
    IF SETA >= 15 AND SETA <= 16 THEN PrintHelp "TAB ou ENTER para mudar de janela. ESC Sair/Gravar configurao."
  END IF
' 1 - Texto dos menus
' 2 - Barra de selecao dos menus
' 3 - Fundo dos menus
' 4 - Titulo da janela principal
' 5 - Titulo das janelas de informao
' 6 - Fundo dos titulos das janelas
' 7 - Fundo das janelas
' 8 - Texto das janelas
' 9 - Calendario
'10 - Dias da semana
'11 - Hora
'12 - Data
'13 - Texto do campo
'14 - Campo selecionado
'15 - Texto de ajuda
'16 - Fundo do texto de ajuda
'17 - Fundo do programa

RETURN



exitSub:
  WORKBENCH 5
  PRINTF CONTADOR + 6, 10, CORFUNDO, CORFUNDO, CHR$(219)
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
SUB CONFIG (OPERATION)
SHARED Path$, CONFPATH$
 
  SELECT CASE OPERATION
         CASE LOAD:
           OPEN CONFPATH$ + ConfigFilename$ FOR INPUT AS #2
             SEEK #2, SeekPos
               FOR REC = 1 TO 17
                 INPUT #2, Colors(REC)
               NEXT REC
             INPUT #2, DOSDir.StrDir
             Path$ = RTRIM$(DOSDir.StrDir)
            
             FOR REC = 1 TO 17
               AuxColors(REC) = Colors(REC)
             NEXT REC
           CLOSE #2
      
         CASE SAVE:
             FOR REC = 1 TO 17
               Colors(REC) = AuxColors(REC)
             NEXT REC
            
             OPEN CONFPATH$ + ConfigFilename$ FOR APPEND AS #2
             SEEK #2, SeekPos
               FOR REC = 1 TO 17
                 PRINT #2, Colors(REC)
               NEXT REC
             PRINT #2, DOSDir.StrDir
             CLOSE #2
  END SELECT
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                DirSystem                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Rotina encarregue de recolher as directorias para a configurao.       บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB DirSystem
SHARED Path$

  WORKBENCH 4
  GOSUB PrintDir

  Temp$ = DOSDir.StrDir
  Temp$ = UCASE$(GetString$(2, 3, Temp$, Temp$, 77, 127, currKey$))
  IF RIGHT$(Temp$, 1) <> "\" THEN Temp$ = Temp$ + "\"
  DOSDir.StrDir = Temp$
  Path$ = Temp$
  GOSUB PrintDir
  
  WORKBENCH 5
  EXIT SUB

PrintDir:
  PRINTF 1, 2, 15, 3, SPACE$(80)
  IF LEN(DOSDir.StrDir) < 77 THEN
    PRINTF 2, 2, 15, 3, ">" + DOSDir.StrDir
  ELSE
    PRINTF 2, 2, 15, 3, ">" + LEFT$(DOSDir.StrDir, 77)
  END IF
RETURN

END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                  GetKey                                 บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Retorna as teclas premidas a fim de permitir saber qual foi a opao     บ
'บ pretendida.                                                             บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
FUNCTION GetKey (CurrChoiceX)
    currChoice = CurrChoiceX
    FINISHED = FALSE

    WHILE NOT FINISHED
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
    FINISHED = TRUE
    RETURN

FGETKEscape:
    currChoice = 0
    FINISHED = TRUE
    RETURN
FGETKUp:
    currChoice = 1
    FINISHED = TRUE
    RETURN
FGETKLeft:
    currChoice = 2
    FINISHED = TRUE
    RETURN
FGETKRight:
    currChoice = 3
    FINISHED = TRUE
    RETURN
FGETKDown:
    currChoice = 4
    FINISHED = TRUE
    RETURN
FGETKPgUP:
    currChoice = 5
    FINISHED = TRUE
    RETURN
FGETKHOME:
    currChoice = 6
    FINISHED = TRUE
    RETURN
FGETKEND:
    currChoice = 7
    FINISHED = TRUE
    RETURN
FGETKPgDOWN:
    currChoice = 8
    FINISHED = TRUE
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

    FINISHED = FALSE
    DO
        GOSUB GetStringShowText
        GOSUB GetStringGetKey

    
        IF LEN(kbd$) > 1 THEN
            FINISHED = TRUE
            GetString$ = curr$
            currKey$ = kbd$
        ELSE
            SELECT CASE kbd$
                CASE CHR$(13), CHR$(27), CHR$(9)
                    FINISHED = TRUE
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

    LOOP UNTIL FINISHED

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

SUB Main
  DO
    WORKBENCH 1
    WORKBENCH 2
   
    ColorSystem
    DirSystem
    PrintHelp "Deseja gravar esta configurao? (S=GRAVA, N=CONTINUA, ESC=SAIR S/ GRAVAR)"
    DO: C$ = INKEY$: LOOP UNTIL C$ <> ""
    IF UCASE$(C$) = "S" THEN CONFIG SAVE
  LOOP UNTIL C$ = CHR$(27) OR UCASE$(C$) = "S"
 
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                PRINTDate                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime um calend rio formatado de um determinado dia e ms             บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTDate
SHARED MonthData() AS MonthType
SHARED Day, Month, Year
   
   COMPUTEMonth Year, Month, StartDay, TotalDays
   Header$ = MID$(DATE$, 4, 2) + " " + RTRIM$(MonthData(Month).MName) + "," + STR$(Year)
   LeftMargin = (34 - LEN(Header$)) \ 2

   PRINTF 15, 56, AuxColors(12), AuxColors(7), Header$
   PRINTF 16, 56, AuxColors(10), AuxColors(7), "DO SE TE QU QU SX SA"

   IF StartDay = 0 THEN LeftMargin = 55
   IF StartDay = 1 THEN LeftMargin = 58
   IF StartDay = 2 THEN LeftMargin = 61
   IF StartDay = 3 THEN LeftMargin = 64
   IF StartDay = 4 THEN LeftMargin = 67
   IF StartDay = 5 THEN LeftMargin = 70
   IF StartDay = 6 THEN LeftMargin = 73
   IF StartDay = 7 THEN LeftMargin = 76

   LOCATE 17, LeftMargin
   IF AuxColors(7) <= 7 THEN Comp = 0 ELSE IF AuxColors(7) >= 8 THEN Comp = 16
   a = 17:  COLOR AuxColors(9) + Comp, AuxColors(7)
  
   FOR I = 1 TO TotalDays
      IF I = Day THEN
        IF AuxColors(9) = 11 THEN
          COLOR 14 + Comp, AuxColors(7)
        ELSE
          COLOR 11 + Comp, AuxColors(7)
        END IF
      END IF
      PRINT USING " ##"; I;
      COLOR AuxColors(9) + Comp, AuxColors(7)
      IF POS(0) > 74 THEN a = a + 1: LOCATE a, 55
   NEXT

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
SUB PrintHelp (Help$)
    Color1 = AuxColors(15): Color2 = AuxColors(16)
    IF Color2 <= 7 THEN Comp = 0 ELSE IF Color2 >= 8 THEN Comp = 16
    PRINTF 25, 1, Color1, Color2, SPACE$(80)
    PRINTF 25, 41 - LEN(Help$) \ 2, Color1, Color2, Help$
END SUB

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                                PRINTTime                                บ
'วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
'บ Imprime a hora e verifica se ainda no passou da meia noite para        บ
'บ actualizar a data.                                                      บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
SUB PRINTTime (Lin%, Col%, Color1%, Color2%)
  IF Color2% <= 7 THEN Comp = 0 ELSE IF Color2% >= 8 THEN Comp = 16
  COLOR Color1% + Comp, Color2%
  LOCATE Lin%, Col%
  PRINT TIME$
  IF TIME$ = "00:00:00" THEN PRINTDate
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
        PRINTF Lin2, Col1 + 2, 9, 0, STRING$((Col2 - Col1) - 2, 220)
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
           TBOX 1, 1, 25, 82, 9, "Agenda Config v1.1", 2, 15, 1, FALSE, SDW1
           TBOX 13, 55, 23, 78, AuxColors(7), "HORA/DATA", 56, AuxColors(5), AuxColors(6), TRUE, SDW2
           TBOX 4, 3, 24, 51, 7, "CONFIGURA€O DE CORES", 4, AuxColors(4), AuxColors(6), TRUE, SDW2
           WORKBENCH 3
           PRINTDate
          
         CASE 2
           PRINTF 6, 15, 10, 7, "A": PRINTF 6, 17, 15, 7, "Texto dos menus"
           PRINTF 7, 15, 10, 7, "B": PRINTF 7, 17, 15, 7, "Barra de selecao dos menus"
           PRINTF 8, 15, 10, 7, "C": PRINTF 8, 17, 15, 7, "Fundo dos menus"
           PRINTF 9, 15, 10, 7, "D": PRINTF 9, 17, 15, 7, "Titulo da janela principal"
           PRINTF 10, 15, 10, 7, "E": PRINTF 10, 17, 15, 7, "Titulo das janelas de informao"
           PRINTF 11, 15, 10, 7, "F": PRINTF 11, 17, 15, 7, "Fundo dos titulos das janelas"
           PRINTF 12, 15, 10, 7, "G": PRINTF 12, 17, 15, 7, "Fundo das janelas"
           PRINTF 13, 15, 10, 7, "H": PRINTF 13, 17, 15, 7, "Texto das janelas"
           PRINTF 14, 15, 10, 7, "I": PRINTF 14, 17, 15, 7, "Calendario"
           PRINTF 15, 15, 10, 7, "J": PRINTF 15, 17, 15, 7, "Dias da semana"
           PRINTF 16, 15, 10, 7, "K": PRINTF 16, 17, 15, 7, "Hora"
           PRINTF 17, 15, 10, 7, "L": PRINTF 17, 17, 15, 7, "Data"
           PRINTF 18, 15, 10, 7, "M": PRINTF 18, 17, 15, 7, "Texto do campo"
           PRINTF 19, 15, 10, 7, "N": PRINTF 19, 17, 15, 7, "Campo selecionado"
           PRINTF 20, 15, 10, 7, "O": PRINTF 20, 17, 15, 7, "Texto de ajuda"
           PRINTF 21, 15, 10, 7, "P": PRINTF 21, 17, 15, 7, "Fundo do texto de ajuda"
           PRINTF 22, 15, 10, 7, "Q": PRINTF 22, 17, 15, 7, "Fundo do programa"
       
         CASE 3
           TBOX 4, 53, 11, 80, AuxColors(7), "DIRECTORIOS", 54, AuxColors(5), AuxColors(6), TRUE, SDW2
           PRINTF 6, 54, AuxColors(8), AuxColors(7), "Insira  na  linha acima"
           PRINTF 7, 54, AuxColors(8), AuxColors(7), "o  directorio  onde  se "
           PRINTF 8, 54, AuxColors(8), AuxColors(7), "encontra   o   ficheiro"
           PRINTF 9, 54, AuxColors(8), AuxColors(7), "AGENDA.DAT."

       
         CASE 4
           WINDOWS 2, 1, 2, 80, 1, CURSORON
           WINDOWS 3, 46, 7, 68, 2, CURSORON
           
         CASE 5
           WINDOWS 2, 1, 2, 80, 1, CURSOROFF
           WINDOWS 3, 46, 7, 68, 2, CURSOROFF
           WORKBENCH 3

         CASE 7
           COLOR 9, 0
           PRINT
           PRINT "AGENDA CONFIG v1.1"
           COLOR 7, 0
           PRINT "Desenvolvido e programado por Hugo Ferreira"
           PRINT "WEST COAST SOFTWARE, 1993"
           PRINT
         
        CASE 8
           'No Utilizado
       
        CASE 9
           'No Utilizado
        
         CASE 10
           'No Utilizado
        
         CASE 11
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           PRINTF 9, 17, 12, 7, "A impressora no se encontra pronta."
           PRINTF 10, 17, 15, 7, "Corrija o problema e tente de novo."
           DO: LOOP UNTIL INKEY$ <> ""
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 12
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           PRINTF 9, 17, 12, 7, "Erro no directorio de AGENDA.DAT."
           PRINTF 10, 17, 15, 7, "De seguida pode corrigir o problema."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 13
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           PRINTF 9, 17, 12, 7, "Erro na escrita no disco ou o programa"
           PRINTF 10, 17, 12, 7, "AGENDA.EXE no foi encontrado."
           PRINTF 11, 17, 15, 7, "O programa vai terminar a sua execuo."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
        
         CASE 14
           WINDOWS 7, 15, 12, 66, 3, CURSORON
           TBOX 7, 15, 12, 65, 7, "AVISO", 17, 15, 4, TRUE, SDW1
           PRINTF 9, 17, 12, 7, "A disquete no se encontra pronta."
           PRINTF 10, 17, 15, 7, "Corrija o problema e prima uma tecla."
           GOSUB PrintChoseKey
           WINDOWS 7, 15, 12, 66, 3, CURSOROFF
         CASE ELSE
  END SELECT
EXIT SUB

PrintChoseKey:
  PrintHelp "PRIMA UMA TECLA PARA CONTINUAR"
  DO: LOOP UNTIL INKEY$ <> ""
RETURN
END SUB

