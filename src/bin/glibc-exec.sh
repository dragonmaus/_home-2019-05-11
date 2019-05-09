#!/bin/mksh

cmd=${0##*/}

while [[ $(glibc which "$cmd") -ef $0 ]]; do
  p=${PATH%%:*}
  export PATH=${PATH#$p:}:$p
done

exec glibc "$cmd" "$@"
