#include <newboot.h>

size_t pm_write(const char *str, size_t len, int color)
{
	size_t ctr = len;
	for( ; ctr != 0; ctr--, str++ )
		pm_putchar(*str, color);
	return len;
}

size_t write(const char *str, size_t len)
{
	return pm_write(str, len, COLOR);
}
