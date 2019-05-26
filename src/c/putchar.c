#include <newboot.h>

int pm_putchar(int c, int color)
{
	c &= 0x7f;

	if(c == '\n' || c == '\v')
	{
		y++;
		goto ret;
	}
	else if(c == '\r')
	{
		x = 0;
		goto ret;
	}
	else if(c == '\t')
	{
		x += 8 - (x % 8);
		goto ret;
	}
	else if(c == '\b')
	{
		x--;
		vid_mem[get_vid_pos()] = 0;
		goto ret;
	}

	vid_mem[get_vid_pos()] = (short)(c | color);
	x++;
ret:	return c;
}

int putchar(int c)
{
	return pm_putchar(c, COLOR);
}
