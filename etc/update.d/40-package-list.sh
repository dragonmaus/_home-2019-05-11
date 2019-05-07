(
  list=$HOME/etc/packages.list
  xbps-query -m | xargs -n 1 xbps-uhelper getpkgname >$list{new}
  cmp -s $list{new} $list || cp -fp $list{new} $list
  rm -f $list{new}
)
