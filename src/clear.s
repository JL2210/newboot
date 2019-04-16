.globl bios_clear
bios_clear:
	pusha
	mov $0x07, %ah
	mov %ah, %bh
	xor %cx, %cx
	mov $0x4f, %dl
	mov $0x18, %dh
	int $0x10
	popa
	ret
