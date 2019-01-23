;
; SRD - Spooler Remove Directories...
;
; **************************************************
; EDUARDO MOTA TEIXEIRA (C) 1993  "SPOOLER Magazine"
; **************************************************
;
;
;           +++++++++++   EQUATES   ++++++++++++
;
ReadOnly    EQU    01h                ; atributo de somente leitura.
Hidden      EQU    02h                ; atributo de escondido.
Subdir      EQU    10h                ; atributo de subdirect¢rio.
RmDir       EQU    3Ah                ; Fun‡„o 3Ah - Remove Directory.
OffsetA     EQU    15h                ; deslocamento na DTA para Atributo de fx.
OffsetN     EQU    1Eh                ; deslocamento na DTA para Nome de fx.
;
;           MACRO
; - activa interrup‡„o 21h do DOS, com n§ de fun‡„o definida durante
;   a execu‡„o do c¢digo.
DOS         MACRO  function
            MOV    AH,function
            INT    21h
            ENDM
;
CodeSeg     SEGMENT
            ASSUME CS:CodeSeg,DS:CodeSeg,ES:CodeSeg,SS:CodeSeg

            ORG    0080h                   ; parƒmetros inseridos no
CommandLine LABEL  BYTE                    ; prompt do DOS ao chamar o
                                           ; programa come‡am no offset
                                           ; 0081h. Em 0080h est  um byte
                                           ; que informa o tamanho (em
                                           ; caracteres) dos parƒmetros.

            ORG    0100h                   ; programa .COM come‡a em 0100h.
Inicio:     JMP    Main
;
;
;           +++++++++++++++++   DADOS   ++++++++++++++++++
;
DirCount           DB     0                ; Conta o n§ de direct¢rios removidos.
Next               DB     0                ; 0 = 1¦ pesquisa.
Nivel              DB     0                ; Nivel de "profundidade"
                                           ; em direct¢rios.
A_or_D             DB     0                ; 'K','D' ou 'A'
SearchAll          DB     '\*.*',0         ; para pesquisa total.
                   ;       ---- mensagens para o utilizador ----
Formato            DB     13,10,'SRD - elimina‡„o de direct¢rios...',13,10
                   DB     'Sintaxe: SRD/A [drive]',13,10
                   DB     '         SRD/D [[drive]caminho]',13,10
                   DB     '         SRD/K [drive]caminho [[drive]caminho [...]]',13,10
                   DB     '         SRD [drive]caminho [[drive]caminho [...]]',13,10,'$'
DirectorioRemovido DB     ' - direct¢rio removido',13,10,'$'
KillDirectory      DB     ' - apagar (S/N)? $'
DosVersion         DB     'Somente DOS 2.0 ou superior...',13,10,'$'
ViaNotFound        DB     ' - N„o encontrado',13,10,'$'
AcessoNegado       DB     ' - Acesso negado',13,10,'$'
NoRemove           DB     'Nenhum direct¢rio removido...',13,10,'$'
DTA                DW     128 + OFFSET Directory   ; ponteiro para a "Data
                                                   ; Transfer Area", utilizada
                                                   ; pelas fun‡”es 4EH e 4FH
                                                   ; dos DOS.
;
;
;           ++++++++++++++++   CŸDIGO   ++++++++++++++++++
;
Main:       CLD                           ; pesquisa e movimenta‡„o de strings
                                          ; ser  feita para a frente...
            DOS    30h                    ; fun‡„o 30h - obt‚m vers„o do DOS.
            CMP    AL,2                   ;
            JNB    VersionOK              ; se n„o f“r uma vers„o inferior a
                                          ; 2.00 a execu‡„o do programa
                                          ; continua,
            MOV    DX, OFFSET DosVersion  ; sen„o imprime mensagem no ecr„
Print:      CALL   DosPrint               ;
            INT    20h                    ; e sai imediatamente...

