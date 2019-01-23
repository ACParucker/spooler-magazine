
TITLE VMONITOR.ASM (VIRT86.EXE)

COMMENT %
	      Programa:.... VIRT86.EXE
	      Programa demonstrativo de execuáÑo em
	      Modo Virtual 86.

M¢dulo:...... VMONITOR.ASM
Autor:....... JosÇ P†scoa

Compilado via: Borland C++ 3.1 (TASM)

Produzido em Dezembro 1993 para a revista SPOOLER.

Nota: S¢ Ç execut†vel em computadores com processador >= 386SX

%

; MACROS

INCLUDE MACROS.INC
INCLUDE SEGM.INC

.386P

; EQUATES para tipos de segmentos de mem¢ria.

RDONLY          EQU 0
RD_WR           EQU 1
RD_WR_XD        EQU 3
EXONLY          EQU 4
EX_RD           EQU 5
EXONLY_CF       EQU 6
EX_RD_CF        EQU 7
TSS_LIMIT       EQU 67h

; EQUATES de controle

TRUE            EQU 1
FALSE           EQU 0

; EQUATES com as posiáîes de mem¢ria f°sica e l¢gica
; do Monitor de Modo Virtual 86

FISICV86MONITOR EQU 100000H
PAGEDV86MONITOR EQU 1000000H

; Idem mas para utilizaáÑo nos 'descriptors' da GDT

DSCPAGED        EQU 1
DSCFISIC        EQU 10H


DESC386 STRUC                   ; Estrutura dos 'descriptors' na GDT e LDT

	limDesc386     dw 0     ; Primeiros 16 bits do limite
	LO_apDesc386   dw 0     ; Primeiros 16 bits da base
	MID_apDesc386  db 0     ; Bits 16 a 23 da base.
	accessDesc386  db 0     ; Acesso, Tipo de Operaáîes,
				; Tipo de 'Descriptor', DPL, Present Bit
	granDesc386    db 0     ; Bits 16 a 19 do limite, AVL, Granularidade.
	HI_apDesc386   db 0     ; Bits 24 a 31 da base.

DESC386 ENDS

DESCTABLEREG STRUC              ; Estrutura do GDTR, LDTR e IDTR

	limitGDT      dw ?      ; Limite na GDT, LDT ou IDT
	LO_apBaseGDT  dw ?      ; Endereáo do £ltimo byte da GDT, LDT ou IDT
	HI_apBaseGDT  dw ?      ; Idem, bits 16 a 31.

DESCTABLEREG ENDS

TSS_BLOCK STRUC                 ; Estrutura do 'Task State Segment'

	back_link        dw 0
	intel_reserv1    dw 0
	rSP0             dd 0
	rSS0             dw 0
	intel_reserv2    dw 0
	rSP1             dd 0
	rSS1             dw 0
	intel_reserv3    dw 0
	rSP2             dd 0
	rSS2             dw 0
	intel_reserv4    dw 0
	rCR3             dd 0
	rIP              dd 0
	EFLAGS           dd 0
	rEAX             dd 0
	rECX             dd 0
	rEDX             dd 0
	rEBX             dd 0
	rESP             dd 0
	rEBP             dd 0
	rESI             dd 0
	rEDI             dd 0
	rES              dw 0
	intel_reserv5    dw 0
	rCS              dw 0
	intel_reserv6    dw 0
	rSS              dw 0
	intel_reserv7    dw 0
	rDS              dw 0
	intel_reserv8    dw 0
	rFS              dw 0
	intel_reserv9    dw 0
	rGS              dw 0
	intel_reserv10   dw 0
	task_LDT         dw 0
	intel_reserv11   dw 0
	intel_reserv12   dw 0
	io_mapbase       dw 104

TSS_BLOCK ENDS

; Formato do 1ß Word da 'User Page Table Entry' a utilizar neste programa.

US_OPTIONS RECORD us_addresslow:4, us_avail:3=0, us_res1:2=0, \
		  us_dirty:1=0, us_aces:1=0, us_res2:2=0, \
		  us_us:1=1, us_rw:1=1, us_pres:1=1

; Formato do 1ß Word da 'Supervisor Page Table Entry' a utilizar neste programa.

SP_OPTIONS RECORD sp_addresslow:4, sp_avail:3=0, sp_res1:2=0, \
		  sp_dirty:1=0, sp_aces:1=0, sp_res2:2=0, \
		  sp_us:1=0, sp_rw:1=1, sp_pres:1=1

; Estrutura de 'Supervisor Page Table Entry'

SUPERVISORPAGETABLE STRUC

options SP_OPTIONS <>
addresshigh dw ?

SUPERVISORPAGETABLE ENDS

; Estrutura de 'User Page Table Entry'

USERPAGETABLE STRUC

options US_OPTIONS <>
addresshigh dw ?

USERPAGETABLE ENDS

; Segmento a ser preenchido com informaáÑo cr°tica durante a construáÑo
; das 'Page Tables'

PAGES SEGMENT PARA PUBLIC USE32

	supervisorpage   SUPERVISORPAGETABLE <>
	userpage         USERPAGETABLE <>

prot_pagedirstart     dd 5 dup (0)
virt_pagedirstart     dd 5 dup (0)
prottask_start        dd 5 dup (0)

virt_ramstart  dd 0
virt_romstart  dd 0
virt_hmastart  dd 0
virt_2megstart dd 0
virt1_start    dd 0
virt2_start    dd 0
virt3_start    dd 0
virt4_start    dd 0
vsys_start     dd 0

PAGES ENDS

_DATA SEGMENT PARA PUBLIC 'DATA'
EVEN
setprompt      db 33,"SET PROMPT=*MODO VIRTUAL 86* $P$G",13,0
setprompt_ansi db 64,"SET PROMPT=$e[32;41;1m*MODO VIRTUAL 86*$e[40m $e[36;1m$P$G$e[33m",13,0

; Os comandos internos, sÑo apenas 2, mas ser† algo f†cil ampliar esta lista.
; Nota: Alguns BIOS originam uma "Exception" na activaáÑo do comando TRACE.
; As causas nÑo poderam ser devidamente investigadas.

exit_command    db 3, "SAI"               ; Comando interno: Saida para Modo real.
trace_command   db 5, "TRACE"             ; Comando interno: Trace /on ou Trace /off

; 'switches' do comando TRACE

on_cline          db "ON"                 ; 'switch' para TRACE /ON
off_cline         db "OFF"                ; 'switch' para TRACE /OFF


OpenGateError db 13,10,"Erro na abertura da 'Gate' A20",13,10, "$"
CloseGateError db 13,10,"Erro no fecho da 'Gate' A20",13,10, "$"

_no_of_instrs     dd 0
_tracecounter    dw 32
_tracebuffer_cs  dw 33 dup (0)
_tracebuffer_ip  dw 33 dup (0)
_trace_status    db FALSE
cmosextmem      db FALSE
_hmaflag        db TRUE
oldss           dw 0
oldsp           dw 0
_erro           db 0
_code_erro      db 0ffh
_VideoSegment   dd 0
_virtualbox     db 0
Int_Mask_Reg1   db 0
Int_Mask_Reg2   db 0

protcr3 dd 0
_himap db 97 dup (0)

_pageerrorok  db FALSE
_pageerror    dd 0
_stackerrorok db FALSE
_stackerror dd 0
_stackeip    dd 0
_stackcs    dw 0
_stackflags dd 0
_stackesp   dd 0
_stackss    dw 0
_stackes    dw 0
_stackds    dw 0
_stackfs    dw 0
_stackgs    dw 0
_stackvirt  db FALSE
_stackbytesbelow dd 16
_stackbytes   db 33 dup (0)
_virtstack    db 17 dup (0)

GDTPtr LABEL BYTE
DESCTABLEREG  <gdt_limit, 0, 0>

IDTPtr LABEL BYTE
DESCTABLEREG <idt_limit, 0, 0 >

RealIDT LABEL BYTE
DESCTABLEREG <03ffh,0,0>

_DATA ENDS


MEMORYSEG GDT, RD_WR, 0, USE32

; Comeáa aqui a 'GLOBAL DESCRIPTOR TABLE (GDT)

DESC386  <0,0,0,0,0,0> ; 'Descriptor' NULO. Necess†rio.
DSCRP gdt_dat, GDT
DSCRP idt_dat, IDT
DSCRP Prot32CodeDesc, PROT32
DSCRP dados, DSC                         ; Dados e Pilha
DSCRP inthandler_seg, INT_HANDLERS
DSCRP faulthandler_seg, FAULT_HANDLERS
DSCRP , FAKECODE
DSCRPTSS prottask, INIT_TSS
DSCRPTSS virt86, VIRT_TSS
DSCRP virtldt, T2LDT
DSCRP errorldt, T3LDT
DSCRPTSS fault14tss, F14TSS
aliasf14 LABEL WORD
	DESC386 <f14tss_limit, F14TSS, 0, 10010010b, 0, 0>
DSCRPTSS fault12tss, F12TSS
aliasf12 LABEL WORD
	DESC386 <f12tss_limit, F12TSS, 0, 10010010b, 0, 0>
DSCRPTSS fault10tss, F10TSS
aliasf10 LABEL WORD
	DESC386 <f10tss_limit, F10TSS, 0, 10010010b, 0, 0>
DSCRPTSS fault08tss, F08TSS
aliasf08 LABEL WORD
	DESC386 <f08tss_limit, F08TSS, 0, 10010010b, 0, 0>
DSCRP falias, STAK4_0

RealCodeDesc LABEL WORD
	DESC386  <0FFFFh, _TEXT , 0 , 10011000b, 0, 0>
RealDataDesc LABEL WORD
	DESC386  <0FFFFh, _DATA , 0  , 10010010b, 0, 0>
Mega1RealDataDesc LABEL WORD
	DESC386  <0FFFFh, _DATA , DSCFISIC  , 10010010b, 0, 0>
Mega1Virt86 LABEL WORD
	DESC386  <virt_tss_limit, VIRT_TSS , DSCFISIC  , 10010010b , 0, 0>
Mega1PAGESDesc LABEL WORD
	DESC386  <0FFFFh, PAGES , DSCFISIC  , 10010010b, 0, 0>
Mega1PageTablesDesc LABEL WORD
	DESC386  < 0 , 0 , 0 , 10010010b, 0, 0>
Mega2RealDataDesc LABEL WORD
	DESC386  <0FFFFh, _DATA , 0  , 10010010b, 0, DSCPAGED>
HighAliasf14 LABEL WORD
	DESC386 <f14tss_limit, F14TSS, DSCFISIC, 10010010b, 0, 0>
HighAliasf12 LABEL WORD
	DESC386 <f12tss_limit, F12TSS, DSCFISIC, 10010010b, 0, 0>
HighAliasf10 LABEL WORD
	DESC386 <f10tss_limit, F10TSS, DSCFISIC, 10010010b, 0, 0>
HighAliasf08 LABEL WORD
	DESC386 <f08tss_limit, F08TSS, DSCFISIC, 10010010b, 0, 0>
P32High LABEL WORD
	DESC386 <prot32_limit, PROT32, DSCFISIC, 10011000b, 01000000b, 0>
