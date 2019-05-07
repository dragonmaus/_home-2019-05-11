#include "die.h"
#include "unix.h"

#define SIZE 4096

  int
main(void)
{
  char buf[SIZE];
  int e, i, j, len;

#ifdef WIN32
  setmode(0, 0x8000);
  setmode(1, 0x8000);
  setmode(2, 0x8000);
#endif

  // `e` is necessary to handle "\r\n" split across buffer boundaries
  e = 0;
  while ((len = read(0, buf, SIZE)) > 0) {
    for (i = j = 0; i < len; ++i, ++j) {
      if (e) {
        e = 0;
        if (buf[i] == '\n' && ++i >= len) break;
      }
      if (buf[i] == '\r') {
        e = 1;
        buf[j] = '\n';
      } else if (i != j) buf[j] = buf[i];
    }
    if (write(1, buf, j) == -1) die(1, "error");
  }
  if (len == -1) die(1, "error");

  _exit(0);
}
