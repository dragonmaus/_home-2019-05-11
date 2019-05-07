startx=false
case `tty` in
/dev/tty*)
  printf 'Start X? (y/n): ' 1>&2
  read reply || echo n 1>&2
  case $reply in
  [Yy]*) startx=true ;;
  esac
esac

shell=`basename "$SHELL"`
shell=${shell:-sh}

XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

path=$path:$HOME/bin
path=$path:$HOME/.cargo/bin
path=$path:$HOME/.local/bin
path=$path:$HOME/src/go/bin
path=$path:$HOME/src/go/ext/bin

path=${path#:}

set -a

ENV=$XDG_CONFIG_HOME/shell/init.$shell
PATH=$path:$PATH

HOSTNAME=${HOSTNAME:-`hostname`}
test -r $XDG_CONFIG_HOME/locale.conf && . $XDG_CONFIG_HOME/locale.conf

EDITOR=`which nvim vim vi 2>/dev/null | (read line; echo $line)`

XKB_DEFAULT_LAYOUT=us
XKB_DEFAULT_MODEL=pc105
XKB_DEFAULT_OPTIONS=compose:paus
XKB_DEFAULT_VARIANT=dvorak
XKB_INTERNAL_OPTIONS='compose:paus ctrl:nocaps'

DARCS_ALWAYS_COLOR=1
DARCS_DO_COLOR_LINES=1
if which go >/dev/null 2>&1; then
  GOPATH=$HOME/src/go/ext:$HOME/src/go
  GOROOT=`go env GOROOT`
fi
IDEA_PROPERTIES=$XDG_CONFIG_HOME/idea/idea.properties
LESSHISTFILE=/dev/null
PASSWORD_STORE_SIGNING_KEY=`cat $HOME/.secret/signing.key`
RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/rgrc
SUDO_ASKPASS=$HOME/bin/askpass
_JAVA_AWT_WM_NONREPARENTING=1

if which fixpaths >/dev/null 2>&1; then
  GOPATH=`fixpaths -e GOPATH`
  PATH=`fixpaths -e PATH`
fi

set +a

test -r $XDG_DATA_HOME/ssh/agent.sh && . $XDG_DATA_HOME/ssh/agent.sh

$startx && exec startx
