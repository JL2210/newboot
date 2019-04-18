/* Get instruction pointer */
.globl _GetIP
_GetIP:
	push %bp
	mov %sp, %bp
	mov 2(%bp), %bx
	sub $3, %bx
	mov %bp, %sp
	pop %bp
	ret
