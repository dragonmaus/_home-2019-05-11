#!/bin/sh

cd "$HOME"/Pictures/Wallpapers

current=$(readlink .current)
random=$current

while test x"$random" = x"$current"; do
  random=$(ls *.png digitalblasphemy/.current/*.jpg | shuf | head -1)
done

ln -fs "$random" .current

test x"$1" = x-s && exec set-wallpaper .current
