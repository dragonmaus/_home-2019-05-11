#include "char.h"

  char
char_toupper(register const char c)
{
  if (c >= 'a' && c <= 'z') return (c - ('a'-'A'));
  return c;
}
