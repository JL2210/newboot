.globl error
error:
	add $errmsgoff, %bx
	push %bx
	push $errmsglen
	call bios_write
	cli
	hlt

/* Error message */
errmsg:
	errmsgoff = . - .text
	.ascii "Error! Aborting...\r\n"
	errmsglen = . - errmsg
