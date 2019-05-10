#include <newboot.h>

size_t pm_write(const char *str, size_t len, void **ptr)
{
	size_t ctr = len;
	for( ; ctr != 0; ctr--, str++ )
		pm_putchar(*str, ptr);
	return len;
}