FakingCodeHigh LABEL WORD
	DESC386 <fakecode_limit, FAKECODE, 0, 10011000b, 11000000b, DSCPAGED>
FakingDataHigh LABEL WORD
	DESC386 <fakecode_limit, FAKECODE, 0, 10010010b, 11000000b, DSCPAGED>

VeryBigDataDesc LABEL WORD
	DESC386  <0FFFFh, 0 , 0  , 10010010b, 11001111b, 0>

ENDSEG GDT

MEMORYSEG IDT, RD_WR, 0, USE32

; "INTERRUPT DESCRIPTOR TABLE"

; "Exceptions" detectadas pelo processador (vectores 0 a 1Fh) .

GATE ,fault_00, faulthandler_seg, 0, INT_GATE, 0       ; "Divide error"
GATE ,fault_01, faulthandler_seg, 0, INT_GATE, 0       ; "Debug exception"
GATE ,fault_02, faulthandler_seg, 0, INT_GATE, 0       ; "NMI interrupt"
GATE ,fault_03, faulthandler_seg, 0, INT_GATE, 0       ; "BreakPoint"
GATE ,fault_04, faulthandler_seg, 0, INT_GATE, 0       ; "INTO Overflow"
GATE ,fault_05, faulthandler_seg, 0, INT_GATE, 0       ; "BOUND Range Exceeded"
GATE ,fault_06, faulthandler_seg, 0, INT_GATE, 0       ; "Invalid Opcode"
GATE ,fault_07, faulthandler_seg, 0, INT_GATE, 0       ; "Coprocessor not available"
GATE ,0, fault08tss, 0, TASK_GATE, 0                   ; "Double Fault"
GATE ,fault_09, faulthandler_seg, 0, INT_GATE, 0       ; "Coprocessor Segment Overrun"
GATE ,0, fault10tss, 0, TASK_GATE, 0                   ; "Invalid Task State Segment"
GATE ,fault_11, faulthandler_seg, 0, INT_GATE, 0       ; "Segment Not Present"
GATE ,0, fault12tss, 0, TASK_GATE, 0                   ; "Stack Fault"
GATE ,fault_13, faulthandler_seg, 0, INT_GATE, 0       ; "General Protection"
GATE ,0, fault14tss, 0, TASK_GATE, 0                   ; "Page Fault"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,fault_16, faulthandler_seg, 0, TRAP_GATE, 0      ; "Coprocessor Error"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"
GATE ,undefined, faulthandler_seg, 0, TRAP_GATE, 0     ; "Intel Reserved"

; Interrupts de Hardware n°vel 0 (vectores 20h a 27h)

GATE ,timer_int, inthandler_seg, 0, INT_GATE, 0 ; IRQ 0 (ex Int 8) TIMER_INT
GATE ,kb_int, inthandler_seg, 0, INT_GATE, 0    ; IRQ 1 (ex Int 9) KB_INT
GATE ,irq02, inthandler_seg, 0, INT_GATE, 0     ; IRQ 2 (ex Int 0Ah) Reservado.
GATE ,com2_int, inthandler_seg, 0, INT_GATE, 0  ; IRQ 3 (ex Int 0Bh) Comunicaáîes.
GATE ,com1_int, inthandler_seg, 0, INT_GATE, 0  ; IRQ 4 (ex Int 0Ch) Comunicaáîes.
GATE ,prn2_int, inthandler_seg, 0, INT_GATE, 0  ; IRQ 5 (ex Int 0Dh) Disco R°gido.
GATE ,fd_int, inthandler_seg, 0, INT_GATE, 0    ; IRQ 6 (ex Int 0Eh) Floppies.
GATE ,prn1_int, inthandler_seg, 0, INT_GATE, 0  ; IRQ 7 (ex Int 0Fh) Impressora.

; Interrupts de Hardware n°vel 1 (vectores 28h a 2Fh)

GATE ,rtc_int, inthandler_seg, 0, INT_GATE, 0     ; IRQ 8 (ex Int 70h) CMOS Real Time Clock
GATE ,irq09, inthandler_seg, 0, INT_GATE, 0       ; IRQ 9 (ex Int 71h) Redirecionado para Int 0Ah pelo Bios
GATE ,irq10, inthandler_seg, 0, INT_GATE, 0       ; IRQ 10 (ex Int 72h) Reservado.
GATE ,irq11, inthandler_seg, 0, INT_GATE, 0       ; IRQ 11 (ex Int 73h) Reservado.
GATE ,irq12, inthandler_seg, 0, INT_GATE, 0       ; IRQ 12 (ex Int 74h) Pointing Device (PS/2).
GATE ,ncoproc_int, inthandler_seg, 0, INT_GATE, 0 ; IRQ 13 (ex Int 75h) Coprocessor Exception.
GATE ,hd_int, inthandler_seg, 0, INT_GATE, 0      ; IRQ 14 (ex Int 76h) HD controller.
GATE ,irq15, inthandler_seg, 0, INT_GATE, 0       ; IRQ 15 (ex Int 77h) Reservado.

ENDSEG IDT

_TEXT SEGMENT BYTE PUBLIC 'CODE'

		ASSUME CS:_TEXT, DS:_DATA, ES:NOTHING

PUBLIC _code_erro, _VideoSegment, _erro, _protectentry, _virtualbox, _himap
PUBLIC _stackerror, _stackeip, _stackcs, _stackflags, _stackesp, _stackss
PUBLIC _stackes, _stackds, _stackfs, _stackgs, _stackvirt, _stackerrorok
PUBLIC _stackbytes, _hmaflag, _virtstack, _pageerror, _pageerrorok
PUBLIC _stackbytesbelow, _tracebuffer_cs, _tracebuffer_ip, _trace_status
PUBLIC _tracecounter, _no_of_instrs

	EXTRN OpenGateA20:NEAR, RealModeErrors:NEAR, CloseGateA20:NEAR
	EXTRN IntrSet:NEAR, IsAnsi:Near
	EXTRN _ReportVirtExtended:DWORD

adjust_addr   proc near

; Esta subrotina converte os endereáos de 'MODO REAL' existentes
; nas 'Descriptor Tables' em endereáos f°sicos.
; Isto Ç necess†rio pois o programa foi ligado com um 'linker' de
; vulgar (sem ofensa).
; Tudo o que h† a fazer nesta fase Ç multiplicar por 16 pois o nosso
; programa ainda executa no primeiro megabyte.
; Mais tarde far-se-† novo ajustamento ap¢s o salto para o segundo
; megabyte e posterior execuáÑo no 17ß Megabyte graáas ao mecanismo de 'paging'.

; Chamado com ES:0 apontando para a tabela, CX contÇm o n£mero de
; entradas.

	xor     bx, bx
newloop:
	mov     al, es:[bx].accessDesc386
	test    al, 10h              ; Trata-se de segmento de mem¢ria ?
	jnz     got_seg
	and     al, 0Fh
	cmp     al, 9                ; '386/486 TSS' dispon°vel ?
	jz      got_seg
	cmp     al, 11               ; '386/486 TSS' indispon°vel ?
	jz      got_seg
	cmp     al, 2                ; 'LDT' ?
	jnz     update_next          ;  NÑo, tentemos outro.
got_seg:
	mov     ax, es:[bx].LO_apDesc386        ; segmento de mem¢ria.
	mov     dx, 16
	mul     dx                              ; converte para endereáo f°sico.
	mov     es:[bx].LO_apDesc386, ax        ; guarda
	add     es:[bx].MID_apDesc386, dl       ; SÑo 24 bits no 1ß megabyte.
	add     es:[bx].HI_apDesc386, dh
update_next:
	add     bx, 8                           ; 'Novo descriptor'
	loop    newloop
	ret

adjust_addr     endp

ASSUME DS:_DATA

; A execuáÑo neste m¢dulo comeáa aqui.

_protectentry proc near

	push ds               ; Para assegurar mais tarde uma reentrada no
	push es               ; modulo em 'C' sem desaires, convÇm perservar
	push edi              ; o valor destes registos.
	push esi

	call OpenGateA20            ; Abrimos a 'porta dourada'.

	test al, 1
	jz OpenedOk
	lea dx, OpenGateError
	jmp RealModeErrors

OpenedOk:


ASSUME DS:_DATA

; Temos de converter os endereáos de segmentos de 'MODO REAL' para
; 'MODO PROTEGIDO'

; Primeiro na GDT

	mov     ax, GDT
	mov     es, ax          ; Aponta para GDT
	mov     cx, offset GDT:VeryBigDataDesc
	shr     cx, 3
	call    adjust_addr

; Depois nas LDTs

	mov ax, T2LDT
	mov es, ax
	mov cx, t2ldt_limit
	inc cx
	shr cx, 3
	call adjust_addr

	mov ax, T3LDT
	mov es, ax
	mov cx, t3ldt_limit
	inc cx
	shr cx, 3
	call adjust_addr


; PreparaáÑo da estrutura GDTPtr para o carregamento do GDTR

	mov bx, _DATA
	mov ds, bx
	movzx eax, word ptr GDTPtr.LO_apBaseGDT
	mov  bx, GDT
	movzx ebx, bx
	shl ebx, 4
	add  eax, ebx
	mov  GDTPtr.LO_apBaseGDT, ax
	shr eax, 16
	mov GDTPtr.HI_apBaseGDT, ax

; PreparaáÑo da estrutura IDTPtr para o carregamento do IDTR

	movzx eax, word ptr IDTPtr.LO_apBaseGDT
	mov bx, IDT
	movzx ebx, bx
	shl ebx, 4
	add eax, ebx
	mov IDTPtr.LO_apBaseGDT, ax
	shr eax, 16
	mov IDTPtr.HI_apBaseGDT, ax

; Pequena precauáÑo: Esperar que todos os "interrupts" do teclado
; possam ser processados.

	mov ecx,0fffffh
	loop $

	mov ah , 0dh
	int 21h          ; Flush dos Buffers e reset do disk

; Guardamos para restauro posterior o conte£do dos "Interrupt Mask Registers".

	in al, 21h
	mov Int_Mask_Reg1, al
	in al, 0a1h
	mov Int_Mask_Reg2, al

	CLI                     ; ãnicio de zona cr°tica.
	mov ax, ss
	mov [oldss], ax
	mov [oldsp] ,sp

; Reprograma o PIC ('Programmable Interrupt Controller')
; 'Interrupts' de 'Hardware' N°vel 0 com °nicio no vector 20H
; 'Interrupts' de 'Hardware' N°vel 1 com °nicio no vector 28H

	mov bh, 20h
	mov bl, 28h
	call near ptr IntrSet

; E faz a entrada em Modo Protegido ap¢s definir o tamanho e localizaáÑo
; das tabelas GDT e IDT.

	lidt fword ptr IDTPtr
	lgdt fword ptr GDTPtr

	mov eax, cr0
	or eax, 1h              ; 'Modo Protegido' activo.
	mov cr0, eax            ; Instante 0. __ENTRÜMOS__.

; Saltamos para um segmento de 32 bits

	JMP_FAR1632 GDT:Prot32CodeDesc, 0, 0   

_protectentry endp

