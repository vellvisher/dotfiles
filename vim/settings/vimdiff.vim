if &diff
    "Vimdiff use c-j and c-k to navigate
    nnoremap <C-j> ]c
    nnoremap <C-k> [c

    "Vimdiff quit without changes
    nnoremap q :qa! <CR>
endif
