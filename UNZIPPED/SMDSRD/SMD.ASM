;
; SMD - Spooler Make Directories...
;
; +++++++++++++++++++++++++++++++++++++++++++++++++++
; EDUARDO MOTA TEXEIRA  (c)  1993  "SPOOLER Magazine"
; +++++++++++++++++++++++++++++++++++++++++++++++++++
;
;
;           MACRO
;
DOS         MACRO  function
            MOV    AH,function
            INT    21h
            ENDM
;
;                 ------       CŸDIGO        ------
;
CodeSeg     SEGMENT
            ASSUME CS:CodeSeg,DS:CodeSeg,ES:CodeSeg,SS:CodeSeg

            ORG    0080h
CommandLine LABEL  BYTE

            ORG    0100h
Inicio:     JMP    Start

;
;                 -----         DADOS         -------
;
DosVersionError    DB 'Necessita DOS 2.0 ou superior...',13,10,'$'
Formato            DB 13,10,'SMD - Cria direct¢rios.',13,10
                   DB 'Sintaxe: SMD [drive:]caminho[ [drive]caminho...]',13,10,'$'
DirKreator         DB ' - Direct¢rio criado',13,10,'$'
AcessoNegado       DB ' - Acesso negado',13,10,'$'
ViaNaoEncontrada   DB ' - N„o encontrado',13,10,'$'
;
;
Start:      DOS    30h                   ; verifica vers„o do DOS...
            CMP    AL,2
            JNB    VersionOK
            MOV    DX,OFFSET DosVersionError
            DOS    9                     ; caso vers„o do DOS n„o esteja
            INT    20h                   ; nos "trinques", sai-se...
VersionOK:  CLD                          ; direc‡„o -> em FREEEENTE!!!!!!
            SUB    CH,CH                 ; CH = 0
            MOV    SI,OFFSET CommandLine
            MOV    CL,[SI]               ; CL agora cont‚m o tamanho da
                                         ; linha de comando...
            INC    SI                    ; SI aponta para o 1§ char...
            PUSH   SI                    ; guarda-se a posi‡„o...
            ADD    SI,CX
            MOV    BYTE PTR[SI],0        ; zero no fim da linha de comando...
                                         ; ( *  ASCIIZ  * )
            POP    SI                    ; restaura-se a posi‡„o para o 1§
                                         ; caractere...
            LODSB
            CMP    AL,' '                ; o 1§ char tem de ser um espa‡o...
            JZ     EspacoOK
WriteForm:  MOV    DX,OFFSET Formato     ; se n„o f“r, d -se uma ajudinha
            DOS    9                     ; indicando ao utilizador qual o
                                         ; modo de proceder com o programa...
            INT    20h
EspacoOK:   LODSB
            CMP    AL,' '                ; os espa‡os em branco s„o ignorados...
            JZ     EspacoOK
            CMP    AL,0                  ; caso se encontre o zero, sai-se...
            JZ     WriteForm             ; sen„o continua...

NotSpaceOK: DEC    SI                    ; ( por causa de LODSB )
            MOV    DI,OFFSET Directory   ; DI -> buffer.
            PUSH   DI
FillBuffer: MOVSB                        ; enche buffer com caracter.
            CMP    BYTE PTR[SI],0        ; se o pr¢ximo char f“r um zero
            JZ     BufferOK              ; acabaram-se os direct¢rios.
            CMP    BYTE PTR[SI],' '      ; caso seja um espa‡o,
                                         ; existe mais um direct¢rio
                                         ; para criar.
            JNZ    FillBuffer            ; caso n„o tenha sido nem o zero,
                                         ; nem o espa‡o, preenche-se o buffer.
BufferOK:   MOV    WORD PTR[DI],'$' * 100h ; nulo antes de '$' para servir
                                         ; tanto como ASCIIZ como para
                                         ; a fun‡„o 09H do DOS ( int 21h ).
            POP    DX                    ; DX -> buffer.
            DOS    9                     ; imprime nome do direct¢rio a criar.
            DOS    39h                   ; fun‡„o 39h da interrup‡„o 21h:
                                         ; cria direct¢rio.
            JC     CheckError            ; se o CF ficou a 1, ‚ porque houve
                                         ; um erro.
            MOV    DX,OFFSET DirKreator
Print:      DOS    9
AfterGood:  INC    SI
            CMP    BYTE PTR[SI-1],' '
            JZ     EspacoOK
            JMP    SHORT Exit

CheckError: CMP    AL,3                  ; !!!! tratamento de erros !!!!...
            JZ     ViaUnknown
            MOV    DX,OFFSET AcessoNegado
            JMP    SHORT Print
ViaUnknown: MOV    DX,OFFSET ViaNaoEncontrada
            JMP    SHORT Print

Exit:       INT    20h                   ; *****      THE END     *****


Directory   LABEL  BYTE                  ; buffer

CodeSeg     ENDS
            END Inicio
