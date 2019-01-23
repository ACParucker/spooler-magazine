#include <dos.h>
#include <io.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <alloc.h>

#define car_lin 77
#define fast unsigned char register
#define verilinha if (lcount==car_lin) {putc(13,sai);putc('\n',sai);lcount=0;linhacur++;}

void mensagem(void)
{
  textcolor(11);
  cprintf("FILE MAIL - By Miguel Gon‡alves");
  printf("\nSintaxe :\n");
  textcolor(15);
  cprintf("          Partir : FILEMAIL P <linhas/ficheiro> <ficheiro origem> <nome destino>");
  printf("\n");
  cprintf("          Juntar : FILEMAIL J <nome origem>\n");
  textcolor(7);
  exit(1);
}

void erro(char *oi)
{
 textcolor(4);
 cprintf("\n\n%s \n\n\n",oi);
 fcloseall();
 mensagem();
}

void compose(int filecur, char *str)
{
 sprintf(str,"%3d",filecur);
 if (filecur<100) str[0]='0';
 if (filecur<10) str[1]='0';
}

void doname(unsigned n, char *in, char *out)
{
 char resto[4], snd[130];
 fast c;

 sprintf(resto, "%3d",n);
 if (n<10) resto[0]=resto[1]='0';
 if (n<100) resto[0]='0';
 strcpy(snd,in);
 for(c=0;c<13;c++) if (snd[c]==NULL) {snd[c]='.'; snd[c+1]=NULL; break;}
 strcat(snd,resto);
 strcpy(out,snd);
}

void bridge(FILE *entra, char *val)
{
 fast a;

 if(val[0]=='+' && val[1]=='*') val[0]=val[1]=val[2]=val[3]=0;
 if(val[1]=='+' && val[2]=='*') val[1]=val[2]=val[3]=0;
 if(val[2]=='+' && val[3]=='*') val[2]=val[3]=0;
 if(val[3]=='+') val[3]=0;
 for(a=0;a<4;a++)
 {
    if (val[a]==0)
    {
       val[a]=getc(entra);
       if (val[a]=='\n' || val[a]==13) val[a]=getc(entra);
       if (val[a]=='\n' || val[a]==13) val[a]=getc(entra);
    }
 }
}

char outprep(char f)
{
 char ret;

 ret=f;
 ret+=40;
 if (ret>57) ret+=8;
 if (ret>90) ret+=7;
 return ret;
}

char inprep(char f)
{
 char ret;

 ret=f;
 if (ret>=97) ret-=7;
 if (ret>=65) ret-=8;
 ret-=40;
 return ret;
}


void partir(char *fl, char *in, char *out)
{
  FILE *entra, *sai;
  int hand;
  long siz;
  unsigned nl, linhacur=0, filecur=1;
  char ok=0, nout[13], str[4];
  fast a, lcount=29;
  struct bit1 { b1:2; b2:2; b3:2; re:2;}nbit;
  struct bit2 { nbit : 6; re:2;};
  union
  {
   char c;
   struct bit2 bit;
  }r1,r2,r3;
  union
  {
   char c;
   struct bit1 nbit;
  }conv;

  if ((nl=atoi(fl))==0) erro("N£mero de linhas inv lido !");
  nl--;
  doname(filecur,out,nout);
  if(!(hand=_open(in,O_BINARY))) erro("Erro na abertura do ficheiro de input !");
  siz=filelength(hand);
  _close(hand);
  if((entra=fopen(in,"rb"))==NULL) erro("Erro na abertura do ficheiro de input !");
  if((sai=fopen(nout,"wb"))==NULL) erro("Erro na cria‡„o do ficheiro de output !");

  for(a=0;a<strlen(in);a++) if(in[a]=='\\' || in[a]==':') {in=&(in[a+1]); a=0;}
  fprintf(sai,"+*FILE MAIL*+%-12s",in);
  fwrite(&(siz), 4, 1, sai);
  for(;;)
    {
      unsigned char o;
      fread(&(r1.c), 1, 1, entra);
      if(feof(entra)!=0) ok=1;
      if(ok==1) r1.c=0;
      nbit.b1=r1.bit.re; r1.bit.re=0;
      o=outprep(r1.c);
      if(putc(o,sai)==EOF) erro("Erro de escrita !");
      lcount++; verilinha;
      if (linhacur==nl)
       {
	  compose(filecur, str);
	  fprintf(sai,"+*FIM DO BLOCO No. %s*+",str);
	  fclose(sai);
	  filecur++; linhacur=0;
	  doname(filecur,out,nout);
	  if((sai=fopen(nout,"wb"))==NULL) erro("Erro na cria‡„o do ficheiro de output !");
	  fprintf(sai,"+*FILE MAIL*+%-12s",in); lcount=29;
	  fwrite(&(siz), 4, 1, sai);
       }

      fread(&(r2.c), 1, 1, entra);
      if(feof(entra)!=0) ok=1;
      if(ok==1) r2.c=0;
      nbit.b2=r2.bit.re; r2.bit.re=0;
      o=outprep(r2.c);
      if(putc(o,sai)==EOF) erro("Erro de escrita !");
      lcount++; verilinha;
      if (linhacur==nl)
       {
	  compose(filecur,str);
	  fprintf(sai,"+*FIM DO BLOCO No. %s*+",str);
	  fclose(sai);
	  filecur++; linhacur=0;
	  doname(filecur,out,nout);
	  if((sai=fopen(nout,"wb"))==NULL) erro("Erro na cria‡„o do ficheiro de output !");
	  fprintf(sai,"+*FILE MAIL*+%-12s",in); lcount=29;
	  fwrite(&(siz), 4, 1, sai);
       }

      fread(&(r3.c), 1, 1, entra);
      if(feof(entra)!=0) ok=1;
      if(ok==1) r3.c=0;
      nbit.b3=r3.bit.re; r3.bit.re=0;
      o=outprep(r3.c);
      if(putc(o,sai)==EOF) erro("Erro de escrita !");
      lcount++; verilinha;
      if (linhacur==nl)
       {
	  compose(filecur,str);
	  fprintf(sai,"+*FIM DO BLOCO No. %s*+",str);
	  fclose(sai);
	  filecur++; linhacur=0;
	  doname(filecur,out,nout);
	  if((sai=fopen(nout,"wb"))==NULL) erro("Erro na criacao do ficheiro de output !");
	  fprintf(sai,"+*FILE MAIL*+%-12s",in); lcount=29;
	  fwrite(&(siz), 4, 1, sai);
       }

      conv.nbit=nbit; conv.nbit.re=0;
      o=outprep(conv.c);
      if(putc(o,sai)==EOF) erro("Erro de escrita !");
      lcount++; verilinha;
      if (linhacur==nl)
	{
	  compose(filecur, str);
	  fprintf(sai,"+*FIM DO BLOCO No. %s*+",str);
	  fclose(sai);
	  filecur++; linhacur=0;
	  doname(filecur,out,nout);
	  if((sai=fopen(nout,"wb"))==NULL) erro("Erro na criacao do ficheiro de output !");
	  fprintf(sai,"+*FILE MAIL*+%-12s",in); lcount=29;
	  fwrite(&(siz), 4, 1, sai);
	}
      if (ok==1) break;
    }
  putc(13,sai); putc('\n',sai);
  compose(filecur, str);
  fprintf(sai,"+*FIM DO ULTIMO BLOCO - No. %s*+",str);
  fclose(entra);
  fclose(sai);
}

