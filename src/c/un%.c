#include "die.h"
#include "unix.h"

#define SIZE 4096

  static int
dehex(char c)
{
  if (c >= '0' && c <= '9') return c - '0' + 0x0;
  if (c >= 'A' && c <= 'F') return c - 'A' + 0xA;
  if (c >= 'a' && c <= 'f') return c - 'a' + 0xa;
  return -1;
}

  int
main(void)
{
  char buf[SIZE];
  int c, i, j, k, len, stage;

#ifdef WIN32
  setmode(0, 0x8000);
  setmode(1, 0x8000);
  setmode(2, 0x8000);
#endif

  // handle %XX sequences that cross buffer boundaries
  stage = 0;
  while ((len = read(0, buf, SIZE)) > 0) {
    i = j = 0;
    while (i < len) switch (stage) {
      case 0:
        if (buf[i] == '%') {
          ++stage;
          ++i;
          continue;
        }
        if (i != j) buf[j] = buf[i];
        ++i;
        ++j;
        continue;
      case 1:
        if ((k = dehex(buf[i++])) == -1) die(1, "error");
        ++stage;
        if (i >= len) continue;
      case 2:
        if ((c = dehex(buf[i++])) == -1) die(1, "error");
        buf[j++] = (char)(k * 0x10 + c);
        stage = 0;
        continue;
    }
    if (write(1, buf, j) == -1) die(1, "error");
  }
  if (len == -1) die(1, "error");
  _exit(0);
}
