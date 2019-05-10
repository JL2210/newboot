#include <newboot.h>

#define B_LIGHT_GRAY 0x7000
#define LIGHT_GRAY 0x0700
#define B_WHITE 0xf000
#define WHITE 0x0f00
#define B_BLACK 0x0000
#define BLACK 0x0000
#define COLUMNS 160
#define COLOR (B_WHITE)

void pm_putchar(int c, void **ptr)
{
	c &= 0xff;
	c |= COLOR;

	if(c == ('\n' | COLOR))
	{
		*ptr += COLUMNS;
		return;
	}
	else if(c == ('\r' | COLOR))
	{
		*ptr -= ((intptr_t)*ptr - VIDEO_MEM) % COLUMNS;
		return;
	}
	else if(c == ('\t' | COLOR))
	{
		*ptr += 16 - (((intptr_t)*ptr - VIDEO_MEM) % 16);
		return;
	}
	else if(c == ('\b' | COLOR))
	{
		*ptr -= 2;
		**(short **)ptr = 0;
		return;
	}

	**(short **)ptr = (short)c;
	*ptr += 2;
}
