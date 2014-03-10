for fpath in split(globpath('~/.vim/settings_mac', '*.vim'), '\n')
  exe 'source' fpath
endfor
