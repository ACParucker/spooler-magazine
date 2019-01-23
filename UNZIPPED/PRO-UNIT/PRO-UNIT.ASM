r
a
;-----------------------------------------------------------------------------
; PRO-UNIT.ASM: C¢digo-fonte do programa PRO-UNIT.
; Por Marcos Sim”es
; As letras ®r¯ e ®a¯ na primeira e segunda linhas, respectivamente, s„o co-
; mandos do Debug e n„o devem ser alterados de qualquer maneira.
; O programa ‚ constitu¡do de um £nico segmento e ‚ cont¡guo.
; Para se compilar usando o Debug, executar o comando DEBUG<PRO-UNIT.ASM>NUL
; (o Debug faz parte do conjunto de utilit rios do MS-DOS, e qualquer vers„o
; serve) a partir da linha de comando do DOS (a assemblagem demora alguns
; segundos a executar).
; Todos os valores est„o em hexadecimal.
; A assemblagem come‡a automaticamente em CS:0100h.
;
        jmp 95a ;saltar o bloco de dados
;
; Aqui inicia-se o bloco de dados (CS:0103h):
;
        db 1a 
        ;este byte pode ser ignorado, pois s¢ serve para que a listagem
        ;pare aqui, se se usar o comando TYPE do MS-DOS
        db "PRO-UNIT - Sistema De Protec‡„o De Unidades",0d,0a
        db "Programado Por Marcos Sim”es",0d,0a
        db "Introduza a password de acesso (10 caracteres no m ximo):",0d,0a
        db 24 
        ;mensagem de inicia‡„o (INIT_MSG, 104h)
        db "Acesso negado.",0d,0a,07,24 
        ;(ACC_NEG, 18bh)
        db "Acesso permitido.",0d,0a,24
        ;(ACC_PERM, 19dh)
        db "Erro na linha de comando.",0d,0a
        db "Sintaxe correcta: pro-unit /ac‡„o [drive:]",0d,0a
        db 'Onde ac‡„o ‚ uma letra precedida de "/":',0d,0a
        db "/p - Proteger a unidade (necessita do parƒmetro drive:).",0d,0a
        db "/d - Desproteger a unidade (necessita do parƒmetro drive:).",0d,0a
        db "/r - Restaurar o direct¢rio ra¡z (necessita do parƒmetro "
        db "drive:).",0d,0a
        db "/m - Modificar a password de acesso ao programa, que se deve "
        db "encontrar no direc-t¢rio actual.",0d,0a
        db "Drive: ‚ um parƒmetro representando a unidade em que o programa "
        db "deve actuar.",0d,0a
        db "Usar apenas com os comandos que o necessitem.",0d,0a,07,24
        ;(ERROR_COM,1b1h)
        db "Processando...",0d,0a,24 
        ;(PROC, 3bah)
        db "Acabado.",0d,0a,24 
        ;(END, 3cbh)
        db "Introduzir a nova password (10 caracteres no m ximo):",0d,0a,24
        ;(N_PW, 3d6h)
        db "Repetir a password:",0d,0a,24 
        ;(REP_PW, 40eh)
        db "Repeti‡„o incorrecta.",0d,0a,07,24 
        ;(REP_INC, 424h)
        db "Repeti‡„o correcta.",0d,0a,24 
        ;(REP_OK, 43dh)
        db "Erro em opera‡„o de disco: ",07,24 
        ;(DISK_ERROR, 453h)
        db "Erro em manuseamento do ficheiro: ",07,24 
        ;(FILE_ERROR, 470h)
        db 0d,0a,"Ocorreu um erro muito invulgar. Contactar o Marcos Sim”es "
        db "pelo n£mero de telefo-ne (01) 4104591.",0d,0a,24
        ;(DISK_INV, 494h)
        db "Marca de direc‡„o n„o encontrada.",0d,0a,24 
        ;(DISK_DIR, 4f9h)
        db "Disquete protegida contra escrita.",0d,0a,24 
        ;(DISK_PRO, 51dh)
        db "Sector n„o encontrado.",0d,0a,24 
        ;(DISK_SEC, 542h)
        db "Erro no DMA.",0d,0a,24 
        ;(DISK_DMA, 55b)
        db "Erro de CRC.",0d,0a,24 
        ;(DISK_CRC,56ah)
        db "Erro no controlador de disco.",0d,0a,24 
        ;(DISK_CONTROL, 579h)
        db "Erro de busca.",0d,0a,24 
        ;(DISK_BUSCA, 599h)
        db "Tempo excedido (time-out).",0d,0a,24 
        ;(DISK_OUT, 5aah)
        db "Abortar (a); repetir (r); ignorar o erro e continuar (c)? ",24
        ;(DISK_REP, 5c7h)
        db 0d,0a,"Um erro muito invulgar ocorreu. O ficheiro est  "
        db "provavelmente corrupto.",0d,0a,"Obter uma nova c¢pia do "
        db "programa contactando o Marcos Sim”es atrav‚s do telefone"
        db "(01) 4104591.",0d,0a,24 
        ;(FILE_INV, 602h)
        db "PRO-UNIT.COM n„o encontrado.",0d,0a,24 
        ;(FILE_NE, 6adh)
        db "Insuficientes file handles.",0d,0a,24 
        ;(FILE_IFH, 6cch)
        db "Acesso ao ficheiro negado.",0d,0a,24 
        ;(FILE_NEG, 6eah)
        db "Erro no file handle.",0d,0a,24 
        ;(FILE_EFH, 707h)
        db "PRO-UNIT.COM",00 
        ;nome do ficheiro a manusear (FILE, 71eh)
        db 2d,20,20,20,20,20,20,20,20,20,20 
        ;password codificada (PW, 72bh)
        db 0b,00,00,00,00,00,00,00,00,00,00,00,00 
        ;buffer para a introdu‡„o da password e para a sua modifica‡„o
        ;(PW_N, 736h)
        db 0b,00,00,00,00,00,00,00,00,00,00,00,00 
        ;buffer para a repeti‡„o da password (PW_REP, 743h)
        db 00,00,00,00,01,00,5a,07,00,00 
        ;buffer com a informa‡„o para a leitura/escrita do disco 
        ;(DISK_INFO, 750h); a leitura/escrita absoluta de disco usando o m‚to-
        ;do do DOS (INT 25/INT 26) funciona preenchendo AL com o n£mero da
        ;unidade, BX com a direc‡„o do buffer contendo a informa‡„o respeitan-
        ;te … opera‡„o de leitura/escrita, e CX com o valor FFFFh; o buffer
        ;deve conter numa doubleword o sector inicial, numa word o n£mero de
        ;sectores a ler/gravar, e numa doubleword a direc‡„o de mem¢ria do
        ;buffer para leitura/escrita de dados; esta ordem tem que ser respei-
        ;tada; usa-se INT 25 para leitura e INT 26 para escrita
        ;o seguinte comando do Debug preenche a zona da mem¢ria de 75ah a 94fh
        ;(inclusive) com zeros (00h), constitu¡ndo o buffer para a transferˆn-
        ;cia de sectores de e para o disco (DISK_BUFFER, 75ah)
