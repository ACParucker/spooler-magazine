
/*

    criar o EGAVGA.OBJ da seguinte forma: bgiobj egavga

*/

#include <graphics.h>
#include <stdio.h>

main(void)
{
	int gdriver=VGA, gmode=VGAHI;
	int x;

	if ((registerbgidriver(EGAVGA_driver) < 0) ||
		(registerbgifont(triplex_font) < 0))
	{
		printf("\nPrograma currompido.\n");
		return -1;
	}

	initgraph(&gdriver, &gmode, "");
	if (graphresult() != grOk) {
		printf("\n necess rio uma placa VGA pelo menos.\n");
		return -1;
	}

	settextstyle(TRIPLEX_FONT, HORIZ_DIR, 4);	/* select the registered font */
	settextjustify(CENTER_TEXT, CENTER_TEXT);	/* output some text */
	outtextxy(getmaxx()/2, getmaxy()/2, "Um exemplo da fonte TRIPLEX");

	getch();
	restorecrtmode();
	return 0;
}
