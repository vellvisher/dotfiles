" Author: Eric Van Dewoestine

" highlight System.out.println(), System.err.println(), and printStackTrace()
let java_highlight_debug = 1

setlocal textwidth=80

" nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
nnoremap <silent> <buffer> <leader>p :JavaDocPreview<cr>
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>o :JavaImportOrganize<cr>
nnoremap <silent> <buffer> <leader>c :JavaCorrect<cr>
nnoremap <silent> <buffer> <leader>jc :JavaDocComment<cr>
nnoremap <silent> <buffer> <leader>jd :JavaDocSearch -x declarations<cr>
nnoremap <silent> <buffer> <leader>jt :JUnitFindTest<cr>
let g:EclimBrowser = 'open -a "Google Chrome Beta"'
let g:EclimSignLevel=2
" vim:ft=vim:fdm=marker
