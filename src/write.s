.globl bios_write
bios_write:
	push %bp
	mov %sp, %bp
	pusha
	mov 4(%bp), %cx
	mov 6(%bp), %si
0:	lodsb
	cmp $0, %cx
	je 1f
	push %ax
	call bios_putchar
	pop %ax
	dec %cx
	jmp 0b
1:	popa
	mov %bp, %sp
	pop %bp
	ret
