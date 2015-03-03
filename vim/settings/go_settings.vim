" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if !empty($GOROOT)
  set runtimepath+=$GOROOT/misc/vim
endif
