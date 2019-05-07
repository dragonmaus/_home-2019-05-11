#include "die.h"
#include "unix.h"

#define SIZE 4096
#define SIZEB 12288

  static int
special(char c)
{
  if (c == '\n') return 0;
  if (c == '-') return 0;
  if (c == '_') return 0;
  if (c >= '0' && c <= '9') return 0;
  if (c >= 'A' && c <= 'Z') return 0;
  if (c >= 'a' && c <= 'z') return 0;
  return 1;
}

  static int
enhex(char c)
{
  if (c >= 0x0 && c <= 0x9) return c - 0x0 + '0';
  if (c >= 0xA && c <= 0xF) return c - 0xA + 'A';
  return -1;
}

  int
main(void)
{
  char ibuf[SIZE];
  char obuf[SIZEB];
  int i, j, k, len;

#ifdef WIN32
  setmode(0, 0x8000);
  setmode(1, 0x8000);
  setmode(2, 0x8000);
#endif

  while ((len = read(0, ibuf, SIZE)) > 0) {
    for (i = j = 0; i < len; ++i, ++j) {
      if (special(ibuf[i])) {
        obuf[j] = '%';
        if ((k = enhex((ibuf[i] & 0xF0) / 0x10)) == -1) die(1, "error");
        obuf[++j] = (char)k;
        if ((k = enhex(ibuf[i] & 0x0F)) == -1) die(1, "error");
        obuf[++j] = (char)k;
      } else obuf[j] = ibuf[i];
    }
    if (write(1, obuf, j) == -1) die(1, "error");
  }
  if (len == -1) die(1, "error");
  _exit(0);
}
