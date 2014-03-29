" Easier shifting of blocks
" http://vim.wikia.com/wiki/Shifting_blocks_visually

" Retain selection after shifting text
vnoremap < <gv
vnoremap > >gv

" Map tab key in normal and visual mode
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
