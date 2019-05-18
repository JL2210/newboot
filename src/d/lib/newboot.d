module lib.newboot;

extern(C):

enum VIDEO_MEM = 0x0b8000;
enum B_LIGHT_GRAY = 0x7000;
enum LIGHT_GRAY = 0x0700;
enum B_WHITE = 0xf000;
enum WHITE = 0x0f00;
enum B_BLACK = 0x0000;
enum BLACK = 0x0000;
enum COLUMNS = 80;
enum ROWS = 25;

/* Character, then color, then pointer to buffer */
extern int pm_putchar(int, int, shared(short) **);

/* String (immutable char array), then size, then color, then pointer to buffer */
extern size_t pm_write(string, size_t, int, shared(short) **);

/* Color */
extern void clear(int, shared(short) **);

/* Pointer to current video memory location */
extern short *vid_mem;
