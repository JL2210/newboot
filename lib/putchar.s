.globl bios_putchar
bios_putchar:
	push %bp
	mov %sp, %bp
	mov 4(%bp), %ax
	mov $0x0e, %ah
	xor %bx, %bx
	int $0x10
	xor %ah, %ah
	mov %bp, %sp
	pop %bp
	ret
