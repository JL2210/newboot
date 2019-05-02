#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI leave

.code16
/* Load and jump to second stage */
.globl _start
_start:
	call _GetIP
	cld
	cmp $reloc_addr, %bx
	jne _relocate
	cli
	xor %ax, %ax
	mov %ax, %ss
	mov $0x0400, %sp
	push %cs
	pop %ds
	sti
	xor %ah, %ah
	int $0x13
	jc _error
	xor %dh, %dh
	mov $0x02, %ah
	mov $0x01, %al
	add $_stage2off, %bx
	xor %ch, %ch
	mov %ah, %cl /* A.K.A. mov $0x02, %cl */
	int $0x13
	jc _error
	cmp $0x01, %al
	jne _error
	mov %bx, %si
	add $0x01fe, %si
	mov (%si), %ax
	cmp $0xaa55, %ax
	jne _error
	jmp _stage2
#include "src/getip.s"
#include "src/error.s"
#include "src/relocate.s"
/* Fill to 512 bytes */
buf:
	. = .text + 0x01fe
/* BIOS magic number */
magic:
	.word 0xaa55
/* Next stage */
_stage2:
	_stage2off = . - _start
