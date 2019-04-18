.globl bios_read
bios_read:
	STACK_INIT
	pusha
	mov 4(%bp), %cx
	mov 6(%bp), %di
0:	cmp $0, %cx
	je 1f
	call bios_getchar
	push %ax
	call bios_putchar
	mov %al, (%di)
	inc %di
	dec %cx
	jmp 0b
1:	popa
	STACK_FINI
	ret
