set guifont=Consolas\ 12
set lines=35 columns=90
" Toggle toolbar with ctrl+F2
noremap <silent> <C-F2> :if &guioptions=~# 'T' <Bar>
                            \set guioptions-=T <Bar>
                            \set guioptions-=m <Bar>
                            \else <Bar>
                            \set guioptions+=T <Bar>
                            \set guioptions+=m <Bar>
                            \endif<CR>
set guioptions-=T

"Open new file dialog (ctrl-n)
	 :noremap <C-n> :browse confirm e<cr>
"Open save-as dialog (ctrl-shift-s)
	 :noremap <C-S-s> :browse confirm saveas<cr>
