#include "die.h"
#include "open.h"
#include "unix.h"

  int
main(int argc, const char **argv)
{
  register int fd;

  if (!*++argv) die(1, "error");
  for (;;) {
    if ((fd = open_read(*argv)) == -1) die(1, "error");
    if (fsync(fd) == -1) die(1, "error");
    if (close(fd) == -1) die(1, "error");
    if (!*++argv) _exit(0);
  }
}
