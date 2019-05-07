#ifndef UNIX_H
#define UNIX_H

void  _exit(int);
int   chdir(const char *);
int   close(int);
int   execl(const char *, const char *, ...);
int   execle(const char *, const char *, ...);
int   execlp(const char *, const char *, ...);
int   execlpe(const char *, const char *, ...);
int   execv(const char *, const char *const *);
int   execve(const char *, const char *const *, const char *const *);
int   execvp(const char *, const char *const *);
int   execvpe(const char *, const char *const *, const char *const *);
#ifndef WIN32
int   fsync(int);
#endif
char *getcwd(char *, int);
int   open(const char *, int, ...);
int   read(int, void *, unsigned int);
int   setmode(int, int);
int   write(int, const void *, unsigned int);

#endif
