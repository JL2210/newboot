.globl pm_putchar
pm_putchar:
	push %edi
	mov 8(%esp), %eax
	mov 12(%esp), %edi
	mov (%edi), %edx
	and $0xff, %ax
	or $0x0700, %ax
	mov %ax, (%edx)
	addl $2, (%edi)
	pop %edi
	ret
