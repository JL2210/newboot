extern(C):

extern int main();

void _start_c()
{
	/* TODO: Run more initialization */
	int ret = main();
	for(;;) { }
}

void _d_dso_registry(void *ignore)
{
}
