'Funçaõ para detectar se o Security Program está na memória
Declare Function findwindow% Lib "user" (ByVal lpclassname As Any, ByVal lpcaption As Any)
'Função para sair do Windows no caso de haver batota
Declare Function ExitWindows Lib "user" (ByVal value As Long, ByVal notused As Long) As Integer
Declare Function writeprivateprofilestring Lib "kernel" (ByVal section As String, ByVal entry As String, ByVal inpstr As String, ByVal file As String) As Integer
Declare Function getwindowsdirectory Lib "kernel" (ByVal windir As String, ByVal lenbuffer As Integer) As Integer

Sub main ()
  Static valor As Long
'Procurar Security Program
  lpcaption$ = "Secur"
  a = findwindow%(0&, lpcaption$)
'Se não achou sai do Windows
  If a = 0 Then
    valor = &H43 * &HFFFF
    x = ExitWindows(valor, 0)
  End If
'No caso de o ter achado mandar mensagem para
'Removê-lo da memória
  Load DDEForm
  DDEForm.DDELabel.LinkMode = 2
  DDEForm.DDELabel.LinkExecute "EXITPROG"
  DDEForm.DDELabel.LinkMode = 0
  Unload DDEForm
  c$ = app.Path
  If Right$(c$, 1) <> "\" Then c$ = c$ & "\"
  b$ = String$(144, 0)
  x = getwindowsdirectory(b$, 144)
  b$ = Left$(b$, x)
  If Right$(b$, 1) <> "\" Then b$ = b$ & "\"
  x = writeprivateprofilestring("boot", "shell", c$ & "secur.exe", b$ & "system.ini")
End Sub

