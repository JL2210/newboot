.globl _init_c
_init_c:
	xor %ebp, %ebp
	and $-16, %esp
	push %esp
	push %ss
	call _start_c
	jmp .
