#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -f ~/.aliases_disable ]; then
    source ~/.aliases_disable
fi

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

if [ -f ~/.aliases_local ]; then
    source ~/.aliases_local
fi

if [ -f ~/.aliases_linux ]; then
    source ~/.aliases_linux
fi

if [ -f ~/.aliases_osx ]; then
    source ~/.aliases_osx
fi

export EDITOR='vim'
export VISUAL='vim'

# Add vi-mode up down
bindkey '^P' up-history
bindkey '^N' down-history

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

bindkey '^D' delete-char

# Larger history size.
export HISTSIZE=1000000
export SAVEHIST=1000000
