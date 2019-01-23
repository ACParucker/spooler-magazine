//Header para o rato do 3DVISUAL por Bruno Shirley Possolo

typedef struct{
  unsigned int 	x,
		y,
		butao,
		click;
}cord;

cord 	rato;

union REGS regs;

void mostra_rato(void);
void esconde_rato(void);
void inicializa_rato(void);
cord getmouse(void);
cord getmousepos(void);
void mouseOff(void);


/* mostra ponteiro */
void mostra_rato(void)
{
  regs.x.ax = 1;
  int86(0x33,&regs,&regs);
}

/* esconde ponteiro */
void esconde_rato(void)
{
  regs.x.ax = 2;
  int86(0x33,&regs,&regs);
}

/* testa e inicializa o rato */
void inicializa_rato(void)
{
  /* ver se existe rato */
  regs.x.ax = 0;
  int86(0x33,&regs,&regs);
  if (regs.x.ax == 0)
    {
    perror("ERRO! Rato n∆o instalado!\n");
    exit(0);
    }
  /* posicao min/max Horizontal */
  regs.x.ax = 7;
  regs.x.cx = 1;
  regs.x.dx = getmaxx();
  int86(0x33,&regs,&regs);
  /* posicao min/max Vertical */
  regs.x.ax = 8;
  regs.x.cx = 1;
  regs.x.dx = getmaxy();
  int86(0x33,&regs,&regs);
  /* posiciona o rato */
  regs.x.ax = 4;
  regs.x.cx = getmaxx()/2;
  regs.x.dx = getmaxy()/2;
  int86(0x33,&regs,&regs);
  mostra_rato();
}

/* devolve coordenadas ao carregar num bot∆o */
cord getmouse(void)
{
  union REGS regs;
  cord pos;
  regs.x.ax = 5;
  regs.x.bx = 0;
  int86(0x33,&regs,&regs);
  pos.x = regs.x.cx;
  pos.y = regs.x.dx;
  pos.x = pos.x ;
  pos.y = pos.y ;
  pos.butao = regs.x.ax;
  pos.click = regs.x.bx;
  return (pos);
}

/* devolve coordenadas */
cord getmousepos(void)
{
  union REGS regs;
  cord pos;
  regs.x.ax = 3;
  regs.x.bx = 0;
  int86(0x33,&regs,&regs);
  pos.x = regs.x.cx;
  pos.y = regs.x.dx;
  pos.x = pos.x ;
  pos.y = pos.y ;
  pos.butao = regs.x.bx;
  return (pos);
}

/* desinstala o rato */
void mouseOff(void)
{
	regs.x.ax=0;
	int86(0x33,&regs,&regs);
}

