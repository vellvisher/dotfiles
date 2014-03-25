# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx brew battery vi-mode virtualenvwrapper web-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source ~/.aliases

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