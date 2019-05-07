#!/bin/sh

. "$HOME"/lib/echo.sh

PINENTRY_GUI=/usr/bin/pinentry-dmenu
PINENTRY_TTY=/usr/bin/pinentry-tty

name=$(basename "$0")
usage="Usage: $name [options] (-h for help)"
help=$(pinentry-tty --help 2>/dev/null | sed "s/pinentry-tty/$name/g")

args=$(getopt \
  -l colors:,debug,display:,help,lc-ctype:,lc-messages:,no-global-grab \
  -l parent-wid:,timeout:,ttyalert:,ttyname:,ttytype: \
  -n "$name" \
  -o C:D:M:N:T:W:a:c:dgo: \
  -s sh \
  -- "$@") || die 100 "$usage"
eval set -- "$args"

while test $# -gt 0; do
  case $1 in
  -C|--lc-ctype)
    shift ;;
  -D|--display)
    export DISPLAY=$2
    shift ;;
  -M|--lc-messages)
    shift ;;
  -N|--ttytype)
    shift ;;
  -T|--ttyname)
    shift ;;
  -W|--parent-wid)
    shift ;;
  -a|--ttyalert)
    shift ;;
  -c|--colors)
    shift ;;
  -d|--debug)
    ;;
  -g|--no-global-grab)
    ;;
  -h|--help)
    die 0 "$help" ;;
  -o|--timeout)
    shift ;;
  --)
    shift
    break ;;
  *)
    break ;;
  esac
  shift
done

eval set -- "$args"

if test x"$DISPLAY" != x; then
  exec "$PINENTRY_GUI" "$@"
fi

exec "$PINENTRY_TTY" "$@"
