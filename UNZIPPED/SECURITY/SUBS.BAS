'Variavel com as passwords
Dim Shared pass(10, 1) As String
'Variavel com directorias importantes
Dim Shared pathname(1) As String
'Variavel com nº de utilizadores e outras informações
Dim Shared number(2) As Integer
'Criação da janela codeform2
Dim Shared codeform2 As New codeform
'Criação da janela codeform3
Dim Shared codeform3 As New codeform
'Declara variavel global
Global errado As Integer
'Declara função para obter a directoria do Windows
Declare Function GetWindowsDirectory Lib "Kernel" (ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
'Declara função para procurar se programa está a ser executado
Declare Function findwindow Lib "user" (ByVal class As Any, ByVal title As Any) As Integer
'Declara função para escrever em ficheiro .INI
Declare Function writeprivateprofilestring Lib "kernel" (ByVal section As String, ByVal entry As String, ByVal inpstr As String, ByVal file As String) As Integer

Sub adduser ()
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Adiciona Utilizador
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  Static passconvert(28, 1) As Integer
  If number(1) = False Then
    'Junta utilizador principal em memória
    pass(0, 0) = editcodes.Text(0).Text
    pass(0, 1) = editcodes.Text(1).Text
    number(1) = True
    editcodes.Label(1).Tag = Str$(number(1))
    codeform.Label(0).Tag = Str$(number(1))
    'Junta utilizador principal em ficheiro
    filenum1 = FreeFile
    Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
    a$ = "1"
    Put filenum1, 1, a$
    a$ = pass(0, 0) + String$(16 - Len(pass(0, 0)), " ") + pass(0, 1) + String$(12 - Len(pass(0, 1)), " ")
    For f = 1 To 28
      passconvert(f, 0) = Asc(Mid$(a$, f, 1)) - 16
    Next f
    For f = 1 To 27 Step 2
      passconvert(f, 1) = passconvert(29 - f, 0)
      passconvert(f + 1, 1) = passconvert(f, 0)
    Next f
    a$ = ""
    For f = 1 To 28
      a$ = a$ + Chr$(passconvert(f, 1))
    Next f
    Put filenum1, 3, a$
    Close filenum1
    'Junta Utilizador principal no ecrã
    editcodes.Combo.AddItem pass(0, 0) + " [PRINCIPAL]"
    editcodes.Combo.ItemData(editcodes.Combo.NewIndex) = 0
    editcodes.Combo.ListIndex = editcodes.Combo.NewIndex
    Exit Sub
  End If
  If userexist(editcodes.Text(0), num) Then
    Beep
    MsgBox "Nome de utilizador já existente!", 48, screen.ActiveForm.Caption
    Exit Sub
  End If
  If number(2) = 10 Then
    Beep
    MsgBox "Só pode haver 10 utilizadore secundários", 48, screen.ActiveForm.Caption
    Exit Sub
  End If
  'Junta utilizador na memória
  num = number(2) + 1
  pass(num, 0) = editcodes.Text(0).Text
  pass(num, 1) = editcodes.Text(1).Text
  number(2) = number(2) + 1
  editcodes.Label(2).Tag = Str$(number(2))
  codeform.Label(2).Tag = Str$(number(2))
  'Junta utilizador no ficheiro
  filenum1 = FreeFile
  Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
  a$ = Chr$(number(2) + 32)
  Put filenum1, 2, a$
  a$ = pass(num, 0) + String$(16 - Len(pass(num, 0)), " ") + pass(num, 1) + String$(12 - Len(pass(num, 1)), " ")
  For f = 1 To 28
    passconvert(f, 0) = Asc(Mid$(a$, f, 1)) - 16
  Next f
  For f = 1 To 27 Step 2
    passconvert(f, 1) = passconvert(29 - f, 0)
    passconvert(f + 1, 1) = passconvert(f, 0)
  Next f
  a$ = ""
  For f = 1 To 28
    a$ = a$ + Chr$(passconvert(f, 1))
  Next f
  Put filenum1, (num - 1) * 28 + 31, a$
  Close filenum1
  'Junta utilizador no ecrã
  editcodes.Combo.AddItem pass(num, 0)
  editcodes.Combo.ItemData(editcodes.Combo.NewIndex) = num
  editcodes.Combo.ListIndex = editcodes.Combo.NewIndex
End Sub

Sub centerform (x As Form)
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Centra Janelas no Ecrã
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  x.Left = (screen.Width - x.Width) / 2
  x.Top = (screen.Height - x.Height) / 2
End Sub

Sub changeuser (a)
  '''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Modifica nome e password do utilizador               '
  '''''''''''''''''''''''''''''''''''''''''''''''''''''''
  Static passconvert(28, 1) As Integer
  'Verifica se nome de utilizador já existe noutro utilizador
  If userexist(editcodes.Text(0).Text, num) And editcodes.Text(0).Text <> pass(a, 0) Then
    Beep
    MsgBox "Nome de utilizador já existente!", 48, screen.ActiveForm.Caption
    Exit Sub
  End If
  'Coloca nova password na memória
  pass(a, 0) = editcodes.Text(0).Text
  pass(a, 1) = editcodes.Text(1).Text
  'Encripta password
  e$ = pass(a, 0) + String$(16 - Len(pass(a, 0)), " ") + pass(a, 1) + String$(12 - Len(pass(a, 1)), " ")
  For f = 1 To 28
    passconvert(f, 0) = Asc(Mid$(e$, f, 1)) - 16
  Next f
  For f = 1 To 27 Step 2
    passconvert(f, 1) = passconvert(29 - f, 0)
    passconvert(f + 1, 1) = passconvert(f, 0)
  Next f
  e$ = ""
  For f = 1 To 28
    e$ = e$ + Chr$(passconvert(f, 1))
  Next f
  filenum1 = FreeFile
  'Coloca password no ficheiro
  Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
  If a = 0 Then
    Put filenum1, 3, e$
   Else
    Put filenum1, (a - 1) * 28 + 31, e$
  End If
  editcodes.Combo.Clear
  'Actualiza password na listagem
  fillcombo
End Sub

Sub disable (x As Control)
  'Desliga objectos
  x.Enabled = False
  x.TabStop = False
End Sub

Sub enable (x As Control)
  'Liga objectos
  x.Enabled = True
  x.TabStop = True
End Sub

Sub fillcombo ()
  'Actualiza combo box
  If number(1) = False Then Exit Sub
  editcodes.Combo.AddItem pass(0, 0) + " [PRINCIPAL]"
  editcodes.Combo.ItemData(editcodes.Combo.NewIndex) = 0
  editcodes.Combo.ListIndex = editcodes.Combo.NewIndex
  For f = 1 To number(2)
    editcodes.Combo.AddItem pass(f, 0)
    editcodes.Combo.ItemData(editcodes.Combo.NewIndex) = f
  Next f
  editcodes.Text(0).Text = pass(0, 0)
  editcodes.Text(1).Text = pass(0, 1)
  editcodes.Text(2).Text = pass(0, 1)
End Sub

Sub getlocal ()
  'Obtem a directoria do programa e activa help do programa
  pathname(0) = app.Path
  If Right$(pathname(0), 1) <> "\" Then pathname(0) = pathname(0) + "\"
  a$ = String$(128, " ")
  filen = FreeFile
  app.HelpFile = pathname(0) & "secur.hlp"
  'Obtém directoria do Windows
  windir$ = String$(144, 0)
  x = GetWindowsDirectory(windir$, 144)
  windir$ = Left$(windir$, x)
  If Right$(windir$, 1) <> "\" Then
    windir$ = windir$ + "\"
  End If
  pathname(1) = windir$
End Sub

Sub getpass ()
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Obtem Passwords do ficheiro e modulos de acesso
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  Static passconvert(28, 1) As Integer
  'Abrir Ficheiro de informações
  filenum1 = FreeFile
  Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
  'Passwords
  a$ = " "
  Get filenum1, 1, a$
  If a$ = "0" Then
    number(1) = False
    GoTo fim1
   Else
    number(1) = True
  End If
  a$ = " "
  Get filenum1, 2, a$
  number(2) = Asc(a$) - 32
  'Obter Utilizador Principal
  a$ = String$(28, " ")
  Get filenum1, 3, a$
  For f = 1 To 28
    passconvert(f, 0) = Asc(Mid$(a$, f, 1)) + 16
  Next f
  For f = 1 To 27 Step 2
    passconvert(29 - f, 1) = passconvert(f, 0)
    passconvert(f, 1) = passconvert(f + 1, 0)
  Next f
  a$ = ""
  For f = 1 To 28
    a$ = a$ + Chr$(passconvert(f, 1))
  Next f
  pass(0, 0) = outspaces(Left$(a$, 16))
  pass(0, 1) = outspaces(Right$(a$, 12))
  If number(2) = 0 Then GoTo fim1
  'Obter Utilizadores Secundários
  For f = 1 To number(2)
    a$ = String$(28, " ")
    Get filenum1, (f - 1) * 28 + 31, a$
    For n = 1 To 28
      passconvert(n, 0) = Asc(Mid$(a$, n, 1)) + 16
    Next n
    For n = 1 To 27 Step 2
      passconvert(29 - n, 1) = passconvert(n, 0)
      passconvert(n, 1) = passconvert(n + 1, 0)
    Next n
    a$ = ""
    For n = 1 To 28
      a$ = a$ + Chr$(passconvert(n, 1))
    Next n
    pass(f, 0) = outspaces(Left$(a$, 16))
    pass(f, 1) = outspaces(Right$(a$, 12))
  Next f
fim1:
  Close filenum1
End Sub

Sub hidecontrol (x As Control)
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Esconde control
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  x.Enabled = False
  x.Visible = False
  If TypeOf x Is Label Then Exit Sub Else x.TabStop = False
End Sub

Sub main ()
  'Obtém directorias importantes
  getlocal
  'Obtém passwords e remove encriptação
  getpass
  'mostra janela para pedido de password
  showcodeform1
  'procura se o Program Manager está a ser executado
  x = findwindow("progman", 0&)
  If x = 0 Then
    'Não, Executa Program Manager
    t = writeprivateprofilestring("boot", "shell", "progman.exe", pathname(1) & "system.ini")
    s = Shell(pathname(1) & "progman.exe", 1)
   Else
    'Sim, Termina programa
    End
  End If
ciclo:
  DoEvents
  GoTo ciclo
End Sub

Function outspaces (ByVal a$)
  'Rotina utilizada para remover os espaços extras
  'numa String
  'ATENÇÃO
  '     Depois de concluir este programa descobri
  'a existencia de comandos já incorporados no Visual Basic
  'que executam a mesma tarefa:RTrim$;LTrim$;Trim$
  For f = Len(a$) To 1 Step -1
    If Mid$(a$, f, 1) = " " Then
      a$ = Left$(a$, Len(a$) - 1)
     Else
      Exit For
    End If
  Next f
  outspaces = a$
End Function

Function password (ByVal a$, b)
  'Verifica se a password a$ pertence ao utilizador b
  password = False
  If a$ = pass(b, 1) Then password = True
End Function

Sub removeuser (a)
  '''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Remove utilizador                                    '
  '''''''''''''''''''''''''''''''''''''''''''''''''''''''
  b = MsgBox("Têm a certeza que quer excluir utilizador " & pass(a, 0) & "?", 36, screen.ActiveForm.Caption)
  If b = 7 Then Exit Sub
  If a = 0 Then
    'Remover da memória
    pass(0, 0) = ""
    pass(0, 1) = ""
    number(1) = False
    editcodes.Label(1).Tag = Str$(number(1))
    codeform.Label(0).Tag = Str$(number(1))
    'Remover do ficheiro
    filenum1 = FreeFile
    Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
    d$ = "0"
    Put filenum1, 1, d$
    d$ = String$(28, Chr$(Asc(" ") + 16))
    Put filenum1, 3, d$
    'Remover do ecrã
    editcodes.Combo.Clear
    Exit Sub
  End If
  'Remover da memória
  For f = a + 1 To number(2)
    pass(f - 1, 0) = pass(f, 0)
    pass(f - 1, 1) = pass(f, 1)
  Next f
  pass(number(2), 0) = ""
  pass(number(2), 0) = ""
  number(2) = number(2) - 1
  codeform.Label(1).Tag = Str$(number(2))
  editcodes.Label(2).Tag = Str$(number(2))
  'Remover do ficheiro
  filenum1 = FreeFile
  Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
  d$ = Chr$(number(2) + 32)
  Put filenum1, 2, d$
  For f = a + 1 To number(2) + 1
    d$ = String$(28, " ")
    Get filenum1, (f - 1) * 28 + 31, d$
    Put filenum1, (f - 2) * 28 + 31, d$
  Next f
  d$ = String$(28, Chr$(Asc(" ") + 16))
  Put filenum1, number(2) * 28 + 31, d$
  number(0) = 0
  Close filenum1
  'Remover do ecrã
  editcodes.Combo.Clear
  fillcombo
End Sub

Sub showcodeform1 ()
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Mostra janela para pedir código de entrada
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  Load codeform
  codeform.HelpContextID = 1
  hidecontrol codeform.Label(2)
  hidecontrol codeform.Text(2)
  hidecontrol codeform.Button(1)
  codeform.Button(0).Top = 2020
  codeform.Button3D.Top = 2020
  codeform.Height = 3225
  centerform codeform
  codeform.Label(0).Tag = Str$(number(1))
  codeform.Tag = "1"
  codeform.Label(1).Tag = Str$(number(2))
  codeform.Show 1
End Sub

Function showcodeform2 ()
  'Mostra janela para verificar se quem tem o controle
  'ainda é o utilizador Secundário
  Load codeform2
  codeform2.HelpContextID = 3
  hidecontrol codeform2.Label(0)
  hidecontrol codeform2.Label(2)
  hidecontrol codeform2.Text(0)
  hidecontrol codeform2.Text(2)
  codeform2.Text(1).Top = 420
  codeform2.Label(1).Top = 120
  codeform2.Button(0).Top = 1120
  hidecontrol codeform2.Button3D
  codeform2.Button(1).Top = 1120
  codeform2.Height = 2325
  codeform2.Text(1).Tag = pass(0, 1)
  centerform codeform2
  codeform2.Tag = "2"
  codeform2.Show 1
  showcodeform2 = Val(codeform2.Button(0).Tag)
  Unload codeform2
End Function

Sub showcodeform3 (c)
  'Mostra janela para modificar passwords
  'a nivel secundário
ciclo1:
  Load codeform3
  codeform3.HelpContextID = 2
  Static passconvert(28, 1) As Integer
  hidecontrol codeform3.Button3D
  codeform3.Button(0).Tag = Str$(False)
  centerform codeform3
  codeform3.Tag = "3"
  codeform3.Show 1
  b$ = codeform3.Button(0).Tag
  t0$ = codeform3.Text(0).Text
  t1$ = codeform3.Text(1).Text
  t2$ = codeform3.Text(2).Text
  Unload codeform3
  If Val(b$) = False Then
    Exit Sub
  End If
  If userexist(t0$, num) And t0$ <> pass(c, 0) Then
    Beep
    MsgBox "Utilizador já existente!", 48, screen.ActiveForm.Caption
    GoTo ciclo1
  End If
  If t1$ <> t2$ Then
    Beep
    MsgBox "Digite o código corretamente!", 48, screen.ActiveForm.Caption
    GoTo ciclo1
  End If
  pass(c, 0) = t0$
  pass(c, 1) = t1$
  e$ = pass(c, 0) + String$(16 - Len(pass(c, 0)), " ") + pass(c, 1) + String$(12 - Len(pass(c, 1)), " ")
  For f = 1 To 28
    passconvert(f, 0) = Asc(Mid$(e$, f, 1)) - 16
  Next f
  For f = 1 To 27 Step 2
    passconvert(f, 1) = passconvert(29 - f, 0)
    passconvert(f + 1, 1) = passconvert(f, 0)
  Next f
  e$ = ""
  For f = 1 To 28
    e$ = e$ + Chr$(passconvert(f, 1))
  Next f
  filenum1 = FreeFile
  Open pathname(0) + "NTAINFO.INI" For Binary As filenum1
  If c = 0 Then
    Put filenum1, 3, e$
   Else
    Put filenum1, (c - 1) * 28 + 31, e$
  End If
End Sub

Sub showcontrol (x As Control)
  'Mostra Control Invisivel
  x.Enabled = True
  x.TabStop = True
  x.Visible = True
End Sub

Sub showeditcodes1 ()
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  'Carrega form para Mudar todos os Códigos
  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  Load editcodes
  editcodes.HelpContextID = 4
  editcodes.Tag = "1"
  editcodes.Label(1).Tag = codeform.Label(0).Tag
  editcodes.Label(2).Tag = codeform.Label(1).Tag
  editcodes.Label(0).Caption = "&Utilizadores:"
  centerform editcodes
  editcodes.Show 1
  Unload editcodes
End Sub

Sub updatepass ()
  'Actualiza password nas caixas de texto
  a = editcodes.Combo.ItemData(editcodes.Combo.ListIndex)
  editcodes.Text(0).Text = pass(a, 0)
  editcodes.Text(1).Text = pass(a, 1)
  editcodes.Text(2).Text = pass(a, 1)
End Sub

Function userexist (ByVal a$, b)
  'Verifica se o utilizador a$ existe
  'Retorna o nº do utilizador se existir na variavel b
  b = -1
  For f = 0 To number(2)
    If pass(f, 0) = a$ Then b = f
  Next f
  If b = -1 Then userexist = False Else userexist = True
End Function