;-----------------------------------------------------------------------------

f cs:75a l 200 00
a 95a
;-----------------------------------------------------------------------------
;A seguir ao buffer de 512 bytes (200h), que ‚ o tamanho de um sector, o pro-
;grama procede na direc‡„o 95ah.
;
        mov ah,9 ;fun‡„o escrever string
        mov dx,104 ;direc‡„o da string (INIT_MSG)
        int 21 ;chamada ao DOS
        mov ah,0a ;fun‡„o introduzir string a partir do teclado
        mov dx,736 ;direc‡„o do buffer (PW_N); o buffer deve ter no seu pri-
                   ;meiro byte o n£mero de caracteres a introduzir, inclu¡ndo
                   ;o ENTER; o segundo byte ‚ preenchido pelo DOS com o n£mero
                   ;de caracteres introduzidos, sem contar com o ENTER; os
                   ;restantes bytes s„o o espa‡o onde o DOS escreve a string
                   ;introduzida, finalizando com 0dh (ENTER)
        int 21 ;chamada ao DOS
        ;ciclo de descodifica‡„o da password
        mov si,72b ;direc‡„o de PW
        mov di,si
        mov cx,b
        cld ;df=0 (incrementar direc‡”es de strings de destino e de fonte)
;971:
        lodsb ;ler byte actual da string para AL (DS:SI)
        sub al,20 ;subtra¡r 20h de AL
        stosb ;gravar AL na posi‡„o actual da string (ES:DI)
        loop 971
        ;ciclo de compara‡„o de passwords
        mov si,72b ;password de acesso
        mov di,738 ;password introduzida (n„o se contam os dois primeiros
                   ;bytes do buffer)
        mov cx,b ;comprimento das passwords
        cld
        repz cmpsb ;comparar strings de bytes
        jcxz 98e ;saltar se compara‡„o conclu¡da, ou seja, bem sucedida
        mov ah,9 ;passwords n„o coincidentes
        mov dx,18b ;direc‡„o de ACC_NEG
        int 21
        int 20 ;sa¡r
