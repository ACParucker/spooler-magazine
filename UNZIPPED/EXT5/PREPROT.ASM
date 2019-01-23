.386P

TITLE PREPROT (VIRT86.EXE)

COMMENT %
	      Programa:.... VIRT86.EXE
	      Programa demonstrativo de execu‡„o em
	      Modo Virtual 86.

M¢dulo:...... PREPROT.ASM
Autor:....... Jos‚ P scoa

Compilado via: Borland C++ 3.1 (TASM)

Produzido em Dezembro 1993 para a revista SPOOLER.

Nota: S¢ ‚ execut vel em computadores com processador >= 386SX

%

INCLUDE SEGM.INC

_DATA SEGMENT PARA PUBLIC 'DATA'
EVEN
oldcurspos      dw 0
newcurspos      dw 0
AnsiCode        db "[6n$";
Limpeza         db 08,20h,8,8,20h,8,8,20h,8,8,20h,8,'$'
_versiondos     dw 0
_DATA ENDS


_TEXT SEGMENT BYTE PUBLIC 'CODE'

		ASSUME CS:_TEXT, DS:_DATA, ES:NOTHING

		PUBLIC OpenGateA20, CloseGateA20, IntrSet, RealModeErrors, IsAnsi
		PUBLIC  _check386, _IsProtectedMode
		PUBLIC  _Is_DPMI, _Is_Himem, _OldDos, _Is_Cache, _fakemem

;   Rotinas para abertura e fecho ao tr fego da linha A20
;   O DOS n„o abre 'por default' a linha A20 por raz”es de compatibilidade
;   com programas antigos.
;   Para entrarmos na mem¢ria acima do primeiro MegaByte temos de
;   abrir essa "porta dourada".
;   As rotinas que se seguem dever„o permitir abrir e fechar a linha A20
;   em cerca de 99% dos casos.

; Alguns EQUATES das rotinas que lidam com a linha A20

Status_Port     equ     64h
Cmd_rdy         equ     2
Write_outpt     equ     0d1h
Port_A          equ     60h
EnableA20       equ     0dfh
DisableA20      equ     0ddh


RealModeErrors proc near

	mov ah, 9
	int 21h
	mov ax, 4cffh
	int 21h

RealModeErrors endp

PS2_A20  proc near

	or ax, ax
	jz DisablePS2A20

OpenPS2A20:

	in al,92h
	test al, 2
	jz PS2A20isClosed
	mov al, 1
	jmp short ExitPS2_A20

PS2A20isClosed:

	or al, 2
	out 92h, al
	xor cx,cx

GoOn:

	in al,92h
	test al, 2
	loopz GoOn
	mov al, 1
	jz  short  ExitPS2_A20
	mov al, 0
	jmp short ExitPS2_A20

DisablePS2A20:

	in al, 92h
	and al, 0fdh
	out 92h ,al
	xor cx,cx
GoOff:

	in al, 92h
	test al, 2
	loopnz  GoOff
	mov al, 1
	jnz short ExitPS2_A20
	mov al, 0

ExitPS2_A20:

	ret

PS2_A20 endp

Is_PS2  proc near

	mov ah,0C0h                 ; 'System Description Vector'
	stc
	int 15h
	jc short PS2notFound
	mov al,byte ptr es:[bx+5]   ; MicroChannel ?
	test al, 2
	jz short PS2notFound

	xor ax,ax                   ; Primeiro desactiva A20
	call PS2_A20
	mov ah, 1
	ret

PS2notFound:

	xor ax,ax
	ret

Is_PS2  endp

CloseGateA20  proc near

	call Is_PS2
	cmp ah, 1
	jz EndCloseA20
	call CloseGateA20AT

EndCloseA20:

	ret

CloseGateA20  endp

OpenGateA20 proc near

	call Is_PS2
	cmp ah, 1
	jnz OpenA20AT
	cmp al, 1
	jz EndOpenA20
	mov al, 1
	call PS2_A20
	jmp short EndOpenA20

OpenA20AT:

	call OpenGateA20AT

EndOpenA20:

	ret

OpenGateA20 endp

OpenGateA20AT proc near

	call Sync8042
	jnz GateFailure
	mov al, Write_outpt
	out Status_Port, al
	call Sync8042
	jnz GateFailure
	mov al, EnableA20
	out Port_A, al
	call Sync8042
	jnz GateFailure
	mov al, 0ffh
	out Status_Port, al
	call Sync8042
	jnz GateFailure
	mov ax, 0
	ret

