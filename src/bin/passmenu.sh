#!/bin/sh

. "$HOME"/lib/echo.sh

set -e

name=$(basename "$0")
args=Uhtu
usage="Usage: $name [-$args] [-- [dmenu args]]"
help=$usage'

  -U   output the URI field (if any)
  -c   copy the output instead of printing it
  -h   display this help
  -t   type the output instead of printing it
  -u   output the user field (if any)
'

args=$(getopt -n "$name" -s sh "$args$optargs" "$@") || die 100 "$usage"
eval set -- "$args"

filter=1p
mode=show
while test $# -gt 0; do
  case $1 in
  -U) filter='s/^uri://p' ;;
  -c) mode=copy ;;
  -h) die 0 "$help" ;;
  -t) mode=type ;;
  -u) filter='s/^user://p' ;;
  --) shift
      break ;;
  *)  break ;;
  esac
  shift
done

echo $#
echo -- "$@"

prefix=${PASSWORD_STORE_DIR:-$HOME/.password-store}
password=$( (cd "$prefix" && find . -not '(' -name '.[!.]*' -prune ')' -type f) | sed -En 's:^\./(.+)\.gpg$:\1:p' | pathsort -u | dmenu "$@" )
test x"$password" != x
selection=${PASSWORD_STORE_X_SELECTION:-clipboard}

case $mode in
copy) pass show "$password" | sed -n "$filter" | xclip -i -selection "$selection" ;;
show) pass show "$password" | sed -n "$filter" ;;
type) pass show "$password" | sed -n "$filter" | (IFS= read -r pass; echo -n -- "$pass") | xdotool type --clearmodifiers --file - ;;
esac
