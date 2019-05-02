#include <newboot.h>
#include <stdint.h>
#if __STDC_HOSTED__
# include <stdio.h>
# include <unistd.h>
#endif

void *vid_mem = (void *)VIDEO_MEM;

#define _sz(x) sizeof(x)-1
#define hello "Hello, World"
#if __STDC_HOSTED__
# define pm_getchar(x) getchar()
# define pm_putchar(x,y) putchar(x)
# define pm_write(x,y,z) write(STDOUT_FILENO, x, y)
#endif

void main(void)
{
	int ch;
	pm_write(hello, _sz(hello), &vid_mem);
	pm_putchar('!', &vid_mem);
	keyboard_init();
	for(;;)
	{
		ch = pm_getchar(kbd_sc);
		pm_putchar(ch, &vid_mem);
	}
	return;
}
