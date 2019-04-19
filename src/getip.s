/* Get instruction pointer */
.globl _GetIP
_GetIP:
	STACK_INIT
	mov 2(%bp), %bx
	sub $3, %bx
	STACK_FINI
	ret