;98e:
        mov ah,9
        mov dx,19d ;direc‡„o de ACC_PERM
        int 21
;In¡cio da verifica‡„o da linha de comando.
        mov si,81 ;apontar SI para a direc‡„o da linha de comando, situada
                  ;no PSP (Prefixo de Segmento de Programa)
        cmp word ptr [si],2f20 ;verificar se a linha de comando inicia com
                               ;os caracteres " " (20h) e "/" (2fh)
        jz 9a7 ;se assim for, saltar para 9a7h
;99e:
        mov ah,9 ;pequena rotina que exibe uma mensagem e sai quando a linha
                  ;de comando est  errada
        mov dx,1b1 ;direc‡„o de ERROR_COM
        int 21
        int 20
;9a7
        add si,2 ;avan‡ar na linha de comando
        cmp word ptr [si],0d6d ;comparar com "m" seguido de ENTER
        jz 9f0 ;se assim for, passar … rotina de modifica‡„o da password
        mov dl,ff ;verificar validade da linha de comando para outras op‡”es
        nop ;esta instru‡„o encontra-se aqui apenas para manter igualdade com
            ;o execut vel, podendo-se por isso ignor -la
        cmp word ptr [si],2070 ;comparar com "p "
        jnz 9bb ;se n„o for, passar … seguinte compara‡„o
        mov dl,00 ;se for, indicar em DL
;9bb:
        cmp word ptr [si],2064 ;comparar com "d "
        jnz 9c3
        mov dl,01
;9c3:
        cmp word ptr [si],2072 ;comparar com "r "
        jnz 9cb
        mov dl,02
;9cb:
        add si,2 ;em DL obt‚m-se, agora, o n£mero correspondente … fun‡„o
                 ;pedida, ou ffh se ocorreu um erro
        mov al,[si] ;AL=[SI]
        inc si
        cmp word ptr [si],0d3a ;comparar com ":" seguido de ENTER
        jnz 99e ;se n„o for, saltar para a rotina de erro na linha de comando
        push ax ;guardar o conte£do de AX na pilha, pois em AL cont‚m a unida-
                ;de em que o programa deve actuar; isto ‚ necess rio pois AL,
                ;entretanto, ‚ destru¡do
        cmp dl,00 ;DL=00h?
        jnz 9e0 ;se n„o, salta para a pr¢xima verifica‡„o
        jmp b99 ;se sim, salta para a rotina correspondente … fun‡„o /p
;9e0:
        cmp dl,01
        jnz 9e8
        jmp bf2 ;salta para a rotina correspondente … fun‡„o /d
;9e8:
        cmp dl,02
        jnz 99e ;se n„o for, ‚ porque o utilizador n„o especificou correcta-
                ;mente a fun‡„o; salta para a rotina de erro na linha de co-
                ;mando
        jmp c4b ;salta para a rotina correspondente … fun‡„o /r
;
;Acabou a rotina de tratamento da linha de comando. De seguida come‡a a rotina
;correspondente … fun‡„o /m, ou seja, modificar a password, na direc‡„o 9f0h.
;
        mov si,743 ;direc‡„o de PW_REP
        mov di,736 ;direc‡„o de PW_N
        mov cx,d ;comprimento dos dois buffers
        cld ;este ciclo destina-se a fazer a restaura‡„o do buffer PW_N para
        repz movsb ;que possa receber a nova password; para isso, copia-se o
                   ;buffer PW_REP sobre PW_N, visto que no in¡cio do programa
                   ;ambos os buffers s„o iguais
        mov ah,9
        mov dx,3d6 ;direc‡„o de N_PW
        int 21
        mov ah,0a ;introduzir sting a partir do teclado
        mov dx,736 ;direc‡„o de PW_N
        int 21
        mov ah,9
        mov dx,40e ;direc‡„o de REP_PW
        int 21
        mov ah,0a
        mov dx,743 ;direc‡„o de PW_REP
        int 21
        mov si,736 ;feita a introdu‡„o da nova password e a sua repeti‡„o,
        mov di,743 ;vamos agora comparar os buffers correspondentes para veri-
        mov cx,d   ;ficar se a repeti‡„o est  de acordo com a nova password
        cld
        repz cmpsb
        jcxz a2f ;se a compara‡„o se concluiu, ou seja, se foi bem sucedida,
                 ;saltamos para a2fh, sen„o, continuamos
        mov ah,9
        mov dx,424 ;direc‡„o de REP_INC
        int 21
        int 20 ;sa¡r para o DOS