; Rotina de sa°da do Modo Protegido.

EndProt proc near

	CLI                     ; Zona cr°tica.

; Todos os registos de segmento com limite 64 KB (Ç conveniente)

	mov bx, offset GDT:RealDataDesc
	mov ds, bx
	mov es, bx
	mov fs, bx
	mov gs, bx
	mov ss, bx

	mov eax, cr0
	and eax, 7fffffffh
	mov cr0, eax            ; Desactiva 'Paging'.
	mov eax,0
	mov cr3, eax            ; Limpa cr3 e 'flush' do TLB ('Translation
				; Lookaside Buffer).

	jmp short $ + 2         ; 'Flush'

	mov eax, cr0
	and al, 0feh
	mov cr0, eax            ; Reentramos no MODO REAL. ê bom sentir
				; de novo os pÇs no chÑo.

	JMP_FAR_REAL _TEXT, Realflushed  ; 'Flush' do 'prefetch queue'

Realflushed:

	mov ax, _DATA
	mov ds, ax
	mov ax ,oldss
	mov ss, ax
	mov sp, oldsp
	pop esi
	pop edi
	pop es
	pop ds

; Reprograma o PIC ('Programmable Interrupt Controller') para o 'default'
; 'Interrupts' de 'Hardware' N°vel 0 com °nicio no vector 08H
; 'Interrupts' de 'Hardware' N°vel 1 com °nicio no vector 70H

	mov bh, 08h
	mov bl, 70h
	call near ptr IntrSet

	lidt fword ptr RealIDT

	mov al, Int_Mask_Reg2   ; S¢ habilitaremos os 'interrupts' de
	out 0a1h, al            ; 'Hardware' que vinham habilitados
	jmp short $ + 2         ; no °nicio da execuáÑo do programa.
	jmp short $ + 2
	mov al, Int_Mask_Reg1
	out 21h, al

	call CloseGateA20
	test al, 1
	jz ClosedOk
	lea dx, CloseGateError
	jmp RealModeErrors
 ClosedOK:

	sti                     ; Agora sim, podem-se deixar os 'interrupts'
				; actuar.
	ret                     ; Regresso ao m¢dulo em linguagem 'C'

EndProt endp

; O inicio da execuáÑo em Modo Virtual Ç efectuado nesta rotina.

ASSUME fs:_DATA
virtstart proc near

	mov ax, _DATA
	mov ds, ax
	mov ax ,oldss
	cli
	mov ss, ax
	mov sp, oldsp
	sti
	pop esi
	pop edi
	pop es
	pop ds

	push  ds
	push  fs
	mov   ax, ds
	mov   fs, ax

	call near ptr IsAnsi        ; Para saber se o Ansi.sys est† instaldo
				    ; e activar o 'prompt' colorido.

	mov  si, offset setprompt
	cmp al, 0
	jz prompt_done
	mov si, offset setprompt_ansi

prompt_done:
	mov   fs:[oldss],ss
	mov   fs:[oldsp],sp
	cld
	int   2eh       ; Instala o 'prompt' pela porta das trazeiras
			; do Command.com (ou 4dos.com se for recente).
			; Nota: SS e SP nÑo sÑo perservados.
	cli
	mov   ss,fs:[oldss]
	mov   sp,fs:[oldsp]
	sti

	pop   fs
	pop   ds

	mov eax, 12345678h
	int 0fdh                ; "Linha Directa" para o Monitor V86 pedindo
				; para desligar a 'Task Switched Flag' a fim
				; de evitar as 'exception 7'

	mov _virtualbox,1       ; Sinalazar† ao m¢dulo em C que a sa°da
				; Ç para Modo Virtual 86.
	ret

virtstart endp


_TEXT ENDS

; Primeiro segmento de 32 bits a executar ap¢s a entrada em Modo protegido.

MEMORYSEG PROT32, EXONLY,0, USE32

	ASSUME CS:PROT32, DS:_DATA

	mov bx, offset GDT:dados
	mov ss, bx                              ; Necess†rio termos desde j†
	mov esp, offset DSC:dsc_top_of_stack    ; uma pilha.

	mov ax, offset GDT:gdt_dat
	mov es, ax

; Vamos procurar aonde colocar as 'Page Tables'.
; Ser† acima da pilha de Modo Real, 1 MB mais acima e endereáo m£ltiplo de 4 KB. 

	mov eax, _STACK
	shl eax, 4
	add eax, FISICV86MONITOR
	mov esi, eax

	add eax, offset _STACK:endstack

	mov ebx, eax
	and eax, 0fffff000h
	sub ebx, eax

	mov edx, 2000h
	sub edx, ebx

	add esi, edx
	mov eax, esi

; Encontr†mos o local. Agora preenchemos os campos de 'descriptor'

	mov edi, offset GDT:Mega1PageTablesDesc.LO_apDesc386
	stosw
	shr eax, 16
	stosb
	mov eax, 1a0000h
	dec eax
	sub eax, esi
	mov edi, offset GDT:Mega1PageTablesDesc.limDesc386
	stosw
	mov edi, offset GDT:Mega1PageTablesDesc.granDesc386
	shr eax, 16
	and al, 0fh
	or byte ptr es:[edi], al


	mov ax, offset GDT:VeryBigDataDesc      
	mov ds, ax                              
	mov es, ax
	mov fs, ax
	mov gs, ax

; Copiamos o conte£do da mem¢ria convencional para o 2ß megabyte

	mov esi, 0
	mov edi, 100000h
	mov ecx, 28000h             ; 0A0000h/4
	cld
	rep movs dword ptr [esi], dword ptr [edi]

; Salto para a instruáÑo seguinte (mas 1 MegaByte mais acima).

	JMP_FAR3232 GDT:P32High, PROT32:highmemstart, 0

; Agora estamos a executar no 2ß Megabyte

highmemstart:

	mov ax, offset GDT:Mega1PageTablesDesc
	mov es, ax

	xor edi, edi
	xor edx, edx

; Vamos construir as 'Page Tables':
; 1ß)- Endereáos onde comeáam as varias zonas limitrofes.
; 2ß)- 'Page Tables de 2ß n°vel'
; 3ß)- 'Page Directories'

ASSUME DS:PAGES

	mov ax, offset GDT:Mega1PAGESDesc
	mov ds, ax
	mov ebx, dword ptr ds:[supervisorpage]
	mov ecx, 5

looppdir0:

	mov dword ptr es:[edi], ebx
	add edi, 4
	loop looppdir0
	mov ebx, edx
	mov esi, offset prot_pagedirstart
	mov ecx, 5

loopdir1:

	mov dword ptr ds:[esi], ebx
	add esi, 4
	add ebx, 4
	loop loopdir1
	add edx, 1000h
	mov edi, edx
	mov ebx, dword ptr ds:[userpage]
	mov ecx, 5

loopvdir0:

	mov dword ptr es:[edi], ebx
	add edi, 4
	loop loopvdir0
	mov ebx, edx
	mov esi, offset virt_pagedirstart
	mov ecx, 5

loopvir1:

	mov dword ptr ds:[esi], ebx
	add esi, 4
	add ebx, 4
	loop loopvir1
	add edx, 1000h
	mov edi, edx
	mov ebx, dword ptr ds:[supervisorpage]
	mov ecx, 4352

loopptask01:

	mov dword ptr es:[edi], ebx
	add edi, 4
	loop loopptask01
	mov ebx, edx
	mov esi, offset prottask_start
	mov ecx, 5

loopptask02:

	mov dword ptr ds:[esi], ebx
	add esi, 4
	add ebx, 1000h
	loop loopptask02
	add edx, 5000h
	mov edi, edx
	mov ebx, dword ptr ds:[userpage]
	mov ecx, 1000h

loopvtask01:

	mov dword ptr es:[edi], ebx
	add edi, 4
	loop loopvtask01
	mov ebx, dword ptr ds:[supervisorpage]
	mov ecx, 256

loopvtask11:

	mov dword ptr es:[edi], ebx
	add edi, 4
	loop loopvtask11
	mov ebx, edx
	mov ds:[virt_ramstart], ebx
	add ebx, 640
	mov ds:[virt_romstart], ebx
	add ebx, 384
	mov ds:[virt_hmastart], ebx
	add ebx, 64
	mov ds:[virt_2megstart], ebx
	add ebx, 960
	mov ds:[virt1_start], ebx
	add ebx, 2048
	mov ds:[virt2_start], ebx
	add ebx, 4096
	mov ds:[virt3_start], ebx
	add ebx, 4096
	mov ds:[virt4_start], ebx
	add ebx, 4096
	mov ds:[vsys_start], ebx

ASSUME  ES:PAGES, DS:NOTHING

; 'Page Table de 2ß n°vel' para uso exclusivo do Monitor de Modo Virtual 86
; ("Supervisor Level")

	mov ax, offset GDT:Mega1PageTablesDesc
	mov ds, ax
	mov ax, offset GDT:Mega1PAGESDesc
	mov es, ax
	mov edx, 0
	mov ecx, 1000h
	mov esi, es:[prottask_start]
	call near ptr pageset

       mov edx, 100000h
       mov ecx, 256
       mov esi, es:[prottask_start + 16]
       call near ptr pageset


; 'Page Table' de 2ß n°vel para o 2ß 'Page Directory' ("User Level")
; Remapeamento da 'DOS BOX' do utilizador.
; Os primeiros 640 Kb sÑo mapeados, para simplicidade, no 1ß 'Megabyte'
; a partir do endereáo f°sico 0h.
; Nota: O mapeamento poderia ser feito para a mem¢ria 'extended'
;       mas iriamos complicar o trabalho do monitor V86, pois
;       seria necess†rio criar 'DMA buffers' no primeiro megabyte para
;       ter em conta os 'BUS Masters' que actuam antes do CPU e que
;       nÑo terÑo em conta o remapeamento efectuado pelo CPU.
;       O controlador 'standard AT' de disquetes, alguns controladores
;       de disco r°gido  e v†rios tipos de CD ROMs sÑo 'BUS Masters'

	mov edx, 0h
	mov ecx, 160
	mov esi, es:[virt_ramstart]
	call near ptr pageset

; A zona dos ROM mantem-se mapeada no 1ß 'Megabyte',
; excepto as areas indicadas pela linha de comando.
; RAM=xxxx-yyyy

ASSUME FS:_DATA

	mov ax, offset GDT:Mega1RealDataDesc
	mov fs, ax
	mov edx, 0A0000h
	mov edi, edx
	mov ebx, 19F000h
	mov ecx, 96
	mov esi, es:[virt_romstart]

remaphigh:
	
	push ecx
	mov ecx, 1
	call near ptr pageset
	add edi, 1000h
	pop ecx
	push edi
	sub edi, 0A0000h
	shr edi, 12
	cmp byte ptr fs:[_himap + edi], 1
	pop edi
	jnz remap
	add ebx, 1000h
	mov edx, ebx
	loop remaphigh

remap:

	mov edx, edi
	loop remaphigh

; Se a HMA nÑo estiver activa mapeamos o in°cio do 1ß megabyte
; para o in°cio do 1ß Megabyte

	cmp byte ptr fs:[_hmaflag], TRUE
	jz hmaok
	mov edx, 0
	mov ecx, 16
	mov esi, es:[virt_hmastart]
	call near ptr pageset
	jmp short hma_done