OpenGateA20AT  endp

CloseGateA20AT proc near

	call Sync8042
	jnz GateFailure
	mov al, Write_outpt
	out Status_Port, al
	call Sync8042
	jnz GateFailure
	mov al, DisableA20
	out Port_A, al
	call Sync8042
	jnz GateFailure
	mov al, 0ffh
	out Status_Port, al
	call Sync8042
	jnz GateFailure
	mov ax, 0
	ret

CloseGateA20AT endp

GateFailure proc near

	mov al, 1
	ret

GateFailure endp


Sync8042 proc near

	mov ecx, 30000h             ; N£mero de tentativas mais que
				    ; suficiente.

Syncloop:

	jmp short $ + 2
	in al, Status_Port
	and al, Cmd_rdy
	loopnz Syncloop
	ret

Sync8042 endp

_Is_DPMI proc near

	mov ax, 01687h
	int 2fh
	cmp ax, 0
	mov ax, 1
	jz IsDPMIEnd
	mov ax, 0

IsDPMIEnd:

	ret

_Is_DPMI endp

_Is_Himem proc near

	mov ax, 4300h
	int 2fh
	cmp al, 80h
	mov ax, 1
	jz IsHimemEnd
	mov ax, 0

IsHimemEnd:

	ret

_Is_Himem endp

_IsProtectedMode proc near

	smsw ax                 ; 'Velha' instru‡„o dos 286
				; que ‚ boa para este teste.
				; A alternativa ‚ mov eax, cr0 mas
				; embora n„o pare‡a pode causar
				; uma "General Protection Fault".
	and   ax, 1
	ret

_IsProtectedMode endp

; M‚todo cl ssico da Intel para detec‡„o de processadores.

_check386 proc near

	pushf
	xor ax,ax
	push ax
	popf
	pushf
	pop ax
	and ax,0f000h
	cmp ax,0f000h
	je nao_e_386
	mov ax,0f000h
	push ax
	popf
	pushf
	pop ax
	and ax,0f000h
	jnz e_386

nao_e_386:

	popf
	xor ax,ax
	jmp short endchk

e_386:

	popf
	mov ax,1

endchk:

	ret

_check386 endp

_OldDos proc near

	mov ah, 30h
	int 21h
	xchg ah, al
	mov _versiondos, ax
	cmp ax, 31eh
	mov ax, 0
	jae OldDosExit
	mov ax, 1

OldDosExit:

	ret

_OldDos endp

; Reprograma‡„o do PIC ('Programmable Interrupt Controller')
; Entrada com 'Interrupts' de 'Hardware' N¡vel 0 em BH
; e 'Interrupts' de 'Hardware' N¡vel 1 em BL

IntrSet proc near

	mov al, 11h     ; Fase de inicializa‡„o do chip 8259
	out 0a0h, al
	jmp short $ + 2 ; Pausa para dar tempo ao PIC
	jmp short $ + 2 ; e idem aspas por a¡ fora.
	out 20h, al
	jmp short $ + 2
	jmp short $ + 2
	mov al, bl      ; Nova base para IRQ8 - IRQ15
	out 0a1h, al
	jmp short $ + 2
	jmp short $ + 2
	mov al, bh      ; Nova base para IRQ0 - IRQ7
	out 21h, al
	jmp short $ + 2
	jmp short $ + 2
	mov al, 2       ; Fim de configura‡„o para SLAVE
	out 0a1h, al
	jmp short $ + 2
	jmp short $ + 2
	mov al, 4       ; Fim de configura‡„o para MASTER
	out 21h, al
	jmp short $ + 2
	jmp short $ + 2
	mov al, 1       ; Fim de configura‡„o do 8259A
	out 0a1h, al
	jmp short $ + 2
	jmp short $ + 2
	out 21h, al
	jmp short $ + 2
	jmp short $ + 2
	mov al, 0ffh    ; Todas as interrup‡”es desabilitadas por enquanto.
	out 0a1h, al
	jmp short $ + 2
	jmp short $ + 2
	out 21h, al
	ret

IntrSet endp

