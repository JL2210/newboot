.globl error
error:
	STACK_INIT
	sti
	add $errmsgoff, %bx
	push %bx
	push $errmsglen
	call bios_write
	STACK_FINI
	cli
	hlt

/* Error message */
errmsg:
	errmsgoff = . - .text
	.ascii "Error! Aborting...\r\n"
	errmsglen = . - errmsg
