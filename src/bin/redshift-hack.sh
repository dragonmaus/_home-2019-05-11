#!/bin/sh

. "$HOME"/.secret/coords.sh

exec redshift -l "$latitude:$longitude" "$@"
