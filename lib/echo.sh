case $KSH_VERSION in
*MIRBSD\ KSH*|*LEGACY\ KSH*)
  # mksh does not have builtin printf
  echo() {
    typeset n=
    while test $# -gt 0; do
      case $1 in
      -n) n=-n ;;
      --) shift ;&
      *)  break ;;
      esac
      shift
    done
    print -R $n "$*"
  }
  ;;
*)
  echo() (
    p='%s\n'
    while test $# -gt 0; do
      case $1 in
      -n) p='%s' ;;
      --) shift
          break ;;
      *)  break ;;
      esac
      shift
    done
    printf "$p" "$*"
  )
  ;;
esac

warn() {
  echo ${1+"$@"} 1>&2
}
die() {
  r=$1
  shift 1
  warn ${1+"$@"}
  exit $r
}
