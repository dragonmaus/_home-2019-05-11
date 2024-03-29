# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# OneDark scheme by Lalit Magant (http://github.com/tilal6991)

color00='28/2c/34' # Base 00 - Black
color01='e0/6c/75' # Base 08 - Red
color02='98/c3/79' # Base 0B - Green
color03='e5/c0/7b' # Base 0A - Yellow
color04='61/af/ef' # Base 0D - Blue
color05='c6/78/dd' # Base 0E - Magenta
color06='56/b6/c2' # Base 0C - Cyan
color07='ab/b2/bf' # Base 05 - White
color08='54/58/62' # Base 03 - Bright Black
color09="$color01" # Base 08 - Bright Red
color10="$color02" # Base 0B - Bright Green
color11="$color03" # Base 0A - Bright Yellow
color12="$color04" # Base 0D - Bright Blue
color13="$color05" # Base 0E - Bright Magenta
color14="$color06" # Base 0C - Bright Cyan
color15='c8/cc/d4' # Base 07 - Bright White
color16='d1/9a/66' # Base 09
color17='be/50/46' # Base 0F
color18='35/3b/45' # Base 01
color19='3e/44/51' # Base 02
color20='56/5c/64' # Base 04
color21='b6/bd/ca' # Base 06
color_foreground='ab/b2/bf' # Base 05
color_background='28/2c/34' # Base 00

test x"$BASE16_SHELL_SET_BACKGROUND" = xfalse && set_background=false || set_background=true

if test x"${TERM%%-*}" = xlinux; then
  put_template() { test "$1" -lt 16 && printf '\033]P%x%s' $1 $(echo $2 | sed 's|/||g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' "$@"; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' "$@"; }
  put_template_custom() { printf '\033]%s%s\033\\' "$@"; }
fi

# 16 color space
$set_background && put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
put_template_var 10 $color_foreground
$set_background && put_template_var 11 $color_background
put_template_custom 12 ';7' # cursor (reverse video)
