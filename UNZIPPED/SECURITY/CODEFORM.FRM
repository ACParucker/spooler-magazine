VERSION 2.00
Begin Form Codeform 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Inserir Códigos"
   ClientHeight    =   3720
   ClientLeft      =   1095
   ClientTop       =   1485
   ClientWidth     =   3255
   ControlBox      =   0   'False
   Height          =   4125
   Icon            =   CODEFORM.FRX:0000
   Left            =   1035
   LinkMode        =   1  'Source
   LinkTopic       =   "CodeForm"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3720
   ScaleWidth      =   3255
   Top             =   1140
   Width           =   3375
   Begin SSCommand Button3D 
      Caption         =   "&Modificar"
      Font3D          =   0  'None
      Height          =   700
      Left            =   1670
      Picture         =   CODEFORM.FRX:0302
      TabIndex        =   8
      Top             =   2920
      Width           =   1450
   End
   Begin CommandButton Button 
      BackColor       =   &H00C0C0C0&
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   700
      Index           =   1
      Left            =   1670
      TabIndex        =   7
      Top             =   2920
      Width           =   1450
   End
   Begin CommandButton Button 
      BackColor       =   &H00C0C0C0&
      Caption         =   "&Ok"
      Default         =   -1  'True
      Height          =   700
      Index           =   0
      Left            =   120
      TabIndex        =   6
      Top             =   2920
      Width           =   1450
   End
   Begin TextBox Text 
      BackColor       =   &H0000FFFF&
      Height          =   300
      Index           =   2
      Left            =   120
      MaxLength       =   12
      PasswordChar    =   "*"
      TabIndex        =   5
      Top             =   2220
      Width           =   3000
   End
   Begin TextBox Text 
      BackColor       =   &H0000FFFF&
      Height          =   300
      Index           =   1
      Left            =   120
      MaxLength       =   12
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1320
      Width           =   3000
   End
   Begin TextBox Text 
      BackColor       =   &H0000FFFF&
      Height          =   300
      Index           =   0
      Left            =   120
      MaxLength       =   16
      TabIndex        =   1
      Top             =   420
      Width           =   3000
   End
   Begin Label Label 
      BackColor       =   &H00C0C0C0&
      Caption         =   "&Digite Novamente:"
      Height          =   200
      Index           =   2
      Left            =   120
      TabIndex        =   4
      Top             =   1920
      Width           =   2500
   End
   Begin Label Label 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Código de &Acesso:"
      Height          =   200
      Index           =   1
      Left            =   120
      TabIndex        =   2
      Top             =   1020
      Width           =   2500
   End
   Begin Label Label 
      BackColor       =   &H00C0C0C0&
      Caption         =   "&Nome do Utilizador:"
      Height          =   200
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2500
   End
End

Sub Button_Click (Index As Integer)
  'Verificar qual a janela visivel
  Select Case Tag
    'Codeform1
    Case "1"
      'Verificar qual o botão pressionado
      Select Case Index
	'Ok
	Case 0
	  'Verificar se existem passwords
	  If Val(label(0).Tag) = False Then
	    codeform.Hide
	    Exit Sub
	  End If
	  'Verificar se o nome de utilizador existe
	  If Not userexist(Text(0).Text, num) Then
	    Beep
	    errado = errado + 1
	    If errado = 3 Then
	     End
	    End If
	    MsgBox "Código errado!", 48, screen.ActiveForm.Caption
	    Exit Sub
	  End If
	  'Verificar se a password corresponde ao utilizador
	  If Not password(Text(1).Text, num) Then
	    Beep
	    errado = errado + 1
	    If errado = 3 Then
	     End
	    End If
	    MsgBox "Código errado!", 48, screen.ActiveForm.Caption
	    Exit Sub
	  End If
	  'Esconde a janela
	  codeform.Hide
      End Select
    'Codeform2
    Case "2"
      'Verificar qual o botão pressionado
      Select Case Index
	'Ok
	Case 0
	  'Verifica se apassword principal está correcta
	  If Text(1).Text = Text(1).Tag Then
	    button(0).Tag = Str$(True)
	   Else
	    button(0).Tag = Str$(False)
	  End If
	  Text(1).Text = ""
	  'Esconde Janela
	  Me.Hide
	'Cancel
	Case 1
	  button(0).Tag = Str$(False)
	  Text(1).Text = ""
	  'Esconde Janela
	  Me.Hide
      End Select
    'Codeform3
    Case "3"
      'Verificar qual o botão pressionado
      Select Case Index
	'Cancel
	Case 1
	  Text(0).Text = ""
	  Text(1).Text = ""
	  Text(2).Text = ""
	  button(0).Tag = Str$(False)
	  'Esconde janela
	  Me.Hide
	'Ok
	Case 0
	  button(0).Tag = Str$(True)
	  'Esconde Janela
	  Me.Hide
      End Select
  End Select
End Sub

Sub Button3D_Click ()
  'Verificar se existem passwords
  If Val(label(0).Tag) = False Then
    showeditcodes1
    Exit Sub
  End If
  'Verificar se o utilizador existe
  If Not userexist(Text(0).Text, num) Then
    Beep
    MsgBox "Código errado!", 48, screen.ActiveForm.Caption
    Exit Sub
  End If
  'Verificar se a password está correcta
  If Not password(Text(1).Text, num) Then
    Beep
    MsgBox "Código errado!", 48, screen.ActiveForm.Caption
    Exit Sub
  End If
  Text(0).Text = ""
  Text(1).Text = ""
  'Ver qual utilizador
  If num = 0 Then
    'Principal
    showeditcodes1
   Else
    'Secundário
    showcodeform3 num
  End If
End Sub

Sub Form_LinkExecute (CmdStr As String, Cancel As Integer)
  'Sub utilizada para obter informações do programa
  'FINDPROG.EXE para remover este da memória
  cmdens$ = UCase$(CmdStr)
  If cmdens$ = "EXITPROG" Then
    Cancel = False
    'Remove programa da memória
    End
   Else
    Cancel = True
  End If
End Sub

Sub Text_GotFocus (Index As Integer)
  'Selecciona texto na textbox sempre que ganha o focus
  Text(Index).SelStart = 0
  Text(Index).SelLength = Len(Text(Index).Text)
End Sub

Sub Text_LostFocus (Index As Integer)
  'Tira Selecção
  Text(Index).SelStart = Len(Text(Index).Text)
  Text(Index).SelLength = 0
End Sub

