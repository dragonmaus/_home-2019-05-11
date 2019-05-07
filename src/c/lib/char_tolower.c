#include "char.h"

  char
char_tolower(register const char c)
{
  if (c >= 'A' && c <= 'Z') return (c + ('a'-'A'));
  return c;
}
