#!/bin/sh

. "$HOME"/lib/echo.sh

pass "$@" | (
  read -r pass
  while IFS=: read -r key value; do
    case $key in
    uri)  host=${value#*://}
          host=${host%%/*} ;;
    user) user=$value ;;
    esac
  done
  test x"$host" != x && line='machine '$host
  test x"$user" != x && line=${line:+"$line "}'login '$user
  test x"$pass" != x && line=${line:+"$line "}'password '$pass
  echo -- "$line"
)
