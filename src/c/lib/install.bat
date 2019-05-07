@ECHO OFF

SETLOCAL

SET "BASE=%~DP0"
CHDIR /D "%BASE%"

MKDIR I:\inc >NUL 2>NUL
COPY /Y *.h I:\inc >NUL 2>NUL

CALL COMPILE *.c
CALL MAKELIB libcore.a *.o
MKDIR I:\lib >NUL 2>NUL
COPY /Y *.a I:\lib >NUL 2>NUL

ENDLOCAL
