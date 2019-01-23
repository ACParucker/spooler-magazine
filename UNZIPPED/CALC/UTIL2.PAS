{$I-;$V-;$S-;$D-}

UNIT util2;

	INTERFACE

	USES crt,Dos;

  CONST dayName        : ARRAY[0..6] OF String[3] =
												 ('Dom','Seg','Ter','Qua','Qui','Sex','S b');

	TYPE
			INTG_V    = ARRAY [1..24] OF BYTE;
			STRG_V    = ARRAY [1..24] OF STRING[45];
			STRG1_V   = ARRAY [1..24] OF STRING[1];
			STRG2_V   = ARRAY [1..24] OF STRING[80];
			MENUV_MSG = ^STRG2_V;
			MENUV_INT = ^INTG_V;
			MENUV_STR = ^STRG_V;
			STRG_D    = ARRAY [1..10,1..10] OF STRING[20];
			STRG1_D   = ARRAY [1..10,1..10] OF STRING[80];
			STRG2_D   = ARRAY [1..10,1..10] OF STRING[1];
			INTG_D    = ARRAY [1..10,1..10] OF BYTE;
      INTG2_D   = ARRAY [1..10] OF BYTE;
			INTG3_D   = ARRAY [1..10,1..10,0..1] OF BYTE;
			MENUD_MSG = ^STRG1_D;
			MENUD_INT = ^INTG_D;
			MENUD_STR = ^STRG_D;
			MENUD_CDS = ^INTG3_D;
			STRING3     = STRING[3];
			STRING12    = STRING[12];
			STRING20    = STRING[40];
			MENU_RST    = ARRAY [0..2] OF BYTE;
			ARRAY_CDS		= ARRAY [1..20,0..1] OF BYTE;
			SPECIAL_CDS = ^ARRAY_CDS;

	VAR i,z	: integer;
  		hour,minute,second,sec100,
			year,month,day,dayOFweek  : Word;
			f,g,special_1,jn_mnu,
			sp_m,sp_1,sp_2,sp_3,sp_4,sp_5,sp_6,sp_7,sp_8,sp_9,sp_10,  { posicao inicial da barra - menus principais }
			sbm1,sbm2,sbm3,sbm4,sbm5,sbm6,sbm7,sbm8,sbm9,sbm10,sbm11, { posicao inicial da barra - submenus         }
			sbm12,sbm13,sbm14,sbm15,sbm16,sbm17,sbm18,sbm19,sbm20,
			hlp1,hlp2,hlp3,hlp4,hlp5,hlp6,hlp7,hlp8,hlp9,hlp10,       { posicao inicial da barra - help dos menus principais }
			hlpsbm1,hlpsbm2,hlpsbm3,hlpsbm4,hlpsbm5,hlpsbm6,hlpsbm7,  { posicao inicial da barra - help nos submenus }
			hlpsbm8,hlpsbm9,hlpsbm10,hlpsbm11,hlpsbm12,hlpsbm13,hlpsbm14,
			hlpsbm15,hlpsbm16,hlpsbm17,hlpsbm18,hlpsbm19,hlpsbm20,
			sbmsbm1,sbmsbm2,sbmsbm3,sbmsbm4,sbmsbm5,sbmsbm6,sbmsbm7,  { posicao inicial da barra - sub-submenus }
			sbmsbm8,sbmsbm9,sbmsbm10,sbmsbm11,sbmsbm12,sbmsbm13,sbmsbm14,
			sbmsbm15,sbmsbm16,sbmsbm17,sbmsbm18,sbmsbm19,sbmsbm20,
			hlpsbmsbm1,hlpsbmsbm2,hlpsbmsbm3,hlpsbmsbm4,hlpsbmsbm5,   { posicao inicial da barra - help nos sub-submenus }
			hlpsbmsbm6,hlpsbmsbm7,hlpsbmsbm8,hlpsbmsbm9,hlpsbmsbm10,
			hlpsbmsbm11,hlpsbmsbm12,hlpsbmsbm13,hlpsbmsbm14,hlpsbmsbm15,
			sbm3x1,sbm3x2,sbm3x3,sbm3x4,sbm3x5,sbm3x6,sbm3x7,sbm3x8,sbm3x9, { posicao inicial da barra - sub-sub-submenus }
			sbm3x10,sbm3x11,sbm3x12,sbm3x13,sbm3x14,sbm3x15           : INTEGER;
			e,sp,last_m,cot,line : integer;
			fsl_pos,xx,yy 			 : MENUD_INT;
			opc                  : MENUD_STR;
			fs_cds               : MENUD_CDS;
			h_st,m_st            : MENUD_MSG;
			m_h,m_v,m_v_ve,
			m_v_pur,m_v_h,m_v_red,
			m_v_jn               : MENU_RST;
			sp_cds               : SPECIAL_CDS;
			opc_v,cht_v          : MENUV_STR;
			avai,pos_v			     : MENUV_INT;
			hs_v,ms_v				     : MENUV_MSG;
			edit_cds             : SPECIAL_cds;
			stResult,
			dia,mes,ano          : String;
			stLChar,p            : Char;
			size,y               : longint;
			n                    : integer;

	PROCEDURE TC(a : integer);
	PROCEDURE TB(a : integer);
	PROCEDURE XY(a,b : integer);
	PROCEDURE date;
	PROCEDURE time;
	PROCEDURE pze;
	procedure pressKey(key : char);
	PROCEDURE fundo(x,y,len,alt,clr,bck : integer; ch_st : Char);
	FUNCTION UPLETTER( st:STRING; po:BYTE ):STRING;
  FUNCTION DOWNLETTER(st:STRING; po:BYTE):STRING;
	FUNCTION lowerCase(expr : String; sizeOFexpressao : Byte) : String;
	FUNCTION upperCase(expr : String; tamanho : Byte ) : String;
	FUNCTION CUT(strin : string) : string;
	PROCEDURE SETCURSOR(a:BYTE);
	PROCEDURE init_menuv;
	PROCEDURE dispose_menuv;
	PROCEDURE EDITST(x, y, tx_cl, tx_bk, x_ins, y_ins, ins_cl, ins_bk,
									 c_x, c_y, c_cl, c_bk, arr_cl, arr_bk, le, ch_num, ch : INTEGER;
									 sp_cds : SPECIAL_CDS; s : STRING;
									 VAR st : STRING; VAR car : CHAR);
	PROCEDURE SCROLLST(x,y,tx_cl,tx_bk,ch_num,pos,x_pos,y_pos,cl_pos,bk_pos,
                     arr,arr_cl,arr_bk:INTEGER;
                     sp_cds : SPECIAL_CDS; s:STRING; VAR car:CHAR);

	IMPLEMENTATION

	procedure pressKey;

		var x : char;

		begin
			repeat
				x:=readkey;
			until x=key;
		end;

	PROCEDURE TC;
		BEGIN
			TextColor(a);
		END;

	PROCEDURE TB;
		BEGIN
			TextBackGround(a);
		END;

	PROCEDURE XY;
		BEGIN
			GotoXY(a,b);
		END;

	PROCEDURE date;
		BEGIN
			GetDate(year,month,day,dayOFweek);
			TC(9);TB(7);xy(5,1);Write(' ',dayName[dayOFweek],'(',day,')/',month,'/',year,' ');
		END;

  PROCEDURE time;

		BEGIN
				Repeat
				GetTime(hour,minute,second,sec100);
				TC(9);TB(7);xy(66,1);Write(hour,':',minute,':',second,':',sec100,'    ');
				Until Keypressed;
		END;

		PROCEDURE pze;

			VAR a : integer;

			BEGIN
				a:=700;
				repeat
					sound(a);delay(3);
					a:=a+300;
				until a=5200;
				nosound;
			END;

	PROCEDURE fundo;

		VAR f,g : integer;
				str : string;

		BEGIN
			TC(clr);TB(bck);str:='';
			FOR f:=1 TO len DO
				str:=str+ch_st;
			FOR f:=1 TO alt DO
				BEGIN
					xy(x,y+f-1);Write(str);
				END;
		END;

	FUNCTION UPLETTER;

	 VAR le,f : BYTE;
			 s    : STRING;
			 chrs : char;

		BEGIN
				 le:=LENGTH(st);s:='';
				 FOR f:=1 TO le DO
						BEGIN
								 chrs:=st[f];
								 IF f>po THEN s:=s+st[f];
								 IF f<=po THEN
									BEGIN
									 IF chrs=#132 THEN chrs:=#142;IF chrs=#131 THEN chrs:=#143;
									 IF chrs=#148 THEN chrs:=#153;IF chrs=#136 THEN chrs:=#137;
									 IF chrs=#143 THEN chrs:=#140;IF chrs=#143 THEN chrs:=#135;
									 IF chrs=#160 THEN chrs:=#134;IF chrs=#138 THEN chrs:=#146;
									 IF chrs=#130 THEN chrs:=#144;IF chrs=#141 THEN chrs:=#152;
									 IF chrs=#161 THEN chrs:=#139;IF chrs=#149 THEN chrs:=#169;
									 IF chrs=#162 THEN chrs:=#159;IF chrs=#151 THEN chrs:=#157;
									 IF chrs=#163 THEN chrs:=#150;IF chrs=#135 THEN chrs:=#128;
									 chrs:=UPCASE(chrs);
									 s:=s+chrs;
									END;
						END;
				 UPLETTER:=s;
		END;

	FUNCTION DOWNLETTER;

		VAR le,f : BYTE;
				sa   : STRING;
				chrs : CHAR;
				letters : SET OF CHAR;

		BEGIN
				 letters:=['A'..'Z'];
				 le:=LENGTH(st);sa:='';
				 FOR f:=1 TO le DO
						BEGIN
								 chrs:=st[f];
								 IF (chrs IN letters) THEN
									 BEGIN
                        chrs:=CHR(ORD(st[f])+32);
												IF f<>po THEN sa:=sa+chrs;
												IF f=po THEN sa:=sa+st[f];
									 END
								 ELSE
									 BEGIN
										 IF chrs=#142 THEN chrs:=#132;IF chrs=#143 THEN chrs:=#131;
										 IF chrs=#153 THEN chrs:=#148;IF chrs=#137 THEN chrs:=#136;
										 IF chrs=#140 THEN chrs:=#143;IF chrs=#145 THEN chrs:=#133;
										 IF chrs=#134 THEN chrs:=#160;IF chrs=#146 THEN chrs:=#138;
										 IF chrs=#144 THEN chrs:=#130;IF chrs=#152 THEN chrs:=#141;
										 IF chrs=#139 THEN chrs:=#161;IF chrs=#169 THEN chrs:=#149;
										 IF chrs=#159 THEN chrs:=#162;IF chrs=#157 THEN chrs:=#151;
										 IF chrs=#150 THEN chrs:=#163;IF chrs=#128 THEN chrs:=#135;
										 sa:=sa+chrs;
									 END;
						END;
				 DOWNLETTER:=sa;
		END;

  FUNCTION LowerCase;

		VAR i                    : Integer;
				targetChar,lowerChar : Char;
				outString            : String;
				upperCaseLetters     : SET OF Char;

		BEGIN
			upperCaseLetters := ['A'..'Z'];
			outString        := '';
			FOR i := 1 TO Length(expr)-sizeOFexpressao DO
				BEGIN
					targetChar := expr[i];
					IF (targetChar IN upperCaseLetters) THEN
						BEGIN
							lowerChar := CHR(ORD(targetChar)+32);
							outString := outString + lowerChar;
						END
					ELSE
						outString := outString + targetChar
				END;
			LowerCase := outString+Copy(expr,Length(expr)-sizeOFexpressao+1,Length(expr));
		END;

	FUNCTION upperCase;

		VAR i         : Integer;
				outString : String;

		BEGIN
			outString := '';
			FOR i := 1 TO Length(expr)-tamanho DO
				BEGIN
					outString := outString + Upcase(expr[i]);
				END;
			upperCase := outString+Copy(expr,Length(expr)-tamanho+1,Length(expr));
		END;

		FUNCTION CUT(strin : string) : string;

			VAR staux : String;
					f     : byte;

			begin
				staux:='';
				FOR f:=1 TO Length(strin) DO
					BEGIN
						IF (strin[f]<>#32) THEN staux:=staux+strin[f];
						IF (strin[f]=#32) THEN
							IF ((f+1<LENGTH(strin)) AND (strin[f+1]<>#32))
								THEN staux:=staux+#32;
					END;
				IF staux[1]=#32 THEN DELETE(staux,1,1);
				cut:=staux;
			end;

	PROCEDURE SETCURSOR;

		TYPE SETTINGS = ARRAY [0..7] OF BYTE;

		CONST MON : SETTINGS = ( 14 , 00 , 11 , 12 , 07 , 12 , 00 , 12 );
					CLR : SETTINGS = ( 01 , 00 , 06 , 07 , 04 , 07 , 00 , 07 );

		VAR reg : REGISTERS;

		 BEGIN
			 IF (a>3) OR (a<0) THEN HALT;
				 a:=a*2;
				 WITH reg DO
					 BEGIN
						IF LASTMODE=MONO THEN
							BEGIN
								ch:=MON[a];
								cl:=MON[a+1];
							END ELSE
							BEGIN
								ch:=CLR[a];
								cl:=CLR[a+1];
							END;
							ah:=$01;
							INTR($10,reg);
			END;
	 END;

	PROCEDURE INIT_MENUV;

		BEGIN
			NEW(opc_v);NEW(hs_v);NEW(ms_v);NEW(avai);
			NEW(pos_v);NEW(sp_cds);
			FOR f:=1 TO 24 DO
				BEGIN
					opc_v^[f]:='';hs_v^[f]:='';ms_v^[f]:='';
					avai^[f]:=0;pos_v^[f]:=1;
					IF f<21 THEN BEGIN sp_cds^[f,0]:=3;sp_cds^[f,1]:=3 END
				END;
			sp_cds^[1,0]:=33;sp_cds^[2,0]:=50;sp_cds^[3,0]:=31;sp_cds^[4,0]:=25;
			sp_cds^[5,0]:=18;sp_cds^[6,0]:=23;sp_cds^[7,0]:=34;sp_cds^[8,0]:=20;
			sp_cds^[9,0]:=49;sp_cds^[10,0]:=35;sp_cds^[11,0]:=16;sp_cds^[12,0]:=130;
			FOR f:=0 TO 2 DO
				BEGIN
					m_v[f]:=0;m_v_h[f]:=0;m_v_ve[f]:=0;m_v_pur[f]:=0;m_v_red[f]:=0;
					m_v_jn[f]:=0;
				END;
		END;

	PROCEDURE DISPOSE_MENUV;

		BEGIN
			DISPOSE(opc_v);DISPOSE(hs_v);DISPOSE(ms_v);DISPOSE(avai);
			DISPOSE(pos_v);DISPOSE(sp_cds);
		END;

	PROCEDURE EDITST;

		VAR   c,c_ch,f,aux  : INTEGER;
					i,k           : CHAR;
					auxst         : STRING[80];
					ist           : STRING[3];

		LABEL 1,2;

			BEGIN
				 aux:=80;ist:='ON ';st:=s;
				 IF (aux-x) < ch_num THEN HALT;IF LENGTH(st)>le THEN HALT;
				 IF (x IN [1..80]) AND (y IN [1..25]) AND (le IN [1..250]) AND
						(ch IN [0..1]) AND (LENGTH(s)<=le) THEN
					 BEGIN
						 SETCURSOR(3);
						 XY(x_ins,y_ins);TC(ins_cl);TB(ins_bk);WRITE(#16' INSERT ',ist,' '#17);
						 TC(tx_cl);TB(tx_bk);auxst:='';
             FOR f:=1 TO ch_num DO auxst:=auxst+' ';
             XY(x,y);WRITE(auxst);
						 c:=LENGTH(st);IF c>ch_num THEN c:=ch_num;XY(x,y);c_ch:=c;aux:=0;
						 FOR f:=1 TO c_ch DO WRITE(st[f]);XY(x+c_ch,y);
						 REPEAT
							1:
							 aux:=(ch_num-c_ch);
							 TC(arr_cl);TB(arr_bk);
               IF c+aux<LENGTH(st) THEN
								 BEGIN
									 XY(x+ch_num+1,y);WRITE(#16)
								 END;
							 IF c-c_ch>0 THEN
								 BEGIN
									 XY(x-2,y);WRITE(#17)
								 END;
							 XY(c_x,c_y);TC(c_cl);TB(c_bk);WRITE('   ');XY(c_x,c_y);WRITE(le-LENGTH(st));
							 TC(tx_cl);TB(tx_bk);XY(x+c_ch,y);
							 IF ch=0 THEN
								 BEGIN
		 						   REPEAT
										 i:=READKEY;k:=#1;
										 IF i=#0 THEN k:=READKEY;
										 FOR f:=1 TO 20 DO
											 BEGIN
												 IF sp_cds^[f,0]=ORD(k) THEN BEGIN car:=k;EXIT END;
												 IF sp_cds^[f,1]=ORD(k) THEN BEGIN car:=i;EXIT END;
											 END;
									 UNTIL (i IN [#32..#125]) OR (i IN [#128..#153]) OR (i=#27) AND
												 (i<>#137) AND(i<>#139) AND (i<>#140) AND (i<>#145) AND
												 (i<>#146) AND (i<>#150) OR (i=#156) OR
												 (i>=#160) AND (i<=#163) OR (i=#166) OR (i=#167) OR
												 (i=#174) OR (i=#175) OR (i=#8) OR (i=#13) OR (i=#4) OR
												 (k=#77) OR (k=#75) OR (k=#83) OR (k=#79) OR
												 (k=#71) OR (k=#82) OR (k=#80) OR (k=#72);
								 END;
								 IF ch=1 THEN
										 REPEAT
											 i:=READKEY;k:=#1;
											 IF i=#0 THEN k:=READKEY;
                       FOR f:=1 TO 20 DO
  											 BEGIN
	  											 IF sp_cds^[f,0]=ORD(k) THEN BEGIN car:=k;EXIT END;
		  										 IF sp_cds^[f,1]=ORD(k) THEN BEGIN car:=i;EXIT END;
			  								 END;
										 UNTIL (i IN [#48..#58]) OR (i=#8) OR (i=#13) OR (i=#27) OR
													 (i=#4) OR (k=#77) OR (k=#75) OR (k=#83) OR (k=#79) OR
										  		 (k=#71) OR (k=#82) OR (k=#72) OR (k=#80);
									 IF (LENGTH(st)>=le) AND (i<>#13) AND (i<>#8) AND (i<>#4) AND (k<>#75) AND (k<>#77) AND
											(k<>#83) AND (k<>#71) AND (k<>#79) AND (k<>#82) AND (k<>#72) AND (k<>#80) AND (i<>#27) THEN
											BEGIN
												IF ist='ON ' THEN
													BEGIN
														SOUND(1200);DELAY(50);NOSOUND;EXIT
													END;
												IF (ist='OFF') AND (c=le) THEN
                          BEGIN
														SOUND(1200);DELAY(50);NOSOUND;EXIT
													END;
											END;
									 IF (i=#13) OR (i=#27) THEN BEGIN car:=i;SOUND(1200);DELAY(50);NOSOUND;EXIT END;
									 IF (k=#80) OR (k=#72) THEN BEGIN car:=k;SOUND(1200);DELAY(50);NOSOUND;EXIT END;
									 IF k=#82 THEN
										 BEGIN
											 IF ist='OFF' THEN
                         BEGIN
													 ist:='ON ';SETCURSOR(3);GOTO 2
                         END;
											 IF ist='ON ' THEN
                         BEGIN
													 ist:='OFF';SETCURSOR(1);GOTO 2
												 END;
											2:
                       XY(x_ins,y_ins);TC(ins_cl);TB(ins_bk);
											 WRITE(#16' INSERT ',ist,' '#17);
											 TC(tx_cl);TB(tx_bk);
											 XY(x+c_ch,y);
											 GOTO 1
										 END;
									 TC(arr_cl);TB(arr_bk);
									 XY(x-2,y);WRITE(' ');XY(x+ch_num+1,y);WRITE(' ');
									 TC(tx_cl);TB(tx_bk);
									 IF i=#4 THEN
										BEGIN
											st:='';c_ch:=0;c:=0;xy(x,y);Write(auxst)
										END;
 									 IF k=#83 THEN
										 BEGIN
											 IF c=LENGTH(st) THEN
												 BEGIN
													 XY(x+c_ch,y);SOUND(1500);DELAY(6);NOSOUND;GOTO 1;
												 END;
											 DELETE(st,c+1,1);XY(x,y);WRITE(auxst);
										 END;
									 IF k=#71 THEN
										 BEGIN
											 c:=0;c_ch:=0;XY(x,y);
											 aux:=ch_num;IF LENGTH(st)<ch_num THEN aux:=LENGTH(st);
											 FOR f:=1 TO aux DO WRITE(st[f]);
											 XY(x,y);GOTO 1;
										 END;
  								 IF k=#79 THEN
										 BEGIN
											 c:=LENGTH(st);c_ch:=ch_num;XY(x,y);
                       IF LENGTH(st)<c_ch THEN c_ch:=LENGTH(st);
											 aux:=(ch_num-c_ch);
                       IF LENGTH(st)-c<(ch_num-c_ch) THEN aux:=LENGTH(st)-c;
											 FOR f:=c+1-(c_ch) TO c+aux DO WRITE(st[f]);
											 XY(x+c_ch,y);GOTO 1;
										 END;
									 IF i=#8 THEN
										 BEGIN
											 DELETE(st,c,1);c:=c-1;
											 IF c_ch>c THEN c_ch:=c_ch-1;
											 IF c_ch<0 THEN c_ch:=0;
											 IF c<0 THEN
												 BEGIN
													 c:=0;XY(x+c_ch,y);SOUND(1500);DELAY(6);NOSOUND;GOTO 1;
												 END;
											 XY(x,y);WRITE(auxst);
									   END;
									 IF k=#75 THEN
										 BEGIN
											 c:=c-1;
											 IF c_ch>0 THEN c_ch:=c_ch-1;
											 IF c<0 THEN
												 BEGIN
													 c:=0;XY(x+c_ch,y);SOUND(1500);DELAY(6);NOSOUND;GOTO 1;
												 END;
										 END;
									 IF k=#77 THEN
										 BEGIN
											 c:=c+1;XY(x+c_ch,y);
											 IF (c_ch<ch_num) AND (c<=LENGTH(st)) THEN c_ch:=c_ch+1;
											 IF c_ch>LENGTH(st) THEN c_ch:=LENGTH(st);
											 IF c>LENGTH(st) THEN
												 BEGIN
													 c:=LENGTH(st);XY(x+c_ch,y);SOUND(1500);DELAY(6);NOSOUND;GOTO 1;
												 END;
										 END;
									 IF (NOT (k IN [#77,#75,#83])) AND (i<>#8) AND (i<>#4) AND
											(ist='OFF') THEN
										 BEGIN
											 DELETE(st,c+1,1);INSERT(i,st,c+1);c:=c+1;c_ch:=c_ch+1;
											 IF c_ch>ch_num THEN c_ch:=ch_num;
										 END;
									 IF (NOT (k IN [#77,#75,#83])) AND (i<>#8) AND (i<>#4) AND
											(ist='ON ') THEN
										 BEGIN
											 c:=c+1;INSERT(i,st,c);XY(x,y);c_ch:=c_ch+1;
											 IF c_ch>ch_num THEN c_ch:=ch_num;
										 END;
									 aux:=(ch_num-c_ch);
									 XY(x,y);
									 IF LENGTH(st)-c<(ch_num-c_ch) THEN aux:=LENGTH(st)-c;
									 FOR f:=c+1-(c_ch) TO c+aux DO WRITE(st[f]);
									 XY(x+c_ch,y);
									 SOUND(650);DELAY(3);NOSOUND;
									 IF LENGTH(st)=le THEN GOTO 1;
								UNTIL (i=#13);
								SOUND(1200);DELAY(50);NOSOUND;
         END
       ELSE EXIT;
		 END;

	PROCEDURE SCROLLST;

		VAR   c,c_ch,f,aux  : INTEGER;
					i,k           : CHAR;
					auxst         : STRING[80];

		LABEL 1;

			BEGIN
				 aux:=80;
				 IF (x IN [1..80]) AND (y IN [1..25]) AND	(LENGTH(s) IN [0..250]) THEN
					 BEGIN
						 SETCURSOR(2);
						 TC(tx_cl);TB(tx_bk);auxst:='';
             FOR f:=1 TO ch_num DO auxst:=auxst+' ';
             XY(x,y);WRITE(auxst);
						 c:=LENGTH(s);IF c>ch_num THEN c:=ch_num;XY(x,y);c_ch:=c;aux:=0;
						 FOR f:=1 TO c_ch DO WRITE(s[f]);
						 REPEAT
              1:
               IF arr=1 then
                 begin
                   TC(arr_cl);TB(arr_bk);
									 XY(x-2,y);WRITE(' ');XY(x+ch_num+1,y);WRITE(' ');
                   aux:=(ch_num-c_ch);
  	  						 TC(arr_cl);TB(arr_bk);
                   IF c+aux<LENGTH(s) THEN
		  	  					 BEGIN
			  	  					 XY(x+ch_num+1,y);WRITE(#16)
				  	  			 END;
  					  		 IF c-c_ch>0 THEN
	  					  		 BEGIN
		  					  		 XY(x-2,y);WRITE(#17)
			  					   END;
									 tc(tx_cl);tb(tx_bk);
                   xy(x+c_ch,y);
                 end;
               IF pos=1 then
                 begin
                   tc(cl_pos);tb(bk_pos);
                   xy(x_pos+3,y_pos);write('     ');
                   xy(x_pos,y_pos);write(c+1,'/',length(s));
                   tc(tx_cl);tb(tx_bk);
                   xy(x+c_ch,y);
                 end;
 						   REPEAT
     						 i:=READKEY;k:=#1;
								 IF i=#0 THEN k:=READKEY;
								 FOR f:=1 TO 20 DO
									 BEGIN
										 IF sp_cds^[f,0]=ORD(k) THEN BEGIN car:=k;EXIT END;
										 IF sp_cds^[f,1]=ORD(k) THEN BEGIN car:=i;EXIT END;
									 END;
		  				 UNTIL (k=#77) OR (k=#75) OR (k=#79) OR (i=#27) OR (i=#13) OR
							  		 (k=#71) OR (k=#80) OR (k=#72);
							 IF (i=#13) OR (i=#27) THEN BEGIN car:=i;SOUND(1200);DELAY(50);NOSOUND;EXIT END;
							 IF (k=#80) OR (k=#72) THEN BEGIN car:=k;SOUND(1200);DELAY(50);NOSOUND;EXIT END;
			  			 IF k=#71 THEN
								 BEGIN
									 c:=0;c_ch:=0;XY(x,y);
									 FOR f:=1 TO ch_num DO WRITE(s[f]);
									 XY(x,y);GOTO 1;
								 END;
  			  		 IF k=#79 THEN
								 BEGIN
									 c:=LENGTH(s);c_ch:=ch_num;XY(x,y);
									 FOR f:=c-ch_num+1 TO c DO WRITE(s[f]);
									 XY(x+c_ch,y);GOTO 1;
								 END;
							 IF k=#75 THEN
								 BEGIN
									 c:=c-1;
									 IF c_ch>0 THEN c_ch:=c_ch-1;
									 IF c<0 THEN
					  				 BEGIN
											 c:=0;xy(x+c_ch,y);SOUND(1000);DELAY(3);NOSOUND;GOTO 1;
										 END;
								 END;
							 IF k=#77 THEN
								 BEGIN
									 c:=c+1;XY(x+c_ch,y);aux:=c_ch;
									 IF (c_ch<ch_num) THEN c_ch:=c_ch+1;
									 IF (c_ch>LENGTH(s)) THEN c_ch:=LENGTH(s);
									 IF c>LENGTH(s) THEN
										 BEGIN
											 c:=LENGTH(s);XY(x+c_ch,y);SOUND(1000);DELAY(3);NOSOUND;GOTO 1;
										 END;
								 END;
               xy(x,y);aux:=(ch_num-c_ch);
						   IF LENGTH(s)-c<(ch_num-c_ch) THEN aux:=LENGTH(s)-c;
							 FOR f:=(c-c_ch)+1 TO c+aux DO Write(s[f]);
							 XY(x+c_ch,y);
               SOUND(600);DELAY(6);NOSOUND;
						 UNTIL (i=#13);
						 SOUND(1200);DELAY(50);NOSOUND;
         END
       ELSE EXIT;
		 END;
	END.