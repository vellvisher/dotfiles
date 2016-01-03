" Settings related to tabs in vim
set tabpagemax=50

" Go to last tab.
let g:lasttab = 1
nnoremap <Leader>l :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
