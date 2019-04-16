.globl bios_putchar
bios_putchar:
	push %bp
	mov %sp, %bp
	pusha
	mov 4(%bp), %ax
	mov $0x0e, %ah
	xor %bx, %bx
	int $0x10
	popa
	mov %bp, %sp
	pop %bp
	ret
