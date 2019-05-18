#ifndef NEWBOOT_H
#define NEWBOOT_H 1

#include <stddef.h>
#include <stdint.h>

#define VIDEO_MEM 0x0b8000
#define B_LIGHT_GRAY 0x7000
#define LIGHT_GRAY 0x0700
#define B_WHITE 0xf000
#define WHITE 0x0f00
#define B_BLACK 0x0000
#define BLACK 0x0000
#define COLUMNS 80
#define ROWS 25

/* Character, then color, then pointer to buffer */
extern int pm_putchar(int, int, volatile short **);

/* String, then size, then color, then pointer to buffer */
extern size_t pm_write(const char *, size_t, int, volatile short **);

/* Color */
extern void clear(int, volatile short **);

/* Pointer to current video memory location */
extern volatile short *vid_mem;

#endif