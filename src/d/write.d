import lib.newboot;

extern(C):

size_t pm_write(string str, size_t len, int color, shared(short) **ptr)
{
	size_t ctr = len;
	immutable(char)* tmp_str = str.ptr;
	for( ; ctr != 0; ctr--, tmp_str++ )
		pm_putchar(*tmp_str, color, ptr);
	return len;
}
