program vboot;
  uses crt,dos;

  type sector=array[0..511] of byte;

       bpb_rec=record
                 bytesPerSect:word;
                 sectsPerClust:byte;
                 reservedSects:word;
                 numOfFats:byte;
                 numOfRootEntries:word;
                 totalSects:word;
                 mediaDescriptorByte:byte;
                 sectsPerFat:word;
               end;

       boot_rec=record
                  jump:array[0..2] of byte;
                  oem:array[0..7] of byte;
                  bpb:bpb_rec;
                  sectsPerTrack:word;
                  numOfHeads:word;
                  numOfHiddenSects:word;
                  dummy:array[0..8] of byte;
                  serialNumber:array[0..3] of byte;  {offset 27H}
                  volumeId:array[0..10] of byte;     {offset 2BH}
                  bootStrapCode:array[0..461] of byte;
                end;

  function resetFdc(drive:byte):boolean;
    var r:registers;
    begin
      r.ah := 0;                { funcao 00h do INT 13h - reset floppy disk system }
      r.dl := drive;
      intr($13,r);              { chama o BIOS }
      if (r.flags and fcarry)<>0 then
        resetFdc:=false         { houve erro }
      else resetFdc:=true;      { nao houve erro }
    end;
  

  function lerStatus:boolean;
    var r:registers;
    begin
      r.ah := 1;                { funcao 01h do INT 13h - get floppy disk system status }
      intr($13,r);              { chama o BIOS }
      if r.ah=0 then
        lerStatus:=true
      else
        lerStatus:=false;
    end;

  function lerSector(drive,pista,face,primSect,numSects:byte;
                     buf:pointer):boolean;
    label LOOP;
    const MAX_TENT=3;
    var r:registers;
        res:boolean;
	tentativas:byte;
    begin
      tentativas:=0;
      LOOP:
      r.ah := 2;                { funcao 02h do INT 13h - read floppy disk }
      r.dl := drive;            { drive: 0=A 1=B 80h=C 81h=D ... }
      r.ch := pista;            { pista 0..}
      r.dh := face;             { face 0 ou 1 }
      r.cl := primSect;         { primeiro sector 1.. }
      r.al := numSects;         { numero de sectores a ler }
      r.es := seg(buf^);        { posiciona ES:BX no endere‡o do buffer }
      r.bx := ofs(buf^);        { para onde vao ser lidos os sectores }
      Intr($13,r);              { chama o BIOS }
      if (r.flags and fcarry)<>0 then
        begin
          if tentativas=MAX_TENT then
            lerSector:=false        { houve erro }
    	  else begin
	    res:=resetFdc(drive);
 	    tentativas:=tentativas+1;
  	    goto LOOP;
  	  end;
	end
      else lerSector:=true;     { nao houve erro }
    end;

  procedure mostrarBpb(var bootSect:boot_rec);
    begin
      with bootSect.bpb do begin
        writeln('              Numero de bytes por sector = ',bytesPerSect);
        writeln('          Numero de sectores por cluster = ',sectsPerClust);
        writeln('           Numero de sectores reservados = ',reservedSects);
        writeln('                          Numero de FATs = ',numOfFats);
        writeln('Numero de entradas de directoria da ROOT = ',numOfRootEntries);
        writeln('                Numero total de sectores = ',totalSects);
        writeln('                 Byte descritor da MEDIA = ',mediaDescriptorByte);
        writeln('              Numero de sectores por FAT = ',sectsPerFat);
      end;
    end;

  procedure mostrarBoot(var bootSect:boot_rec);
    var f:integer;
    begin
      with bootSect do begin
        write('                           Jump = ');
        for f:=0 to 2 do write(jump[f],' '); writeln;
        write('                            OEM = ');
        for f:=0 to 7 do write(chr(oem[f])); writeln;
        writeln('   Numero de sectores por pista = ',sectsPerTrack);
        writeln('              Numero de cabecas = ',numOfHeads);
        writeln('Numero de sectores "escondidos" = ',numOfHiddenSects);
          write('      Numero de serie do volume = ');
        for f:=3 downto 0 do write(serialNumber[f],' '); writeln;
        {neste ponto, os bytes podem ser mostrados em hexadecimal, como
        faz o DOS}
          write('                 Nome do volume = ');
        for f:=0 to 10 do write(chr(volumeId[f])); writeln;
        writeln('Numero de sectores "escondidos" = ',numOfHiddenSects);
        writeln;
      end;
    end;

  var bootSect:boot_rec;
      bpbInfo:bpb_rec;
      drive,face:byte;
  begin
    clrscr;
    writeln('VBOOT - Leitura do boot de uma disquete            *** Spooler Magazine 1995 ***');
    write('Qual o drive a ler ? (0=A, 1=B) : '); readln(drive); writeln;

    if drive<$80 then
      face:=0
    else
      face:=1;

    if lerSector(drive,0,face,1,1,@bootSect) then {drive,pista,face,primeiro,numero,buf}
      begin
        writeln('Informacoes do Bios Parameter Block (BPB):');
        writeln('==========================================');
        mostrarBpb(bootSect);
        writeln;
        writeln('Outras informacoes do Boot Sector:');
        writeln('==================================');
        mostrarBoot(bootSect);
      end
    else
      writeln('Erro no acesso ao drive.');
  end.


