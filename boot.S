#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI mov %bp, %sp; pop %bp

.code16
/* The code */
.globl _start
_start:
	call _GetIP
	mov %bx, %ax
	add $0x200, %ax
	shr $4, %ax
	mov %ax, %ss
	mov $0x2000, %sp
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es
	call bios_clear
	push $0
	call bios_setcursor
	mov %bx, %cx
	add $msgoff, %cx
	push %cx
	push $msglen
	call bios_write
0:	call bios_getchar
	cmp $0x1B, %al
	je 1f
	push %ax
	call bios_putchar
	jmp 0b
1:	xor %ah, %ah
	int $0x13
	jc error
	xor %dh, %dh
	mov $0x02, %ah
	mov $0x01, %al
	add $endoff, %bx
	xor %ch, %ch
	mov $2, %cl
	int $0x13
	jc error
	jmp end
	cli
	hlt
#include "src/clear.s"
#include "src/getchar.s"
#include "src/getip.s"
#include "src/setcursor.s"
#include "src/write.s"
#include "src/putchar.s"
#include "src/error.s"
/* Message */
msg:
	msgoff = . - .text
	.ascii "Press ESC to continue with boot\r\n"
	msglen = . - msg
/* Padding */
buf:
	bufoff = . - .text
	.fill 510-(.-_start), 1, 0
/* BIOS magic number */
magic:
	.word 0xaa55
end:
	endoff = . - .text
