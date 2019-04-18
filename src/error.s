.globl error
error:
	mov %bx, %cx
	add $errmsgoff, %cx
	push %cx
	push $errmsglen
	call bios_write
	cli
	hlt

/* Error message */
errmsg:
	errmsgoff = . - .text
	.ascii "Error! Aborting...\r\n"
	errmsglen = . - errmsg
