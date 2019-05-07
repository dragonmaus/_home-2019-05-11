#include "option.h"
#include "print.h"

char *option_arg;
int option_index = 1;
char option_error;
static int point = 0;

typedef enum {
  NOT_OPTION,
  OPTION,
  ARG_OPTION,
} scan_result;

  static scan_result
scan_optstring(const char *optstring, const char opt)
{
  int i;

  for (i = 0; optstring[i]; ++i) {
    if (optstring[i] == opt) {
      if (optstring[i+1] == ':') {
        return ARG_OPTION;
      }
      return OPTION;
    }
  }
  return NOT_OPTION;
}

  char
option_next(int argc, const char **argv, const char *optstring)
{
  char opt;

  if (point == 0) {
    if (!argv[option_index] || argv[option_index][0] != '-' || !argv[option_index][1]) {
      return -1;
    }

    if (argv[option_index][1] == '-' && !argv[option_index][2]) {
      ++option_index;
      point = 0;
      return -1;
    }

    ++point;
  }

  opt = argv[option_index][point++];

  switch (scan_optstring(optstring, opt)) {
    case OPTION:
      if (!argv[option_index][point]) {
        ++option_index;
        point = 0;
      }
      return opt;
    case ARG_OPTION:
      if (argv[option_index][point]) {
        option_arg = (char *)(argv[option_index] + point);
      } else {
        option_arg = (char *)argv[++option_index];
        if (!option_arg) {
          option_error = opt;
          if (optstring[0] == ':') {
            return ':';
          } else {
            return '?';
          }
        }
      }
      ++option_index;
      point = 0;
      return opt;
    default:
      option_error = opt;
      return '?';
  }
}
