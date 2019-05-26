#include <newboot.h>

extern int main();

void _start_c()
{
	/* TODO: Run more initialization */
	int ret = main();
	(void)ret;
	for(;;);
}
