  Unit BINU;

    Interface

      Function BinToWord( S : String) : Word;

      Function WordToBin( W : Word) : String;

    Implementation

      Function BinToWord( S : String) : Word;
        var
          w,i,j : Word;
        Begin
          W := 0;
          j := 1;
          For i := Length(S) DownTo 1 do
            begin
              w := w + (Ord(s[i])-48) * j;
              j := j *2;
            end;
          BinToWord := w;
        end;

      Function WordToBin( w : Word) : String;
        var
          s: String;
          i,j,k : Word;
        begin
          k := 1;
          s := '';
          For i := $0 to $F do
            begin
              If (W and k) > 0 then
                s := '1' + s
              else
                s := '0' + s;
              k := k *2;
            end;
          WordToBin := s;
        end;

			end.