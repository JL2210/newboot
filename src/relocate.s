	reloc_addr = 0x0600

/* Relocate the bootloader to a different address */
.globl _relocate
_relocate:
	cld
        mov $0x100, %cx
        xor %ax, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %bx, %si
        mov $reloc_addr, %di
        rep movsw
        jmp reloc_addr
