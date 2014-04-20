""" Copy in visual mode using pbcopy
vnoremap <C-y> y:call system("pbcopy", getreg("\""))<CR>