hmaok:

; Se a HMA estiver activa vamos "enxertar" RAM do inicio do 3ß Megabyte

	mov edx, 200000
	mov ecx, 16
	mov esi, es:[virt_hmastart]
	call near ptr pageset

hma_done:

; O 3ß Megabyte Ç mapeado no 4ß Megabyte e por a° fora.

	mov edx, 210000h
	mov ecx,  3824
	mov esi, es:[virt_2megstart]
	call near ptr pageset

; O 17ß Megabyte Ç mapeado no 2ß Megabyte

	mov edx, 100000h
	mov ecx, 256
	mov esi, es:[vsys_start]
	call near ptr pageset

; 1ß 'Page Directory'. Ponteiro para a 'Page Table' de 2ß n°vel.

	push ds
	mov ax, offset GDT:gdt_dat
	mov ds, ax

ASSUME DS:GDT

	mov esi, offset GDT:Mega1PageTablesDesc
	mov eax, dword ptr ds:[esi].LO_apDesc386
	and eax, 0ffffffh

ASSUME DS:NOTHING

	pop ds
	mov edi, 0
	mov ecx, 5

addpdir:

	push ecx
	push edi
	mov esi, es:[prot_pagedirstart + edi]
	mov edx, es:[prottask_start + edi]
	add edx, eax
	mov ecx, 1
	call near ptr pageset
	pop edi
	pop ecx
	add edi, 4
	loop addpdir

; Registo cr3 com o endereáo da 1ß 'Page Directory'.

	push eax
	mov ebx, es:[prot_pagedirstart]
	add eax, ebx
	and eax, 0fffff000h
	mov ebx, cr3
	and ebx, 0fffh
	or ebx, eax
	xchg eax, ebx
	mov cr3, eax
	mov dword ptr fs:[protcr3], eax

ASSUME GS:F14TSS

; TSS da 'fault 14'

	mov bx, offset GDT:HighAliasf14
	mov gs, bx
	mov dword ptr gs:[rCR3], eax

ASSUME GS:F12TSS

; TSS da 'fault 12'

	mov bx, offset GDT:HighAliasf12
	mov gs, bx
	mov dword ptr gs:[rCR3], eax

ASSUME GS:F10TSS

; TSS da 'fault 10'

	mov bx, offset GDT:HighAliasf10
	mov gs, bx
	mov dword ptr gs:[rCR3], eax

ASSUME GS:F08TSS

; TSS da 'fault 08'

	mov bx, offset GDT:HighAliasf08
	mov gs, bx
	mov dword ptr gs:[rCR3], eax


ASSUME GS:NOTHING

	pop eax

; 2ß 'Page Directory'. Ponteiros para a 'Page Table' de 2ß n°vel.

	mov esi, es:[virt_pagedirstart]
	mov edx, es:[virt_ramstart]
	add edx, eax
	mov ecx, 1
	call near ptr pageset

	mov esi, es:[virt_pagedirstart + 4]
	mov edx, es:[virt2_start]
	add edx, eax
	mov ecx, 1
	call near ptr pageset

	mov esi, es:[virt_pagedirstart + 8]
	mov edx, es:[virt3_start]
	add edx, eax
	mov ecx, 1
	call near ptr pageset

	mov esi, es:[virt_pagedirstart + 12]
	mov edx, es:[virt4_start]
	add edx, eax
	mov ecx, 1
	call near ptr pageset

	mov esi, es:[virt_pagedirstart + 16]
	mov edx, es:[vsys_start]
	add edx, eax
	mov ecx, 1
	call near ptr pageset

; ActualizaáÑo do TSS da 'DOS BOX'

	mov ebx, es:[virt_pagedirstart]
	add eax, ebx
	and eax, 0fffff000h

ASSUME DS:VIRT_TSS, ES:_DATA

	mov bx, offset GDT:Mega1Virt86
	mov ds, bx
	mov bx, offset GDT:Mega1RealDataDesc
	mov es, bx
	mov ebx, ds:[rCR3]
	and ebx, 0fffh
	or ebx, eax
	xchg eax, ebx
	mov ds:[rCR3], eax
	pushfd
	pop eax
	or eax, 20000h                          ; 'Virtual Mode Flag' com 1
	and eax, 0ffff0fffh
	mov dword ptr ds:[EFLAGS], eax

	mov ax, _TEXT                           ; CS para onde vamos ap¢s
	mov word ptr ds:[rCS], ax               ; o 'Task switch'

	mov eax, offset _TEXT:virtstart         ; EIP para onde vamos ap¢s
	mov dword ptr ds:[rIP], eax             ; o 'Task switch'

	mov ax, offset T2LDT:virtstk_0          ; 'Stack' de privilÇgio 0.
	add ax, 4                               ; ê na LDT, soma-se 4.
	mov word ptr ds:[rSS0], ax
	mov eax, offset STAK2_0:stak2_end
	mov dword ptr ds:[rSP0], eax

	mov ax, offset GDT:virtldt
	mov ds:[task_LDT], ax

ASSUME DS:_DATA

	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax      
	mov es, ax
	mov fs, ax
	mov gs, ax

; Ajustamento dos 'descriptors' na GDT para ter em conta a reformulaáÑo
; dos endereáos ap¢s o 'paging'

	call near ptr SetupGDT
	mov eax, cr0
	or eax, 80000000h       ; 'Paging' activo.
	mov cr0, eax
	jmp short $ + 2
	mov ebx, _DATA
	shl ebx, 4
	add ebx, FISICV86MONITOR
	add ebx, offset _DATA:GDTPtr
	mov eax, GDT
	shl eax, 4
	add eax, PAGEDV86MONITOR
	mov ds:[ebx + 2], eax
	lgdt fword ptr ds:[ebx] ; Novas coordenadas para a GDT
	JMP_FAR3232 GDT:Prot32CodeDesc, PROT32:flushpg1, 0

flushpg1:

; Estamos a executar no 17ß Megabyte

	mov bx, offset GDT:VeryBigDataDesc 
	mov ds, bx
	mov es, bx
	mov bx, offset GDT:dados
	mov ss, bx
	mov esp, offset DSC:dsc_top_of_stack

	mov ebx, _DATA
	shl ebx, 4
	add ebx, FISICV86MONITOR
	add ebx, offset _DATA:IDTPtr
	mov eax, IDT
	shl eax, 4
	add eax, PAGEDV86MONITOR
	mov ds:[ebx + 2], eax

; Ajustamento para o novo endereáo da IDT

	lidt fword ptr ds:[ebx]
	mov ax, offset GDT:RealDataDesc
	mov ds, ax
	mov al, Int_Mask_Reg2   ; Habilitamos apenas os 'interrupts' de
	out 0a1h, al            ; 'Hardware' que vinham habilitados no
	jmp short $ + 2         ; no °nicio da execuáÑo do programa.
	jmp short $ + 2
	mov al, Int_Mask_Reg1
	out 21h, al

	mov ax, offset GDT:prottask
	ltr ax                       ; Necess†rio prÇ-inicializar o 'Task Register'

	JMP_FAR3232 GDT:virt86, 0, 0 ; E vamos de imediato para Modo Virtual 86.

ASSUME DS:NOTHING

SetupGDT proc near

	mov esi, GDT
	shl esi, 4
	add esi, FISICV86MONITOR
	mov ecx, offset GDT:RealCodeDesc
	shr ecx, 3
	mov edi, PAGEDV86MONITOR
	call near ptr adj_add2

	mov esi, T2LDT
	shl esi, 4
	add esi, FISICV86MONITOR
	mov ecx, t2ldt_limit
	inc ecx
	shr ecx, 3
	mov edi, PAGEDV86MONITOR
	call near ptr adj_add2

	mov esi, T3LDT
	shl esi, 4
	add esi, FISICV86MONITOR
	mov ecx, t3ldt_limit
	inc ecx
	shr ecx, 3
	mov edi, PAGEDV86MONITOR
	call near ptr adj_add2

	ret

SetupGDT endp


adj_add2 proc near

	add esi, 8                       ; Primeiro 'descriptor ' Ç nulo
	dec ecx

newloop2:

	mov     al, es:[esi].accessDesc386
	test    al, 10h                 ; Trata-se de segmento de mem¢ria ?
	jnz     got_seg2
	and     al, 0Fh
	cmp     al, 9                   ; '386/486 TSS' dispon°vel ?
	jz      got_seg2
	cmp     al, 11                  ; '386/486 TSS' indispon°vel ?
	jz      got_seg2
	cmp     al, 2                   ; 'LDT' ?
	jnz     update_next2            ; NÑo, tentemos outro.

got_seg2:

	mov     eax, dword ptr ds:[esi].LO_apDesc386    ; segmento de mem¢ria.
	and     eax, 0ffffffh
	movzx   ebx, byte ptr ds:[esi].HI_apDesc386
	shl     ebx, 24
	add     eax, ebx
	add     eax, edi
	push eax
	and     eax, 0ffffffh
	and     dword ptr ds:[esi].Lo_apDesc386, 0ff000000h
	or      dword ptr ds:[esi].LO_apDesc386, eax        ; guarda
	pop eax
	shr     eax, 24
	mov byte ptr ds:[esi].HI_apDesc386, al

update_next2:

	add     esi, 8                   ; 'Novo descriptor'
	loop    newloop2
	ret

adj_add2 endp

; Preenchimento das 'Page Table Entries'

pageset proc near

	push edx
	shr edx, 12
	and edx,0Fh
	shl edx, 12
	and word ptr ds:[esi], 0fffh
	or word ptr ds:[esi], dx
	pop edx
	push edx
	shr edx, 16
	mov word ptr ds:[esi+2], dx
	pop edx
	add edx, 1000h
	add esi, 4
	loop pageset
	ret

pageset endp

ENDSEG PROT32

; EQUATES para controlador 8259A

MASTER          EQU     20h
SLAVE           EQU     0A0h
EOI             EQU     20h


MEMORYSEG INT_HANDLERS, EXONLY,0, USE32

		ASSUME  CS:INT_HANDLERS, DS:DSC

; Rotinas de Serviáo dos 'Interrupts'

; 'Interrupts' de 'Hardware' de n°vel 0. Necess†rio sinalizar EOI
; ('End of Interrupt') para o 8259A Master.

timer_int:

	push ax
	mov al, 8
	jmp irq1make

kb_int:

	test    byte ptr [esp + 10], 2      ; Verifica se 'interrupt' ocorreu
					    ; Modo Virtual 86
	jz protmodekbint
	pushad
	push ds                             ; Previne Ctrl+Alt+Del em
					    ; Modo V86. Trata-se de
	in al, 60h                          ; uma soluáÑo para evitar
	mov bl, al                          ; problemas com alguns BIOS.
	and al, 07fh
	cmp al, 53h                         ; C¢digo de varrimento para DEL
	jnz not_del
	mov ax, offset GDT:VeryBigDataDesc
	mov ds,ax
	mov al, byte ptr ds:[417h]
	and al, 0ch                         ; Apura apenas CTRL+ALT simultÉneos
	cmp al, 0ch
	jnz not_del
	pop ds
       _popad                               ; SoluáÑo genÇrica para o POPAD bug:
					    ; _popad = popad + nop 
	jmp short protmodekbint

