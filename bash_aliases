# ls
if [ "$(uname)" == "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    COLOR_COMMAND=' -G'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    COLOR_COMMAND=' --color=auto'
fi
DEFAULT_LS=' -Fh'$COLOR_COMMAND

alias l='ls'$DEFAULT_LS
alias ls='ls'$DEFAULT_LS
alias ll='ls -l'$DEFAULT_LS
alias la='ls -a'$DEFAULT_LS
alias lla='ls -la'$DEFAULT_LS
alias lh='ls -d'$DEFAULT_LS' .*'

# cd
alias ..='cd ..'

# grep
alias grep='grep --color=auto'

# mkdir
alias mkdir='mkdir -pv'

# install colordiff
alias diff='colordiff'

# vim as default
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

# color tree
alias tree='tree -C'

# git alias
alias g=git
alias gr='if [ "`git rev-parse --show-cdup`" != "" ]; then cd `git rev-parse --show-cdup`; fi'


dev() {
    cd $HOME/dev/$1
}

# tmux
alias tmux="TERM=screen-256color-bce tmux"
