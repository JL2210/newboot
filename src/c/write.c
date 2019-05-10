#include <newboot.h>

void pm_write(const char *str, size_t len, void **ptr)
{
	for( ; len != 0; len--, str++ )
		pm_putchar(*str, ptr);
}