not_del:

	pop ds
       _popad
	push ax
	mov al, 9
	jmp v86irq1

protmodekbint:

	push ax
	in al, 61h
	or al, 80h
	out 61h, al             ; Retira caracter do porto
	and al, 07fh
	out 61h, al             ; Reactiva teclado.
	mov     al, EOI
	out     MASTER, al
	pop ax
	iretd

irq02:

	push ax
	mov al, 10
	jmp short irq1make

com2_int:

	push ax
	mov al, 11
	jmp short irq1make

com1_int:

	push ax
	mov al, 12
	jmp short irq1make

prn2_int:

	push ax
	mov al, 13
	jmp short irq1make

fd_int:

	push ax
	mov al, 14
	jmp short irq1make

prn1_int:

	push ax
	mov al, 15

irq1make:

	test    byte ptr [esp + 12], 2
	jnz      v86irq1
	mov     al, EOI
	out     MASTER, al
	pop ax
	iretd

v86irq1:
ASSUME SS:STAK2_0

	mov ss:[irqnumber], al
	pop ax
	pushad
	mov dl, ss:[irqnumber]
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

; 'Interrupts' de 'Hardware' de n°vel 1. Necess†rio sinalizar EOI
; ('End of Interrupt') para o 8259A Master e Slave.

rtc_int:

	push ax
	mov al, 70h
	jmp short irq2make

irq09:

	push ax
	mov al, 71h
	jmp short irq2make

irq10:

	push ax
	mov al, 72h
	jmp short irq2make

irq11:

	push ax
	mov al, 73h
	jmp short irq2make

irq12:

	push ax
	mov al, 74h
	jmp short irq2make

ncoproc_int:

	push ax
	mov al, 75h
	jmp short irq2make

hd_int:

	push ax
	mov al, 76h
	jmp short irq2make

irq15:

	push ax
	mov al, 77h

irq2make:

	test    byte ptr [esp + 12], 2
	jnz      v86irq2
	mov     al, EOI
	out     SLAVE, al
	out     MASTER, al
	pop ax
	iretd

v86irq2:

	mov ss:[irqnumber], al
	pop ax
	pushad
	mov dl, ss:[irqnumber]
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

ENDSEG INT_HANDLERS

; Rotinas de Serviáo †s 'Exceptions'

MEMORYSEG FAULT_HANDLERS, EXONLY, 0, USE32

	ASSUME CS:FAULT_HANDLERS, DS:NOTHING

fault_00:

	test byte ptr ss:[esp+10],2
	jnz short virtualdiv
	mov al, 0
	jmp end_fault

virtualdiv:

	pushad
	mov dl, 0
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

fault_01:

	test byte ptr ss:[esp+10],2
	jnz short virtualdebug
	mov al, 1
	jmp end_fault

virtualdebug:

	pushad
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	dec byte ptr ds:[_tracecounter]
	jnz tracecounternotzero
	mov byte ptr ds:[_tracecounter], 32

tracecounternotzero:

	movzx esi, word ptr ds:[_tracecounter]
	dec esi
	add esi, esi
	mov ax, word ptr ss:[esp + 36]
	mov word ptr ds:[_tracebuffer_cs + esi], ax
	mov ax, word ptr ss:[esp + 32]
	mov word ptr ds:[_tracebuffer_ip + esi], ax
	inc dword ptr ds:[_no_of_instrs]

ASSUME DS:NOTHING

	mov dl, 1
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

fault_02:

	test byte ptr ss:[esp+10],2
	jnz short virtualf2
	mov al, 2
	jmp end_fault

virtualf2:

	pushad
	mov dl, 2
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

fault_03:

	test byte ptr ss:[esp+10],2
	jnz short virtualf3
	mov al, 3
	jmp end_fault

virtualf3:

	pushad
	mov dl, 3
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0


fault_04:

	test byte ptr ss:[esp+10],2
	jnz short virtualf4
	mov al, 4
	jmp end_fault

virtualf4:

	pushad
	mov dl, 4
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

fault_05:

	test byte ptr ss:[esp+10],2
	jnz short virtualf5
	mov al, 5
	jmp end_fault

virtualf5:

	pushad
	mov dl, 5
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

fault_06:

	test byte ptr ss:[esp+10],2
	jnz short virtualf6

endfault6:

	mov al, 6
	jmp end_fault

virtualf6:

	pushad
	mov esi, dword ptr ss:[esp + 36]
	shl esi, 4
	mov eax, dword ptr ss:[esp + 32]
	add esi, eax
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax

ASSUME DS:NOTHING

	mov ax, word ptr ds:[esi]
	cmp ax, 0c10fh
       _popad
	jnz short endfault6
	mov eax, dword ptr ss:[esp]     ; RecuperaáÑo da instruáÑo XADD
					; que em alguns CPU em Modo Virtual 86
					; nÑo actua devidamente. 
	add dword ptr ss:[esp], 5
	inc ecx
	iretd

fault_07:

	test byte ptr ss:[esp+10],2
	jnz short virtualf7
	mov al, 7
	jmp end_fault

virtualf7:

	pushad
	mov dl, 7
	JMP_FAR3232 GDT:faulthandler_seg, FAULT_HANDLERS:v86int,0

fault_09:

	mov al, 9
	jmp end_fault

fault_11:

	mov al, 11
	jmp end_fault

; O 'handler' mais solicitado de todos: "General Protection Fault"

fault_13:

	test byte ptr ss:[esp+14],2    ; a 'GPF' tem sempre c¢digo de erro
				       ; por conseguinte o registo EFLAGS
				       ; est† mais acima.
	jnz short v86genv86
	jmp true_fault13

v86genv86:

ASSUME DS:_DATA

	push eax
	mov ax, offset GDT:Mega2RealDataDesc
	mov ds, ax
	mov eax, dword ptr ss:[esp + 4]
	mov ds:[_stackerror], eax          ; guardamos o c¢digo de erro pois
					   ; se nÑo haver tratamento para o
					   ; mesmo no Émbito do 'handler'
					   ; "cairemos" para o Modo Real com
					   ; essa informaáÑo.
	pop eax

ASSUME DS:NOTHING

	add esp,4               ; J† podemos saltar por cima do c¢digo erro

	pushad                  ;  Para referància:
				;  Os valores na pilha ap¢s esta instruáÑo
				;  GS    = ESP + 64
				;  FS    = ESP + 60
				;  DS    = ESP + 56
				;  ES    = ESP + 52
				;  SS    = ESP + 48
				; ESP    = ESP + 44
				; EFLAGS = ESP + 40
				;  CS    = ESP + 36
				; EIP    = ESP + 32
				; EAX    = ESP + 28
				; ECX    = ESP + 24
				; EDX    = ESP + 20
				; EBX    = ESP + 16
				; ESP    = ESP + 12 (velho ESP)
				; EBP    = ESP +  8
				; ESI    = ESP +  4
				; EDI    = ESP 

	mov ax, offset GDT:VeryBigDataDesc
	mov ds,ax
	movzx ebx,word ptr ss:[esp+36]          ; CS do erro.
	shl ebx,4
	movzx eax, word ptr ss:[esp + 32]       ; IP do erro.
	add ebx, eax                            ; Endereáo linear do erro.
	inc word ptr ss:[esp+32]
	mov al,ds:[ebx]                         ; O 'opcode' que motivou o erro.

	push ds
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	cmp byte ptr ds:[_trace_status], FALSE ; Estamos em 'single step' devido
					       ; ao comando TRACE /ON ?
	pop ds
	jz trapflagdone

ASSUME DS:NOTHING

	or word ptr ss:[esp + 40], 100h  ; "Trap Flag" ligada.

trapflagdone:

; Instruáîes Privilegiadas que vÑo ser emuladas em Modo Protegido.
; Ex: Mov eax, cr0

	mov cx, word ptr ds:[ebx]
	xchg ch, cl
	cmp cx, 0f20h
	jb short notprotinstr
	cmp cx, 0f26h
	ja short notprotinstr
	xchg ch, cl
	mov dx, offset GDT:FakingDataHigh
	mov es, dx
	xor edi, edi
	mov word ptr es:[edi], cx
	mov cl, byte ptr ds:[ebx + 2]
	mov byte ptr es:[di + 2], cl
       _popad
	CALL_FAR3232 GDT:FakingCodeHigh, FAKECODE:initfakecode,0
	add dword ptr ss:[esp], 2
	iretd


; Tratamento das instruáîes de Input/Output marcadas no 'I/O Permission Bit Map'
; Procede-se aqui tambÇm a um exemplo de tratamento que Ç simulaáÑo de menos
; mem¢ria 'extended'.

notprotinstr:

	cmp al, 0e6h
	jz outport1
	cmp al, 0e7h
	jz outport2
	cmp al, 0eeh
	jz outport3
	cmp al, 0efh
	jz outport4
	cmp al,6eh
	jz outport5
	cmp al, 6fh
	jz outport6
	jmp notoutport

outport1:

	mov al, byte ptr ss:[esp+28]
	xor dx, dx
	mov dl, byte ptr ds:[ebx + 1]
	out dx, al
	jmp short $ + 2
	jmp short $ + 2
	inc word ptr ss:[esp+32]
	cmp dx, 70h
	jnz endoutport1
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	mov byte ptr ds:[cmosextmem], FALSE
	and al, 3fh
	cmp al, 18h
	jz ourindexport1
	cmp al, 31h
	jnz endoutport1

ourindexport1:

	mov byte ptr ds:[cmosextmem], TRUE

ASSUME DS:NOTHING
endoutport1:

	jmp exit_to_virt86

outport2:
   
	mov ax, word ptr ss:[esp+28]
	xor dx, dx
	mov dl, byte ptr ds:[ebx + 1]
	out dx, ax
	jmp short $ + 2
	jmp short $ + 2
	inc word ptr ss:[esp+32]
	jmp exit_to_virt86

outport3:

	mov al, byte ptr ss:[esp+28]
	mov dx, word ptr ss:[esp+20]
	out dx, al
	jmp short $ + 2
	jmp short $ + 2
	cmp dx, 70h
	jnz endoutport3
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	mov byte ptr ds:[cmosextmem], FALSE
	and al, 3fh
	cmp al, 18h
	jz ourindexport3
	cmp al, 31h
	jnz endoutport3

ourindexport3:

	mov byte ptr ds:[cmosextmem], TRUE

ASSUME DS:NOTHING

endoutport3:

	jmp exit_to_virt86

outport4:

	mov ax, word ptr ss:[esp+28]
	mov dx, word ptr ss:[esp+20]
	out dx, ax
	jmp short $ + 2
	jmp short $ + 2
	jmp exit_to_virt86

