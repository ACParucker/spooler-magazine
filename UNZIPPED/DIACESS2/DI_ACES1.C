#include <dos.h>
#include <dir.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define DRIVE_C		(0x80)

#define TIMES		(200)

int GetCurrentDriveParameters(
	int drive_number,	int *max_cylinder,
	int *max_sector,	int *max_heads,
	int *fixed_disks)
{
    union REGS r;

    r.h.ah = 0x08;
    r.h.dl = drive_number;
    int86(0x13, &r, &r);
    if(r.h.ah)
	 return -1;	/* erro	*/

    *max_cylinder = r.h.ch;
    *max_sector = r.h.cl;
    *max_heads = r.h.dh;
    *fixed_disks = r.h.dl;

    return 0;
}



int SeekToCylinder(
	int cylinder,	int max_heads,
	int drive_number)
{
    union REGS r;

    r.h.ah = 0x0C;

    r.h.ch = cylinder;
    r.h.cl = ((cylinder >> 8 ) << 6);

    r.h.dh = max_heads;
    r.h.dl = drive_number;
    int86(0x13, &r, &r);
    if(r.h.ah)
	 return -1;	/* erro */
    return 0;
}



#define TIME(value)	((float)((end - start)/CLK_TCK/value*1000))

	   /*

int main(void)
{
    int dummy;
    int error, i;
    int cyli;
    int sect;
    int heads;
    int fixed_disks;
    int drive;
    int cylinder;
    clock_t start, end;


    drive = DRIVE_C;

    error = GetCurrentDriveParameters(drive, &cyli, &sect, &heads, &fixed_disks);
    if(error==-1){
	 printf("Erro na obten‡„o dos parƒmetros do disco...\n");
	 return -1;
    }

    if(!fixed_disks){
	 printf("HD n„o foi detectado...\n");
	 return -1;
    }

    printf("%d disco(s) detectado(s)\n\n", fixed_disks);


    while(fixed_disks--){

	 printf("Disco %c\n", drive - DRIVE_C + 'C');

	 cylinder = cyli+((sect >> 6) << 8) + 1;
	 sect = (unsigned)(sect << 10) >> 10;

	 printf("N£mero de cilindros  %7d\n", cylinder);
	 printf("N£mero de sectores   %7d\n", sect);
	 printf("N£mero de cabe‡as    %7d\n", heads + 1);
	 printf("Bytes por sector     %7d\n", 512);
	 printf("Capacidade formatada %9.1f Mbytes\n",
		      512.0 * cylinder * (heads + 1) * sect / 1024 / 1024);

	 error = SeekToCylinder(0, heads, drive);
	 if(error==-1){
	      printf("Erro no posicionamento no cilindro 0...\n");
	      return -1;
	 }

	 start = clock();
	 for(i=0; i!=cylinder; i++){
	      error = SeekToCylinder(i, heads, drive);
	      if(error==-1){
		   printf("Erro no posicionamento no cilindro %d...\n", i);
		   return -1;
	      }
	 }
	 end = clock();
	 printf("Pista por pista      %9.1f ms\n", TIME(cylinder));



	 randomize();
	 error = SeekToCylinder(0, heads, drive);
	 if(error==-1){
		printf("Erro no posicionamento no cilindro 0...\n");
		return -1;
	 }
	 start = clock();
	 for(i=0; i!=TIMES; i++){
	      cyli = random(cylinder);
	      SeekToCylinder(cyli, heads, drive);
	 }
	 end = clock();
	 printf("Tempo de acesso      %9.1f ms\n\n", TIME(TIMES));

	 if(!fixed_disks)
	      return 0;

	 drive++;

	 error = GetCurrentDriveParameters(drive, &cyli, &sect, &heads, &dummy);
	 if(error==-1){
	      printf("Erro na obten‡„o dos parƒmetros do disco...\n");
	      return -1;
	 }

    }

    return 0;
}
*/