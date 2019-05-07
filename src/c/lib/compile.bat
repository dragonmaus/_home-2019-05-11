@ECHO OFF

SETLOCAL

SET "BASE=%~DP0"
CHDIR /D "%BASE%"

cc -I. -c %*

ENDLOCAL
