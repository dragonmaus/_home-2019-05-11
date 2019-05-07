@ECHO OFF

SETLOCAL

SET "BASE=%~DP0"
CHDIR /D "%BASE%"

SET "MAIN=%~1"
SHIFT

SET ARGS=
:LOOP
SET ARGS=%ARGS% %~1
SHIFT
IF "%~1" NEQ "" GOTO:LOOP

DEL /F /Q "%MAIN%".o >NUL 2>NUL
CALL COMPILE "%MAIN%".c
cc -static -LI:\lib -o"%MAIN%" "%MAIN%".o %ARGS%
strip "%MAIN%".exe

ENDLOCAL