;a2f:
        mov ah,9
        mov dx,43d ;direc‡„o de REP_OK
        int 21
        mov dx,3ba ;direc‡„o de PROC
        int 21
        mov si,738 ;direc‡„o do buffer PW_N (onde se encontra a nova password)
        mov di,si ;tirando os dois primeiros bytes
        mov cx,b ;comprimento da string introduzida mais CR
        cld
;a44:        
        lodsb
        add al,20
        stosb
        loop a44 ;este ciclo destina-se a codificar a password introduzida
        mov ax,3d01 ;AH=fun‡„o abrir ficheiro existente; AL=m‚todo de acesso:
                    ;apenas escrita
        mov dx,71e ;direc‡„o de FILE: string com o nome do ficheiro a abrir
        int 21 ;chamada ao DOS
        jnc a8e ;se n„o ocorreu nenhum erro (CF=0), saltar a rotina de proces-
                ;samento de erros de ficheiro
;Aqui inicia-se a rotina de processamento de erros de ficheiro, que imprime
;uma mensagem indicando qual o erro e sai para o DOS. Situa-se na direc‡„o
;a54h e chama-se atrav‚s de um simples JMP, pois n„o tem retorno.
        push ax ;guardar AX, pois possui o c¢digo de erro
        mov ah,9
        mov dx,470 ;direc‡„o de FILE_ERROR
        int 21
        pop ax ;restaurar AX
        mov dx,0 ;verificar qual o erro
        cmp ax,2 ;ficheiro n„o encontrado
        jnz a68 ;se n„o for, passar … pr¢xima verifica‡„o
        mov dx,6ad ;direc‡„o de FILE_NE
;a68:
        cmp ax,4 ;insuficientes file handles
        jnz a70
        mov dx,6cc ;direc‡„o de FILE_IFH
;a70:
        cmp ax,5 ;acesso negado
        jnz a78
        mov dx,6ea ;direc‡„o de FILE_NEG
;a78:
        cmp ax,6 ;erro no file handle
        jnz a80
        mov dx,707
;a80:
        cmp dx,0 ;se nenhum dos erros acima ocorreu (portanto, DX=0), ent„o
        jnz a88 ;indicar que ocorreu um erro muito invulgar
        mov dx,602 ;direc‡„o de FILE_INV
;a88:
        mov ah,9 ;tendo j  em DX a direc‡„o correspondente a uma mensagem
        int 21 ;consoante o erro que ocorreu, imprimimos essa mensagem e
        int 20 ;sa¡mos
;a8e:
        mov bx,ax ;se n„o ocorreu erro, continuamos aqui; esta instru‡„o mete
                  ;o file handle (devolvido em AX) em BX, que ‚ o registo
                  ;onde as outras fun‡”es utilizadas v„o buscar o file handle
        mov ax,4200 ;AH=fun‡„o mover ponteiro de leitura/escrita; AL=m‚todo:
                    ;mover ponteiro desde o in¡cio do ficheiro
        mov cx,0 ;valor mais significativo: 0
        mov dx,62b ;valor menos significativo: 62b (direc‡„o de PW, retirando
                   ;os 100h bytes correspondentes ao PSP)
        int 21
        jc a54 ;se ocorreu um erro saltar para a rotina de processamento de
               ;erros de ficheiro (a54h)
        mov ah,40 ;fun‡„o escrever ficheiro
        mov cx,b ;n£mero de bytes a gravar
        mov dx,738 ;direc‡„o dos dados a gravar (PW_N)
        int 21
        jc a54
        mov ah,3e ;fun‡„o fechar ficheiro
        int 21
        jc a54
        mov ah,9
        mov dx,3cb ;direc‡„o de END
        int 21
        int 20 ;a fun‡„o requesitada est  cumprida; sa¡r
