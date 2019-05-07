#!/bin/sh

. "$HOME"/lib/echo.sh

prompt=$(echo -- $1)
shift

temp=$(mktemp -d)
chmod 700 "$temp"
rm -f "$temp"/pipe
mkfifo -m 600 "$temp"/pipe

sed -n 's/^D //p' <"$temp"/pipe &
exec >"$temp"/pipe

rm -f "$temp"/pipe
rmdir "$temp"

exec pinentry-smart <<END
OPTION lc-ctype=${LC_ALL:-${LC_CTYPE:-${LANG:-C}}}
OPTION ttyname=$(tty)
OPTION ttytype=$TERM
SETDESC $*
SETPROMPT ${prompt:-Password:}
GETPIN
END
