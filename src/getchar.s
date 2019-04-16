.globl bios_getchar
bios_getchar:
	xor %ax, %ax
	int $0x16
	ret
