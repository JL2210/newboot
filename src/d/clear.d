import lib.newboot;

extern(C):

void clear(int color, shared(short) **ptr)
{
	int ctr;
	for( ctr = 0; ctr < COLUMNS*ROWS; ctr++ )
	{
		(*ptr)[ctr] = cast(short)color;
	}
}
