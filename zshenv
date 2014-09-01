# Add brew path earlier for exuberant ctags to work
export PATH=/usr/local/bin:$PATH
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  if [ -z "$TMUX" ]; then
    eval `/usr/libexec/path_helper -s`
  fi
fi

# Enable aliases everywhere
source ~/.aliases
