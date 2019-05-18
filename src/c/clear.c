#include <newboot.h>

void clear(int color, volatile short **ptr)
{
	int ctr;
	for( ctr = 0; ctr < COLUMNS*ROWS; ctr++ )
	{
		(*ptr)[ctr] = color;
	}
}
