#!/bin/sh

window=
while getopts fr opt; do
  case $opt in
  f) window=$(xdotool getwindowfocus -f) ;;
  r) window=root ;;
  *) break ;;
  esac
done
shift $(expr $OPTIND - 1)

exec import ${window+-window "$window"} "$@" "$HOME"/Pictures/Screenshots/$(date -u +%FT%TZ).png
