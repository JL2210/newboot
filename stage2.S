#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI leave

/* Stage 2 */
.code16
	jmp _start
	. = 0x57 + .text
.globl _start
_start:
	call _GetIP
	call bios_clear
	push $0
	call bios_setcursor
	pop %ax
	mov %bx, %ax
	add $msgoff, %ax
	push %ax
	push $msglen
	call bios_write
	pop %ax
	pop %ax
	cli
	hlt

#include "src/clear.s"
#include "src/getip.s"
#include "src/setcursor.s"
#include "src/write.s"
msg:
	msgoff = . - _start
	.ascii "Stage 2 loaded successfully.\r\n"
	msglen = . - msg
buf:
	.fill 0x01fe-(.-.text), 1, 0
magic:
	.word 0xaa55
