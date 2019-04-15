#include "newboot.h"
#include <sys/syscall.h>

#ifndef ENOSYS
# define ENOSYS 38
#endif

int16_t bios_syscall(
int16_t syscall,
int16_t a,
int16_t b,
int16_t c,
int16_t d,
int16_t e,
int16_t f)
{
	switch(syscall)
	{
		case SYS_read:
			return bios_read(b, c);
			break;
		case SYS_write:
			return bios_write(b, c);
			break;
		case SYS_exit:
			/* Run in this order:
			 * 1. DOS 2+ (exit code)
			 * 2. DOS 1+ (terminate)
			 * 3. Assembly (clear interrupt flag and halt)
			 */
			asm("mov %0, %%ax" : : "r" (a) : "%al");
			asm("mov $0x4c, %%ah" : : : "%ah");
			asm("int $0x21");
			asm("mov $0, %%ax" : : : "%ax");
			asm("int $0x21");
			asm("cli");
			asm("hlt");
			break;
		default:
			return -ENOSYS;
	}
}
