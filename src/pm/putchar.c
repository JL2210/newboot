#include <newboot.h>

#define LIGHT_GRAY 0x0700
#define COLUMNS 80

void pm_putchar(int c, void **ptr)
{
	static int tab_count;

	c &= 0xff;
	c |= LIGHT_GRAY;

	if(c == ('\n' | LIGHT_GRAY))
	{
		*ptr += (2*COLUMNS);
		return;
	}
	else if(c == ('\r' | LIGHT_GRAY))
	{
		for( ; tab_count > 0; tab_count-- )
			*ptr -= 2*8;
		*ptr -= (2*COLUMNS) - ((intptr_t)*ptr % (2*COLUMNS));
		return;
	}
	else if(c == ('\t' | LIGHT_GRAY))
	{
		*ptr += 2*8;
		tab_count++;
		return;
	}

	**(short **)ptr = (short)c;
	(*ptr) += 2;
}
