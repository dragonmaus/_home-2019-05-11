#define _GNU_SOURCE

#include <sched.h>
#include <stdio.h>
#include <sys/mount.h>
#include <unistd.h>

#define e(n,f) if ((f) == -1) { perror(n); return 1; }
#define SRC "/glibc"

int main(int argc, const char **argv) {
  const char *shell[] = { "/bin/sh", NULL };

  // move glibc stuff in place
  e("unshare", unshare(CLONE_NEWNS));
  e("mount /usr", mount(SRC "/usr", "/usr", NULL, MS_BIND, NULL));
  e("mount /var/db/xbps", mount(SRC "/var/db/xbps", "/var/db/xbps", NULL, MS_BIND, NULL));

  // drop the rights suid gave us
  e("setuid", setreuid(getuid(), getuid()));
  e("setgid", setregid(getgid(), getgid()));

  if (!*++argv) argv = shell;
  e("execvp", execvp(*argv, argv));
}
