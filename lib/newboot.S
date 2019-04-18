#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI mov %bp, %sp; pop %bp

.code16
#include "../src/clear.s"
#include "../src/getchar.s"
#include "../src/getip.s"
#include "../src/putchar.s"
#include "../src/read.s"
#include "../src/setcursor.s"
#include "../src/shutdown.s"
#include "../src/write.s"
