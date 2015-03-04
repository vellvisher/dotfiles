# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=~/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="vellvisher"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

export QUOTE_FILE=~/Dropbox/quotes.txt

plugins=(git quote tmuxinator osx brew battery pyenv vi-mode web-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
if [ -f ~/.aliases_disable ]; then
    source ~/.aliases_disable
fi

if [ -f ~/.at_google ]; then
    source ~/.aliases_google
    source ~/.zshrc_google
fi

if [ -f ~/.aliases_linux ]; then
    source ~/.aliases_linux
fi

if [ -f ~/.aliases_osx ]; then
    source ~/.aliases_osx
fi

# Enable autocorrect only for commands, not arguments
unsetopt correct_all
setopt correct

# Unicode support for vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Add brew path earlier for exuberant ctags to work
export PATH=/usr/local/bin:$PATH

# Change timeout for vi-mode to 0.1s
export KEYTIMEOUT=1
source $HOME/.aliases

export EDITOR=vim

# Add vi-mode up down
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^D' delete-char

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# Kill line backwards
bindkey '^U' backward-kill-line
bindkey '^K' kill-line

# Run homebrew from home directory
export PATH=${HOME}/homebrew/bin:${PATH}
quote
