.globl bios_clear
bios_clear:
	pusha
	xor %ah, %ah
	mov $0x02, %al
	int $0x10
	popa
	ret
