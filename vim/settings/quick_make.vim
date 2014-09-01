:function! MapIfMakefileExists()
:   if filereadable("Makefile") || filereadable("makefile")
:       nnoremap <Leader>m :w<CR>:make!<CR>
:   endif
:endfunction
call MapIfMakefileExists()