VersionOK:  MOV    SI,OFFSET CommandLine  ; SI = 0080H
            MOV    CL,[SI]                ; CL = Tamanho da linha de comando
            XOR    CH,CH                  ; CH = 0;
            INC    SI                     ; SI -> 1§ char...
            PUSH   SI                     ; salva posi‡„o
            ADD    SI,CX                  ;
            MOV    BYTE PTR[SI],0         ; Zero no fim ( ASCIIZ ).
            POP    SI                     ; restaura posi‡„o
            CMP    BYTE PTR[SI],'/'       ; ser  o caracter '/' ?
            JZ     Parametros             ; se sim...
            CMP    BYTE PTR[SI],' '       ; ser  o caracter espa‡o ?
            JZ     Ignorar                ; caso afirmativo...

PrintForm:  MOV    DX,OFFSET Formato      ; sen„o
            JMP    SHORT Print            ; imprime mensagem no ecr„
                                          ; e sai !

Parametros: INC    SI                     ; SI -> 2§ char...
            CMP    BYTE PTR[SI],'A'       ; ser  um 'A' ?
            JNZ    CheckAnother1          ; n„o...
            JMP    RemoveSome             ; sim...
CheckAnother1:
            CMP    BYTE PTR[SI],'a'       ; ser  um 'a' ?
            JNZ    CheckAnother2          ; n„o...
            JMP    RemoveSome             ; sim...
CheckAnother2:
            CMP    BYTE PTR[SI],'d'       ; ser  um 'd' ?
            JNZ    CheckAnother3          ; n„o...
            JMP    RemoveSome             ; sim...
CheckAnother3:
            CMP    BYTE PTR[SI],'D'       ; ser  um 'D' ?
            JNZ    CheckAnother4          ; n„o...
            JMP    RemoveSome             ; sim...
CheckAnother4:
            CMP    BYTE PTR[SI],'K'       ; ser  um 'K' ?
            JZ     Kill_Em_All            ; sim...
            CMP    BYTE PTR[SI],'k'       ; sen„o, ser  um 'k'?
            JNZ    PrintForm              ; se n„o f“r n„o ‚ um parƒmetro
                                          ; v lido e sai-se do programa
                                          ; com mensagem.
Kill_Em_All:MOV    [A_Or_D],'K'           ; "A_Or_D" agora cont‚m 'K'.

Ignorar:    INC    SI
SpaceOK:    CALL   IgnoreSpace            ; passam-se os espa‡os … frente.
            CMP    AL,0                   ; caso se encontre o zero,
            JZ     PrintForm              ; imprime-se mensagem no ecr„ e
                                          ; sai-se !
NotSpaceOK: DEC    SI                     ; -por causa de LODSB.
            MOV    DI,OFFSET Directory    ; DI -> buffer...
FillBuffer: MOVSB                         ; enche buffer com caracter...
            CMP    BYTE PTR[SI],0         ; se o pr¢ximo char f“r um zero
            JZ     BufferOK               ; acabaram-se os direct¢rios...
            CMP    BYTE PTR[SI],' '       ; caso seja um espa‡o,
                                          ; existe mais um direct¢rio
                                          ; para criar ...
            JNZ    FillBuffer             ; caso n„o tenha sido nem o zero,
                                          ; nem o espa‡o, enche o buffer...
BufferOK:   MOV    WORD PTR[DI],'$' * 100h; nulo antes de '$'..., para servir
                                          ; tanto como ASCIIZ como para
                                          ; a fun‡„o 09H do DOS ( int 21h )...
            CMP    [A_Or_D],'K'           ; A_Or_D = 'K' ?
            JNZ    ButAi                  ; se n„o f“r igual a 'K'...
            MOV    DX,OFFSET Directory    ; se f“r igual,
            CALL   DosPrint               ; escreve nome do direct¢rio
                                          ; a remover no ecr„,
            MOV    DX,OFFSET KillDirectory; pergunta-se se deseja MESMO
            CALL   DosPrint               ; apag -lo.
            XOR    AX,AX
            INT    16H                    ; espera que uma tecla seja premida
            PUSH   AX
            MOV    DL,AL                  ; escreve ASCII da tecla
            DOS    2                      ; premida no ecr„,
            CALL   Print1310              ; assim como um CR + LF.
            POP    AX
            CMP    AL,53H                 ; 'S'?
            JZ     ButAi                  ; caso afirmativo...
            CMP    AL,73H                 ; 's'?
            JNZ    AfterGood              ; n„o...