;Inicia aqui (ab8h) a rotina que serve as fun‡”es /p, /d e /r. A sua fun‡„o
:‚ ler o Generic Boot Record (sector l¢gico DOS 0000h) e retornar, usando os
;dados contidos no bloco de parƒmetros da BIOS (que se encontra na direc‡„o
;3h dentro do sector do BOOT), o sector inicial (primeiro sector da FAT) e o
;n£mero de sectores a trabalhar (todos os sectores da FAT e do ROOT DIR). Pas-
;sa-se o controlo a esta rotina com CALL, tendo o n£mero da unidade em AL.
        mov word ptr [758],cs ;escrever CS na direc‡„o 758h (£ltimos dois by-
                              ;tes do buffer DISK_INFO)
        mov bx,750 ;direc‡„o do buffer DISK_INFO
        mov cx,ffff ;leitura por parti‡”es usando um buffer
        mov dx,cx ;DX=FFFF; esta ac‡„o serve para que no caso de acontecer um
                  ;erro de disco a rotina de processamento de erros possa sa-
                  ;ber que o erro ocorreu quando se tentava ler o BOOT
        push ax ;guardar AX pois ‚ destru¡do pelo INT 25 e tamb‚m pelo INT 26
                ;isto ‚ necess rio pois AL cont‚m o n£mero da unidade
        int 25 ;interrup‡„o DOS de ler sectores absolutos
        jc acc ;se ocorreu um erro saltar para acch (CF=1)
        jmp b77 ;se n„o, saltar a rotina de tratamento de erros e continuar
;acc:
        popf ;restaurar as bandeiras gravadas na pilha pelo INT 25
;Na direc‡„o acdh inicia-se a rotina de tratamento de erros de disco, usada
;pelos comandos /p, /d e /r. A rotina comunica o erro ao utilizador e pergunta
;qual a ac‡„o a tomar (abortar, repetir ou continuar). Chama-se com CALL.
        push dx ;DX cont‚m o identificador de qual a ac‡„o de leitura/escrita
                ;do disco: FFFFh indica que foi a leitura do sector do BOOT e 
                ;portanto sai imediatamente para o DOS; 0h indica todas as
                ;outras; como se ocorrer um erro ao ler o BOOT n„o existe re-
                ;torno, pode-se a¡ fazer a chamada … rotina com JMP
        push ax ;AH cont‚m o erro
        mov ah,9
        mov dx,453 ;direc‡„o de DISK_ERROR
        int 21
        pop ax
        mov dx,0
        cmp ah,2 ;verifica‡„o do c¢digo de erro devolvido em AH pelo INT 25
        jnz ae2
        mov dx,4f9 ;direc‡„o de DISK_DIR
;ae2:
        cmp ah,3
        jnz aea
        mov dx,51d ;direc‡„o de DISK_PRO
;aea:
        cmp ah,4
        jnz af2
        mov dx,542 ;direc‡„o de DISK_SEC
;af2:
        cmp ah,8
        jnz afa
        mov dx,55b ;direc‡„o de DISK_DMA
;afa:
        cmp ah,10
        jnz b02
        mov dx,56a ;direc‡„o de DISK_CRC
;b02:
        cmp ah,20
        jnz b0a
        mov dx,579 ;direc‡„o de DISK_CONTROL
;b0a:
        cmp ah,40
        jnz b12
        mov dx,599 ;direc‡„o de DISK_BUSCA
;b12:
        cmp ah,80
        jnz b1a
        mov dx,5aa ;direc‡„o de DISK_OUT
;b1a:
        cmp dx,0 ;nenhum dos erros acima ocorreu?
        jnz b22
        mov dx,494 ;direc‡„o de DISK_INV
;b22:
        mov ah,9 ;imprimir mensagem correspondente ao erro
        int 21
        pop dx ;restaurar DX
        cmp dx,ffff ;a opera‡„o que originou o erro foi a leitura do BOOT?
        jnz b2e ;se n„o, prosseguir
        int 20 ;se sim, sa¡r
;b2e:
        mov dx,5c7 ;direc‡„o de DISK_REP
        int 21
;b33:        
        mov ah,01 ;fun‡„o retornar tecla premida (em AL)
        int 21 ;chamar ao DOS
        push ax
        mov ah,9
        mov dx,188 ;esta direc‡„o aponta para os bytes 0d,0a,24 (24h=fim de
                   ;string); destina-se a mudar de linha ap¢s o utilizador ter
                   ;premido uma tecla
        int 21
        pop ax
        cmp al,61 ;AL (tecla premida)="a"?
        jnz b4d ;se n„o, saltar para b4dh
        mov ah,9 ;se sim, imprimir mensagem e sa¡r
        mov dx,3cb ;direc‡„o de END
        int 21
        int 20
