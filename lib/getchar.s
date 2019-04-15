.globl bios_getchar
bios_getchar:
	push %bp
	mov %sp, %bp
	xor %ax, %ax
	int $0x16
	mov %bp, %sp
	pop %bp
	ret
