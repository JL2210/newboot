.globl _init_c
_init_c:
	xor %ebp, %ebp
	and $-16, %esp
	call _start_c
