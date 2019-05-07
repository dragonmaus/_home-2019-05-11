shell=`basename "$SHELL"`
shell=${shell:-sh}
shell_config=${XDG_CONFIG_HOME:-$HOME/.config}/shell
shell_cache=${XDG_CACHE_HOME:-$HOME/.cache}/shell
shell_data=${XDG_DATA_HOME:-$HOME/.local/share}/shell

load() {
  for f in $shell_config/$1.$shell $shell_config/$1.sh; do
    if test -r $f; then
      . $f
      return $?
    fi
  done
  unset f
}

load functions
(BASE16_SHELL_SET_BACKGROUND=false; load theme)

unset -f load

PS1='($USER@$HOSTNAME) `date +%T` [$PWD]
τ '

HISTFILE=$shell_cache/history.$shell
HISTSIZE=12000

alias lc='ls -C'
alias ll='ls -Fl'
alias ls='ls -1A --color=auto'
alias pstree='pstree -achlnp'

export GPG_TTY=`tty`

set -o vi

_cd() {
  PWD=`env - "PATH=$PATH" pwd`
}
cd() {
  command cd "$@" && _cd
}

trap -- "test -r $shell_config/logout.sh && . $shell_config/logout.sh" EXIT

unset shell shell_cache shell_config shell_data