;b4d:
        cmp al,72 ;AL="r"?
        jnz b5f
        mov ah,9
        mov dx,3ba ;direc‡„o de PROC
        int 21
        pop dx ;se tiver sido escolhido "repetir", ent„o, ap¢s se ter imprimi-
        pop ax ;do a mensagem, tem que se saltar para 9 bytes antes da chamada
        sub dx,9 ;CALL … rotina de processamento de erros; para isso, com POP
        push dx ;DX, retorna-se em DX a direc‡„o de retorno, previamente guar-
        ret ;dada na pilha pela instru‡„o CALL; de seguida retorna-se, tamb‚m
            ;com POP, a unidade em AL; subtrai-se 9 a DX, e guarda-se DX na
            ;pilha, podendo agora sa¡r da rotina de processamento de erros a-
            ;trav‚s de RET
;b5f:
        cmp al,63 ;AL="c"?
        jnz b6e
        mov ah,9
        mov dx,3ba ;direc‡„o de PROC
        int 21
        pop dx ;se se escolheu "continuar", ter  que se p“r as bandeiras na
        pushf ;pilha para que possam ser restauradas pela instru‡„o POPF, que
        push dx ;‚ para onde se vai retornar; para isso, o registo das bandei-
        ret ;ras teria que estar na pilha depois da direc‡„o de retorno; caso
            ;contr rio, a instru‡„o RET retornaria usando o registo das ban-
            ;deiras em vez da direc‡„o de retorno; assim, usando esta sequˆn-
            ;cia de instru‡”es, a direc‡„o de retorno fica antes das bandeiras
;b6e:
        mov ah,9 ;se se chegou aqui, ‚ porque o utilizador n„o escolheu uma
        mov dx,5c7 ;op‡„o correcta, de maneira que se volta a imprimir a per-
        int 21 ;gunta DISK_REP e salta-se para o in¡cio do c¢digo que cont‚m
        jmp b33 ;as ac‡”es a tomar consoante a resposta do utilizador
;Aqui continua a rotina de retorno do n£mero de sectores e do sector inicial,
;na direc‡„o b77h.
        popf ;restaurar as bandeiras guardadas na pilha pelo INT 25
        mov bx,[768] ;BX=sector inicial; a posi‡„o relativa eh do sector do
                     ;BOOT indica o n£mero de sectores de BOOT (normalmente 1)
                     ;que ‚ igual ao sector inicial da FAT, visto o primeiro 
                     ;sector ser o 0h
        mov [750],bx ;a posi‡„o do buffer DISK_INFO correspondente ao sector
                     ;inicial ‚ carregada com BX
        mov bl,[76a] ;BL=n§ de c¢pias da FAT
        mov ax,[770] ;AX=n§ de sectores/FAT
        mov bh,00 ;BH=0h
        mul bx ;multiplicar AX por BX e armazenar o resultado em DX:AX; se DX
               ;n„o for igual a zero, ent„o OF=1        
        into ;instru‡„o ®INTerrupt if Overflow¯; como o programa n„o pode ma-
             ;nusear um n£mero de sectores superior a FFFFh, e o pr¢prio DOS
             ;tamb‚m nunca tem (pelo menos que eu tivesse visto) um n£mero de
             ;sectores de FAT e ROOT DIR superiores a este n£mero, se a multi-
             ;plica‡„o de AX por BX for superior a FFFFh esta instru‡„o provo-
             ;ca um INT 4 (Overflow), pois detecta quando OF=1
        mov cx,ax ;cx=ax
        mov bl,10 ;10h entradas de direct¢rio por sector de ROOT DIR
        mov ax,[76b] ;AX=n§ de entradas no direct¢rio ra¡z
        div bl ;AX a dividir por BL; AL=quociente e AH=resto
        add cx,ax ;AL cont‚m o n£mero de sectores ocupados pelo ROOT DIR;esta
                  ;divis„o retorna sempre AH (resto) igual a zero, pois todos
                  ;os sectores de ROOT DIR contˆm entradas de direct¢rio at‚
                  ;ao fim; assim, somando AX a CX, obtemos o n£mero total de
                  ;sectores a trabalhar em CX
        pop ax ;restaurar AX, pois AL cont‚m a unidade
        ret ;fim da rotina
