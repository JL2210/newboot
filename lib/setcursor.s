.globl bios_setcursor
bios_setcursor:
	push %bp
	mov %sp, %bp
	pusha
	mov 4(%bp), %dx
	mov $0x02, %ah
	xor %bh, %bh
	int $0x10
	popa
	mov %bp, %sp
	pop %bp
	ret
