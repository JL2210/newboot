.globl bios_clear
bios_clear:
	push %bp
	mov %sp, %bp
	pusha
	xor %ax, %ax
	mov $0x07, %ah
	mov %ah, %bh
	xor %cx, %cx
	mov $0x4f, %dl
	mov $0x18, %dh
	int $0x10
	popa
	mov %bp, %sp
	pop %bp
	ret
