#ifndef NEWBOOT_H
#define NEWBOOT_H 1

#include <stddef.h>
#include <stdint.h>

#define VIDEO_MEM 0x0b8000

/* Character, then pointer to buffer */
extern void pm_putchar(int, void **);

/* String, then size, then pointer to buffer */
extern void pm_write(const char *, size_t, void **);

/* Array of ASCII characters corresponding to scancodes */
extern int pm_getchar(uint8_t []);

/* Nothing */
extern int pm_getsc(void);

/* Port number */
extern unsigned char inb(unsigned short);

/* Port number and value */
extern void outb(unsigned short, unsigned char);

/* Nothing */
extern void keyboard_init(void);

/* Array of keyboard scancode (set 1) to ASCII character table */
extern uint8_t kbd_sc[];

/* Pointer to current video memory location */
extern void *vid_mem;

#endif
