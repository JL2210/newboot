#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI leave

	VIDEO_MEM = 0x0b8000

/* Stage 2 */
.code16
	jmp _start
gdt_start:
        .quad 0
gdt_code:
        .word 0xffff # Segment limit
        .word 0 # Base
        .byte 0 # Base cont.
        .byte 0b10011010 # Access -- RX
        .byte 0b11001111
        .byte 0
gdt_data:
        .word 0xffff
        .word 0
        .byte 0
        .byte 0b10010010 # RW
        .byte 0b11001111
        .byte 0
gdt_end:
        CODE_SEG = gdt_code - gdt_start
        DATA_SEG = gdt_data - gdt_start
gdt_pointer:
        .word gdt_end - gdt_start
        .long gdt_start
	.byte 0 # Fix objdump output
.globl _start
_start:
	mov $0x2401, %ax
	int $0x15
	jc _error
	call bios_clear
	push $0
	call bios_setcursor
	pop %ax
	mov $0x02, %ah
	mov $0x20, %al
	mov $_end, %bx
	xor %cx, %cx
	mov %cx, %es
	mov $0x03, %cl
	int $0x13
	jc _error
	cli
	lgdt gdt_pointer
	mov %cr0, %eax
	or $0x01, %eax
	mov %eax, %cr0
	ljmp $CODE_SEG, $_enter_pm
#include "src/clear.s"
#include "src/error.s"
#include "src/setcursor.s"
.code32
_enter_pm:
	mov $DATA_SEG, %ax
	mov %ax, %ds
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss
	mov %ax, %es
	jmp _end
	hlt
buf:
	. = .text + 0x01fe
magic:
	.word 0xaa55
_end:
        xor %ebp, %ebp
        and $-16, %esp
        call _start_c
