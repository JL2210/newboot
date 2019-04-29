	reloc_addr = 0x7a00

/* Relocate the bootloader to a different address */
_relocate:
        mov $0x100, %cx
        xor %ax, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %bx, %si
        mov $reloc_addr, %di
        rep movsw
        jmp reloc_addr
