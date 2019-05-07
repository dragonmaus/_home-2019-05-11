@ECHO OFF

SETLOCAL

SET "BASE=%~DP0"
CHDIR /D "%BASE%"

cc -II:\inc -c %*

ENDLOCAL
