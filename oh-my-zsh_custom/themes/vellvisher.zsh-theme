# PROMPT=' %{$fg[red]%}${PWD/#$HOME/~}%{$reset_color%} %{$fg[green]%}@%m%{$reset_color%}$() '
PROMPT=' %{$fg[red]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[white]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# vi-mode
MODE_INDICATOR="%{$fg_bold[blue]%}[NORMAL]%{$reset_color%}"
