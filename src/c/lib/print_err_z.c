#include "print.h"
#include "str.h"
#include "unix.h"

  int
print_err_z(const char *s)
{
  int l = 0;

  l += write(2, s, str_len(s));
  if (l >= 0) l += write(2, "\0", 1);

  return l;
}
