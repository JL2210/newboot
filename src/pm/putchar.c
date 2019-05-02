#include <newboot.h>

#define LIGHT_GRAY 0x0700

void pm_putchar(int c, void **ptr)
{
	short *video_mem = *ptr;

	c &= 0xff;
	c |= LIGHT_GRAY;

	*video_mem = (short)c;
	(*ptr) += 2;
}
