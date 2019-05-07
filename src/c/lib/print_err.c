#include "print.h"
#include "str.h"
#include "unix.h"

  int
print_err(const char *s)
{
  return write(2, s, str_len(s));
}
