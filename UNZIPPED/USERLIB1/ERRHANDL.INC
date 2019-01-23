'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³                     QUICK BASIC IV - FICHA TCNICA                        ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³ Software................: -                                               ³
'³ M¢dulo,Execut vel.......: ERRHANDL.INC                                    ³
'³ Vers„o (Idioma),rev.....: 1.1 (P), 30/10/93                               ³
'³ Cliente.................: -                                               ³
'³ Autor...................: N‚lio Abreu                                     ³
'³ Copyright...............: 1993                                            ³
'³ Data de cria‡„o.........: 18/09/93                                        ³
'³ Interface de v¡deo......: Texto                                           ³
'³ Ambiente................: DOS                                             ³
'³ Interface de sistema....: Monoposto                                       ³
'³ Sistema operativo.......: MS/PC/DR-DOS vers„o 2 ou superior               ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³                         FINALIDADE DO SOFTWARE                            ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³    Rutinas de controlo de erro.                                           ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³                         PROJECTO LEVADO A CABO POR                        ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³    N‚lio Abreu, para a Spooler Magazine, com o intuito de fornecer apoio a³
'³todos aqueles que programam em Quick BASIC da MicroSoft.                   ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


error.handler:
  SAVE.SCREEN "ERRHANDL.SCN"
  SCREEN 0: COLOR 7, 0, 0: CLS
  LOCATE , , 1, 11, 12
  '1 Beep - erro comum
  '2 Beep - erro de memoria
  '3 Beep - erro de  I/O
  '4 Beep - erro de hardware
  '5 Beep - erro desconhecido
  severity$(1, 1) = "Severity 1 - common error - Very low severity"
  severity$(2, 1) = "Severity 2 - memory error - Low severity"
  severity$(3, 1) = "Severity 3 - I/O error - Medium severity"
  severity$(4, 1) = "Severity 4 - Hardware error - High severity"
  severity$(5, 1) = "Severity 5 - Unknown error - Very high severity"
  severity$(1, 2) = "Severidade 1 - Erro comum - Severidade muito baixa"
  severity$(2, 2) = "Severidade 2 - Erro de mem¢ria - Severidade baixa"
  severity$(3, 2) = "Severidade 3 - Erro E/S - Severidade m‚dia"
  severity$(4, 2) = "Severidade 4 - Erro Hardware - Severidade alta"
  severity$(5, 2) = "Severidade 5 - Erro desconhecido - Severidade muito alta"
  error.code = ERR
  cod$ = MID$(STR$(error.code), 2)
  SELECT CASE error.code
    CASE 5
      BEEP
      warning$(1) = "Illegal function call - Error code #" + cod$
      warning$(2) = "Chamada ilegal de fun‡„o - Erro #" + cod$
      beps = 1
    CASE 6
      BEEP
      warning$(1) = "Overflow - Error code #" + cod$
      warning$(2) = "Overflow - Erro #" + cod$
      beps = 1
    CASE 7
      BEEP: SLEEP 1: BEEP
      warning$(1) = "Out of memory - Error code #" + cod$
      warning$(2) = "Sem mem¢ria - Erro #" + cod$
      beps = 2
    CASE 11
      BEEP
      warning$(1) = "Division by zero - Error code #" + cod$
      warning$(2) = "Divis„so por zero - Erro #" + cod$
      beps = 1
    CASE 13
      BEEP
      warning$(1) = "Type mismatch - Error code #" + cod$
      warning$(2) = "Erro de igualdade - Erro #" + cod$
      beps = 1
    CASE 14
      BEEP: SLEEP 1: BEEP
      warning$(1) = "Out of String space - Error code #" + cod$
      warning$(2) = "Sem espa‡o na  rea de string - Erro #" + cod$
      beps = 2
    CASE 24
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Printer OFF-LINE - Error code #" + cod$
      warning$(2) = "Impressora OFF-LINE - Erro #" + cod$
      beps = 3
    CASE 25
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Printer not responding - Error code #" + cod$
      warning$(2) = "Impressora sem resposta - Erro #" + cod$
      beps = 3
    CASE 27
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Printer out of paper - Error code #" + cod$
      warning$(2) = "Impressora sem papel - Erro #" + cod$
      beps = 3
    CASE 51
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Internal error - Error code #" + cod$
      warning$(2) = "Erro interno - Erro #" + cod$
      beps = 4
    CASE 53
      BEEP
      warning$(1) = "File not found - Error code #" + cod$
      warning$(2) = "Ficheiro n„o encontrado - Erro #" + cod$
      beps = 1
    CASE 57
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Error R/W on drive - Error code #" + cod$
      warning$(2) = "Erro L/E (Leitura/Escrita) - Erro #" + cod$
      beps = 3
    CASE 61
      BEEP
      warning$(1) = "Disk full - Error code #" + cod$
      warning$(2) = "Disco cheio - Erro #" + cod$
      beps = 1
    CASE 62
      BEEP
      warning$(1) = "^Z (<EOF>) not found - Error code #" + cod$
      warning$(2) = "^Z (<EOF>) n„o encontrado - Erro #" + cod$
      beps = 1
    CASE 67
      BEEP
      warning$(1) = "Too many files on root directory - Error code #" + cod$
      warning$(2) = "Muitos ficheiros na raiz do direct¢rio - Erro #" + cod$
      beps = 1
    CASE 68
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Device unavailable - Error code #" + cod$
      warning$(2) = "Perif‚rico n„o existente - Erro #" + cod$
      beps = 4
    CASE 70
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Write protected disk error - Error code #" + cod$
      warning$(2) = "Disco protegido contra escrita - Erro #" + cod$
      beps = 5
    CASE 71
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Disk drive error - Error code #" + cod$
      warning$(2) = "Drive sem disco - Erro #" + cod$
      beps = 4
    CASE 72
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Disk drive media error - Error code #" + cod$
      warning$(2) = "Disco n„o formatado - Erro #" + cod$
      beps = 4
    CASE 75
      BEEP
      warning$(1) = "Access denied - Error code #" + cod$
      warning$(2) = "Acesso recusado - Erro #" + cod$
      beps = 1
    CASE 76
      BEEP
      warning$(1) = "Invalid directory - Error code #" + cod$
      warning$(2) = "Direct¢rio desconhecido - Erro #" + cod$
      beps = 1
    CASE ELSE
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(1) = "Unknown error - Error code #" + cod$
      warning$(2) = "Erro desconhecido - Erro #" + cod$
      beps = 5
  END SELECT
  aborted = 0
  ignored = 0
  retry = 0
  breaked = 0
  fail = 0
  DO
    COLOR 12: PRINT warning$(pais)
    COLOR 11: PRINT severity$(beps, pais)
    IF pais = 1 THEN COLOR 7: PRINT "Abort, Retry, Ignore, Fail . . . ";
    IF pais = 2 THEN COLOR 7: PRINT "Abortar, Repetir, Ignorar, Falha . . . ";
    reply$ = nul.string$
    DO WHILE reply$ = ""
      reply$ = UCASE$(INKEY$)
    LOOP
    IF ASC(reply$) < 32 THEN
      PRINT ; "^"; CHR$(64 + ASC(reply$))
    ELSE
      PRINT ; reply$
    END IF
    IF reply$ = "A" THEN aborted = -1: EXIT DO
    IF reply$ = "I" THEN ignored = -1: EXIT DO
    IF reply$ = "R" THEN retry = -1: EXIT DO
    IF reply$ = "F" THEN fail = -1: EXIT DO
    IF reply$ = CHR$(3) THEN breaked = -1: EXIT DO
  LOOP
  IF ignored THEN RESTORE.SCREEN "ERRHANDL.SCN": RESUME NEXT
  IF retry THEN RESTORE.SCREEN "ERRHANDL.SCN": RESUME
  RESTORE.SCREEN "ERRHANDL.SCN": SLEEP 1: COLOR 7, 0, 0: CLS
  IF pais = 1 THEN
    IF aborted THEN COLOR 12: PRINT "Program aborted on "; DATE$; " at "; TIME$; "!"
    IF breaked THEN COLOR 12: PRINT "Program breaked on "; DATE$; " at "; TIME$; "!"
    IF fail THEN COLOR 12: PRINT "Operation failed on "; DATE$; " at "; TIME$; "!"
    IF beps > 3 THEN COLOR 28: PRINT "Please contact your local software dealer"
  END IF
  IF pais = 2 THEN
    IF aborted THEN COLOR 12: PRINT "Programa abortado a "; DATE$; " …s "; TIME$; "!"
    IF breaked THEN COLOR 12: PRINT "Programa interrumpido a "; DATE$; " …s "; TIME$; "!"
    IF fail THEN COLOR 12: PRINT "Opera‡„o falhada a "; DATE$; " …s "; TIME$; "!"
    IF beps > 3 THEN COLOR 28: PRINT "Por favor contacte o fornecedor do programa"
  END IF
  PRINT
END

