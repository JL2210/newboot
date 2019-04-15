.code16
.globl _start
_start:
	mov $0x07e0, %ax
	mov %ax, %ss
	xor %ax, %ax
	mov $0x2000, %sp
	push %cs
	pop %ds
	call bios_clear
	push $0
	call bios_setcursor
	push $msg1
	push $msg1len
	call bios_write
	push $msg2
	push $msg2len
	call bios_write
0:	call bios_getchar
	push %ax
	call bios_putchar
	jmp 0b
	cli
	hlt
#include "lib/clear.s"
#include "lib/setcursor.s"
#include "lib/write.s"
#include "lib/putchar.s"
#include "lib/read.s"
#include "lib/getchar.s"
msg1:
	.ascii "Booting from disk..."
	msg1len = . - msg1
msg2:
	.ascii " Done!\r\n"
	msg2len = . - msg2
buf:
	.fill 510-(.-_start), 1, 0
magic:
	.word 0xaa55
