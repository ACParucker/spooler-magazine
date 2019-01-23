program x;

  {calcula a potˆncia inteira A elevado a B}
  function intPower(a,b:integer):integer;
     var auxA,f:integer;
     begin
       if b=0 then
         auxA:=1
       else
         begin
           auxA:=a;
           for f:=1 to b-1 do auxA:=auxA*a;
         end;
       intPower:=auxA;
     end;

  {converte uma string bin ria no seu equivalente decimal}
  function bin2dec(s:string):integer;
    var
      n,dimS,f,dig,erro:integer;
    begin
      n:=0;
      dimS:=length(s);
      for f:=1 to dimS do
        begin
          {para maior eficiˆncia podem condensar-se estas duas linhas numa s¢
          n:=n+ord(s[dimS+1-f])-ord('0')*intPower(2,f-1);
          e omitir a vari vel DIG}
          dig:=ord(s[dimS+1-f])-ord('0');
          n:=n+dig*intPower(2,f-1);
        end;
      bin2dec:=n;
    end;

  {converte um n£mero inteiro no seu equivalente bin rio}
  function dec2bin(n:integer):string;
    var binStr,auxStr:string;
        bit,nDig,quoc,f:integer;
    begin
      nDig:=0;
      quoc:=n;
      while quoc>1 do begin
        bit:=quoc mod 2;
        nDig:=nDig+1;
        binStr[nDig]:=chr(ord('0')+bit);
        quoc:=quoc div 2;
      end;
      nDig:=nDig+1;
      binStr[nDig]:=chr(ord('0')+quoc);
      binStr[0]:=chr(nDig);
      (*a string tem de ser invertida*)
      for f:=nDig downto 1 do
          auxStr[nDig-f+1]:=binStr[f];
      auxStr[0]:=chr(nDig);
      dec2bin:=auxStr;
    end;

  begin
    writeln(bin2dec('11111111'));
    writeln(dec2bin(255));
    readln;
  end.
