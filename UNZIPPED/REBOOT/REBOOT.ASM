
ORG 100h            ; Diz-se ao compilador que se trata de um ficheiro COM

JMP comeco

autor     DB   10,13,'REBOOT v1.1 - Junho de 94',10,13
          DB   'Por : Carlos Jorge Santos',10,13
          DB   'Para a SPOOLER MAGAZINE',10,13,'$'

param     DB   10,13,'Uso : REBOOT [/F] [/Q] [/B]'
          DB   10,13,'/F - Reboot a frio'
          DB   10,13,'/Q - Reboot a quente'
          DB   10,13,'/B - Bootstrap Loader',10,13,'$'

bad_par   DB   10,13,'Parƒmetro inv lido.',10,13,'$'

COMECO:

     MOV  AH,09h                             ;Imprime a mensagem
     LEA  DX,autor
     INT  21h

     MOV  SI,81h
     CMP  BYTE PTR[SI],13                    ; Verifica se ha parametros
     JNE  tem_parametros                     ; Se tiver parametros salta
                                             ; se nao tiver informa que se
     MOV  AH,09h                             ; podem usar parametros
     LEA  DX,param
     INT  21h
     MOV  AX,4C01h                           ; Sai para o DOS
     INT  21h                                ; Sai para o DOS com errorlevel 1


TEM_PARAMETROS:

ciclo:
     INC  SI                                 ; Comparamos a linha de comando
     CMP  BYTE PTR[SI],32                    ; com o espa‡o e retiramo-los a
     JE   ciclo                              ; todos

     CMP  BYTE PTR[SI],'/'                   ; Se nao houver uma barra ‚ um
     JE   param_ok                           ; parƒmetro inv lido

PARAM_NOT_OK:
     MOV  AH,09h                             ;Imprime mensagem de erro
     LEA  DX,bad_par
     INT  21h
     MOV  AH,09h                             ; e indica como usar parametros
     LEA  DX,param
     INT  21h
     MOV  AX,4C01h                           ; Sai para o DOS com errorlevel 1
     INT  21h

PARAM_OK:
     INC  SI                            ; Tranforma em maiusculas o caracter
     CMP  BYTE PTR[SI],97               ; da linha de comando, para compara‡„o
     JB   maiuscula
     SUB  BYTE PTR[SI],32
maiuscula:
     CMP  BYTE PTR[SI],'F'
     JE   cold_boot
     CMP  BYTE PTR[SI],'Q'
     JE   warm_boot
     CMP  BYTE PTR[SI],'B'
     JNE  param_not_ok
     INT  19h                                ; Inicia o BOOTSTRAP LOADER

WARM_BOOT:
     MOV  DX,40h                             ; Poe na BIOS data area a
     MOV  DS,DX
     MOV  BX,72h
     MOV  WORD PTR[BX],1234h                 ; flag de reboot = WARM BOOT
     JMP  reboot

COLD_BOOT:
     MOV  DX,40h                             ; Poe na BIOS data area a
     MOV  DS,DX
     MOV  BX,72h
     MOV  WORD PTR[BX],0064h                 ; flag de reboot = COLD BOOT

REBOOT:
     JMP  0FFFFh:0000                        ;Passa o controlo para a rotina
     RET                                     ; de reboot

