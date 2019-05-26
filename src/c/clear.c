#include <newboot.h>

void pm_clear(int color)
{
	int ctr;
	for( ctr = 0; ctr < COLUMNS*ROWS; ctr++ )
	{
		vid_mem[ctr] = (short)color;
	}
}

void clear(void)
{
	return pm_clear(COLOR);
}
