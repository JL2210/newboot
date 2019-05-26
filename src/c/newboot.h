#ifndef NEWBOOT_H
#define NEWBOOT_H 1

#include <stddef.h>
#include <stdint.h>

#define VIDEO_MEM 0x0b8000
#define LIGHT_GRAY 0x07
#define WHITE 0x0f
#define BLACK 0x00
#define COLOR (vga_color(BLACK, LIGHT_GRAY))
#define COLUMNS 80
#define ROWS 25

#ifndef __GNUC__
# define __attribute__(x) /* */
#endif
#define FORCE_INLINE __attribute__((__always_inline__))

/* Character, then color */
extern int pm_putchar(int, int);

/* Character */
extern int putchar(int);

/* String, then size, then color */
extern size_t pm_write(const char *, size_t, int);

/* String, then size */
extern size_t write(const char *, size_t);

/* Color */
extern void pm_clear(int);

/* Nothing */
extern void clear(void);

/* Pointer to current video memory location */
extern volatile short *vid_mem;

/* X-position */
extern int x;

/* Y-position */
extern int y;

/* Nothing */
static inline FORCE_INLINE int get_vid_pos(void)
{
	return (y * COLUMNS) + x;
}

/* background color, foreground color */
static inline FORCE_INLINE int vga_color(int bg, int fg)
{
	return (bg << 12) | (fg << 8);
}

#endif
