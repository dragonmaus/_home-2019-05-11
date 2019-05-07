#!/bin/sh

. "$HOME"/lib/echo.sh

set -e

file=${XDG_DATA_HOME:-$HOME/.local/share}/x.display

test -s "$file" || die 1 "DISPLAY not set"

display=`head -1 <"$file"`

exec env "DISPLAY=$display" "$@"
