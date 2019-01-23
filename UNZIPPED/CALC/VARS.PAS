   unit Vars;

     interface

   { Character and string constants: }

     const NULLCHR    = #0;
           BELL       = #7;
           BS         = #8;
           TAB        = #9;
           LF         = #10;
           CR         = #13;
           FF         = #12;
           ESC        = #27;
           SPACE      = #32;
           DEL        = #127;
           NULLSTR    = '';

   { Control key constants: }

           BKSPCKEY   = BS;
           ENTERKEY   = CR;
           TABKEY     = TAB;
           F1KEY      = #59;
           F2KEY      = #60;
           F3KEY      = #61;
           F4KEY      = #62;
           F5KEY      = #63;
           F6KEY      = #64;
           F7KEY      = #65;
           F8KEY      = #66;
           F9KEY      = #67;
           F10KEY     = #68;
           INSKEY     = #82;
           DELKEY     = #83;
           HOMEKEY    = #71;
           ENDKEY     = #79;
           PGUP       = #73;
           PGDN       = #81;
           CURRIGHT   = #77;
           CURLEFT    = #75;
           CURUP      = #72;
           CURDOWN    = #80;

  { Key symbol constants: Strings that display IBM key symbols. }

            RIGTHSYM    = #32#26#32;
            LEFTSYM     = #32#27#32;
            UPSYM       = #32#24#32;
            DOWNSYM     = #32#25#32;
            BSSYM       = #32#17#196#32;
            ENTERSYM    = #32#17#196#217#32;
            TABSYM      = #32#196#196#16#221#32;
            ARROW       = #205#205#16#32;

            TextoNormal = [#32..#254];
            Numerico    = [#40..#57];
            TMaiusculas = [#32,#65..#90];

  { String types: General purpose string types. }

       type Str2        = string[2];
            Str3        = string[3];
            Str4        = string[4];
            Str5        = string[5];
            Str6        = string[6];
            Str7        = string[7];
            Str8        = string[8];
            Str9        = string[9];
            Str10       = string[10];
            Str12       = string[12];
            Str15       = string[15];
            Str20       = string[20];
            Str25       = string[25];
            Str30       = string[30];
            Str40       = string[40];
            Str50       = string[50];
            Str60       = string[60];
            Str78       = string[78];
            Str80       = string[80];
            Str255      = string[255];
            FileID      = string[64];

        { Set Types: }

         AnyChar        = set of Char;
         PrintableChar  = set of ' '..'~';
         ControlChar    = set of #0..#127;

        { Tipo de control de fluxo }

         Fluxo = (Janelas,Menus,Botoes);

  { Global status variables: }

       var  ioStatus,
            VidAttr     : integer;
            TipoOp      : Fluxo;
            monoSystem,
            escFlag,
            errFlag,
            endSession  : boolean;


   implementation
   end.