outport5:

	movzx ebx, word ptr ss:[esp + 56]
	shl ebx, 4
	add ebx, dword ptr ss:[esp + 4]
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	mov al, byte ptr ds:[ebx]
	mov dx, word ptr ss:[esp + 20]
	out dx, al
	jmp short $ + 2
	jmp short $ + 2
	cmp dx, 70h
	jnz endoutport5
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	mov byte ptr ds:[cmosextmem], FALSE
	and al, 3fh
	cmp al, 18h
	jz ourindexport5
	cmp al, 31h
	jnz endoutport5

ourindexport5:

	mov byte ptr ds:[cmosextmem], TRUE

ASSUME DS:NOTHING

endoutport5:

	test byte ptr ss:[esp + 41], 4
	jz adv_si1
	dec dword ptr ss:[esp + 4]
	jmp short endout5

adv_si1:

	inc dword ptr ss:[esp + 4]

endout5:

	jmp exit_to_virt86

outport6:

	movzx ebx, word ptr ss:[esp + 56]
	shl ebx, 4
	add ebx, dword ptr ss:[esp + 4]
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	mov ax, word ptr ds:[ebx]
	mov dx, word ptr ss:[esp + 20]
	out dx, ax
	jmp short $ + 2
	jmp short $ + 2
	test byte ptr ss:[esp + 41], 4
	jz adv_si2
	sub dword ptr ss:[esp + 4], 2
	jmp short endout6

adv_si2:

	add dword ptr ss:[esp + 4], 2

endout6:

	jmp exit_to_virt86

notoutport:

	cmp al, 0e4h
	jz inport1
	cmp al, 0e5h
	jz inport2
	cmp al, 0ech
	jz inport3
	cmp al, 0edh
	jz inport4
	cmp al,6ch
	jz inport5
	cmp al, 6dh
	jz inport6
	jmp notinport

inport1:

	xor dx, dx
	xor al, al
	mov dl, byte ptr ds:[ebx + 1]
	in al, dx
	jmp short $ + 2
	jmp short $ + 2
	cmp dl, 71h
	jnz notourinp1
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	cmp byte ptr ds:[cmosextmem], TRUE
	jnz notourinp1
	sub al, 4

ASSUME DS:NOTHING

notourinp1:

	mov byte ptr ss:[esp + 28], al
	inc word ptr ss:[esp+32]
	jmp exit_to_virt86

inport2:

	xor dx, dx
	mov dl, byte ptr ds:[ebx + 1]
	in ax, dx
	jmp short $ + 2
	jmp short $ + 2
	mov word ptr ss:[esp + 28], ax
	inc word ptr ss:[esp+32]
	jmp exit_to_virt86

inport3:

	mov dx, word ptr ss:[esp+20]
	in al, dx
	jmp short $ + 2
	jmp short $ + 2
	cmp dx, 71h
	jnz notourinp3
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	cmp byte ptr ds:[cmosextmem], TRUE
	jnz notourinp3
	sub al, 4

ASSUME DS:NOTHING

notourinp3:

	mov byte ptr ss:[esp + 28], al
	jmp exit_to_virt86

inport4:

	mov dx, word ptr ss:[esp+20]
	in ax, dx
	jmp short $ + 2
	jmp short $ + 2
	mov word ptr ss:[esp + 28], ax
	jmp exit_to_virt86

inport5:

	movzx ebx, word ptr ss:[esp + 52]
	shl ebx, 4
	add ebx, dword ptr ss:[esp]
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	mov dx, word ptr ss:[esp + 20]
	in al, dx
	jmp short $ + 2
	jmp short $ + 2
	cmp dx, 71h
	jnz notourinp5
	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	cmp byte ptr ds:[cmosextmem], TRUE
	jnz notourinp5
	sub al, 4

ASSUME DS:NOTHING

notourinp5:

	mov dx, offset GDT:VeryBigdataDesc
	mov ds, dx
	mov byte ptr ds:[ebx], al
	test byte ptr ss:[esp + 41], 4
	jz adv_di1
	dec dword ptr ss:[esp]
	jmp short endinp5

adv_di1:

	inc dword ptr ss:[esp]

endinp5:

	jmp exit_to_virt86

inport6:

	movzx ebx, word ptr ss:[esp + 52]
	shl ebx, 4
	add ebx, dword ptr ss:[esp]
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	mov dx, word ptr ss:[esp + 20]
	in ax, dx
	mov word ptr ds:[ebx], ax
	test byte ptr ss:[esp + 41], 4
	jz adv_di2
	sub dword ptr ss:[esp], 2
	jmp short endinp6

adv_di2:

	add dword ptr ss:[esp], 2

endinp6:

	jmp exit_to_virt86

notinport:

	cmp al,0fah                     ; cli ?
	jnz notcli
	and word ptr ss:[esp+40],0fdffh ; 'Interrupt flag' a 0.
	jmp exit_to_virt86

notcli:

	cmp al, 0fbh                    ; sti ?
	jnz notsti
	or word ptr ss:[esp+40],0200h   ; 'Interrupt flag' a 1.
	jmp exit_to_virt86

notsti:

	cmp al, 9ch             ; pushf ?
	jnz notpushf
	movzx edx,word ptr ss:[esp+48]
	shl edx,4
	sub word ptr ss:[esp+44], 2
	movzx eax, word ptr ss:[esp + 44]
	add edx, eax
	mov ax, word ptr ss:[esp+40]
	mov word ptr ds:[edx],ax
	jmp exit_to_virt86

notpushf:

	cmp al, 9dh             ; popf ?
	jnz notpopf
	movzx edx,word ptr ss:[esp+48]
	shl edx,4
	movzx eax, word ptr ss:[esp + 44]
	add edx,eax
	mov ax, word ptr ds:[edx]
	add word ptr ss:[esp+44], 2
	mov word ptr ss:[esp+40], ax
	jmp exit_to_virt86

notpopf:

	cmp al, 0cfh            ; iret ?
	jnz notiret
	movzx edx,word ptr ss:[esp+48]
	shl edx,4
	movzx eax, word ptr ss:[esp + 44]
	add edx, eax
	mov ax, ds:[edx + 4]
	mov word ptr ss:[esp + 40], ax
	movzx eax, word ptr ds:[edx + 2]
	mov dword ptr ss:[esp + 36], eax
	movzx eax, word ptr ds:[edx]
	mov dword ptr ss:[esp + 32], eax
	add word ptr ss:[esp+44],6
	jmp exit_to_virt86

notiret:

	mov dl,3
	cmp al,0cch             ; int 3 ?
	jne contcheck
	jmp v86int

contcheck:

	cmp al,0ceh
	jbe precheck

ASSUME DS:_DATA

prefault13:

	dec word ptr ss:[esp+32]
       _popad
	mov ax, offset GDT:Mega2RealDataDesc
	mov ds, ax
	mov eax, dword ptr ds:[_stackerror]
	push eax

ASSUME DS:NOTHING

	jmp true_fault13

precheck:

	jne check2
	jmp v86genv86ni ; into

check2:

	cmp al, 0cdh
	jne prefault13

	inc word ptr ss:[esp+32]
	mov dl, byte ptr ds:[ebx+1]

; Interrupt FDH Ç utilizado para interface de programas DOS com o nosso Programa
; Monitor de Modo virtual.

	cmp dl, 0fdh             ; Interrupt FDH ?
	jnz testint15
	cmp dword ptr ss:[esp + 28], 99ff99ffh   ; Para sair para Modo Real
	jnz disablecop

       _popad
	mov al, 0ffh
	jmp end_fault

disablecop:

	cmp dword ptr ss:[esp + 28], 12345678h   ; Desactivar "Task Switched Flag"
	jnz IamHere
	clts
	jmp exit_to_virt86

IamHere:

	cmp dword ptr ss:[esp + 28], 88ff88ffh  ; InformaáÑo de que estamos
						; instalados.
	jnz v86int
	mov dword ptr ss:[esp + 28], "V86"
	jmp exit_to_virt86

testint15:

	cmp dl, 15h             ; Interrupt 15H ?
	jnz testint2f

; SÑo emuladas 3 funáîes do Int 15H

	mov ah, byte ptr ss:[esp+29]    
	cmp ah, 87h             ; FunáÑo 'Copy Extended Memory"
	je int15_87
	cmp ah, 88h             ; FunáÑo 'Get Extended Memory Size'
	je int15_88
	cmp ah, 89h             ; FunáÑo 'Switch to Protected Mode'
	jne v86int
	mov ax,0ff00h           ; Sinala erro.
	mov word ptr ss:[esp + 28], ax
	mov ax, word ptr ss:[esp + 40]
	or ax, 1
	mov word ptr ss:[esp+40], ax
	jmp exit_to_virt86

int15_88:

ASSUME DS:_DATA

	mov ax, offset GDT:Mega2RealDataDesc
	mov ds, ax
	mov eax, ds:[_ReportVirtExtended]

ASSUME DS:NOTHING

	mov dword ptr ss:[esp + 28], eax
	mov ax, word ptr ss:[esp + 40]
	and ax, 0fffeh
	mov word ptr ss:[esp+40], ax
	jmp exit_to_virt86

; A emulaáÑo desta funáÑo permite que programas como o EXTVIEW.EXE (Spooler
; nß 23) espiem o conte£do da mem¢ria "extended"

int15_87:

	movzx eax, word ptr ss:[esp + 52]
	shl eax, 4
	movzx esi, word ptr ss:[esp + 4]
	add esi, eax
	movzx ecx, word ptr ss:[esp + 24]
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	mov es, ax
	mov edi, esi
	mov edx, ecx
	add esi, 16
	add cx, cx
	dec cx
	cmp es:[esi], cx
	jb errorint15_87
	add esi, 8
	cmp word ptr es:[esi], cx
	jb errorint15_87
	mov esi, edi
	add esi, 21
	cmp byte ptr es:[esi], 93h
	jnz errorint15_87
	add esi, 8
	cmp byte ptr es:[esi], 93h
	jnz errorint15_87
	mov esi, edi
	mov ecx, edx
	add esi, 18
	mov esi, dword ptr es:[esi]
	add edi, 26
	mov edi, dword ptr es:[edi]
	and esi, 0ffffffh
	and edi, 0ffffffh
	and ecx, 07fffh
	cld
	rep movs word ptr [esi], word ptr [edi]
	mov ax, 0
	mov word ptr ss:[esp + 28], ax
	mov ax, word ptr ss:[esp + 40]
	and ax, 0fffeh
	mov word ptr ss:[esp+40], ax
	jmp exit_to_virt86

errorint15_87:

	mov ax,200h                             ; Sinala erro de 'interrupt'
	mov word ptr ss:[esp + 28], ax
	mov ax, word ptr ss:[esp + 40]          ; 'Carry flag'
	or ax, 1
	mov word ptr ss:[esp+40], ax
	jmp exit_to_virt86

testint2f:

; ExecuáÑo de Comandos internos.
; O processador de comandos Command.com ou 4dos.com (mas versîes antes de
; 4.02B contàm 'bugs' neste serviáo) Ç interceptado permitindo a substituiáÑo
; ou a adiáÑo de novos comandos internos.

	cmp dl, 2fh
	jnz testint67
	mov ax, word ptr ss:[esp+28]
	cmp ax, 0ae00h          ; "Instalable command" - Check
	je check_command

	cmp ax, 0ae01h          ; "Instalable command" - Execute
	je exec_cmd
	jmp v86int

