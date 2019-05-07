#!/bin/sh

. "$HOME"/lib/echo.sh

set -e

repo=$(while :; do test -d .pijul && pwd -P && exit; test . -ef .. && exit; cd ..; done)
test x"$repo" = x && exit 1
file=$repo/.ignore

test -f "$file" || touch "$file"
rm -f "$file"{tmp}
for f do echo -- "$f"; done | cat - "$file" | sort -u >"$file"{tmp}
rm -f "$file"{new}
(grep -v '^!' <"$file"{tmp} || :; grep '^!' <"$file"{tmp} || :) >"$file"{new}
rm -f "$file"{tmp}
fsync "$file"{new}
cmp -s "$file" "$file"{new} || cp -f "$file"{new} "$file"
rm -f "$file"{new}
