#include <fcntl.h>
#include "open.h"

  int
open_read(const char *fn)
{
#ifdef WIN32
  return open(fn, O_RDONLY | O_BINARY);
#else
  return open(fn, O_RDONLY | O_NONBLOCK);
#endif
}
