.globl bios_shutdown
bios_shutdown:
	pusha
	xor %bx, %bx
	mov $0x5301, %ax
	int $0x15
	jc error
	xor %cx, %cx
	mov $0x530e, %ax
	int $0x15
	jc error
	mov $0x5307, %ax
	inc %bx
	mov $0x03, %cx
	int $0x15
	jc error
	popa
	ret
