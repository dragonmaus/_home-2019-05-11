(
  list=$HOME/etc/packages-glibc.list
  glibc xbps-query -m | xargs -n 1 glibc xbps-uhelper getpkgname >$list{new}
  cmp -s $list{new} $list || cp -fp $list{new} $list
  rm -f $list{new}
)