ButAi:      MOV    DX,OFFSET Directory
            CALL   DosPrint               ; imprime nome do direct¢rio
            CMP    [Directory],'.'        ; se o nome do direct¢rio come‡ar
                                          ; por um ponto ou f“r um ponto,
            JZ     ANegado                ; n„o ‚ um direct¢rio v lido.
            DOS    RmDir                  ; Remove direct¢rio...
            JC     CheckError             ; se o CF ficou a 1, ‚ porque houve
                                          ; um erro...
            MOV    DX,OFFSET DirectorioRemovido ; sen„o imprime mensagem a
                                          ; confirmar remo‡„o de direct¢rio.
PrintDos:   CALL   DosPrint               ; escreve para o ecr„.
AfterGood:  INC    SI
            CMP    BYTE PTR[SI-1],' '     ; (SI - 1) aponta para um espa‡o ?
            JZ     SpaceOK                ; sim...
            INT    20H                    ; n„o...

CheckError: CMP    AL,3                   ; !!!! tratamento de erros !!!!...
            JZ     ViaUnknown             ; se c¢digo de erro retornado f“r
                                          ; trˆs, significa que o DOS n„o
                                          ; encontra direct¢rio.
            CMP    [A_Or_D],'K'           ; A_Or_D = 'K' ?
            JZ     JumpToKill             ; se sim...
ANegado:    MOV    DX,OFFSET AcessoNegado ; sen„o imprime mensagem de
            JMP    SHORT PrintDos         ; " Acesso negado ".
ViaUnknown: MOV    DX,OFFSET ViaNotFound  ; se foi o c¢digo de erro 3,
            JMP    SHORT PrintDos         ; escreve no ecr„ "n„o encontrado"

JumpToKill: PUSH   SI                     ; salvaguarda SI ( aponta para
                                          ; um espa‡o ou um zero ).
            MOV    DX,OFFSET Directory
            CALL   Print1310              ; CR + LF.
            MOV    [Nivel],1              ; Nivel = 1.
            CALL   DrawSearch             ; vai fazer a pesquisa...
            POP    SI                     ; resgata SI.
            JMP    AfterGood              ; existir  mais um direct¢rio
                                          ; a remover ?...

RemoveSome: DOS    19h                    ; obt‚m Drive...
            INC    AL                     ; Drive A=1,B=2,C=3,...
            MOV    DL,AL
            ADD    AL,'@'                 ; converte drive para caracter ASCII
            MOV    DI,OFFSET Directory
            STOSB                         ; coloca-o em "Directory".
            MOV    BYTE PTR[DI],':'       ; segue-lhe os 2 pontos (':')...
            INC    DI                     ; aponta para DEPOIS dos ':'
            LODSB                         ; lˆ byte de DS:SI para AL.
            CMP    AL,'d'                 ; ser  'd' ?
            JZ     Metallica              ; sim...
            CMP    AL,'D'                 ; sen„o, ser  um 'D' ?
            JNZ    RemoveAllDirectory     ; n„o...
Metallica:  JMP    RemoveCurrentDirectory ; sim...


