#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI leave

.code16
/* The code */
.globl _start
_start:
	call _GetIP
	cld
	cmp $_start, %bx
	je relocate
	cli
	mov %bx, %ax
	add $0x0400, %ax
	shr $4, %ax
	mov %ax, %ss
	mov $0x2000, %sp
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es
	sti
	call bios_clear
	push $0
	call bios_setcursor
	pop %ax
	mov %bx, %cx
	add $msgoff, %cx
	push %cx
	push $msglen
	call bios_write
	pop %ax
	pop %ax
0:	call bios_getchar
	cmp $0x1b, %al
	je 1f
	push %ax
	call bios_putchar
	pop %ax
	jmp 0b
1:	call bios_clear
	push $0
	call bios_setcursor
	pop %ax
	xor %ah, %ah
	int $0x13
	jc error
	xor %dh, %dh
	mov $0x02, %ah
	mov $0x01, %al
	add $_stage2off, %bx
	xor %ch, %ch
	mov %ah, %cl /* A.K.A. mov $0x02, %cl */
	int $0x13
	jc s2error
	sub $_stage2off, %bx
	cmp $0x01, %al
	jne error
	mov %bx, %si
	add $_stage2off+0x01fe, %si
	mov (%si), %ax
	cmp $0xaa55, %ax
	jne error
	jmp _stage2
#include "src/clear.s"
#include "src/getchar.s"
#include "src/getip.s"
#include "src/setcursor.s"
#include "src/write.s"
#include "src/putchar.s"
#include "src/error.s"
/*'sub' sets CF */
s2error:
	sub $_stage2off, %bx
	jmp error
	cli
	hlt
/* Relocate the bootloader to a different address */
relocate:
	mov $0x100, %cx
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %bx, %si
	mov %bx, %di
	sub $0x0200, %di
	rep movsw
	jmp %ds:_start-0x0200
	cli
	hlt
/* Message */
msg:
	msgoff = . - _start
	.ascii "Press ESC to continue with boot\r\n"
	msglen = . - msg
/* Padding */
buf:
	bufoff = . - _start
	.fill 0x01fe-(.-_start), 1, 0
/* BIOS magic number */
magic:
	magicoff = . - magic
	.word 0xaa55
_stage2:
	_stage2off = . - _start
