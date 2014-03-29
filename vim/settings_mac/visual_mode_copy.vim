""" Copy in visual mode using pbcopy
vnoremap <C-c> y:call system("pbcopy", getreg("\""))<CR>