RemoveAllDirectory:
            CALL   IgnoreSpace            ; passa os espa‡os … frente...
            CMP    AL,0                   ; ser  o zero ?
            JZ     DrawSearch             ; sim...
            MOV    [Directory],AL         ; sen„o, move caracter para Directory.
            LODSB                         ; lˆ pr¢ximo caracter.
            CMP    AL,':'                 ; ser„o os ':' ?
            JNZ    GotoPrint              ; n„o...
            CALL   IgnoreSpace            ; passa os espa‡os ...
            CMP    AL,0                   ; ser  um nulo ?
            JZ     DrawSearch             ; sim...
GotoPrint:  JMP    PrintForm              ; sen„o, escreve mensagem no ecr„
                                          ; e sai.
DrawSearch: MOV    SI,OFFSET SearchAll    ; SI -> '\*.*',0
            MOV    CX,5                   ; s„o 5 caracteres.
            REP    MOVSB                  ; DS:SI -> ES:DI
            MOV    DX,[DTA]               ; define novo endere‡o para
            DOS    1Ah                    ; a  rea de transferˆncia de dados
            CMP    [Next],0               ; Primeira pesquisa no direct¢rio ?
            JNZ    FindNext               ; se n„o o f“r...
            MOV    DX,OFFSET Directory    ; caso contr rio...
            MOV    CX,SubDir + Hidden     ; Atributo de pesquisa.
            DOS    4Eh                    ; Encontra 1¦ entrada de direct¢rio.
            JMP    SHORT CheckCF          ; vai-se verificar o flag de carry

FindNext:   DOS    4Fh                    ; Encontra pr¢xima entrada de direct¢rio.
CheckCF:    JNC    CheckAttrib            ; se CF = 1, n„o encontrou mais entradas...
            JMP    CheckLevel             ; se CF = 0, existem + entradas...

CheckPara:  CMP    [A_Or_D],'K'           ; A_Or_D = 'K' ?
            JNZ    FindNext               ; n„o...
                                          ; caso contr rio...
RemoveFiles:CMP    BYTE PTR[SI + OffsetA],ReadOnly ; verifica atributo
                                          ; de ficheiro encontrado.
            JZ     ChangeAttr             ; Somente de leitura ? se sim...
            CMP    BYTE PTR[SI + OffsetA],ReadOnly + Hidden
                                          ; somente de leitura e escondido ?
            JNZ    RemoveF                ; n„o...

ChangeAttr: MOV    DX,SI                  ; sim,
            ADD    DX,OffsetN             ; muda atributo para
            SUB    CX,CX                  ; o de arquivo
            MOV    AL,01H                 ; normal.
            DOS    43H                    ; fun‡„o 43h e subfun‡„o 01h.

RemoveF:    ADD    SI,OffsetN             ; SI -> nome do ficheiro encontrado
            STD                           ; pesquisa de string ser  efectuada
                                          ; para tr s...!
            CALL   ScanForBar             ; procura caracter '\' em "Directory"
            CLD                           ; em frente...!
            INC    DI                     ; incrementa DI duas vezes para que
            INC    DI                     ; fique a apontar a seguir
                                          ; ao caracter '\'.
ReLeitura:  MOVSB                         ; DS:SI (nome de ficheiro encontrado)
                                          ; para ES:DI ( buffer "Directory" ).
            CMP    BYTE PTR[SI - 1],0     ; j  se moveu para DI o zero ?
            JNZ    ReLeitura              ; n„o...
            MOV    BYTE PTR[DI],'$'       ; sim, p”e-se '$' ap¢s o zero( para
                                          ; a fun‡„o 9 do DOS int 21h ).
            MOV    DX,OFFSET Directory    ; DX -> buffer Directory.
            CALL   DosPrint               ; escreve para o ecr„
            PUSH   DX
            CALL   Print1310              ; CR + LF
            POP    DX
            DOS    41H                    ; fun‡„o 41h, remove ficheiro.
            JMP    FindNext               ; vai procurar pr¢xima entrada...

