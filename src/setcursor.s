.globl bios_setcursor
bios_setcursor:
	STACK_INIT
	pusha
	mov 4(%bp), %dx
	xor %bh, %bh
	mov $0x02, %ah
	int $0x10
	popa
	STACK_FINI
	ret
