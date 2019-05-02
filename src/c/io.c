#include <newboot.h>

unsigned char inb(unsigned short port)
{
	unsigned char result;
	asm volatile("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}

void outb(unsigned short port, unsigned char val)
{
	asm volatile("out %%al, %%dx" : : "d" (port), "a" (val));
}