CheckAttrib:MOV    SI,[DTA]               ; Verifica atributo do fx encontrado...
            CMP    BYTE PTR[SI + OffsetA],SubDir
            JZ     CheckEntry             ;  um direct¢rio ? se sim...
            CMP    BYTE PTR[SI + OffsetA],SubDir + Hidden
                                          ; Š um direct¢rio escondido ?
            JNZ    CheckPara              ; n„o...
                                          ; se sim,
CheckEntry: ADD    SI,OffsetN             ; SI aponta para o seu nome.
            CMP    BYTE PTR[SI],'.'       ; '.' ou '..' ?
            JZ     FindNext               ; se verdadeiro, vai procurar outra
                                          ; entrada...
            CALL   ScanForZero            ; sen„o, procura o nulo em buffer
            STD                           ; Directory. Direc‡„o: para tr s!
            CALL   ScanForBar             ; procura separador de direct¢rios.
            INC    DI                     ; DI = DI + 2.
            INC    DI                     ; Aponta para depois do char '\'
            CLD                           ; direc‡„o: em frente !
FillDir:    MOVSB                         ; Escreve o nome do fx encontrado
            CMP    BYTE PTR[SI - 1],0     ; em buffer.
            JNZ    FillDir                ; enquanto n„o encontrar o zero...
            MOV    BYTE PTR[DI],'$'       ; p”e o char '$' ap¢s o zero para
                                          ; a fun‡„o 9 int 21h.
            MOV    DX,OFFSET Directory    ; DX -> buffer.
            DOS    RmDir                  ; Tenta apagar direct¢rio...
            JC     ClimbOneLevel          ; Se houver erro, o dir. n„o est  vazio...
            INC    [DirCount]             ; sen„o incrementa-se  o n§ de
                                          ; direct¢rios removidos.
            MOV    DX,OFFSET Directory    ; DX -> buffer.
            CALL   DosPrint               ; Imprime nome do dir. no ecr„.
            CALL   Removed                ; imprime mensagem de sucesso no ecr„.
            JMP    FindNext               ; Vai procurar nova entrada
                                          ; de direct¢rio...

ClimbOneLevel:
            INC    [Nivel]                ; incrementa o n¡vel...
            CMP    [A_or_D],'K'           ; A_Or_D = 'K' ?
            JZ     MotleyCrue             ; se sim...
            ADD    [DTA],43               ; sen„o, posiciona correctamente o
                                          ; ponteiro para a DTA.
MotleyCrue: MOV    [Next],0               ; ser  a primeira pesquisa efectuada
                                          ; nesse novo direct¢rio.
            CALL   ScanForZero            ; Procura o caracter nulo final.
            JMP    DrawSearch

CheckLevel: CMP    [A_Or_D],'K'           ; A_Or_D = 'K' ?
            JZ     CheckThisOut           ; se sim...
            CMP    [Nivel],0              ; sen„o, Nivel = 0 ?
            JZ     EndOfSearch            ; sim ( root )...
            DEC    [Nivel]                ; n„o, decrementa-se o n¡vel.
            MOV    [Next],1               ; Next = 1 : n„o ‚ a primeira
                                          ; pesquisa efectuada nesse direct¢rio.
            SUB    [DTA],43               ; recupera DTA anterior.
            CALL   ScanForZero            ; Procura o zero.
            STD                           ; Em "marcha atr s",
            CALL   ScanForBar             ; procura '\'.
            REPNZ  SCASB                  ; novamente ( direct¢rio anterior )...
            INC    DI                     ; DI aponta para o char '\'...
            CLD                           ; Em frente !!!
            JMP    DrawSearch

EndOfSearch:CMP    [DirCount],0           ; N§ de dir. vazios eliminados = 0 ?
            JNZ    Done                   ; n„o...
            MOV    DX,OFFSET NoRemove     ; sim,
            CALL   DosPrint               ; avisa-se o utilizador.
Done:       JMP    SHORT Exit             ; sai !

