��+ �  H   SysFuel& � Fuel do sistema��� �  6  �  j   B #�             �     (       @         �                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                    �������p       �������p       x������pp      ������wp      x������wp      ������wp      x������wp      x������wp      x������wp      x������wp      x������wp      �wwwww�wp      �������wp              p      ���������p      ��������       x��������    x����������    x�������� �� �� x�������� �� � x���������  � x����������  � x���������     x���������     x���������  �� x��������;     wwwwwwww�    � ��������p      ��������w   ��  ��������                   � ��  �  �  0�  <�  <�  9�  1�  3�  #�  '�  '�  '�  '�  '�  '�  '�  �  �  �  �  �  �  �  �  �  �  �  �  �  �� ?$Form1�.  � Picture2 ����   ���   B $ �.  �  Picture2 ����       �K   B $ �    Frame3���� <   � �&   Sobre� 
&Sobre ...���� �3   
cmdActualizar� &Actualizar j�!x ��� �8   Frame1� Resources livres:���  �� x x #
) �p  Picture1 ���� B  BMB      v   (   4   5                                   �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ��������������������������  ���������������������������w���������������������������̈������������������������� ��������������������������  ��������������������������  ��������������������������3���������������������������������������wwwww����������  �����������wwwww�x��������  �����������wwwwwxx��������  �����������wwwww�x��������  �����������wwwww�x���������w�����������wwwww�x���������̈����������wwwww�x��������  �����������wwwwww���������  �����������wwwwwx���������  �����������w���wx���������3�����������w���w�����������������������w���w����������  �����������wwwww����������  ������������wwwx����������  ����������������  ��������������������������w���������������̈������������ �����������  �����x������������  ��������������������������  �����x������������3�������������������������������x�������������  �������������������������  ����xx�������������  ��������������������������  ����xx����������������w��������������������������̈��x���������������  �������������������������  ���x�����������������  ��������������������������3���xx�������������������������������������������  ��xxx�������������xx�  �������������������������  ��xxx�x����xx�xxx�  ���������������������������w�� xxxxx�xx�xx�xxxxxp ��̈��� ����������������� ��  ����� xxxxxxxxxxxp ����  ������� ���������� �����  ���������  xxxxx  �������3�����������     ��������������������������������������  < ,�  b $ �'   Line1��   �  �   �  �  �,   Total� 100%��� ��  T� ��  ��+   User� 100%��� ��  T���  ��*   GDI� 100%��� ��  T���  ��7  �  lblResource� Total:  ���  �� 8� :� 
 �5  � lblResource� GDI: ���  �� 8��� 	 �6  � lblResource� User: ���  �� 8��  �/   	Mem� 	6000.0 Kb��� ��  ((u�  ��?  � lblResource� Mem�ria livre: ���  �� x (��  �.   Frame2� Op��es:���  �� < �7  �   Text1�< �g;5 �8   Check1� &Sempre no topo��� ��  x ,c�  �N  � lblResource� &Periodo de actualiza��o (s): ���  �� < �`	�  �   Timer1��  h    �+   	OkPeriodo� 	OkPeriodod�G; ��  �  PP	 
����/   8� g � �!S�y@5!Z H� m�u 6)	�� Wo�� ���                  /  �  	Form_Load+ 
Form_Click�  UserRequest�  Image1_Click�  Gauge1_Change Gauge1_Click  Timer1_Timer� Gauge1�  Value 	ForeColor� Qbcollor� GaugeE Valure` Gauge2� form2� Label1, Caption� Timer1� STATITi I� Picture1_Click� form1( line1~ X1� Height� Picture1� WidthW FormTitleHeight` Form_Resize MaxRessources� hWndG Property� Example the7 forces� a� form� always1 remainO top� try2 This� create? an� MDI� child� its_ give menuu 
containing� itemX named� Make? sure� 	statementz all� oneO Paste� code� into� Declarations= section ofF press� F5�
 requires� 	Microsoft� WindowsG version�	 SetWindowPosB h1M h2� X Yj cx cy fh HWND_TOPMOST1 HWND_NOTOPMOST} SWP_NOACTIVATE� SWP_SHOWWINDOW mnuTopmost_Click 
mnuTopMost� CheckedO Declarefunctions S� hWndInsertAfter" fuFlages� flags� Fuelhwndb SysFuelY lhwnd� wFlags� WindowTopMost4	 OnTop� Status� Dim� Handley Ifnot   sempre� no�	 topoX desta� janela GetWindowPlacement	 lpwndpl� WindowPlacementF SetWindowPlacement   length+ showCmd ptMinPosition? POINTAPI� ptMaxPosition.
 rcNormalPosition� RECT� left� right& bottom� SaveWindowPlacement� WindowHandleO 
FileHandle Place� Form_Unload� Cancel   Nd SaveWindowPlace�	 LoadWindowPlace 
Fuel_ClickN	 Picture1_DblClick� Picture1_DragDropN Source� Controlx Picture1_DragOver: State� Picture1_GotFocus� Picture1_KeyDown� KeyCode�
 Shift" Picture1_KeyPress� KeyAsciin Picture1_KeyUpX Picture1_LinkClosec
 Picture1_LinkError LinkErr�	 Picture1_LinkNotify8 Picture1_LinkOpen�	 Picture1_LostFocus�
 Picture1_MouseDown� Button� Picture1_MouseMove	 Picture1_MouseUp� Picture1_Paint� Picture1_Resize Form_LinkOpen� Form_LinkExecuteo CmdStro Form_LinkError) Form_LinkClose^ 
Form_KeyUp� Form_KeyPress� Form_KeyDownK Form_Activate?
 Form_DblClick� Form_Deactivate� Form_DragDrop�	 Form_DragOver� Form_GotFocus
 Form_LostFocus�	 Form_MouseDown   Form_MouseMove	 Form_MouseUp   
Form_Paint�
 Form_QueryUnload   
UnloadMode�	 
ConfigFile�	 SysRes' GDIRes3 UserRes   GetFreeSystemResourcesf	 GFSR_SYSTEMRESOURCES{	 GFSR_GDIRESOURCES�
 GFSR_USERRESOURCES   FreeMem�
 GetFreeSpaceL GDI
 User[
 Memy Kb�
 WindowState
 	Minimized�	 Label1_Click   Label3_ClickR
 Check1_Click   Check1   Text1_Change Text1_KeyDowno
 Text1_LostFocus   Text1�
 Text   Interval�
 Text1_KeyPress� OkPeriodo_Click� Total   Timer1_   
WindowSate� Normal   SysFuelCaption Command1_Click   cmdActualizar_Click   Picture2_Click   Index   um� inteirob positivoX inferior   	GetCfgInt� FileName� Succes� 	GetCfgStr� sizeof   SizeOfS   cmdActualizar   Sucess 	PutCfgStr� SobreSysFuel   Total_Click   
User_Click   	Mem_Click& SysFule   Heig   	GDI_Click   Load About   Sobre_Click   Timer      ;	  ��������    About0�      X      �       X  �   y � > � �y
  �  �  J  Op��es  � 
 `  Nome  �  t      � y 	  b X  ���(� �  � 
 JorgeLopes  � I    �e    x  8   9 	  ��������
     Check1_Click0�      X  
      � 
 �   5� � I �  � ( > # N�o consegui alterar a situa��o de  � " � � �  r  sempre no topo  � � " � � �  �   desta janela � � & 8   9 	  ��������     cmdActualizar_Click0       X  �
    $   �   9 	  ��������    	 Form_Load0
     X  Z      � J � � ,     X  �   y � J � �y
  �     � 	  �� � I �   � 0 ~ * N�o consegui recolocar a posi��o da janela  � & 8    �,  5� � I N � ( � # N�o consegui alterar a situa��o de  � " � � �   sempre no topo  � � " � � �  2  desta janela � � & 8   �  Z Op��es  �  p NoTopo  � 	  ? 
 �  �  � Op��es  �  � PeriodoActualiza��o �  � 5  � y 	  b X  � R
 [
 $   ?
  ye    x   e    x  $     9  D	  ��������     Form_Resize0�      X  �     �  �
 $   �    �	 �
� I �    �
  !    �� ��   o� �� � I �  0� �  � 0� �  o  8  8    9 	  ��������     Form_Unload0�     X  �  � �    � 2   
  @     �    � 	  �� � I �   � . f ( N�o consegui guardar a posi��o da janela  � & 8    R
 [
�  @  @� �  @�  @� �  @� A � � I v  , sita��es: 2.23  ou -9 ou 0  �   5  R
 [
 8    �    Op��es  �  6 NoTopo   
 � �  	  � � �  � Op��es  �  � PeriodoActualiza��o  R
 [
 	  � �  $       9 	  ��������     OkPeriodo_Click0       X  �
    $   ?
  9 	  ��������     Sobre_Click 0(      X       �e    x   9 	  ��������     Text1_LostFocus0     X  ?
    �     
  @  R
 [
�  @  @� �  @�  @� �  @� A � � I �   � ( f " O periodo de actualiza��o deve ser  �  � � � * � % um n� inteiro positivo, inferior a 65 � � 0 & 2    @� � ��  , c
  $   �
   ye    x  8   9 	  ��������     Timer1_Timer0,     X  �      � �	 � H     	  "  	  6  )	  J  �	   N	  4	 	  f	  4	 	  {	  4	 )	 �   �	 �	    �	 �	� I X  �  �  Total=   	� � �  �  %, GDI= �  	� � �  �  %, User=  �  )	� � �   %, Mem= �  �	�  � �  0 0.0 � �  @ Kb  �   ! 2 X  v .  de maximo a m�nimo, x1 varia de 630, at� 195  � v� d  	� � � ffffff@� �  ` i   	� �  �  %  �  �
 !   	� �  �  %  �  �	 !   )	� �    %  �  �	 !   �	�  � �  2 0.0 �  @  Kb �  �	 ! @ 8    9 	  ��������   