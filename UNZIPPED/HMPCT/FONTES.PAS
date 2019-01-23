Unit Fontes;

Interface

Uses DOS;

Procedure LoadFontFile(Nome:String);
Procedure LoadLinkfont(Buffer:pointer;NumBytes:Byte);
Procedure LoadRomFont8x16;
Procedure LoadRomFont8x14;
Procedure LoadRomFont8x8;

Implementation

Procedure LoadFontFile(Nome:String);
          var r:registers;
              Buffer:Pointer;
              F:file;
              Nc:byte;
              BR:word;
          begin
               Assign(F,Nome);
               Reset(f,1);
               BlockRead(F,Nc,1);
               BR:=FileSize(f)-1;
               GetMem(Buffer,BR);
               BlockRead(F,Buffer^,BR);
               Close(f);
	       r.ah:=$11;
	       r.al:=$10;
               r.es:=Seg(Buffer^);
	       r.bp:=Ofs(Buffer^);
	       r.cx:=256;
	       r.dx:=0;
	       r.bl:=0;
	       r.bh:=NC;
	       Intr($10,r);
               FreeMem(Buffer,BR);
          end;

Procedure LoadLinkfont(Buffer:pointer;NumBytes:Byte);
          var r:registers;
          begin
	       r.ah:=$11;
	       r.al:=$10;
               r.es:=Seg(Buffer^);
	       r.bp:=Ofs(Buffer^);
	       r.cx:=256;
	       r.dx:=0;
	       r.bl:=0;
	       r.bh:=NumBytes;
	       Intr($10,r);
          end;

Procedure LoadRomFont8x16;
          var r:registers;
          begin
               r.ah:=$11;
               r.al:=$4;
               r.bl:=0;
               Intr($10,r);
          end;
Procedure LoadRomFont8x14;
          var r:registers;
          begin
               r.ah:=$11;
               r.al:=$1;
               r.bl:=0;
               Intr($10,r);
          end;

Procedure LoadRomFont8x8;
          var r:registers;
          begin
               r.ah:=$11;
               r.al:=$2;
               r.bl:=0;
               Intr($10,r);
          end;
end.