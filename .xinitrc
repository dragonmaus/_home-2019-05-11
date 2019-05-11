echo $DISPLAY >${XDG_DATA_HOME:-$HOME/.local/share}/x.display

test -s $HOME/.Xresources && xrdb -load $HOME/.Xresources

XKB_INTERNAL_DEVICE=`xinput --list --id-only 'AT Translated Set 2 keyboard'`

setxkbmap -model "$XKB_DEFAULT_MODEL" -layout "$XKB_DEFAULT_LAYOUT" -variant "$XKB_DEFAULT_VARIANT" `for o in $XKB_DEFAULT_OPTIONS; do echo " -option $o"; done`
test x"$XKB_INTERNAL_DEVICE" != x && setxkbmap -device "$XKB_INTERNAL_DEVICE" `for o in $XKB_INTERNAL_OPTIONS; do echo " -option $o"; done`

randomise-wallpaper -s

compton &
redshift-hack &
unclutter --ignore-scrolling --jitter 5 &

xset +dpms
xset dpms 300 600 900
xset s off
acpi-handler &
dwmstatus &

exec dwm
