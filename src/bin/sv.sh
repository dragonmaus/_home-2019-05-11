#!/bin/sh
case $(id -u) in
0) exec /usr/bin/sv "$@" ;;
*) exec env "SVDIR=$HOME/etc/runit/runsvdir" /usr/bin/sv "$@" ;;
esac
