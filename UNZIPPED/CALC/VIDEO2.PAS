  Unit Video2;

    interface

    uses Dos,
         Crt;

    type
      ScreenChars = Record
                      ch : char;
                      at : Byte;
                    end;
      screens = Record
									position : Array[1..80,1..25] of ScreenChars;
                  x,y : Byte;
                end;

      ScreenType = (mono,color);

    var
      Stype : ScreenType;
      VidSeg : Word;

    Procedure ShowScreen( var source,Video; Length : Word);
    Procedure GetScreen( var Video,Source; Length : word);
    Procedure XYstring( x,y: Byte;
                        s : string;
                        fg,bg : Byte);
    Procedure ReadScr( Var S);
    Procedure WriteScr( Var S);
    Procedure HorStr( x,y,Len : Byte;
                      fg,bg : Byte;
                      ch : Char);
    Procedure VerStr( x,y,len : Byte;
                      fg,bg : Byte;
                      ch : Char);
    type BoxStyle = (DBLDBL,DBLSNGL,SNGLDBL,SNGLSNGL,NENHUMA);
         Boxline  = (URCORNER,ULCORNER,LRCORNER,LLCORNER,
                     HORIZBAR,VERTBAR);
    procedure Box( x1,y1,x2,y2:integer;
                   style:BoxStyle;
                   fg,bg:Byte);
    Procedure center( y : Byte;
                      st: String;
                      fg,bg : Byte);
    Procedure BoxString( y : Byte;
                         st: String;
                         fg,bg : Byte;
                         style : BoxStyle);
    Procedure FillScreen( var sc : screens;
                          s : string;
                          x,y : Byte;
                          fg,bg : Byte);
    Procedure CursorOff;
    Procedure CursorSmall;
    Procedure CursorBig;
{$V-}Procedure Maiusculas(Var Texto : String); {$V+}
    Procedure cor(fg,bg:Byte);

  Implementation

    var
      regs : Registers;
      vid : Pointer;

    Procedure ShowScreen( var Source, Video;
                              Length : Word);
      { Este procedimento escreve diectamente para a memoria sem "Snow" .}
      begin
        if Stype = Color then
          InLine($90/$90/$90/$90/
                 $1E/$55/$BA/$DA/$03/$C5/$B6/ Source /$C4/$BE/ Video /
                 $8B/$8E/ Length /$FC/$AD/$89/$C5/$B4/$09/$EC/$D0/$D8/
                 $72/$FB/$FA/$EC/$20/$E0/$74/$FB/$89/$E8/$AB/$FB/$E2/
                 $EA/$5D/$1F)
        else
          begin
            length := length * 2;
            move(source,video,length);
          end;
      end;

    Procedure GetScreen( Var Video,Source;
                             Length : Word);
      begin
        if Stype = Color then
          InLine($1E/$55/$BA/$DA/$03/$C5/$B6/ Video /$C4/$BE/ Source /
                 $8B/$8E/ Length /$FC/$EC/$D0/$D8/$72/$FB/$FA/$EC/$D0/
                 $D8/$73/$FB/$AD/$FB/$AB/$E2/$F0/$5D/$1F)
        else
          begin
            length := length * 2;
            move(video,Source,Length);
          end;
      end;

    Procedure XYstring( x,y : Byte;
                        s : String;
                        fg,bg: Byte);
      Var Sa : Array[1..255] of record
                                  ch : char;
                                  at : Byte;
                                End;
          b,i : byte;
          offset : word;
      begin
        if (length(s) = 0) or
           (x > 80) or
           (x < 1) or
           (y > 25) or
           (y < 1) then exit;
        b := (ord(bg) shl 4) or ord(fg);
        FillChar(SA,Sizeof(SA),b);
        for i := 1 to length(s) do
          SA[i].ch := s[i];
        offset := (((y-1)*80)+(x-1))*2;
        Vid := Ptr(vidseg,offset);
        Showscreen(SA,Vid^,length(s));
      end;

    Procedure ReadScr(Var s);
      begin
        Vid := Ptr(VidSeg,0);
        GetScreen(Vid^,S,2000);
      end;

    Procedure WriteScr(Var S);
      Begin
        Vid := Ptr(VidSeg,0);
        ShowScreen(S,Vid^,2000);
      end;

    Procedure HorStr( x,y,Len : Byte;
                      fg,bg : Byte;
                      ch : Char);
      var
        i : Byte;
      begin
        For i := 1 to Len do
          begin
            XYstring(x,y,ch,fg,bg);
            x := x + 1;
          end;
      end;

    Procedure VerStr( x,y,Len : Byte;
                      fg,bg : Byte;
                      ch : char);
      Var
        i : Byte;
      begin
        for i := 1 to Len do
          begin
            XYstring(x,y,ch,fg,bg);
            y := y + 1;
          end;
      end;

    Procedure Box( x1,y1,x2,y2:integer;
                   style:BoxStyle;
                   fg,bg: byte);
      type BoxChar = array[URCORNER..VERTBAR,
                           DBLDBL..SNGLSNGL] of Char;
      const  boxChr : BoxChar = ((#187,#184,#183,#191),
                                 (#201,#213,#214,#218),
                                 (#188,#190,#189,#217),
                                 (#200,#212,#211,#192),
                                 (#205,#205,#196,#196),
                                 (#186,#179,#186,#179));
      var i : integer;
      begin
        if Style = NENHUMA then Exit;
        HorStr(x1,y1,1,fg,bg,boxchr[ULCORNER,style]);
        HorStr(x1+1,y1,pred(x2-x1),fg,bg,BoxChr[HORIZBAR,style]);
        HorStr(x2,y1,1,fg,bg,boxChr[URCORNER,style]);
        VerStr(x1,y1+1,Pred(y2-y1),fg,bg,boxChr[VERTBAR,Style]);
        VerStr(x2,y1+1,Pred(y2-y1),fg,bg,boxChr[VERTBAR,Style]);
        HorStr(x1,y2,1,fg,bg,boxChr[LLCORNER,style]);
        HorStr(x1+1,y2,pred(x2-x1),fg,bg,boxChr[HORIZBAR,style]);
        HorStr(x2,y2,1,fg,bg,boxChr[LRCORNER,Style]);
      end; { box }

    Procedure Center( y : Byte;
                      st: String;
                      fg,
                      bg : Byte);
      var
        x : Byte;
      begin
        x := (40 -(Length(st) div 2));
        XYstring(x,y,st,fg,bg);
      end;

    Procedure BoxString( Y : Byte;
                         st: String;
                         fg,bg : Byte;
                         Style : BoxStyle);
      var
        x1,y1,x2,y2 : Byte;
      begin
        Center(y,st,fg,bg);
        x1 := 40 -(length(st) div 2)-2;
        x2 := x1+length(st) + 3;
        y1 := y-1;
        y2 := y+1;
        Box(x1,y1,x2,y2,style,fg,bg);
      end;

    Procedure FillScreen(Var sc : screens;
                             s  : String;
                             x,y: Byte;
                             fg,bg : Byte);
      var
        i,atx : Byte;
      begin
        atx := fg Or (bg shl 4);
        For i := 1 to length(s) do
          begin
            sc.position[y,x].ch := s[i];
            sc.position[y,x].at := atx;
            x := x+1;
            if x>80 then
              begin
                x := 1;
                y := y+1;
                if y > 25 then
                  exit;
              end;
          end;
      end;

    Procedure CursorOff;
      begin
        FillChar(Regs,sizeOf(Regs),0);
        with Regs Do
          begin
            AH := $01;
            CH := $20;
            CL := $20;
          end;
        Intr($10,Regs);
      end;

    Procedure CursorSmall;
      begin
        FillChar(Regs,SizeOf(Regs),0);
        regs.AH := $01;
        Case Stype of
          Mono : Begin
                   With regs do
                     begin
                       ch := 12;
                       cl := 13;
                     end;
                  end;
          Color : Begin
                    With Regs do
                      begin
                        CH := 6;
                        CL := 7;
                      end;
                   end;
            end; { Case }
        Intr($10,Regs);
      end;

    Procedure CursorBig;
      begin
        FillChar(Regs,SizeOf(regs),0);
        regs.AH := 1;
        regs.CH := 0;
        case Stype of
          Mono : Regs.CL := 13;
          Color: Regs.CL := 7;
        end;
        Intr($10,Regs);
      end;

{$V-}Procedure Maiusculas(Var Texto : String); {$V+}
      Var c1 : Byte;
      begin
        for c1 := 1 to Length(Texto) do
          Texto[c1] := UpCase(Texto[C1]);
      end; { Maiusculas }

    Procedure Cor(Fg,Bg:Byte);
      begin
        TextColor(fg);
        TextBackGround(Bg);
      end;

    begin
      FillChar(regs,sizeof(regs),0);
      Regs.AH := $0F;
      Intr($10,Regs);
      If Regs.AL = 7 then
        begin
          Stype := Mono;
          VidSeg := $B000;
        end
      else
        begin
          stype := color;
          vidSeg := $B800;
        end;
    end. { Video2 Unit }
