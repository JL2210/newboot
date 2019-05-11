#include <newboot.h>
#if __STDC_HOSTED__
# include <stdio.h>
# include <unistd.h>
#endif

void *vid_mem = (void *)VIDEO_MEM;

#define _sz(x) sizeof(x)-1
char welcome[] = "Welcome to the strange land of protected mode!\r\n";
#if __STDC_HOSTED__
# define pm_getchar(x) getchar()
# define pm_putchar(x,y) putchar(x)
# define pm_write(x,y,z) write(STDOUT_FILENO, x, y)
#endif

void main(void)
{
	pm_write(welcome, _sz(welcome), &vid_mem);
}
