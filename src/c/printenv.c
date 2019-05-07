#ifdef WIN32
#include "char.h"
#endif
#include "option.h"
#include "print.h"
#include "unix.h"

static const char *help = "\
Usage: printenv [-hz] [name …]\n\
  -h   display this help\n\
  -z   terminate lines with null instead of newline\n\
";

  static const char *
check_env(register const char *e, register const char *k)
{
  if (!k || !e) return 0;

  for (;;) {
    if (!*k) break;
#ifdef WIN32
    if (char_tolower(*k++) != char_tolower(*e++)) return 0;
#else
    if (*k++ != *e++) return 0;
#endif
  }

  if (*e != '=') return 0;

  return ++e;
}

  static const char *
scan_env(const char **envp, const char *key)
{
  const char *v;

  for (;;) {
    v = check_env(*envp, key);

    if (v) return v;

    if (!*++envp) return 0;
  }
}

  int
main(const int argc, const char **argv, const char **envp)
{
  int zero = 0;
  char opt;

#ifdef WIN32
  setmode(1, 0x8000);
  setmode(2, 0x8000);
#endif

  while ((opt = option_next(argc, argv, "hz")) != -1) {
    switch (opt) {
      case 'h':
        print_err(help);
        _exit(0);
      case 'z':
        zero = 1;
        break;
      case '?':
        print_err("printenv: Unknown option '");
        write(2, &option_error, 1);
        print_err_ln("'");
        _exit(1);
    }
  }

  if (option_index < argc) {
    int i;
    const char *value;

    for (i = option_index; i < argc; ++i) {
      value = scan_env(envp, argv[i]);

      if (value) {
        if (zero) print_z(value);
        else print_ln(value);
      }
    }

    return 0;
  }

  while (*envp) {
    if (zero) print_z(*envp);
    else print_ln(*envp);
    ++envp;
  }

  return 0;
}
