:function! MapIfBuildFileExists()
:   if filereadable("build.xml")
:       noremap <Leader>a :Ant debug install<CR>
:   endif
:endfunction
call MapIfBuildFileExists()