CheckThisOut:
            STD                           ; pesquisa em "marcha-atr s"
            CALL   ScanForBar             ; do caracter '\'
            DEC    [Nivel]                ; Nivel = Nivel - 1
            CMP    [Nivel],0              ; Nivel = 0 ?
            JZ     LastLevel              ; sim...
            REPNZ  SCASB                  ; n„o, ent„o posiciona-se
                                          ; correctamente DI.
            CLD
            INC    DI                     ; DI aponta para o caracter '\'
            JMP    DrawSearch
LastLevel:  CLD
            INC    DI                     ; DI aponta para o caracter '\'
            MOV    BYTE PTR[DI],0         ; que ‚ substitu¡do por um zero.
            MOV    DX,OFFSET Directory    ; DX -> buffer Directory.
            DOS    RmDir                  ; remove direct¢rio...
            RET                           ; regressa...


RemoveCurrentDirectory:
            CALL   IgnoreSpace            ; passa os espa‡os.
            CMP    AL,0                   ; ser  um zero ?
            JNZ    Depois                 ; n„o...
            MOV    BYTE PTR[DI],'\'       ; move para local apontado por
                                          ; DI no buffer Directory o caracter
                                          ; '\'.
            INC    DI                     ; incrementa DI.
            MOV    SI,DI                  ; DS:SI -> buffer
            DOS    47h                    ; fun‡„o 47h - Obt‚m direct¢rio
                                          ;              corrente.
            CALL   ScanForZero            ; procura o fim da string.
            JMP    SHORT AfterEnche
Depois:     MOV    DI,OFFSET Directory    ; DI -> buffer Directory.
            DEC    SI                     ; SI = SI - 1
Enche:      MOVSB                         ; DS:SI -> ES:DI
            CMP    BYTE PTR[SI - 1],0     ; j  moveu para ES:DI o nulo ?
            JNZ    Enche                  ; n„o, volta a mover caracteres
            DEC    DI                     ; sen„o p”e-se DI apontar para
                                          ; o nulo.
AfterEnche: INC    [A_or_D]               ; A_Or_D = 1;
            JMP    DrawSearch

Exit:       INT    20h                    ; sa¡da.


; --------------------------------------------------------------- ;
; DosPrint: (MOV DX, OFFSET *buffer*                              ;
;            MOV AH,09h                                           ;
;            INT 21h )                                            ;
; --------------------------------------------------------------- ;
Removed:    MOV    DX,OFFSET DirectorioRemovido
DosPrint:   DOS    9
            RET

; -------------------------------------------------------------- ;
; ScanForZero: procura o zero em 128 bytes de "Directory", e faz ;
;              DI apontar para ele...                            ;
; -------------------------------------------------------------- ;
ScanForZero:MOV    DI,OFFSET Directory
            MOV    CX,128
            XOR    AL,AL
            REPNZ  SCASB
            DEC    DI
            RET

; -------------------------------------------------------------- ;
; ScanForBar: procura em ES:DI o caracter '\' ao longo de 128    ;
;             bytes...                                           ;
; -------------------------------------------------------------- ;
ScanForBar: MOV    AL,'\'
            MOV    CX,128
            REPNZ  SCASB
            RET

; -------------------------------------------------------------- ;
; Print1310: Carriage Return + Line Feed ( Muda de linha )       ;
; -------------------------------------------------------------- ;
Print1310:  MOV    DX,OFFSET AcessoNegado + 16
            CALL   DosPrint
            RET

; -------------------------------------------------------------- ;
; IgnoreSpace: lˆ caracter de DS:SI enquanto f“r um espa‡o em    ;
;              branco...                                         ;
; -------------------------------------------------------------- ;
IgnoreSpace:LODSB
            CMP    AL,' '
            JZ     IgnoreSpace
            RET

Directory   LABEL  BYTE                   ; buffer para armazenar os
                                          ; bytes que formam os nomes
                                          ; dos direct¢rios e ficheiros.

; (DTA come‡a 128 bytes depois de "Directory"...)

CodeSeg     ENDS
            END Inicio
