#include <newboot.h>
#include <stdint.h>
#if __STDC_HOSTED__
# include <stdio.h>
# include <unistd.h>
#endif

void *vid_mem = (void *)VIDEO_MEM;

#define _sz(x) sizeof(x)-1
char kbd_init_msg[] = "Initializing keyboard...";
char kbd_done_msg[] = "Done initializing keyboard.";
#if __STDC_HOSTED__
# define pm_getchar(x) getchar()
# define pm_putchar(x,y) putchar(x)
# define pm_write(x,y,z) write(STDOUT_FILENO, x, y)
#endif

void main(void)
{
	int ch;
	pm_write(kbd_init_msg, _sz(kbd_init_msg), &vid_mem);
	pm_write(kbd_done_msg, _sz(kbd_done_msg), &vid_mem);
}
