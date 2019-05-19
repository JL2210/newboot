#include <newboot.h>

int pm_putchar(int c, int color, volatile short **ptr)
{
	c &= 0xff;

	if(c == '\n')
	{
		*ptr += COLUMNS;
		goto ret;
	}
	else if(c == '\r')
	{
		*ptr -= ((intptr_t)*ptr - VIDEO_MEM) % COLUMNS;
		goto ret;
	}
	else if(c == '\t')
	{
		*ptr += 8 - (((intptr_t)*ptr - VIDEO_MEM) % 8);
		goto ret;
	}
	else if(c == '\b')
	{
		(*ptr)--;
		**ptr = 0;
		goto ret;
	}

	**ptr = (short)(c | color);
	(*ptr)++;
ret:	return c;
}

int putchar(int c)
{
	return pm_putchar(c, COLOR, &vid_mem);
}