void juntar(char *in)
{
  FILE *entra, *sai, *out;
  unsigned filecur=1;
  char ok=0, ok2=0, nin[13], d[30], *dump, ci[4];
  fast a;
  long siz, know;
  struct bit1 { b1:2; b2:2; b3:2; re:2;}nbit;
  struct bit2 { nbit : 6; re:2;};
  union
  {
   char c;
   struct bit2 bit;
  }r1,r2,r3;
  union
  {
   char c;
   struct bit1 nbit;
  }conv;

  dump=d;

RESTART:
  doname(filecur,in,nin);
  if((entra=fopen(nin,"rb"))==NULL) erro("Erro na abertura do ficheiro de input !");

  for(;;)
  {
    long pos;

    while((getc(entra))!='+');
    pos=ftell(entra);
    fgets(dump, 25, entra);
    dump[25]=NULL;
    fread(&siz, 4, 1, entra);
    if(strstr(dump,"*FILE M")) break;
    else fseek(entra,pos,SEEK_SET);
    if (feof(entra)) erro("O ficheiro n„o cont‚m nenhuma marca do FILEMAIL.");
  }

  if (ok==0)
  {
    for(a=0;a<25;a++) if(dump[a]=='+') dump=&(dump[a+1]);
    textcolor(11);
    cprintf("FILE MAIL - By Miguel Gon‡alves\n");
    printf("\nReunindo o ficheiro %s\n",strupr(dump));
    if((sai=fopen(dump,"wb"))==NULL) erro("Erro na criacao do ficheiro de output !");
    ok=1;
  }

  for(;;)
    {

      if (ok2==0) for(a=0;a<4;a++)
      {
	ci[a]=getc(entra);
        if (ci[a]=='\n' || ci[a]==13) ci[a]=getc(entra);
        if (ci[a]=='\n' || ci[a]==13) ci[a]=getc(entra);
      }
      else {bridge(entra, ci); ok2=0;}

      if(feof(entra)!=0) erro("O fim do ficheiro foi atingido sem que fosse encontrada a marca do FILEMAIL");

      if(ci[0]=='+' || ci[1]=='+' || ci[2]=='+' || ci[3]=='+')
      {
        char str[17];
        long tel;

        tel=ftell(entra);
        fgets(str,17,entra);
        fseek(entra,tel,SEEK_SET);
        if(strstr(str,"ULTIMO")) { fclose(entra); fclose(sai); goto BAZAR; }
        if(strstr(str,"BLOCO")) { fclose(entra); filecur++; ok2=1; goto RESTART; }
      }

      ci[0]=inprep(ci[0]); ci[1]=inprep(ci[1]); ci[2]=inprep(ci[2]); ci[3]=inprep(ci[3]);
      r1.bit.nbit=ci[0]; r2.bit.nbit=ci[1]; r3.bit.nbit=ci[2]; conv.c=ci[3];
      r1.bit.re=conv.nbit.b1;
      r2.bit.re=conv.nbit.b2;
      r3.bit.re=conv.nbit.b3;

      know=ftell(sai);
      if(putc(r1.c,sai)==EOF) erro("Erro de escrita !"); if (know+1==siz) goto BAZAR;
      if(putc(r2.c,sai)==EOF) erro("Erro de escrita !"); if (know+2==siz) goto BAZAR;
      if(putc(r3.c,sai)==EOF) erro("Erro de escrita !"); if (know+3==siz) goto BAZAR;
    }
BAZAR:
    textcolor(3);
    cputs("\nFicheiro reunido com sucesso !\n\n");
    textcolor(7);
}

void main(int argc, char *argv[])
{
  if (argc<3) mensagem();
  switch (toupper(argv[1][0]))
  {
    case 'P' : if (argc<5) mensagem();
	       partir(argv[2],argv[3],argv[4]);
	       break;
    case 'J' : juntar(argv[2]);
	       break;
    default  : mensagem();
  }
}
