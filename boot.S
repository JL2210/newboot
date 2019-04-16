.code16
.globl _start
/* The code */
_start:
	call _GetIP
	mov $0x07e0, %ax
	mov %ax, %ss
	mov $0x2000, %sp
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es
	call bios_clear
	push $0
	call bios_setcursor
	add $msgoff, %cx
	push %cx
	mov %bx, %cx
	push $msglen
	call bios_write
0:	call bios_getchar
	cmp $0x1B, %al
	je 1f
	push %ax
	call bios_putchar
	jmp 0b
1:	# Do booting stuff
	call bios_shutdown
	cli
	hlt
#include "src/clear.s"
#include "src/setcursor.s"
#include "src/write.s"
#include "src/putchar.s"
#include "src/getchar.s"
#include "src/shutdown.s"
/* Get instruction pointer */
.globl _GetIP
_GetIP:
	push %bp
	mov %sp, %bp
	mov 2(%bp), %bx
	sub $3, %bx
	mov %bx, %cx
	mov %bp, %sp
	pop %bp
	ret
/* Message */
msg:
	msgoff = . - .text
	.ascii "Booting from disk... (press escape key to continue)\r\n"
	msglen = . - msg
/* Dual-purpose memory and filler */
buf:
	.fill 510-(.-_start), 1, 0
/* BIOS magic number */
magic:
	.word 0xaa55
