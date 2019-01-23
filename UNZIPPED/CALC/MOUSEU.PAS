  Unit MouseU;

    Interface

      Uses Crt,vars,DOS,VIDEO2,Binu;

      const Posicao = 1;
            PressLeftButton = 2;
            ReleaseLeftButton = 4;
            PressRightButton = 8;
            ReleaseRightButton = 16;
      Type
        GraphCursMaskType = Record
                              Mask : Array[0..1,0..15] of word;
                              HorzHotSpot,
                              VertHotSpot : Integer;
                            end;
      Var
        StandardShapeCurs,
        UpArrowCurs,
        LeftArrowCurs,
        CheckMarkCurs,
        PointingHandCurs,
        DiagonalCrossCurs,
        RectangularCrossCurs,
        HourGlassCurs : GraphCursMaskType;
				MouseX,
				MouseY,
				ButtonPressCount,
				ButtonReleaseCount,
				TextScrMask,
				TextCursMask : word;

        Xm,Ym        : Word;

        NumMouseKeys : Byte;

        MousePresent : Boolean;

        MKey : (None,Left,Right,Both);

      Procedure ResetMouse;
      Procedure VirtualScreenSize( Var MaxX,
                                       MaxY,
                                       CellSizeX,
                                       CellSizeY  : Word);
      Procedure MostraRato;
      Procedure EscondeRato;
      Procedure GetButtonStatus;
      Procedure ColocaRatoXY( x,y : Word );
      Procedure GetButtonPressInfo( KeyNum : Word);
      Procedure GetButtonReleaseInfo( KeyNum : Word );
      Procedure SetMinMaxHorzCursPos( Min,Max : Word);
      Procedure SetMinMaxVertCursPos( Min,Max : word);
      Procedure SetGraphicsCursor( Var Mask : GraphCursMaskType );
      Procedure SetSoftTextCursor( TextScrMask,
                                   TextCursMask : word );
      Procedure SetHardTextCursorbig;
      Procedure SetHardTextCursorSmall;
      Procedure ReadMouseMotionCounters( Var Hcount,
                                             Vcount : integer);
      Procedure LightPenEmulOn;
      Procedure LightPenEmulOff;
      Procedure SetMickeyTopixels( HRatio, VRatio : Word);
      Procedure ConditionalOff( x1,y1,x2,y2 : Word);
      Procedure SetDoubleSpeed( Speed : Word );
      Procedure SaveMouseDriverState;
      Procedure RestoreMouseDriverState;
      Procedure SetCrtPageNumber( Page : Word );
      Procedure GetCrtPageNumber(Var Page : Word);
      Function  AnyRato : Boolean;
      Function  EsqRato : Boolean;
      Function  DirRato : Boolean;
      Function  BothRato : Boolean;
      Procedure DefineEventHandler(Mask : Word;Pt : Pointer);

    Implementation

      const
        MouseDelay = 250;
      Var
        MouseSaveBuffer : Pointer;
        MKP,
        MouseVisible : Boolean;
        MouseBufferSize : Word;
        Regs : Registers;

      Procedure DefineStandardShape;
        begin
          with StandardShapeCurs do
            begin
              Mask[0,0]   := BinToWord('0011111111111111');
              Mask[0,1]   := BinToWord('0001111111111111');
              Mask[0,2]   := BinToWord('0000111111111111');
              Mask[0,3]   := BinToWord('0000011111111111');
              Mask[0,4]   := BinToWord('0000001111111111');
              Mask[0,5]   := BinToWord('0000000111111111');
              Mask[0,6]   := BinToWord('0000000011111111');
              Mask[0,7]   := BinToWord('0000000001111111');
              Mask[0,8]   := BinToWord('0000000000111111');
              Mask[0,9]   := BinToWord('0000000000011111');
              Mask[0,10]  := BinToWord('0000000111111111');
              Mask[0,11]  := BinToWord('0001000011111111');
              Mask[0,12]  := BinToWord('0011000011111111');
              Mask[0,13]  := BinToWord('1111100001111111');
              Mask[0,14]  := BinToWord('1111100001111111');
              Mask[0,15]  := BinToWord('1111110000111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0100000000000000');
              Mask[1,2]   := BinToWord('0110000000000000');
              Mask[1,3]   := BinToWord('0111000000000000');
              Mask[1,4]   := BinToWord('0111100000000000');
              Mask[1,5]   := BinToWord('0111110000000000');
              Mask[1,6]   := BinToWord('0111111000000000');
              Mask[1,7]   := BinToWord('0111111100000000');
              Mask[1,8]   := BinToWord('0111111110000000');
              Mask[1,9]   := BinToWord('0111111111000000');
              Mask[1,10]  := BinToWord('0111110000000000');
              Mask[1,11]  := BinToWord('0100011000000000');
              Mask[1,12]  := BinToWord('0000011000000000');
              Mask[1,13]  := BinToWord('0000001100000000');
              Mask[1,14]  := BinToWord('0000001100000000');
              Mask[1,15]  := BinToWord('0000000110000000');

              HorzHotSpot := -1;
              VertHotSpot := -1;
            end;
        end;

      Procedure DefineUpArrow;
        Begin
          With UpArrowCurs Do
            begin
              Mask[0,0]   := BinToWord('1111100111111111');
              Mask[0,1]   := BinToWord('1111000011111111');
              Mask[0,2]   := BinToWord('1110000001111111');
              Mask[0,3]   := BinToWord('1110000001111111');
              Mask[0,4]   := BinToWord('1100000000111111');
              Mask[0,5]   := BinToWord('1100000000111111');
              Mask[0,6]   := BinToWord('1000000000011111');
              Mask[0,7]   := BinToWord('1000000000011111');
              Mask[0,8]   := BinToWord('0000000000001111');
              Mask[0,9]   := BinToWord('0000000000001111');
              Mask[0,10]  := BinToWord('1111000011111111');
              Mask[0,11]  := BinToWord('1111000011111111');
              Mask[0,12]  := BinToWord('1111000011111111');
              Mask[0,13]  := BinToWord('1111000011111111');
              Mask[0,14]  := BinToWord('1111000011111111');
              Mask[0,15]  := BinToWord('1111000011111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0000011000000000');
              Mask[1,2]   := BinToWord('0000111100000000');
              Mask[1,3]   := BinToWord('0000111100000000');
              Mask[1,4]   := BinToWord('0001111110000000');
              Mask[1,5]   := BinToWord('0001111110000000');
              Mask[1,6]   := BinToWord('0011111111000000');
              Mask[1,7]   := BinToWord('0011111111000000');
              Mask[1,8]   := BinToWord('0111111111100000');
              Mask[1,9]   := BinToWord('0111111111100000');
              Mask[1,10]  := BinToWord('0000011000000000');
              Mask[1,11]  := BinToWord('0000011000000000');
              Mask[1,12]  := BinToWord('0000011000000000');
              Mask[1,13]  := BinToWord('0000011000000000');
              Mask[1,14]  := BinToWord('0000011000000000');
              Mask[1,15]  := BinToWord('0000000000000000');

              HorzHotSpot := 5;
              VertHotSpot := 0;

            end;
        end;

      Procedure DefineLeftArrow;
        Begin
          With LeftArrowCurs do
            begin
              Mask[0,0]   := BinToWord('1111111000011111');
              Mask[0,1]   := BinToWord('1111000000011111');
              Mask[0,2]   := BinToWord('0000000000000000');
              Mask[0,3]   := BinToWord('0000000000000000');
              Mask[0,4]   := BinToWord('0000000000000000');
              Mask[0,5]   := BinToWord('1111000000011111');
              Mask[0,6]   := BinToWord('1111111000011111');
              Mask[0,7]   := BinToWord('1111111111111111');
              Mask[0,8]   := BinToWord('1111111111111111');
              Mask[0,9]   := BinToWord('1111111111111111');
              Mask[0,10]  := BinToWord('1111111111111111');
              Mask[0,11]  := BinToWord('1111111111111111');
              Mask[0,12]  := BinToWord('1111111111111111');
              Mask[0,13]  := BinToWord('1111111111111111');
              Mask[0,14]  := BinToWord('1111111111111111');
              Mask[0,15]  := BinToWord('1111111111111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0000000011000000');
              Mask[1,2]   := BinToWord('0000011111000000');
              Mask[1,3]   := BinToWord('0111111111111110');
              Mask[1,4]   := BinToWord('0000011111000000');
              Mask[1,5]   := BinToWord('0000000011000000');
              Mask[1,6]   := BinToWord('0000000000000000');
              Mask[1,7]   := BinToWord('0000000000000000');
              Mask[1,8]   := BinToWord('0000000000000000');
              Mask[1,9]   := BinToWord('0000000000000000');
              Mask[1,10]  := BinToWord('0000000000000000');
              Mask[1,11]  := BinToWord('0000000000000000');
              Mask[1,12]  := BinToWord('0000000000000000');
              Mask[1,13]  := BinToWord('0000000000000000');
              Mask[1,14]  := BinToWord('0000000000000000');
              Mask[1,15]  := BinToWord('0000000000000000');

              HorzHotSpot := 0;
              VertHotSpot := 3;
            end;
        end;

      Procedure DefineCheckMark;
        begin
          With CheckMarkCurs do
            begin
              Mask[0,0]   := BinToWord('1111111111110000');
              Mask[0,1]   := BinToWord('1111111111100000');
              Mask[0,2]   := BinToWord('1111111111000000');
              Mask[0,3]   := BinToWord('1111111110000001');
              Mask[0,4]   := BinToWord('1111111100000011');
              Mask[0,5]   := BinToWord('0000011000000111');
              Mask[0,6]   := BinToWord('0000000000001111');
              Mask[0,7]   := BinToWord('0000000000011111');
              Mask[0,8]   := BinToWord('1100000000111111');
              Mask[0,9]   := BinToWord('1111000001111111');
              Mask[0,10]  := BinToWord('1111111111111111');
              Mask[0,11]  := BinToWord('1111111111111111');
              Mask[0,12]  := BinToWord('1111111111111111');
              Mask[0,13]  := BinToWord('1111111111111111');
              Mask[0,14]  := BinToWord('1111111111111111');
              Mask[0,15]  := BinToWord('1111111111111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0000000000000110');
              Mask[1,2]   := BinToWord('0000000000001100');
              Mask[1,3]   := BinToWord('0000000000011000');
              Mask[1,4]   := BinToWord('0000000000110000');
              Mask[1,5]   := BinToWord('0000000001100000');
              Mask[1,6]   := BinToWord('0111000011000000');
              Mask[1,7]   := BinToWord('0001110110000000');
              Mask[1,8]   := BinToWord('0000011100000000');
              Mask[1,9]   := BinToWord('0000000000000000');
              Mask[1,10]  := BinToWord('0000000000000000');
              Mask[1,11]  := BinToWord('0000000000000000');
              Mask[1,12]  := BinToWord('0000000000000000');
              Mask[1,13]  := BinToWord('0000000000000000');
              Mask[1,14]  := BinToWord('0000000000000000');
              Mask[1,15]  := BinToWord('0000000000000000');

              HorzHotSpot := 6;
              VertHotSpot := 7;

            end;
        end;

      procedure DefinePointingHand;
        begin
          With PointingHandCurs do
            begin
              Mask[0,0]   := BinToWord('1110000111111111');
              Mask[0,1]   := BinToWord('1110000111111111');
              Mask[0,2]   := BinToWord('1110000111111111');
              Mask[0,3]   := BinToWord('1110000111111111');
              Mask[0,4]   := BinToWord('1110000111111111');
              Mask[0,5]   := BinToWord('1110000000000000');
              Mask[0,6]   := BinToWord('1110000000000000');
              Mask[0,7]   := BinToWord('1110000000000000');
              Mask[0,8]   := BinToWord('0000000000000000');
              Mask[0,9]   := BinToWord('0000000000000000');
              Mask[0,10]  := BinToWord('0000000000000000');
              Mask[0,11]  := BinToWord('0000000000000000');
              Mask[0,12]  := BinToWord('0000000000000000');
              Mask[0,13]  := BinToWord('0000000000000000');
              Mask[0,14]  := BinToWord('0000000000000000');
              Mask[0,15]  := BinToWord('0000000000000000');

              Mask[1,0]   := BinToWord('0001111000000000');
              Mask[1,1]   := BinToWord('0001001000000000');
              Mask[1,2]   := BinToWord('0001001000000000');
              Mask[1,3]   := BinToWord('0001001000000000');
              Mask[1,4]   := BinToWord('0001001000000000');
              Mask[1,5]   := BinToWord('0001001111111111');
              Mask[1,6]   := BinToWord('0001001001001001');
              Mask[1,7]   := BinToWord('0001001001001001');
              Mask[1,8]   := BinToWord('1111001001001001');
              Mask[1,9]   := BinToWord('1001000000000001');
              Mask[1,10]  := BinToWord('1001000000000001');
              Mask[1,11]  := BinToWord('1001000000000001');
              Mask[1,12]  := BinToWord('1000000000000001');
              Mask[1,13]  := BinToWord('1000000000000001');
              Mask[1,14]  := BinToWord('1000000000000001');
              Mask[1,15]  := BinToWord('1111111111111111');

              HorzHotSpot := 5;
              VertHotSpot := 0;
            end;
        End;

      Procedure DefineDiagonalCross;
        begin
          With DiagonalCrossCurs do
            begin
              Mask[0,0]   := BinToWord('0000011111100000');
              Mask[0,1]   := BinToWord('0000000110000000');
              Mask[0,2]   := BinToWord('0000000000000000');
              Mask[0,3]   := BinToWord('1100000000000011');
              Mask[0,4]   := BinToWord('1111000000001111');
              Mask[0,5]   := BinToWord('1100000000000011');
              Mask[0,6]   := BinToWord('0000000000000000');
              Mask[0,7]   := BinToWord('0000000110000000');
              Mask[0,8]   := BinToWord('0000011111100000');
              Mask[0,9]   := BinToWord('1111111111111111');
              Mask[0,10]  := BinToWord('1111111111111111');
              Mask[0,11]  := BinToWord('1111111111111111');
              Mask[0,12]  := BinToWord('1111111111111111');
              Mask[0,13]  := BinToWord('1111111111111111');
              Mask[0,14]  := BinToWord('1111111111111111');
              Mask[0,15]  := BinToWord('1111111111111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0111000000001110');
              Mask[1,2]   := BinToWord('0001110000111000');
              Mask[1,3]   := BinToWord('0000011001100000');
              Mask[1,4]   := BinToWord('0000001111000000');
              Mask[1,5]   := BinToWord('0000011001100000');
              Mask[1,6]   := BinToWord('0001110000111000');
              Mask[1,7]   := BinToWord('0111000000001110');
              Mask[1,8]   := BinToWord('0000000000000000');
              Mask[1,9]   := BinToWord('0000000000000000');
              Mask[1,10]  := BinToWord('0000000000000000');
              Mask[1,11]  := BinToWord('0000000000000000');
              Mask[1,12]  := BinToWord('0000000000000000');
              Mask[1,13]  := BinToWord('0000000000000000');
              Mask[1,14]  := BinToWord('0000000000000000');
              Mask[1,15]  := BinToWord('0000000000000000');

              HorzHotSpot := 7;
              VertHotSpot := 4;
            end;
        end;

      Procedure DefineRectangularCross;
        begin
          with RectangularCrossCurs do
            begin
              Mask[0,0]   := BinToWord('1111110000111111');
              Mask[0,1]   := BinToWord('1111110000111111');
              Mask[0,2]   := BinToWord('1111110000111111');
              Mask[0,3]   := BinToWord('0000000000000000');
              Mask[0,4]   := BinToWord('0000000000000000');
              Mask[0,5]   := BinToWord('0000000000000000');
              Mask[0,6]   := BinToWord('1111110000111111');
              Mask[0,7]   := BinToWord('1111110000111111');
              Mask[0,8]   := BinToWord('1111110000111111');
              Mask[0,9]   := BinToWord('1111111111111111');
              Mask[0,10]  := BinToWord('1111111111111111');
              Mask[0,11]  := BinToWord('1111111111111111');
              Mask[0,12]  := BinToWord('1111111111111111');
              Mask[0,13]  := BinToWord('1111111111111111');
              Mask[0,14]  := BinToWord('1111111111111111');
              Mask[0,15]  := BinToWord('1111111111111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0000000110000000');
              Mask[1,2]   := BinToWord('0000000110000000');
              Mask[1,3]   := BinToWord('0000000110000000');
              Mask[1,4]   := BinToWord('1111111111111111');
              Mask[1,5]   := BinToWord('0000000110000000');
              Mask[1,6]   := BinToWord('0000000110000000');
              Mask[1,7]   := BinToWord('0000000110000000');
              Mask[1,8]   := BinToWord('0000000000000000');
              Mask[1,9]   := BinToWord('0000000000000000');
              Mask[1,10]  := BinToWord('0000000000000000');
              Mask[1,11]  := BinToWord('0000000000000000');
              Mask[1,12]  := BinToWord('0000000000000000');
              Mask[1,13]  := BinToWord('0000000000000000');
              Mask[1,14]  := BinToWord('0000000000000000');
              Mask[1,15]  := BinToWord('0000000000000000');

              HorzHotSpot := 7;
              VertHotSpot := 4;
            end;
        end;

      Procedure DefineHourGlass;
        begin
          With HourGlassCurs do
            begin
              Mask[0,0]   := BinToWord('0000000000000000');
              Mask[0,1]   := BinToWord('0000000000000000');
              Mask[0,2]   := BinToWord('0000000000000000');
              Mask[0,3]   := BinToWord('0000000000000000');
              Mask[0,4]   := BinToWord('1000000000000001');
              Mask[0,5]   := BinToWord('1100000000000011');
              Mask[0,6]   := BinToWord('1110000000000111');
              Mask[0,7]   := BinToWord('1111000000001111');
							Mask[0,8]   := BinToWord('1110000000000111');
							Mask[0,9]   := BinToWord('1100000000000011');
							Mask[0,10]  := BinToWord('1000000000000001');
							Mask[0,11]  := BinToWord('0000000000000000');
							Mask[0,12]  := BinToWord('0000000000000000');
							Mask[0,13]  := BinToWord('0000000000000000');
							Mask[0,14]  := BinToWord('0000000000000000');
							Mask[0,15]  := BinToWord('1111111111111111');

              Mask[1,0]   := BinToWord('0000000000000000');
              Mask[1,1]   := BinToWord('0111111111111110');
              Mask[1,2]   := BinToWord('0110000000000110');
              Mask[1,3]   := BinToWord('0011000000001100');
              Mask[1,4]   := BinToWord('0001100000011000');
              Mask[1,5]   := BinToWord('0000110000110000');
              Mask[1,6]   := BinToWord('0000011001100000');
              Mask[1,7]   := BinToWord('0000001111000000');
              Mask[1,8]   := BinToWord('0000011001100000');
              Mask[1,9]   := BinToWord('0000110000110000');
              Mask[1,10]  := BinToWord('0001100000011000');
              Mask[1,11]  := BinToWord('0011000000001100');
              Mask[1,12]  := BinToWord('0110000000000110');
              Mask[1,13]  := BinToWord('0111111111111110');
              Mask[1,14]  := BinToWord('0000000000000000');
              Mask[1,15]  := BinToWord('0000000000000000');

              HorzHotSpot := 7;
              VertHotSpot := 7;
            end;
        end;

      Procedure SetKeyStatus ( Mstatus : word );
        begin
          case Mstatus of
            0 : Mkey := None;
            1 : MKey := Left;
            2 : MKey := Right;
            3 : MKey := Both;
          end;
        end;

      Procedure ResetMouse;
        begin
          Regs.AX := 0;
          Intr($33,Regs);
          With Regs do
            begin
              MousePresent := AX > 0;
              if MousePresent Then
                NumMouseKeys := BX
              else
                NumMouseKeys := 0;
            end;
          MouseVisible := FALSE;
        end;

      Procedure VirtualScreenSize( Var MaxX,
                                       MaxY,
                                       CellSizeX,
                                       CellSizeY : Word);
        begin
          Regs.AH := $0F;
          Intr($10,Regs);
          Case Regs.AL of
            0,1,13 : Begin
                       MaxX := 640;
                       MaxY := 200;
                       CellSizeX := 16;
                       CellSizeY := 8;
                     end;
            2,3,7:Begin
                    MaxX := 640;
                    MaxY := 200;
                    CellSizeX := 8;
                    CellSizeY := 8;
                  end;
            4,5  :Begin
                    MaxX := 640;
                    MaxY := 200;
                    CellSizeX := 2;
                    CellSizeY := 1;
                  end;
            6    :Begin
                    MaxX := 640;
                    MaxY := 200;
                    CellSizeX := 1;
                    CellSizeY := 1;
                  end;
            14,15:Begin
                    MaxX := 640;
                    MaxY := 350;
                    CellSizeX := 1;
                    CellSizeY := 1;
                  end;
          end;
        end;

      Procedure MostraRato;
        begin
          If Not MouseVisible Then
            begin
              Regs.AX := 1;
              Intr($33,Regs);
              MouseVisible := True;
            end;
        end;

      Procedure EscondeRato;
        begin
          If MouseVisible Then
            Begin
              Regs.AX := 2 ;
              Intr($33,Regs);
              MouseVisible := False;
            end;
        end;

      Procedure GetButtonStatus;
        begin
          Regs.AX := 3;
          Intr($33,Regs);
          With Regs do
            begin
              SetKeyStatus(BX);
              MouseX := CX;
              MouseY := DX;
              Xm := (trunc(MouseX) div 8) + 1;
              Ym := (trunc(MouseY) div 8) + 1;
            end;
        end;

      Procedure ColocaRatoXY( x,y : Word );
        begin
          with Regs do
            Begin
              AX := 4;
              CX := x;
              DX := y;
            end;
          Intr($33,Regs);
          MouseX := x;
          MouseY := y;
          Xm := (trunc(MouseX) div 8) + 1;
          Ym := (trunc(MouseY) div 8) + 1;
        end;

      Procedure GetButtonPressInfo(KeyNum : word);
        begin
          With Regs do
            begin
              AX := 5;
              BX := KeyNum-1;
            end;
          Intr($33,Regs);
          With Regs do
            begin
              SetKeyStatus(AX);
              ButtonPressCount := BX;
              MouseX := CX;
              MouseY := DX;
              Xm := (trunc(MouseX) div 8) + 1;
              Ym := (trunc(MouseY) div 8) + 1;
            end;
        end;

      Procedure GetButtonReleaseInfo( KeyNum : Word);
        begin
          With Regs do
            begin
              AX := 6;
              BX := KeyNum -1;
            end;
          Intr($33,Regs);
          With Regs do
            begin
              SetKeyStatus(AX);
              ButtonReleaseCount := BX;
              MouseX := CX;
              MouseY := DX;
              Xm := (trunc(MouseX) div 8) + 1;
              Ym := (trunc(MouseY) div 8) + 1;
            end;
        end;

      Procedure SetMinMaxHorzCursPos(Min,Max : Word);
        begin
          with Regs do
            begin
              AX := 7;
              CX := Min;
              DX := Max;
            end;
          Intr($33,Regs);
        end;

      Procedure SetMinMaxVertCursPos(Min,Max : Word);
        begin
          with Regs do
            begin
              AX := 8;
              CX := Min;
              DX := Max;
            end;
          Intr($33,Regs);
        end;

      Procedure SetGraphicsCursor( Var Mask: GraphCursMaskType);
        begin
          with regs do
            begin
              AX := 9;
              BX := Word(Mask.HorzHotSpot);
              CX := Word(Mask.VertHotSpot);
              DX := Ofs(Mask);
              ES := Seg(Mask);
            end;
          Intr($33,Regs);
        end;

      Procedure SetSoftTextCursor( TextScrMask,
                                   TextCursMask : word);
        begin
          with regs do
            begin
              AX := 10;
              BX := 0;
              CX := TextScrMask;
              DX := TextCursMask;
            end;
          Intr($33,Regs);
        end;

      Procedure SetHardTextCursorBig;
        begin
          With Regs do
            begin
              AX := 10;
              BX := 1;
              If Stype = Mono then
                begin
                  CX := 0;
                  DX := 13;
                end
              else
                Begin
                  CX := 0;
                  DX := 7;
                end;
            end;
          Intr($33,Regs);
        end;

      Procedure SetHardTextCursorSmall;
        begin
          With Regs do
            begin
              AX := 10;
              BX := 1;
              if Stype = mono then
                begin
                  CX := 12;
                  DX := 13;
                end
              else
                begin
                  CX := 6;
                  DX := 7;
                end;
            end;
          Intr($33,Regs);
        end;

      Procedure ReadMouseMotionCounters( Var Hcount,
                                             Vcount : Integer);
        begin
          Regs.AX := 11;
          Intr($33,Regs);
          With Regs do
            begin
              Hcount := CX;
              VCount := DX;
            end;
        end;

      Procedure LightPenEmulOn;
        begin
          Regs.AX := 13;
          Intr($33,Regs);
        end;

      Procedure LightPenEmulOff;
        begin
          Regs.AX := 14;
          Intr($33,Regs);
        end;

      Procedure SetMickeyToPixels( Hratio,Vratio : word);
        begin
          with Regs do
            begin
              AX := 15;
              CX := HRatio;
              DX := VRatio;
            end;
          Intr($33,Regs);
        end;

      Procedure ConditionalOff( x1,y1,x2,y2 : Word);
        begin
          with regs do
            begin
              AX := 16;
              CX := x1;
              DX := y1;
              SI := x2;
              DI := y2;
            end;
          intr($33,Regs);
        end;

      Procedure SetDoubleSpeed( Speed : word);
        begin
          With Regs do
            begin
              AX := 19;
              DX := speed;
            end;
          Intr($33,Regs);
        end;

      Procedure GetMouseSaveSize;
        begin
          Regs.AX := 21;
          Intr($33,Regs);
          MouseBufferSize := Regs.BX;
        end;

      Procedure SaveMouseDriverState;
        begin
          GetMem(MouseSaveBuffer,MouseBufferSize);
          With Regs do
            begin
              AX := 22;
              DX := Ofs(MouseSaveBuffer^);
              ES := Seg(MouseSaveBuffer^);
            end;
          Intr($33,Regs);
        end;

      Procedure RestoreMouseDriverState;
        begin
          With Regs do
            begin
              AX := 23;
              DX := Ofs(MouseSaveBuffer^);
              ES := Seg(MouseSaveBuffer^);
            end;
          Intr($33,Regs);
          FreeMem(mouseSaveBuffer,MouseBufferSize);
        end;

      Procedure SetCrtPageNumber( Page : Word);
        begin
          With Regs DO
            begin
              AX := 29;
              BX := Page;
            end;
          Intr($33,Regs);
        end;

      Procedure GetCrtPageNumber( Var Page : word);
        begin
          Regs.AX := 23;
          Intr($33,Regs);
          Page := Regs.BX;
        end;

      Function AnyRato : Boolean;
        begin
          if MKP then
            Delay(MouseDelay);
          GetButtonStatus;
          MKP := MKey <> None;
          AnyRAto := MKP;
        end;

        Function EsqRato : Boolean;
        begin
          if MKP then
            Delay(MouseDelay);
          GetButtonStatus;
          MKP := MKey = left;
          EsqRato := MKP;
        end;

      Function DirRato : Boolean;
        begin
          if MKP then
            Delay(MouseDelay);
          GetButtonStatus;
          MKP := MKey = Right;
          DirRato := MKP;
        end;

	Function BothRato : Boolean;
        begin
          if MKP then
            Delay(MouseDelay);
          GetButtonStatus;
          MKP := MKey = Both;
	  BothRato := MKP;
        end;

      Procedure DefineEventHandler(Mask : Word;Pt : Pointer);
        begin
          FillChar(Regs,SizeOf(Regs),0);
          Regs.AX := 12;
          Regs.CX := Mask;
          Regs.ES := Seg(Pt);
          Regs.DX := Ofs(Pt);
          Intr($33,Regs);
        end;

      begin
        ResetMouse;
        DefineStandardShape;
        DefineUpArrow;
        DefineLeftArrow;
        DefineCheckMark;
        DefinePointingHand;
        DefineDiagonalCross;
        DefineRectangularCross;
        DefineHourGlass;
        MKP := FALSE;
        If MousePresent then
          begin
            TextScrMask := BinToWord('0111011111111111');
            TextCursMask:= BinToWord('0111011100000000');
            SetSoftTextCursor(TextScrMask,TextCursMask);
          end;
			end.*