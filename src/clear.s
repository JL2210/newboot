.globl bios_clear
bios_clear:
	pusha
	xor %ah, %ah
	mov $0x03, %al
	int $0x10
	mov $0x07, %ah
	mov $0xf7, %bh
	xor %cx, %cx
	mov $80-1, %dl
	mov $25-1, %dh
	int $0x10
	mov $0x01, %ah
	mov $0x2607, %cx
	int $0x10
	popa
	ret