;Acabada a rotina de an lise da informa‡„o contida no BOOT Sector da unidade
;a processar, come‡a a rotina de codifica‡„o (protec‡„o) da unidade na direc-
;‡„o b99h. O £nico parƒmetro passado a esta rotina pela rotina de an lise da
;linha de comando ‚ o n£mero da unidade, e encontra-se na pilha.
        mov ah,9
        mov dx,3ba ;direc‡„o de PROC
        int 21
        pop ax ;restaurar em AL o n£mero da unidade
        sub al,61 ;visto as unidades serem designadas por letras (neste caso
                  ;min£sculas) ‚ necess rio subtra¡r ao n£mero da unidade re-
                  ;tornado pela rotina de an lise da linha de comando o valor
                  ;61h (letra "a"), de maneira que o "a" se torne 0h, o "b" se
                  ;torne 1h, e assim sucessivamente
        call ab8 ;chamada … rotina de processamento do sector de BOOT, tendo
                 ;como £nico parƒmetro a unidade em AL
;ba6:        
        push cx ;salvar CX, pois cont‚m o n£mero de sectores a processar
        mov bx,750 ;direc‡„o do buffer DISK_INFO
        mov cx,ffff ;leitura de sectores tendo em considera‡„o as parti‡”es
        mov dx,0 ;identificador de que a opera‡„o de leitura/escrita n„o ocor-
                 ;reu quando se tentava ler o BOOT
        push ax ;guardar AX
        int 25 ;leitura de disco absoluta
        jnc bb9 ;se n„o ocorreu erro, continuar
        popf ;restaurar bandeiras
        call acd ;chamada … rotina de processamento de erros de disco
;bb9:
        popf ;restaurar bandeiras
        mov si,75a ;direc‡„o de DISK_BUFFER
        mov di,si
        mov cx,200 ;comprimento do sector
        cld
;bc3:        
        lodsb ;ler byte de DS:SI para AL e avan‡ar SI
        push cx
        mov cl,5
        ror al,cl ;ROtate Right
                  ;rodar AL 5 bits (CL) … direita; ‚ esta a instru‡„o usada
                  ;para a codifica‡„o dos bytes da FAT e do ROOT DIR; consiste
                  ;em rodar os bits de um byte para formar um novo valor; a
                  ;sua vantagem ‚ que 0h permanece sempre 0h e nenhum outro 
                  ;valor se transforma em 0h, de maneira que as entradas na
                  ;FAT e ROOT DIR que n„o est„o usadas (marcadas com zero)
                  ;continuam dispon¡veis depois da codifica‡„o do disco, e as 
                  ;entradas que pertencem a ficheiros n„o correm o risco de 
                  ;serem preenchidas com zero, o que provavelmente causaria 
                  ;perda de dados
        pop cx
        stosb ;gravar AL para ES:DI e avan‡ar DI
        loop bc3 ;repetir ciclo para cada byte do buffer
        pop ax ;recuperar a unidade
        mov bx,750
        mov cx,ffff
        mov dx,0
        push ax
        int 26 ;grava‡„o de disco absoluta
        jnc be0
        popf
        call acd
;be0:
        popf
        pop ax ;recuperar unidade
        pop cx ;recuperar n£mero de sector actual
        inc word ptr [750] ;incrementar a primeira word no buffer DISK_INFO
                           ;(sector a ler/escrever)
        loop ba6 ;repetir ciclo para cada sector
        mov ah,9 ;quando aqui chegar ‚ porque j  processou todos os sectores
        mov dx,3cb ;direc‡„o de END
        int 21 ;imprimir mensagem
        int 20 ;sa¡r
;Est  terminada a rotina correspondente … fun‡„o /p. De seguida inicia-se a
;rotina da fun‡„o /d (bf2h). Esta rotina ‚ bastante semelhante com a anterior.
        mov ah,9
        mov dx,3ba ;direc‡„o de PROC
        int 21
        pop ax
        sub al,61
        call ab8
;bff:        
        push cx
        mov bx,750
        mov cx,ffff
        mov dx,0
        push ax
        int 25
        jnc c12
        popf
        call acd
;c12:
        popf
        mov si,75a
        mov di,si
        mov cx,200
        cld
