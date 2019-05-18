#include <newboot.h>

volatile short *vid_mem = (volatile short *)VIDEO_MEM;

#define length(x) sizeof(x)-1
const char welcome[] = "\t\tWelcome to the strange land of protected mode!\r\n";

int main(void)
{
	clear(B_BLACK | LIGHT_GRAY, &vid_mem);
	pm_write(welcome, length(welcome), B_BLACK | LIGHT_GRAY, &vid_mem);
	return 0;
}
