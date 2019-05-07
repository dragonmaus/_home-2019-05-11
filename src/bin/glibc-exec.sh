#!/bin/sh
cmd=$(glibc which -a "${0##*/}" | grep -Fvx "$0" | sed 1q)
exec glibc "$cmd" "$@"