;c1c:        
        lodsb
        push cx
        mov cl,05
        rol al,cl ;ROtate Left
                  ;esta ‚ a maior e £nica diferen‡a significativa entre as
                  ;duas rotinas; nesta, a rota‡„o dos bits faz-se para a es-
                  ;querda, para inverter o efeito da anterior; quando se des-
                  ;codifica a unidade, o valor E5h (primeiro byte numa entra-
                  ;da de direct¢rio), correspondente a um ficheiro ou direc-
                  ;t¢rio removido, converte-se em BCh, mas as entradas na FAT,
                  ;postas a zero quando se usou ERASE ou RD, continuam a zero
                  ;ap¢s a descodifica‡„o, de maneira que a rotina correspon-
                  ;dente … fun‡„o /r apenas tem de procurar entradas de direc-
                  ;t¢rio come‡ando com BCh e removˆ-las (preencher com zeros)
        pop cx
        stosb
        loop c1c
        pop ax
        mov bx,750
        mov cx,ffff
        mov dx,0
        push ax
        int 26
        jnc c39
        popf
        call acd
;c39:
        popf
        pop ax
        pop cx
        inc word ptr [750]
        loop bff
        mov ah,9
        mov dx,3cb ;direc‡„o de END
        int 21
        int 20
;Est  terminada a rotina /d. Na direc‡„o c4bh come‡a a rotina da fun‡„o /r:
        mov ah,9
        mov dx,3ba ;direc‡„o de PROC
        int 21
        pop ax
        sub al,61
        call ab8
        push ax ;guardar AX (AL cont‚m a unidade)
        mov ax,[770] ;como a fun‡„o /r s¢ actua no ROOT DIR, ‚ necess rio ex-
        mov bl,[76a] ;cluir de CX e aumentar no sector inicial (primeira word
        mov bh,00 ;do buffer DISK_INFO) o n£mero de sectores correspondentes
        mul bx ;… FAT; usamos os parƒmetros que est„o no sector do BOOT para
        into ;calcular quantos s„o esses sectores: 770h cont‚m o n£mero de
             ;sectores por FAT, e 76ah cont‚m o n£mero de FATs
        add [750],ax ;somar … primeira word de DISK_INFO o n£mero de sectores
                     ;ocupados pela FAT (contido em AX)
        sub cx,ax ;subtra¡r a CX (n§ de sectores a processar) o valor de AX
        pop ax ;restaurar a unidade em AL
;c6c:
        push cx ;guardar o n£mero de sectores a processar
        mov bx,750
        mov cx,ffff
        mov dx,0
        push ax
        int 25
        jnc c7f
        popf
        call acd
;c7f:
        popf
        mov cx,10 ;n£mero de entradas de direct¢rio por sector
        mov si,75a ;direc‡„o de DISK_BUFFER
;c86:        
        cmp byte ptr [si],bc ;verificar se o primeiro caracter do nome de
                             ;ficheiro ‚ igual a BCh (antes da descodifica‡„o
                             ;da unidade era E5h, marca do DOS de entrada de
                             ;direct¢rio removida)
        jnz c97 ;se n„o for, segue em c97h
        push cx ;guarda qual a entrada de direct¢rio a ser processada
        mov al,00 ;valor com que se preenche toda a entrada
        mov di,si ;DI=SI
        mov cx,20 ;n£mero de bytes por entrada de direct¢rio
        cld
        repz stosb ;preencher entrada apontada por ES:DI com o valor 00h (AL)
        pop cx ;restaura n£mero da entrada actual
;c97:
        add si,20 ;apontar SI para a pr¢xima entrada naquele sector
        loop c86 ;ciclo de verifica‡„o de entradas
        pop ax ;acabada a verifica‡„o das entradas, gravar sector
        mov bx,750
        mov cx,ffff
        mov dx,0
        push ax
        int 26
        jnc caf
        popf
        call acd
;caf:
        popf
        pop ax
        pop cx ;restaurar sector actual
        inc word ptr [750] ;incrementar word indicadora de qual o sector a
                           ;ler/escrever (no buffer DISK_INFO)
        loop c6c
        mov ah,9 ;acabada a restaura‡„o do direct¢rio ra¡z, imprimimos a men-
        mov dx,3cb ;sagem de sa¡da (3cbh - END) e voltamos ao DOS
        int 21
        int 20
;E aqui acaba o c¢digo fonte do programa. A pr¢xima direc‡„o a seguir … ins-
;tru‡„o INT 20 ‚ cc1h. Portanto, retirando os 100h bytes do PSP, obtemos o
;tamanho do ficheiro execut vel: bc1h bytes.
;-----------------------------------------------------------------------------

r cx
bc1
n pro-unit.com
r
w
q
