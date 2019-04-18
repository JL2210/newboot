#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI mov %bp, %sp; pop %bp

.code16
.globl _start
_start:
	call _GetIP
	call bios_clear
	push $0
	call bios_setcursor
	mov %bx, %cx
	add $msgoff, %cx
	push %cx
	push $msglen
	call bios_write
	cli
	hlt
#include "src/clear.s"
#include "src/getip.s"
#include "src/setcursor.s"
#include "src/write.s"
#include "src/putchar.s"
msg:
	msgoff = . - .text
	.ascii "Boot successful!\r\n"
	msglen = . - msg
buf:
	.fill 512-(.-_start), 1, 0
