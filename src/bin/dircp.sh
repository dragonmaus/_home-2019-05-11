#!/bin/sh

set -e

mkdir -p "$2"

(cd "$1"; exec find . -print0) |
(cd "$1"; exec bsdtar -cn -f - -T - --no-fflags --no-xattrs --null) |
(cd "$2"; exec bsdtar -xp -f - --no-fflags --no-xattrs)
