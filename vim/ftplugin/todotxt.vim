" abbreviations
" can put these in .vimrc if useful for other file types
iab date <c-r>=strftime("%Y-%m-%d")<cr>
nnoremap <Leader>d 0ix <c-r>=strftime("%Y-%m-%d")<cr> <Esc>
