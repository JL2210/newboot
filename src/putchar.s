.globl bios_putchar
bios_putchar:
	STACK_INIT
	pusha
	mov 4(%bp), %ax
	mov $0x0e, %ah
	xor %bx, %bx
	int $0x10
	popa
	STACK_FINI
	ret
