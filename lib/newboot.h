#ifndef NEWBOOT_H
#define NEWBOOT_H 1

#include <stddef.h>

#define VIDEO_MEM 0x0b8000

/* Character, then pointer to buffer */
extern void pm_putchar(int, void **);

/* String, then size, then pointer to buffer */
extern void pm_write(const char *, size_t, void **);

#endif
