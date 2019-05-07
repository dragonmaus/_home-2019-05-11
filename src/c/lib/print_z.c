#include "print.h"
#include "str.h"
#include "unix.h"

  int
print_z(const char *s)
{
  int l = 0;

  l += write(1, s, str_len(s));
  if (l >= 0) l += write(1, "\0", 1);

  return l;
}
