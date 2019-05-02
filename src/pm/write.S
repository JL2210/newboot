.globl pm_write
pm_write:
	push %esi
	push %edi
	mov 12(%esp), %esi
	mov 16(%esp), %ecx
	mov 20(%esp), %edi
0:	or %ecx, %ecx
	jz 1f
	lodsb
	push %edx
	push %edi
	push %eax
	call pm_putchar
	pop %eax
	pop %eax
	pop %edx
	dec %ecx
	jmp 0b
1:	pop %edi
	pop %esi
	ret
#include "putchar.s"