check_command:

	mov edi, offset _DATA:exit_command
	mov ecx, 4
	call near ptr compare_name
	je found_command
	mov edi, offset _DATA:trace_command
	mov ecx, 6
	call near ptr compare_name
	je found_command
	jmp v86int

found_command:

	mov al,0ffh
	mov byte ptr ss:[esp + 28], al
	and word ptr ss:[esp+40],0fcffh   ; 'Interrupt' e 'Trap' flags a 0.
	jmp exit_to_virt86

exec_cmd:

	mov edi, offset _DATA:exit_command
	mov ecx, 4
	call near ptr compare_name
	je found_exit_command
	mov edi, offset _DATA:trace_command
	mov ecx, 6
	call near ptr compare_name
	je found_trace
	jmp v86int

found_trace:

	mov edi, offset _DATA:on_cline
	mov ebx, offset _DATA:trace_command
	mov ecx, 2
	call near ptr compare_cline
	mov al, TRUE
	je end_trace_rotine1
	mov edi, offset _DATA:off_cline
	mov ebx, offset _DATA:trace_command
	mov ecx, 3
	call near ptr compare_cline
	mov al, FALSE
	jne end_trace_rotine2

end_trace_rotine1:

	mov dx, offset GDT:Mega2RealDataDesc
	mov ds, dx

ASSUME DS:_DATA

	mov byte ptr ds:[_trace_status], al

ASSUME DS:NOTHING

end_trace_rotine2:

	movzx eax, word ptr ss:[esp + 56]    ; DS do modo virtual
	shl eax, 4
	movzx esi, word ptr ss:[esp + 4]     ; SI do modo virtual
	add esi, eax                         ; Endereáo linear.
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	mov byte ptr ds:[esi], 0
	and word ptr ss:[esp+40],0fcffh   ; 'Interrupt' e 'Trap' flags a 0.
	jmp exit_to_virt86

found_exit_command:

	mov ax, offset GDT:VeryBigDataDesc
	mov ds,ax
	movzx ebx,word ptr ss:[esp+36]
	shl ebx,4
	add ebx,ss:[esp+32]
	mov word ptr ss:[esp + 28], 0d00h         ; mov ax, 0d00h
	mov word ptr ds:[ebx], 21cdh              ; int 21
	mov dword ptr ds:[ebx + 2], 99ffb866h     ; mov eax, 99ff99ff
	mov dword ptr ds:[ebx + 6], 0fdcd99ffh    ; int 0fdh
	jmp exit_to_virt86

testint67:

	cmp dl, 67h             ; Int 67H
	jnz v86int
	mov ah, 80h             ; Sinala erro . NÑo h† mem¢ria 'expanded'.
				; Necess†rio pois alguns programas partem
				; do principio que a execuáÑo em Modo Virtual
				; pressupîe a existància de um emulador
				; de mem¢ria "expanded", e como alguns BIOS nÑo
				; providenciam qualquer "handler default"
				; para este "interrupt", o resultado poderia ser
				; ir-se ter onde menos se esperava.

	mov byte ptr ss:[esp+29], ah
	jmp exit_to_virt86

v86genv86ni:

	mov dl,4

v86int:                       ; Simula 'Interrupt' em Modo Virtual 86

	mov ax, offset GDT:VeryBigDataDesc
	mov ds,ax
	movzx ebx,dl
	shl ebx,2
	movzx edx,word ptr ss:[esp+48]
	shl edx,4
	sub word ptr ss:[esp+44],6
	movzx eax, word ptr ss:[esp + 44]
	add edx, eax
	mov ax, word ptr ss:[esp+40]
	mov word ptr ds:[edx+4],ax
	mov ax, word ptr ss:[esp+36]
	mov word ptr ds:[edx+2],ax
	mov ax, word ptr ss:[esp+32]
	mov word ptr ds:[edx],ax
	and word ptr ss:[esp+40],0fcffh   ; 'Interrupt' e 'Trap' flags a 0.
	mov eax, dword ptr ds:[ebx]
	mov word ptr ss:[esp+32], ax
	shr eax,16
	mov word ptr ss:[esp+36], ax

exit_to_virt86:

	_popad
	 iretd

compare_name proc near

	mov ax, offset GDT:Mega2RealDataDesc
	mov es, ax
	movzx eax, word ptr ss:[esp + 60]    ; DS do modo virtual
	shl eax, 4
	movzx esi, word ptr ss:[esp + 8]     ; SI do modo virtual
	add esi, eax                         ; Endereáo linear.
	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax

ASSUME ES:_DATA

	cld
	repe cmps byte ptr ds:[esi], byte ptr es:[edi]
	ret

ASSUME ES:NOTHING

compare_name endp

compare_cline proc near

ASSUME DS:NOTHING

	mov ax, offset GDT:Mega2RealDataDesc
	mov es, ax
	mov al, es:[ebx]
	xor ebx, ebx
	xchg al, bl
	movzx eax, word ptr ss:[esp + 60]    ; DS do modo virtual
	shl eax, 4
	movzx esi, word ptr ss:[esp + 20]    ; BX do modo virtual
	add esi, eax                         ; Endereáo linear.

	mov ax, offset GDT:VeryBigDataDesc
	mov ds, ax
	add bl, 2
	mov dl, 127
	sub dl, bl
	sub dl, cl
	add esi, ebx
	push ecx
	movzx ecx, dl

lookfchar:

	mov al, ds:[esi]
	cmp al, '/'
	jz found1stchar
	inc esi
	loop lookfchar
	dec ecx
	pop ecx
	ret

found1stchar:

	pop ecx
	inc esi

testcomp:

	mov al, byte ptr ds:[esi]
	or al, 20h
	mov ah, byte ptr es:[edi]
	or ah, 20h
	cmp al, ah
	jnz exitcomp_cline
	inc esi
	inc edi
	dec ecx
	jnz testcomp

exitcomp_cline:

	ret

ASSUME ES:NOTHING

compare_cline endp

true_fault13:

	mov al, 13
	jmp end_fault

fault_16:

	mov al, 16
	jmp end_fault

undefined:

	mov al, 15
	jmp end_fault

fault_ts:

ASSUME ES:F14TSS   ; Podia ser F12TSS ou outro

	pop eax
	mov bx, es:[back_link]
	lar dx, bx
	jnz fake_data
	test dh, 80h
	jz fake_data
	and dh, 1fh
	cmp dh, TSS_BUSY
	jnz fake_data
	lsl dx, bx
	cmp dx, TSS_LIMIT
	jb fake_data
	mov di, offset GDT:falias
	mov dx, offset GDT:gdt_dat
	mov es, dx
	and bx, 0fff8h

ASSUME ES:GDT

	mov cx, es:[bx].LO_apDesc386
	mov es:[di].LO_apDesc386, cx
	mov cl, es:[bx].MID_apDesc386
	mov es:[di].MID_apDesc386, cl
	mov cl, es:[bx].HI_apDesc386
	mov es:[di].HI_apDesc386, cl
	mov es:[di].limDesc386, TSS_LIMIT
	mov es, di
	xor bx,bx
	push bx
	push word ptr es:[rGS]
	push bx
	push word ptr es:[rFS]
	push bx
	push word ptr es:[rDS]
	push bx
	push word ptr es:[rES]
	push bx
	push word ptr es:[rSS]
	push dword ptr es:[rESP]
	push dword ptr es:[EFLAGS]
	push bx
	push word ptr es:[rCS]
	push dword ptr es:[rIP]
	push eax
	mov eax, esi
	jmp end_fault2

fake_data:

	mov ebx, 0
	push ebx
	push ebx
	push ebx
	push ebx
	push ebx
	push ebx
	push ebx
	push bx
	push word ptr 0ffffh
	push dword ptr 0fffffffch
	push eax
	mov eax, esi
	jmp end_fault2


; Tratamento "post mortem". PreparaáÑo da reentrada em Modo real

end_fault:

	mov bx, offset GDT:Mega2RealDataDesc
	mov ds, bx

ASSUME DS:_DATA

	mov ebx, dword ptr ds:[protcr3]
	mov cr3, ebx
	jmp short $ + 2
	cmp al, 0ffh
	jz end_report

end_fault2:

	mov bx, offset GDT:Mega1RealDataDesc
	mov ds, bx
	mov ds:[_erro], TRUE
	mov ds:[_code_erro], al
	mov esi, 4
	cmp al, 8
	jz has_errorcode1
	cmp al, 10
	jb no_errorcode
	cmp al, 14
	ja no_errorcode
	jb has_errorcode1
	mov eax, cr2
	mov ds:[_pageerror], eax
	mov ds:[_pageerrorok], TRUE
	jmp short has_errorcode2

has_errorcode1:

	mov ds:[_stackerrorok], TRUE

has_errorcode2:

	mov eax, dword ptr ss:[esp]
	mov ds:[_stackerror], eax
	mov esi, 8

no_errorcode:

	call near ptr fillregvals

end_report:

	call near ptr HightoLowMem
	call near ptr reset_kb
	JMP_FAR3216 GDT:RealCodeDesc, _TEXT:EndProt, 0

fillregvals proc near

	mov ax, offset GDT:Mega1RealDataDesc
	mov ds, ax
	mov eax, dword ptr ss:[esp+esi]
	mov ds:[_stackeip], eax
	mov ax, word ptr ss:[esp+esi+4]
	mov ds:[_stackcs], ax
	mov eax, dword ptr ss:[esp+esi+8]
	mov ds:[_stackflags], eax
	mov eax, dword ptr ss:[esp+esi+12]
	mov ds:[_stackesp], eax
	mov ax, word ptr ss:[esp+esi+16]
	mov ds:[_stackss], ax
	test byte ptr ss:[esp+esi+10],2
	jz endfill

	mov ds:[_stackvirt], TRUE
	mov ax, word ptr ss:[esp + esi+ 20]
	mov ds:[_stackes], ax
	mov ax, word ptr ss:[esp + esi+ 24]
	mov ds:[_stackds], ax
	mov ax, word ptr ss:[esp + esi + 28]
	mov ds:[_stackfs], ax
	mov ax, word ptr ss:[esp + esi + 32]
	mov ds:[_stackgs], ax

	mov ax, offset GDT:VeryBigDataDesc
	mov fs, ax

	movzx eax, ds:[_stackss]
	shl eax, 4
	add eax, ds:[_stackesp]
	mov edi, eax
	mov ecx, 16
	mov esi, 0

loopstack:

	mov bl, byte ptr fs:[edi]
	mov byte ptr ds:[_virtstack + esi], bl
	inc edi
	inc esi
	loop loopstack

	movzx eax, ds:[_stackcs]
	shl eax, 4
	add eax, ds:[_stackeip]
	mov edi, eax
	mov ecx, 32
	sub edi, 16
	jnc notbelow
	not edi
	inc edi
	mov eax, 16
	sub eax, edi
	mov ds:[_stackbytesbelow], eax
	mov ecx, 16
	add ecx, eax
	mov edi, 0

notbelow:

	mov esi, 0

looperr:

	mov bl, byte ptr fs:[edi]
	mov byte ptr ds:[_stackbytes + esi], bl
	inc edi
	inc esi
	loop looperr