IsAnsi proc near

	mov ax, _DATA
	mov ds, ax

	mov ah, 0fh
	int 10h
	mov ah,3
	int 10h              ; Lˆ e Guarda a posi‡„o do cursor em CX.
	mov oldcurspos, dx
	mov dx, offset AnsiCode
	mov ah, 9           ; O Cursor n„o mover  se ANSI.SYS
			    ; estiver activo, pois [6n ‚ um c¢digo
			    ; cuja finalidade ‚ relatar ao sistema a
			    ; posi‡„o do cursor.
	int 21h

	mov ah, 6           ; Retira tecla Escape do Buffer do teclado.
	mov dl, 0ffh        ; Um teste preliminar.
	int 21h
	jz pre_saida
	cmp al, 1bh
	jnz pre_saida

check_virgula:

	mov ah, 6           ; Procura o primeiro digito da coluna actual,
	int 21h             ; o qual fica ap¢s a virgula.
	jz pre_saida
	cmp al,';'
	jnz check_virgula

	mov ah, 6           ; Primeiro digito da coluna actual.
	int 21h
	jz  pre_saida

	mov bh, al          ; Guarda em BH.
	mov ah, 6           ; Segundo d¡gito da coluna actual.
	int 21h
	jz pre_saida
	mov bl, al          ; Guarda em BL

	mov newcurspos,bx

	mov ax, oldcurspos
	xor ah, ah           ; S¢ interessa a coluna
	cbw
	inc ax               ; Este referencial ‚ de base 1 e n„o 0.
	cbw
	xor dx,dx
	mov cx, 100
	div cx
	aam
	or ax, '00'
	xchg ax, dx
	aam
	or ax, '00'

	push ax

	mov ax, 0c06h       ; Retira resto das teclas do Buffer.
	mov dl, 0ffh
	int 21h

	pop ax
	mov bx, newcurspos
	cmp ax, bx          ; Se os valores forem iguais ANSI.SYS foi
			    ; carregado em mem¢ria.
			    ; Seria contudo bem estranho chegarmos at‚
			    ; aqui sem que o ANSI.SYS tivesse sido
			    ; efectivamente carregado.
	jne pre_saida
	mov ax, 1           ; 1, se existe ANSI.SYS
	jmp saida

pre_saida:

	mov dx, offset Limpeza
	mov ah, 9
	int 21h
	sub ax, ax            ; 0, ANSI.SYS n„o carregado.

saida:

	ret

IsAnsi endp

_Is_Cache proc near

	push ds
	push es
	push si
	push di
	push bp
			    ; Qcache
	mov ax, 2700h
	mov bx, 0
	int 13h
	cmp bx, 0
	mov bx, 3
	jnz cacheinst
			    ; Pc-cache.sys
	mov ax, 0ffh
	mov si, 4358h
	int 25h
	pop ax                ; Necess rio
	cmp si, 6378h
	mov bx, 4
	jz cacheinst
			      ; Pc-Cache 6.0+
	mov ax, 0ffa5h
	mov cx, 1111h
	int 16h
	cmp ch, 0
	mov bx, 4
	jz cacheinst
			      ; Pc-cache 5.x
	mov ax, 2b00h
	mov cx, 4358h
	int 21h
	cmp al, 0
	mov bx, 4
	jz cacheinst
			      ; Hyperdisk
	mov ax, 0df00h
	mov bx, 4448h
	mov cx, 0
	mov dx, 0
	int 2fh
	cmp cx, 5948h
	mov bx, 2
	jz cacheinst
			      ; Smartdrive +4.2, ncache(v?), pc-cache v8
	mov ax, 04a10h
	mov bx, 0
	mov cx, 0ebabh
	int 2fh
	cmp ax, 0babeh
	mov bx, 1
	jz cacheinst
	mov ax, 0
	jmp short cachend

cacheinst:

	mov ax, bx

cachend:

	pop bp
	pop di
	pop si
	pop es
	pop ds
	ret

_Is_Cache endp

_fakemem proc near            ; Diminui‡„o da mem¢ria "extended" para o DOS.
			      ; O utilit rio MEM.EXE recorre aqui.
	push ds
	push es
	push si
	push di
	mov ax, _DATA
	mov ds, ax
	mov ax, _versiondos
	cmp ax, 400h
	jb fakemem_exit
	mov ax, 5200h         ; Servi‡o do DOS que permite saber onde fica
	int 21h               ; a famosa Lista das Listas.
	add bx, 45h           ; O endere‡o que nos interessa ‚ dado por ES:[BX+45h]
	mov ax, es:[bx]
	sub ax, 400h
	mov es:[bx], ax

fakemem_exit:

	pop di
	pop si
	pop es
	pop ds
	ret

_fakemem endp


_TEXT ends

end

