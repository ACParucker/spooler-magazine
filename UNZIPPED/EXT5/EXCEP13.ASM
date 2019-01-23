; Testes
; Instru‡„o Assembly HLT provoca Exception 13 em Modo Virtual 86

.386P

data segment use16
msg db "O programa Virt86.exe n„o est  instalado !",13,10,"$"
oldintfdoff dw 0
oldintfdseg dw 0
data ends

code segment para public use16

assume cs:code, ds:data, ss:pilha
start:

          mov ax, data
          mov ds, ax

          mov ax, 35fdh
          int 21h
          mov oldintfdoff, bx
          mov ax, es
          mov oldintfdseg, ax
          mov dx, offset novirt86exe
          push ds
          mov ax, cs
          mov ds, ax
          mov ax,25fdh
          int 21h
          pop ds

          mov eax, 88ff88ffh            ; Vericador de instala‡„o do Virt86.exe
          int 0fdh
          cmp eax, "V86"                ; Em principio esta instru‡„o s¢ ser 
                                        ; executada se o Virt86.exe estiver
                                        ; instalado. E na presente vers„o
                                        ; a igualdade verifica-se sempre, pelo
          jnz novirt86exe               ; que o teste 'jnz' ‚ redundante.

          hlt                           ; Instru‡„o Privilegiada->Exception 13.
                                        ; Nota: Alguns gestores de mem¢ria como
                                        ; o QEMM386.SYS optam por tratar esta
                                        ; instru‡„o como NOP recuperando
                                        ; imediatamente da Exception 13 sem
                                        ; quaisquer alardes.
novirt86exe:
          mov dx, offset data
          mov ah,9
          int 21h
          mov dx, oldintfdoff
          mov ax, oldintfdseg
          mov ds, ax
          mov ax, 25fdh
          int 21h
          mov ah, 4ch
          int 21h
code ends
pilha segment para stack
dw 128 dup (0)
pilha ends
end start