endfill:

	ret

fillregvals endp

HightoLowMem proc near

	mov ax, offset GDT:VeryBigDataDesc
	mov es, ax
	mov ds, ax
	mov eax, dword ptr ds:[46ch]      ; Actualizar o nß de "timer ticks"
					  ; ou o "rel¢gio" ficaria atrazado.
	mov dword ptr ds:[10046ch], eax        
	mov al, byte ptr ds:[470h]
	mov byte ptr ds:[100470h], al

	mov esi, 100000h
	mov edi, 0
	mov ecx, 28000h      ; 0A0000h/4
	cld
	rep movs dword ptr [esi], dword ptr [edi]

; Necess†rio esta limpeza pois alguns programas verificam se a
; Gate A20 est† aberta comparando os primeiros bytes do primeiro
; e segundo Megabytes. Por ex: Borland C++ 3.1

	mov edi, 100000h
	mov eax, 0
	mov ecx, 400h      ;01000h/4         ; 1024 bytes devem chegar mesmo
					     ; para os programas mais cÇpticos.
	cld
	rep stos dword ptr es:[edi]
	ret

HightoLowMem endp

; ReinicializaáÑo do controlador de teclado.

reset_kb proc near

	pushf
	cli
	push eax
	push bx
	push ecx
	push es

	mov ax, offset GDT:VeryBigDataDesc
	mov es,ax
	mov bl,es:[417h]
	shr bl,4
	and bl,0fh
	call setkb
	in al,21h
	or al,2
	out 21h,al
	pop es
	pop ecx
	pop bx
	pop eax
	popf
	ret

reset_kb endp


setkb proc near

	mov al,0edh
	call outtokb
	mov al,bl
	call outtokb
	mov al,0f4h

outtokb:

	mov ah,al
	mov bh,3

outtokbl0:

	call waitforkb
	mov al,ah
	out 60h,al
	mov ecx,4000h

outtokbl1:

	in al,61h
	test al,10h
	jz $-4
	in al,61h
	test al,10h
	jnz $-4
	in al,64h
	test al,1
	loopz outtokbl1
	in al,60h
	cmp al,0fah
	je endouttokbl1
	dec bh
       jnz outtokbl0

endouttokbl1:

	ret

setkb endp

waitforkb proc near

	mov ecx,20000h

waitforkbl:

	in al,64h
	test al,2
	loopnz waitforkbl
	ret

waitforkb endp

ENDSEG FAULT_HANDLERS

MEMORYSEG    DSC,RD_WR,0,USE32

; Uma das pilha de Modo Protegido

EVEN
	dw      200h DUP (0)

dsc_top_of_stack LABEL WORD

ENDSEG  DSC

SYSTEMSEG INIT_TSS, TSS_AV, 0
	TSS_BLOCK <>
ENDSEG INIT_TSS

SYSTEMSEG VIRT_TSS, TSS_AV, 0
	TSS_BLOCK <>

io_map0         db 14 dup (0)
		db 03h                 ; Portos 70h e 71h
		db 8177 dup (0)
; io_map        db 2000h dup (0)
		db 0ffh

ENDSEG VIRT_TSS

SYSTEMSEG F08TSS, TSS_AV, 0

	dw 0                            ; back link
	dw 0                            ; intel_reserved1
	dd offset STAK3_0:stak3_end     ; SP0 *
	LDT_SEL errorstk_1, 0           ; rSS0 *
	dw 0                            ; intel_reserved2
	dd 0                            ; rSP1
	dw 0                            ; rSS1
	dw 0                            ; intel_reserved3
	dd 0                            ; rSP2
	dw 0                            ; rSS2
	dw 0                            ; intel_reserved4
	dd ?                            ; rCR3
	dd fault_ts                     ; rIP
	dd 0                            ; EFLAGS
	dd 4 dup (0)                    ; rEAX / rECX / rEDX / rEBX
	dd offset STAK4_0:stak4_end     ; rESP
	dd offset STAK4_0:stak4_end     ; rEBP
	dd 08                           ; rESI
	dd 0                            ; rEDI
	GDT_SEL aliasf08, 0             ; rES
	dw 0                            ; intel_reserv5
	GDT_SEL faulthandler_seg,0      ; rCS
	dw 0                            ; intel_reser6
	LDT_SEL errorstk_2, 0           ; rSS
	dw 0                            ; intel_reserv7
	LDT_SEL errorstk_2, 0           ; rDS
	dw 0                            ; intel_reserv8
	dw 0                            ; rFS
	dw 0                            ; intel_reserv9
	dw 0                            ; rGS
	dw 0                            ; intel_reserv10
	GDT_SEL errorldt, 0             ; task_LDT
	dw 0                            ; intel_reserv11
	dw 0                            ; intel_reserv12
	dw 104                          ; io_mapbase

ENDSEG F08TSS


SYSTEMSEG F10TSS, TSS_AV, 0

	dw 0                            ; back link
	dw 0                            ; intel_reserved1
	dd offset STAK3_0:stak3_end     ; SP0 *
	LDT_SEL errorstk_1, 0           ; rSS0 *
	dw 0                            ; intel_reserved2
	dd 0                            ; rSP1
	dw 0                            ; rSS1
	dw 0                            ; intel_reserved3
	dd 0                            ; rSP2
	dw 0                            ; rSS2
	dw 0                            ; intel_reserved4
	dd ?                            ; rCR3
	dd fault_ts                     ; rIP
	dd 0                            ; EFLAGS
	dd 4 dup (0)                    ; rEAX / rECX / rEDX / rEBX
	dd offset STAK4_0:stak4_end     ; rESP
	dd offset STAK4_0:stak4_end     ; rEBP
	dd 10                           ; rESI
	dd 0                            ; rEDI
	GDT_SEL aliasf10, 0             ; rES
	dw 0                            ; intel_reserv5
	GDT_SEL faulthandler_seg,0      ; rCS
	dw 0                            ; intel_reser6
	LDT_SEL errorstk_2, 0           ; rSS
	dw 0                            ; intel_reserv7
	LDT_SEL errorstk_2, 0           ; rDS
	dw 0                            ; intel_reserv8
	dw 0                            ; rFS
	dw 0                            ; intel_reserv9
	dw 0                            ; rGS
	dw 0                            ; intel_reserv10
	GDT_SEL errorldt, 0             ; task_LDT
	dw 0                            ; intel_reserv11
	dw 0                            ; intel_reserv12
	dw 104                          ; io_mapbase

ENDSEG F10TSS



SYSTEMSEG F12TSS, TSS_AV, 0

	dw 0                            ; back link
	dw 0                            ; intel_reserved1
	dd offset STAK3_0:stak3_end     ; SP0 *
	LDT_SEL errorstk_1, 0           ; rSS0 *
	dw 0                            ; intel_reserved2
	dd 0                            ; rSP1
	dw 0                            ; rSS1
	dw 0                            ; intel_reserved3
	dd 0                            ; rSP2
	dw 0                            ; rSS2
	dw 0                            ; intel_reserved4
	dd ?                            ; rCR3
	dd fault_ts                     ; rIP
	dd 0                            ; EFLAGS
	dd 4 dup (0)                    ; rEAX / rECX / rEDX / rEBX
	dd offset STAK4_0:stak4_end     ; rESP
	dd offset STAK4_0:stak4_end     ; rEBP
	dd 12                           ; rESI
	dd 0                            ; rEDI
	GDT_SEL aliasf12, 0             ; rES
	dw 0                            ; intel_reserv5
	GDT_SEL faulthandler_seg,0      ; rCS
	dw 0                            ; intel_reser6
	LDT_SEL errorstk_2, 0           ; rSS
	dw 0                            ; intel_reserv7
	LDT_SEL errorstk_2, 0           ; rDS
	dw 0                            ; intel_reserv8
	dw 0                            ; rFS
	dw 0                            ; intel_reserv9
	dw 0                            ; rGS
	dw 0                            ; intel_reserv10
	GDT_SEL errorldt, 0             ; task_LDT
	dw 0                            ; intel_reserv11
	dw 0                            ; intel_reserv12
	dw 104                          ; io_mapbase

ENDSEG F12TSS


SYSTEMSEG F14TSS, TSS_AV, 0

	dw 0                            ; back link
	dw 0                            ; intel_reserved1
	dd offset STAK3_0:stak3_end     ; SP0 *
	LDT_SEL errorstk_1, 0           ; rSS0 *
	dw 0                            ; intel_reserved2
	dd 0                            ; rSP1
	dw 0                            ; rSS1
	dw 0                            ; intel_reserved3
	dd 0                            ; rSP2
	dw 0                            ; rSS2
	dw 0                            ; intel_reserved4
	dd ?                            ; rCR3
	dd fault_ts                     ; rIP
	dd 0                            ; EFLAGS
	dd 4 dup (0)                    ; rEAX / rECX / rEDX / rEBX
	dd offset STAK4_0:stak4_end     ; rESP
	dd offset STAK4_0:stak4_end     ; rEBP
	dd 14                           ; rESI
	dd 0                            ; rEDI
	GDT_SEL aliasf14, 0             ; rES
	dw 0                            ; intel_reserv5
	GDT_SEL faulthandler_seg,0      ; rCS
	dw 0                            ; intel_reser6
	LDT_SEL errorstk_2, 0           ; rSS
	dw 0                            ; intel_reserv7
	LDT_SEL errorstk_2, 0           ; rDS
	dw 0                            ; intel_reserv8
	dw 0                            ; rFS
	dw 0                            ; intel_reserv9
	dw 0                            ; rGS
	dw 0                            ; intel_reserv10
	GDT_SEL errorldt, 0             ; task_LDT
	dw 0                            ; intel_reserv11
	dw 0                            ; intel_reserv12
	dw 104                          ; io_mapbase

ENDSEG F14TSS


SYSTEMSEG T2LDT, LDT, 0

	DESC386  <0,0,0,0,0,0>
	DSCRP virtstk_0, STAK2_0

ENDSEG T2LDT

SYSTEMSEG T3LDT, LDT, 0

	DESC386  <0,0,0,0,0,0>
	DSCRP errorstk_1, STAK3_0
	DSCRP errorstk_2, STAK4_0

ENDSEG T3LDT

MEMORYSEG STAK2_0, RD_WR, 0, USE32

irqnumber       db ?
		dw 200h dup (0)
stak2_end LABEL WORD

ENDSEG STAK2_0

MEMORYSEG STAK3_0, RD_WR, 0, USE32

	dw 100h dup (0)
stak3_end LABEL WORD

ENDSEG STAK3_0

MEMORYSEG STAK4_0, RD_WR, 0, USE32

	dw 100h dup (0)
stak4_end LABEL WORD

ENDSEG STAK4_0

MEMORYSEG FAKECODE, EXONLY, 0, USE32

initfakecode LABEL BYTE
	db 3 dup (0)
	retf

ENDSEG FAKECODE

_STACK        SEGMENT PARA USE16 STACK 'STACK'

EVEN
stackint LABEL WORD
	dw 800h dup (0)
endstack LABEL WORD

ENDS

END _Protectentry

; _EOF_

