#include "print.h"
#include "str.h"
#include "unix.h"

  int
print_ln(const char *s)
{
  int l = 0;

  l += write(1, s, str_len(s));
  if (l >= 0) l += write(1, "\n", 1);

  return l;
}
