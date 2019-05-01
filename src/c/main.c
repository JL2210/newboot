#include <newboot.h>

void *vid_mem = (void *)0x0b8000;
extern void *stack_top;

#define _sz(x) sizeof(x)-1
#define hello "Hello, World!"

void main(void)
{
	pm_write(hello, _sz(hello), &vid_mem);
}
