.globl pm_putchar
pm_putchar:
	push %edi
	mov 8(%esp), %ax
	mov 10(%esp), %edi
	mov (%edi), %edx
	and $0xff, %eax
	or $0x0700, %eax
	mov %ax, (%edx)
	addl $2, (%edi)
	pop %edi
	ret
