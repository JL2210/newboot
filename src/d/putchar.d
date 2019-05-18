import lib.newboot;

extern(C):

int pm_putchar(int c, int color, shared(short)** ptr)
{
	c &= 0xff;

	if(c == '\n')
	{
		*ptr += COLUMNS;
		goto ret;
	}
	else if(c == '\r')
	{
		*ptr -= (*ptr - (cast(shared(short) *)VIDEO_MEM)) % COLUMNS;
		goto ret;
	}
	else if(c == '\t')
	{
		*ptr += 8 - ((*ptr - (cast(shared(short) *)VIDEO_MEM)) % 8);
		goto ret;
	}
	else if(c == '\b')
	{
		(*ptr)--;
		**ptr = 0;
		goto ret;
	}

	**ptr = cast(short)(c | color);
	(*ptr)++;
ret:	return c;
}
