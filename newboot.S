#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI leave

.code16
#include "src/clear.s"
#include "src/error.s"
#include "src/getchar.s"
#include "src/getip.s"
#include "src/read.s"
#include "src/relocate.s"
#include "src/setcursor.s"
#include "src/shutdown.s"
#include "src/write.s"
