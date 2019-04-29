#include <newboot.h>
#include <stddef.h>

void *stack_cur = NULL;
void *stack_begin = NULL;

void _start_c(void *sp, void *ss)
{
	int ctr = 0;
	const char string[] = " is a very large number.";
	stack_cur = sp;
	stack_begin = ss;
	for( ctr = '0'; ctr <= '9'; ctr++ )
	{
		pm_putchar(ctr);
	}
	pm_write(string, sizeof(string));
}
