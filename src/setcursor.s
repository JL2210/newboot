.globl bios_setcursor
bios_setcursor:
	push %bp
	mov %sp, %bp
	pusha
	mov 4(%bp), %dx
	xor %bh, %bh
	mov $0x02, %ah
	int $0x10
	popa
	mov %bp, %sp
	pop %bp
	ret
