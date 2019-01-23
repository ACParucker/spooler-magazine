unit mouseA;
interface


  procedure hidemouse;
  procedure showmouse;
  function mgetxpos : integer;
  function getxpos : integer;
  function getypos : integer;
  function mousebp : integer;
  procedure mousenewpos (nx, ny : integer);
  procedure xposminmax  (minX, maxX : integer);
  procedure yposminmax  (minY, maxY : integer);

  procedure esp_bp (botao : byte);
  procedure esp_br;


implementation

  procedure showmouse;assembler;
    asm
          MOV    AX, 1
          INT    033h
    end;

  procedure hidemouse;assembler;
    asm
          MOV    AX, 2
          INT    033h
    end;

  function mgetxpos;assembler;
    asm
          MOV    AX, 3
          INT    033h
          MOV    AX, CX
          SHR    AX, 1
    end;

  function getxpos;assembler;
    asm
          MOV    AX, 3
          INT    033h
          MOV    AX, CX
    end;


  function getypos;assembler;
    asm
          MOV    AX, 3
          INT    033h
          MOV    AX, DX
    end;

   function mousebp;assembler;
     asm
          MOV    AX, 3
          INT    033h
          MOV    AX, BX
     end;

   procedure mousenewpos;assembler;
     asm
          MOV    AX, 4
          MOV    CX, nx
          MOV    DX, ny
          INT    033h
     end;

   procedure xposminmax;assembler;
     asm
          MOV    AX, 7
          MOV    CX, minX
          MOV    DX, maxX
          INT    033h
     end;

   procedure yposminmax;assembler;
     asm
          MOV    AX, 8
          MOV    CX, minY
          MOV    DX, maxY
          INT    033h
     end;


   procedure esp_bp;
{ espera at‚ o bot„o 'botao' ser pressionado }
   begin
        repeat until mousebp = botao
   end;


   procedure esp_br;
{ espera at‚ todos os bot”es deixarem de ser pressionados }
   begin
        repeat until mousebp = 0
   end;




end.













