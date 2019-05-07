#!/bin/sh

set -e

conf=$HOME/etc/wallpaper
dest=$HOME/Pictures/Wallpapers/digitalblasphemy
dist=$HOME/Downloads
temp=$HOME/tmp/wallpaper

while read -u3 res suf; do
  dir=$dest/$res
  zip=$dist/$res.zip

  test -e "$zip" || continue

  mkdir -pv "$dir"
  find "$dir" -type f -print0 | xargs -0r chmod 755

  rm -fr "$temp"
  mkdir -p "$temp"

  (
    cd "$temp"
    7z x "$zip"

    find . -type f -print0 | xargs -0r chmod 644

    sed "s/$/$suf.jpg/" <"$conf"/black.list | xargs -r rm -f 2>/dev/null || :
    sed "s/$/$suf.jpg/" <"$conf"/white.list | xargs -r mv -f -t "$dir" 2>/dev/null || :

    for file in *$suf.jpg; do
      test -e "$file" || continue

      name=${file%$suf.jpg}

      pid=
      if test x"$DISPLAY" != x; then
        feh -. "$file" & pid=$!
      fi

      while :; do
        printf "Keep '%s'? (y/n): " "$name" 1>&2
        read keep
        case $keep in
          [Yy]*)
            mv -fv -t "$dir" "$file"
            echo "$name" >>"$conf"/white.list+
            break
            ;;
          [Nn]*)
            rm -fv "$file"
            echo "$name" >>"$conf"/black.list+
            break
            ;;
        esac
      done
      test x"$pid" = x || kill $pid || :
    done
  )

  rm -fr "$temp"

  find "$dir" -type f -perm 755 -print0 | xargs -0r rm -fv

  for i in black white; do
    list=$conf/$i.list

    if test -e "$list"+; then
      cat "$list" "$list"+ | sort -u >"$list".new
      rm -f "$list"+
      diff -u "$list" "$list".new | cdiff
      mv -fv "$list".new "$list"
    fi
  done
done 3<"$conf"/res.list
