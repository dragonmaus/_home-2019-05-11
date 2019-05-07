#include "die.h"
#include "print.h"
#include "unix.h"

  void
die(int c, const char *m)
{
  if (print_err_ln(m) == -1) _exit(c << 1);
  _exit(c);
}
