#!/bin/sh

set -e

log() {
  printf '%s\n' "$*" 1>&2
}

dst=/mnt/frame
src=$HOME/Pictures/Wallpapers/digitalblasphemy/1600x1200

umount "$dst" 2>/dev/null || :
mount "$dst" || {
  log "Could not mount $dst"
  exit 111
}

log "Cleaning up $dst"
ls -rt "$dst" | while read file; do
  name=${file#????-}
  test -e "$src"/"$name" || rm -fv "$dst"/"$file"
done
log "Done"

log

log "Importing from $src"
ls -rt "$src" | nl -nrz -w4 | while IFS='	' read num file; do
  file1=$src/$file
  for file2 in "$dst"/????-"$file"; do
    test -e "$file2" || file2=$dst/$num-$file
    cmp -s "$file1" "$file2" || {
      cp -fpv "$file1" "$file2"
      fsync "$file2"
    }
  done
done
log "Done"

log

el=`tput el`
pattern='s/^/'$el'/;s/$/\r/'
count=0
log "Shuffling $dst"
max=`ls "$dst" | wc -l`
ls "$dst" | shuf | nl -nrz -w4 | while IFS='	' read num file; do
  name=${file#????-}
  file1=$dst/$file
  file2=$dst/$num-$name

  test x"$file1" = x"$file2" && continue

  count=`expr $count + 1`
  num=`printf %${#max}d $count`

  mv -v "$file1" "$file2" | sed "s/^/($num\\/$max) /;$pattern" | tr -d '\n'
  fsync "$file2"
done
echo
log "Done"

umount "$dst"
