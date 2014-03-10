""" Copy in visual mode using pbcopy
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
