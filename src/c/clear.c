#include <newboot.h>

void pm_clear(int color, volatile short **ptr)
{
	int ctr;
	for( ctr = 0; ctr < COLUMNS*ROWS; ctr++ )
	{
		(*ptr)[ctr] = color;
	}
}

void clear(void)
{
	return pm_clear(LIGHT_GRAY, &vid_mem);
}
